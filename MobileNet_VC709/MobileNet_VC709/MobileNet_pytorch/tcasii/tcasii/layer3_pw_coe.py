import pickle
import numpy as np


with open("D:\\Spyder Project\\mobilenetv2_demo\\layer1_to_53_M_V1_bias32b\\M1_list_bias_fuse.pkl", "rb") as f:
    M1_list_bias_fuse = pickle.load(f)
    
with open("D:\\Spyder Project\\mobilenetv2_demo\\layer1_to_53_M_V1_bias32b\\weight_quantized_list.pkl", "rb") as f:
    weight_quantized_list = pickle.load(f)
      
    
M1_list_layer3 = M1_list_bias_fuse[2]
w_layer3_pw    = weight_quantized_list[2]

print(w_layer3_pw.shape)

#%%

# weight layer3 pw  
    
M1_list_layer3 = M1_list_bias_fuse[2]
w_layer3_dw    = weight_quantized_list[2]

print(w_layer3_dw.shape)

Cin  = w_layer3_pw.shape[1]
Cout = w_layer3_pw.shape[0]

w_3_reshape = w_layer3_pw.reshape((Cout, Cin))
w_layer3_pw = w_layer3_pw.reshape((Cout, Cin))
if(Cout%9 == 0):
    kernel_num_div9 = int(Cout/9)
else:
    kernel_num_div9 = int(Cout/9) + 1
if(Cin%9 == 0):
    Cin_div9        = int(Cin/9)
else:
    Cin_div9        = int(Cin/9) + 1
depth           = kernel_num_div9*Cin_div9

w3_pw = np.zeros((9,depth,9))

for i in range(0,Cout,1):
    for j in range(0,Cin,1):
        a = int(i/9)
        b = i%9
        c = int(j/9)
        d = j%9
        w3_pw[b][a*Cin_div9 + c][d] = w_layer3_pw[i][j]
                
w3_pw = w3_pw.astype("int8")  

#%%

bin8  = lambda x : ''.join(reversed( [str((x >> i) & 1) for i in range(8)]))

for i in range(9):
    with open("D:\\Spyder Project\\mobilenetv2_demo\\layer1_to_53_M_V1_bias32b\\tcasii\\layer3\\weight_layer3_"+str(i)+".txt","w+") as f:
        f.write("memory_initialization_radix=2;\n") # 数据以2进制格式存储
        f.write("memory_initialization_vector=\n")
        for j in range(depth):
            temp = ""
            for k in range(9):
                temp = bin8(w3_pw[i][j][k]) + temp
            temp = temp + "\n"
            f.write(temp)
#%%
bin32  = lambda x : ''.join(reversed( [str((x >> i) & 1) for i in range(32)]))

cout      = len(M1_list_layer3)
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
    new_array[a][b] = M1_list_layer3[i]

with open("D:\\Spyder Project\\mobilenetv2_demo\\layer1_to_53_M_V1_bias32b\\tcasii\\layer3\\m1_layer3.txt","w+") as f:
    f.write("memory_initialization_radix=2;\n") # 数据以2进制格式存储
    f.write("memory_initialization_vector=\n")
    for i in range(new_array.shape[0]):
        temp = ""
        for j in range(new_array.shape[1]):
            temp = bin32(new_array[i][j]) + temp
        temp = temp + "\n"
        f.write(temp)

w_layer3_pw    = weight_quantized_list[2]
np.save("D:\\Spyder Project\\mobilenetv2_demo\\layer1_to_53_M_V1_bias32b\\tcasii\\layer3\\w_layer3_pw.npy",w_layer3_pw)