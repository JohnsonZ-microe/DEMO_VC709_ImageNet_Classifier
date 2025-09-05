#%%

import os, sys
root_path = os.path.abspath('D:\Project_UM\MobileNet_VC709\MobileNet_pytorch')
sys.path.append(root_path)

import numpy as np
import torchvision
import torch
from torchvision import transforms
from PIL import Image
import torchextractor as tx
from conv_norm_dp_pw import QuantizedConv2D, pw1_dw_pw2, short_cut



def quantize_tensor(x, num_bits=8):# to quantize the input tensor and return an int8 tensor, scale and zero point

    qmin = 0.
    qmax = 2.**num_bits - 1.
    min_val, max_val = x.min(), x.max()

    scale = (max_val - min_val) / (qmax - qmin)

    initial_zero_point = qmin - min_val / scale

    zero_point = 0
    if initial_zero_point < qmin:
        zero_point = qmin
    elif initial_zero_point > qmax:
        zero_point = qmax
    else:
        zero_point = initial_zero_point

    # print(zero_point)
    zero_point = int(zero_point)
    q_x = zero_point + x / scale
    q_x.clamp_(qmin, qmax).round_()
    q_x = q_x.round().byte()
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

#########################################################################################
#####                   Processing of input image
#########################################################################################

normalize = transforms.Normalize(mean=[0.485, 0.456, 0.406],
                                     std=[0.229, 0.224, 0.225])
test_transform = transforms.Compose([
        transforms.Resize(256),
        transforms.CenterCrop(224),
        transforms.ToTensor(),
        normalize,])


preprocess = transforms.Compose([
    transforms.Resize(256),
    transforms.CenterCrop(224),
    transforms.ToTensor(),
    transforms.Normalize(mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225]),
])

filename = "D:\Project_UM\MobileNet_VC709\MobileNet_pytorch\ILSVRC2012_val_00000293.jpg"
input_image = Image.open(filename)
input_tensor = preprocess(input_image)
input_batch = input_tensor.unsqueeze(0)


#########################################################################################
#########################################################################################
#########################################################################################


#########################################################################################
####                        Torch Extractor
#########################################################################################

input_quantized,input_scale,input_zero = quantize_tensor(input_batch) # to quantize the input tensor and return an uint8 tensor, scale and zero point
input_quantized = input_quantized.detach().numpy()[0]
model_quantized = torchvision.models.quantization.mobilenet_v2(pretrained=True, quantize=True)# Load a quantized mobilenet_v2 model
model_quantized.eval()


# add torchextractor
model_quantized = tx.Extractor(model_quantized, ["features.0.0", "features.1.conv.0", "features.1.conv.1", "features.2.conv.0", "features.2.conv.1", "features.2.conv.2", "features.3.conv.0", "features.3.conv.1", "features.3.conv.2", "features.3.skip_add.activation_post_process", 'features.4.conv.0', 'features.4.conv.1', 'features.4.conv.2'])#Capture of the ofmp

# print(tx.list_module_names(model_quantized))

model_output, features = model_quantized(input_batch) # Forward propagation

# print(len(list(features.keys())))
features_keys_list = list(features.keys())

output_scale_list = []
output_zero_list  = []
output_fm_list    = []

for i in range(len(features.keys())):
    output_scale_list.append(features[features_keys_list[i]].detach().q_scale())
    output_zero_list.append(features[features_keys_list[i]].detach().q_zero_point())
    output_fm_list.append(features[features_keys_list[i]].detach().int_repr().numpy()[0])

# ####################################################################################### 
# ####################################################################################### 
# ####################################################################################### 

#%%
#########################################################################################
####                         Layer0 to Layer11
#########################################################################################

model_quantized  = model_quantized.model
#Layer1
input_scale      = input_scale.detach().item()
input_zero       = np.array(input_zero).astype("uint8") 
conv_module      = model_quantized.features[0][0]
weight_scale     = conv_module.state_dict()["weight"].detach().q_scale()
weight_zero      = conv_module.state_dict()["weight"].detach().q_zero_point()
weight_quantized = conv_module.state_dict()["weight"].detach().int_repr().numpy()
bias             = conv_module.state_dict()["bias"].detach().numpy()
kernel_size      = 3 
stride           = 2 
padding          = 1
ofm_size         = 112
conv_mode        = 0

