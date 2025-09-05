# -*- coding: utf-8 -*-
"""
Created on Sat Aug  7 17:55:54 2021

@author: 11351
"""

import pickle
import numpy as np

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

    print(zero_point)
    zero_point = int(zero_point)
    q_x = zero_point + x / scale
    q_x.clamp_(qmin, qmax).round_()
    q_x = q_x.round().byte()
    return q_x, scale, zero_point

#%%
import torchvision
model_preextract_quantized = torchvision.models.quantization.mobilenet_v2(pretrained=True, quantize=True)
# print(model_preextract_quantized)

model = torchvision.models.mobilenet_v2(pretrained=True)
import torchextractor as tx
# model_quantized = tx.Extractor(model_preextract_quantized, ["features.0","features.1","features.2","features.3",
#                                                             "features.4","features.5","features.6","features.7",
#                                                             "features.8","features.9","features.10","features.11",
#                                                             "features.12","features.13","features.14","features.15",
#                                                             "features.16","features.17","features.18","classifier"])
layer_names = tx.list_module_names(model)
model_quantized = tx.Extractor(model_preextract_quantized, layer_names)
import os
import torch

def print_model_size(mdl):
    torch.save(mdl.state_dict(), "tmp.pt")
    print("%.2f MB" %(os.path.getsize("tmp.pt")/1e6))
    os.remove('tmp.pt')

print_model_size(model)
print_model_size(model_quantized)
#%%
# Download an example image from the pytorch website
import urllib
url, filename = ("https://github.com/pytorch/hub/raw/master/images/dog.jpg", "dog.jpg")
try: urllib.URLopener().retrieve(url, filename)
except: urllib.request.urlretrieve(url, filename)

# sample execution (requires torchvision)
from PIL import Image
from torchvision import transforms
input_image = Image.open(filename)
preprocess = transforms.Compose([
    transforms.Resize(256),
    transforms.CenterCrop(224),
    transforms.ToTensor(),
    transforms.Normalize(mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225]),
])
input_tensor = preprocess(input_image)
input_batch = input_tensor.unsqueeze(0) # create a mini-batch as expected by the model

# move the input and model to GPU for speed if available
if torch.cuda.is_available():
    input_batch = input_batch.to('cuda')
    model_quantized.to('cuda')

with torch.no_grad():
    output, features  = model_quantized(input_batch)
#%%
print(model_quantized)

#%%
feature_shapes = {name: f.shape for name, f in features.items()}
# print(feature_shapes)
# Tensor of shape 1000, with confidence scores over Imagenet's 1000 classes
# print(output[0])
# The output has unnormalized scores. To get probabilities, you can run a softmax on it.
probabilities = torch.nn.functional.softmax(output[0], dim=0)
# print(probabilities)

# Read the categories
with open("D:\\Project_UM\\MobileNet_VC709\\MobileNet_pytorch\\imagenet_classes.txt", "r") as f:
    categories = [s.strip() for s in f.readlines()]
# Show top categories per image
top5_prob, top5_catid = torch.topk(probabilities, 5)
for i in range(top5_prob.size(0)):
    print(categories[top5_catid[i]], top5_prob[i].item())




#%% 'Extractor' object has no attribute 'features'
with torch.no_grad():
    output,features  = model_preextract_quantized(input_batch)

#%% feature extraction
layer_conv33_out = features['features.0'].int_repr().cpu().detach().numpy()[0]
pickle.dump( layer_conv33_out, open( "D:\Project_UM\MobileNet_VC709\MobileNet_pytorch\pickle_obj\layer_conv33_out.p", "wb" ) )

