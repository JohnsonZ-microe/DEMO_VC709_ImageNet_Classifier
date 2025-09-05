# -*- coding: utf-8 -*-
"""
Created on Fri Sep 17 17:54:48 2021

@author: 11351
"""

import numpy as np
import pickle

lines0 = []
with open('D:\\Project_UM\\MobileNet_VC709\\MobileNet_pytorch\\simulation_grasp\\conv_out.txt', encoding='utf8') as f0:
    lines = f0.readlines()
    
value = []
verification_obj = np.zeros((32,112,112))
Truth_table = np.zeros((32,112,112))
Ch = 0
H = 0
V = 0
ofmp1 = pickle.load( open("D:\\Project_UM\\MobileNet_VC709\\MobileNet_VC709\\simulation_reference\\ofmp1.pkl",'rb'))
for i in range(len(lines)):
    if(i%36 == 32 or i%36 == 33 or i%36 == 34 or i%36 == 35):
        Ch = 0
        continue
    else:
        if(H == 1):
            print("H =1 Stop!")
        if(Ch == 31):
            print("Ch = 31 Stop!")
        if(H == 2):
            print("H =2 Stop!")
        verification_obj[Ch][V][H] = int(lines[i].strip())
        if(verification_obj[Ch][V][H] == ofmp1[Ch][V][H]):
            Truth_table[Ch][V][H] = True
        else:
            Truth_table[Ch][V][H] = False
        if(Ch == 31): 
            Ch = 0
            H = H + 1
        Ch = Ch + 1
        if(H == 111):
            print("H = 111 Stop!")
        if(H == 112):
            H = 0
            V = V + 1
        if(V == 111):
            print("V = 111 Stop!")
        if(V == 112):
            print("Conv finished")
            break
#%%
accuracy = Truth_table.sum()/(112*112*32)
print('Accuracy = ',accuracy*100, '%')
verification_round1_ofmap = pickle.dump(verification_obj ,open( "D:\\Project_UM\\MobileNet_VC709\\MobileNet_pytorch\\simulation_grasp\\verification_round1_ofmap.p", "wb" ) )
verification_round1_Truthtable = pickle.dump(Truth_table ,open( "D:\\Project_UM\\MobileNet_VC709\\MobileNet_pytorch\\simulation_grasp\\verification_round1_Truthtable.p", "wb" ) )
verification_round1_accuracy = pickle.dump(accuracy ,open( "D:\\Project_UM\\MobileNet_VC709\\MobileNet_pytorch\\simulation_grasp\\verification_round1_accuracy.p", "wb" ) )


# value1 = []
# value2 = []
# value3 = []
# cat = []
# channel_pack = 0
# point = 0
# for i in range(len(lines)):
#     # if(i%12 == 0):
#     #     continue
#     # else
#         cat.append(lines[i][82:92])
#         value1.append(int(lines[i][82:84].strip()))
#         value2.append(int(lines[i][86:88].strip()))
#         value3.append(int(lines[i][90:92].strip()))
#         if(i==)
