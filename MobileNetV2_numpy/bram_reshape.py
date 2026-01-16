import pandas as pd
import numpy as np
import sys
import re
import math
from pathlib import Path

# 有效十六进制字符正则表达式
VALID_HEX = re.compile(r'^[0-9a-fA-F]+$')


def is_valid_hex(s):
    """检查字符串是否为有效的十六进制"""
    return bool(VALID_HEX.match(s))


def read_layered_bram_file(file_path):
    """读取BRAM文件，按layer分割，返回{layer_num: {addr: data}}"""
    layered_data = {}
    current_layer = None
    current_data = {}
    try:
        with open(file_path, 'r') as f:
            for line_num, line in enumerate(f, 1):
                line = line.strip()
                if not line:
                    continue
                # 检查是否是layer行
                if line.startswith('layer '):
                    # 保存上一层数据（如果有的话）
                    if current_layer is not None:
                        layered_data[current_layer] = current_data
                    # 解析当前层号
                    layer_part = line.split()[1]
                    try:
                        current_layer = int(layer_part)
                        current_data = {}
                    except ValueError:
                        print(f"警告: {file_path} 第{line_num}行layer号格式错误，跳过该层")
                        current_layer = None
                        current_data = {}
                elif current_layer is not None and line.startswith('Addr '):
                    # 解析地址和数据
                    parts = line.split()
                    if len(parts) == 3:
                        try:
                            addr = int(parts[1])
                            data = parts[2].lower()
                            if is_valid_hex(data):
                                current_data[addr] = data
                            else:
                                print(f"警告: {file_path} 第{line_num}行地址{addr}含无效十六进制，已跳过")
                        except ValueError:
                            print(f"警告: {file_path} 第{line_num}行地址格式错误，已跳过")
            # 保存最后一层数据
            if current_layer is not None and current_layer not in layered_data:
                layered_data[current_layer] = current_data
    except FileNotFoundError:
        print(f"错误: 找不到文件 {file_path}")
        sys.exit(1)
    return layered_data


def read_address_range(file_path, start_addr, end_addr, layer_num):
    """读取指定文件中指定layer的指定地址范围内的数据，缺失地址填充18个零，按地址升序排列"""
    # 先读取该文件的分层数据
    layered_data = read_layered_bram_file(file_path)
    # 获取当前layer的数据，若不存在则为空字典
    layer_data = layered_data.get(layer_num, {})
    # 生成从start_addr到end_addr的所有地址
    addr_data = {}
    for addr in range(start_addr, end_addr + 1):
        if addr in layer_data:
            addr_data[addr] = layer_data[addr]
        else:
            # 缺失地址填充18个零
            addr_data[addr] = '0' * 18
            #print(f"警告: {file_path} layer {layer_num} 地址{addr}不存在，填充18个零")
    # 按地址升序返回
    return {addr: addr_data[addr] for addr in sorted(addr_data.keys())}


def hex_to_channels(hex_strings, base_addr, pos, num_channels):
    """将16进制字符串转换为指定数量的channel值（小端模式）"""
    all_values = []
    for addr_offset, hex_str in enumerate(hex_strings):
        # 确保72位（18个十六进制字符）并按小端模式解析
        groups = [hex_str[i * 2:(i + 1) * 2] for i in range(9)][::-1]  # 低位在前
        for group_idx, group in enumerate(groups):
            try:
                all_values.append(int(group, 16))
            except ValueError:
                all_values.append(0)
                print(f"警告: BRAM{pos} 地址{base_addr + addr_offset} 组{group_idx}无效，用0代替")
    return all_values[:num_channels]


def parse_top5_indices(hex_str):
    """
    解析top5索引：每12位一个idx，从高位到低位代表top1-top5（修正顺序）
    hex_str应为15个字符（60位）
    """
    # 确保十六进制字符串长度正确
    if len(hex_str) < 15:
        hex_str = hex_str.zfill(15)  # 不足补零
    else:
        hex_str = hex_str[-15:]  # 超过截取后15位

    # 转换为二进制字符串，确保60位，小端模式
    bin_str = bin(int(hex_str, 16))[2:].zfill(60)

    # 从高位到低位提取5个12位的索引（修正顺序）
    top5 = []
    for i in range(5):
        # 计算当前12位在二进制字符串中的位置（修正为从高位开始）
        start = 60 - (i + 1) * 12
        end = 60 - i * 12
        if start < 0:
            top5.append(0)
            continue
        # 提取12位并转换为整数
        idx_bin = bin_str[start:end]
        idx = int(idx_bin, 2)
        top5.append(idx)

    return top5


