import os

def filter_and_expand_binary(text_content: str) -> list[str]:
    """过滤文字，提取72位二进制串并扩充至128位"""
    pure_binary = ''.join([c for c in text_content if c in ('0', '1')])
    expanded_list = []

    for i in range(0, len(pure_binary), 72):
        segment = pure_binary[i:i + 72]
        if len(segment) != 72:
            print(f"⚠️  发现不合法片段（长度{len(segment)}位，非72位），已跳过：{segment[:20]}...")
            continue
        expanded = segment.ljust(128, '0')  # 补零至128位
        expanded_list.append(expanded)
    return expanded_list


def binary_str_to_bytes(binary_str: str) -> bytes:
    """将128位二进制串转为16字节（每8位对应1个字节）"""
    bytes_list = []
    for i in range(0, 128, 8):
        byte_str = binary_str[i:i + 8]
        byte = int(byte_str, 2)
        bytes_list.append(byte.to_bytes(1, byteorder='big'))
    return b''.join(bytes_list)


def process_single_txt(txt_path: str, output_dir: str) -> bool:
    """处理单个指定的TXT文件，输出BIN文件"""
    # 检查输入文件合法性
    if not os.path.exists(txt_path):
        print(f"❌ 文件不存在：{txt_path}")
        return False
    if not os.path.isfile(txt_path):
        print(f"❌ 不是合法文件：{txt_path}")
        return Falsez
    if not txt_path.endswith('.txt'):
        print(f"❌ 非TXT文件：{txt_path}，仅支持TXT格式")
        return False

    try:
        # 读取TXT内容
        with open(txt_path, 'r', encoding='utf-8') as f:
            content = f.read()

        # 过滤并扩充二进制数据
        expanded_binaries = filter_and_expand_binary(content)
        if not expanded_binaries:
            print(f"❌ 未提取到有效72位二进制数据：{txt_path}")
            return False

        # 生成输出BIN路径
        file_name = os.path.basename(txt_path)
        bin_name = os.path.splitext(file_name)[0] + ".bin"
        bin_path = os.path.join(output_dir, bin_name)

        # 写入BIN文件
        with open(bin_path, 'wb') as f:
            for bin_str in expanded_binaries:
                f.write(binary_str_to_bytes(bin_str))

        print(f"✅ 处理成功：{txt_path} → {bin_path}")
        print(f"   有效数据段数：{len(expanded_binaries)}（每段128位）")
        return True

    except PermissionError:
        print(f"❌ 权限不足：无法读取 {txt_path} 或写入 {bin_path}")
        return False
    except Exception as e:
        print(f"❌ 处理失败 {txt_path}：{str(e)}")
        return False


def batch_process_specified_txt(FILE_LIST: list[str], output_dir: str) -> None:
    """批量处理用户指定的TXT文件列表"""
    # 检查输出目录，不存在则创建
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)
        print(f"📁 创建输出目录：{output_dir}")

    # 检查文件列表是否为空
    if not FILE_LIST:
        print(f"⚠️  未指定任何要处理的TXT文件！")
        return

    # 统计结果
    total = len(FILE_LIST)
    success = 0
    fail = 0

    print(f"\n=== 开始处理 {total} 个指定TXT文件 ===")
    print("-" * 80)
    for txt_path in FILE_LIST:
        if process_single_txt(txt_path, output_dir):
            success += 1
        else:
            fail += 1

    # 输出汇总
    print("-" * 80)
    print(f"=== 处理完成 ===")
    print(f"📊 总文件数：{total}")
    print(f"✅ 处理成功：{success} 个")
    print(f"❌ 处理失败：{fail} 个")


