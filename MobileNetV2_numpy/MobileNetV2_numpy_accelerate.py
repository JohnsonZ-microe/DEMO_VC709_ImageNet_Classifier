import sys
import numpy as np
import torchvision
from torchvision import transforms
from PIL import Image
import torchextractor as tx
from conv_accelerate import QuantizedConv2D_M, pw1_dw_pw2_M, get_element_numbers, compare_2_numpy, short_cut_M
import torch
import xlsxwriter
import pandas as pd


# 辅助函数：将整数转换为指定位数的二进制字符串（小端存储）
def int_to_bin(value, bits=8):
    """将整数转换为指定位数的二进制字符串，采用小端存储"""
    # 处理负数（补码表示）
    if value < 0:
        value = (1 << bits) + value
    # 转换为二进制并补零
    bin_str = bin(value)[2:].zfill(bits)
    # 小端存储（反转比特顺序）
    return bin_str[::-1]


# 初始化参数输出文件
param_file = open("layer_parameters.txt", "w")


# 导入相关库
def relu(x, x_zero):
    # x: ndarray, x_zero: 标量
    np.maximum(x, x_zero, out=x)   # 原地操作
    return x


# %%
#########################################################################################
#####                   Processing of input image
#########################################################################################
# normalize函数是对图像进行归一化处理，将图像的像素值从0-255范围转换到0-1范围，并减去均值和除以标准差。
normalize = transforms.Normalize(mean=[0.485, 0.456, 0.406],
                                 std=[0.229, 0.224, 0.225])
# test_transform是一个组合变换，包括调整图像大小、中心裁剪、转换为张量和归一化。
test_transform = transforms.Compose([
    transforms.Resize(256),
    transforms.CenterCrop(224),
    transforms.ToTensor(),
    normalize, ])
# preprocess函数和test_transform完全相同
preprocess = transforms.Compose([
    transforms.Resize(256),
    transforms.CenterCrop(224),
    transforms.ToTensor(),
    transforms.Normalize(mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225]),
])

filename = "dog.jpg"
input_image = Image.open(filename)  # 打开图像
input_tensor = preprocess(input_image)  # 预处理图像
input_batch = input_tensor.unsqueeze(0)  # 增加一个维度，使其成为一个批次的图像
ofmp = [0] * 54
#########################################################################################
#########################################################################################
#########################################################################################

#########################################################################################
####                        Torch Extractor
#########################################################################################


model_quantized = torchvision.models.quantization.mobilenet_v2(pretrained=True,
                                                               quantize=True).to('cpu')  # 加载量化的mobilenet_v2模型

model_quantized.eval()
# %% Visualization
import netron
import torch.onnx

path = 'mobilenetv2_quantized.pt'
torch.jit.save(torch.jit.script(model_quantized), path)
# netron.start(path)
# %%
# 添加torchextractor，提取每个层的中间结果
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
                                "classifier.1"])  # 捕获输出特征图

model_output, features = model_quantized(input_batch)  # 前向传播

# %%
features_keys_list = list(features.keys())

#### --------------------------------------------------------- ####
###############     extract the model parameter    ################
#### --------------------------------------------------------- ####

output_scale_list = []
output_zero_list = []
output_fm_list = []

for i in range(len(features.keys())):
    output_scale_list.append(features[features_keys_list[i]].detach().q_scale())  ### 第i层的scale
    output_zero_list.append(features[features_keys_list[i]].detach().q_zero_point())  ### 第i层的zero_point
    output_fm_list.append(features[features_keys_list[i]].detach().int_repr().numpy()[0])  ### 第i层的输出特征图

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

#########################################################################################
####                      Numpy model  Layer1 to Layer53
#########################################################################################
# 量化输入图像

input_scale = 0.018657904118299484
input_zero = np.array(114).astype("uint8")
input_batch = input_batch.detach().numpy()[0]
input_quantized = input_zero + input_batch / input_scale
input_quantized = np.round(input_quantized).astype("uint8")

