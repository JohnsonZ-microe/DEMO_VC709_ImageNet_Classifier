# %%
import sys

import numpy as np
import torchvision
from torchvision import transforms
from PIL import Image
import torchextractor as tx
from conv_norm_dp_pw_M_V1 import QuantizedConv2D_M, pw1_dw_pw2_M, pw1_dw_pw2_M_cal, get_element_numbers, compare_2_numpy, short_cut_M
import torch
import xlsxwriter
# 导入相关库
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

    # print(zero_point)
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
# 写入指定文件

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
# import urllib #urllib是Python内置的库，用于处理URL相关的操作
# url, filename = ("https://github.com/pytorch/hub/raw/master/images/dog.jpg", "dog.jpg")
# try: urllib.URLopener().retrieve(url, filename)  #先尝试用老方法下载，如果失败（比如在 Python3 环境），就用新方法下载。
# except: urllib.request.urlretrieve(url, filename)
filename = "dog.jpg"
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

M0_int_n_list = np.load("M0_int_n_list.npy")
M0_SC_int_n_list = np.load("M0_SC_int_n_list.npy")
M1_SC_int_n_list = np.load("M1_SC_int_n_list.npy")

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

# input_scale = 0.018657904118299484
# input_zero = np.array(114).astype("uint8")
# input_scale = 0.018591291
# input_zero = np.array(113).astype("uint8")
input_scale = model_quantized.quant.scale.item()
input_zero = model_quantized.quant.zero_point.item()

input_batch = input_batch.detach().numpy()[0]
input_quantized = input_zero + input_batch / input_scale
input_quantized = np.round(input_quantized).astype("uint8")

#%%
# Layer1 inference
print(" Layer 1 CONV inference start ")
print(" Hierarchy configuration: FMin=224, Cin=3, Fmout=112, Cout=32, s=2")
input_quantized = input_quantized
# input_scale = input_scale                          # scale of the quantized input tensor
# input_scale = 0.018657904118299484
# input_zero = np.array(114).astype("uint8")
#input_scale = 0.018591291
#input_zero = np.array(113).astype("uint8")
# input_zero = np.array(input_zero).astype("uint8")  # zero_point of the quantized input tensor
conv_module = model_quantized.features[0][0]
weight_scale = conv_module.state_dict()["weight"].detach().q_scale()
weight_zero = conv_module.state_dict()["weight"].detach().q_zero_point()
weight_quantized = conv_module.state_dict()["weight"].detach().int_repr().numpy()
bias = conv_module.state_dict()["bias"].detach().numpy()
output_zero = output_zero_list[0]
n = M0_int_n_list[0][1]
kernel_size = 3
stride = 2
padding = 1
ofm_size = 112
conv_mode = 0

output_scale = output_scale_list[0]
M0_cal = np.round(2**16*input_scale*weight_scale/output_scale)
M0     = M0_cal
#calculate the M0 and M1 value
M1_cal = np.round(2**16*bias/output_scale).astype("int32")
M1 = M1_cal

# input_quantized_mean = np.mean(input_quantized)
# input_quantized_std = np.std(input_quantized)
#
# M1 = (M1_cal - input_quantized_mean) / input_quantized_std**2

ofmp1 = QuantizedConv2D_M(input_zero, input_quantized, output_zero, weight_quantized, kernel_size, stride, padding,
                          ofm_size, M0, n, M1, conv_mode=0)

# ofmp1_mean = np.mean(ofmp1)
# ofmp1_var = np.var(ofmp1)
#
# ofmp1 = (ofmp1 - ofmp1_mean) / ofmp1_var

ofmp1 = relu(ofmp1, output_zero_list[0])

ofmp1 = ofmp1.astype("uint8")
out1_extract = output_fm_list[0]
flag = np.zeros(ofmp1.shape)
for i in range(ofmp1.shape[0]):
    for j in range(ofmp1.shape[1]):
        for k in range(ofmp1.shape[2]):
            if (abs(ofmp1[i][j][k] - out1_extract[i][j][k]) == 0):
                flag[i][j][k] = 1
flag_2d = flag.reshape((flag.shape[0]*flag.shape[1]),-1)
np.savetxt("Layer1.csv", flag_2d, delimiter=",")
print(" Layer 1 inference finished ")
print(flag.sum() / get_element_numbers(ofmp1)* 100, '%'," of values are the same between the pytorch and numpy quantization schemes")

print(" Layer 2 DW inference start ")
print(" hyperparameter: FMin=112, Cin=32, Fmout=112, Cout=32, s=1")
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
M0_cal =  np.round(2**16*input_scale*weight_scale/output_scale)
M1_save = M1
M1_cal = np.round(2**16*bias/output_scale).astype("int32")

M0 = M0_cal
M1 = M1_cal
ofmp2 = QuantizedConv2D_M(input_zero, input_quantized, output_zero, weight_quantized, kernel_size, stride, padding,
                          ofm_size, M0, n, M1, conv_mode=1)
ofmp2 = relu(ofmp2, output_zero_list[1])

out2_extract = output_fm_list[1]
flag = np.zeros(ofmp2.shape)
for i in range(ofmp2.shape[0]):
    for j in range(ofmp2.shape[1]):
        for k in range(ofmp1.shape[2]):
            if (abs(ofmp2[i][j][k] - out2_extract[i][j][k]) == 0):
                flag[i][j][k] = 1

print(" Layer 2 inference finished ")
print(flag.sum() / get_element_numbers(ofmp2) * 100, '%'," of values are the same between the pytorch and numpy quantization schemes")

print(" Layer 3 PW inference start ")
print(" Hierarchy configuration: FMin=112, Cin=32, Fmout=112, Cout=16, s=1")
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
M0_cal = int(2**16*input_scale*weight_scale/output_scale)
M1_save = M1
M1_cal = np.round(2**16*bias/output_scale).astype("int32")

ofmp3 = QuantizedConv2D_M(input_zero, input_quantized, output_zero, weight_quantized, kernel_size, stride, padding,
                          ofm_size, M0, n, M1, conv_mode=2)



out3_extract = output_fm_list[2]
flag = np.zeros(ofmp3.shape)
for i in range(ofmp3.shape[0]):
    for j in range(ofmp3.shape[1]):
        for k in range(ofmp3.shape[2]):
            if (abs(ofmp3[i][j][k] - out3_extract[i][j][k]) == 0):
                flag[i][j][k] = 1

print(" Layer 3 inference finished ")
print(flag.sum() / get_element_numbers(ofmp3) * 100, '%'," of values are the same between the pytorch and numpy quantization schemes")
#%% Layer4 inference
print(" Layer 4,5,6 PW_DW_PW Bottleneck with Expansion Layer inference start ")
