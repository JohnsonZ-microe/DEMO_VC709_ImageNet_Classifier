import numpy as np
import torchvision
import torch
from torchvision import transforms, datasets
from PIL import Image
from torchvision import transforms
import torchextractor as tx
import math
import matplotlib.pyplot as plt


# Convert a normal regular tensor to a quantized tensor with scale and zero_point
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

filename ="dog.jpg"
input_image = Image.open(filename)
input_tensor = preprocess(input_image)
input_batch = input_tensor.unsqueeze(0)
#########################################################################################
#########################################################################################
#########################################################################################

#----First verify that the torchextractor class should not influent the inference outcome 

# ofmp of layer1 before putting into torchextractor
a,b,c = quantize_tensor(input_batch)# to quantize the input tensor and return an int8 tensor, scale and zero point
# input_qa = torch.quantize_per_tensor(torch.tensor(input_batch.clone().detach()), b, c, torch.quint8)# Using quantize_per_tensor method of torch

# Load a quantized mobilenet_v2 model
model_quantized = torchvision.models.quantization.mobilenet_v2(pretrained=True, quantize=True)

model_quantized.eval()
with torch.no_grad():
    output = model_quantized(input_batch)# Ofmp of layer1, datatype : quantized_tensor


# print("FM of layer1 before tx_extractor:\n",output.int_repr())# Ofmp of layer1, datatype : int8 tensor
# output1_clone = output.int_repr().detach().numpy()# Clone ofmp of layer1, datatype : ndarray


probabilities = torch.nn.functional.softmax(output[0], dim=0)
# print(probabilities)

# Read the categories
with open("D:\\Project_UM\\MobileNet_VC709\\MobileNet_pytorch\\imagenet_classes.txt", "r") as f:
    categories = [s.strip() for s in f.readlines()]
# Show top categories per image
top5_prob, top5_catid = torch.topk(probabilities, 5)
for i in range(top5_prob.size(0)):
    print(categories[top5_catid[i]], top5_prob[i].item())


#%%
#########################################################################################
#########################################################################################
#########################################################################################

# ofmp of layer1 after adding torchextractor
model_quantized_ex = tx.Extractor(model_quantized, ["features.0.0"])#Capture of the module inside first layer
model_output, features = model_quantized_ex(input_batch)# Forward propagation
# feature_shapes = {name: f.shape for name, f in features.items()}
# print(features['features.0.0']) # Ofmp of layer1, datatype : quantized_tensor
out1_clone = features['features.0.0'].int_repr().numpy() # Clone ofmp of layer1, datatype : ndarray


if(out1_clone.all() == output1_clone.all()):
    print('Model with torchextractor attached output the same value as the original model')
else:
    print('Torchextractor method influence the outcome')

#%%
# #############################################################################################
# ---------  Simulate the inference process of layer0: conv33 using numpy
# #############################################################################################


# get the input_batch quantized buffer data
input_scale = b.item()
input_zero  = c
input_quantized = a[0].detach().numpy()

# get the layer0 output scale and zero_point
output_scale = model_quantized.features[0][0].state_dict()['scale'].item()
output_zero  = model_quantized.features[0][0].state_dict()['zero_point'].item()

# get the quantized weight with scale and zero_point  
weight_scale = model_quantized.features[0][0].state_dict()["weight"].q_scale()
weight_zero  = model_quantized.features[0][0].state_dict()["weight"].q_zero_point()
weight_quantized = model_quantized.features[0][0].state_dict()["weight"].int_repr().numpy()
# print(weight_quantized)
# print(weight_quantized.shape)


# bias_quantized,bias_scale,bias_zero= quantize_tensor(model_quantized.features[0][0].state_dict()["bias"])# to quantize the input tensor and return an int8 tensor, scale and zero point
# print(bias_quantized.shape)
bias = model_quantized.features[0][0].state_dict()["bias"].detach().numpy()
# print(input_quantized)
print(type(input_scale))
print(type(output_scale))
print(type(weight_scale))
#%% numpy simulated layer0 convolution function define

def conv_cal(input_quantized, weight_quantized, kernel_size, stride, out_i, out_j, out_k):
    weight = weight_quantized[out_i]
    input = np.zeros((input_quantized.shape[0], kernel_size, kernel_size))
    for i in range(weight.shape[0]):
        for j in range(weight.shape[1]):
            for k in range(weight.shape[2]):
                input[i][j][k] = input_quantized[i][stride*out_j+j][stride*out_k+k]
    # print(np.dot(weight,input))
    # print(input,"\n")
    # print(weight)

    return np.multiply(weight,input).sum()

def QuantizedConv2D(input_scale, input_zero, input_quantized, output_scale, output_zero, weight_scale, weight_zero, weight_quantized, bias, kernel_size, stride, padding, ofm_size):
    output = np.zeros((weight_quantized.shape[0],ofm_size,ofm_size))

    input_quantized_padding = np.full((input_quantized.shape[0],input_quantized.shape[1]+2*padding,input_quantized.shape[2]+2*padding),0)
    zero_temp = np.full(input_quantized.shape,input_zero)
    input_quantized = input_quantized - zero_temp
    for i in range(input_quantized.shape[0]):
        for j in range(padding,padding + input_quantized.shape[1]):
            for k in range(padding,padding + input_quantized.shape[2]):
                input_quantized_padding[i][j][k] = input_quantized[i][j-padding][k-padding]

    zero_temp = np.full(weight_quantized.shape, weight_zero)
    weight_quantized = weight_quantized - zero_temp
    M =  weight_scale*input_scale/output_scale
    for i in range(output.shape[0]):
        for j in range(output.shape[1]):
            for k in range(output.shape[2]):
                # output[i][j][k] = (weight_scale*input_scale)*conv_cal(input_quantized_padding, weight_quantized, kernel_size, stride, i, j, k) + bias[i] #floating_output
                output[i][j][k] = M*conv_cal(input_quantized_padding, weight_quantized, kernel_size, stride, i, j, k) + bias[i]/output_scale + output_zero
                output[i][j][k] = round(output[i][j][k])
                # int_output
    return output