# %%
# Layer1 inference
print(" Layer 1 CONV inference start ")
print(" Hierarchy configuration: FMin=224, Cin=3, Fmout=112, Cout=32, s=2")
input_quantized = input_quantized
input_scale = 0.018657904118299484
input_zero = np.array(114).astype("uint8")
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
M0_save = np.round(2 ** 16 * input_scale * weight_scale / output_scale)
M0_cal = np.round(2 ** 16 * input_scale * weight_scale / output_scale)
M0 = M0_cal

# 计算M0和M1值
M1_save = M1
M1_cal = np.round(2 ** 16 * bias / output_scale).astype("int32")
M1 = M1_cal

ofmp[1] = QuantizedConv2D_M(input_zero, input_quantized, output_zero, weight_quantized, kernel_size, stride, padding,
                            ofm_size, M0, n, M1, conv_mode=0)
ofmp[1] = relu(ofmp[1], output_zero_list[0])

# 输出Layer1的参数到文件
param_file.write(f"Layer 1:\n")
param_file.write(f"  M0: {M0}\n")
param_file.write(f"  输入零点: {input_zero} (二进制: {int_to_bin(input_zero)})\n")
param_file.write(f"  输出零点: {output_zero} (二进制: {int_to_bin(output_zero)})\n\n")

out1_extract = output_fm_list[0]
flag_ratio = (ofmp[1] == output_fm_list[0]).mean() * 100

print(" Layer 1 inference finished ")
print(f"{flag_ratio:.2f}% of values are the same of values are the same between the pytorch and numpy quantization schemes")
np.save("outputs\\software_output_layer1.npy", ofmp[1])

pickle.dump(M1, open("coe\\layer1_M1.p","wb"))
pickle.dump(input_quantized, open("coe\\ifmap.p",  "wb"))
pickle.dump(weight_quantized, open("coe\\layer1_weight.p", "wb"))

# %% Layer2 inference
print(" Layer 2 DW inference start ")
print(" hyperparameter: FMin=112, Cin=32, Fmout=112, Cout=32, s=1")
input_quantized = ofmp[1]
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
M1_cal = np.round(2 ** 16 * bias / output_scale).astype("int32")

ofmp[2] = QuantizedConv2D_M(input_zero, input_quantized, output_zero, weight_quantized, kernel_size, stride, padding,
                            ofm_size, M0, n, M1, conv_mode=1)
ofmp[2] = relu(ofmp[2], output_zero_list[1])

# 输出Layer2的参数到文件
param_file.write(f"Layer 2:\n")
param_file.write(f"  M0: {M0}\n")
param_file.write(f"  输入零点: {input_zero} (二进制: {int_to_bin(input_zero)})\n")
param_file.write(f"  输出零点: {output_zero} (二进制: {int_to_bin(output_zero)})\n\n")

out2_extract = output_fm_list[1]
flag_ratio = (ofmp[2]  == output_fm_list[1]).mean() * 100

print(" Layer 2 inference finished ")
print(f"{flag_ratio:.2f}% of values are the same between the pytorch and numpy quantization schemes")
pickle.dump(M1, open("coe\\layer2_M1.p", "wb"))
pickle.dump(weight_quantized, open("coe\\layer2_weight.p", "wb"))
np.save("outputs\\software_output_layer2.npy", ofmp[2])

# %% Layer3 inference
print(" Layer 3 PW inference start ")
print(" Hierarchy configuration: FMin=112, Cin=32, Fmout=112, Cout=16, s=1")
input_quantized = ofmp[2]
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
M1_cal = np.round(2 ** 16 * bias / output_scale).astype("int32")

ofmp[3] = QuantizedConv2D_M(input_zero, input_quantized, output_zero, weight_quantized, kernel_size, stride, padding,
                            ofm_size, M0, n, M1, conv_mode=2)

# 输出Layer3的参数到文件
param_file.write(f"Layer 3:\n")
param_file.write(f"  M0: {M0}\n")
param_file.write(f"  输入零点: {input_zero} (二进制: {int_to_bin(input_zero)})\n")
param_file.write(f"  输出零点: {output_zero} (二进制: {int_to_bin(output_zero)})\n\n")

out3_extract = output_fm_list[2]

flag_ratio = (ofmp[3]  == output_fm_list[2]).mean() * 100

print(" Layer 3 inference finished ")
print(f"{flag_ratio:.2f}% of values are the same between the pytorch and numpy quantization schemes")

