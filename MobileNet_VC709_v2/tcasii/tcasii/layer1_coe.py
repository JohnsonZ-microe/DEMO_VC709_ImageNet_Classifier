import pickle
import numpy as np

with open("M1.p", "rb") as f:
    M1_list_bias_fuse = pickle.load(f)
    #此处M1_list_bias_fuse的形状为{32}，即存储了32个数
    
with open("weight.p", "rb") as f:
    weight_quantized_list = pickle.load(f)
    #此处weight_quantized_list 的形状为{32,3,3,3}，即32个卷积核组（每一个包含三个3*3的卷积核），对应输出32通道

M1_list_layer1 = M1_list_bias_fuse
w_layer1 = weight_quantized_list

print(w_layer1.shape)

padding = np.zeros((1,3,3,3),dtype = "int8")
#创建一个全0的卷积核组

w1 = np.concatenate((w_layer1, padding), axis = 0)
#w1为layer1的32个卷积核组最后加上了一个空的卷积核组
w1_9x11x9 = np.zeros((9,11,9))

for i in range(w1.shape[0]):
    depth = int(i/3)
    for j in range(w1.shape[1]):
        for k in range(w1.shape[2]):
            for l in range(w1.shape[3]):
                a = i%3
                w1_9x11x9[k*3+l][depth][a*3+j] = w1[i][j][k][l]
'''
将权重重新装入w1_9x11x9这个张量中。其中第一个维度9代表了第几个bram。k*3+l代表将3*3的卷积核展平
[0,1,2]
[3,4,5]      --->  [0,1,2,3,4,5,6,7,8]
[6,7,8] 
depth代表将卷积核组每三个进行一次划分，33/3=11行。
第三个维度a*3+j则代表了重排后的列索引。
这个重组可以理解为将卷积核某一位置的所有数展平，然后一行一行放入新的张量中，最后存入对应的bram中。
'''
w1_9x11x9 = w1_9x11x9.astype("int8")       

with open("ifmap.p", "rb") as f:
    ifmp0 = pickle.load(f)

b = int(224/3 + 1)
ifmp0_padding = np.full((3,b*3,b*3),101,dtype = "uint8")
#ifmp0_padding的形状为（3，225，225）
for i in range(ifmp0.shape[0]):
    for j in range(ifmp0.shape[1]):
        for k in range(ifmp0.shape[2]):
            ifmp0_padding[i][j][k] = ifmp0[i][j][k]
#ifmp0_padding实际上是在右边加了一列0，下面加了一行0。这个操作使得输入特征图刚好可以被划分为3*3的块。

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

# ifmp0_processed1 = np.full((b*b,9,9),0,dtype = "uint8")

for i in range(b):
    for j in range(b):
        c = i*b + j #number of 3x3 window
        for k in range(ifmp0_padding.shape[0]):
            for l in range(3):
                for m in range(3):
                    ifmp0_processed[l*3+m][c][k] = ifmp0_padding[k][i*3+l][j*3+m]
                    # ifmp0_processed1[c][l*3+m][k] = ifmp0_padding[k][i*3+l][j*3+m]
'''
ifmap根据3*3的块进行划分。行和列划分后有225/3=75个3*3的块，因此i和j代表了3*3块的行索引和列索引。c代表是第几个3*3块。
ifmp0_processed第一维l*3+m中的l代表该3*3块中的行索引，m为列索引。因此可以看出是将每一个3*3块的不同位置的数字存到不同的bram中，和权重的存储方式一样。
k代表输入特征图的channel。因此基于输入特征图是（3，225，225）可以知道每一行其实只存储了3个数字。
因此data的存储方式是将ifmap划分为3*3的窗口，将每一个窗口相同位置的数字存入对应的bram中。由于ifmap只有3个channel，所以每一行只有3个数字。
'''

#%%
bin8  = lambda x : ''.join(reversed( [str((x >> i) & 1) for i in range(8)]))

for i in range(9):
    with open("./layer1_test/weight_layer1_"+str(i)+".txt","w+") as f:
        f.write("memory_initialization_radix=2;\n") # 数据以2进制格式存储
        f.write("memory_initialization_vector=\n")
        for j in range(12):
            temp = ""
            for k in range(9):
                temp = bin8(w1_9x11x9[i][j][k]) + temp
            temp = temp + "\n"
            f.write(temp)
#将权重转换为二进制数后写入对应txt文件
#%%

bin8  = lambda x : ''.join(reversed( [str((x >> i) & 1) for i in range(8)]))

for i in range(ifmp0_processed.shape[0]):
    with open("./layer1_test/ifmp_layer1_"+str(i)+".txt","w+") as f:
        f.write("memory_initialization_radix=2;\n") # 数据以2进制格式存储
        f.write("memory_initialization_vector=\n")
        for j in range(ifmp0_processed.shape[1]):
            temp = ""
            for k in range(ifmp0_processed.shape[2]):
                temp = bin8(ifmp0_processed[i][j][k]) + temp
            temp = temp + "\n"
            f.write(temp)
#将ifmap转换为二进制数后写入对应txt文件
#%%
import pickle
import numpy as np

bin32  = lambda x : ''.join(reversed( [str((x >> i) & 1) for i in range(32)]))


with open("M1.p","rb") as f:
    M1_list_bias_fuse = pickle.load(f)

cout      = len(M1_list_bias_fuse)
remainder = cout%9
if(remainder == 0):
    depth = cout/9
else:
    depth = int(cout/9) + 1
    depth = depth*3
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
#M1的存储方式为每一行存放3个int32数据，每个int32位数据实际上占用了96位。即每一行有96*3=288位数，每个96位数的高64位都是0.
with open("./layer1_test/m1_layer1.txt","w+") as f:
    f.write("memory_initialization_radix=2;\n") # 数据以2进制格式存储
    f.write("memory_initialization_vector=\n")
    for i in range(new_array.shape[0]):
        temp = ""
        for j in range(new_array.shape[1]):
            temp = bin32(new_array[i][j]) + temp
        temp = temp + "\n"
        f.write(temp)
        