layer_IRB1_out = features['features.1'].int_repr().cpu().detach().numpy()[0]
layer_IRB2_out = features['features.2'].int_repr().cpu().detach().numpy()[0]
layer_IRB3_out = features['features.3'].int_repr().cpu().detach().numpy()[0]
layer_IRB4_out = features['features.4'].int_repr().cpu().detach().numpy()[0]
layer_IRB5_out = features['features.5'].int_repr().cpu().detach().numpy()[0]
layer_IRB6_out = features['features.6'].int_repr().cpu().detach().numpy()[0]
layer_IRB7_out = features['features.7'].int_repr().cpu().detach().numpy()[0]
layer_IRB8_out = features['features.8'].int_repr().cpu().detach().numpy()[0]
layer_IRB9_out = features['features.9'].int_repr().cpu().detach().numpy()[0]
layer_IRB10_out = features['features.10'].int_repr().cpu().detach().numpy()[0]
layer_IRB11_out = features['features.11'].int_repr().cpu().detach().numpy()[0]
layer_IRB12_out = features['features.12'].int_repr().cpu().detach().numpy()[0]
layer_IRB13_out = features['features.13'].int_repr().cpu().detach().numpy()[0]
layer_IRB14_out = features['features.14'].int_repr().cpu().detach().numpy()[0]
layer_IRB15_out = features['features.15'].int_repr().cpu().detach().numpy()[0]
layer_IRB16_out = features['features.16'].int_repr().cpu().detach().numpy()[0]
layer_IRB17_out = features['features.17'].int_repr().cpu().detach().numpy()[0]
layer_PW18_out = features['features.18'].int_repr().cpu().detach().numpy()[0]
layer_FC2_out = features['classifier'].int_repr().cpu().detach().numpy()[0]
#%% 
def layer_param_key_list_extraction(layer_idx, operation_idx):
    quantized_module_list = []
    quantized_module_list.append(model_quantized.model.features[layer_idx].conv[0])
    quantized_module_list.append(model_quantized.model.features[layer_idx].conv[1])
    quantized_module_list.append(model_quantized.model.features[layer_idx].conv[2])
    layer11_param_list = list(quantized_module_list[operation_idx].state_dict().keys())
    return layer11_param_list

    #%% 
def IRB_layer_param_extraction(model_preextract_quantized, layer_idx):
    #######---------scale extraction -----------------
    print('start param writing, layer: ', layer_idx)
    scale_base_dir = 'D:\\Project_UM\\MobileNet_VC709\\MobileNet_pytorch\\ofmap_saved\\scale_saved\\'
    
    op0_key_list = layer_param_key_list_extraction(layer_idx,0)
    op1_key_list = layer_param_key_list_extraction(layer_idx,1)
    op2_key_list = layer_param_key_list_extraction(layer_idx,2)
    
    
# weight scale extraction
    PW1_weight_scale_filename = 'layer' + str(layer_idx) + '_PW1_weight_scale'
    PW1_weight_scale_file_addr = scale_base_dir + PW1_weight_scale_filename
    DW1_weight_scale_filename = 'layer' + str(layer_idx) + '_DW1_weight_scale'
    DW1_weight_scale_file_addr = scale_base_dir + DW1_weight_scale_filename
    PW2_weight_scale_filename = 'layer' + str(layer_idx) + '_PW2_weight_scale'
    PW2_weight_scale_file_addr = scale_base_dir + PW2_weight_scale_filename
    # layer11_PW1_scale = features['features.11.conv.0'].q_scale()
    # layer11_DW1_scale = features['features.11.conv.1'].q_scale()
    # layer11_PW2_scale = features['features.11.conv.2'].q_scale()
    # print(layer11_output_scale)
    # print(layer11_output_zero_point)
    # print(model_preextract_quantized.features[11].conv[2].state_dict())
    PW1_weight_scale = model_preextract_quantized.features[layer_idx].conv[0].state_dict()[op0_key_list[0]].q_scale()
    DW1_weight_scale = model_preextract_quantized.features[layer_idx].conv[1].state_dict()[op1_key_list[0]].q_scale()
    PW2_weight_scale = model_preextract_quantized.features[layer_idx].conv[2].state_dict()[op2_key_list[0]].q_scale()
    
    np.save(PW1_weight_scale_file_addr, PW1_weight_scale)
    print('PW1_weight_scale = ', PW1_weight_scale)
    np.save(DW1_weight_scale_file_addr, DW1_weight_scale)
    print('DW1_weight_scale = ', DW1_weight_scale)
    np.save(PW2_weight_scale_file_addr, PW2_weight_scale)
    print('PW2_weight_scale = ', PW2_weight_scale)
    
