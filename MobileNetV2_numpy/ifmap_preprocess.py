import pickle
import numpy as np
from PIL import Image
from pathlib import Path  # 替代os，也可以换回os（如果需要）

# ==========================================================
# 1. 纯PIL+Numpy实现图像预处理（替代torchvision.transforms）
# ==========================================================

# 原torchvision的归一化参数
MEAN = [0.485, 0.456, 0.406]
STD = [0.229, 0.224, 0.225]


def pil_resize(image, size=256):
    """等价于torchvision.transforms.Resize(256)（保持比例，短边缩放到size）"""
    w, h = image.size
    # 计算缩放比例（短边对齐size）
    if w < h:
        new_w = size
        new_h = int(h * (size / w))
    else:
        new_h = size
        new_w = int(w * (size / h))
    # PIL的resize默认用BILINEAR，和torchvision一致
    return image.resize((new_w, new_h), Image.BILINEAR)


def pil_center_crop(image, crop_size=224):
    """等价于torchvision.transforms.CenterCrop(224)"""
    w, h = image.size
    # 计算中心裁剪的坐标
    left = (w - crop_size) // 2
    top = (h - crop_size) // 2
    right = left + crop_size
    bottom = top + crop_size
    return image.crop((left, top, right, bottom))


def pil_to_tensor(image):
    """等价于torchvision.transforms.ToTensor()"""
    # PIL图像转numpy数组 (H, W, C)，值范围[0,255]
    img_np = np.array(image, dtype=np.float32)
    # 归一化到[0,1] + 调整维度 (H,W,C) → (C,H,W)
    img_np = img_np / 255.0
    img_np = np.transpose(img_np, (2, 0, 1))
    return img_np


def normalize_np(img_np, mean=MEAN, std=STD):
    """等价于torchvision.transforms.Normalize"""
    # 广播均值/标准差，逐通道归一化：(x - mean) / std
    mean_np = np.array(mean, dtype=np.float32).reshape(3, 1, 1)
    std_np = np.array(std, dtype=np.float32).reshape(3, 1, 1)
    img_np = (img_np - mean_np) / std_np
    return img_np


def preprocess_image(image_name):
    """替代原preprocess_jpg_to_quantized_image中的torchvision逻辑"""
    # 1. 打开图像（保持和原逻辑一致，用PIL）
    input_image = Image.open(image_name).convert("RGB")  # 确保是RGB（避免灰度图）

    # 2. 逐步骤实现预处理（等价torchvision.Compose）
    input_image = pil_resize(input_image, 256)  # Resize(256)
    input_image = pil_center_crop(input_image, 224)  # CenterCrop(224)
    input_tensor = pil_to_tensor(input_image)  # ToTensor()
    input_tensor = normalize_np(input_tensor)  # Normalize

    # 以下逻辑和原代码完全一致（量化+保存）
    input_batch = np.expand_dims(input_tensor, axis=0)  # 等价unsqueeze(0)

    input_scale = 0.018657904118299484
    input_zero = np.array(114).astype("uint8")

    input_batch = input_batch[0]  # 等价detach().numpy()[0]

    input_quantized = input_zero + input_batch / input_scale
    input_quantized = np.round(input_quantized).astype("uint8")

    # 创建目录+保存pickle（用pathlib，也可换回os）
    coe_dir = Path("coe")
    coe_dir.mkdir(exist_ok=True)
    with open(coe_dir / "ifmap.p", "wb") as f:
        pickle.dump(input_quantized, f)

    print("✓ ifmap.p 生成完成")
    return input_quantized


# ==========================================================
# 2. ifmap重排 -> BRAM TXT（原逻辑完全不变）
# ==========================================================
INPUT_SIZE = 224
PADDING_VALUE = 101
OUTPUT_DIR = Path("./merged_bram_output/")


def bin8(x):
    return ''.join(reversed([str((x >> i) & 1) for i in range(8)]))


