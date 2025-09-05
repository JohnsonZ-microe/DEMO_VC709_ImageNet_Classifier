import pickle
import numpy as np
from mkdir import mkdir

layer = 6
 
mkpath="D:\\Spyder Project\\mobilenetv2_demo\\layer1_to_53_M_V1_bias32b\\tcasii\\layer"+ str(layer)
mkdir(mkpath)

with open("D:\\Spyder Project\\mobilenetv2_demo\\layer1_to_53_M_V1_bias32b\\M1_list_bias_fuse.pkl", "rb") as f:
    M1_list_bias_fuse = pickle.load(f)
    
with open("D:\\Spyder Project\\mobilenetv2_demo\\layer1_to_53_M_V1_bias32b\\weight_quantized_list.pkl", "rb") as f:
    weight_quantized_list = pickle.load(f)
      
    

#%%

# weight layer4 pw  
    
M1_list_layer4 = M1_list_bias_fuse[layer-1]
w_layer4_pw    = weight_quantized_list[layer-1]

print(w_layer4_pw.shape)

Cin  = w_layer4_pw.shape[1]
Cout = w_layer4_pw.shape[0]

w_4_reshape = w_layer4_pw.reshape((Cout, Cin))
w_layer4_pw = w_layer4_pw.reshape((Cout, Cin))
if(Cout%9 == 0):
    kernel_num_div9 = int(Cout/9)
else:
    kernel_num_div9 = int(Cout/9) + 1
if(Cin%9 == 0):
    Cin_div9        = int(Cin/9)
else:
    Cin_div9        = int(Cin/9) + 1
depth           = kernel_num_div9*Cin_div9

w4_pw = np.zeros((9,depth,9))

for i in range(0,Cout,1):
    for j in range(0,Cin,1):
        a = int(i/9)
        b = i%9
        c = int(j/9)
        d = j%9
        w4_pw[b][a*Cin_div9 + c][d] = w_layer4_pw[i][j]
                
w4_pw = w4_pw.astype("int8")  

#%%

bin8  = lambda x : ''.join(reversed( [str((x >> i) & 1) for i in range(8)]))

for i in range(9):
    with open("D:\\Spyder Project\\mobilenetv2_demo\\layer1_to_53_M_V1_bias32b\\tcasii\\layer"+ str(layer) +"\\weight_layer"+ str(layer) +"_"+str(i)+".txt","w+") as f:
        f.write("memory_initialization_radix=2;\n") # 数据以2进制格式存储
        f.write("memory_initialization_vector=\n")
        for j in range(depth):
            temp = ""
            for k in range(9):
                temp = bin8(w4_pw[i][j][k]) + temp
            temp = temp + "\n"
            f.write(temp)
#%%
bin32  = lambda x : ''.join(reversed( [str((x >> i) & 1) for i in range(32)]))

cout      = len(M1_list_layer4)
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
    new_array[a][b] = M1_list_layer4[i]

with open("D:\\Spyder Project\\mobilenetv2_demo\\layer1_to_53_M_V1_bias32b\\tcasii\\layer"+ str(layer) +"\\m1_layer"+ str(layer) +".txt","w+") as f:
    f.write("memory_initialization_radix=2;\n") # 数据以2进制格式存储
    f.write("memory_initialization_vector=\n")
    for i in range(new_array.shape[0]):
        temp = ""
        for j in range(new_array.shape[1]):
            temp = bin32(new_array[i][j]) + temp
        temp = temp + "\n"
        f.write(temp)

w_layer4_pw    = weight_quantized_list[layer-1]
np.save("D:\\Spyder Project\\mobilenetv2_demo\\layer1_to_53_M_V1_bias32b\\tcasii\\layer"+ str(layer) +"\\w_layer"+ str(layer) +"_pw.npy",w_layer4_pw)