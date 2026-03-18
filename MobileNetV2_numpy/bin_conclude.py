import os
import sys


def read_bin_file_to_16byte_lines(file_path):
    """
    读取bin文件，按每16个字节分割为一行（二进制）
    :param file_path: bin文件路径
    :return: 16字节块列表，不足16字节的最后一块也保留；读取失败返回空列表
    """
    try:
        with open(file_path, 'rb') as f:
            bin_content = f.read()  # 读取全部二进制内容

        # 按每16个字节分割成一行，核心修改点
        lines = []
        block_size = 16
        # 从0开始，步长16截取内容
        for i in range(0, len(bin_content), block_size):
            line = bin_content[i:i + block_size]
            lines.append(line)

        return lines
    except Exception as e:
        print(f"读取文件 {file_path} 失败: {str(e)}")
        return []


def compare_bin_folders(folder1, folder2):
    """
    对比两个文件夹中同名bin文件的内容（按16字节/行），统计相同行数
    :param folder1: 文件夹1路径（内容更多的文件夹）
    :param folder2: 文件夹2路径（内容更少的文件夹）
    """
    # 验证文件夹是否存在
    if not os.path.isdir(folder1):
        print(f"错误：文件夹1 {folder1} 不存在或不是有效文件夹")
        return
    if not os.path.isdir(folder2):
        print(f"错误：文件夹2 {folder2} 不存在或不是有效文件夹")
        return

    # 获取两个文件夹中的bin文件列表（仅保留.bin后缀）
    folder1_files = {
        fname: os.path.join(folder1, fname)
        for fname in os.listdir(folder1)
        if fname.lower().endswith('.bin') and os.path.isfile(os.path.join(folder1, fname))
    }
    folder2_files = {
        fname: os.path.join(folder2, fname)
        for fname in os.listdir(folder2)
        if fname.lower().endswith('.bin') and os.path.isfile(os.path.join(folder2, fname))
    }

    # 找出同名的bin文件
    common_files = set(folder1_files.keys()) & set(folder2_files.keys())
    if not common_files:
        print("两个文件夹中没有同名的bin文件")
        return

    # 总统计
    total_common_lines = 0
    total_files_compared = 0

    print("=" * 60)
    print(f"共找到 {len(common_files)} 个同名bin文件，开始对比（16字节/行）...")
    print("=" * 60)

    # 逐文件对比
    for fname in sorted(common_files):
        f1_path = folder1_files[fname]
        f2_path = folder2_files[fname]

        # 读取文件内容（按16字节/行）
        f1_lines = read_bin_file_to_16byte_lines(f1_path)
        f2_lines = read_bin_file_to_16byte_lines(f2_path)

        if not f1_lines or not f2_lines:
            print(f"\n【{fname}】：文件读取失败，跳过对比")
            continue

        # 统计文件夹2的16字节行在文件夹1中出现的数量
        match_count = 0
        for line in f2_lines:
            if line in f1_lines:
                match_count += 1

        # 输出当前文件结果
        print(f"\n【{fname}】")
        print(f"  文件夹1文件总行数（16字节/行）：{len(f1_lines)}")
        print(f"  文件夹2文件总行数（16字节/行）：{len(f2_lines)}")
        print(f"  相同行数：{match_count}")
        print(f"  是否完全包含：{'是' if match_count == len(f2_lines) else '否'}")

        # 更新总统计
        total_common_lines += match_count
        total_files_compared += 1

    # 输出汇总结果
    print("\n" + "=" * 60)
    print("对比汇总（16字节/行）：")
    print(f"  实际对比文件数：{total_files_compared}")
    print(f"  所有文件累计相同行数：{total_common_lines}")
    print("=" * 60)


if __name__ == "__main__":
    # 修改为你的实际文件夹路径
    FOLDER1_PATH = r"1"  # 文件夹1（首尾多几行的文件夹）
    FOLDER2_PATH = r"bin_output"  # 文件夹2

    compare_bin_folders(FOLDER1_PATH, FOLDER2_PATH)