def process_ifmp(IFMP0_PKL_PATH):
    OUTPUT_DIR.mkdir(exist_ok=True)

    print("加载 ifmap 数据")
    with open(IFMP0_PKL_PATH, "rb") as f:
        ifmp0 = pickle.load(f)

    print("ifmap shape:", ifmp0.shape)

    b = int(INPUT_SIZE / 3 + 1)
    ifmp0_padding = np.full((3, b * 3, b * 3), PADDING_VALUE, dtype="uint8")

    for i in range(ifmp0.shape[0]):
        for j in range(ifmp0.shape[1]):
            for k in range(ifmp0.shape[2]):
                ifmp0_padding[i][j][k] = ifmp0[i][j][k]

    ifmp0_processed = np.full((9, b * b, 9), 0, dtype="uint8")

    print("开始3x3窗口重排")
    for i in range(b):
        for j in range(b):
            c = i * b + j
            for k in range(3):
                for l in range(3):
                    for m in range(3):
                        ifmp0_processed[l * 3 + m][c][k] = \
                            ifmp0_padding[k][i * 3 + l][j * 3 + m]

    print("写入 BRAM TXT")
    for i in range(ifmp0_processed.shape[0]):
        file_path = OUTPUT_DIR / f"ifmp_layer1_{i}.txt"
        with open(file_path, "w+") as f:
            f.write("memory_initialization_radix=2;\n")
            f.write("memory_initialization_vector=\n")
            for j in range(ifmp0_processed.shape[1]):
                temp = ""
                for k in range(ifmp0_processed.shape[2]):
                    temp = bin8(ifmp0_processed[i][j][k]) + temp
                temp += "\n"
                f.write(temp)

    print("✓ TXT 文件生成完成")


# ==========================================================
# 3. TXT -> BIN（原逻辑完全不变）
# ==========================================================
def reverse_bytes(hex_str):
    hex_str = hex_str.strip()
    bytes_list = [hex_str[i:i + 2] for i in range(0, len(hex_str), 2)]
    bytes_list.reverse()
    return ''.join(bytes_list)


def hex_to_padded_bytes(hex_str):
    hex_str = hex_str.ljust(32, '0')
    return bytes.fromhex(hex_str)


def process_txt_to_bin(txt_path, output_dir):
    txt_path = Path(txt_path)
    if not txt_path.exists():  # 替代os.path.exists
        print("文件不存在:", txt_path)
        return False

    output_dir = Path(output_dir)
    output_dir.mkdir(exist_ok=True)

    with open(txt_path, 'r') as f:
        lines = f.readlines()

    # 路径拼接（替代os.path.splitext/os.path.basename/os.path.join）
    bin_name = txt_path.stem + ".bin"  # stem是去掉后缀的文件名
    bin_path = output_dir / bin_name

    with open(bin_path, 'wb') as f:
        for line in lines:
            line = line.strip()
            if line == "" or line.startswith("memory"):
                continue
            # 二进制转hex
            hex_value = hex(int(line, 2))[2:]
            if len(hex_value) % 2 != 0:
                hex_value = "0" + hex_value
            # 字节反转
            reversed_hex = reverse_bytes(hex_value)
            # 补零到128bit
            padded_bytes = hex_to_padded_bytes(reversed_hex)
            f.write(padded_bytes)

    print("✓", txt_path, "->", bin_path)
    return True


def batch_txt_to_bin():
    txt_list = []
    for i in range(9):
        txt_list.append(OUTPUT_DIR / f"ifmp_layer1_{i}.txt")
    for txt in txt_list:
        process_txt_to_bin(txt, "./data")


# ==========================================================
# 主程序（调用新的预处理函数）
# ==========================================================
if __name__ == "__main__":
    image_file = "dog.jpg"

    print("Step1: 图像量化（无torchvision）")
    preprocess_image(image_file)  # 替换原preprocess_jpg_to_quantized_image

    print("Step2: ifmap -> TXT")
    process_ifmp("coe/ifmap.p")

    print("Step3: TXT -> BIN")
    batch_txt_to_bin()

    print("\n✓ 全流程完成")