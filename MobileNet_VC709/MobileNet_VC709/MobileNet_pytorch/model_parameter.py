# -*- coding: utf-8 -*-
"""
Created on Sat Aug 21 12:24:54 2021

@author: 11351
"""

import pickle
import numpy
import sys

#%%

def pad_with(vector, pad_width, iaxis, kwargs):
    pad_value = kwargs.get('padder', 10)
    vector[:pad_width[0]] = pad_value
    vector[-pad_width[1]:] = pad_value
    
def conv_(img, conv_filter, stride, input_zero_point, weight_zero_point, M):
    filter_size = conv_filter.shape[1]
    result = numpy.zeros((numpy.uint8(img.shape[0]/stride),numpy.uint8(img.shape[1]/stride)))
    #Looping through the image to apply the convolution operation.
    
    #padding 
    img_padding = numpy.pad(img, 1, pad_with, padder = 0)
    
    ofmap_r = 0
    for r in numpy.uint8(numpy.arange(1, img_padding.shape[0]-1, stride)):
        ofmap_c = 0
        for c in numpy.uint8(numpy.arange(1, img_padding.shape[0]-1, stride)):
            """
            Getting the current region to get multiplied with the filter.
            How to loop through the image and get the region based on 
            the image and filer sizes is the most tricky part of convolution.
            """
            leftarm = numpy.uint16(numpy.floor(filter_size/2.0))
            rightarm = numpy.uint16(numpy.ceil(filter_size/2.0))
            curr_region = img_padding[r-leftarm:r+rightarm, 
                              c-leftarm:c+rightarm]
            #Element-wise multipliplication between the current region and the filter.
            curr_result = M*(curr_region-input_zero_point) * (conv_filter-weight_zero_point)
            conv_sum = numpy.sum(curr_result) #Summing the result of multiplication.
            result[ofmap_r][ofmap_c] = conv_sum #Saving the summation in the convolution layer feature map.
            ofmap_c = ofmap_c + 1
        ofmap_r = ofmap_r + 1
    return result


def conv(img, conv_filter, stride, layer0_conv_bias, input_zero_point, weight_zero_point, M):
    if len(img.shape) > 2 or len(conv_filter.shape) > 3: # Check if number of image channels matches the filter depth.
        if img.shape[0] != conv_filter.shape[1]:
            print("Error: Number of channels in both image and filter must match.")
            sys.exit()
    if conv_filter.shape[2] != conv_filter.shape[3]: # Check if filter dimensions are equal.
        print('Error: Filter must be a square matrix. I.e. number of rows and columns must match.')
        sys.exit()
    if conv_filter.shape[2]%2==0: # Check if filter diemnsions are odd.
        print('Error: Filter must have an odd size. I.e. number of rows and columns must be odd.')
        sys.exit()

    # An empty feature map to hold the output of convolving the filter(s) with the image.
    feature_maps = numpy.zeros((conv_filter.shape[0],
                                numpy.uint8(img.shape[1]/stride), 
                                numpy.uint8(img.shape[2]/stride)))

    # Convolving the image by the filter(s).
    for filter_num in range(conv_filter.shape[0]):
        print("Filter ", filter_num + 1)
        curr_filter = conv_filter[filter_num, :] # getting a filter from the bank.
        """ 
        Checking if there are mutliple channels for the single filter.
        If so, then each channel will convolve the image.
        The result of all convolutions are summed to return a single feature map.
        """
        if curr_filter.shape[0]>1:
            conv_map = numpy.round(conv_(img[0, :, :], curr_filter[0, :, :], stride, input_zero_point, weight_zero_point, M)) + numpy.round(layer0_conv_bias[0]*M)  # Array holding the sum of all feature maps.
            for ch_num in range(1, curr_filter.shape[-1]): # Convolving each channel with the image and summing the results.
                conv_map = conv_map + numpy.round(conv_(img[ch_num, :, :], 
                                  curr_filter[ch_num, :, :], stride, input_zero_point, weight_zero_point, M)) +  numpy.round(layer0_conv_bias[ch_num] *M)
        else: # There is just a single channel in the filter.
            conv_map = numpy.round(conv_(img[0], curr_filter[0], stride, input_zero_point, weight_zero_point, M)) + numpy.round(layer0_conv_bias[0]*M)
        feature_maps[filter_num, :, :] = conv_map # Holding feature map with the current filter.
    return feature_maps # Returning all feature maps.

