# -*- coding: utf-8 -*-
"""
Created on Sun Sep  5 00:57:16 2021

@author: 11351
"""
#####  -------------------------------------------------  #####
##   This model is for hardware verification                    ##########
##   Checking the first few outputs from the Vivado simulation  ########## 


import pickle;
import numpy as np

# Depthwise33 module simulation 
#%%
ifmp1_before_minus_input_zero = pickle.load( open("D:\\Project_UM\\MobileNet_VC709\\MobileNet_VC709\\simulation_reference\\ifmp1_before_minus_input_zero.pkl",'rb'))
M0_Sigma = pickle.load( open("D:\\Project_UM\\MobileNet_VC709\\MobileNet_VC709\\simulation_reference\\M0_Sigma.pkl",'rb'))
M1_fuse_layer1 = pickle.load( open("D:\\Project_UM\\MobileNet_VC709\\MobileNet_VC709\\simulation_reference\\M1_fuse_layer1.pkl",'rb'))
ofmp1 = pickle.load( open("D:\\Project_UM\\MobileNet_VC709\\MobileNet_VC709\\simulation_reference\\ofmp1.pkl",'rb'))
Sigma = pickle.load( open("D:\\Project_UM\\MobileNet_VC709\\MobileNet_VC709\\simulation_reference\\Sigma.pkl",'rb'))
w1_int8 = pickle.load( open("D:\\Project_UM\\MobileNet_VC709\\MobileNet_VC709\\simulation_reference\\w1_int8.pkl",'rb'))
M0_list_int = pickle.load( open("D:\\Project_UM\\MobileNet_VC709\\MobileNet_VC709\\simulation_reference\M0_list_int.pkl",'rb'))
M1_list_bias_fuse = pickle.load( open("D:\\Project_UM\\MobileNet_VC709\\MobileNet_VC709\\simulation_reference\M1_list_bias_fuse.pkl",'rb'))
# # print((1151490+2121732)/2**16)
# # print(208*(1016+1054+219232))
print(w1_int8[3])
# a0 = (77-101)*28 + (75-101)*82 + (101-101)*10 -39*(59-101) -59*(74-101) -9*(92-101)
# a1 = (76-101)*58 + (99-101)*127 + (85-101)*24 -69*(63-101) -127*(79-101) -16*(79-101)
# a2 = (68-101)*10 + (106-101)*39 + (66-101)*2 -13*(53-101) -33*(74-101) -1*(63-101)
# m = 208*(a0+a1+a2)
a1 = 0
a2 = 0
a3 = 0
a4 = (192-101)*(14)
a5 = (218-101)*(43)
a6 = (149-101)*(-64)
a7 = (109-101)*(5)
a8 = (112-101)*(67)
a9 = (83-101)*(-76)
sum_0 = a1 + a2 + a3 + a4 + a5 + a6 + a7 + a8 + a9
sum_0_merge = sum_0 * 208 + 1164688

b1 = 0
b2 = 0
b3 = 0
b4 = (205-101)*(10)
b5 = (230-101)*(112)
b6 = (168-101)*(-128)
b7 = (125-101)*(11)
b8 = (121-101)*(127)
b9 = (94-101)*(-128)
sum_1 = b1 + b2 + b3 + b4 + b5 + b6 + b7 + b8 + b9
t1 = b1 + b2 
t2 = b3 + b4 
t3 = b5 + b6
t4 = b7 + b8


c1 = 0
c2 = 0
c3 = 0
c4 = (194-101)*(9)
c5 = (220-101)*(18)
c6 = (166-101)*(-18)
c7 = (116-101)*(0)
c8 = (108-101)*(19)
c9 = (84-101)*(-31)
sum_2 = c1 + c2 + c3 + c4 + c5 + c6 + c7 + c8 + c9
merge = 208*(sum_0 + sum_1 + sum_2) + 1164688
ofmap = merge >> 16

# Pointwise33 module simulation 
# ifmp4_before_minus_input_zero = pickle.load( open("D:\\Project_UM\\MobileNet_VC709\\MobileNet_VC709\\simulation_reference\\layer2_PW1_simu\\ifmp4_before_minus_input_zero.pkl",'rb'))
# M0_Sigma_layer4 = pickle.load( open("D:\\Project_UM\\MobileNet_VC709\\MobileNet_VC709\\simulation_reference\\layer2_PW1_simu\\M0_Sigma_layer4.pkl",'rb'))
# ofmp4 = pickle.load( open("D:\\Project_UM\\MobileNet_VC709\\MobileNet_VC709\\simulation_reference\\layer2_PW1_simu\\ofmp4.pkl",'rb'))
# Sigma_layer4 = pickle.load( open("D:\\Project_UM\\MobileNet_VC709\\MobileNet_VC709\\simulation_reference\\layer2_PW1_simu\\Sigma_layer4.pkl",'rb'))
# w_int8_layer4 = pickle.load( open("D:\\Project_UM\\MobileNet_VC709\\MobileNet_VC709\\simulation_reference\\layer2_PW1_simu\\w_int8_layer4.pkl",'rb'))
# M0_list_int = pickle.load( open("D:\\Project_UM\\MobileNet_VC709\\MobileNet_VC709\\simulation_reference\\M0_list_int.pkl",'rb'))
# M1_list_bias_fuse = pickle.load( open("D:\\Project_UM\\MobileNet_VC709\\MobileNet_VC709\\simulation_reference\\M1_list_bias_fuse.pkl",'rb'))

#%%

ofmp2 = np.load('D:\\Project_UM\\MobileNet_VC709\\MobileNet_VC709\\sumulation_coes\\layer1to3\\ofmp_layer2_dw.npy')
w_layer2_dw = np.load('D:\\Project_UM\\MobileNet_VC709\\MobileNet_VC709\\sumulation_coes\\layer1to3\\w_layer2_dw.npy')
print(w_layer2_dw[0])