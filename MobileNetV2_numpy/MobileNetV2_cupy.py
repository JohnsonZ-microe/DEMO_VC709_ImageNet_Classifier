# %%
import cupy as cp
import torchextractor as tx
import torchvision
from PIL import Image
from torchvision import transforms
import numpy as np

from conv_norm_dp_pw_M_V1_cupy import QuantizedConv2D_M, pw1_dw_pw2_M, short_cut_M


#%% input tensor quantization:
## ref:
# quantize_tensor的作用是将输入张量x进行量化处理，返回量化后的张量q_x、缩放因子scale和零点zero_point。
def quantize_tensor(x, num_bits=8):  #num_bits: 量化位数，默认为8位
    qmin = 0.  # 量化的最小值
    qmax = 2. ** num_bits - 1.  # 量化的最大值
    min_val, max_val = x.min(), x.max()  #取得x的最小值和最大值

    scale = (max_val - min_val) / (qmax - qmin) # 计算缩放因子scale

    initial_zero_point = qmin - min_val / scale  # 计算初始零点

    zero_point = 0# 将零点初始化为0
    # 确保零点在量化范围内。但是如果实际零点在量化范围外，将导致无法对齐零点。
    if initial_zero_point < qmin:
        zero_point = qmin
    elif initial_zero_point > qmax:
        zero_point = qmax
    else:
        zero_point = initial_zero_point

    # #print(zero_point)
    zero_point = int(zero_point)
    q_x = zero_point + x / scale
    q_x.clamp_(qmin, qmax).round_() # 将q_x限制在量化范围内，并四舍五入到最近的整数。clamp加上_的含义是直接修改q_x。
    q_x = q_x.round().byte() #byte是将q_x转换为无符号8位整数类型
    return q_x, scale, zero_point


def relu(x, x_zero):
    if len(x.shape) > 1:
        for i in range(x.shape[0]):
            relu(x[i], x_zero)
    elif len(x.shape) == 1:
        for i in range(x.shape[0]):
            if x[i] < x_zero:
                x[i] = x_zero

    return x

#%%
#########################################################################################
#####                   Processing of input image
#########################################################################################
# normalize函数是对图像进行归一化处理，将图像的像素值从0-255范围转换到0-1范围，并减去均值和除以标准差。
normalize = transforms.Normalize(mean=[0.485, 0.456, 0.406],
                                 std=[0.229, 0.224, 0.225])
# test_transform是一个组合变换，包括调整图像大小、中心裁剪、转换为张量和归一化。
# 具体来说，首先将图像调整为256x256大小，然后进行中心裁剪，裁剪出224x224的区域，最后将图像转换为张量并进行归一化处理。
test_transform = transforms.Compose([
    transforms.Resize(256),
    transforms.CenterCrop(224),
    transforms.ToTensor(),
    normalize, ])
# preprocess函数是对图像进行预处理，包括调整图像大小、中心裁剪、转换为张量和归一化。和test_transform完全相同。
preprocess = transforms.Compose([
    transforms.Resize(256),
    transforms.CenterCrop(224),
    transforms.ToTensor(),
    transforms.Normalize(mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225]),
])

# filename = "D:\Project_UM\MobileNet_VC709\MobileNet_pytorch\ILSVRC2012_val_00000293.jpg"
# Download an example image from the pytorch website
import urllib #urllib是Python内置的库，用于处理URL相关的操作
url, filename = ("https://github.com/pytorch/hub/raw/master/images/dog.jpg", "dog.jpg")
try: urllib.URLopener().retrieve(url, filename)  #先尝试用老方法下载，如果失败（比如在 Python3 环境），就用新方法下载。
except: urllib.request.urlretrieve(url, filename)

input_image = Image.open(filename) #打开图像
input_tensor = preprocess(input_image)#预处理图像
input_batch = input_tensor.unsqueeze(0) #增加一个维度，使其成为一个批次的图像。unsqueeze(0)是在第0维增加一个维度，变成 [1, C, H, W]，从而适配模型输入

#########################################################################################
#########################################################################################
#########################################################################################
# First we want to complete the inference by pytorch model, later we will compare it with the
# results gained by numpy model

#########################################################################################
####                        Torch Extractor
#########################################################################################


model_quantized = torchvision.models.quantization.mobilenet_v2(pretrained=True,
                                                               quantize=True).to('cpu')  # Load a quantized mobilenet_v2 model

model_quantized.eval()

#%% Visualization
import netron
import torch.onnx

path = 'mobilenetv2_quantized.pt'
torch.jit.save(torch.jit.script(model_quantized),path)
netron.start(path)
#%%
# add torchextractor, extract the intermediate result from each layer
model_quantized = tx.Extractor(model_quantized,
                               ["features.0.0", "features.1.conv.0", "features.1.conv.1", "features.2.conv.0",
                                "features.2.conv.1", "features.2.conv.2", "features.3.conv.0", "features.3.conv.1",
                                "features.3.conv.2", "features.3.skip_add.activation_post_process", 'features.4.conv.0',
                                'features.4.conv.1', 'features.4.conv.2', \
                                "features.5.conv.0", "features.5.conv.1", "features.5.conv.2",
                                "features.5.skip_add.activation_post_process", "features.6.conv.0", "features.6.conv.1",
                                "features.6.conv.2", "features.6.skip_add.activation_post_process", "features.7.conv.0",
                                "features.7.conv.1", "features.7.conv.2", \
                                "features.8.conv.0", "features.8.conv.1", "features.8.conv.2",
                                "features.8.skip_add.activation_post_process", "features.9.conv.0", "features.9.conv.1",
                                "features.9.conv.2", "features.9.skip_add.activation_post_process",
                                "features.10.conv.0", "features.10.conv.1", "features.10.conv.2",
                                "features.10.skip_add.activation_post_process", \
                                "features.11.conv.0", "features.11.conv.1", "features.11.conv.2", "features.12.conv.0",
                                "features.12.conv.1", "features.12.conv.2",
                                "features.12.skip_add.activation_post_process", "features.13.conv.0",
                                "features.13.conv.1", "features.13.conv.2",
                                "features.13.skip_add.activation_post_process", \
                                "features.14.conv.0", "features.14.conv.1", "features.14.conv.2", "features.15.conv.0",
                                "features.15.conv.1", "features.15.conv.2",
                                "features.15.skip_add.activation_post_process", "features.16.conv.0",
                                "features.16.conv.1", "features.16.conv.2",
                                "features.16.skip_add.activation_post_process", \
                                "features.17.conv.0", "features.17.conv.1", "features.17.conv.2", "features.18.0",
                                "classifier.1"])  # Capture of the ofmp

model_output, features = model_quantized(input_batch)  # Forward propagation

#%%
features_keys_list = list(features.keys())

#### --------------------------------------------------------- ####
###############     extract the model parameter    ################
#### --------------------------------------------------------- ####

output_scale_list = []
output_zero_list = []
output_fm_list = []

for i in range(len(features.keys())):
    output_scale_list.append(features[features_keys_list[i]].detach().q_scale())           ### the scale of the ith layer
    output_zero_list.append(features[features_keys_list[i]].detach().q_zero_point())          ### the zero_list of the ith layer
    output_fm_list.append(features[features_keys_list[i]].detach().int_repr().numpy()[0])      ### the output feature map of the ith layer

model_quantized = model_quantized.model
# #######################################################################################
# #######################################################################################
# #######################################################################################

M0_int_n_list = cp.load("M0_int_n_list.npy")
M0_SC_int_n_list = cp.load("M0_SC_int_n_list.npy")
M1_SC_int_n_list = cp.load("M1_SC_int_n_list.npy")

import pickle

with open("M1_list.pkl", 'rb') as f:
    M1_list = pickle.load(f)


#%%
#########################################################################################
####                      Numpy model  Layer1 to Layer53
#########################################################################################
#quantize the input image
# input_quantized, input_scale, input_zero = quantize_tensor(
#     input_batch)  # to quantize the input tensor and return an uint8 tensor, scale and zero point


