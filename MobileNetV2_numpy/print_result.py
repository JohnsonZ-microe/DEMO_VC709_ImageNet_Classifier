import os


def read_bin_file(bin_file_path):
    """从bin文件读取前32字节，拆分为两组16字节的十六进制字符串"""
    try:
        with open(bin_file_path, "rb") as f:
            bin_data = f.read()

        if len(bin_data) < 32:
            raise ValueError(f"bin文件大小不足！当前{len(bin_data)}字节，需至少32字节")

        group1_bytes = bin_data[:16]
        group2_bytes = bin_data[16:32]
        group1_hex = group1_bytes.hex()
        group2_hex = group2_bytes.hex()

        print(f"✅ 成功读取bin文件：{bin_file_path}")
        # print(f"   第一组16字节：{group1_hex}")
        # print(f"   第二组16字节：{group2_hex}\n")
        return group1_hex, group2_hex

    except FileNotFoundError:
        print(f"❌ 错误：未找到bin文件 {bin_file_path}")
        exit()
    except Exception as e:
        print(f"❌ 读取bin失败：{str(e)}")
        exit()


def process_group1(hex_str, eng_classes, cn_classes, take_groups=5):
    """处理第一组：返回中英双语label列表"""
    raw_bytes = bytes.fromhex(hex_str)
    reversed_bytes = raw_bytes[::-1]
    reversed_hex = reversed_bytes.hex()
    reversed_hex_rev = reversed_hex[::-1]

    eng_label_list = []
    cn_label_list = []
    # print("📌 第一组取数&中英对照详情：")
    for i in range(take_groups):
        start = i * 3
        end = start + 3
        chunk = reversed_hex_rev[start:end].ljust(3, '0')
        chunk_rev = chunk[::-1]
        idx = int(chunk_rev, 16)

        # 中英文label匹配（索引越界兜底）
        if 0 <= idx < len(eng_classes):
            eng_label = eng_classes[idx]
            cn_label = cn_classes[idx]
            row_num = idx + 1
        else:
            eng_label = f"【索引{idx}无效】"
            cn_label = f"【索引{idx}无效】"
            row_num = "—"

        eng_label_list.append(eng_label)
        cn_label_list.append(cn_label)
        # print(f"  第{i + 1}组：{chunk_rev}(16进制) → 索引{idx}（第{row_num}行）→ 英文：{eng_label} | 中文：{cn_label}")

    return eng_label_list, cn_label_list


def process_group2(hex_str, take_groups=5):
    """处理第二组：返回识别结果小数列表"""
    raw_bytes = bytes.fromhex(hex_str)
    reversed_bytes = raw_bytes[::-1]
    reversed_hex = reversed_bytes.hex()
    reversed_hex_rev = reversed_hex[::-1]

    score_list = []
    # print("\n📌 第二组取数&小数转换详情：")
    for i in range(take_groups):
        start = i * 2
        end = start + 2
        chunk = reversed_hex_rev[start:end].ljust(2, '0')
        chunk_rev = chunk[::-1]
        hex_int = int(chunk_rev, 16)
        score = round(hex_int / 255, 6)
        score_list.append(score)
        # print(f"  第{i + 1}组：{chunk_rev}(16进制) → 整数{hex_int} → 识别结果：{score}")

    return score_list


# ===================== 主程序（一键运行） =====================
if __name__ == "__main__":
    # 1. 配置文件路径（修改为你的实际路径）
    BIN_FILE_PATH = "combined_result.bin"  # 你的合并bin文件
    ENG_CLASSES_FILE = "imagenet_classes.txt"  # 原版英文类别文件
    CN_CLASSES_FILE = "imagenet_classes_cn.txt"  # 生成的中文版文件

    # 2. 自动生成中文版类别txt（若已生成，可注释此行，直接读取）
    # eng_classes, cn_classes = generate_imagenet_cn_txt(ENG_CLASSES_FILE, CN_CLASSES_FILE)

    # （可选：若已生成中文版txt，直接读取中英文文件，替代上一行）
    with open(ENG_CLASSES_FILE, "r", encoding="utf-8") as f:
        eng_classes = [line.strip() for line in f if line.strip()]
    with open(CN_CLASSES_FILE, "r", encoding="utf-8") as f:
        cn_classes = [line.strip() for line in f if line.strip()]

    # 3. 读取bin文件，获取两组16字节数据
    group1_raw_hex, group2_raw_hex = read_bin_file(BIN_FILE_PATH)

    # 4. 处理两组数据（第一组返回中英双语label）
    eng_label_result, cn_label_result = process_group1(group1_raw_hex, eng_classes, cn_classes, take_groups=5)
    score_result = process_group2(group2_raw_hex, take_groups=5)

    # 5. 最终输出：中英文同时显示 + 识别结果
    # print("\n" + "=" * 100)
    print("推理结果：")
    # print("=" * 100)
    for i in range(len(eng_label_result)):
        print(
            f"Top{i+1} 类别：{eng_label_result[i]:<15} {cn_label_result[i]:<8} | 概率 ：{score_result[i]}")