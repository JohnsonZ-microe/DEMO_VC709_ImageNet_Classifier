# -*- coding: utf-8 -*-
"""
Created on Mon Aug 30 12:13:09 2021

@author: 11351
"""



#Verified all zero_point of convolution's weight are zeros

import numpy as np

## 
layer_idx = 2
zero_point_base_dir = 'D:\\Project_UM\\MobileNet_VC709\\MobileNet_pytorch\\ofmap_saved\\zero_point_saved\\'
PW1_weight_zero_point_filename = 'layer' + str(layer_idx) + '_PW1_weight_zero_point.npy'
PW1_weight_zero_point_file_addr = zero_point_base_dir + PW1_weight_zero_point_filename
DW1_weight_zero_point_filename = 'layer' + str(layer_idx) + '_DW1_weight_zero_point.npy'
DW1_weight_zero_point_file_addr = zero_point_base_dir + DW1_weight_zero_point_filename
PW2_weight_zero_point_filename = 'layer' + str(layer_idx) + '_PW2_weight_zero_point.npy'
PW2_weight_zero_point_file_addr = zero_point_base_dir + PW2_weight_zero_point_filename


PW1_zero_point = np.load(PW1_weight_zero_point_file_addr)
print(PW1_zero_point)
DW1_zero_point = np.load(DW1_weight_zero_point_file_addr)
print(DW1_zero_point)
PW2_zero_point = np.load(PW2_weight_zero_point_file_addr)
print(PW2_zero_point)