def numpy_inference(input_tensor):
    """使用numpy实现量化MobileNetV2的前向传播"""
    # 转换为numpy并处理批次维度
    input_scale = 0.018657904118299484
    input_zero = cp.array(114).astype("uint8")
    input_batch = input_tensor.numpy()[0]
    input_batch = cp.asarray(input_batch)
    input_quantized = input_zero + input_batch / input_scale

    # %%
    # Layer1 inference
    # #print(" Layer 1 CONV inference start ")
    # #print(" Hierarchy configuration: FMin=224, Cin=3, Fmout=112, Cout=32, s=2")
    input_quantized = input_quantized
    # input_scale = input_scale                          # scale of the quantized input tensor
    input_scale = 0.018657904118299484
    # input_zero = cp.array(input_zero).astype("uint8")  # zero_point of the quantized input tensor
    input_zero = cp.array(114).astype("uint8")
    conv_module = model_quantized.features[0][0]
    weight_scale = conv_module.state_dict()["weight"].detach().q_scale()
    weight_zero = conv_module.state_dict()["weight"].detach().q_zero_point()
    weight_quantized = conv_module.state_dict()["weight"].detach().int_repr().numpy()
    bias = conv_module.state_dict()["bias"].detach().numpy()
    output_zero = output_zero_list[0]
    M0 = M0_int_n_list[0][0]
    n = M0_int_n_list[0][1]
    M1 = M1_list[0]
    kernel_size = 3
    stride = 2
    padding = 1
    ofm_size = 112
    conv_mode = 0

    output_scale = output_scale_list[0]
    M0_save = cp.round(2 ** 16 * input_scale * weight_scale / output_scale)
    M0_cal = cp.round(2 ** 16 * input_scale * weight_scale / output_scale)
    M0 = M0_cal

    # calculate the M0 and M1 value
    M1_save = M1
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")

    ofmp1 = QuantizedConv2D_M(input_zero, input_quantized, output_zero, weight_quantized, kernel_size, stride, padding,
                              ofm_size, M0, n, M1, conv_mode=0)
    ofmp1 = relu(ofmp1, output_zero_list[0])

    # #print(" Layer 1 inference finished ")
    # 
    # # %% Layer2 inference
    # #print(" Layer 2 DW inference start ")
    # #print(" hyperparameter: FMin=112, Cin=32, Fmout=112, Cout=32, s=1")
    input_quantized = ofmp1
    input_scale = output_scale_list[0]
    input_zero = output_zero_list[0]
    conv_module = model_quantized.features[1].conv[0][0]
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
    conv_mode = 1

    output_scale = output_scale_list[1]
    M0_save = int(M0)
    M0_cal = int(2 ** 16 * input_scale * weight_scale / output_scale)
    M1_save = M1
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")

    ofmp2 = QuantizedConv2D_M(input_zero, input_quantized, output_zero, weight_quantized, kernel_size, stride, padding,
                              ofm_size, M0, n, M1, conv_mode=1)
    ofmp2 = relu(ofmp2, output_zero_list[1])

    # #print(" Layer 2 inference finished ")
    # 
    # # %% Layer3 inference
    # #print(" Layer 3 PW inference start ")
    # #print(" Hierarchy configuration: FMin=112, Cin=32, Fmout=112, Cout=16, s=1")
    input_quantized = ofmp2
    input_scale = output_scale_list[1]
    input_zero = output_zero_list[1]
    conv_module = model_quantized.features[1].conv[1]
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
    conv_mode = 2

    output_scale = output_scale_list[2]
    M0_save = int(M0)
    M0_cal = int(2 ** 16 * input_scale * weight_scale / output_scale)
    M1_save = M1
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")

    ofmp3 = QuantizedConv2D_M(input_zero, input_quantized, output_zero, weight_quantized, kernel_size, stride, padding,
                              ofm_size, M0, n, M1, conv_mode=2)

    # #print(" Layer 3 inference finished ")
    # 
    # # %% Layer4 inference
    # #print(" Layer 4,5,6 PW_DW_PW Bottleneck with Expansion Layer inference start ")
    # #print(" Hierarchy configuration: PW1 FMin=112, Cin=16, Fmout=112, Cout=96, s=1")
    # #print(" Hierarchy configuration: DW1 FMin=112, Cin=96, Fmout=56, Cout=96, s=2")
    # #print(" Hierarchy configuration: PW2 FMin=56, Cin=96, Fmout=56, Cout=24, s=1")
    quantized_module_list = []
    quantized_module_list.append(model_quantized.features[2].conv[0][0])
    quantized_module_list.append(model_quantized.features[2].conv[1][0])
    quantized_module_list.append(model_quantized.features[2].conv[2])

    input_quantized = ofmp3
    input_scale_list = output_scale_list[2:5]
    input_zero_list = output_zero_list[2:5]

    ofmp_scale_list = output_scale_list[3:6]
    ofmp_zero_list = output_zero_list[3:6]

    weight_scale_list = []
    weight_zero_list = []
    weight_quantized_list = []
    bias_list = []

    M0 = []
    n = []
    M1 = []
    for i in range(3, 6):
        M0.append(M0_int_n_list[i][0])
        n.append(M0_int_n_list[i][1])
        M1.append(M1_list[i])

    for i in range(0, len(quantized_module_list)):
        module_keys = list(quantized_module_list[i].state_dict().keys())
        weight_scale_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().q_scale())
        weight_zero_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().q_zero_point())
        weight_quantized_list.append(
            quantized_module_list[i].state_dict()[module_keys[0]].detach().int_repr().numpy().astype("int32"))
        bias_list.append(quantized_module_list[i].state_dict()[module_keys[1]].detach().numpy())

    kernel_size_list = [1, 3, 1]
    stride_list = [1, 2, 1]
    padding_list = [0, 1, 0]
    ofm_size_list = [112, 56, 56]

    output_scale = output_scale_list[3]
    M0_save = int(M0[0])
    input_scale = input_scale_list[0]
    weight_scale = weight_scale_list[0]
    bias = bias_list[0]
    M0_cal = int(2 ** 16 * input_scale * weight_scale / output_scale)
    M1_save = M1[0]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")

    output_scale = output_scale_list[4]
    M0_save = int(M0[1])
    input_scale = input_scale_list[1]
    weight_scale = weight_scale_list[1]
    bias = bias_list[1]
    M0_cal = int(2 ** 16 * input_scale * weight_scale / output_scale)
    M1_save = M1[1]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")

    output_scale = output_scale_list[5]
    M0_save = int(M0[2])
    input_scale = input_scale_list[2]
    weight_scale = weight_scale_list[2]
    bias = bias_list[2]
    M0_cal = int(2 ** 16 * input_scale * weight_scale / output_scale)
    M1_save = M1[2]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")

    ofmp4, ofmp5, ofmp6 = pw1_dw_pw2_M(input_scale_list, input_zero_list, input_quantized, ofmp_scale_list,
                                       ofmp_zero_list,
                                       weight_scale_list, weight_zero_list, weight_quantized_list, bias_list,
                                       kernel_size_list, stride_list, padding_list, ofm_size_list, M0, n, M1)

    # #print(" Layer 4,5,6 PW_DW_PW Bottleneck with Expansion Layer inference finished ")
    # 
    # # %%
    # # Layer7 to Layer9
    # #print(" Layer 7,8,9 PW_DW_PW_SC Inverse Residual Block inference start ")
    # #print(" Hierarchy configuration: PW1 FMin=56, Cin=24, Fmout=56, Cout=114, s=1")
    # #print(" Hierarchy configuration: DW1 FMin=56, Cin=114, Fmout=56, Cout=114, s=1")
    # #print(" Hierarchy configuration: PW2 FMin=56, Cin=114, Fmout=56, Cout=24, s=1")
    quantized_module_list = []
    quantized_module_list.append(model_quantized.features[3].conv[0][0])
    quantized_module_list.append(model_quantized.features[3].conv[1][0])
    quantized_module_list.append(model_quantized.features[3].conv[2])

    input_quantized = ofmp6
    input_scale_list = output_scale_list[5:8]
    input_zero_list = output_zero_list[5:8]

    ofmp_scale_list = output_scale_list[6:9]
    ofmp_zero_list = output_zero_list[6:9]

    weight_scale_list = []
    weight_zero_list = []
    weight_quantized_list = []
    bias_list = []

    for i in range(0, len(quantized_module_list)):
        module_keys = list(quantized_module_list[i].state_dict().keys())
        weight_scale_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().q_scale())
        weight_zero_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().q_zero_point())
        weight_quantized_list.append(
            quantized_module_list[i].state_dict()[module_keys[0]].detach().int_repr().numpy().astype("int32"))
        bias_list.append(quantized_module_list[i].state_dict()[module_keys[1]].detach().numpy())

    kernel_size_list = [1, 3, 1]
    stride_list = [1, 1, 1]
    padding_list = [0, 1, 0]
    ofm_size_list = [56, 56, 56]

    M0 = []
    n = []
    M1 = []
    for i in range(6, 9):
        M0.append(M0_int_n_list[i][0])
        n.append(M0_int_n_list[i][1])
        M1.append(M1_list[i])

    output_scale = output_scale_list[6]
    M0_save = int(M0[0])
    input_scale = input_scale_list[0]
    weight_scale = weight_scale_list[0]
    bias = bias_list[0]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[0]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")

    output_scale = output_scale_list[7]
    M0_save = int(M0[1])
    input_scale = input_scale_list[1]
    weight_scale = weight_scale_list[1]
    bias = bias_list[1]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[1]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")

    output_scale = output_scale_list[8]
    M0_save = int(M0[2])
    input_scale = input_scale_list[2]
    weight_scale = weight_scale_list[2]
    bias = bias_list[2]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[2]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")

    ofmp7, ofmp8, ofmp9 = pw1_dw_pw2_M(input_scale_list, input_zero_list, input_quantized, ofmp_scale_list,
                                       ofmp_zero_list,
                                       weight_scale_list, weight_zero_list, weight_quantized_list, bias_list,
                                       kernel_size_list, stride_list, padding_list, ofm_size_list, M0, n, M1)

    # #print(" Layer 7,8,9 PW_DW_PW Bottleneck with Expansion Layer inference finished ")
    # # %%
    # # Layer9 Short Cut
    # #print(" Layer 9 Short Cut ")
    x = ofmp6
    x_s = output_scale_list[5]
    x_z = output_zero_list[5]
    Fx = ofmp9
    Fx_s = output_scale_list[8]
    Fx_z = output_zero_list[8]
    Sc_s = output_scale_list[9]
    Sc_z = output_zero_list[9]

    n1 = int(M0_SC_int_n_list[0][1])
    #####_int_n_list[0][1])
    output_scale = output_scale_list[9]
    M0_save = M0_SC_int_n_list[0][0]
    M0_cal = int(round(2 ** 16 * x_s / Sc_s))
    M1_save = M1_SC_int_n_list[0][0]
    M1_cal = cp.round(2 ** 16 * Fx_s / Sc_s).astype("int32")

    ofmp9 = short_cut_M(x, Fx, x_s, x_z, Fx_s, Fx_z, Sc_s, Sc_z, M0_save, M1_save, n1)

    # %%

    # Layer10 to Layer12
    # #print(" Layer 10,11,12 PW_DW_PW Bottleneck with Expansion Layer inference start ")
    # #print(" Hierarchy configuration: PW1 FMin=56, Cin=24, Fmout=56, Cout=144, s=1")
    # #print(" Hierarchy configuration: DW1 FMin=56, Cin=144, Fmout=28, Cout=144, s=2")
    # #print(" Hierarchy configuration: PW2 FMin=28, Cin=144, Fmout=28, Cout=32, s=1")
    quantized_module_list = []
    quantized_module_list.append(model_quantized.features[4].conv[0][0])
    quantized_module_list.append(model_quantized.features[4].conv[1][0])
    quantized_module_list.append(model_quantized.features[4].conv[2])

    input_quantized = ofmp9
    input_scale_list = output_scale_list[9:12]
    input_zero_list = output_zero_list[9:12]

    ofmp_scale_list = output_scale_list[10:13]
    ofmp_zero_list = output_zero_list[10:13]

    weight_scale_list = []
    weight_zero_list = []
    weight_quantized_list = []
    bias_list = []

    for i in range(0, len(quantized_module_list)):
        module_keys = list(quantized_module_list[i].state_dict().keys())
        weight_scale_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().q_scale())
        weight_zero_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().q_zero_point())
        weight_quantized_list.append(
            quantized_module_list[i].state_dict()[module_keys[0]].detach().int_repr().numpy().astype("int32"))
        bias_list.append(quantized_module_list[i].state_dict()[module_keys[1]].detach().numpy())

    kernel_size_list = [1, 3, 1]
    stride_list = [1, 2, 1]
    padding_list = [0, 1, 0]
    ofm_size_list = [56, 28, 28]

    M0 = []
    n = []
    M1 = []
    for i in range(9, 12):
        M0.append(M0_int_n_list[i][0])
        n.append(M0_int_n_list[i][1])
        M1.append(M1_list[i])

    output_scale = output_scale_list[10]
    M0_save = int(M0[0])
    input_scale = input_scale_list[0]
    weight_scale = weight_scale_list[0]
    bias = bias_list[0]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[0]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")

    output_scale = output_scale_list[11]
    M0_save = int(M0[1])
    input_scale = input_scale_list[1]
    weight_scale = weight_scale_list[1]
    bias = bias_list[1]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[1]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")

    output_scale = output_scale_list[12]
    M0_save = int(M0[2])
    input_scale = input_scale_list[2]
    weight_scale = weight_scale_list[2]
    bias = bias_list[2]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[2]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")

    ofmp10, ofmp11, ofmp12 = pw1_dw_pw2_M(input_scale_list, input_zero_list, input_quantized, ofmp_scale_list,
                                          ofmp_zero_list,
                                          weight_scale_list, weight_zero_list, weight_quantized_list, bias_list,
                                          kernel_size_list, stride_list, padding_list, ofm_size_list, M0, n, M1)

    # #print(" Layer 10,11,12 PW_DW_PW Bottleneck with Expansion Layer inference finished ")
    # # %%
    # 
    # # Layer13 to Layer15
    # #print(" Layer 13,14,15 PW_DW_PW_SC Inverse Residual Block inference start")
    # #print(" Hierarchy configuration: PW1 FMin=28, Cin=32, Fmout=28, Cout=192, s=1")
    # #print(" Hierarchy configuration: DW1 FMin=28, Cin=192, Fmout=28, Cout=192, s=1")
    # #print(" Hierarchy configuration: PW2 FMin=28, Cin=192, Fmout=28, Cout=32, s=1")
    quantized_module_list = []
    quantized_module_list.append(model_quantized.features[5].conv[0][0])
    quantized_module_list.append(model_quantized.features[5].conv[1][0])
    quantized_module_list.append(model_quantized.features[5].conv[2])

    input_quantized = ofmp12
    input_scale_list = output_scale_list[12:15]
    input_zero_list = output_zero_list[12:15]

    ofmp_scale_list = output_scale_list[13:16]
    ofmp_zero_list = output_zero_list[13:16]

    weight_scale_list = []
    weight_zero_list = []
    weight_quantized_list = []
    bias_list = []

    for i in range(0, len(quantized_module_list)):
        module_keys = list(quantized_module_list[i].state_dict().keys())
        weight_scale_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().q_scale())
        weight_zero_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().q_zero_point())
        weight_quantized_list.append(
            quantized_module_list[i].state_dict()[module_keys[0]].detach().int_repr().numpy().astype("int32"))
        bias_list.append(quantized_module_list[i].state_dict()[module_keys[1]].detach().numpy())

    kernel_size_list = [1, 3, 1]
    stride_list = [1, 1, 1]
    padding_list = [0, 1, 0]
    ofm_size_list = [28, 28, 28]

    M0 = []
    n = []
    M1 = []
    for i in range(12, 15):  # change
        M0.append(M0_int_n_list[i][0])
        n.append(M0_int_n_list[i][1])
        M1.append(M1_list[i])

    output_scale = output_scale_list[13]  # change
    M0_save = int(M0[0])
    input_scale = input_scale_list[0]
    weight_scale = weight_scale_list[0]
    bias = bias_list[0]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[0]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")

    output_scale = output_scale_list[14]  # change
    M0_save = int(M0[1])
    input_scale = input_scale_list[1]
    weight_scale = weight_scale_list[1]
    bias = bias_list[1]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[1]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")

    output_scale = output_scale_list[15]  # change
    M0_save = int(M0[2])
    input_scale = input_scale_list[2]
    weight_scale = weight_scale_list[2]
    bias = bias_list[2]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[2]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")

    ofmp13, ofmp14, ofmp15 = pw1_dw_pw2_M(input_scale_list, input_zero_list, input_quantized, ofmp_scale_list,
                                          ofmp_zero_list,
                                          weight_scale_list, weight_zero_list, weight_quantized_list, bias_list,
                                          kernel_size_list, stride_list, padding_list, ofm_size_list, M0, n, M1)

    # %%
    # Layer15 Short Cut
    # #print(" Layer 15 Short Cut ")
    x = ofmp12
    x_s = output_scale_list[12]
    x_z = output_zero_list[12]
    Fx = ofmp15
    Fx_s = output_scale_list[15]
    Fx_z = output_zero_list[15]
    Sc_s = output_scale_list[16]
    Sc_z = output_zero_list[16]

    n1 = int(M0_SC_int_n_list[1][1])  # change
    #####_int_n_list[1][1])# change
    output_scale = output_scale_list[16]  # change
    M0_save = M0_SC_int_n_list[1][0]  # change
    M0_cal = int(round(2 ** 16 * x_s / Sc_s))
    M1_save = M1_SC_int_n_list[1][0]  # change
    M1_cal = cp.round(2 ** 16 * Fx_s / Sc_s).astype("int32")

    ofmp15 = short_cut_M(x, Fx, x_s, x_z, Fx_s, Fx_z, Sc_s, Sc_z, M0_save, M1_save, n1)
    # 
    # #print(" Layer 13,14,15 PW_DW_PW Bottleneck with Expansion Layer inference finished ")
    # # %%
    # #print(" Layer 16,17,18 PW_DW_PW Bottleneck with Expansion Layer inference start")
    # #print(" Hierarchy configuration: PW1 FMin=28, Cin=32, Fmout=28, Cout=192, s=1")
    # #print(" Hierarchy configuration: DW1 FMin=28, Cin=192, Fmout=28, Cout=192, s=1")
    # #print(" Hierarchy configuration: PW2 FMin=28, Cin=192, Fmout=28, Cout=32, s=1")
    # Layer16 to Layer18
    quantized_module_list = []
    quantized_module_list.append(model_quantized.features[6].conv[0][0])
    quantized_module_list.append(model_quantized.features[6].conv[1][0])
    quantized_module_list.append(model_quantized.features[6].conv[2])

    input_quantized = ofmp15
    input_scale_list = output_scale_list[16:19]
    input_zero_list = output_zero_list[16:19]

    ofmp_scale_list = output_scale_list[17:20]
    ofmp_zero_list = output_zero_list[17:20]

    weight_scale_list = []
    weight_zero_list = []
    weight_quantized_list = []
    bias_list = []

    for i in range(0, len(quantized_module_list)):
        module_keys = list(quantized_module_list[i].state_dict().keys())
        weight_scale_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().q_scale())
        weight_zero_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().q_zero_point())
        weight_quantized_list.append(
            quantized_module_list[i].state_dict()[module_keys[0]].detach().int_repr().numpy().astype("int32"))
        bias_list.append(quantized_module_list[i].state_dict()[module_keys[1]].detach().numpy())

    kernel_size_list = [1, 3, 1]
    stride_list = [1, 1, 1]
    padding_list = [0, 1, 0]
    ofm_size_list = [28, 28, 28]

    M0 = []
    n = []
    M1 = []
    for i in range(15, 18):  # change
        M0.append(M0_int_n_list[i][0])
        n.append(M0_int_n_list[i][1])
        M1.append(M1_list[i])

    output_scale = output_scale_list[17]  # change
    M0_save = int(M0[0])
    input_scale = input_scale_list[0]
    weight_scale = weight_scale_list[0]
    bias = bias_list[0]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[0]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")

    output_scale = output_scale_list[18]  # change
    M0_save = int(M0[1])
    input_scale = input_scale_list[1]
    weight_scale = weight_scale_list[1]
    bias = bias_list[1]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[1]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")

    output_scale = output_scale_list[19]  # change
    M0_save = int(M0[2])
    input_scale = input_scale_list[2]
    weight_scale = weight_scale_list[2]
    bias = bias_list[2]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[2]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")

    ofmp16, ofmp17, ofmp18 = pw1_dw_pw2_M(input_scale_list, input_zero_list, input_quantized, ofmp_scale_list,
                                          ofmp_zero_list,
                                          weight_scale_list, weight_zero_list, weight_quantized_list, bias_list,
                                          kernel_size_list, stride_list, padding_list, ofm_size_list, M0, n, M1)

    # %%
    # Layer18 Short Cut
    # #print(" Layer 18 Short Cut ")
    x = ofmp15
    x_s = output_scale_list[16]
    x_z = output_zero_list[16]
    Fx = ofmp18
    Fx_s = output_scale_list[19]
    Fx_z = output_zero_list[19]
    Sc_s = output_scale_list[20]
    Sc_z = output_zero_list[20]

    n1 = int(M0_SC_int_n_list[2][1])  # change
    #####_int_n_list[2][1])# change
    output_scale = output_scale_list[20]  # change
    M0_save = M0_SC_int_n_list[2][0]  # change
    M0_cal = int(round(2 ** 16 * x_s / Sc_s))
    M1_save = M1_SC_int_n_list[2][0]  # change
    M1_cal = cp.round(2 ** 16 * Fx_s / Sc_s).astype("int32")

    # change
    ofmp18 = short_cut_M(x, Fx, x_s, x_z, Fx_s, Fx_z, Sc_s, Sc_z, M0_save, M1_save, n1)
    # #print(" Layer 16,17,18 PW_DW_PW Bottleneck with Expansion Layer inference finished ")
    # # %%
    # #print(" Layer 19,20,21 PW_DW_PW Bottleneck with Expansion Layer inference start")
    # #print(" Hierarchy configuration: PW1 FMin=28, Cin=32, Fmout=28, Cout=192, s=1")
    # #print(" Hierarchy configuration: DW1 FMin=28, Cin=192, Fmout=14, Cout=192, s=1")
    # #print(" Hierarchy configuration: PW2 FMin=14, Cin=192, Fmout=14, Cout=64, s=1")
    # Layer19 to Layer21
    quantized_module_list = []
    quantized_module_list.append(model_quantized.features[7].conv[0][0])
    quantized_module_list.append(model_quantized.features[7].conv[1][0])
    quantized_module_list.append(model_quantized.features[7].conv[2])

    input_quantized = ofmp18
    input_scale_list = output_scale_list[20:23]
    input_zero_list = output_zero_list[20:23]

    ofmp_scale_list = output_scale_list[21:24]
    ofmp_zero_list = output_zero_list[21:24]

    weight_scale_list = []
    weight_zero_list = []
    weight_quantized_list = []
    bias_list = []

    for i in range(0, len(quantized_module_list)):
        module_keys = list(quantized_module_list[i].state_dict().keys())
        weight_scale_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().q_scale())
        weight_zero_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().q_zero_point())
        weight_quantized_list.append(
            quantized_module_list[i].state_dict()[module_keys[0]].detach().int_repr().numpy().astype("int32"))
        bias_list.append(quantized_module_list[i].state_dict()[module_keys[1]].detach().numpy())

    kernel_size_list = [1, 3, 1]
    stride_list = [1, 2, 1]
    padding_list = [0, 1, 0]
    ofm_size_list = [28, 14, 14]

    M0 = []
    n = []
    M1 = []
    for i in range(18, 21):  # change
        M0.append(M0_int_n_list[i][0])
        n.append(M0_int_n_list[i][1])
        M1.append(M1_list[i])

    output_scale = output_scale_list[21]  # change
    M0_save = int(M0[0])
    input_scale = input_scale_list[0]
    weight_scale = weight_scale_list[0]
    bias = bias_list[0]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[0]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")

    output_scale = output_scale_list[22]  # change
    M0_save = int(M0[1])
    input_scale = input_scale_list[1]
    weight_scale = weight_scale_list[1]
    bias = bias_list[1]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[1]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")

    output_scale = output_scale_list[23]  # change
    M0_save = int(M0[2])
    input_scale = input_scale_list[2]
    weight_scale = weight_scale_list[2]
    bias = bias_list[2]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[2]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")

    ofmp19, ofmp20, ofmp21 = pw1_dw_pw2_M(input_scale_list, input_zero_list, input_quantized, ofmp_scale_list,
                                          ofmp_zero_list,
                                          weight_scale_list, weight_zero_list, weight_quantized_list, bias_list,
                                          kernel_size_list, stride_list, padding_list, ofm_size_list, M0, n, M1)

    # #print(" Layer 19,20,21 PW_DW_PW Bottleneck with Expansion Layer inference finished ")
    # %%

    # # Layer22 to Layer24
    # #print(" Layer 22,23,24 PW_DW_PW_SC Inverse Residual Block inference start")
    # #print(" Hierarchy configuration: PW1 FMin=14, Cin=64, Fmout=14, Cout=384, s=1")
    # #print(" Hierarchy configuration: DW1 FMin=14, Cin=384, Fmout=14, Cout=384, s=1")
    # #print(" Hierarchy configuration: PW2 FMin=14, Cin=384, Fmout=14, Cout=64, s=1")
    quantized_module_list = []
    quantized_module_list.append(model_quantized.features[8].conv[0][0])
    quantized_module_list.append(model_quantized.features[8].conv[1][0])
    quantized_module_list.append(model_quantized.features[8].conv[2])

    input_quantized = ofmp21
    input_scale_list = output_scale_list[23:26]
    input_zero_list = output_zero_list[23:26]

    ofmp_scale_list = output_scale_list[24:27]
    ofmp_zero_list = output_zero_list[24:27]

    weight_scale_list = []
    weight_zero_list = []
    weight_quantized_list = []
    bias_list = []

    for i in range(0, len(quantized_module_list)):
        module_keys = list(quantized_module_list[i].state_dict().keys())
        weight_scale_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().q_scale())
        weight_zero_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().q_zero_point())
        weight_quantized_list.append(
            quantized_module_list[i].state_dict()[module_keys[0]].detach().int_repr().numpy().astype("int32"))
        bias_list.append(quantized_module_list[i].state_dict()[module_keys[1]].detach().numpy())

    kernel_size_list = [1, 3, 1]
    stride_list = [1, 1, 1]
    padding_list = [0, 1, 0]
    ofm_size_list = [14, 14, 14]

    M0 = []
    n = []
    M1 = []
    for i in range(21, 24):  # change
        M0.append(M0_int_n_list[i][0])
        n.append(M0_int_n_list[i][1])
        M1.append(M1_list[i])

    output_scale = output_scale_list[24]  # change
    M0_save = int(M0[0])
    input_scale = input_scale_list[0]
    weight_scale = weight_scale_list[0]

    bias = bias_list[0]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[0]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")

    output_scale = output_scale_list[25]  # change
    M0_save = int(M0[1])
    input_scale = input_scale_list[1]
    weight_scale = weight_scale_list[1]
    bias = bias_list[1]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[1]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")

    output_scale = output_scale_list[26]  # change
    M0_save = int(M0[2])
    input_scale = input_scale_list[2]
    weight_scale = weight_scale_list[2]
    bias = bias_list[2]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[2]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")

    ofmp22, ofmp23, ofmp24 = pw1_dw_pw2_M(input_scale_list, input_zero_list, input_quantized, ofmp_scale_list,
                                          ofmp_zero_list,
                                          weight_scale_list, weight_zero_list, weight_quantized_list, bias_list,
                                          kernel_size_list, stride_list, padding_list, ofm_size_list, M0, n, M1)

    # %%
    # Layer24 Short Cut
    # #print(" Layer 24 Short Cut ")
    x = ofmp21
    x_s = output_scale_list[23]
    x_z = output_zero_list[23]
    Fx = ofmp24
    Fx_s = output_scale_list[26]
    Fx_z = output_zero_list[26]
    Sc_s = output_scale_list[27]
    Sc_z = output_zero_list[27]

    n1 = int(M0_SC_int_n_list[3][1])  # change
    #####_int_n_list[3][1])# change
    output_scale = output_scale_list[20]  # change
    M0_save = M0_SC_int_n_list[3][0]  # change
    M0_cal = int(round(2 ** 16 * x_s / Sc_s))
    M1_save = M1_SC_int_n_list[3][0]  # change
    M1_cal = cp.round(2 ** 16 * Fx_s / Sc_s).astype("int32")

    # change
    ofmp24 = short_cut_M(x, Fx, x_s, x_z, Fx_s, Fx_z, Sc_s, Sc_z, M0_save, M1_save, n1)
    # #print(" Layer 22,23,24  PW_DW_PW Bottleneck with Expansion Layer inference finished ")
    # # %%
    # # Layer25 to Layer27
    # #print(" Layer 25,26,27 PW_DW_PW_SC Inverse Residual Block inference start")
    # #print(" Hierarchy configuration: PW1 FMin=14, Cin=64, Fmout=14, Cout=384, s=1")
    # #print(" Hierarchy configuration: DW1 FMin=14, Cin=384, Fmout=14, Cout=384, s=1")
    # #print(" Hierarchy configuration: PW2 FMin=14, Cin=384, Fmout=14, Cout=64, s=1")
    quantized_module_list = []
    quantized_module_list.append(model_quantized.features[9].conv[0][0])
    quantized_module_list.append(model_quantized.features[9].conv[1][0])
    quantized_module_list.append(model_quantized.features[9].conv[2])

    input_quantized = ofmp24
    input_scale_list = output_scale_list[27:30]
    input_zero_list = output_zero_list[27:30]

    ofmp_scale_list = output_scale_list[28:31]
    ofmp_zero_list = output_zero_list[28:31]

    weight_scale_list = []
    weight_zero_list = []
    weight_quantized_list = []
    bias_list = []

    for i in range(0, len(quantized_module_list)):
        module_keys = list(quantized_module_list[i].state_dict().keys())
        weight_scale_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().q_scale())
        weight_zero_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().q_zero_point())
        weight_quantized_list.append(
            quantized_module_list[i].state_dict()[module_keys[0]].detach().int_repr().numpy().astype("int32"))
        bias_list.append(quantized_module_list[i].state_dict()[module_keys[1]].detach().numpy())

    kernel_size_list = [1, 3, 1]
    stride_list = [1, 1, 1]
    padding_list = [0, 1, 0]
    ofm_size_list = [14, 14, 14]

    M0 = []
    n = []
    M1 = []
    for i in range(24, 27):  # change
        M0.append(M0_int_n_list[i][0])
        n.append(M0_int_n_list[i][1])
        M1.append(M1_list[i])

    output_scale = output_scale_list[28]  # change
    M0_save = int(M0[0])
    input_scale = input_scale_list[0]
    weight_scale = weight_scale_list[0]

    bias = bias_list[0]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[0]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")

    output_scale = output_scale_list[29]  # change
    M0_save = int(M0[1])
    input_scale = input_scale_list[1]
    weight_scale = weight_scale_list[1]
    bias = bias_list[1]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[1]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")

    output_scale = output_scale_list[30]  # change
    M0_save = int(M0[2])
    input_scale = input_scale_list[2]
    weight_scale = weight_scale_list[2]
    bias = bias_list[2]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[2]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")

    ofmp25, ofmp26, ofmp27 = pw1_dw_pw2_M(input_scale_list, input_zero_list, input_quantized, ofmp_scale_list,
                                          ofmp_zero_list,
                                          weight_scale_list, weight_zero_list, weight_quantized_list, bias_list,
                                          kernel_size_list, stride_list, padding_list, ofm_size_list, M0, n, M1)

    '''
    out25_extract = output_fm_list[28]
    flag = cp.zeros(ofmp25.shape)
    for i in range(ofmp25.shape[0]):
        for j in range(ofmp25.shape[1]):
            for k in range(ofmp25.shape[2]):
                if (abs(ofmp25[i][j][k] - out25_extract[i][j][k]) <= 3):
                    flag[i][j][k] = 1

    #print(flag.sum() / (get_element_numbers(ofmp25)) * 100, '%'," of values are the same between the pytorch and numpy quantization schemes in layer 25")

    out26_extract = output_fm_list[29]
    flag = cp.zeros(ofmp26.shape)
    for i in range(ofmp26.shape[0]):
        for j in range(ofmp26.shape[1]):
            for k in range(ofmp26.shape[2]):
                if (abs(ofmp26[i][j][k] - out26_extract[i][j][k]) <= 3):
                    flag[i][j][k] = 1

    #print(flag.sum() / (get_element_numbers(ofmp26)) * 100, '%'," of values are the same between the pytorch and numpy quantization schemes in layer 26")

    out27_extract = output_fm_list[30]
    flag = cp.zeros(ofmp27.shape)
    for i in range(ofmp27.shape[0]):
        for j in range(ofmp27.shape[1]):
            for k in range(ofmp27.shape[2]):
                if (abs(ofmp27[i][j][k] - out27_extract[i][j][k]) <= 3):
                    flag[i][j][k] = 1

    #print(flag.sum() / (get_element_numbers(ofmp27)) * 100, '%'," of values are the same between the pytorch and numpy quantization schemes in layer 27")
    '''
    # %%
    # Layer27 Short Cut
    # #print(" Layer 27 Short Cut ")
    x = ofmp24
    x_s = output_scale_list[27]
    x_z = output_zero_list[27]
    Fx = ofmp27
    Fx_s = output_scale_list[30]
    Fx_z = output_zero_list[30]
    Sc_s = output_scale_list[31]
    Sc_z = output_zero_list[31]

    n1 = int(M0_SC_int_n_list[4][1])  # change
    #####_int_n_list[4][1])# change
    output_scale = output_scale_list[31]  # change
    M0_save = M0_SC_int_n_list[4][0]  # change
    M0_cal = int(round(2 ** 16 * x_s / Sc_s))
    M1_save = M1_SC_int_n_list[4][0]  # change
    M1_cal = cp.round(2 ** 16 * Fx_s / Sc_s).astype("int32")

    # change
    ofmp27 = short_cut_M(x, Fx, x_s, x_z, Fx_s, Fx_z, Sc_s, Sc_z, M0_save, M1_save, n1)
    #
    #
    # out27_sc_extract = output_fm_list[31]
    # flag = cp.zeros(ofmp27.shape)
    # for i in range(ofmp27.shape[0]):
    #     for j in range(ofmp27.shape[1]):
    #         for k in range(ofmp27.shape[2]):
    #             if (abs(ofmp27[i][j][k] - out27_sc_extract[i][j][k]) <= 3):
    #                 flag[i][j][k] = 1
    #
    # #print(flag.sum() / (get_element_numbers(ofmp27)) * 100, '%'," of values are the same between the pytorch and numpy quantization schemes after layer 24 shortcut")
    # #print(" Layer 25,26,27 PW_DW_PW Bottleneck with Expansion Layer inference finished ")
    # # %%
    # #print(" Layer 28,29,30 PW_DW_PW_SC Inverse Residual Block inference start")
    # #print(" Hierarchy configuration: PW1 FMin=14, Cin=64, Fmout=14, Cout=384, s=1")
    # #print(" Hierarchy configuration: DW1 FMin=14, Cin=384, Fmout=14, Cout=384, s=1")
    # #print(" Hierarchy configuration: PW2 FMin=14, Cin=384, Fmout=14, Cout=64, s=1")
    # Layer28 to Layer30
    quantized_module_list = []
    quantized_module_list.append(model_quantized.features[10].conv[0][0])
    quantized_module_list.append(model_quantized.features[10].conv[1][0])
    quantized_module_list.append(model_quantized.features[10].conv[2])

    input_quantized = ofmp27
    input_scale_list = output_scale_list[31:34]
    input_zero_list = output_zero_list[31:34]

    ofmp_scale_list = output_scale_list[32:35]
    ofmp_zero_list = output_zero_list[32:35]

    weight_scale_list = []
    weight_zero_list = []
    weight_quantized_list = []
    bias_list = []

    for i in range(0, len(quantized_module_list)):
        module_keys = list(quantized_module_list[i].state_dict().keys())
        weight_scale_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().q_scale())
        weight_zero_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().q_zero_point())
        weight_quantized_list.append(
            quantized_module_list[i].state_dict()[module_keys[0]].detach().int_repr().numpy().astype("int32"))
        bias_list.append(quantized_module_list[i].state_dict()[module_keys[1]].detach().numpy())

    kernel_size_list = [1, 3, 1]
    stride_list = [1, 1, 1]
    padding_list = [0, 1, 0]
    ofm_size_list = [14, 14, 14]

    M0 = []
    n = []
    M1 = []
    for i in range(27, 30):  # change
        M0.append(M0_int_n_list[i][0])
        n.append(M0_int_n_list[i][1])
        M1.append(M1_list[i])

    output_scale = output_scale_list[32]  # change
    M0_save = int(M0[0])
    input_scale = input_scale_list[0]
    weight_scale = weight_scale_list[0]

    bias = bias_list[0]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[0]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")

    output_scale = output_scale_list[33]  # change
    M0_save = int(M0[1])
    input_scale = input_scale_list[1]
    weight_scale = weight_scale_list[1]
    bias = bias_list[1]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[1]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")

    output_scale = output_scale_list[34]  # change
    M0_save = int(M0[2])
    input_scale = input_scale_list[2]
    weight_scale = weight_scale_list[2]
    bias = bias_list[2]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[2]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")

    ofmp28, ofmp29, ofmp30 = pw1_dw_pw2_M(input_scale_list, input_zero_list, input_quantized, ofmp_scale_list,
                                          ofmp_zero_list,
                                          weight_scale_list, weight_zero_list, weight_quantized_list, bias_list,
                                          kernel_size_list, stride_list, padding_list, ofm_size_list, M0, n, M1)

    #
    # out28_extract = output_fm_list[32]
    # flag = cp.zeros(ofmp28.shape)
    # for i in range(ofmp28.shape[0]):
    #     for j in range(ofmp28.shape[1]):
    #         for k in range(ofmp28.shape[2]):
    #             if (abs(ofmp28[i][j][k] - out28_extract[i][j][k]) <= 3):
    #                 flag[i][j][k] = 1
    #
    # #print(flag.sum() / (get_element_numbers(ofmp28)) * 100, '%'," of values are the same between the pytorch and numpy quantization schemes in layer 28")
    #
    # out29_extract = output_fm_list[33]
    # flag = cp.zeros(ofmp29.shape)
    # for i in range(ofmp29.shape[0]):
    #     for j in range(ofmp29.shape[1]):
    #         for k in range(ofmp29.shape[2]):
    #             if (abs(ofmp29[i][j][k] - out29_extract[i][j][k]) <= 3):
    #                 flag[i][j][k] = 1
    #
    # #print(flag.sum() / (get_element_numbers(ofmp29)) * 100, '%'," of values are the same between the pytorch and numpy quantization schemes in layer 29")
    #
    # out30_extract = output_fm_list[34]
    # flag = cp.zeros(ofmp30.shape)
    # for i in range(ofmp30.shape[0]):
    #     for j in range(ofmp30.shape[1]):
    #         for k in range(ofmp30.shape[2]):
    #             if (abs(ofmp30[i][j][k] - out30_extract[i][j][k]) <= 3):
    #                 flag[i][j][k] = 1
    #
    # #print(flag.sum() / (get_element_numbers(ofmp30)) * 100, '%'," of values are the same between the pytorch and numpy quantization schemes in layer 30")
    # #%%
    # Layer30 Short Cut
    #print(" Layer 30 Short Cut ")
    x = ofmp27
    x_s = output_scale_list[31]
    x_z = output_zero_list[31]
    Fx = ofmp30
    Fx_s = output_scale_list[34]
    Fx_z = output_zero_list[34]
    Sc_s = output_scale_list[35]
    Sc_z = output_zero_list[35]

    n1 = int(M0_SC_int_n_list[5][1])  # change
    #####_int_n_list[5][1])# change
    output_scale = output_scale_list[35]  # change
    M0_save = M0_SC_int_n_list[5][0]  # change
    M0_cal = int(round(2 ** 16 * x_s / Sc_s))
    M1_save = M1_SC_int_n_list[5][0]  # change
    M1_cal = cp.round(2 ** 16 * Fx_s / Sc_s).astype("int32")

    # change
    ofmp30 = short_cut_M(x, Fx, x_s, x_z, Fx_s, Fx_z, Sc_s, Sc_z, M0_save, M1_save, n1)

    # out30_sc_extract = output_fm_list[35]
    # flag = cp.zeros(ofmp30.shape)
    # for i in range(ofmp30.shape[0]):
    #     for j in range(ofmp30.shape[1]):
    #         for k in range(ofmp30.shape[2]):
    #             if (abs(ofmp30[i][j][k] - out30_sc_extract[i][j][k]) <= 3):
    #                 flag[i][j][k] = 1
    #
    # #print(flag.sum() / (get_element_numbers(ofmp30)) * 100, '%'," of values are the same between the pytorch and numpy quantization schemes after layer 30 shortcut")
    #print(" Layer 28,29,30 PW_DW_PW Bottleneck with Expansion Layer inference finished ")
    # %%
    #print(" Layer 31,32,33 PW_DW_PW Bottleneck with Expansion Layer inference start")
    #print(" Hierarchy configuration: PW1 FMin=14, Cin=64, Fmout=14, Cout=384, s=1")
    #print(" Hierarchy configuration: DW1 FMin=14, Cin=384, Fmout=14, Cout=384, s=1")
    #print(" Hierarchy configuration: PW2 FMin=14, Cin=384, Fmout=14, Cout=96, s=1")
    # Layer31 to Layer33
    quantized_module_list = []
    quantized_module_list.append(model_quantized.features[11].conv[0][0])
    quantized_module_list.append(model_quantized.features[11].conv[1][0])
    quantized_module_list.append(model_quantized.features[11].conv[2])

    input_quantized = ofmp30
    input_scale_list = output_scale_list[35:38]
    input_zero_list = output_zero_list[35:38]

    ofmp_scale_list = output_scale_list[36:39]
    ofmp_zero_list = output_zero_list[36:39]

    weight_scale_list = []
    weight_zero_list = []
    weight_quantized_list = []
    bias_list = []

    for i in range(0, len(quantized_module_list)):
        module_keys = list(quantized_module_list[i].state_dict().keys())
        weight_scale_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().q_scale())
        weight_zero_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().q_zero_point())
        weight_quantized_list.append(
            quantized_module_list[i].state_dict()[module_keys[0]].detach().int_repr().numpy().astype("int32"))
        bias_list.append(quantized_module_list[i].state_dict()[module_keys[1]].detach().numpy())

    kernel_size_list = [1, 3, 1]
    stride_list = [1, 1, 1]
    padding_list = [0, 1, 0]
    ofm_size_list = [14, 14, 14]

    M0 = []
    n = []
    M1 = []
    for i in range(30, 33):  # change
        M0.append(M0_int_n_list[i][0])
        n.append(M0_int_n_list[i][1])
        M1.append(M1_list[i])

    output_scale = output_scale_list[36]  # change
    M0_save = int(M0[0])
    input_scale = input_scale_list[0]
    weight_scale = weight_scale_list[0]

    bias = bias_list[0]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[0]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")

    output_scale = output_scale_list[37]  # change
    M0_save = int(M0[1])
    input_scale = input_scale_list[1]
    weight_scale = weight_scale_list[1]
    bias = bias_list[1]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[1]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")

    output_scale = output_scale_list[38]  # change
    M0_save = int(M0[2])
    input_scale = input_scale_list[2]
    weight_scale = weight_scale_list[2]
    bias = bias_list[2]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[2]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")

    ofmp31, ofmp32, ofmp33 = pw1_dw_pw2_M(input_scale_list, input_zero_list, input_quantized, ofmp_scale_list,
                                          ofmp_zero_list,
                                          weight_scale_list, weight_zero_list, weight_quantized_list, bias_list,
                                          kernel_size_list, stride_list, padding_list, ofm_size_list, M0, n, M1)

    # out31_extract = output_fm_list[36]
    # flag = cp.zeros(ofmp31.shape)
    # for i in range(ofmp31.shape[0]):
    #     for j in range(ofmp31.shape[1]):
    #         for k in range(ofmp31.shape[2]):
    #             if (abs(ofmp31[i][j][k] - out31_extract[i][j][k]) <= 3):
    #                 flag[i][j][k] = 1
    #
    # #print(flag.sum() / (get_element_numbers(ofmp31)) * 100, '%'," of values are the same between the pytorch and numpy quantization schemes in layer 31")
    #
    # out32_extract = output_fm_list[37]
    # flag = cp.zeros(ofmp32.shape)
    # for i in range(ofmp32.shape[0]):
    #     for j in range(ofmp32.shape[1]):
    #         for k in range(ofmp32.shape[2]):
    #             if (abs(ofmp32[i][j][k] - out32_extract[i][j][k]) <= 3):
    #                 flag[i][j][k] = 1
    #
    # #print(flag.sum() / (get_element_numbers(ofmp32)) * 100, '%'," of values are the same between the pytorch and numpy quantization schemes in layer 32")
    #
    # out33_extract = output_fm_list[38]
    # flag = cp.zeros(ofmp33.shape)
    # for i in range(ofmp33.shape[0]):
    #     for j in range(ofmp33.shape[1]):
    #         for k in range(ofmp33.shape[2]):
    #             if (abs(ofmp33[i][j][k] - out33_extract[i][j][k]) <= 3):
    #                 flag[i][j][k] = 1
    #
    # #print(flag.sum() / (get_element_numbers(ofmp33)) * 100, '%'," of values are the same between the pytorch and numpy quantization schemes in layer 33")
    #print(" Layer 31,32,33 PW_DW_PW Bottleneck with Expansion Layer inference finished ")
    # %%
    #print(" Layer 34,35,36 PW_DW_PW_SC Inverse Residual Block inference start")
    #print(" Hierarchy configuration: PW1 FMin=14, Cin=96, Fmout=14, Cout=576, s=1")
    #print(" Hierarchy configuration: DW1 FMin=14, Cin=576, Fmout=14, Cout=576, s=1")
    #print(" Hierarchy configuration: PW2 FMin=14, Cin=576, Fmout=14, Cout=96, s=1")
    # Layer34 to Layer36
    quantized_module_list = []
    quantized_module_list.append(model_quantized.features[12].conv[0][0])
    quantized_module_list.append(model_quantized.features[12].conv[1][0])
    quantized_module_list.append(model_quantized.features[12].conv[2])

    input_quantized = ofmp33
    input_scale_list = output_scale_list[38:41]
    input_zero_list = output_zero_list[38:41]

    ofmp_scale_list = output_scale_list[39:42]
    ofmp_zero_list = output_zero_list[39:42]

    weight_scale_list = []
    weight_zero_list = []
    weight_quantized_list = []
    bias_list = []

    for i in range(0, len(quantized_module_list)):
        module_keys = list(quantized_module_list[i].state_dict().keys())
        weight_scale_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().q_scale())
        weight_zero_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().q_zero_point())
        weight_quantized_list.append(
            quantized_module_list[i].state_dict()[module_keys[0]].detach().int_repr().numpy().astype("int32"))
        bias_list.append(quantized_module_list[i].state_dict()[module_keys[1]].detach().numpy())

    kernel_size_list = [1, 3, 1]
    stride_list = [1, 1, 1]
    padding_list = [0, 1, 0]
    ofm_size_list = [14, 14, 14]

    M0 = []
    n = []
    M1 = []
    for i in range(33, 36):  # change
        M0.append(M0_int_n_list[i][0])
        n.append(M0_int_n_list[i][1])
        M1.append(M1_list[i])

    output_scale = output_scale_list[39]  # change
    M0_save = int(M0[0])
    input_scale = input_scale_list[0]
    weight_scale = weight_scale_list[0]

    bias = bias_list[0]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[0]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")

    output_scale = output_scale_list[40]  # change
    M0_save = int(M0[1])
    input_scale = input_scale_list[1]
    weight_scale = weight_scale_list[1]
    bias = bias_list[1]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[1]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")

    output_scale = output_scale_list[41]  # change
    M0_save = int(M0[2])
    input_scale = input_scale_list[2]
    weight_scale = weight_scale_list[2]
    bias = bias_list[2]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[2]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")

    ofmp34, ofmp35, ofmp36 = pw1_dw_pw2_M(input_scale_list, input_zero_list, input_quantized, ofmp_scale_list,
                                          ofmp_zero_list,
                                          weight_scale_list, weight_zero_list, weight_quantized_list, bias_list,
                                          kernel_size_list, stride_list, padding_list, ofm_size_list, M0, n, M1)

    # out34_extract = output_fm_list[39]
    # flag = cp.zeros(ofmp34.shape)
    # for i in range(ofmp34.shape[0]):
    #     for j in range(ofmp34.shape[1]):
    #         for k in range(ofmp34.shape[2]):
    #             if (abs(ofmp34[i][j][k] - out34_extract[i][j][k]) <= 3):
    #                 flag[i][j][k] = 1
    #
    # #print(flag.sum() / (get_element_numbers(ofmp34)) * 100, '%'," of values are the same between the pytorch and numpy quantization schemes in layer 34")
    #
    # out35_extract = output_fm_list[40]
    # flag = cp.zeros(ofmp35.shape)
    # for i in range(ofmp35.shape[0]):
    #     for j in range(ofmp35.shape[1]):
    #         for k in range(ofmp35.shape[2]):
    #             if (abs(ofmp35[i][j][k] - out35_extract[i][j][k]) <= 3):
    #                 flag[i][j][k] = 1
    #
    # #print(flag.sum() / (get_element_numbers(ofmp35)) * 100, '%'," of values are the same between the pytorch and numpy quantization schemes in layer 35")
    #
    # out36_extract = output_fm_list[41]
    # flag = cp.zeros(ofmp36.shape)
    # for i in range(ofmp36.shape[0]):
    #     for j in range(ofmp36.shape[1]):
    #         for k in range(ofmp36.shape[2]):
    #             if (abs(ofmp36[i][j][k] - out36_extract[i][j][k]) <= 3):
    #                 flag[i][j][k] = 1
    #
    # #print(flag.sum() / (get_element_numbers(ofmp36)) * 100, '%'," of values are the same between the pytorch and numpy quantization schemes in layer 36")
    # #%%
    # Layer36 Short Cut
    #print(" Layer 36 Short Cut ")
    x = ofmp33
    x_s = output_scale_list[38]
    x_z = output_zero_list[38]
    Fx = ofmp36
    Fx_s = output_scale_list[41]
    Fx_z = output_zero_list[41]
    Sc_s = output_scale_list[42]
    Sc_z = output_zero_list[42]

    n1 = int(M0_SC_int_n_list[6][1])  # change
    #####_int_n_list[6][1])# change
    output_scale = output_scale_list[42]  # change
    M0_save = M0_SC_int_n_list[6][0]  # change
    M0_cal = int(round(2 ** 16 * x_s / Sc_s))
    M1_save = M1_SC_int_n_list[6][0]  # change
    M1_cal = cp.round(2 ** 16 * Fx_s / Sc_s).astype("int32")

    # change
    ofmp36 = short_cut_M(x, Fx, x_s, x_z, Fx_s, Fx_z, Sc_s, Sc_z, M0_save, M1_save, n1)

    # out36_sc_extract = output_fm_list[42]
    # flag = cp.zeros(ofmp36.shape)
    # for i in range(ofmp36.shape[0]):
    #     for j in range(ofmp36.shape[1]):
    #         for k in range(ofmp36.shape[2]):
    #             if (abs(ofmp36[i][j][k] - out36_sc_extract[i][j][k]) <= 3):
    #                 flag[i][j][k] = 1
    #
    # #print(flag.sum() / (get_element_numbers(ofmp36)) * 100, '%'," of values are the same between the pytorch and numpy quantization schemes after layer 36 shortcut")
    #print(" Layer 34,35,36 PW_DW_PW Bottleneck with Expansion Layer inference finished ")
    # %%

    # Layer37 to Layer39
    quantized_module_list = []
    quantized_module_list.append(model_quantized.features[13].conv[0][0])
    quantized_module_list.append(model_quantized.features[13].conv[1][0])
    quantized_module_list.append(model_quantized.features[13].conv[2])

    input_quantized = ofmp36
    input_scale_list = output_scale_list[42:45]
    input_zero_list = output_zero_list[42:45]

    ofmp_scale_list = output_scale_list[43:46]
    ofmp_zero_list = output_zero_list[43:46]

    weight_scale_list = []
    weight_zero_list = []
    weight_quantized_list = []
    bias_list = []

    for i in range(0, len(quantized_module_list)):
        module_keys = list(quantized_module_list[i].state_dict().keys())
        weight_scale_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().q_scale())
        weight_zero_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().q_zero_point())
        weight_quantized_list.append(
            quantized_module_list[i].state_dict()[module_keys[0]].detach().int_repr().numpy().astype("int32"))
        bias_list.append(quantized_module_list[i].state_dict()[module_keys[1]].detach().numpy())

    kernel_size_list = [1, 3, 1]
    stride_list = [1, 1, 1]
    padding_list = [0, 1, 0]
    ofm_size_list = [14, 14, 14]

    M0 = []
    n = []
    M1 = []
    for i in range(36, 39):  # change
        M0.append(M0_int_n_list[i][0])
        n.append(M0_int_n_list[i][1])
        M1.append(M1_list[i])

    output_scale = output_scale_list[43]  # change
    M0_save = int(M0[0])
    input_scale = input_scale_list[0]
    weight_scale = weight_scale_list[0]

    bias = bias_list[0]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[0]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")
    #print("M0 == M0_cal " + str(int(M0_save) == M0_cal))
    #print("M1 == M1_cal " + str(compare_2_numpy(M1_save, M1_cal)))
    #print(M0_cal)
    #print(M0_save)

    output_scale = output_scale_list[44]  # change
    M0_save = int(M0[1])
    input_scale = input_scale_list[1]
    weight_scale = weight_scale_list[1]
    bias = bias_list[1]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[1]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")
    #print("M0 == M0_cal " + str(int(M0_save) == M0_cal))
    #print("M1 == M1_cal " + str(compare_2_numpy(M1_save, M1_cal)))
    #print(M0_cal)

    output_scale = output_scale_list[45]  # change
    M0_save = int(M0[2])
    input_scale = input_scale_list[2]
    weight_scale = weight_scale_list[2]
    bias = bias_list[2]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[2]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")
    #print("M0 == M0_cal " + str(int(M0_save) == M0_cal))
    #print("M1 == M1_cal " + str(compare_2_numpy(M1_save, M1_cal)))
    #print(M0_cal)

    ofmp37, ofmp38, ofmp39 = pw1_dw_pw2_M(input_scale_list, input_zero_list, input_quantized, ofmp_scale_list,
                                          ofmp_zero_list,
                                          weight_scale_list, weight_zero_list, weight_quantized_list, bias_list,
                                          kernel_size_list, stride_list, padding_list, ofm_size_list, M0, n, M1)

    # out37_extract = output_fm_list[43]
    # flag = cp.zeros(ofmp37.shape)
    # for i in range(ofmp37.shape[0]):
    #     for j in range(ofmp37.shape[1]):
    #         for k in range(ofmp37.shape[2]):
    #             if (abs(ofmp37[i][j][k] - out37_extract[i][j][k]) <= 3):
    #                 flag[i][j][k] = 1
    #
    # #print(flag.sum() / (get_element_numbers(ofmp37)) * 100, '%')
    #
    # out38_extract = output_fm_list[44]
    # flag = cp.zeros(ofmp38.shape)
    # for i in range(ofmp38.shape[0]):
    #     for j in range(ofmp38.shape[1]):
    #         for k in range(ofmp38.shape[2]):
    #             if (abs(ofmp38[i][j][k] - out38_extract[i][j][k]) <= 3):
    #                 flag[i][j][k] = 1
    #
    # #print(flag.sum() / (get_element_numbers(ofmp38)) * 100, '%')
    #
    # out39_extract = output_fm_list[45]
    # flag = cp.zeros(ofmp39.shape)
    # for i in range(ofmp39.shape[0]):
    #     for j in range(ofmp39.shape[1]):
    #         for k in range(ofmp39.shape[2]):
    #             if (abs(ofmp39[i][j][k] - out39_extract[i][j][k]) <= 3):
    #                 flag[i][j][k] = 1
    #
    # #print(flag.sum() / (get_element_numbers(ofmp39)) * 100, '%')

    # %%

    # Layer39 Short Cut

    x = ofmp36
    x_s = output_scale_list[42]
    x_z = output_zero_list[42]
    Fx = ofmp39
    Fx_s = output_scale_list[45]
    Fx_z = output_zero_list[45]
    Sc_s = output_scale_list[46]
    Sc_z = output_zero_list[46]

    n1 = int(M0_SC_int_n_list[7][1])  # change
    #####_int_n_list[7][1])# change
    output_scale = output_scale_list[46]  # change
    M0_save = M0_SC_int_n_list[7][0]  # change
    M0_cal = int(round(2 ** 16 * x_s / Sc_s))
    M1_save = M1_SC_int_n_list[7][0]  # change
    M1_cal = cp.round(2 ** 16 * Fx_s / Sc_s).astype("int32")
    #print("M0 == M0_cal " + str(int(M0_save) == M0_cal))
    #print("M1 == M1_cal " + str(int(M1_save) == M1_cal))
    #print(M0_cal)

    # change
    ofmp39 = short_cut_M(x, Fx, x_s, x_z, Fx_s, Fx_z, Sc_s, Sc_z, M0_save, M1_save, n1)

    # out39_sc_extract = output_fm_list[46]
    # flag = cp.zeros(ofmp39.shape)
    # for i in range(ofmp39.shape[0]):
    #     for j in range(ofmp39.shape[1]):
    #         for k in range(ofmp39.shape[2]):
    #             if (abs(ofmp39[i][j][k] - out39_sc_extract[i][j][k]) <= 3):
    #                 flag[i][j][k] = 1
    #
    # #print(flag.sum() / (get_element_numbers(ofmp39)) * 100, '%')
    #print(" Layer 37,38,39 PW_DW_PW Bottleneck with Expansion Layer inference finished ")
    # %%

    # Layer40 to Layer42
    quantized_module_list = []
    quantized_module_list.append(model_quantized.features[14].conv[0][0])
    quantized_module_list.append(model_quantized.features[14].conv[1][0])
    quantized_module_list.append(model_quantized.features[14].conv[2])

    input_quantized = ofmp39
    input_scale_list = output_scale_list[46:49]
    input_zero_list = output_zero_list[46:49]

    ofmp_scale_list = output_scale_list[47:50]
    ofmp_zero_list = output_zero_list[47:50]

    weight_scale_list = []
    weight_zero_list = []
    weight_quantized_list = []
    bias_list = []

    for i in range(0, len(quantized_module_list)):
        module_keys = list(quantized_module_list[i].state_dict().keys())
        weight_scale_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().q_scale())
        weight_zero_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().q_zero_point())
        weight_quantized_list.append(
            quantized_module_list[i].state_dict()[module_keys[0]].detach().int_repr().numpy().astype("int32"))
        bias_list.append(quantized_module_list[i].state_dict()[module_keys[1]].detach().numpy())

    kernel_size_list = [1, 3, 1]
    stride_list = [1, 2, 1]
    padding_list = [0, 1, 0]
    ofm_size_list = [14, 7, 7]

    M0 = []
    n = []
    M1 = []
    for i in range(39, 42):  # change
        M0.append(M0_int_n_list[i][0])
        n.append(M0_int_n_list[i][1])
        M1.append(M1_list[i])

    output_scale = output_scale_list[47]  # change
    M0_save = int(M0[0])
    input_scale = input_scale_list[0]
    weight_scale = weight_scale_list[0]

    bias = bias_list[0]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[0]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")
    #print("M0 == M0_cal " + str(int(M0_save) == M0_cal))
    #print("M1 == M1_cal " + str(compare_2_numpy(M1_save, M1_cal)))
    #print(M0_cal)
    #print(M0_save)

    output_scale = output_scale_list[48]  # change
    M0_save = int(M0[1])
    input_scale = input_scale_list[1]
    weight_scale = weight_scale_list[1]
    bias = bias_list[1]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[1]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")
    #print("M0 == M0_cal " + str(int(M0_save) == M0_cal))
    #print("M1 == M1_cal " + str(compare_2_numpy(M1_save, M1_cal)))
    #print(M0_cal)

    output_scale = output_scale_list[49]  # change
    M0_save = int(M0[2])
    input_scale = input_scale_list[2]
    weight_scale = weight_scale_list[2]
    bias = bias_list[2]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[2]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")
    #print("M0 == M0_cal " + str(int(M0_save) == M0_cal))
    #print("M1 == M1_cal " + str(compare_2_numpy(M1_save, M1_cal)))
    #print(M0_cal)

    ofmp40, ofmp41, ofmp42 = pw1_dw_pw2_M(input_scale_list, input_zero_list, input_quantized, ofmp_scale_list,
                                          ofmp_zero_list,
                                          weight_scale_list, weight_zero_list, weight_quantized_list, bias_list,
                                          kernel_size_list, stride_list, padding_list, ofm_size_list, M0, n, M1)

    # out40_extract = output_fm_list[47]
    # flag = cp.zeros(ofmp40.shape)
    # for i in range(ofmp40.shape[0]):
    #     for j in range(ofmp40.shape[1]):
    #         for k in range(ofmp40.shape[2]):
    #             if (abs(ofmp40[i][j][k] - out40_extract[i][j][k]) <= 3):
    #                 flag[i][j][k] = 1
    #
    # #print(flag.sum() / (get_element_numbers(ofmp40)) * 100, '%')
    #
    # out41_extract = output_fm_list[48]
    # flag = cp.zeros(ofmp41.shape)
    # for i in range(ofmp41.shape[0]):
    #     for j in range(ofmp41.shape[1]):
    #         for k in range(ofmp41.shape[2]):
    #             if (abs(ofmp41[i][j][k] - out41_extract[i][j][k]) <= 3):
    #                 flag[i][j][k] = 1
    #
    # #print(flag.sum() / (get_element_numbers(ofmp41)) * 100, '%')
    #
    # out42_extract = output_fm_list[49]
    # flag = cp.zeros(ofmp42.shape)
    # for i in range(ofmp42.shape[0]):
    #     for j in range(ofmp42.shape[1]):
    #         for k in range(ofmp42.shape[2]):
    #             if (abs(ofmp42[i][j][k] - out42_extract[i][j][k]) <= 3):
    #                 flag[i][j][k] = 1
    #
    # #print(flag.sum() / (get_element_numbers(ofmp42)) * 100, '%')
    #print(" Layer 40,41,42 PW_DW_PW Bottleneck with Expansion Layer inference finished ")
    # %%

    # Layer43 to Layer45
    quantized_module_list = []
    quantized_module_list.append(model_quantized.features[15].conv[0][0])
    quantized_module_list.append(model_quantized.features[15].conv[1][0])
    quantized_module_list.append(model_quantized.features[15].conv[2])

    input_quantized = ofmp42
    input_scale_list = output_scale_list[49:52]
    input_zero_list = output_zero_list[49:52]

    ofmp_scale_list = output_scale_list[50:53]
    ofmp_zero_list = output_zero_list[50:53]

    weight_scale_list = []
    weight_zero_list = []
    weight_quantized_list = []
    bias_list = []

    for i in range(0, len(quantized_module_list)):
        module_keys = list(quantized_module_list[i].state_dict().keys())
        weight_scale_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().q_scale())
        weight_zero_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().q_zero_point())
        weight_quantized_list.append(
            quantized_module_list[i].state_dict()[module_keys[0]].detach().int_repr().numpy().astype("int32"))
        bias_list.append(quantized_module_list[i].state_dict()[module_keys[1]].detach().numpy())

    kernel_size_list = [1, 3, 1]
    stride_list = [1, 1, 1]
    padding_list = [0, 1, 0]
    ofm_size_list = [7, 7, 7]

    M0 = []
    n = []
    M1 = []
    for i in range(42, 45):  # change
        M0.append(M0_int_n_list[i][0])
        n.append(M0_int_n_list[i][1])
        M1.append(M1_list[i])

    output_scale = output_scale_list[50]  # change
    M0_save = int(M0[0])
    input_scale = input_scale_list[0]
    weight_scale = weight_scale_list[0]

    bias = bias_list[0]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[0]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")
    #print("M0 == M0_cal " + str(int(M0_save) == M0_cal))
    #print("M1 == M1_cal " + str(compare_2_numpy(M1_save, M1_cal)))
    #print(M0_cal)
    #print(M0_save)

    output_scale = output_scale_list[51]  # change
    M0_save = int(M0[1])
    input_scale = input_scale_list[1]
    weight_scale = weight_scale_list[1]
    bias = bias_list[1]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[1]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")
    #print("M0 == M0_cal " + str(int(M0_save) == M0_cal))
    #print("M1 == M1_cal " + str(compare_2_numpy(M1_save, M1_cal)))
    #print(M0_cal)

    output_scale = output_scale_list[52]  # change
    M0_save = int(M0[2])
    input_scale = input_scale_list[2]
    weight_scale = weight_scale_list[2]
    bias = bias_list[2]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[2]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")
    #print("M0 == M0_cal " + str(int(M0_save) == M0_cal))
    #print("M1 == M1_cal " + str(compare_2_numpy(M1_save, M1_cal)))
    #print(M0_cal)

    ofmp43, ofmp44, ofmp45 = pw1_dw_pw2_M(input_scale_list, input_zero_list, input_quantized, ofmp_scale_list,
                                          ofmp_zero_list,
                                          weight_scale_list, weight_zero_list, weight_quantized_list, bias_list,
                                          kernel_size_list, stride_list, padding_list, ofm_size_list, M0, n, M1)

    # out43_extract = output_fm_list[50]
    # flag = cp.zeros(ofmp43.shape)
    # for i in range(ofmp43.shape[0]):
    #     for j in range(ofmp43.shape[1]):
    #         for k in range(ofmp43.shape[2]):
    #             if (abs(ofmp43[i][j][k] - out43_extract[i][j][k]) <= 3):
    #                 flag[i][j][k] = 1
    #
    # #print(flag.sum() / (get_element_numbers(ofmp43)) * 100, '%')
    #
    # out44_extract = output_fm_list[51]
    # flag = cp.zeros(ofmp44.shape)
    # for i in range(ofmp44.shape[0]):
    #     for j in range(ofmp44.shape[1]):
    #         for k in range(ofmp44.shape[2]):
    #             if (abs(ofmp44[i][j][k] - out44_extract[i][j][k]) <= 3):
    #                 flag[i][j][k] = 1
    #
    # #print(flag.sum() / (get_element_numbers(ofmp44)) * 100, '%')
    #
    # out45_extract = output_fm_list[52]
    # flag = cp.zeros(ofmp45.shape)
    # for i in range(ofmp45.shape[0]):
    #     for j in range(ofmp45.shape[1]):
    #         for k in range(ofmp45.shape[2]):
    #             if (abs(ofmp45[i][j][k] - out45_extract[i][j][k]) <= 3):
    #                 flag[i][j][k] = 1
    #
    # #print(flag.sum() / (get_element_numbers(ofmp45)) * 100, '%')

    # %%

    # Layer45 Short Cut

    x = ofmp42
    x_s = output_scale_list[49]
    x_z = output_zero_list[49]
    Fx = ofmp45
    Fx_s = output_scale_list[52]
    Fx_z = output_zero_list[52]
    Sc_s = output_scale_list[53]
    Sc_z = output_zero_list[53]

    n1 = int(M0_SC_int_n_list[8][1])  # change
    #####_int_n_list[8][1])# change
    output_scale = output_scale_list[53]  # change
    M0_save = M0_SC_int_n_list[8][0]  # change
    M0_cal = int(round(2 ** 16 * x_s / Sc_s))
    M1_save = M1_SC_int_n_list[8][0]  # change
    M1_cal = cp.round(2 ** 16 * Fx_s / Sc_s).astype("int32")
    #print("M0 == M0_cal " + str(int(M0_save) == M0_cal))
    #print("M1 == M1_cal " + str(int(M1_save) == M1_cal))
    #print(M0_cal)

    # change
    ofmp45 = short_cut_M(x, Fx, x_s, x_z, Fx_s, Fx_z, Sc_s, Sc_z, M0_save, M1_save, n1)

    #
    # out45_sc_extract = output_fm_list[53]
    # flag = cp.zeros(ofmp45.shape)
    # for i in range(ofmp45.shape[0]):
    #     for j in range(ofmp45.shape[1]):
    #         for k in range(ofmp45.shape[2]):
    #             if (abs(ofmp45[i][j][k] - out45_sc_extract[i][j][k]) <= 3):
    #                 flag[i][j][k] = 1
    #
    # #print(flag.sum() / (get_element_numbers(ofmp45)) * 100, '%')
    #print(" Layer 43,44,45 PW_DW_PW Bottleneck with Expansion Layer inference finished ")
    # %%

    # Layer46 to Layer48
    quantized_module_list = []
    quantized_module_list.append(model_quantized.features[16].conv[0][0])
    quantized_module_list.append(model_quantized.features[16].conv[1][0])
    quantized_module_list.append(model_quantized.features[16].conv[2])

    input_quantized = ofmp45
    input_scale_list = output_scale_list[53:56]
    input_zero_list = output_zero_list[53:56]

    ofmp_scale_list = output_scale_list[54:57]
    ofmp_zero_list = output_zero_list[54:57]

    weight_scale_list = []
    weight_zero_list = []
    weight_quantized_list = []
    bias_list = []

    for i in range(0, len(quantized_module_list)):
        module_keys = list(quantized_module_list[i].state_dict().keys())
        weight_scale_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().q_scale())
        weight_zero_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().q_zero_point())
        weight_quantized_list.append(
            quantized_module_list[i].state_dict()[module_keys[0]].detach().int_repr().numpy().astype("int32"))
        bias_list.append(quantized_module_list[i].state_dict()[module_keys[1]].detach().numpy())

    kernel_size_list = [1, 3, 1]
    stride_list = [1, 1, 1]
    padding_list = [0, 1, 0]
    ofm_size_list = [7, 7, 7]

    M0 = []
    n = []
    M1 = []
    for i in range(45, 48):  # change
        M0.append(M0_int_n_list[i][0])
        n.append(M0_int_n_list[i][1])
        M1.append(M1_list[i])

    output_scale = output_scale_list[54]  # change
    M0_save = int(M0[0])
    input_scale = input_scale_list[0]
    weight_scale = weight_scale_list[0]

    bias = bias_list[0]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[0]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")
    #print("M0 == M0_cal " + str(int(M0_save) == M0_cal))
    #print("M1 == M1_cal " + str(compare_2_numpy(M1_save, M1_cal)))
    #print(M0_cal)
    #print(M0_save)

    output_scale = output_scale_list[55]  # change
    M0_save = int(M0[1])
    input_scale = input_scale_list[1]
    weight_scale = weight_scale_list[1]
    bias = bias_list[1]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[1]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")
    #print("M0 == M0_cal " + str(int(M0_save) == M0_cal))
    #print("M1 == M1_cal " + str(compare_2_numpy(M1_save, M1_cal)))
    #print(M0_cal)

    output_scale = output_scale_list[56]  # change
    M0_save = int(M0[2])
    input_scale = input_scale_list[2]
    weight_scale = weight_scale_list[2]
    bias = bias_list[2]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[2]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")
    #print("M0 == M0_cal " + str(int(M0_save) == M0_cal))
    #print("M1 == M1_cal " + str(compare_2_numpy(M1_save, M1_cal)))
    #print(M0_cal)

    ofmp46, ofmp47, ofmp48 = pw1_dw_pw2_M(input_scale_list, input_zero_list, input_quantized, ofmp_scale_list,
                                          ofmp_zero_list,
                                          weight_scale_list, weight_zero_list, weight_quantized_list, bias_list,
                                          kernel_size_list, stride_list, padding_list, ofm_size_list, M0, n, M1)

    # out46_extract = output_fm_list[54]
    # flag = cp.zeros(ofmp46.shape)
    # for i in range(ofmp46.shape[0]):
    #     for j in range(ofmp46.shape[1]):
    #         for k in range(ofmp46.shape[2]):
    #             if (abs(ofmp46[i][j][k] - out46_extract[i][j][k]) <= 3):
    #                 flag[i][j][k] = 1
    #
    # #print(flag.sum() / (get_element_numbers(ofmp46)) * 100, '%')
    #
    # out47_extract = output_fm_list[55]
    # flag = cp.zeros(ofmp47.shape)
    # for i in range(ofmp47.shape[0]):
    #     for j in range(ofmp47.shape[1]):
    #         for k in range(ofmp47.shape[2]):
    #             if (abs(ofmp47[i][j][k] - out47_extract[i][j][k]) <= 3):
    #                 flag[i][j][k] = 1
    #
    # #print(flag.sum() / (get_element_numbers(ofmp47)) * 100, '%')
    #
    # out48_extract = output_fm_list[56]
    # flag = cp.zeros(ofmp48.shape)
    # for i in range(ofmp48.shape[0]):
    #     for j in range(ofmp48.shape[1]):
    #         for k in range(ofmp48.shape[2]):
    #             if (abs(ofmp48[i][j][k] - out48_extract[i][j][k]) <= 3):
    #                 flag[i][j][k] = 1
    #
    # #print(flag.sum() / (get_element_numbers(ofmp48)) * 100, '%')

    # %%

    # Layer48 Short Cut

    x = ofmp45
    x_s = output_scale_list[53]
    x_z = output_zero_list[53]
    Fx = ofmp48
    Fx_s = output_scale_list[56]
    Fx_z = output_zero_list[56]
    Sc_s = output_scale_list[57]
    Sc_z = output_zero_list[57]

    n1 = int(M0_SC_int_n_list[9][1])  # change
    #####_int_n_list[9][1])# change
    output_scale = output_scale_list[57]  # change
    M0_save = M0_SC_int_n_list[9][0]  # change
    M0_cal = int(round(2 ** 16 * x_s / Sc_s))
    M1_save = M1_SC_int_n_list[9][0]  # change
    M1_cal = cp.round(2 ** 16 * Fx_s / Sc_s).astype("int32")
    #print("M0 == M0_cal " + str(int(M0_save) == M0_cal))
    #print("M1 == M1_cal " + str(int(M1_save) == M1_cal))
    #print(M0_cal)

    # change
    ofmp48 = short_cut_M(x, Fx, x_s, x_z, Fx_s, Fx_z, Sc_s, Sc_z, M0_save, M1_save, n1)

    # out48_sc_extract = output_fm_list[57]
    # flag = cp.zeros(ofmp48.shape)
    # for i in range(ofmp48.shape[0]):
    #     for j in range(ofmp48.shape[1]):
    #         for k in range(ofmp48.shape[2]):
    #             if (abs(ofmp48[i][j][k] - out48_sc_extract[i][j][k]) <= 3):
    #                 flag[i][j][k] = 1
    #
    # #print(flag.sum() / (get_element_numbers(ofmp48)) * 100, '%')
    #print(" Layer 46,47,48 PW_DW_PW Bottleneck with Expansion Layer inference finished ")
    # %%

    # Layer49 to Layer51
    quantized_module_list = []
    quantized_module_list.append(model_quantized.features[17].conv[0][0])
    quantized_module_list.append(model_quantized.features[17].conv[1][0])
    quantized_module_list.append(model_quantized.features[17].conv[2])

    input_quantized = ofmp48
    input_scale_list = output_scale_list[57:60]
    input_zero_list = output_zero_list[57:60]

    ofmp_scale_list = output_scale_list[58:61]
    ofmp_zero_list = output_zero_list[58:61]

    weight_scale_list = []
    weight_zero_list = []
    weight_quantized_list = []
    bias_list = []

    for i in range(0, len(quantized_module_list)):
        module_keys = list(quantized_module_list[i].state_dict().keys())
        weight_scale_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().q_scale())
        weight_zero_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().q_zero_point())
        weight_quantized_list.append(
            quantized_module_list[i].state_dict()[module_keys[0]].detach().int_repr().numpy().astype("int32"))
        bias_list.append(quantized_module_list[i].state_dict()[module_keys[1]].detach().numpy())

    kernel_size_list = [1, 3, 1]
    stride_list = [1, 1, 1]
    padding_list = [0, 1, 0]
    ofm_size_list = [7, 7, 7]

    M0 = []
    n = []
    M1 = []
    for i in range(48, 51):  # change
        M0.append(M0_int_n_list[i][0])
        n.append(M0_int_n_list[i][1])
        M1.append(M1_list[i])

    output_scale = output_scale_list[58]  # change
    M0_save = int(M0[0])
    input_scale = input_scale_list[0]
    weight_scale = weight_scale_list[0]

    bias = bias_list[0]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[0]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")
    #print("M0 == M0_cal " + str(int(M0_save) == M0_cal))
    #print("M1 == M1_cal " + str(compare_2_numpy(M1_save, M1_cal)))
    #print(M0_cal)
    #print(M0_save)

    output_scale = output_scale_list[59]  # change
    M0_save = int(M0[1])
    input_scale = input_scale_list[1]
    weight_scale = weight_scale_list[1]
    bias = bias_list[1]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[1]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")
    #print("M0 == M0_cal " + str(int(M0_save) == M0_cal))
    #print("M1 == M1_cal " + str(compare_2_numpy(M1_save, M1_cal)))
    #print(M0_cal)

    output_scale = output_scale_list[60]  # change
    M0_save = int(M0[2])
    input_scale = input_scale_list[2]
    weight_scale = weight_scale_list[2]
    bias = bias_list[2]
    M0_cal = int(round(2 ** 16 * input_scale * weight_scale / output_scale))
    M1_save = M1[2]
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")
    #print("M0 == M0_cal " + str(int(M0_save) == M0_cal))
    #print("M1 == M1_cal " + str(compare_2_numpy(M1_save, M1_cal)))
    #print(M0_cal)

    ofmp49, ofmp50, ofmp51 = pw1_dw_pw2_M(input_scale_list, input_zero_list, input_quantized, ofmp_scale_list,
                                          ofmp_zero_list,
                                          weight_scale_list, weight_zero_list, weight_quantized_list, bias_list,
                                          kernel_size_list, stride_list, padding_list, ofm_size_list, M0, n, M1)
    #
    # out49_extract = output_fm_list[58]
    # flag = cp.zeros(ofmp49.shape)
    # for i in range(ofmp49.shape[0]):
    #     for j in range(ofmp49.shape[1]):
    #         for k in range(ofmp49.shape[2]):
    #             if (abs(ofmp49[i][j][k] - out49_extract[i][j][k]) <= 3):
    #                 flag[i][j][k] = 1
    #
    # #print(flag.sum() / (get_element_numbers(ofmp49)) * 100, '%')
    #
    # out50_extract = output_fm_list[59]
    # flag = cp.zeros(ofmp50.shape)
    # for i in range(ofmp50.shape[0]):
    #     for j in range(ofmp50.shape[1]):
    #         for k in range(ofmp50.shape[2]):
    #             if (abs(ofmp50[i][j][k] - out50_extract[i][j][k]) <= 3):
    #                 flag[i][j][k] = 1
    #
    # #print(flag.sum() / (get_element_numbers(ofmp50)) * 100, '%')
    #
    # out51_extract = output_fm_list[60]
    # flag = cp.zeros(ofmp51.shape)
    # for i in range(ofmp51.shape[0]):
    #     for j in range(ofmp51.shape[1]):
    #         for k in range(ofmp51.shape[2]):
    #             if (abs(ofmp51[i][j][k] - out51_extract[i][j][k]) <= 3):
    #                 flag[i][j][k] = 1
    #
    # #print(flag.sum() / (get_element_numbers(ofmp51)) * 100, '%')

    #print(" Layer 49,50,51 PW_DW_PW Bottleneck with Expansion Layer inference finished ")
    # %%
    # Layer52
    input_scale = output_scale_list[60]
    input_zero = output_zero_list[60]
    input_quantized = ofmp51
    conv_module = model_quantized.features[18][0]
    weight_scale = conv_module.state_dict()["weight"].detach().q_scale()
    weight_zero = conv_module.state_dict()["weight"].detach().q_zero_point()
    weight_quantized = conv_module.state_dict()["weight"].detach().int_repr().numpy()
    bias = conv_module.state_dict()["bias"].detach().numpy()
    output_scale = output_scale_list[61]
    output_zero = output_zero_list[61]
    M0 = M0_int_n_list[51][0]
    n = M0_int_n_list[51][1]
    M1 = M1_list[51]
    kernel_size = 1
    stride = 1
    padding = 0
    ofm_size = 7
    conv_mode = 2

    M0_save = cp.round(M0)
    M0_cal = cp.round(2 ** 16 * input_scale * weight_scale / output_scale)
    M1_save = M1
    M1_cal = cp.round(2 ** 16 * bias / output_scale).astype("int32")
    #print("M0 == M0_cal " + str(M0_save == M0_cal))
    #print("M1 == M1_cal " + str(compare_2_numpy(M1_save, M1_cal)))

    ofmp52 = QuantizedConv2D_M(input_zero, input_quantized, output_zero, weight_quantized, kernel_size, stride, padding,
                               ofm_size, M0, n, M1, conv_mode=0)
    ofmp52 = relu(ofmp52, output_zero_list[61])

    # out52_extract = output_fm_list[61]
    # flag = cp.zeros(ofmp52.shape)
    # for i in range(ofmp52.shape[0]):
    #     for j in range(ofmp52.shape[1]):
    #         for k in range(ofmp52.shape[2]):
    #             if (abs(ofmp52[i][j][k] - out52_extract[i][j][k]) <= 3):
    #                 flag[i][j][k] = 1
    #
    # #print(flag.sum() / get_element_numbers(ofmp52) * 100, '%')
    #
    #print(" Layer 52  inference finished ")
    # %%

    # AVG_POOLING
    ofmp52_pooling = cp.zeros(len(ofmp52))
    for i in range(len(ofmp52)):
        # ofmp52_pooling[i] = (ofmp52[i].sum() / 49).astype("int32")
        ofmp52_pooling[i] = (ofmp52[i].sum() * 1337 / 256 / 256).astype("int32")

    # %%
    # Layer53
    input_scale = output_scale_list[61]
    input_zero = output_zero_list[61]
    conv_module = model_quantized.classifier[1]
    input_quantized = ofmp52_pooling

    # #print(conv_module.state_dict().keys())
    weight_quantized = conv_module.state_dict()["_packed_params._packed_params"][0].detach().int_repr().numpy()
    weight_zero = conv_module.state_dict()["_packed_params._packed_params"][0].detach().q_zero_point()
    weight_scale = conv_module.state_dict()["_packed_params._packed_params"][0].detach().q_scale()

    bias = conv_module.state_dict()["_packed_params._packed_params"][1].detach().numpy()

    output_scale = conv_module.state_dict()["scale"].numpy()
    output_zero = conv_module.state_dict()["zero_point"].numpy()

    output_1000 = cp.zeros(1000)

    M0 = M0_int_n_list[52][0]
    n = M0_int_n_list[52][1]
    M1 = M1_list[52]

    for i in range(1000):
        w_mul_x = cp.multiply(weight_quantized[i] - weight_zero, input_quantized - input_zero).sum()
        output_1000[i] = cp.round(
            (M0 * w_mul_x + M1[i]) * (2 ** (-n)) + output_zero)
    #print(" Layer 53 inference finished ")
    '''
    for i in range(1000):
        w_mul_x = cp.multiply(weight_quantized[i] - weight_zero, ofmp52_pooling - input_zero).sum()
        output_1000[i] = cp.round(weight_scale*input_scale/output_scale*w_mul_x + output_zero + bias[i]/output_scale)
    '''
    # %%
    #print(output_1000.argmax())
    output_scale = 0.15309934318065643
    output_zero = 75
    output_1000 = output_scale * (output_1000 - output_zero)

    # 返回logits
    return output_1000