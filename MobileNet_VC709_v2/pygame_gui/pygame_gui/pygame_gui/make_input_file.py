# %%
import numpy as np
from torchvision import transforms
from PIL import Image
from settings import Settings
 
Sw = 0.002889582421630621
So = 0.015018309466540813

image_num = 20

def hex_ext32(h):
    z = np.zeros(8,dtype = "int32").tolist()
    for i in range(len(z)):
        z[i] = str(z[i])
    for i in range(len(h)-2):
        z[len(z)-1-i] = h[len(h)-1-i]
        
    return ''.join(z)

def hex_ext8(h):
    if(len(h) == 2 + 2):
        return h[2:]
    else:
        z = np.zeros(2,dtype = "int32").tolist()
        for i in range(len(z)):
            z[i] = str(z[i])
        for i in range(len(h)-2):
            z[len(z)-1-i] = h[len(h)-1-i]
            
        return ''.join(z)


def quantize_tensor(x, num_bits=8):  # to quantize the input tensor and return an int8 tensor, scale and zero point

    qmin = 0.
    qmax = 2. ** num_bits - 1.
    min_val, max_val = x.min(), x.max()

    scale = (max_val - min_val) / (qmax - qmin)

    initial_zero_point = qmin - min_val / scale

    zero_point = 0
    if initial_zero_point < qmin:
        zero_point = qmin
    elif initial_zero_point > qmax:
        zero_point = qmax
    else:
        zero_point = initial_zero_point

    # print(zero_point)
    zero_point = int(zero_point)
    q_x = zero_point + x / scale
    q_x.clamp_(qmin, qmax).round_()
    q_x = q_x.round().byte()
    return q_x, scale, zero_point


def relu(x, x_zero):
    if len(x.shape) > 1:
        for i in range(x.shape[0]):
            relu(x[i], x_zero)
    elif len(x.shape) == 1:
        for i in range(x.shape[0]):
            if x[i] < x_zero:
                x[i] = x_zero

    return x

preprocess = transforms.Compose([
    transforms.Resize(256),
    transforms.CenterCrop(224),
    transforms.ToTensor(),
    transforms.Normalize(mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225]),
])

ai_settings = Settings()

def make_uart_input(image_index):
    image_dir = ai_settings.dir_list[image_index]
    filename = image_dir
    
    input_image = Image.open(filename)
    input_tensor = preprocess(input_image)
    input_batch = input_tensor.unsqueeze(0)
    input_quantized, input_scale, input_zero = quantize_tensor(
        input_batch)  # to quantize the input tensor and return an uint8 tensor, scale and zero point
    input_quantized = input_quantized.detach().numpy()[0].astype("uint8")
    iq_reshape = input_quantized.reshape(3*224*224)
    
    M0 = round(input_scale.item()*Sw/So*(2**16))
    input_zero = hex(int(input_zero))
    M0 = hex_ext32(hex(int(M0)))
    
    with open("D:\\Project_UM\\pygame_gui\\pygame_gui\\pygame_gui\\input_file\\uart_input_file.txt" ,"w") as f:
       f.write(M0)
       f.write(input_zero[2:])
       for j in range(int(len(iq_reshape)/2)):
           temp = iq_reshape[j] 
           temp  = hex_ext8(hex(temp))
           f.write(temp)
    
    # with open("D:\\Spyder Project\\mobilenetv2_demo\\pygame_gui\\input_file\\uart_input_file.txt" ,"w+") as f:
    #     f.write(M0)
    #     f.write(input_zero[2:])
    #     for j in range(len(iq_reshape)):
    #         temp = iq_reshape[j] 
    #         temp  = hex_ext8(hex(temp))
    #         f.write(temp)