def parse_softmax_results(hex_str):
    """
    解析softmax结果：每8位一个小数，共5个，从高位到低位对应top1-top5（修正顺序）
    hex_str应为10个字符（40位）
    """
    # 确保十六进制字符串长度正确
    if len(hex_str) < 10:
        hex_str = hex_str.zfill(10)  # 不足补零
    else:
        hex_str = hex_str[-10:]  # 超过截取后10位

    # 从高位到低位解析，每个8位一组（修正顺序）
    softmax = []
    # 反转分组顺序以匹配top5索引
    for i in range(4, -1, -1):
        start = i * 2
        end = start + 2
        if end > 10:
            softmax.append(0.0)
            continue
        # 提取8位并转换为小数（假设是0-255表示0-1）
        byte_hex = hex_str[start:end]
        try:
            value = int(byte_hex, 16) / 255.0  # 转换为0-1之间的小数
            softmax.append(round(value, 6))
        except ValueError:
            softmax.append(0.0)

    return softmax


def calculate_parameters(output_shape, window_size):
    """计算所需参数"""
    num_channels, height, width = output_shape
    win_rows = (height + window_size - 1) // window_size
    win_cols = (width + window_size - 1) // window_size
    total_windows = win_rows * win_cols
    addr_per_window = math.ceil(num_channels / 9)
    return {
        "num_channels": num_channels, "height": height, "width": width,
        "win_rows": win_rows, "win_cols": win_cols, "total_windows": total_windows,
        "addr_per_window": addr_per_window, "required_addrs": total_windows * addr_per_window
    }