pickle.dump(M1, open("coe\\layer3_M1.p", "wb"))
pickle.dump(weight_quantized, open("coe\\layer3_weight.p", "wb"))
np.save("outputs\\software_output_layer3.npy", ofmp[3])


# 定义模块参数列表
bottleneck_configs = [
    # (起始层索引, 卷积核列表,步长列表, padding list,输出尺寸列表, 是否有Shortcut)
    (3, [1, 3, 1], [1, 2, 1], [0, 1, 0], [112, 56, 56], False),
    (6, [1, 3, 1], [1, 1, 1], [0, 1, 0], [56, 56, 56], True),
    (9, [1, 3, 1], [1, 2, 1], [0, 1, 0], [56, 28, 28], False),
    (12, [1, 3, 1], [1, 1, 1], [0, 1, 0], [28, 28, 28], True),
    (15, [1, 3, 1], [1, 1, 1], [0, 1, 0], [28, 28, 28], True),
    (18, [1, 3, 1], [1, 2, 1], [0, 1, 0], [28, 14, 14], False),
    (21, [1, 3, 1], [1, 1, 1], [0, 1, 0], [14, 14, 14], True),
    (24, [1, 3, 1], [1, 1, 1], [0, 1, 0], [14, 14, 14], True),
    (27, [1, 3, 1], [1, 1, 1], [0, 1, 0], [14, 14, 14], True),
    (30, [1, 3, 1], [1, 1, 1], [0, 1, 0], [14, 14, 14], False),
    (33, [1, 3, 1], [1, 1, 1], [0, 1, 0], [14, 14, 14], True),
    (36, [1, 3, 1], [1, 1, 1], [0, 1, 0], [14, 14, 14], True),
    (39, [1, 3, 1], [1, 2, 1], [0, 1, 0], [14, 7, 7], False),
    (42, [1, 3, 1], [1, 1, 1], [0, 1, 0], [7, 7, 7], True),
    (45, [1, 3, 1], [1, 1, 1], [0, 1, 0], [7, 7, 7], True),
    (48, [1, 3, 1], [1, 1, 1], [0, 1, 0], [7, 7, 7], False),
]

# 统一处理所有瓶颈模块