#  output scale extraction
    PW1_output_scale_filename = 'layer' + str(layer_idx) + '_PW1_output_scale'
    PW1_output_scale_file_addr = scale_base_dir + PW1_output_scale_filename
    DW1_output_scale_filename = 'layer' + str(layer_idx) + '_DW1_output_scale'
    DW1_output_scale_file_addr = scale_base_dir + DW1_output_scale_filename
    PW2_output_scale_filename = 'layer' + str(layer_idx) + '_PW2_output_scale'
    PW2_output_scale_file_addr = scale_base_dir + PW2_output_scale_filename
    # layer11_PW1_scale = features['features.11.conv.0'].q_scale()
    # layer11_DW1_scale = features['features.11.conv.1'].q_scale()
    # layer11_PW2_scale = features['features.11.conv.2'].q_scale()
    # print(layer11_output_scale)
    # print(layer11_output_zero_point)
    # print(model_preextract_quantized.features[11].conv[2].state_dict())
    PW1_output_scale = model_preextract_quantized.features[layer_idx].conv[0].state_dict()[op0_key_list[2]].item()
    DW1_output_scale = model_preextract_quantized.features[layer_idx].conv[1].state_dict()[op1_key_list[2]].item()
    PW2_output_scale = model_preextract_quantized.features[layer_idx].conv[2].state_dict()[op2_key_list[2]].item()
    
    np.save(PW1_output_scale_file_addr, PW1_output_scale)
    print('PW1_output_scale = ', PW1_output_scale)
    np.save(DW1_output_scale_file_addr, DW1_output_scale)
    print('DW1_output_scale = ', DW1_output_scale)
    np.save(PW2_output_scale_file_addr, PW2_output_scale)
    print('PW2_output_scale = ', PW2_output_scale)
    

#######---------zero_point extraction -----------------

    zero_point_base_dir = 'D:\\Project_UM\\MobileNet_VC709\\MobileNet_pytorch\\ofmap_saved\\zero_point_saved\\'
    
    PW1_weight_zero_point_filename = 'layer' + str(layer_idx) + '_PW1_weight_zero_point'
    PW1_weight_zero_point_file_addr = zero_point_base_dir + PW1_weight_zero_point_filename
    DW1_weight_zero_point_filename = 'layer' + str(layer_idx) + '_DW1_weight_zero_point'
    DW1_weight_zero_point_file_addr = zero_point_base_dir + DW1_weight_zero_point_filename
    PW2_weight_zero_point_filename = 'layer' + str(layer_idx) + '_PW2_weight_zero_point'
    PW2_weight_zero_point_file_addr = zero_point_base_dir + PW2_weight_zero_point_filename
    
    PW1_weight_zero_point  = model_preextract_quantized.features[layer_idx].conv[0].state_dict()[op0_key_list[0]].q_zero_point()
    DW1_weight_zero_point  = model_preextract_quantized.features[layer_idx].conv[1].state_dict()[op1_key_list[0]].q_zero_point()
    PW2_weight_zero_point  = model_preextract_quantized.features[layer_idx].conv[2].state_dict()[op2_key_list[0]].q_zero_point()
    
    np.save( PW1_weight_zero_point_file_addr, PW1_weight_zero_point)
    print('PW1_weight_zero_point = ', PW1_weight_zero_point)
    np.save( DW1_weight_zero_point_file_addr, DW1_weight_zero_point)
    print('DW1_weight_zero_point = ', DW1_weight_zero_point)
    np.save( PW2_weight_zero_point_file_addr, PW2_weight_zero_point)
    print('PW2_weight_zero_point = ', PW2_weight_zero_point)
    
    