ofmp1 = QuantizedConv2D(input_scale, input_zero, input_quantized, output_scale_list[0], output_zero_list[0], weight_scale, weight_zero, weight_quantized, bias, kernel_size, stride, padding, ofm_size,conv_mode)
ofmp1 = relu(ofmp1, output_zero_list[0])
print('layer0 reference done')

out1_extract = output_fm_list[0]
flag = np.zeros(ofmp1.shape)
for i in range(ofmp1.shape[0]):
    for j in range(ofmp1.shape[1]):
        for k in range(ofmp1.shape[2]):
            if((ofmp1[i][j][k] - out1_extract[i][j][k])<=3):
                flag[i][j][k] = 1
        
print('layer0 reference accuracy = ',flag.sum()/(112*112*32)*100,'%')


#Layer2
input_scale      = output_scale_list[0]
input_zero       = output_zero_list[0] 
conv_module      = model_quantized.features[1].conv[0][0]
weight_scale     = conv_module.state_dict()["weight"].detach().q_scale()
weight_zero      = conv_module.state_dict()["weight"].detach().q_zero_point()
weight_quantized = conv_module.state_dict()["weight"].detach().int_repr().numpy()
bias             = conv_module.state_dict()["bias"].detach().numpy()
kernel_size      = 3 
stride           = 1 
padding          = 1
ofm_size         = 112
conv_mode        = 1

ofmp2 = QuantizedConv2D(input_scale, input_zero, ofmp1, output_scale_list[1], output_zero_list[1], weight_scale, weight_zero, weight_quantized, bias, kernel_size, stride, padding, ofm_size,conv_mode)
ofmp2 = relu(ofmp2, output_zero_list[1])
print('layer1.DW reference done')
out2_extract = output_fm_list[1]
flag = np.zeros(ofmp2.shape)
for i in range(ofmp2.shape[0]):
    for j in range(ofmp2.shape[1]):
        for k in range(ofmp1.shape[2]):
            if(abs(ofmp2[i][j][k] - out2_extract[i][j][k])<=3):
                flag[i][j][k] = 1
            
print('layer1.DW reference accuracy = ',flag.sum()/(112*112*32)*100,'%')


#Layer3
input_scale      = output_scale_list[1]
input_zero       = output_zero_list[1] 
conv_module      = model_quantized.features[1].conv[1]
weight_scale     = conv_module.state_dict()["weight"].detach().q_scale()
weight_zero      = conv_module.state_dict()["weight"].detach().q_zero_point()
weight_quantized = conv_module.state_dict()["weight"].detach().int_repr().numpy()
bias             = conv_module.state_dict()["bias"].detach().numpy()
kernel_size      = 1 
stride           = 1 
padding          = 0
ofm_size         = 112
conv_mode        = 2

ofmp3 = QuantizedConv2D(input_scale, input_zero, ofmp2, output_scale_list[2], output_zero_list[2], weight_scale, weight_zero, weight_quantized, bias, kernel_size, stride, padding, ofm_size,conv_mode)
print('layer1.PW reference done')

out3_extract = output_fm_list[2]
flag = np.zeros(ofmp3.shape)
for i in range(ofmp3.shape[0]):
    for j in range(ofmp3.shape[1]):
        for k in range(ofmp3.shape[2]):
            if(abs(ofmp3[i][j][k] - out3_extract[i][j][k])<=3):
                flag[i][j][k] = 1
            

print('layer1.PW reference accuracy = ',flag.sum()/(112*112*16)*100,'%')

#%%
#Layer2 reference
quantized_module_list = []
quantized_module_list.append(model_quantized.features[2].conv[0][0])
quantized_module_list.append(model_quantized.features[2].conv[1][0])
quantized_module_list.append(model_quantized.features[2].conv[2])

input_quantized   = ofmp3
input_scale_list  = output_scale_list[2:5]
input_zero_list   = output_zero_list[2:5]

ofmp_scale_list   = output_scale_list[3:6]
ofmp_zero_list    = output_zero_list[3:6]

weight_scale_list     = []
weight_zero_list      = []
weight_quantized_list = []
bias_list             = []

