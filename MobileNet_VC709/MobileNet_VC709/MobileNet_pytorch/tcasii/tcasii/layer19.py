import pickle
import numpy as np

with open("D:\\Spyder Project\\mobilenetv2_demo\\layer1_to_53_M_V1_bias32b\\M1_list_bias_fuse.pkl", "rb") as f:
    M1_list_bias_fuse = pickle.load(f)
    
with open("D:\\Spyder Project\\mobilenetv2_demo\\layer1_to_53_M_V1_bias32b\\weight_quantized_list.pkl", "rb") as f:
    weight_quantized_list = pickle.load(f)
      
    
M1_list_layer19 = M1_list_bias_fuse[18]
w_layer19_pw    = weight_quantized_list[18]

print(w_layer19_pw.shape)

Cin  = w_layer19_pw.shape[1]
Cout = w_layer19_pw.shape[0]

w_19_reshape = w_layer19_pw.reshape((Cout, Cin))
w_layer19_pw = w_layer19_pw.reshape((Cout, Cin))
if(Cout%9 == 0):
    kernel_num_div9 = int(Cout/9)
else:
    kernel_num_div9 = int(Cout/9) + 1
if(Cin%9 == 0):
    Cin_div9        = int(Cin/9)
else:
    Cin_div9        = int(Cin/9) + 1
depth           = kernel_num_div9*Cin_div9

w19_pw = np.zeros((9,depth,9))

for i in range(0,Cout,1):
    for j in range(0,Cin,1):
        a = int(i/9)
        b = i%9
        c = int(j/9)
        d = j%9
        w19_pw[b][a*Cin_div9 + c][d] = w_layer19_pw[i][j]
                
w19_pw = w19_pw.astype("int8")      

#%%
bin8  = lambda x : ''.join(reversed( [str((x >> i) & 1) for i in range(8)]))

for i in range(9):
    with open("D:\\Spyder Project\\mobilenetv2_demo\\layer1_to_53_M_V1_bias32b\\tcasii\\layer19\\weight_layer19_"+str(i)+".txt","w+") as f:
        f.write("memory_initialization_radix=2;\n") # 数据以2进制格式存储
        f.write("memory_initialization_vector=\n")
        for j in range(depth):
            temp = ""
            for k in range(9):
                temp = bin8(w19_pw[i][j][k]) + temp
            temp = temp + "\n"
            f.write(temp) 

#%%
'''

# input fm layer19

with open("D:\\Spyder Project\\mobilenetv2_demo\\layer1_to_53_M_V1_bias32b\\layer19\\0.pkl", "rb") as f:
    ifmp_layer19 = pickle.load(f)[18]    

#%%
b = int(224/3 + 1)
ifmp0_padding = np.full((3,b*3,b*3),101,dtype = "uint8")
for i in range(ifmp0.shape[0]):
    for j in range(ifmp0.shape[1]):
        for k in range(ifmp0.shape[2]):
            ifmp0_padding[i][j][k] = ifmp0[i][j][k]


'''
ifmp0_processed = np.zeros((9,int(b*b/3),9),dtype = "uint8")

for i in range(b):
    for j in range(b):
        c = i*b + j #number of 3x3 window
        d = c%3 
        e = int(c/3) #depth of bram
        for k in range(ifmp0_padding.shape[0]):
            for l in range(3):
                for m in range(3):
                    ifmp0_processed[l*3+m][e][d*3+k] = ifmp0_padding[k][i*3+l][j*3+m]
'''    

ifmp0_processed = np.full((9,b*b,9),0,dtype = "uint8")

ifmp0_processed1 = np.full((b*b,9,9),0,dtype = "uint8")

for i in range(b):
    for j in range(b):
        c = i*b + j #number of 3x3 window
        for k in range(ifmp0_padding.shape[0]):
            for l in range(3):
                for m in range(3):
                    ifmp0_processed[l*3+m][c][k] = ifmp0_padding[k][i*3+l][j*3+m]
                    ifmp0_processed1[c][l*3+m][k] = ifmp0_padding[k][i*3+l][j*3+m]



            
#%%

bin8  = lambda x : ''.join(reversed( [str((x >> i) & 1) for i in range(8)]))

for i in range(ifmp0_processed.shape[0]):
    with open("./layer1/ifmp_layer1_"+str(i)+".txt","w+") as f:
        f.write("memory_initialization_radix=2;\n") # 数据以2进制格式存储
        f.write("memory_initialization_vector=\n")
        for j in range(ifmp0_processed.shape[1]):
            temp = ""
            for k in range(ifmp0_processed.shape[2]):
                temp = bin8(ifmp0_processed[i][j][k]) + temp
            temp = temp + "\n"
            f.write(temp)

#%%
import pickle
import numpy as np

bin32  = lambda x : ''.join(reversed( [str((x >> i) & 1) for i in range(32)]))


with open("D:\\Spyder Project\\mobilenetv2_demo\\layer1_to_53_M_V1_bias32b\\M1_list_bias_fuse.pkl","rb") as f:
    M1_list_bias_fuse = pickle.load(f)[0]

cout      = len(M1_list_bias_fuse)
remainder = cout%3
if(remainder == 0):
    depth = cout/3
else:
    depth = int(cout/3) + 1
new_array = np.zeros((depth,9),dtype = "int32") 

'''
for i in range(cout):
    a = int(i/3)
    b = i - a*3
    new_array[a][b] = M1_list_bias_fuse[i]
'''

for i in range(cout):
    a = int(i/3)
    b = i - a*3
    new_array[a][b*3] = M1_list_bias_fuse[i]

with open("D:\\Spyder Project\\mobilenetv2_demo\\layer1_to_53_M_V1_bias32b\\tcasii\\layer1\\m1_layer1.txt","w+") as f:
    f.write("memory_initialization_radix=2;\n") # 数据以2进制格式存储
    f.write("memory_initialization_vector=\n")
    for i in range(new_array.shape[0]):
        temp = ""
        for j in range(new_array.shape[1]):
            temp = bin32(new_array[i][j]) + temp
        temp = temp + "\n"
        f.write(temp)
        
        
'''



    


