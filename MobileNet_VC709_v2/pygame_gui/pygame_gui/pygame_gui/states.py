import torch
import numpy as np
import torchvision
from PIL import Image
from torchvision import transforms

def quantize_array(iput_array, scale, zero):
    a = iput_array/scale + zero
    a = a.round()
    b = np.clip(a,0,255)
    return b

def dequantize_array(iput_array, scale, zero):
    return scale*(iput_array - zero)

#%%

image_num = 20

true_label_list = np.zeros(image_num).tolist()
true_label_list[0] = "Samoyed"
true_label_list[1] = "tench"
true_label_list[2] = "tiger shark"
true_label_list[3] = "snow leopard"
true_label_list[4] = "Komodo dragon"
true_label_list[5] = "rock python"
true_label_list[6] = "Eskimo dog"
true_label_list[7] = "tank"
true_label_list[8] = "violin"
true_label_list[9] = "hotdog"
true_label_list[10] = "coffee mug"
true_label_list[11] = "bubble"
true_label_list[12] = "bucket"
true_label_list[13] = "goose"
true_label_list[14] = "spider monkey"
true_label_list[15] = "pineapple"
true_label_list[16] = "banana"
true_label_list[17] = "brown bear"
true_label_list[18] = "computer keyboard"
true_label_list[19] = "toilet tissue"



preprocess = transforms.Compose([
    transforms.Resize(256),
    transforms.CenterCrop(224),
    transforms.ToTensor(),
    transforms.Normalize(mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225]),
])

model_quantized = torchvision.models.quantization.mobilenet_v2(pretrained=True, quantize=True)
model_quantized.eval()

with open("D:\\Project_UM\\pygame_gui\\pygame_gui\\pygame_gui\\imagenet_classes.txt", "r") as f:
    categories = [s.strip() for s in f.readlines()]

def calculate(filename = "D:\\Project_UM\\pygame_gui\\pygame_gui\\pygame_gui\\output_file\\output_1000.txt"):
    with open(filename,"r") as f:
        output_1000 = f.readlines()[0].replace(" ","")
    length = int(len(output_1000)/2)
    o1000_list = np.zeros(length).tolist()
    for i in range(0,len(output_1000),2):
        o1000_list[int(i/2)] = output_1000[i] + output_1000[i+1]
        o1000_list[int(i/2)] = int(o1000_list[int(i/2)],16)    
        
    output = np.array(o1000_list)
    qo = output

    
    qo      = torch.tensor(qo)
    qo_top5,label_top5 = torch.topk(qo, 5)
    
    output_fp = dequantize_array(qo, 0.15309934318065643, 75)
    probabilities = torch.nn.functional.softmax(output_fp, dim=0)
    top5_prob, top5_catid = torch.topk(probabilities, 5)
    top5_prob = top5_prob.numpy()*100
    top5_prob = np.around(top5_prob, decimals=1)
    
    top5_qo    = qo_top5.numpy().astype("uint8")
    label_top5 = label_top5.numpy()
    
    top5_label_str = []
    top5_qo_str    = []
    top5_prob_str  = []
     
    for i in range(len(top5_qo)):
        top5_label_str.append(categories[top5_catid[i]])
        top5_qo_str.append(str(top5_qo[i]))
        top5_prob_str.append('%.1f' % top5_prob[i] + "%")
    
    # print(top5_label_str)
    # print(top5_qo_str)
    # print(top5_prob_str)
    
    return top5_label_str, top5_qo_str, top5_prob_str



#%%

class States():
    def __init__(self, ai_settings): 
        """初始化统计信息""" 
        self.ai_settings = ai_settings 
        self.reset_states()
        self.image_index = 0
        self.show        = 0
        self.reset_states()
        
        
    def reset_states(self): 
       """初始化在游戏运行期间可能变化的统计信息""" 
       self.score_list  = ["","","","",""]
       self.label_list  = ["","","","",""]
       self.acc_list    = ["","","","",""]
       self.true_label  = ""
       self.image_index = 0
       self.show        = 0
       self.finish      = 0
       self.image_dir   = self.ai_settings.dir_list[self.image_index]
       
    def update(self):
        if(self.finish == 0):
            self.index      = self.image_index
            self.image_dir  = self.ai_settings.dir_list[self.index]
            self.finish     = 1
            self.true_label = true_label_list[self.index]
            self.image_dir = self.ai_settings.dir_list[self.image_index]
            self.label_list,self.score_list,self.acc_list = calculate()

