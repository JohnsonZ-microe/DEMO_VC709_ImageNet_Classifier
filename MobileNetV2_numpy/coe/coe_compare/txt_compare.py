import os
from typing import List, Tuple

def compare_two_txt_files(file1: str, file2: str, block_size: int = 4096) -> Tuple[bool, str]:
    """
    核心函数：对比单个TXT文件对是否完全一致（二进制级别）
    返回：(是否一致, 提示信息)
    """
    # 检查文件是否存在
    if not os.path.exists(file1):
        return False, f"❌ 缺失文件：{file1} 不存在"
    if not os.path.exists(file2):
        return False, f"❌ 缺失文件：{file2} 不存在"
    if not os.path.isfile(file1) or not os.path.isfile(file2):
        return False, f"❌ 非法文件：{file1} 或 {file2} 不是合法的TXT文件"

    # 先对比文件大小
    size1 = os.path.getsize(file1)
    size2 = os.path.getsize(file2)
    if size1 != size2:
        return False, f"❌ 大小不一致：{file1}({size1}字节) vs {file2}({size2}字节)"

    # 逐块对比内容
    try:
        with open(file1, 'rb') as f1, open(file2, 'rb') as f2:
            offset = 0
            while True:
                b1 = f1.read(block_size)
                b2 = f2.read(block_size)

                if not b1 and not b2:
                    break
                if b1 != b2:
                    # 定位第一个不同字节
                    min_len = min(len(b1), len(b2))
                    for i in range(min_len):
                        if b1[i] != b2[i]:
                            diff_pos = offset + i
                            return False, f"❌ 内容不一致：{file1} vs {file2}（字节偏移量 {diff_pos}）"
                    return False, f"❌ 内容不一致：{file1} vs {file2}（块长度不同）"
                offset += len(b1)

        return True, f"✅ 完全一致：{file1} vs {file2}"
    except PermissionError:
        return False, f"❌ 权限不足：无法读取 {file1} 或 {file2}"
    except Exception as e:
        return False, f"❌ 未知错误：{str(e)}（文件对：{file1} vs {file2}）"

def batch_compare_manual(file_pairs: List[Tuple[str, str]]) -> None:
    """
    模式1：手动指定多组文件对进行对比（适合无规律命名）
    参数：file_pairs - 列表，每个元素是(文件1路径, 文件2路径)
    """
    if not file_pairs:
        print("⚠️  未指定任何需要对比的文件对！")
        return

    # 统计变量
    total = len(file_pairs)
    match = 0
    mismatch = 0
    error = 0

    # 开始批量对比
    print(f"\n=== 手动模式：开始对比 {total} 组TXT文件 ===")
    print("-" * 80)
    for idx, (f1, f2) in enumerate(file_pairs, 1):
        result, msg = compare_two_txt_files(f1, f2)
        print(f"[{idx}] {msg}")
        # 更新统计
        if result:
            match += 1
        elif "缺失" in msg or "权限" in msg or "未知错误" in msg:
            error += 1
        else:
            mismatch += 1

    # 汇总结果
    print("-" * 80)
    print("=== 对比完成：汇总结果 ===")
    print(f"📊 总组数：{total}")
    print(f"✅ 完全一致：{match} 组")
    print(f"❌ 内容/大小不一致：{mismatch} 组")
    print(f"⚠️  错误（缺失/权限等）：{error} 组")

def batch_compare_auto(dir_path: str, prefix_rule: str = "{group}_1.txt", suffix_rule: str = "{group}_2.txt") -> None:
    """
    模式2：按命名规则自动配对对比（适合有规律命名，比如 group1_1.txt ↔ group1_2.txt）
    参数：
        dir_path - 目标目录路径
        prefix_rule - 第一组文件的命名规则（{group} 为分组标识）
        suffix_rule - 第二组文件的命名规则（{group} 为分组标识）
    """
    if not os.path.isdir(dir_path):
        print(f"❌ 错误：目录 {dir_path} 不存在或不是合法目录！")
        return

    # 提取所有符合前缀规则的文件，解析分组标识
    groups = set()
    file_map = {}
    # 示例：prefix_rule是"{group}_1.txt"，则匹配 "xxx_1.txt"，提取xxx作为group
    rule_part = prefix_rule.replace("{group}", "")  # 得到 "_1.txt"
    rule_len = len(rule_part)

    for filename in os.listdir(dir_path):
        if filename.endswith(rule_part) and len(filename) > rule_len:
            group = filename[:-rule_len]  # 提取分组标识（比如 "group1"）
            groups.add(group)
            file_map[f"{group}_1"] = os.path.join(dir_path, filename)

    # 为每个分组匹配对应文件
    file_pairs = []
    for group in groups:
        f1_path = file_map.get(f"{group}_1")
        f2_name = suffix_rule.replace("{group}", group)
        f2_path = os.path.join(dir_path, f2_name)
        if f1_path:
            file_pairs.append((f1_path, f2_path))

    # 调用手动对比逻辑处理自动配对的文件
    batch_compare_manual(file_pairs)

# 主程序入口：按需选择模式
if __name__ == "__main__":
    # ==================== 模式1：手动指定文件对（推荐无规律命名） ====================
    # 替换为你要对比的多组TXT文件路径
    MANUAL_FILE_PAIRS = [
        ("new_0.txt", "old0.txt"),  # 第一组
        ("new_1.txt", "old1.txt"), ("new_2.txt", "old2.txt"),
        ("new_3.txt", "old3.txt"), ("new_4.txt", "old4.txt"),
        ("new_5.txt", "old5.txt"), ("new_6.txt", "old6.txt"),
        ("new_7.txt", "old7.txt"), ("new_8.txt", "old8.txt")
    ]
    # 执行手动模式对比
    batch_compare_manual(MANUAL_FILE_PAIRS)

    # ==================== 模式2：自动按规则配对（适合有规律命名） ====================
    # 示例：对比 dir_path 下的 group1_1.txt ↔ group1_2.txt、group2_1.txt ↔ group2_2.txt
    # TARGET_DIR = "./files"  # 目标目录
    # PREFIX_RULE = "{group}_1.txt"  # 第一组文件规则（比如 group1_1.txt）
    # SUFFIX_RULE = "{group}_2.txt"  # 第二组文件规则（比如 group1_2.txt）
    # # 执行自动模式对比
    # batch_compare_auto(TARGET_DIR, PREFIX_RULE, SUFFIX_RULE)