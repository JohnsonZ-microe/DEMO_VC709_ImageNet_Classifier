import pickle
import numpy as np

# ===================== 配置参数（可根据需要修改） =====================
# ifmp0.pkl文件路径
IFMP0_PKL_PATH = "ifmap.p"
# 输出txt文件的目录（确保该目录已存在）
OUTPUT_DIR = "./merged_bram_output/"
# 输入特征图原始边长（原代码中为224）
INPUT_SIZE = 224
# padding填充值（原代码中为101）
PADDING_VALUE = 101

# ===================== 核心处理逻辑 =====================
def bin8(x):
    """
    将8位整数转换为反向的二进制字符串（适配硬件内存位序）
    参数x: uint8类型的整数
    返回: 8位反向二进制字符串（如x=1 → '10000000'）
    """
    return ''.join(reversed([str((x >> i) & 1) for i in range(8)]))

def process_ifmp():
    # 1. 加载ifmp0原始数据
    print("正在加载ifmp0数据...")
    with open(IFMP0_PKL_PATH, "rb") as f:
        ifmp0 = pickle.load(f)
    print(f"ifmp0原始形状: {ifmp0.shape}")

    # 2. 计算3x3滑动窗口相关尺寸
    b = int(INPUT_SIZE / 3 + 1)
    print(f"计算得到窗口数量相关尺寸b: {b}")

    # 3. 为ifmp0添加padding扩展（未覆盖区域填充101）
    ifmp0_padding = np.full((3, b*3, b*3), PADDING_VALUE, dtype="uint8")
    # 将原始ifmp0数据填充到padding数组的对应位置
    for i in range(ifmp0.shape[0]):
        for j in range(ifmp0.shape[1]):
            for k in range(ifmp0.shape[2]):
                ifmp0_padding[i][j][k] = ifmp0[i][j][k]
    print(f"padding后ifmp0形状: {ifmp0_padding.shape}")

    # 4. 初始化重排后的数组（与原代码一致）
    ifmp0_processed = np.full((9, b*b, 9), 0, dtype="uint8")
    ifmp0_processed1 = np.full((b*b, 9, 9), 0, dtype="uint8")  # 原代码中备用数组

    # 5. 按3x3窗口编号重排ifmp0数据（核心维度映射逻辑）
    print("正在重排ifmp0数据维度...")
    for i in range(b):          # 遍历窗口行
        for j in range(b):      # 遍历窗口列
            c = i * b + j       # 计算当前3x3窗口的唯一编号
            for k in range(3):  # 遍历通道维度（固定为3）
                for l in range(3):  # 遍历窗口内的行
                    for m in range(3):  # 遍历窗口内的列
                        # 维度映射（与原代码完全一致）
                        ifmp0_processed[l*3 + m][c][k] = ifmp0_padding[k][i*3 + l][j*3 + m]
                        ifmp0_processed1[c][l*3 + m][k] = ifmp0_padding[k][i*3 + l][j*3 + m]

    # 6. 将处理后的数据写入硬件初始化txt文件
    print("正在写入ifmp处理后的txt文件...")
    for i in range(ifmp0_processed.shape[0]):
        file_path = f"{OUTPUT_DIR}new_{i}.txt"
        with open(file_path, "w+") as f:
            # 写入硬件内存初始化头信息
            f.write("memory_initialization_radix=2;\n")
            f.write("memory_initialization_vector=\n")
            # 遍历每个窗口/深度维度
            for j in range(ifmp0_processed.shape[1]):
                temp = ""
                # 拼接二进制字符串（反向位序）
                for k in range(ifmp0_processed.shape[2]):
                    temp = bin8(ifmp0_processed[i][j][k]) + temp
                temp += "\n"
                f.write(temp)
    print(f"ifmp处理完成！输出文件路径: {OUTPUT_DIR}")

# 执行ifmp处理函数
if __name__ == "__main__":
    process_ifmp()