def Short_cut(x, Fx, x_s, x_z, Fx_s):
    #input feature map x and residual map Fx with their scale(s) and zero_point(z)
    M = Fx_s/x_s
    Hx = np.int8((x-x_z)*M + Fx)
    return Hx
#%% convolution function test
# test_data_in = np.array([[[1,2,3,4,5,6],[1,2,3,4,5,6],[1,2,3,4,5,6],[1,2,3,4,5,6],[1,2,3,4,5,6],[1,2,3,4,5,6]]])
# test_filter_in = np.array([[[[1,2,1],[1,2,1],[1,2,1]]]])
# bias = np.array([9])
# # test_out = conv(test_data_in, test_filter_in, 2, bias, 0, 0 ,1 )
# out1_np = QuantizedConv2D(1, 0, test_data_in, 1, 0, 1, 0, test_filter_in, bias, 3, 2, 1, 3)
print(model_quantized)

#%% Short_cut test
# test_data_x = np.array([[[1,2,3,4,5,6],[1,2,3,4,5,6],[1,2,3,4,5,6],[1,2,3,4,5,6],[1,2,3,4,5,6],[1,2,3,4,5,6]]])
# test_data_Fx = np.array([[[1,2,3,4,5,6],[1,2,3,4,5,6],[1,2,3,4,5,6],[1,2,3,4,5,6],[1,2,3,4,5,6],[1,2,3,4,5,6]]])
# test_x_s = 0.5
# test_x_z = 10
# test_Fx_s = 0.5
# test_hx = Short_cut(test_data_x, test_data_Fx, test_x_s, test_x_z, test_Fx_s)
#%% numpy simulated layer0 inference

# torchextractor fetched layer0 result
quantized_model_out1_int8 = np.squeeze(features['features.0.0'].int_repr().numpy())


# print(quantized_model_out1_int8.shape)
# print(quantized_model_out1_int8)
out1_np = QuantizedConv2D(input_scale, input_zero, input_quantized, output_scale, output_zero, weight_scale, weight_zero, weight_quantized, bias, 3, 2, 1, 112)
np.save("out1_np.npy",out1_np)

for i in range(quantized_model_out1_int8.shape[0]):
    for j in range(quantized_model_out1_int8.shape[1]):
        for k in range(quantized_model_out1_int8.shape[2]):
            if(out1_np[i][j][k] < 0):
                out1_np[i][j][k] = 0

print(out1_np)

flag = np.zeros(quantized_model_out1_int8.shape)
for i in range(quantized_model_out1_int8.shape[0]):
    for j in range(quantized_model_out1_int8.shape[1]):
        for k in range(quantized_model_out1_int8.shape[2]):

            if(quantized_model_out1_int8[i][j][k] == out1_np[i][j][k]):
                flag[i][j][k] = 1
                out1_np[i][j][k] = 0
                quantized_model_out1_int8[i][j][k] = 0

# Compare the simulated result to extractor fetched result, gain the total hit rate
print('Total hit rate:',flag.sum()/(112*112*32)*100,'%')
#%% simple function to calculate the shift number of M
def multiply(n, M, P):
    result = M * P
    Mo = int(round(2 ** n * M)) # here we can omit the round operation 

    approx_result = (Mo * P) >> n
    print("n=%d, Mo=%d, approx=%f, error=%f"%\
          (n, Mo, approx_result, result-approx_result))
    return Mo
#%% A test code to check the calculation process
weight_quantized_sample = weight_quantized[1]
M_t = input_scale * weight_scale / output_scale
ifmap_t = np.int32(input_quantized[:,1:4,7:10])
weight_t = np.int32(weight_quantized_sample)
bias_t = bias[1]
bias_q = bias_t/output_scale
res_t = 0
for ch in range(3):
    ifmap_offset = ifmap_t[ch]-np.int32(input_zero)
    weight_offset = weight_t[ch]-np.int32(weight_zero)
    res_ch = np.multiply(ifmap_offset, weight_offset)
    res_ch = np.uint8(M_t*res_ch.sum())
    res_t = res_t + res_ch
res_mul = res_t
for n in range(1, 30):
    res_mul = multiply(n, M_t, res_t)
res_t = round(res_mul + output_zero + bias_q)
print(res_t)





#%% 
fig1=plt.figure()
quantized_model_out1_int8_flat = list(quantized_model_out1_int8.flatten())
quantized_model_out1_int8_plt = [i for i in quantized_model_out1_int8_flat if i != 0]
plt.hist(quantized_model_out1_int8_plt,256)
plt.title('Pytorch output')
plt.xlim([0, 127]);
plt.ylim([0, 1000]);
fig1.show()

fig2=plt.figure()
out1_np_flat = list(out1_np.flatten())
out1_np_plt = [i for i in out1_np_flat if i != 0]
plt.hist(out1_np_plt,256)
plt.title('Numpy output')
plt.xlim([0, 127]);
plt.ylim([0, 1000]);
fig2.show()