def relu(feature_map):
    #Preparing the output of the ReLU activation function.
    relu_out = numpy.zeros(feature_map.shape)
    for map_num in range(feature_map.shape[-1]):
        for r in numpy.arange(0,feature_map.shape[0]):
            for c in numpy.arange(0, feature_map.shape[1]):
                relu_out[r, c, map_num] = numpy.max([feature_map[r, c, map_num], 0])
    return relu_out

## %%
layer0_conv_bias = pickle.load( open( "D:\Project_UM\MobileNet_VC709\MobileNet_pytorch\pickle_obj\layer0_conv_bias.p", "rb" ) )
layer0_conv_weight = pickle.load( open( "D:\Project_UM\MobileNet_VC709\MobileNet_pytorch\pickle_obj\layer0_conv_weight.p", "rb" ) )
layer_conv33_out = pickle.load( open( "D:\Project_UM\MobileNet_VC709\MobileNet_pytorch\pickle_obj\layer_conv33_out.p", "rb" ) )
input_batch = pickle.load( open( "D:\Project_UM\MobileNet_VC709\MobileNet_pytorch\pickle_obj\input_batch.p", "rb" ) )
layer_conv_scale = pickle.load( open( "D:\Project_UM\MobileNet_VC709\MobileNet_pytorch\pickle_obj\layer0_conv_scale.p", "rb" ) )
input_scale = pickle.load( open( "D:\Project_UM\MobileNet_VC709\MobileNet_pytorch\pickle_obj\image_input_scale.p", "rb" ) )
input_zero_point = pickle.load( open( "D:\Project_UM\MobileNet_VC709\MobileNet_pytorch\pickle_obj\image_input_zero_point.p", "rb" ) )
weight_scale = 0.0029
weight_zero_point = 0
M = input_scale*weight_scale/layer_conv_scale
print(M)
layer_conv33_out_simu0 = conv(input_batch, layer0_conv_weight, 2, layer0_conv_bias, input_zero_point, weight_zero_point, M)
layer_conv33_out_simu0 = relu(layer_conv33_out_simu0)
# layer_conv33_out_simu0 = layer_conv33_out_simu0 * layer_conv_scale

# layer0_conv_bias_scale = pickle.load( open( "D:\Project_UM\MobileNet_VC709\MobileNet_pytorch\pickle_obj\layer0_conv_bias_scale.p", "rb" ) )
# layer0_conv_bias_zero_point = pickle.load( open( "D:\Project_UM\MobileNet_VC709\MobileNet_pytorch\pickle_obj\layer0_conv_bias_zero_point.p", "rb" ) )
#%%
# print(layer0_conv_weight[0])
# 
#%% Convolution numpy simulation test
# test_data_in = numpy.array([[[1,2,3,4,5,6],[1,2,3,4,5,6],[1,2,3,4,5,6],[1,2,3,4,5,6],[1,2,3,4,5,6],[1,2,3,4,5,6]]])
# test_filter_in = numpy.array([[[[1,2,1],[1,2,1],[1,2,1]]]])
# bias = numpy.array([0])
# test_out = conv(test_data_in, test_filter_in, 2, bias, 0, 0 ,1 )

## 3-D bar chart plot
from mpl_toolkits.mplot3d import axes3d
import matplotlib.pyplot as plt
fig=plt.figure()
ax = fig.add_subplot(projection='3d')
from matplotlib import style
style.use('ggplot')
nx, ny = (112, 112)
x = numpy.linspace(0, 111, nx)
y = numpy.linspace(0, 111, ny)
xv, yv = numpy.meshgrid(x, y, sparse=False, indexing='ij')
xv = xv.flatten()
yv = yv.flatten()
z = numpy.zeros(12544)

dx = 0.25*numpy.ones(12544)
dy = 0.25*numpy.ones(12544)
dz = layer_conv33_out_simu0[1].flatten()
ax.bar3d(xv, yv, z, dx, dy, dz, color = 'c')
plt.title('Numpy Simulated Ofmap Distribution')
fig.show()

fig1=plt.figure()
ax1 = fig1.add_subplot(projection='3d')
style.use('ggplot')
dz1 = layer_conv33_out[1].flatten()
ax1.bar3d(xv, yv, z, dx, dy, dz1, color = 'm')
fig1.show()
plt.title('Original Pytorch Ofmap Distribution')
#%%

