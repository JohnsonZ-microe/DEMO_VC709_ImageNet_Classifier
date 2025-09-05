# %%
import numpy as np
import torchvision
from torchvision import transforms
from PIL import Image
import torchextractor as tx
from conv_accelerate import QuantizedConv2D_M, pw1_dw_pw2_M, get_element_numbers, compare_2_numpy, short_cut_M
import torch

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
# netron.start(path)
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


def numpy_inference(input_tensor):
    ofmp = [0] * 54
    """使用numpy实现量化MobileNetV2的前向传播"""
    # 转换为numpy并处理批次维度
    input_scale = 0.018657904118299484
    input_zero = np.array(114).astype("uint8")
    input_batch = input_tensor.numpy()[0]
    input_quantized = input_zero + input_batch / input_scale
    input_quantized = np.round(input_quantized).astype("uint8")

    # %%
    # Layer1 inference
    # print(" Layer 1 CONV inference start ")
    # print(" Hierarchy configuration: FMin=224, Cin=3, Fmout=112, Cout=32, s=2")
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

    ofmp[1] = QuantizedConv2D_M(input_zero, input_quantized, output_zero, weight_quantized, kernel_size, stride,
                                padding,
                                ofm_size, M0, n, M1, conv_mode=0)
    ofmp[1] = relu(ofmp[1], output_zero_list[0])



    out1_extract = output_fm_list[0]
    flag_ratio = (ofmp[1] == output_fm_list[0]).mean() * 100

    # print(" Layer 1 inference finished ")
    # print(f"{flag_ratio:.2f}% of values are the same of values are the same between the pytorch and numpy quantization schemes")
    np.save("accelerate\\software_output_layer1.npy", ofmp[1])

    pickle.dump(M1, open("coe\\layer1_M1.p", "wb"))
    pickle.dump(input_quantized, open("coe\\ifmap.p", "wb"))
    pickle.dump(weight_quantized, open("coe\\layer1_weight.p", "wb"))

    # %% Layer2 inference
    # print(" Layer 2 DW inference start ")
    # print(" hyperparameter: FMin=112, Cin=32, Fmout=112, Cout=32, s=1")
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

    ofmp[2] = QuantizedConv2D_M(input_zero, input_quantized, output_zero, weight_quantized, kernel_size, stride,
                                padding,
                                ofm_size, M0, n, M1, conv_mode=1)
    ofmp[2] = relu(ofmp[2], output_zero_list[1])

    # 输出Layer2的参数到文件


    out2_extract = output_fm_list[1]
    flag_ratio = (ofmp[2] == output_fm_list[1]).mean() * 100

    # print(" Layer 2 inference finished ")
    # print(f"{flag_ratio:.2f}% of values are the same between the pytorch and numpy quantization schemes")
    pickle.dump(M1, open("coe\\layer2_M1.p", "wb"))
    pickle.dump(weight_quantized, open("coe\\layer2_weight.p", "wb"))
    np.save("accelerate\\software_output_layer2.npy", ofmp[2])

    # %% Layer3 inference
    # print(" Layer 3 PW inference start ")
    # print(" Hierarchy configuration: FMin=112, Cin=32, Fmout=112, Cout=16, s=1")
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

    ofmp[3] = QuantizedConv2D_M(input_zero, input_quantized, output_zero, weight_quantized, kernel_size, stride,
                                padding,
                                ofm_size, M0, n, M1, conv_mode=2)

    # 输出Layer3的参数到文件


    out3_extract = output_fm_list[2]

    flag_ratio = (ofmp[3] == output_fm_list[2]).mean() * 100

    # print(" Layer 3 inference finished ")
    # print(f"{flag_ratio:.2f}% of values are the same between the pytorch and numpy quantization schemes")

    pickle.dump(M1, open("coe\\layer3_M1.p", "wb"))
    pickle.dump(weight_quantized, open("coe\\layer3_weight.p", "wb"))
    np.save("accelerate\\software_output_layer3.npy", ofmp[3])

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
    for n, (start_idx, kernel_size_list, stride_list, padding_list, ofm_size_list, has_sc) in enumerate(
            bottleneck_configs):
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
        # print(ofmp_scale_list)

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
                                                                                     padding_list, ofm_size_list, M0,
                                                                                     n_val,
                                                                                     M1)

        # 输出当前模块中各层的参数



            # with pd.ExcelWriter(f"accelerate\\ofmp{layer_num}.xlsx") as writer:
            #     for ch in range(ofmp[layer_num].shape[0]):
            #         df = pd.DataFrame(ofmp[layer_num][ch])
            #         df.to_excel(writer, sheet_name=f"channel_{ch}", index=False, header=False)

        # 输出相似度结果
        for idx in range(start_idx + 1, start_idx + 4):
            flag_ratio = (ofmp[idx] == output_fm_list[out_index]).mean() * 100
            # print(" Layer", idx, " inference finished ")
            # print(f"{flag_ratio:.2f}% of values are the same between the pytorch and numpy quantization schemes")
            out_index = out_index + 1

        # 处理Shortcut
        if has_sc:
            # print("Layer", start_idx + 3, "Short cut")
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


            ofmp_file_name = f"accelerate\\software_output_layer{start_idx + 3}_shortcut.npy"
            np.save(ofmp_file_name, ofmp[start_idx + 3])
            # with pd.ExcelWriter(f"accelerate\\ofmp{start_idx + 3}_shortcut.xlsx") as writer:
            #     for ch in range(ofmp[start_idx + 3].shape[0]):
            #         df = pd.DataFrame(ofmp[start_idx + 3][ch])
            #         df.to_excel(writer, sheet_name=f"channel_{ch}", index=False, header=False)

            flag_ratio = (ofmp[idx] == output_fm_list[out_index]).mean() * 100
            out_index = out_index + 1
            shortcut_para_idx = shortcut_para_idx + 1
            # print(" Layer", idx, " inference finished ")
            # print(f"{flag_ratio:.2f}%  of values are the same between the pytorch and numpy quantization schemes after layer", start_idx + 3, " shortcut")

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


    M0_save = np.round(M0)
    M0_cal = np.round(2 ** 16 * input_scale * weight_scale / output_scale)
    M1_save = M1
    M1_cal = np.round(2 ** 16 * bias / output_scale).astype("int32")
    # print("M0 == M0_cal " + str(M0_save == M0_cal))
    # print("M1 == M1_cal " + str(compare_2_numpy(M1_save, M1_cal)))
    M0 = M0_cal
    M1 = M1_cal

    M1_file_name = f"{output_dir}\\layer52_M1.p"
    pickle.dump(M1, open(M1_file_name, "wb"))
    weight_file_name = f"{output_dir}\\layer52_weight.p"
    pickle.dump(weight_quantized, open(weight_file_name, "wb"))
    # print("layer52", M0, n, M1)
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
    # print(flag.sum() / get_element_numbers(ofmp52) * 100, '%', "Layer 52 conv2d 1*1")
    ofmp_file_name = f"accelerate\\software_output_layer52.npy"
    np.save(ofmp_file_name, ofmp52)
    # with pd.ExcelWriter(f"accelerate\\ofmp52.xlsx") as writer:
    #     for ch in range(ofmp52.shape[0]):
    #         df = pd.DataFrame(ofmp52[ch])
    #         df.to_excel(writer, sheet_name=f"channel_{ch}", index=False, header=False)
    # %%

    # AVG_POOLING
    ofmp52_pooling = np.zeros(len(ofmp52))
    for i in range(len(ofmp52)):
        ofmp52_pooling[i] = np.round(ofmp52[i].sum() / 49).astype("int32")

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


    M0 = M0_int_n_list[52][0]
    n = M0_int_n_list[52][1]
    M1 = M1_list[52]

    for i in range(1000):
        w_mul_x = np.multiply(weight_quantized[i] - weight_zero, input_quantized - input_zero).sum()
        output_1000[i] = np.round(
            (M0 * w_mul_x + M1[i]) * (2 ** (-n)) + output_zero)

    # print(output_1000.argmax())
    output1000_extract = output_fm_list[62]

    flag = np.zeros(output_1000.shape)
    for i in range(output_1000.shape[0]):
        if (abs(output_1000[i] - output1000_extract[i]) == 0):
            flag[i] = 1
    # print(flag.sum() / get_element_numbers(output_1000) * 100, '%', "output")

    flag = np.zeros(output_1000.shape)
    for i in range(output_1000.shape[0]):
        if (abs(output_1000[i] - output1000_extract[i]) <= 1):
            flag[i] = 1
    # print(flag.sum() / get_element_numbers(output_1000) * 100, '%', "output diff<=1")

    flag = np.zeros(output_1000.shape)
    for i in range(output_1000.shape[0]):
        if (abs(output_1000[i] - output1000_extract[i]) <= 3):
            flag[i] = 1
    # print(flag.sum() / get_element_numbers(output_1000) * 100, '%', "output diff<= 3")

    flag = np.zeros(output_1000.shape)
    for i in range(output_1000.shape[0]):
        if (abs(output_1000[i] - output1000_extract[i]) <= 5):
            flag[i] = 1
    # print(flag.sum() / get_element_numbers(output_1000) * 100, '%', "output diff<= 5")

    diff[54] = [(output_1000 - output1000_extract).min(), (output_1000 - output1000_extract).max()]
    diff_count[54] = np.where(output_1000 - output1000_extract != 0)

    output_scale = 0.15309934318065643
    output_zero = 75
    output_1000 = output_scale * (output_1000 - output_zero)
    # output_1000_tensor = torch.from_numpy(output_1000).clone().detach()
    #
    # probabilities = torch.nn.functional.softmax(output_1000_tensor, dim=0)
    #
    # with open("imagenet_classes.txt", "r") as f:
    #     categories = [s.strip() for s in f.readlines()]
    # top5_prob, top5_catid = torch.topk(probabilities, 5)
    # # for i in range(top5_prob.size(0)):
    #     # print(categories[top5_catid[i]], top5_prob[i].item())

    # 关闭参数文件

    # 返回logits
    return output_1000