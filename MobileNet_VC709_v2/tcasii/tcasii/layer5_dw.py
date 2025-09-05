import pickle
import numpy as np


with open("D:\\Spyder Project\\mobilenetv2_demo\\layer1_to_53_M_V1_bias32b\\M1_list_bias_fuse.pkl", "rb") as f:
    M1_list_bias_fuse = pickle.load(f)
    
with open("D:\\Spyder Project\\mobilenetv2_demo\\layer1_to_53_M_V1_bias32b\\weight_quantized_list.pkl", "rb") as f:
    weight_quantized_list = pickle.load(f)
      
    
M1_list_layer5 = M1_list_bias_fuse[4]
w_layer5_dw    = weight_quantized_list[4]

print(w_layer5_dw.shape)

#%%

# weight layer5 dw  
    
M1_list_layer5 = M1_list_bias_fuse[4]
w_layer5_dw    = weight_quantized_list[4]

print(w_layer5_dw.shape)

Cout = w_layer5_dw.shape[0]

w_5_reshape = w_layer5_dw.reshape((Cout, 9))
w_layer5_dw = w_layer5_dw.reshape((Cout, 9))

if(Cout%9 == 0):
    kernel_num_div9 = int(Cout/9)
else:
    kernel_num_div9 = int(Cout/9) + 1

depth = kernel_num_div9

w5_dw = np.zeros((9,depth,9))

for i in range(0,Cout,1):
    for j in range(9):
        a = int(i/9)
        b = i%9
        # w5_dw[b][a][j] = w_layer5_dw[i][j]
        w5_dw[j][a][b] = w_layer5_dw[i][j]
                
w5_dw = w5_dw.astype("int8")      

bin8  = lambda x : ''.join(reversed( [str((x >> i) & 1) for i in range(8)]))

for i in range(9):
    with open("D:\\Spyder Project\\mobilenetv2_demo\\layer1_to_53_M_V1_bias32b\\tcasii\\layer5\\weight_layer5_"+str(i)+".txt","w+") as f:
        f.write("memory_initialization_radix=2;\n") # 数据以2进制格式存储
        f.write("memory_initialization_vector=\n")
        for j in range(depth):
            temp = ""
            for k in range(9):
                temp = bin8(w5_dw[i][j][k]) + temp
            temp = temp + "\n"
            f.write(temp)  

#%%

# M1 of layer5

import pickle
import numpy as np

bin32  = lambda x : ''.join(reversed( [str((x >> i) & 1) for i in range(32)]))


with open("D:\\Spyder Project\\mobilenetv2_demo\\layer1_to_53_M_V1_bias32b\\M1_list_bias_fuse.pkl","rb") as f:
    M1_list_bias_fuse = pickle.load(f)[4]

#%%


cout      = len(M1_list_bias_fuse)
remainder = cout%9
if(remainder == 0):
    depth = cout/9
else:
    depth = int(cout/9) + 1
new_array = np.zeros((depth,9),dtype = "int32") 

'''
for i in range(cout):
    a = int(i/3)
    b = i - a*3
    new_array[a][b] = M1_list_bias_fuse[i]
'''

for i in range(cout):
    a = int(i/9)
    b = i%9
    new_array[a][b] = M1_list_bias_fuse[i]

with open("D:\\Spyder Project\\mobilenetv2_demo\\layer1_to_53_M_V1_bias32b\\tcasii\\layer5\\m1_layer5.txt","w+") as f:
    f.write("memory_initialization_radix=2;\n") # 数据以2进制格式存储
    f.write("memory_initialization_vector=\n")
    for i in range(new_array.shape[0]):
        temp = ""
        for j in range(new_array.shape[1]):
            temp = bin32(new_array[i][j]) + temp
        temp = temp + "\n"
        f.write(temp)

w_layer5_dw    = weight_quantized_list[4]
np.save("D:\\Spyder Project\\mobilenetv2_demo\\layer1_to_53_M_V1_bias32b\\tcasii\\layer5\\w_layer5_dw.npy",w_layer5_dw)