for i in range(0, len(quantized_module_list)):
    module_keys = list(quantized_module_list[i].state_dict().keys())
    weight_scale_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().q_scale())
    weight_zero_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().q_zero_point())
    weight_quantized_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().int_repr().numpy().astype("int32"))
    bias_list.append(quantized_module_list[i].state_dict()[module_keys[1]].detach().numpy())
   
kernel_size_list = [1,3,1] 
stride_list      = [1,2,1]
padding_list     = [0,1,0]
ofm_size_list    = [112,56,56]



ofmp4,ofmp5,ofmp6 = pw1_dw_pw2(input_scale_list, input_zero_list, input_quantized, ofmp_scale_list, ofmp_zero_list, weight_scale_list, weight_zero_list, weight_quantized_list, bias_list, kernel_size_list, stride_list, padding_list, ofm_size_list)



out4_extract = output_fm_list[3]
flag = np.zeros(ofmp4.shape)
for i in range(ofmp4.shape[0]):
    for j in range(ofmp4.shape[1]):
        for k in range(ofmp4.shape[2]):
            if((ofmp4[i][j][k] - out4_extract[i][j][k])<=3):
                flag[i][j][k] = 1
            

print('layer2.PW1 reference accuracy = ', flag.sum()/(112*112*96)*100,'%')

out5_extract = output_fm_list[4]
flag = np.zeros(ofmp5.shape)
for i in range(ofmp5.shape[0]):
    for j in range(ofmp5.shape[1]):
        for k in range(ofmp5.shape[2]):
            if(abs(ofmp5[i][j][k] == out5_extract[i][j][k])<=3):
                flag[i][j][k] = 1
            

print('layer2.DW1 reference accuracy = ', flag.sum()/(56*56*96)*100,'%')

out6_extract = output_fm_list[5]
flag = np.zeros(ofmp6.shape)
for i in range(ofmp6.shape[0]):
    for j in range(ofmp6.shape[1]):
        for k in range(ofmp6.shape[2]):
            if(abs(ofmp6[i][j][k] - out6_extract[i][j][k])<=3):
                flag[i][j][k] = 1
            

print('layer2.PW2 reference accuracy = ', flag.sum()/(56*56*24)*100,'%')
print('layer2 reference done')
#%%
#Layer3 reference
quantized_module_list = []
quantized_module_list.append(model_quantized.features[3].conv[0][0])
quantized_module_list.append(model_quantized.features[3].conv[1][0])
quantized_module_list.append(model_quantized.features[3].conv[2])

input_quantized   = ofmp6
input_scale_list  = output_scale_list[5:8]
input_zero_list   = output_zero_list[5:8]

ofmp_scale_list   = output_scale_list[6:9]
ofmp_zero_list    = output_zero_list[6:9]

weight_scale_list     = []
weight_zero_list      = []
weight_quantized_list = []
bias_list             = []

for i in range(0, len(quantized_module_list)):
    module_keys = list(quantized_module_list[i].state_dict().keys())
    weight_scale_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().q_scale())
    weight_zero_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().q_zero_point())
    weight_quantized_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().int_repr().numpy().astype("int32"))
    bias_list.append(quantized_module_list[i].state_dict()[module_keys[1]].detach().numpy())
   
kernel_size_list = [1,3,1] 
stride_list      = [1,1,1]
padding_list     = [0,1,0]
ofm_size_list    = [56,56,56]



ofmp7,ofmp8,ofmp9 = pw1_dw_pw2(input_scale_list, input_zero_list, input_quantized, ofmp_scale_list, ofmp_zero_list, weight_scale_list, weight_zero_list, weight_quantized_list, bias_list, kernel_size_list, stride_list, padding_list, ofm_size_list)

out7_extract = output_fm_list[6]
flag = np.zeros(ofmp7.shape)
for i in range(ofmp7.shape[0]):
    for j in range(ofmp7.shape[1]):
        for k in range(ofmp7.shape[2]):
            if((ofmp7[i][j][k] - out7_extract[i][j][k])<=3):
                flag[i][j][k] = 1
            

print('layer3.PW1 reference accuracy = ', flag.sum()/(56*56*144)*100,'%')