def process_single_config(config):
    """处理单个配置，包括可能的top5和softmax结果"""
    # 提取配置参数
    output_shape = config["output_shape"]
    start_addr, end_addr = config["start_addr"], config["end_addr"]
    bram_files, window_size = config["bram_files"], config.get("window_size", 3)
    output_prefix, output_dir = config.get("output_prefix", "output"), config.get("output_dir")
    top5_addr = config.get("top5_addr")  # 获取top5地址（如果有）
    layer_num = config["layer_num"]  # 获取当前配置对应的layer编号
    output_dir = config.get("output_dir", "outputs")

    # 输出路径处理
    output_path = (lambda fname: f"{output_dir}/{fname}") if output_dir else (lambda fname: fname)
    if output_dir:
        Path(output_dir).mkdir(parents=True, exist_ok=True)

    # 计算参数并验证
    params = calculate_parameters(output_shape, window_size)
    print(f"\n===== 处理配置: {output_prefix} (layer {layer_num}) =====")
    print("自动计算参数:", {k: v for k, v in params.items()})

    # 地址数量验证
    if (end_addr - start_addr + 1) != params["required_addrs"]:
        print(f"\n错误：地址数量不匹配（需要{params['required_addrs']}，实际{end_addr - start_addr + 1}）")
        return False

    # BRAM文件数量验证
    if len(bram_files) != window_size * window_size:
        print(f"\n错误：BRAM文件数量不匹配（需要{window_size * window_size}，实际{len(bram_files)}）")
        return False

    # 读取BRAM数据（传入layer_num）
    bram_data = [read_address_range(fp, start_addr, end_addr, layer_num) for fp in bram_files]
    for idx, data in enumerate(bram_data):
        print(f"BRAM{idx} (layer {layer_num}) 读取到 {len(data)} 个地址数据（含填充）")

    # 初始化结果数组
    result = np.zeros(output_shape, dtype=np.uint8)
    num_channels, height, width = output_shape

    # 处理所有窗口
    for win_row in range(params["win_rows"]):
        for win_col in range(params["win_cols"]):
            window_idx = win_row * params["win_cols"] + win_col
            if window_idx % 1000 == 0 and window_idx > 0:
                print(f"处理窗口索引: {window_idx}/{params['total_windows']}")

            # 处理窗口内每个位置
            for pos in range(window_size * window_size):
                pos_row, pos_col = pos // window_size, pos % window_size
                final_row, final_col = win_row * window_size + pos_row, win_col * window_size + pos_col
                if final_row >= height or final_col >= width:
                    continue

                # 地址处理
                base_addr = start_addr + window_idx * params["addr_per_window"]
                addresses = [base_addr + i for i in range(params["addr_per_window"])]
                if any(addr not in bram_data[pos] for addr in addresses):
                    continue

                # 数据转换与写入
                hex_strings = [bram_data[pos][addr] for addr in addresses]
                channels = hex_to_channels(hex_strings, base_addr, pos, num_channels)
                for ch in range(num_channels):
                    result[ch, final_row, final_col] = channels[ch]

    # 输出结果
    print("\n处理完成")
    print(f"输出数组形状: {result.shape}, 非零值比例: {np.count_nonzero(result) / result.size:.2%}")

    # 保存NPY文件
    npy_file = output_path(f"{output_prefix}.npy")
    np.save(npy_file, result)
    print(f"数组已保存为: {npy_file}")

    # 保存Excel文件（通道数限制）
    if output_shape[0] <= 10:
        excel_file = output_path(f"{output_prefix}.xlsx")
        with pd.ExcelWriter(excel_file) as writer:
            for ch in range(output_shape[0]):
                pd.DataFrame(result[ch]).to_excel(writer, sheet_name=f"channel_{ch}", index=False, header=False)
        print(f"Excel文件已保存为: {excel_file}")
    else:
        print("通道数过多，未生成Excel文件")

    # 处理top5和softmax结果（如果指定了top5地址）
    if top5_addr is not None:
        print(f"\n开始处理top5索引和softmax结果，top5地址: {top5_addr}")
        softmax_addr = top5_addr + 1  # softmax地址为top5地址的下一个地址

        # 读取top5和softmax数据（从第一个BRAM文件读取）
        top5_data = None
        softmax_data = None
        if bram_files:
            # 读取top5地址数据（指定当前layer）
            top5_addr_data = read_address_range(bram_files[0], top5_addr, top5_addr, layer_num)
            if top5_addr in top5_addr_data:
                top5_data = top5_addr_data[top5_addr]

            # 读取softmax地址数据（指定当前layer）
            softmax_addr_data = read_address_range(bram_files[0], softmax_addr, softmax_addr, layer_num)
            if softmax_addr in softmax_addr_data:
                softmax_data = softmax_addr_data[softmax_addr]

        # 解析数据
        if top5_data is not None and softmax_data is not None:
            top5_indices = parse_top5_indices(top5_data)
            softmax_results = parse_softmax_results(softmax_data)

            # 输出结果
            print("\n===== Top5结果 =====")
            for i in range(5):
                print(f"Top{i + 1}: 索引={top5_indices[i]}, 概率={softmax_results[i]:.6f}")

            # 保存结果
            top5_result = pd.DataFrame({
                '排名': [f'Top{i + 1}' for i in range(5)],
                '索引': top5_indices,
                '概率': softmax_results
            })

            # 保存为Excel和NPY
            top5_excel = output_path(f"{output_prefix}_top5.xlsx")
            top5_result.to_excel(top5_excel, index=False)
            print(f"Top5结果已保存为: {top5_excel}")

            top5_npy = output_path(f"{output_prefix}_top5.npy")
            np.savez(top5_npy, indices=top5_indices, probabilities=softmax_results)
            print(f"Top5结果(NPY)已保存为: {top5_npy}")
        else:
            print(f"警告: 无法读取top5地址({top5_addr})或softmax地址({softmax_addr})的数据")

    return True


def process_all_configs(configs):
    """处理所有配置"""
    total = len(configs)
    success = sum(1 for i, cfg in enumerate(configs, 1) if
                  (print(f"\n===== 开始处理配置 {i}/{total} =====") or True) and process_single_config(cfg))
    print(f"\n===== 所有配置处理完毕 =====")
    print(f"总配置数: {total}, 成功: {success}, 失败: {total - success}")