#%%

'''


import torch
import numpy as np
import torchvision
from PIL import Image
from torchvision import transforms

def quantize_array(iput_array, scale, zero):
    a = iput_array/scale + zero
    a = a.round()
    b = np.clip(a,0,255)
    return b

def dequantize_array(iput_array, scale, zero):
    return scale*(iput_array - zero)

#%%

image_num = 20

true_label_list = np.zeros(image_num).tolist()
true_label_list[0] = "Samoyed"
true_label_list[1] = "tench"
true_label_list[2] = "tiger shark"
true_label_list[3] = "snow leopard"
true_label_list[4] = "Komodo dragon"
true_label_list[5] = "rock python"
true_label_list[6] = "Eskimo dog"
true_label_list[7] = "tank"
true_label_list[8] = "violin"
true_label_list[9] = "hotdog"
true_label_list[10] = "cup"
true_label_list[11] = "bubble"
true_label_list[12] = "bucket"
true_label_list[13] = "goose"
true_label_list[14] = "spider monkey"
true_label_list[15] = "pineapple"
true_label_list[16] = "banana"
true_label_list[17] = "brown bear"
true_label_list[18] = "computer keyboard"
true_label_list[19] = "toilet tissue"



preprocess = transforms.Compose([
    transforms.Resize(256),
    transforms.CenterCrop(224),
    transforms.ToTensor(),
    transforms.Normalize(mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225]),
])

model_quantized = torchvision.models.quantization.mobilenet_v2(pretrained=True, quantize=True)
model_quantized.eval()

with open("C:\\Users\\10637\\Desktop\\new_coe\\imagenet_classes.txt", "r") as f:
    categories = [s.strip() for s in f.readlines()]

def calculate(filename = "D:\\Spyder Project\\mobilenetv2_demo\\pygame_gui\\images_to_be_tested\\image0.JPEG"):
    input_image = Image.open(filename)
    input_tensor = preprocess(input_image)
    input_batch = input_tensor.unsqueeze(0)
    with torch.no_grad():
        output = model_quantized(input_batch)
    probabilities = torch.nn.functional.softmax(output[0], dim=0)
    top5_prob, top5_catid = torch.topk(probabilities, 5)
    top5_prob = top5_prob.numpy()*100
    top5_prob = np.around(top5_prob, decimals=1)

    qo      = quantize_array(output[0].numpy(), 0.15309934318065643, 75)
    qo      = torch.tensor(qo)
    qo_top5,label_top5 = torch.topk(qo, 5)
    
    top5_qo    = qo_top5.numpy().astype("uint8")
    label_top5 = label_top5.numpy()
    
    top5_label_str = []
    top5_qo_str    = []
    top5_prob_str  = []
    for i in range(len(top5_prob)):
        top5_label_str.append(categories[top5_catid[i]])
        top5_qo_str.append(str(top5_qo[i]))
        top5_prob_str.append('%.1f' % top5_prob[i] + "%")
    
    # print(top5_label_str)
    # print(top5_qo_str)
    # print(top5_prob_str)
    
    return top5_label_str, top5_qo_str, top5_prob_str

#%%

class States():
    def __init__(self, ai_settings): 
        """初始化统计信息""" 
        self.ai_settings = ai_settings 
        self.reset_states()
        self.image_index = 0
        self.show        = 0
        self.reset_states()
        
        
    def reset_states(self): 
       """初始化在游戏运行期间可能变化的统计信息""" 
       self.score_list  = ["","","","",""]
       self.label_list  = ["","","","",""]
       self.acc_list    = ["","","","",""]
       self.true_label  = ""
       self.image_index = 0
       self.show        = 0
       self.finish      = 0
       self.image_dir   = self.ai_settings.dir_list[self.image_index]
       
    def update(self):
        if(self.finish == 0):
            self.index      = self.image_index
            self.image_dir  = self.ai_settings.dir_list[self.index]
            self.finish     = 1
            self.true_label = true_label_list[self.index]
            self.image_dir = self.ai_settings.dir_list[self.image_index]
            self.label_list,self.score_list,self.acc_list = calculate(self.image_dir)

            
'''          
  