# 初始输入
out_index = 3
shortcut_para_idx = 0
diff = [0] * 60
diff_count = [0] * 60
diff_sc = [0] * 15
output_dir = "coe"
for n, (start_idx, kernel_size_list, stride_list, padding_list, ofm_size_list, has_sc) in enumerate(bottleneck_configs):
    # 获取模块参数
    input_quantized = ofmp[start_idx]
    quantized_module_list = []
    quantized_module_list.append(model_quantized.features[n + 2].conv[0][0])
    quantized_module_list.append(model_quantized.features[n + 2].conv[1][0])
    quantized_module_list.append(model_quantized.features[n + 2].conv[2])

    # 准备输入参数
    input_scale_list = output_scale_list[start_idx - 1 + shortcut_para_idx:start_idx + 2 + shortcut_para_idx]
    input_zero_list = output_zero_list[start_idx - 1 + shortcut_para_idx:start_idx + 2 + shortcut_para_idx]

    ofmp_scale_list = output_scale_list[start_idx + shortcut_para_idx:start_idx + 3 + shortcut_para_idx]
    ofmp_zero_list = output_zero_list[start_idx + shortcut_para_idx:start_idx + 3 + shortcut_para_idx]
    print(ofmp_scale_list)

    weight_scale_list = []
    weight_zero_list = []
    weight_quantized_list = []
    bias_list = []

    M0 = []
    n_val = []
    M1 = []
    for i in range(start_idx, start_idx + 3):
        M0.append(M0_int_n_list[i][0])
        n_val.append(M0_int_n_list[i][1])
        M1.append(M1_list[i])
        M1_file_name = f"{output_dir}\\layer{i + 1}_M1.p"
        pickle.dump(M1_list[i], open(M1_file_name, "wb"))

    for i in range(0, len(quantized_module_list)):
        module_keys = list(quantized_module_list[i].state_dict().keys())
        weight_scale_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().q_scale())
        weight_zero_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().q_zero_point())
        weight_quantized_list.append(
            quantized_module_list[i].state_dict()[module_keys[0]].detach().int_repr().numpy().astype("int32"))
        bias_list.append(quantized_module_list[i].state_dict()[module_keys[1]].detach().numpy())
        weight_file_name = f"{output_dir}\\layer{start_idx + i + 1}_weight.p"
        pickle.dump(
            quantized_module_list[i].state_dict()[module_keys[0]].detach().int_repr().numpy().astype("int32"),
            open(weight_file_name, "wb"))

    # 处理PW-DW-PW模块
    ofmp[start_idx + 1], ofmp[start_idx + 2], ofmp[start_idx + 3] = pw1_dw_pw2_M(input_scale_list, input_zero_list,
                                                                                 input_quantized, ofmp_scale_list,
                                                                                 ofmp_zero_list, weight_scale_list,
                                                                                 weight_zero_list,
                                                                                 weight_quantized_list, bias_list,
                                                                                 kernel_size_list, stride_list,
                                                                                 padding_list, ofm_size_list, M0, n_val,
                                                                                 M1)

    # 输出当前模块中各层的参数
    for i in range(3):
        layer_num = start_idx + i + 1
        param_file.write(f"Layer {layer_num}:\n")
        param_file.write(f"  M0: {M0[i]}\n")
        param_file.write(f"  输入零点: {input_zero_list[i]} (二进制: {int_to_bin(input_zero_list[i])})\n")
        param_file.write(f"  输出零点: {ofmp_zero_list[i]} (二进制: {int_to_bin(ofmp_zero_list[i])})\n\n")

        ofmp_file_name = f"outputs\\software_output_layer{layer_num}.npy"
        np.save(ofmp_file_name, ofmp[layer_num])
        # with pd.ExcelWriter(f"accelerate\\ofmp{layer_num}.xlsx") as writer:
        #     for ch in range(ofmp[layer_num].shape[0]):
        #         df = pd.DataFrame(ofmp[layer_num][ch])
        #         df.to_excel(writer, sheet_name=f"channel_{ch}", index=False, header=False)

    # 输出相似度结果
    for idx in range(start_idx + 1, start_idx + 4):
        flag_ratio = (ofmp[idx]  == output_fm_list[out_index]).mean() * 100
        print(" Layer", idx, " inference finished ")
        print(f"{flag_ratio:.2f}% of values are the same between the pytorch and numpy quantization schemes")
        out_index = out_index + 1


    # 处理Shortcut
    if has_sc:
        print("Layer", start_idx + 3, "Short cut")
        x = ofmp[start_idx]
        x_s = output_scale_list[start_idx - 1 + shortcut_para_idx]
        x_z = output_zero_list[start_idx - 1 + shortcut_para_idx]
        Fx = ofmp[start_idx + 3]
        Fx_s = output_scale_list[start_idx + 2 + shortcut_para_idx]
        Fx_z = output_zero_list[start_idx + 2 + shortcut_para_idx]
        Sc_s = output_scale_list[start_idx + 3 + shortcut_para_idx]
        Sc_z = output_zero_list[start_idx + 3 + shortcut_para_idx]

        n1 = int(M0_SC_int_n_list[shortcut_para_idx][1])
        output_scale = output_scale_list[start_idx + 3 + shortcut_para_idx]
        M0_save = M0_SC_int_n_list[shortcut_para_idx][0]
        M0_cal = int(round(2 ** 16 * x_s / Sc_s))
        M1_save = M1_SC_int_n_list[shortcut_para_idx][0]
        M1_cal = np.round(2 ** 16 * Fx_s / Sc_s).astype("int32")

        ofmp[start_idx + 3] = short_cut_M(x, Fx, x_s, x_z, Fx_s, Fx_z, Sc_s, Sc_z, M0_cal, M1_cal, n1)

        # 输出shortcut层的参数
        param_file.write(f"Layer {start_idx + 3} Shortcut:\n")
        param_file.write(f"  M0: {M0_cal}\n")
        param_file.write(f"  M1: {M1_cal}\n")
        param_file.write(f"  x的零点: {x_z} (二进制: {int_to_bin(x_z)})\n")
        param_file.write(f"  FX的零点: {Fx_z} (二进制: {int_to_bin(Fx_z)})\n")
        param_file.write(f"  SC的零点: {Sc_z} (二进制: {int_to_bin(Sc_z)})\n\n")

        ofmp_file_name = f"outputs\\software_output_layer{start_idx + 3}_shortcut.npy"
        np.save(ofmp_file_name, ofmp[start_idx + 3])
        # with pd.ExcelWriter(f"accelerate\\ofmp{start_idx + 3}_shortcut.xlsx") as writer:
        #     for ch in range(ofmp[start_idx + 3].shape[0]):
        #         df = pd.DataFrame(ofmp[start_idx + 3][ch])
        #         df.to_excel(writer, sheet_name=f"channel_{ch}", index=False, header=False)

        flag_ratio = (ofmp[idx] == output_fm_list[out_index]).mean() * 100
        out_index = out_index + 1
        shortcut_para_idx = shortcut_para_idx + 1
        print(" Layer", idx, " inference finished ")
        print(f"{flag_ratio:.2f}%  of values are the same between the pytorch and numpy quantization schemes after layer", start_idx + 3,
              " shortcut")