out8_extract = output_fm_list[7]
flag = np.zeros(ofmp8.shape)
for i in range(ofmp8.shape[0]):
    for j in range(ofmp8.shape[1]):
        for k in range(ofmp8.shape[2]):
            if(abs(ofmp8[i][j][k] == out8_extract[i][j][k])<=3):
                flag[i][j][k] = 1
            

print('layer3.DW1 reference accuracy = ', flag.sum()/(56*56*144)*100,'%')

out9_extract = output_fm_list[8]
flag = np.zeros(ofmp9.shape)
for i in range(ofmp9.shape[0]):
    for j in range(ofmp9.shape[1]):
        for k in range(ofmp9.shape[2]):
            if(abs(ofmp9[i][j][k] - out9_extract[i][j][k])<=3):
                flag[i][j][k] = 1
            

print('layer3.PW2 reference accuracy = ', flag.sum()/(56*56*24)*100,'%')


# Layer3 Short Cut

x    = ofmp6
x_s  = output_scale_list[5]
x_z  = output_zero_list[5]
Fx   = ofmp9
Fx_s = output_scale_list[8]
Fx_z = output_zero_list[8]
Sc_s = output_scale_list[9]
Sc_z = output_zero_list[9]

ofmp9 = short_cut(x, Fx, x_s, x_z, Fx_s, Fx_z, Sc_s, Sc_z)

out9_sc_extract = output_fm_list[9]
flag = np.zeros(ofmp9.shape)
for i in range(ofmp9.shape[0]):
    for j in range(ofmp9.shape[1]):
        for k in range(ofmp9.shape[2]):
            if(abs(ofmp9[i][j][k] - out9_sc_extract[i][j][k])<=3):
                flag[i][j][k] = 1
            

print('layer3.SC reference accuracy = ', flag.sum()/(56*56*24)*100,'%')
print('layer3 reference done')


#%%
#Layer4
quantized_module_list = []
quantized_module_list.append(model_quantized.features[3].conv[0][0])
quantized_module_list.append(model_quantized.features[3].conv[1][0])
quantized_module_list.append(model_quantized.features[3].conv[2])

input_quantized   = ofmp6
input_scale_list  = output_scale_list[5:8]
input_zero_list   = output_zero_list[5:8]

ofmp_scale_list   = output_scale_list[6:9]
ofmp_zero_list    = output_zero_list[6:9]

weight_scale_list     = []
weight_zero_list      = []
weight_quantized_list = []
bias_list             = []

for i in range(0, len(quantized_module_list)):
    module_keys = list(quantized_module_list[i].state_dict().keys())
    weight_scale_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().q_scale())
    weight_zero_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().q_zero_point())
    weight_quantized_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().int_repr().numpy().astype("int32"))
    bias_list.append(quantized_module_list[i].state_dict()[module_keys[1]].detach().numpy())
   
kernel_size_list = [1,3,1] 
stride_list      = [1,1,1]
padding_list     = [0,1,0]
ofm_size_list    = [56,56,56]



ofmp7,ofmp8,ofmp9 = pw1_dw_pw2(input_scale_list, input_zero_list, input_quantized, ofmp_scale_list, ofmp_zero_list, weight_scale_list, weight_zero_list, weight_quantized_list, bias_list, kernel_size_list, stride_list, padding_list, ofm_size_list)

out7_extract = output_fm_list[6]
flag = np.zeros(ofmp7.shape)
for i in range(ofmp7.shape[0]):
    for j in range(ofmp7.shape[1]):
        for k in range(ofmp7.shape[2]):
            if((ofmp7[i][j][k] - out7_extract[i][j][k])<=3):
                flag[i][j][k] = 1
            

print('layer4.PW1 reference accuracy = ', flag.sum()/(56*56*144)*100,'%')

out8_extract = output_fm_list[7]
flag = np.zeros(ofmp8.shape)
for i in range(ofmp8.shape[0]):
    for j in range(ofmp8.shape[1]):
        for k in range(ofmp8.shape[2]):
            if(abs(ofmp8[i][j][k] == out8_extract[i][j][k])<=3):
                flag[i][j][k] = 1
            

print('layer4.DW1 reference accuracy = ', flag.sum()/(56*56*144)*100,'%')