if __name__ == "__main__":
    # 基础配置（公共参数）
    base = {
        "bram_files": [f"bram{i}.txt" for i in range(9)],
        "window_size": 3
    }

    # 层配置参数（添加了layer_num指定对应的layer）
    # layers = [
    #     {"output_shape": (32, 112, 112), "start_addr": 5776, "end_addr": 11551,
    #      "output_prefix": "hardware_output_layer1", "output_dir": "outputs", "layer_num": 1},
    #     {"output_shape": (32, 112, 112), "start_addr": 0, "end_addr": 5775,
    #      "output_prefix": "hardware_output_layer2", "layer_num": 2},
    #     {"output_shape": (16, 112, 112), "start_addr": 15884, "end_addr": 18771,
    #      "output_prefix": "hardware_output_layer3", "layer_num": 3},
    #     {"output_shape": (96, 112, 112), "start_addr": 0, "end_addr": 15883,
    #      "output_prefix": "hardware_output_layer4", "layer_num": 4},
    #     {"output_shape": (96, 56, 56), "start_addr": 15884, "end_addr": 19854,
    #      "output_prefix": "hardware_output_layer5", "layer_num": 5},
    #     {"output_shape": (24, 56, 56), "start_addr": 0, "end_addr": 1082,
    #      "output_prefix": "hardware_output_layer6", "layer_num": 6},
    #     {"output_shape": (144, 56, 56), "start_addr": 6000, "end_addr": 11775,
    #      "output_prefix": "hardware_output_layer7", "layer_num": 7},
    #     {"output_shape": (144, 56, 56), "start_addr": 11776, "end_addr": 17551,
    #      "output_prefix": "hardware_output_layer8", "layer_num": 8},
    #     {"output_shape": (24, 56, 56), "start_addr": 2000, "end_addr": 3082,
    #      "output_prefix": "hardware_output_layer9", "layer_num": 9},
    #     {"output_shape": (24, 56, 56), "start_addr": 4000, "end_addr": 5082,
    #      "output_prefix": "hardware_output_layer9_shortcut", "layer_num": 10},
    # ]
    layers = [
        {"output_shape": (32, 112, 112), "start_addr": 5776, "end_addr": 11551,
         "output_prefix": "hardware_output_layer1", "output_dir": "outputs", "layer_num": 1},
        {"output_shape": (32, 112, 112), "start_addr": 0, "end_addr": 5775, "output_prefix": "hardware_output_layer2",
         "layer_num": 2},
        {"output_shape": (16, 112, 112), "start_addr": 15884, "end_addr": 18771,
         "output_prefix": "hardware_output_layer3", "layer_num": 3},
        {"output_shape": (96, 112, 112), "start_addr": 0, "end_addr": 15883, "output_prefix": "hardware_output_layer4",
         "layer_num": 4},
        {"output_shape": (96, 56, 56), "start_addr": 15884, "end_addr": 19854,
         "output_prefix": "hardware_output_layer5", "layer_num": 5},
        {"output_shape": (24, 56, 56), "start_addr": 0, "end_addr": 1082, "output_prefix": "hardware_output_layer6",
         "layer_num": 6},
        {"output_shape": (144, 56, 56), "start_addr": 6000, "end_addr": 11775,
         "output_prefix": "hardware_output_layer7", "layer_num": 7},
        {"output_shape": (144, 56, 56), "start_addr": 11776, "end_addr": 17551,
         "output_prefix": "hardware_output_layer8", "layer_num": 8},
        {"output_shape": (24, 56, 56), "start_addr": 2000, "end_addr": 3082, "output_prefix": "hardware_output_layer9",
         "layer_num": 9},
        {"output_shape": (24, 56, 56), "start_addr": 4000, "end_addr": 5082,
         "output_prefix": "hardware_output_layer9_shortcut", "layer_num": 10},
        {"output_shape": (144, 56, 56), "start_addr": 6000, "end_addr": 11775,
         "output_prefix": "hardware_output_layer10", "layer_num": 11},
        {"output_shape": (144, 28, 28), "start_addr": 11776, "end_addr": 13375,
         "output_prefix": "hardware_output_layer11", "layer_num": 12},
        {"output_shape": (32, 28, 28), "start_addr": 0, "end_addr": 399, "output_prefix": "hardware_output_layer12",
         "layer_num": 13},
        {"output_shape": (192, 28, 28), "start_addr": 6000, "end_addr": 8199,
         "output_prefix": "hardware_output_layer13", "layer_num": 14},
        {"output_shape": (192, 28, 28), "start_addr": 8200, "end_addr": 10399,
         "output_prefix": "hardware_output_layer14", "layer_num": 15},
        {"output_shape": (32, 28, 28), "start_addr": 2000, "end_addr": 2399, "output_prefix": "hardware_output_layer15",
         "layer_num": 16},
        {"output_shape": (32, 28, 28), "start_addr": 4000, "end_addr": 4399,
         "output_prefix": "hardware_output_layer15_shortcut", "layer_num": 17},
        {"output_shape": (192, 28, 28), "start_addr": 6000, "end_addr": 8199,
         "output_prefix": "hardware_output_layer16", "layer_num": 18},
        {"output_shape": (192, 28, 28), "start_addr": 8200, "end_addr": 10399,
         "output_prefix": "hardware_output_layer17", "layer_num": 19},
        {"output_shape": (32, 28, 28), "start_addr": 2000, "end_addr": 2399, "output_prefix": "hardware_output_layer18",
         "layer_num": 20},
        {"output_shape": (32, 28, 28), "start_addr": 0, "end_addr": 399,
         "output_prefix": "hardware_output_layer18_shortcut", "layer_num": 21},
        {"output_shape": (192, 28, 28), "start_addr": 6000, "end_addr": 8199,
         "output_prefix": "hardware_output_layer19", "layer_num": 22},
        {"output_shape": (192, 14, 14), "start_addr": 8200, "end_addr": 8749,
         "output_prefix": "hardware_output_layer20", "layer_num": 23},
        {"output_shape": (64, 14, 14), "start_addr": 0, "end_addr": 199, "output_prefix": "hardware_output_layer21",
         "layer_num": 24},
        {"output_shape": (384, 14, 14), "start_addr": 6000, "end_addr": 7074,
         "output_prefix": "hardware_output_layer22", "layer_num": 25},
        {"output_shape": (384, 14, 14), "start_addr": 7075, "end_addr": 8149,
         "output_prefix": "hardware_output_layer23", "layer_num": 26},
        {"output_shape": (64, 14, 14), "start_addr": 2000, "end_addr": 2199, "output_prefix": "hardware_output_layer24",
         "layer_num": 27},
        {"output_shape": (64, 14, 14), "start_addr": 4000, "end_addr": 4199,
         "output_prefix": "hardware_output_layer24_shortcut", "layer_num": 28},
        {"output_shape": (384, 14, 14), "start_addr": 6000, "end_addr": 7074,
         "output_prefix": "hardware_output_layer25", "layer_num": 29},
        {"output_shape": (384, 14, 14), "start_addr": 7075, "end_addr": 8149,
         "output_prefix": "hardware_output_layer26", "layer_num": 30},
        {"output_shape": (64, 14, 14), "start_addr": 2000, "end_addr": 2199, "output_prefix": "hardware_output_layer27",
         "layer_num": 31},
        {"output_shape": (64, 14, 14), "start_addr": 0, "end_addr": 199,
         "output_prefix": "hardware_output_layer27_shortcut", "layer_num": 32},
        {"output_shape": (384, 14, 14), "start_addr": 6000, "end_addr": 7074,
         "output_prefix": "hardware_output_layer28", "layer_num": 33},
        {"output_shape": (384, 14, 14), "start_addr": 7075, "end_addr": 8149,
         "output_prefix": "hardware_output_layer29", "layer_num": 34},
        {"output_shape": (64, 14, 14), "start_addr": 2000, "end_addr": 2199, "output_prefix": "hardware_output_layer30",
         "layer_num": 35},
        {"output_shape": (64, 14, 14), "start_addr": 4000, "end_addr": 4199,
         "output_prefix": "hardware_output_layer30_shortcut", "layer_num": 36},
        {"output_shape": (384, 14, 14), "start_addr": 6000, "end_addr": 7074,
         "output_prefix": "hardware_output_layer31", "layer_num": 37},
        {"output_shape": (384, 14, 14), "start_addr": 7075, "end_addr": 8149,
         "output_prefix": "hardware_output_layer32", "layer_num": 38},
        {"output_shape": (96, 14, 14), "start_addr": 0, "end_addr": 274, "output_prefix": "hardware_output_layer33",
         "layer_num": 39},
        {"output_shape": (576, 14, 14), "start_addr": 6000, "end_addr": 7599,
         "output_prefix": "hardware_output_layer34", "layer_num": 40},
        {"output_shape": (576, 14, 14), "start_addr": 7600, "end_addr": 9199,
         "output_prefix": "hardware_output_layer35", "layer_num": 41},
        {"output_shape": (96, 14, 14), "start_addr": 2000, "end_addr": 2274, "output_prefix": "hardware_output_layer36",
         "layer_num": 42},
        {"output_shape": (96, 14, 14), "start_addr": 4000, "end_addr": 4274,
         "output_prefix": "hardware_output_layer36_shortcut", "layer_num": 43},
        {"output_shape": (576, 14, 14), "start_addr": 6000, "end_addr": 7599,
         "output_prefix": "hardware_output_layer37", "layer_num": 44},
        {"output_shape": (576, 14, 14), "start_addr": 7600, "end_addr": 9199,
         "output_prefix": "hardware_output_layer38", "layer_num": 45},
        {"output_shape": (96, 14, 14), "start_addr": 2000, "end_addr": 2274, "output_prefix": "hardware_output_layer39",
         "layer_num": 46},
        {"output_shape": (96, 14, 14), "start_addr": 0, "end_addr": 274,
         "output_prefix": "hardware_output_layer39_shortcut", "layer_num": 47},
        {"output_shape": (576, 14, 14), "start_addr": 6000, "end_addr": 7599,
         "output_prefix": "hardware_output_layer40", "layer_num": 48},
        {"output_shape": (576, 7, 7), "start_addr": 7600, "end_addr": 8175, "output_prefix": "hardware_output_layer41",
         "layer_num": 49},
        {"output_shape": (160, 7, 7), "start_addr": 0, "end_addr": 161, "output_prefix": "hardware_output_layer42",
         "layer_num": 50},
        {"output_shape": (960, 7, 7), "start_addr": 6000, "end_addr": 6962, "output_prefix": "hardware_output_layer43",
         "layer_num": 51},
        {"output_shape": (960, 7, 7), "start_addr": 6963, "end_addr": 7925, "output_prefix": "hardware_output_layer44",
         "layer_num": 52},
        {"output_shape": (160, 7, 7), "start_addr": 2000, "end_addr": 2161, "output_prefix": "hardware_output_layer45",
         "layer_num": 53},
        {"output_shape": (160, 7, 7), "start_addr": 4000, "end_addr": 4161,
         "output_prefix": "hardware_output_layer45_shortcut", "layer_num": 54},
        {"output_shape": (960, 7, 7), "start_addr": 6000, "end_addr": 6962, "output_prefix": "hardware_output_layer46",
         "layer_num": 55},
        {"output_shape": (960, 7, 7), "start_addr": 6963, "end_addr": 7925, "output_prefix": "hardware_output_layer47",
         "layer_num": 56},
        {"output_shape": (160, 7, 7), "start_addr": 2000, "end_addr": 2161, "output_prefix": "hardware_output_layer48",
         "layer_num": 57},
        {"output_shape": (160, 7, 7), "start_addr": 0, "end_addr": 161,
         "output_prefix": "hardware_output_layer48_shortcut", "layer_num": 58},
        {"output_shape": (960, 7, 7), "start_addr": 6000, "end_addr": 6962, "output_prefix": "hardware_output_layer49",
         "layer_num": 59},
        {"output_shape": (960, 7, 7), "start_addr": 6963, "end_addr": 7925, "output_prefix": "hardware_output_layer50",
         "layer_num": 60},
        {"output_shape": (320, 7, 7), "start_addr": 7926, "end_addr": 8249, "output_prefix": "hardware_output_layer51",
         "layer_num": 61},
        {"output_shape": (1280, 7, 7), "start_addr": 8250, "end_addr": 9536, "output_prefix": "hardware_output_layer52",
         "layer_num": 62},
        {"output_shape": (1280, 1, 1), "start_addr": 9537, "end_addr": 9679,
         "output_prefix": "hardware_output_layer53", "layer_num": 63},
        {"output_shape": (1000, 1, 1), "start_addr": 9680, "end_addr": 9791, "output_prefix": "hardware_output_layer54","top5_addr": 9792,
         "layer_num": 64},
    ]
    # 生成完整配置列表
    CONFIGS = [{**base, **layer} for layer in layers]
    process_all_configs(CONFIGS)