# Layer52
input_scale = output_scale_list[60]
input_zero = output_zero_list[60]
input_quantized = ofmp[51]
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

# 输出Layer52的参数
param_file.write(f"Layer 52:\n")
param_file.write(f"  M0: {M0}\n")
param_file.write(f"  输入零点: {input_zero} (二进制: {int_to_bin(input_zero)})\n")
param_file.write(f"  输出零点: {output_zero} (二进制: {int_to_bin(output_zero)})\n\n")

M0_save = np.round(M0)
M0_cal = np.round(2 ** 16 * input_scale * weight_scale / output_scale)
M1_save = M1
M1_cal = np.round(2 ** 16 * bias / output_scale).astype("int32")
print("M0 == M0_cal " + str(M0_save == M0_cal))
print("M1 == M1_cal " + str(compare_2_numpy(M1_save, M1_cal)))
M0 = M0_cal
M1 = M1_cal

M1_file_name = f"{output_dir}\\layer52_M1.p"
pickle.dump(M1, open(M1_file_name, "wb"))
weight_file_name = f"{output_dir}\\layer52_weight.p"
pickle.dump(weight_quantized, open(weight_file_name, "wb"))
print("layer52",M0, n, M1)

ofmp52 = QuantizedConv2D_M(input_zero, input_quantized, output_zero, weight_quantized, kernel_size, stride,
                           padding,
                           ofm_size, M0, n, M1, conv_mode=0)
ofmp52 = relu(ofmp52, output_zero_list[61])

out52_extract = output_fm_list[61]
flag = np.zeros(ofmp52.shape)
for i in range(ofmp52.shape[0]):
    for j in range(ofmp52.shape[1]):
        for k in range(ofmp52.shape[2]):
            if (abs(ofmp52[i][j][k] - out52_extract[i][j][k]) == 0):
                flag[i][j][k] = 1
flag_2d = flag.reshape((flag.shape[0] * flag.shape[1]), -1)
print(flag.sum() / get_element_numbers(ofmp52) * 100, '%', "Layer 52 conv2d 1*1")
ofmp_file_name = f"outputs\\software_output_layer52.npy"
np.save(ofmp_file_name, ofmp52)
# with pd.ExcelWriter(f"accelerate\\ofmp52.xlsx") as writer:
#     for ch in range(ofmp52.shape[0]):
#         df = pd.DataFrame(ofmp52[ch])
#         df.to_excel(writer, sheet_name=f"channel_{ch}", index=False, header=False)
# %%

# AVG_POOLING
ofmp52_pooling = np.zeros(len(ofmp52))
for i in range(len(ofmp52)):
    ofmp52_pooling[i] = np.round(ofmp52[i].sum()*1337 / 256/256).astype("int32")
ofmp52_pooling_save = ofmp52_pooling.reshape(1280,1,1)
ofmp_file_name = f"outputs\\software_output_layer53.npy"
np.save(ofmp_file_name, ofmp52_pooling_save)
# Layer53
input_scale = output_scale_list[61]
input_zero = output_zero_list[61]
conv_module = model_quantized.classifier[1]
input_quantized = ofmp52_pooling