#  output zero_point extraction
    PW1_output_zero_point_filename = 'layer' + str(layer_idx) + '_PW1_output_zero_point'
    PW1_output_zero_point_file_addr = zero_point_base_dir + PW1_output_zero_point_filename
    DW1_output_zero_point_filename = 'layer' + str(layer_idx) + '_DW1_output_zero_point'
    DW1_output_zero_point_file_addr = zero_point_base_dir + DW1_output_zero_point_filename
    PW2_output_zero_point_filename = 'layer' + str(layer_idx) + '_PW2_output_zero_point'
    PW2_output_zero_point_file_addr = zero_point_base_dir + PW2_output_zero_point_filename

    PW1_output_zero_point = model_preextract_quantized.features[layer_idx].conv[0].state_dict()[op0_key_list[3]].item()
    DW1_output_zero_point = model_preextract_quantized.features[layer_idx].conv[1].state_dict()[op1_key_list[3]].item()
    PW2_output_zero_point = model_preextract_quantized.features[layer_idx].conv[2].state_dict()[op2_key_list[3]].item()
    
    np.save(PW1_output_zero_point_file_addr, PW1_output_zero_point)
    print('PW1_output_zero_point = ', PW1_output_zero_point)
    np.save(DW1_output_zero_point_file_addr, DW1_output_zero_point)
    print('DW1_output_zero_point = ', DW1_output_zero_point)
    np.save(PW2_output_zero_point_file_addr, PW2_output_zero_point)
    print('PW2_output_zero_point = ', PW2_output_zero_point)
    
    #######---------weight extraction -----------------

    weight_base_dir = 'D:\\Project_UM\\MobileNet_VC709\\MobileNet_pytorch\\ofmap_saved\\weight_saved\\'
    
    PW1_weight_filename = 'layer' + str(layer_idx) + '_PW1_weight'
    PW1_weight_file_addr = weight_base_dir + PW1_weight_filename
    DW1_weight_filename = 'layer' + str(layer_idx) + '_DW1_weight'
    DW1_weight_file_addr = weight_base_dir + DW1_weight_filename
    PW2_weight_filename = 'layer' + str(layer_idx) + '_PW2_weight'
    PW2_weight_file_addr = weight_base_dir + PW2_weight_filename
    
    PW1_weight = model_preextract_quantized.features[layer_idx].conv[0].state_dict()[op0_key_list[0]].int_repr().numpy()
    DW1_weight = model_preextract_quantized.features[layer_idx].conv[1].state_dict()[op1_key_list[0]].int_repr().numpy()
    PW2_weight = model_preextract_quantized.features[layer_idx].conv[2].state_dict()[op2_key_list[0]].int_repr().numpy()
    
    np.save( PW1_weight_file_addr, PW1_weight)
    np.save( DW1_weight_file_addr, DW1_weight)
    np.save( PW2_weight_file_addr, PW2_weight)
    
    
    
    
    #######---------bias extraction -----------------

    bias_base_dir = 'D:\\Project_UM\\MobileNet_VC709\\MobileNet_pytorch\\ofmap_saved\\bias_saved\\'
    
    PW1_bias_filename = 'layer' + str(layer_idx) + '_PW1_bias'
    PW1_bias_file_addr = bias_base_dir + PW1_bias_filename
    DW1_bias_filename = 'layer' + str(layer_idx) + '_DW1_bias'
    DW1_bias_file_addr = bias_base_dir + DW1_bias_filename
    PW2_bias_filename = 'layer' + str(layer_idx) + '_PW2_bias'
    PW2_bias_file_addr = bias_base_dir + PW2_bias_filename
    
    PW1_bias = model_preextract_quantized.features[layer_idx].conv[0].state_dict()[op0_key_list[1]].detach().numpy()
    DW1_bias = model_preextract_quantized.features[layer_idx].conv[1].state_dict()[op1_key_list[1]].detach().numpy()
    PW2_bias = model_preextract_quantized.features[layer_idx].conv[2].state_dict()[op2_key_list[1]].detach().numpy()
    
    np.save( PW1_bias_file_addr, PW1_bias)
    np.save( DW1_bias_file_addr, DW1_bias)
    np.save( PW2_bias_file_addr, PW2_bias)
    
    #######---------Shortcut parameter extraction -----------------
    try:
        SC_scale_filename = 'layer' + str(layer_idx) + '_SC_scale'
        SC_scale_file_addr = scale_base_dir + SC_scale_filename
        SC_scale = model_preextract_quantized.features[layer_idx].skip_add.state_dict()['scale'].item()
        np.save(SC_scale_file_addr, SC_scale)
        print('SC_scale = ', SC_scale)
        
        SC_zero_point_filename = 'layer' + str(layer_idx) + '_SC_zero_point'
        SC_zero_point_file_addr = zero_point_base_dir + SC_zero_point_filename
        SC_zero_point = model_preextract_quantized.features[layer_idx].skip_add.state_dict()['zero_point'].item()
        np.save(SC_zero_point_file_addr, SC_zero_point)
        print('SC_zero_point = ', SC_zero_point)
    except:
        print('I told you layer ',layer_idx, ' has no SC operation!!')
    return 0

