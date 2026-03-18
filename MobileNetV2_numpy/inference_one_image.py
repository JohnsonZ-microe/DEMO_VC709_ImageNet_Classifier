#!/usr/bin/env python3
import time
import subprocess
import os
import getpass

# ===================== 核心配置项（可混合.sh和.py）=====================
# 需要sudo执行的初始化bash脚本
SUDO_INIT_SCRIPTS = [
    "./inference_one_image.sh",
]
# 循环中生成bin文件的脚本
GENERATE_BIN_SCRIPT = "./check_inference_complete.sh"
# bin文件路径
BIN_FILE_PATH = "./data_rd/check_inference_complete.bin"
# 循环间隔（毫秒）
CHECK_INTERVAL_MS = 1
# 校验目标：开头9个0xff（根据你的需求调整）
TARGET_HEX_PREFIX = b'\xff' * 9
# 【核心修改】收尾脚本列表（支持.sh和.py混合）
FINAL_SCRIPTS = [
    "./end_inference.sh",  # bash脚本
    "./print_result.py",  # python脚本
]


def run_sudo_script(script_path):
    """sudo执行初始化bash脚本"""
    try:
        result = subprocess.run(
            ["sudo", "/bin/bash", script_path],
            check=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True
        )
        print(f"✅ sudo执行初始化脚本 {script_path} 成功")
        return True
    except subprocess.CalledProcessError as e:
        print(f"❌ sudo执行初始化脚本 {script_path} 失败：{e.stderr}")
        return False
    except FileNotFoundError:
        print(f"❌ 初始化脚本不存在：{script_path}")
        return False


def run_generate_bin_script(script_path):
    """执行生成bin的bash脚本"""
    try:
        result = subprocess.run(
            ["/bin/bash", script_path],
            check=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True
        )
        return True
    except subprocess.CalledProcessError as e:
        print(f"⚠️ 生成bin脚本执行失败：{e.stderr}")
        return False
    except FileNotFoundError:
        print(f"❌ 生成bin脚本不存在：{script_path}，退出")
        return False


def check_bin_file(file_path):
    """检查bin文件内容（开头9个0xff则跳出循环）"""
    try:
        if not os.path.exists(file_path):
            print(f"⚠️ bin文件不存在：{file_path}")
            return -1

        with open(file_path, 'rb') as f:
            content = f.read()

        if all(byte == 0 for byte in content):
            return 0

        if len(content) >= 9 and content[:9] == TARGET_HEX_PREFIX:
            return 1

        return -1
    except Exception as e:
        print(f"⚠️ 读取bin文件出错：{e}")
        return -1


def run_final_script(script_path):
    """执行收尾脚本（自动区分.sh/.py，容错处理）"""
    # 第一步：检查文件是否存在
    if not os.path.exists(script_path):
        print(f"❌ 收尾脚本不存在：{script_path}（继续下一个）")
        return False

    # 第二步：根据后缀判断执行方式
    try:
        if script_path.endswith(".sh"):
            # 执行bash脚本
            result = subprocess.run(
                ["/bin/bash", script_path],
                check=True,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                text=True
            )
            print(f"✅ 执行bash收尾脚本 {script_path} 成功")

        elif script_path.endswith(".py"):
            # 执行python脚本（用python3，兼容多数系统）
            result = subprocess.run(
                ["python3", script_path],
                check=True,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                text=True
            )
            print(f"✅ 执行python收尾脚本 {script_path} 成功")

        else:
            print(f"⚠️ 不支持的脚本类型：{script_path}（继续下一个）")
            return False

        return True

    except subprocess.CalledProcessError as e:
        print(f"❌ 执行收尾脚本 {script_path} 失败（继续下一个）：{e.stderr}")
        return False
    except Exception as e:
        print(f"❌ 执行收尾脚本 {script_path} 异常：{str(e)}（继续下一个）")
        return False


def main():
    # 1. 执行初始化脚本
    print("===== 执行初始化脚本 =====")
    sudo_password = getpass.getpass(prompt="请输入sudo密码：")
    os.environ["SUDO_ASKPASS"] = "/bin/echo"
    os.environ["SUDO_PASSWORD"] = sudo_password

    for script in SUDO_INIT_SCRIPTS:
        if not run_sudo_script(script):
            print("❌ 初始化失败，退出")
            return

    # 2. 等待25ms
    print("\n===== 等待25ms =====")
    time.sleep(0.025)

    # 3. 循环生成并检查bin文件
    print("\n===== 循环检查bin文件 =====")
    loop_count = 0
    while True:
        loop_count += 1

        # 生成bin文件
        if not run_generate_bin_script(GENERATE_BIN_SCRIPT):
            if not os.path.exists(GENERATE_BIN_SCRIPT):
                exit(1)

        # 检查bin文件
        check_result = check_bin_file(BIN_FILE_PATH)
        if check_result == 1:
            print(f"✅ 检测到目标bin内容（循环次数：{loop_count}），跳出循环")
            break
        elif check_result == 0 and loop_count % 10 == 0:
            print(f"ℹ️ bin文件全0，继续循环（次数：{loop_count}）")

        time.sleep(CHECK_INTERVAL_MS / 1000)

    # 4. 执行所有收尾脚本（含.sh和.py）
    print("\n===== 执行收尾脚本 =====")
    all_success = True
    for script in FINAL_SCRIPTS:
        if not run_final_script(script):
            all_success = False

    if all_success:
        print("✅ 所有收尾脚本执行成功")
    else:
        print("⚠️ 部分收尾脚本执行失败，请检查")

    print("\n===== 所有流程完成 =====")


if __name__ == "__main__":
    if os.geteuid() == 0:
        print("⚠️ 请勿用root直接运行，使用普通用户+sudo")
        exit(1)
    main()