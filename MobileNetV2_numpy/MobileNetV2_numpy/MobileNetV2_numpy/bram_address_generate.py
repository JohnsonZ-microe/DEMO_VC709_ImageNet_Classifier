import math


def calculate_bram_address_range(start_address, layer_shape):
    """计算BRAM某一层输出的地址范围"""
    channel, dim2, dim3 = layer_shape

    # 计算各维度的向上取整除法结果
    addr_count1 = math.ceil(channel / 9)
    addr_count2 = math.ceil(dim2 / 3)
    addr_count3 = math.ceil(dim3 / 3)

    # 计算总地址数量和结束地址
    total_addresses = addr_count1 * addr_count2 * addr_count3
    end_address = start_address + total_addresses - 1

    return {
        "start_address": start_address,
        "end_address": end_address,
        "total_addresses": total_addresses,
        "calculation_details": {
            "channel_div9": addr_count1,
            "dim2_div3": addr_count2,
            "dim3_div3": addr_count3
        },
        "layer_shape": layer_shape,
        "layer_name": ""
    }


def main():
    print("===== QuantizableMobileNetV2 层地址信息生成器 =====")
    print("按指定格式生成结果，包含所有层，将保存到 'layer_addresses.txt' 文件中\n")

    # 输入层参数 (通道数, 高度, 宽度)
    input_layer_shape = (3, 224, 224)
    input_layer_name = "输入层(3,224,224)"

    # 模型所有层的详细定义（包含所有中间层）
    # 格式: (层名称, 形状, (是否是shortcut层, scale, zero_point))
    layers = [
        # features(0): Conv2dNormActivation - 无shortcut (层1)
        ("features(0)/QuantizedConvReLU2d(3→32,stride=2)", (32, 112, 112), (False, 0, 0)),

        # features(1): QuantizableInvertedResidual (层2,3)
        ("features(1)/conv(0)/QuantizedConvReLU2d(32→32,stride=1)", (32, 112, 112), (False, 0, 0)),
        ("features(1)/conv(1)/QuantizedConv2d(32→16,stride=1)", (16, 112, 112), (False, 0, 0)),

        # features(2): QuantizableInvertedResidual (层4,5,6)
        ("features(2)/conv(0)/QuantizedConvReLU2d(16→96,stride=1)", (96, 112, 112), (False, 0, 0)),
        ("features(2)/conv(1)/QuantizedConvReLU2d(96→96,stride=2)", (96, 56, 56), (False, 0, 0)),
        ("features(2)/conv(2)/QuantizedConv2d(96→24,stride=1)", (24, 56, 56), (False, 0, 0)),

        # features(3): QuantizableInvertedResidual (层7,8,9)
        ("features(3)/conv(0)/QuantizedConvReLU2d(24→144,stride=1)", (144, 56, 56), (False, 0, 0)),
        ("features(3)/conv(1)/QuantizedConvReLU2d(144→144,stride=1)", (144, 56, 56), (False, 0, 0)),
        ("features(3)/conv(2)/QuantizedConv2d(144→24,stride=1)", (24, 56, 56), (False, 0, 0)),
        ("features(3)/shortcut/Add(24+24)", (24, 56, 56), (True, 0.060171887278556824, 117)),

        # features(4): QuantizableInvertedResidual (层10,11,12)
        ("features(4)/conv(0)/QuantizedConvReLU2d(24→144,stride=1)", (144, 56, 56), (False, 0, 0)),
        ("features(4)/conv(1)/QuantizedConvReLU2d(144→144,stride=2)", (144, 28, 28), (False, 0, 0)),
        ("features(4)/conv(2)/QuantizedConv2d(144→32,stride=1)", (32, 28, 28), (False, 0, 0)),

        # features(5): QuantizableInvertedResidual (层13,14,15)
        ("features(5)/conv(0)/QuantizedConvReLU2d(32→192,stride=1)", (192, 28, 28), (False, 0, 0)),
        ("features(5)/conv(1)/QuantizedConvReLU2d(192→192,stride=1)", (192, 28, 28), (False, 0, 0)),
        ("features(5)/conv(2)/QuantizedConv2d(192→32,stride=1)", (32, 28, 28), (False, 0, 0)),
        ("features(5)/shortcut/Add(32+32)", (32, 28, 28), (True, 0.03812252730131149, 128)),

        # features(6): QuantizableInvertedResidual (层16,17,18)
        ("features(6)/conv(0)/QuantizedConvReLU2d(32→192,stride=1)", (192, 28, 28), (False, 0, 0)),
        ("features(6)/conv(1)/QuantizedConvReLU2d(192→192,stride=1)", (192, 28, 28), (False, 0, 0)),
        ("features(6)/conv(2)/QuantizedConv2d(192→32,stride=1)", (32, 28, 28), (False, 0, 0)),
        ("features(6)/shortcut/Add(32+32)", (32, 28, 28), (True, 0.0451338030397892, 132)),

        # features(7): QuantizableInvertedResidual (层19,20,21)
        ("features(7)/conv(0)/QuantizedConvReLU2d(32→192,stride=1)", (192, 28, 28), (False, 0, 0)),
        ("features(7)/conv(1)/QuantizedConvReLU2d(192→192,stride=2)", (192, 14, 14), (False, 0, 0)),
        ("features(7)/conv(2)/QuantizedConv2d(192→64,stride=1)", (64, 14, 14), (False, 0, 0)),

        # features(8): QuantizableInvertedResidual (层22,23,24)
        ("features(8)/conv(0)/QuantizedConvReLU2d(64→384,stride=1)", (384, 14, 14), (False, 0, 0)),
        ("features(8)/conv(1)/QuantizedConvReLU2d(384→384,stride=1)", (384, 14, 14), (False, 0, 0)),
        ("features(8)/conv(2)/QuantizedConv2d(384→64,stride=1)", (64, 14, 14), (False, 0, 0)),
        ("features(8)/shortcut/Add(64+64)", (64, 14, 14), (True, 0.026260478422045708, 129)),

        # features(9): QuantizableInvertedResidual (层25,26,27) - 这是需要重点处理的第9层
        ("features(9)/conv(0)/QuantizedConvReLU2d(64→384,stride=1)", (384, 14, 14), (False, 0, 0)),
        ("features(9)/conv(1)/QuantizedConvReLU2d(384→384,stride=1)", (384, 14, 14), (False, 0, 0)),
        ("features(9)/conv(2)/QuantizedConv2d(384→64,stride=1)", (64, 14, 14), (False, 0, 0)),
        ("features(9)/shortcut/Add(64+64)", (64, 14, 14), (True, 0.02760491892695427, 129)),

        # features(10): QuantizableInvertedResidual (层28,29,30)
        ("features(10)/conv(0)/QuantizedConvReLU2d(64→384,stride=1)", (384, 14, 14), (False, 0, 0)),
        ("features(10)/conv(1)/QuantizedConvReLU2d(384→384,stride=1)", (384, 14, 14), (False, 0, 0)),
        ("features(10)/conv(2)/QuantizedConv2d(384→64,stride=1)", (64, 14, 14), (False, 0, 0)),
        ("features(10)/shortcut/Add(64+64)", (64, 14, 14), (True, 0.029093407094478607, 130)),

        # 其余层保持完整...
        ("features(11)/conv(0)/QuantizedConvReLU2d(64→384,stride=1)", (384, 14, 14), (False, 0, 0)),
        ("features(11)/conv(1)/QuantizedConvReLU2d(384→384,stride=1)", (384, 14, 14), (False, 0, 0)),
        ("features(11)/conv(2)/QuantizedConv2d(384→96,stride=1)", (96, 14, 14), (False, 0, 0)),

        ("features(12)/conv(0)/QuantizedConvReLU2d(96→576,stride=1)", (576, 14, 14), (False, 0, 0)),
        ("features(12)/conv(1)/QuantizedConvReLU2d(576→576,stride=1)", (576, 14, 14), (False, 0, 0)),
        ("features(12)/conv(2)/QuantizedConv2d(576→96,stride=1)", (96, 14, 14), (False, 0, 0)),
        ("features(12)/shortcut/Add(96+96)", (96, 14, 14), (True, 0.02713003195822239, 125)),

        ("features(13)/conv(0)/QuantizedConvReLU2d(96→576,stride=1)", (576, 14, 14), (False, 0, 0)),
        ("features(13)/conv(1)/QuantizedConvReLU2d(576→576,stride=1)", (576, 14, 14), (False, 0, 0)),
        ("features(13)/conv(2)/QuantizedConv2d(576→96,stride=1)", (96, 14, 14), (False, 0, 0)),
        ("features(13)/shortcut/Add(96+96)", (96, 14, 14), (True, 0.037319157272577286, 116)),

        ("features(14)/conv(0)/QuantizedConvReLU2d(96→576,stride=1)", (576, 14, 14), (False, 0, 0)),
        ("features(14)/conv(1)/QuantizedConvReLU2d(576→576,stride=2)", (576, 7, 7), (False, 0, 0)),
        ("features(14)/conv(2)/QuantizedConv2d(576→160,stride=1)", (160, 7, 7), (False, 0, 0)),

        ("features(15)/conv(0)/QuantizedConvReLU2d(160→960,stride=1)", (960, 7, 7), (False, 0, 0)),
        ("features(15)/conv(1)/QuantizedConvReLU2d(960→960,stride=1)", (960, 7, 7), (False, 0, 0)),
        ("features(15)/conv(2)/QuantizedConv2d(960→160,stride=1)", (160, 7, 7), (False, 0, 0)),
        ("features(15)/shortcut/Add(160+160)", (160, 7, 7), (True, 0.045386239886283875, 119)),

        ("features(16)/conv(0)/QuantizedConvReLU2d(160→960,stride=1)", (960, 7, 7), (False, 0, 0)),
        ("features(16)/conv(1)/QuantizedConvReLU2d(960→960,stride=1)", (960, 7, 7), (False, 0, 0)),
        ("features(16)/conv(2)/QuantizedConv2d(960→160,stride=1)", (160, 7, 7), (False, 0, 0)),
        ("features(16)/shortcut/Add(160+160)", (160, 7, 7), (True, 0.08562454581260681, 114)),

        ("features(17)/conv(0)/QuantizedConvReLU2d(160→960,stride=1)", (960, 7, 7), (False, 0, 0)),
        ("features(17)/conv(1)/QuantizedConvReLU2d(960→960,stride=1)", (960, 7, 7), (False, 0, 0)),
        ("features(17)/conv(2)/QuantizedConv2d(960→320,stride=1)", (320, 7, 7), (False, 0, 0)),

        ("features(18)/QuantizedConvReLU2d(320→1280,stride=1)", (1280, 7, 7), (False, 0, 0)),

        ("classifier/全局平均池化(1280,1,1)", (1280, 1, 1), (False, 0, 0)),
        ("classifier/QuantizedLinear(1280→1000)", (1000, 1, 1), (False, 0, 0))
    ]

    # 初始起始地址
    start_addr = 0

    # 存储所有层的结果
    all_results = []
    current_start = start_addr
    current_layer_number = 0  # 用于跟踪当前的基础层编号

    # 计算输入层 - 作为第0层
    print(f"计算 {input_layer_name} ...")
    input_result = calculate_bram_address_range(current_start, input_layer_shape)
    input_result["layer_name"] = input_layer_name
    input_result["shortcut_info"] = None  # 输入层不是shortcut层
    input_result["base_layer_number"] = current_layer_number  # 输入层编号为0
    all_results.append(input_result)
    current_start = input_result["end_address"] + 1
    current_layer_number += 1  # 下一个基础层编号

    # 计算各层地址范围（包含所有层）
    for layer_name, layer_shape, shortcut_info in layers:
        is_shortcut, scale, zero_point = shortcut_info

        # 对于shortcut层，使用前一个基础层的编号
        if is_shortcut:
            layer_num = current_layer_number - 1  # 使用对应的卷积层编号
            print(f"计算 {layer_name} (对应基础层{layer_num}的shortcut) ...")
        else:
            layer_num = current_layer_number
            print(f"计算 {layer_name} (基础层{layer_num}) ...")
            current_layer_number += 1  # 只有非shortcut层才增加基础层编号

        result = calculate_bram_address_range(current_start, layer_shape)
        result["layer_name"] = layer_name
        result["base_layer_number"] = layer_num  # 记录对应的基础层编号
        result["shortcut_info"] = {
            "is_shortcut": is_shortcut,
            "scale": scale,
            "zero_point": zero_point
        } if is_shortcut else None
        all_results.append(result)

        # 特别处理第9层的shortcut输出名称
        if layer_num == 9 and is_shortcut:
            print(f"已确保第9层的shortcut输出为: hardware_output_layer9_shortcut")

        current_start = result["end_address"] + 1

    # 写入txt文件
    with open("Data_bram_addresses.txt", "w", encoding="utf-8") as f:
        # 写入所有层信息，按指定格式
        for result in all_results:
            layer_num = result["base_layer_number"]
            is_shortcut = result["shortcut_info"]["is_shortcut"] if result["shortcut_info"] else False

            # 生成指定格式的output_prefix
            if is_shortcut:
                output_prefix = f"hardware_output_layer{layer_num}_shortcut"
            else:
                output_prefix = f"hardware_output_layer{layer_num}"

            # 安全获取shortcut信息
            shortcut_info = result.get("shortcut_info", {})
            scale = shortcut_info.get("scale") if shortcut_info else None
            zero_point = shortcut_info.get("zero_point") if shortcut_info else None

            # 按指定格式写入，不包含is_shortcut
            layer_entry = f'''    {{
            "output_shape": {result["layer_shape"]},
            "start_addr": {result["start_address"]},
            "end_addr": {result["end_address"]},
            "bram_files": [f"bram{{i}}.txt" for i in range(9)],
            "output_prefix": "{output_prefix}",
            "window_size": 3,
            {f'"scale": {scale},' if scale is not None else ''}
            {f'"zero_point": {zero_point},' if zero_point is not None else ''}
            # 不指定output_dir则输出到当前目录
        }}'''

            # 最后一个条目不加逗号
            if result != all_results[-1]:
                layer_entry += ","

            f.write(layer_entry + "\n")

    # 控制台显示完成信息
    print("\n===== 生成完成 =====")
    print(f"已按指定格式保存到 'layer_addresses.txt' 文件中")
    print(f"总层数: {len(all_results)}")
    print(f"基础层数量: {current_layer_number}")
    shortcut_count = sum(
        1 for r in all_results if r.get("shortcut_info") and r["shortcut_info"].get("is_shortcut", False))
    print(f"shortcut层数: {shortcut_count}")

    # 验证第9层的shortcut是否存在并正确命名
    layer9_shortcut = next((r for r in all_results if r.get("base_layer_number") == 9 and
                            r.get("shortcut_info") and r["shortcut_info"].get("is_shortcut", False)), None)
    if layer9_shortcut:
        print(f"第9层的shortcut输出名称: hardware_output_layer9_shortcut")
    else:
        print(f"注意: 未找到第9层的shortcut层，请检查层定义")


if __name__ == "__main__":
    main()