# 主程序入口
if __name__ == "__main__":
    # 配置参数（修改这里指定要处理的文件）
    FILE_LIST = [
        "./merged_bram_output/weight_layer1_0.txt",  # 第一个要处理的TXT文件（相对路径/绝对路径均可）
        "./merged_bram_output/weight_layer1_1.txt",
        "./merged_bram_output/weight_layer1_2.txt",
        "./merged_bram_output/weight_layer1_3.txt",
        "./merged_bram_output/weight_layer1_4.txt",
        "./merged_bram_output/weight_layer1_5.txt",
        "./merged_bram_output/weight_layer1_6.txt",
        "./merged_bram_output/weight_layer1_7.txt",
        "./merged_bram_output/weight_layer1_8.txt",
        "./merged_bram_output/ifmp_layer1_0.txt",
        "./merged_bram_output/ifmp_layer1_1.txt",
        "./merged_bram_output/ifmp_layer1_2.txt",
        "./merged_bram_output/ifmp_layer1_3.txt",
        "./merged_bram_output/ifmp_layer1_4.txt",
        "./merged_bram_output/ifmp_layer1_5.txt",
        "./merged_bram_output/ifmp_layer1_6.txt",
        "./merged_bram_output/ifmp_layer1_7.txt",
        "./merged_bram_output/ifmp_layer1_8.txt",
        # 可继续添加更多文件，格式："文件路径"
    ]
    OUTPUT_DIRECTORY = "./bin_output"  # BIN文件输出目录

    # 执行处理
    batch_process_specified_txt(FILE_LIST, OUTPUT_DIRECTORY)

    import os


    def filter_and_expand_binary(text_content: str) -> list[str]:
        """过滤文字，提取72位二进制串并扩充至128位"""
        pure_binary = ''.join([c for c in text_content if c in ('0', '1')])
        expanded_list = []

        for i in range(0, len(pure_binary), 72):
            segment = pure_binary[i:i + 72]
            if len(segment) != 72:
                print(f"⚠️  发现不合法片段（长度{len(segment)}位，非72位），已跳过：{segment[:20]}...")
                continue
            expanded = segment.ljust(128, '0')  # 补零至128位
            expanded_list.append(expanded)
        return expanded_list


    def binary_str_to_bytes(binary_str: str) -> bytes:
        """将128位二进制串转为16字节（每8位对应1个字节）"""
        bytes_list = []
        for i in range(0, 128, 8):
            byte_str = binary_str[i:i + 8]
            byte = int(byte_str, 2)
            bytes_list.append(byte.to_bytes(1, byteorder='big'))
        return b''.join(bytes_list)


    def process_single_txt(txt_path: str, output_dir: str) -> bool:
        """处理单个指定的TXT文件（原有72位段模式），输出BIN文件"""
        # 检查输入文件合法性
        if not os.path.exists(txt_path):
            print(f"❌ 文件不存在：{txt_path}")
            return False
        if not os.path.isfile(txt_path):
            print(f"❌ 不是合法文件：{txt_path}")
            return False
        if not txt_path.endswith('.txt'):
            print(f"❌ 非TXT文件：{txt_path}，仅支持TXT格式")
            return False

        try:
            # 读取TXT内容
            with open(txt_path, 'r', encoding='utf-8') as f:
                content = f.read()

            # 过滤并扩充二进制数据
            expanded_binaries = filter_and_expand_binary(content)
            if not expanded_binaries:
                print(f"❌ 未提取到有效72位二进制数据：{txt_path}")
                return False

            # 生成输出BIN路径
            file_name = os.path.basename(txt_path)
            bin_name = os.path.splitext(file_name)[0] + ".bin"
            bin_path = os.path.join(output_dir, bin_name)

            # 写入BIN文件
            with open(bin_path, 'wb') as f:
                for bin_str in expanded_binaries:
                    f.write(binary_str_to_bytes(bin_str))

            print(f"✅ 处理成功：{txt_path} → {bin_path}")
            print(f"   有效数据段数：{len(expanded_binaries)}（每段128位）")
            return True

        except PermissionError:
            print(f"❌ 权限不足：无法读取 {txt_path} 或写入 {bin_path}")
            return False
        except Exception as e:
            print(f"❌ 处理失败 {txt_path}：{str(e)}")
            return False


    def batch_process_specified_txt(FILE_LIST: list[str], output_dir: str) -> None:
        """批量处理用户指定的TXT文件（原有72位段模式）"""
        # 检查输出目录，不存在则创建
        if not os.path.exists(output_dir):
            os.makedirs(output_dir)
            print(f"📁 创建输出目录：{output_dir}")

        # 检查文件列表是否为空
        if not FILE_LIST:
            print(f"⚠️  未指定任何要处理的TXT文件！")
            return

        # 统计结果
        total = len(FILE_LIST)
        success = 0
        fail = 0

        print(f"\n=== 开始处理 {total} 个指定TXT文件（72位段模式） ===")
        print("-" * 80)
        for txt_path in FILE_LIST:
            if process_single_txt(txt_path, output_dir):
                success += 1
            else:
                fail += 1

        # 输出汇总
        print("-" * 80)
        print(f"=== 处理完成 ===")
        print(f"📊 总文件数：{total}")
        print(f"✅ 处理成功：{success} 个")
        print(f"❌ 处理失败：{fail} 个")


    # ===================== 新增288位每行处理逻辑 =====================
    def filter_and_split_288binary(text_content: str) -> list[str]:
        """
        过滤文字，提取每行288位二进制串，由低到高拆分为4个72位段，每段扩充至128位
        拆分逻辑：
        - 288位串 → 拆分为 [0-71位(最低), 72-143位, 144-215位, 216-287位(最高)] 四个72位段
        - 每个72位段末尾补0至128位
        """
        expanded_list = []
        # 按行分割内容，逐行处理
        lines = text_content.splitlines()
        for line_num, line in enumerate(lines, 1):
            # 过滤每行的纯二进制字符（去除文字部分）
            pure_binary = ''.join([c for c in line if c in ('0', '1')])
            # 校验每行二进制长度是否为288位
            if len(pure_binary) != 288:
                print(
                    f"⚠️  第{line_num}行发现不合法片段（长度{len(pure_binary)}位，非288位），已跳过：{pure_binary[:20]}...")
                continue
            # 由低到高拆分为4个72位段
            seg_lowest = pure_binary[0:72]  # 最低位72位
            seg_2 = pure_binary[72:144]  # 次低位72位
            seg_3 = pure_binary[144:216]  # 次高位72位
            seg_highest = pure_binary[216:288]  # 最高位72位
            # 每个段补零至128位
            expanded_segs = [
                seg_lowest.ljust(128, '0'),
                seg_2.ljust(128, '0'),
                seg_3.ljust(128, '0'),
                seg_highest.ljust(128, '0')
            ]
            expanded_list.extend(expanded_segs)
        return expanded_list


    def process_single_288txt(txt_path: str, output_dir: str) -> bool:
        """处理单个指定的TXT文件（288位每行模式），输出BIN文件"""
        # 检查输入文件合法性
        if not os.path.exists(txt_path):
            print(f"❌ 文件不存在：{txt_path}")
            return False
        if not os.path.isfile(txt_path):
            print(f"❌ 不是合法文件：{txt_path}")
            return False
        if not txt_path.endswith('.txt'):
            print(f"❌ 非TXT文件：{txt_path}，仅支持TXT格式")
            return False

        try:
            # 读取TXT内容
            with open(txt_path, 'r', encoding='utf-8') as f:
                content = f.read()

            # 过滤、拆分并扩充二进制数据
            expanded_binaries = filter_and_split_288binary(content)
            if not expanded_binaries:
                print(f"❌ 未提取到有效288位二进制数据：{txt_path}")
                return False

            # 生成输出BIN路径
            file_name = os.path.basename(txt_path)
            bin_name = os.path.splitext(file_name)[0] + ".bin"
            bin_path = os.path.join(output_dir, bin_name)

            # 写入BIN文件
            with open(bin_path, 'wb') as f:
                for bin_str in expanded_binaries:
                    f.write(binary_str_to_bytes(bin_str))

            print(f"✅ 处理成功（288位行模式）：{txt_path} → {bin_path}")
            print(f"   有效数据段数：{len(expanded_binaries)}（每段128位，源自{len(expanded_binaries) // 4}行288位数据）")
            return True

        except PermissionError:
            print(f"❌ 权限不足：无法读取 {txt_path} 或写入 {bin_path}")
            return False
        except Exception as e:
            print(f"❌ 处理失败（288位行模式） {txt_path}：{str(e)}")
            return False


    def batch_process_288txt(FILE_LIST: list[str], output_dir: str) -> None:
        """批量处理用户指定的TXT文件列表（288位每行模式）"""
        # 检查输出目录，不存在则创建
        if not os.path.exists(output_dir):
            os.makedirs(output_dir)
            print(f"📁 创建输出目录：{output_dir}")

        # 检查文件列表是否为空
        if not FILE_LIST:
            print(f"⚠️  未指定任何要处理的TXT文件！")
            return

        # 统计结果
        total = len(FILE_LIST)
        success = 0
        fail = 0

        print(f"\n=== 开始处理 {total} 个指定TXT文件（288位行模式） ===")
        print("-" * 80)
        for txt_path in FILE_LIST:
            if process_single_288txt(txt_path, output_dir):
                success += 1
            else:
                fail += 1

        # 输出汇总
        print("-" * 80)
        print(f"=== 处理完成 ===")
        print(f"📊 总文件数：{total}")
        print(f"✅ 处理成功：{success} 个")
        print(f"❌ 处理失败：{fail} 个")


    # ===================== 主程序入口（可切换模式） =====================
    if __name__ == "__main__":
        # ========== 配置区（修改这里切换模式/指定文件） ==========
        # 运行模式："72bit_segment"（原有72位段模式） / "288bit_line"（新增288位行模式）
        RUN_MODE = "288bit_line"

        # 72位段模式配置
        FILE_LIST_72BIT = [
        "./merged_bram_output/weight_layer1_0.txt",  # 第一个要处理的TXT文件（相对路径/绝对路径均可）
        "./merged_bram_output/weight_layer1_1.txt",
        "./merged_bram_output/weight_layer1_2.txt",
        "./merged_bram_output/weight_layer1_3.txt",
        "./merged_bram_output/weight_layer1_4.txt",
        "./merged_bram_output/weight_layer1_5.txt",
        "./merged_bram_output/weight_layer1_6.txt",
        "./merged_bram_output/weight_layer1_7.txt",
        "./merged_bram_output/weight_layer1_8.txt",
        "./merged_bram_output/ifmp_layer1_0.txt",
        "./merged_bram_output/ifmp_layer1_1.txt",
        "./merged_bram_output/ifmp_layer1_2.txt",
        "./merged_bram_output/ifmp_layer1_3.txt",
        "./merged_bram_output/ifmp_layer1_4.txt",
        "./merged_bram_output/ifmp_layer1_5.txt",
        "./merged_bram_output/ifmp_layer1_6.txt",
        "./merged_bram_output/ifmp_layer1_7.txt",
        "./merged_bram_output/ifmp_layer1_8.txt",
        # 可继续添加更多文件，格式："文件路径"
    ]
        OUTPUT_DIR_72BIT = "./bin_output"

        # 288位行模式配置（修改为你的实际文件路径）
        FILE_LIST_288BIT = [
            "./merged_bram_output/m1_layer1.txt",
            # 可继续添加更多288位行模式的文件
        ]
        OUTPUT_DIR_288BIT = "./bin_output"

        # ========== 执行逻辑 ==========
        if RUN_MODE == "72bit_segment":
            batch_process_specified_txt(FILE_LIST_72BIT, OUTPUT_DIR_72BIT)
        elif RUN_MODE == "288bit_line":
            batch_process_288txt(FILE_LIST_288BIT, OUTPUT_DIR_288BIT)
        else:
            print(f"❌ 无效的运行模式：{RUN_MODE}，请选择 '72bit_segment' 或 '288bit_line'")