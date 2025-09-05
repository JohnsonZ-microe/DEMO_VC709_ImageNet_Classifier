 # =============================================================================
# MobileNetV2 量化推理流程（Numpy实现）主文件
# -----------------------------------------------------------------------------
# 本文件实现了MobileNetV2的量化推理流程，包括输入图片的预处理、量化函数定义、
# 以及与PyTorch官方量化模型的对比等。适合用于理解量化推理的各个步骤。
# =============================================================================

# 导入必要的库
import numpy as np  # 用于数值计算
import torchvision  # PyTorch视觉库，包含模型和数据增强
from torchvision import transforms  # 图像预处理相关
from PIL import Image  # 图像读取与处理
import torchextractor as tx  # 用于提取PyTorch模型中间特征
from conv_norm_dp_pw_M_V1 import QuantizedConv2D_M, pw1_dw_pw2_M, pw1_dw_pw2_M_cal, get_element_numbers, compare_2_numpy, short_cut_M  # 自定义量化卷积等模块
import torch  # PyTorch主库

# ========== 输入张量量化相关函数 ==========

def quantize_tensor(x, num_bits=8):  
    """
    对输入张量x进行量化，默认8位
    返回量化后的张量、scale和zero_point
    """
    qmin = 0.
    qmax = 2. ** num_bits - 1.  # 量化后最大值
    min_val, max_val = x.min(), x.max()  # 获取最小最大值

    scale = (max_val - min_val) / (qmax - qmin)  # 计算缩放因子

    initial_zero_point = qmin - min_val / scale  # 初始零点

    zero_point = 0
    if initial_zero_point < qmin:
        zero_point = qmin
    elif initial_zero_point > qmax:
        zero_point = qmax
    else:
        zero_point = initial_zero_point

    # print(zero_point)
    zero_point = int(zero_point)  # 零点取整
    q_x = zero_point + x / scale  # 量化
    q_x.clamp_(qmin, qmax).round_()  # 限幅并四舍五入
    q_x = q_x.round().byte()  # 转为byte类型
    return q_x, scale, zero_point  # 返回量化结果

def relu(x, x_zero):
    """
    对输入x进行ReLU操作，x_zero为零点
    支持多维数组递归处理
    """
    if len(x.shape) > 1:
        for i in range(x.shape[0]):
            relu(x[i], x_zero)
    elif len(x.shape) == 1:
        for i in range(x.shape[0]):
            if x[i] < x_zero:
                x[i] = x_zero

    return x

# ========== 输入图片预处理相关 ==========

#########################################################################################
#####                   输入图片的处理流程
#########################################################################################

normalize = transforms.Normalize(mean=[0.485, 0.456, 0.406],
                                 std=[0.229, 0.224, 0.225])  # 标准化参数
test_transform = transforms.Compose([
    transforms.Resize(256),  # 调整图片大小
    transforms.CenterCrop(224),  # 中心裁剪
    transforms.ToTensor(),  # 转为Tensor
    normalize, ])  # 标准化

preprocess = transforms.Compose([
    transforms.Resize(256),
    transforms.CenterCrop(224),
    transforms.ToTensor(),
    transforms.Normalize(mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225]),
])

# filename = "D:\Project_UM\MobileNet_VC709\MobileNet_pytorch\ILSVRC2012_val_00000293.jpg"
# 下载示例图片
import urllib
url, filename = ("https://github.com/pytorch/hub/raw/master/images/dog.jpg", "dog.jpg")
try: urllib.URLopener().retrieve(url, filename)  # Python2方式
except: urllib.request.urlretrieve(url, filename)  # Python3方式

input_image = Image.open(filename)  # 打开图片
input_tensor = preprocess(input_image)  # 预处理
input_batch = input_tensor.unsqueeze(0)  # 增加batch维度

#########################################################################################
# 首先用PyTorch官方模型完成推理，后续与Numpy模型结果对比
#########################################################################################

#########################################################################################
####                        Torch Extractor
#########################################################################################

model_quantized = torchvision.models.quantization.mobilenet_v2(pretrained=True,
                                                               quantize=True).to('cpu')  # 加载官方量化模型

model_quantized.eval()  # 设置为推理模式

# ========== 可视化相关 ==========
import netron  # 用于网络结构可视化
import torch.onnx  # 用于ONNX导出

path = 'mobilenetv2_quantized.pt'  # 保存模型的路径

torch.jit.save(torch.jit.script(model_quantized), path)  # 保存量化模型为TorchScript格式
netron.start(path)  # 用Netron可视化模型结构

# ========== 添加torchextractor，提取每层中间特征 ==========

