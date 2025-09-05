#%%

import numpy as np
import torchvision
import torch
from torchvision import transforms
from PIL import Image
import torchextractor as tx


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


'''
def quantize_tensor(x, num_bits=8):# to quantize the input tensor and return an int8 tensor, scale and zero point

    x = x.numpy()
    qmin = - 2.**(num_bits-1)
    qmax =   2.**(num_bits-1) - 1
    
    min_val, max_val = x.min(), x.max()
    scale = (max_val - min_val) / (qmax - qmin)
    
    zero_point = 0
    
    # print(zero_point)
    zero_point = int(zero_point)
    
    q_x = zero_point + x / scale
    q_x.clip(qmin, qmax).round()
    q_x = q_x.round().astype("int8")
    
    return q_x, scale.item(), zero_point
'''


#########################################################################################
##### Processing of input image
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

# ofmp of layer1 before adding torchextractor
a,b,c = quantize_tensor(input_batch)# to quantize the input tensor and return an uint8 tensor, scale and zero point

#######################################################################
####                          Observer
#######################################################################
from observer import MinMaxObserver

obsever = MinMaxObserver(dtype=torch.quint8, qscheme=torch.per_tensor_affine)
input_orig =  obsever(input_batch[0])
i_scale,i_zero =  obsever.calculate_qparams()
print(i_scale,i_zero)

#min_q,max_q =  obsever._calculate_qparams(min_q, max_q)
#print(min_q,max_q)

#######################################################################
#######################################################################
#######################################################################

input_qa = torch.quantize_per_tensor(torch.tensor(input_batch.clone().detach()), i_scale.clone().detach().item(), int(i_zero.clone().detach().item()), torch.quint8)# Using quantize_per_tensor method of torch

input_scale = i_scale.clone().detach().item()
input_zero  = int(i_zero.clone().detach().item())

model_quantized = torchvision.models.quantization.mobilenet_v2(pretrained=True, quantize=True)# Load a quantized mobilenet_v2 model
# print(model_quantized.features[0][0].state_dict())
model_quantized.eval()
with torch.no_grad():
    output = model_quantized.features[0][0](input_qa)# Ofmp of layer1, datatype : quantized_tensor

# print("FM of layer1 before tx_extractor:\n",output.int_repr())# Ofmp of layer1, datatype : int8 tensor

output1_clone = output.int_repr().detach().numpy()# Clone ofmp of layer1, datatype : ndarray


#########################################################################################
#########################################################################################
#########################################################################################

# ofmp of layer1 after adding torchextractor
model_quantized = tx.Extractor(model_quantized, ["features.0.0", "features.1.conv.0", "features.1.conv.1"])#Capture of the module inside first layer

print(tx.list_module_names(model_quantized))

print(model_quantized)

model_output, features = model_quantized(input_batch)# Forward propagation
# feature_shapes = {name: f.shape for name, f in features.items()}
# print(features['features.0.0']) # Ofmp of layer1, datatype : quantized_tensor
out3_extract = features['features.1.conv.1'].detach().int_repr().numpy()[0] # Clone ofmp of layer1, datatype : ndarray



# #############################################################################################
# #############################################################################################
# #############################################################################################




model_quantized = torchvision.models.quantization.mobilenet_v2(pretrained=True, quantize=True)# Load a quantized mobilenet_v2 model
# help(model_quantized.features[0][0])
# print(model_quantized.features[0][0])

# input_scale = b.item()
input_scale = features['features.1.conv.0'].q_scale()
input_zero  = features['features.1.conv.0'].q_zero_point()
input_quantized = features['features.1.conv.0'].detach().int_repr().numpy()[0]


out2_npy = np.load("out2_np.npy")
out2_npy = relu(out2_npy,input_zero)

input_quantized = out2_npy


                

output_scale = features['features.1.conv.1'].detach().q_scale()
output_zero  = features['features.1.conv.1'].detach().q_zero_point()

weight_scale = model_quantized.features[1].conv[1].state_dict()["weight"].q_scale()
weight_zero  = model_quantized.features[1].conv[1].state_dict()["weight"].q_zero_point()
weight_quantized = model_quantized.features[1].conv[1].state_dict()["weight"].int_repr().numpy()