#%%
    IRB_layer_param_extraction(17)
#%%
# layer_names_0 = layer_names.pop(0)

# for i in layer_names:
#     a = features[i].int_repr().cpu().detach().numpy()[0]
#     if (a.all() == layer_conv33_out.all()):
#         print("TRUE")
#         features.remove(i)
#     else:
#         print('False')
#%%
def quantization_function(x, scale, zero_point):
    xq = np.round(x/scale + zero_point)
    return xq
#%%
layer0_param = model_preextract_quantized.features[0][0].state_dict()
layer0_conv_weight = layer0_param['weight']
layer0_conv_weight= layer0_conv_weight.int_repr().cpu().detach().numpy()
pickle.dump( layer0_conv_weight, open( "D:\Project_UM\MobileNet_VC709\MobileNet_pytorch\pickle_obj\layer0_conv_weight.p", "wb" ) )

layer0_conv_zero_point = layer0_param['zero_point'].cpu().detach().numpy()
layer0_conv_scale = layer0_param['scale'].cpu().detach().numpy()
pickle.dump( layer0_conv_scale, open( "D:\Project_UM\MobileNet_VC709\MobileNet_pytorch\pickle_obj\layer0_conv_scale.p", "wb" ) )
layer0_conv_bias = layer0_param['bias']
layer0_conv_bias = layer0_conv_bias.cpu().detach().int_repr().numpy()
# layer0_conv_bias_q, layer0_conv_bias_scale, layer0_conv_bias_zero_point = quantize_tensor(layer0_conv_bias)
# layer0_conv_bias_q = layer0_conv_bias_q.numpy()
pickle.dump( layer0_conv_bias, open( "D:\Project_UM\MobileNet_VC709\MobileNet_pytorch\pickle_obj\layer0_conv_bias.p", "wb" ) )
# pickle.dump( layer0_conv_bias_scale, open( "D:\Project_UM\MobileNet_VC709\MobileNet_pytorch\pickle_obj\layer0_conv_bias_scale.p", "wb" ) )
# pickle.dump( layer0_conv_bias_zero_point, open( "D:\Project_UM\MobileNet_VC709\MobileNet_pytorch\pickle_obj\layer0_conv_bias_zero_point.p", "wb" ) )


input_batch_q, input_scale, input_zero_point = quantize_tensor(input_batch)
input_batch_q = input_batch_q.numpy()[0]
pickle.dump( input_batch_q, open( "D:\Project_UM\MobileNet_VC709\MobileNet_pytorch\pickle_obj\input_batch.p", "wb" ) )
input_scale = input_scale.numpy()
pickle.dump( input_scale, open( "D:\Project_UM\MobileNet_VC709\MobileNet_pytorch\pickle_obj\image_input_scale.p", "wb" ) )
pickle.dump( input_zero_point, open( "D:\Project_UM\MobileNet_VC709\MobileNet_pytorch\pickle_obj\image_input_zero_point.p", "wb" ) )
#%% 
#%%layer0 bias参数提取
# layer0_conv_bias = layer0_param['bias'].int_repr().cpu().detach().numpy()
bias = layer0_param['bias']
print(layer0_param)


print(model_preextract_quantized)
# print(features.state_dict())
# print(model_preextract_quantized)
# print(layer0_param['weight'])
# layer_conv33_out=features['features.0']
# print(layer_conv33_out)
# print(prt)
#%% check the name of layers
for name, module in model_preextract_quantized.named_modules():
    print(name)
    
#%% scale and zeropoint calculate
print(output)