model_quantized = tx.Extractor(
    model_quantized,
    [
        # 下面是需要提取特征的各层名称（MobileNetV2的各个卷积/跳连/分类层）
        "features.0.0", "features.1.conv.0", "features.1.conv.1", "features.2.conv.0",
        "features.2.conv.1", "features.2.conv.2", "features.3.conv.0", "features.3.conv.1",
        "features.3.conv.2", "features.3.skip_add.activation_post_process", 'features.4.conv.0',
        'features.4.conv.1', 'features.4.conv.2',
        "features.5.conv.0", "features.5.conv.1", "features.5.conv.2",
        "features.5.skip_add.activation_post_process", "features.6.conv.0", "features.6.conv.1",
        "features.6.conv.2", "features.6.skip_add.activation_post_process", "features.7.conv.0",
        "features.7.conv.1", "features.7.conv.2",
        "features.8.conv.0", "features.8.conv.1", "features.8.conv.2",
        "features.8.skip_add.activation_post_process", "features.9.conv.0", "features.9.conv.1",
        "features.9.conv.2", "features.9.skip_add.activation_post_process",
        "features.10.conv.0", "features.10.conv.1", "features.10.conv.2",
        "features.10.skip_add.activation_post_process",
        "features.11.conv.0", "features.11.conv.1", "features.11.conv.2", "features.12.conv.0",
        "features.12.conv.1", "features.12.conv.2",
        "features.12.skip_add.activation_post_process", "features.13.conv.0",
        "features.13.conv.1", "features.13.conv.2",
        "features.13.skip_add.activation_post_process",
        "features.14.conv.0", "features.14.conv.1", "features.14.conv.2", "features.15.conv.0",
        "features.15.conv.1", "features.15.conv.2",
        "features.15.skip_add.activation_post_process", "features.16.conv.0",
        "features.16.conv.1", "features.16.conv.2",
        "features.16.skip_add.activation_post_process",
        "features.17.conv.0", "features.17.conv.1", "features.17.conv.2", "features.18.0",
        "classifier.1"
    ]
)  # 捕获各层输出

model_output, features = model_quantized(input_batch)  # 前向传播，获得输出和中间特征

# ========== 提取各层输出的量化参数和特征图 ==========

features_keys_list = list(features.keys())  # 获取所有特征层的名称

output_scale_list = []  # 各层输出的scale
output_zero_list = []   # 各层输出的zero_point
output_fm_list = []     # 各层输出的特征图

for i in range(len(features.keys())):
    output_scale_list.append(features[features_keys_list[i]].detach().q_scale())           # 第i层的scale
    output_zero_list.append(features[features_keys_list[i]].detach().q_zero_point())       # 第i层的zero_point
    output_fm_list.append(features[features_keys_list[i]].detach().int_repr().numpy()[0])  # 第i层的量化特征图

model_quantized = model_quantized.model  # 还原为原始模型

# ========== 读取量化参数表和辅助数据 ==========

M0_int_n_list = np.load("M0_int_n_list.npy")  # 量化乘法参数M0
M0_SC_int_n_list = np.load("M0_SC_int_n_list.npy")  # shortcut分支M0
M1_SC_int_n_list = np.load("M1_SC_int_n_list.npy")  # shortcut分支M1

import pickle

with open("M1_list.pkl", 'rb') as f:
    M1_list = pickle.load(f)  # 读取主分支M1参数

# ========== Numpy实现的Layer1到Layer53推理 ==========

#########################################################################################
####                      Numpy模型 Layer1到Layer53
#########################################################################################

# 对输入图片进行量化
# input_quantized, input_scale, input_zero = quantize_tensor(
#     input_batch)  # 量化输入张量，返回uint8张量、scale和zero_point
input_scale = 0.018657904118299484  # 直接指定输入scale
input_zero = np.array(114).astype("uint8")  # 直接指定输入zero_point
input_batch = input_batch.detach().numpy()[0]  # 转为numpy格式
input_quantized = input_zero + input_batch / input_scale  # 量化输入

# ========== Layer1前向推理 ==========

print(" Layer 1 CONV inference start ")
print(" Hierarchy configuration: FMin=224, Cin=3, Fmout=112, Cout=32, s=2")
input_quantized = input_quantized
# input_scale = input_scale                          # 量化输入的scale
input_scale = 0.018657904118299484 
# input_zero = np.array(input_zero).astype("uint8")  # 量化输入的zero_point
input_zero = np.array(114).astype("uint8") 
conv_module = model_quantized.features[0][0]  # 获取第1层卷积模块
weight_scale = conv_module.state_dict()["weight"].detach().q_scale()  # 权重量化scale
weight_zero = conv_module.state_dict()["weight"].detach().q_zero_point()  # 权重量化zero_point
weight_quantized = conv_module.state_dict()["weight"].detach().int_repr().numpy()  # 权重量化值
bias = conv_module.state_dict()["bias"].detach().numpy()  # 偏置
output_zero = output_zero_list[0]  # 输出zero_point
M0 = M0_int_n_list[0][0]  # 量化乘法参数M0
n = M0_int_n_list[0][1]   # 量化乘法参数n
M1 = M1_list[0]           # 量化乘法参数M1
kernel_size = 3
stride = 2
padding = 1
ofm_size = 112
conv_mode = 0