# print(weight_quantized.shape)

# bias_quantized,bias_scale,bias_zero= quantize_tensor(model_quantized.features[0][0].state_dict()["bias"])# to quantize the input tensor and return an int8 tensor, scale and zero point
# print(bias_quantized.shape)
bias = model_quantized.features[1].conv[1].state_dict()["bias"].detach().numpy()

def conv_cal(conv_mode, input_quantized, weight_quantized, kernel_size, stride, out_i, out_j, out_k):
    if(conv_mode == 2):
        weight = weight_quantized[out_i]
        input = np.zeros((input_quantized.shape[0], kernel_size, kernel_size))
        for i in range(weight.shape[0]):
            for j in range(weight.shape[1]):
                for k in range(weight.shape[2]):
                    input[i][j][k] = input_quantized[i][stride*out_j+j][stride*out_k+k]
   
    return np.multiply(weight,input).sum()



# print(input_quantized)
print(type(input_scale))
print(type(output_scale))
print(type(weight_scale))



def QuantizedConv2D(conv_mode, input_scale, input_zero, input_quantized, output_scale, output_zero, weight_scale, weight_zero, weight_quantized, bias, kernel_size, stride, padding, ofm_size):# input 3D, weight 4D
    if(conv_mode == 2):# pointwise conv
        output = np.zeros((weight_quantized.shape[0],ofm_size,ofm_size))
        # zero_temp = np.full(input_quantized.shape,input_zero)
        input_quantized = input_quantized - input_zero
        
        zero_temp = np.full(weight_quantized.shape, weight_zero)
        weight_quantized = weight_quantized - zero_temp
    
        for i in range(output.shape[0]):
            for j in range(output.shape[1]):
                for k in range(output.shape[2]):
                    output[i][j][k] = weight_scale*input_scale/output_scale*conv_cal(conv_mode, input_quantized, weight_quantized, kernel_size, stride, i, j, k) + bias[i]/output_scale + output_zero
                    output[i][j][k] = round(output[i][j][k])

    
    return output

stride = 1
pading = 0

out3_np = QuantizedConv2D( 2 ,input_scale, input_zero, input_quantized, output_scale, output_zero, weight_scale, weight_zero, weight_quantized, bias, 1, 1, 0, 112)

# out3_np = relu(out3_np, output_zero)

flag = np.zeros(out3_np.shape)
for i in range(out3_np.shape[0]):
    for j in range(out3_np.shape[1]):
        for k in range(out3_np.shape[2]):
            '''
            if(out1_np[i][j][k] == output1_clone[0][i][j][k]):
                flag[i][j][k] = 1
            '''
            
            
            if(out3_np[i][j][k] == out3_extract[i][j][k]):
                flag[i][j][k] = 1
            
def get_element_numbers(x):
    len_dim = len(x.shape)
    num = 1
    for i in range(len_dim):
        num = num * x.shape[i]
    return(num)
                   
            

print(flag.sum()/(out3_np.shape[0]*out3_np.shape[1]*out3_np.shape[2])*100,'%')

#%%

for i in range(out3_np.shape[0]):
    for j in range(out3_np.shape[1]):
        for k in range(out3_np.shape[2]):
            '''
            if(out1_np[i][j][k] == output1_clone[0][i][j][k]):
                flag[i][j][k] = 1
            '''
            
            
            if(out3_np[i][j][k] == out3_extract[i][j][k]):
                flag[i][j][k] = 1
                out3_np[i][j][k] = 0
                out3_extract[i][j][k] = 0


def get_element_numbers(x):
    len_dim = len(x.shape)
    num = 1
    for i in range(len_dim):
        num = num * x.shape[i]
    return(num)

print(get_element_numbers(out3_np))
print(get_element_numbers(out3_np) - flag.sum())


out1_npy = np.load("out1_np.npy")
out1_npy = relu(out1_npy,input_zero)


def Short_cut(x, Fx, x_s, x_z, Fx_s):
    #input feature map x and residual map Fx with their scale(s) and zero_point(z)
    M = Fx_s/x_s
    Hx = np.int8((x-x_z)*M + Fx)
    return Hx






