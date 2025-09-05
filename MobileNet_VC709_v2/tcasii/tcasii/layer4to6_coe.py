import os
from mkdir import mkdir
from shutil import copyfile

w_file_name_len = 19

n1 = 4
n2 = 5
n3 = 6

folder_dir = "D:\\Spyder Project\\mobilenetv2_demo\\layer1_to_53_M_V1_bias32b\\tcasii\\layer"
file1 = folder_dir + str(n1) +"\\"
file2 = folder_dir + str(n2) +"\\"
file3 = folder_dir + str(n3) +"\\"

w_folder_dir = folder_dir = "D:\\Spyder Project\\mobilenetv2_demo\\layer1_to_53_M_V1_bias32b\\tcasii\\layer"+str(n1)+"to"+str(n3)+"\\"
mkdir(w_folder_dir)

addr_w  = []
addr_m1 = []

addr_w.append(0)
addr_m1.append(0)

def walkFile(file, key="weight"):
    txt_dir_list = []
    for root, dirs, files in os.walk(file):
        for f in files:
            if((".txt" in f) and (key in f)):
                txt_dir_list.append(os.path.join(root, f))

    return txt_dir_list

txt_dir_list1 = walkFile(file1)
txt_dir_list2 = walkFile(file2)
txt_dir_list3 = walkFile(file3)

for i in range(len(txt_dir_list1)):
    copyfile(txt_dir_list1[i], w_folder_dir + txt_dir_list1[i][-w_file_name_len:])

w_txt_dir_list = walkFile(w_folder_dir)


for i in range(len(w_txt_dir_list)):
    with open (w_txt_dir_list[i],"a+") as fw:
        with open(txt_dir_list2[i], "r") as f2:
            data2 = f2.readlines()[2:]
            l2 = len(data2)
            for j in range(len(data2)):
                fw.write(data2[j])
                
        with open(txt_dir_list3[i], "r") as f3:
            data3 = f3.readlines()[2:]
            l3 = len(data3)
            for j in range(len(data3)):
                fw.write(data3[j])


#%%

l1 = 13

def walkFile(file, key="m1"):
    txt_dir_list = []
    for root, dirs, files in os.walk(file):
        for f in files:
            if((".txt" in f) and (key in f)):
                txt_dir_list.append(os.path.join(root, f))

    return txt_dir_list

txt_dir_list1 = walkFile(file1)
txt_dir_list2 = walkFile(file2)
txt_dir_list3 = walkFile(file3)


for i in range(len(txt_dir_list1)):
    copyfile(txt_dir_list1[i], w_folder_dir + txt_dir_list1[i][-l1:])

w_txt_dir_list = walkFile(w_folder_dir)

with open (w_txt_dir_list[0],"a+") as fw:
    with open(txt_dir_list2[0], "r") as f2:
        data2 = f2.readlines()[2:]
        for j in range(len(data2)):
            fw.write(data2[j])
            
    with open(txt_dir_list3[0], "r") as f3:
        data3 = f3.readlines()[2:]
        for j in range(len(data3)):
            fw.write(data3[j])
#%%

# cal lenth addr of w_file and m1_file
import numpy as np

txt_dir_list1 = walkFile(file1,key="weight")
txt_dir_list2 = walkFile(file2,key="weight")
txt_dir_list3 = walkFile(file3,key="weight")

with open(txt_dir_list1[0], "r") as f1:
            data1 = f1.readlines()[2:]
            l1 = len(data1)
with open(txt_dir_list2[0], "r") as f2:
            data2 = f2.readlines()[2:]
            l2 = len(data2)
with open(txt_dir_list3[0], "r") as f3:
            data3 = f3.readlines()[2:]
            l3 = len(data3)

addr_w = np.zeros(3).tolist()

addr_w[0] = l1
addr_w[1] = l2 + l1
addr_w[2] = l3 + l2 + l1


#%%

txt_dir_list1 = walkFile(file1,key="m1")
txt_dir_list2 = walkFile(file2,key="m1")
txt_dir_list3 = walkFile(file3,key="m1")

with open(txt_dir_list1[0], "r") as f1:
            data1 = f1.readlines()[2:]
            l1 = len(data1)
with open(txt_dir_list2[0], "r") as f2:
            data2 = f2.readlines()[2:]
            l2 = len(data2)
with open(txt_dir_list3[0], "r") as f3:
            data3 = f3.readlines()[2:]
            l3 = len(data3)

addr_m1 = np.zeros(3).tolist()

addr_m1[0] = l1
addr_m1[1] = l2 + l1
addr_m1[2] = l3 + l2 + l1