# ========== Layer1输出后处理与对比 ==========

output_scale = output_scale_list[0]  # 第1层输出的scale
M0_save = np.round(2**16*input_scale*weight_scale/output_scale)  # 计算M0（保存用）
M0_cal = np.round(2**16*input_scale*weight_scale/output_scale)   # 计算M0（实际用）
M0     = M0_cal  # 赋值

# 计算M1参数
M1_save = M1
M1_cal = np.round(2**16*bias/output_scale).astype("int32")  # 量化偏置

# 调用自定义量化卷积函数，完成Layer1前向推理
ofmp1 = QuantizedConv2D_M(
    input_zero, input_quantized, output_zero, weight_quantized, kernel_size, stride, padding,
    ofm_size, M0, n, M1, conv_mode=0
)
ofmp1 = relu(ofmp1, output_zero_list[0])  # 经过ReLU激活

out1_extract = output_fm_list[0]  # PyTorch模型的第1层输出
flag = np.zeros(ofmp1.shape)  # 用于统计一致性
for i in range(ofmp1.shape[0]):
    for j in range(ofmp1.shape[1]):
        for k in range(ofmp1.shape[2]):
            if (abs(ofmp1[i][j][k] - out1_extract[i][j][k]) <= 3):  # 误差容忍3
                flag[i][j][k] = 1

print(" Layer 1 inference finished ")
print(flag.sum() / (112 * 112 * 32) * 100, '%', " of values are the same between the pytorch and numpy quantization schemes")

# ========== Layer2 深度可分离卷积 ==========

print(" Layer 2 DW inference start ")
print(" hyperparameter: FMin=112, Cin=32, Fmout=112, Cout=32, s=1")
input_quantized = ofmp1  # 上一层输出作为输入
input_scale = output_scale_list[0]
input_zero = output_zero_list[0]
conv_module = model_quantized.features[1].conv[0][0]  # 获取第2层DW卷积
weight_scale = conv_module.state_dict()["weight"].detach().q_scale()
weight_zero = conv_module.state_dict()["weight"].detach().q_zero_point()
weight_quantized = conv_module.state_dict()["weight"].detach().int_repr().numpy()
bias = conv_module.state_dict()["bias"].detach().numpy()
output_zero = output_zero_list[1]
M0 = M0_int_n_list[1][0]
n = M0_int_n_list[1][1]
M1 = M1_list[1]
kernel_size = 3
stride = 1
padding = 1
ofm_size = 112
conv_mode = 1  # 深度可分离卷积

output_scale = output_scale_list[1]
M0_save = int(M0)
M0_cal = int(2**16*input_scale*weight_scale/output_scale)
M1_save = M1
M1_cal = np.round(2**16*bias/output_scale).astype("int32")

ofmp2 = QuantizedConv2D_M(
    input_zero, input_quantized, output_zero, weight_quantized, kernel_size, stride, padding,
    ofm_size, M0, n, M1, conv_mode=1
)
ofmp2 = relu(ofmp2, output_zero_list[1])

out2_extract = output_fm_list[1]
flag = np.zeros(ofmp2.shape)
for i in range(ofmp2.shape[0]):
    for j in range(ofmp2.shape[1]):
        for k in range(ofmp1.shape[2]):
            if (abs(ofmp2[i][j][k] - out2_extract[i][j][k]) <= 3):
                flag[i][j][k] = 1

print(" Layer 2 inference finished ")
print(flag.sum() / (112 * 112 * 32) * 100, '%', " of values are the same between the pytorch and numpy quantization schemes")

# ========== Layer3 逐点卷积 ==========

print(" Layer 3 PW inference start ")
print(" Hierarchy configuration: FMin=112, Cin=32, Fmout=112, Cout=16, s=1")
input_quantized = ofmp2
input_scale = output_scale_list[1]
input_zero = output_zero_list[1]
conv_module = model_quantized.features[1].conv[1]  # 获取第3层PW卷积
weight_scale = conv_module.state_dict()["weight"].detach().q_scale()
weight_zero = conv_module.state_dict()["weight"].detach().q_zero_point()
weight_quantized = conv_module.state_dict()["weight"].detach().int_repr().numpy()
bias = conv_module.state_dict()["bias"].detach().numpy()
output_zero = output_zero_list[2]
M0 = M0_int_n_list[2][0]
n = M0_int_n_list[2][1]
M1 = M1_list[2]
kernel_size = 1
stride = 1
padding = 0
ofm_size = 112
conv_mode = 2  # 逐点卷积

output_scale = output_scale_list[2]
M0_save = int(M0)
M0_cal = int(2**16*input_scale*weight_scale/output_scale)
M1_save = M1
M1_cal = np.round(2**16*bias/output_scale).astype("int32")

ofmp3 = QuantizedConv2D_M(
    input_zero, input_quantized, output_zero, weight_quantized, kernel_size, stride, padding,
    ofm_size, M0, n, M1, conv_mode=2
)