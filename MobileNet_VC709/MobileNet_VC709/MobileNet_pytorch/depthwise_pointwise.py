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

filename = "D:\\test\\n01440764\\ILSVRC2012_val_00000293.JPEG"
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
model_quantized = tx.Extractor(model_quantized, ["features.0.0", "features.1.conv.0"])#Capture of the module inside first layer

print(tx.list_module_names(model_quantized))

print(model_quantized)

model_output, features = model_quantized(input_batch)# Forward propagation
# feature_shapes = {name: f.shape for name, f in features.items()}
# print(features['features.0.0']) # Ofmp of layer1, datatype : quantized_tensor
out2_extract = features['features.1'].detach().int_repr().numpy()[0] # Clone ofmp of layer1, datatype : ndarray



# #############################################################################################
# #############################################################################################
# #############################################################################################




model_quantized = torchvision.models.quantization.mobilenet_v2(pretrained=True, quantize=True)# Load a quantized mobilenet_v2 model
# help(model_quantized.features[0][0])
# print(model_quantized.features[0][0])

# input_scale = b.item()
input_scale = features['features.0.0'].q_scale()
input_zero  = features['features.0.0'].q_zero_point()
input_quantized = features['features.0.0'].detach().int_repr().numpy()[0]


def relu(x, x_zero):
    if len(x.shape) > 1: 
        for i in range(x.shape[0]):
            relu(x[i], x_zero)
    elif len(x.shape) == 1:
        for i in range(x.shape[0]):
            if x[i] < x_zero:
                x[i] = x_zero
    
    return x
                

output_scale = 0.06928552687168121
output_zero  = 0

weight_scale = model_quantized.features[1].conv[0][0].state_dict()["weight"].q_scale()
weight_zero  = model_quantized.features[1].conv[0][0].state_dict()["weight"].q_zero_point()
weight_quantized = model_quantized.features[1].conv[0][0].state_dict()["weight"].int_repr().numpy()
#%%
# print(weight_quantized.shape)

# bias_quantized,bias_scale,bias_zero= quantize_tensor(model_quantized.features[0][0].state_dict()["bias"])# to quantize the input tensor and return an int8 tensor, scale and zero point
# print(bias_quantized.shape)
bias = model_quantized.features[1].conv[0][0].state_dict()["bias"].detach().numpy()



def Short_cut(x, Fx, x_s, x_z, Fx_s):
    #input feature map x and residual map Fx with their scale(s) and zero_point(z)
    M = Fx_s/x_s
    Hx = np.int8((x-x_z)*M + Fx)
    return Hx


stride = 1
pading = 1

out2_np = QuantizedConv2D_Depthwise(input_scale, input_zero, input_quantized, output_scale, output_zero, weight_scale, weight_zero, weight_quantized, bias, 3, 1, 1, 112)

out2_np = relu(out2_np, output_zero)

flag = np.zeros(out2_np.shape)
for i in range(out2_np.shape[0]):
    for j in range(out2_np.shape[1]):
        for k in range(out2_np.shape[2]):
            '''
            if(out1_np[i][j][k] == output1_clone[0][i][j][k]):
                flag[i][j][k] = 1
            '''
            
            
            if(out2_np[i][j][k] == out2_extract[i][j][k]):
                flag[i][j][k] = 1
            
            
            

print(flag.sum()/(112*112*32)*100,'%')