weight_quantized = conv_module.state_dict()["_packed_params._packed_params"][0].detach().int_repr().numpy()
weight_zero = conv_module.state_dict()["_packed_params._packed_params"][0].detach().q_zero_point()
weight_scale = conv_module.state_dict()["_packed_params._packed_params"][0].detach().q_scale()

bias = conv_module.state_dict()["_packed_params._packed_params"][1].detach().numpy()

output_scale = conv_module.state_dict()["scale"].numpy()
output_zero = conv_module.state_dict()["zero_point"].numpy()

output_1000 = np.zeros(1000)

# 输出Layer53的参数
param_file.write(f"Layer 53:\n")
param_file.write(f"  M0: {M0_int_n_list[52][0]}\n")
param_file.write(f"  输入零点: {input_zero} (二进制: {int_to_bin(input_zero)})\n")
param_file.write(f"  输出零点: {output_zero} (二进制: {int_to_bin(output_zero)})\n\n")

M0 = M0_int_n_list[52][0]
n = M0_int_n_list[52][1]
M1 = M1_list[52]
weight_quantized_save = weight_quantized.reshape(1000,1280,1,1)
M1_file_name = f"{output_dir}\\layer53_M1.p"
pickle.dump(M1, open(M1_file_name, "wb"))
weight_file_name = f"{output_dir}\\layer53_weight.p"
pickle.dump(weight_quantized_save, open(weight_file_name, "wb"))
for i in range(1000):
    w_mul_x = np.multiply(weight_quantized[i] - weight_zero, input_quantized - input_zero).sum()
    output_1000[i] = np.round(
        (M0 * w_mul_x + M1[i]) * (2 ** (-n)) + output_zero)

print(output_1000.argmax())
output1000_extract = output_fm_list[62]
output_1000_save = output_1000.reshape(1000,1,1)
ofmp_file_name = f"outputs\\software_output_layer54.npy"
np.save(ofmp_file_name, output_1000_save)
# np.savetxt("outputs\\software_output_layer54.csv",output_1000)
flag = np.zeros(output_1000.shape)
for i in range(output_1000.shape[0]):
    if (abs(output_1000[i] - output1000_extract[i]) == 0):
        flag[i] = 1
print(flag.sum() / get_element_numbers(output_1000) * 100, '%', "output")

flag = np.zeros(output_1000.shape)
for i in range(output_1000.shape[0]):
    if (abs(output_1000[i] - output1000_extract[i]) <= 1):
        flag[i] = 1
print(flag.sum() / get_element_numbers(output_1000) * 100, '%', "output diff<=1")

flag = np.zeros(output_1000.shape)
for i in range(output_1000.shape[0]):
    if (abs(output_1000[i] - output1000_extract[i]) <= 3):
        flag[i] = 1
print(flag.sum() / get_element_numbers(output_1000) * 100, '%', "output diff<= 3")

flag = np.zeros(output_1000.shape)
for i in range(output_1000.shape[0]):
    if (abs(output_1000[i] - output1000_extract[i]) <= 5):
        flag[i] = 1
print(flag.sum() / get_element_numbers(output_1000) * 100, '%', "output diff<= 5")

diff[54] = [(output_1000 - output1000_extract).min(), (output_1000 - output1000_extract).max()]
diff_count[54] = np.where(output_1000 - output1000_extract != 0)

output_scale = 0.15309934318065643
output_zero = 75
output_1000 = output_scale * (output_1000 - output_zero)
output_1000_tensor = torch.from_numpy(output_1000).clone().detach()
ofmp_file_name = f"outputs\\software_output_softmax.csv"
np.savetxt(ofmp_file_name, output_1000, delimiter=",")
probabilities = torch.nn.functional.softmax(output_1000_tensor, dim=0)

with open("imagenet_classes.txt", "r") as f:
    categories = [s.strip() for s in f.readlines()]
top5_prob, top5_catid = torch.topk(probabilities, 5)
for i in range(top5_prob.size(0)):
    print(categories[top5_catid[i]], top5_prob[i].item())

# 关闭参数文件
param_file.close()