out9_extract = output_fm_list[8]
flag = np.zeros(ofmp9.shape)
for i in range(ofmp9.shape[0]):
    for j in range(ofmp9.shape[1]):
        for k in range(ofmp9.shape[2]):
            if(abs(ofmp9[i][j][k] - out9_extract[i][j][k])<=3):
                flag[i][j][k] = 1
            

print('layer4.PW2 reference accuracy = ', flag.sum()/(56*56*24)*100,'%')

#%%
#Layer5 reference
quantized_module_list = []
quantized_module_list.append(model_quantized.features[5].conv[0][0])
quantized_module_list.append(model_quantized.features[5].conv[1][0])
quantized_module_list.append(model_quantized.features[5].conv[2])

input_quantized   = ofmp9
input_scale_list  = output_scale_list[5:8]
input_zero_list   = output_zero_list[5:8]

ofmp_scale_list   = output_scale_list[6:9]
ofmp_zero_list    = output_zero_list[6:9]

weight_scale_list     = []
weight_zero_list      = []
weight_quantized_list = []
bias_list             = []

for i in range(0, len(quantized_module_list)):
    module_keys = list(quantized_module_list[i].state_dict().keys())
    weight_scale_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().q_scale())
    weight_zero_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().q_zero_point())
    weight_quantized_list.append(quantized_module_list[i].state_dict()[module_keys[0]].detach().int_repr().numpy().astype("int32"))
    bias_list.append(quantized_module_list[i].state_dict()[module_keys[1]].detach().numpy())
   
kernel_size_list = [1,3,1] 
stride_list      = [1,1,1]
padding_list     = [0,1,0]
ofm_size_list    = [56,56,56]



ofmp7,ofmp8,ofmp9 = pw1_dw_pw2(input_scale_list, input_zero_list, input_quantized, ofmp_scale_list, ofmp_zero_list, weight_scale_list, weight_zero_list, weight_quantized_list, bias_list, kernel_size_list, stride_list, padding_list, ofm_size_list)

out7_extract = output_fm_list[6]
flag = np.zeros(ofmp7.shape)
for i in range(ofmp7.shape[0]):
    for j in range(ofmp7.shape[1]):
        for k in range(ofmp7.shape[2]):
            if((ofmp7[i][j][k] - out7_extract[i][j][k])<=3):
                flag[i][j][k] = 1
            

print('layer3.PW1 reference accuracy = ', flag.sum()/(56*56*144)*100,'%')

out8_extract = output_fm_list[7]
flag = np.zeros(ofmp8.shape)
for i in range(ofmp8.shape[0]):
    for j in range(ofmp8.shape[1]):
        for k in range(ofmp8.shape[2]):
            if(abs(ofmp8[i][j][k] == out8_extract[i][j][k])<=3):
                flag[i][j][k] = 1
            

print('layer3.DW1 reference accuracy = ', flag.sum()/(56*56*144)*100,'%')

out9_extract = output_fm_list[8]
flag = np.zeros(ofmp9.shape)
for i in range(ofmp9.shape[0]):
    for j in range(ofmp9.shape[1]):
        for k in range(ofmp9.shape[2]):
            if(abs(ofmp9[i][j][k] - out9_extract[i][j][k])<=3):
                flag[i][j][k] = 1
            

print('layer3.PW2 reference accuracy = ', flag.sum()/(56*56*24)*100,'%')


# Layer3 Short Cut

x    = ofmp6
x_s  = output_scale_list[5]
x_z  = output_zero_list[5]
Fx   = ofmp9
Fx_s = output_scale_list[8]
Fx_z = output_zero_list[8]
Sc_s = output_scale_list[9]
Sc_z = output_zero_list[9]

ofmp9 = short_cut(x, Fx, x_s, x_z, Fx_s, Fx_z, Sc_s, Sc_z)

out9_sc_extract = output_fm_list[9]
flag = np.zeros(ofmp9.shape)
for i in range(ofmp9.shape[0]):
    for j in range(ofmp9.shape[1]):
        for k in range(ofmp9.shape[2]):
            if(abs(ofmp9[i][j][k] - out9_sc_extract[i][j][k])<=3):
                flag[i][j][k] = 1
            

print('layer3.SC reference accuracy = ', flag.sum()/(56*56*24)*100,'%')
print('layer3 reference done')
