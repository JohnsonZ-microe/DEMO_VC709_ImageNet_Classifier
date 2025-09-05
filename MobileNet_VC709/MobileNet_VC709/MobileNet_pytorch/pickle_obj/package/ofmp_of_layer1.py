import numpy as np
import torchvision
import torch
from torchvision import transforms, datasets
from PIL import Image
from torchvision import transforms
import torchextractor as tx


def quantize_tensor(x, num_bits=8):# to quantize the input tensor and return an int8 tensor, scale and zero point

    qmin = 0.
    qmax = 2.**num_bits - 1.
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

    print(zero_point)
    zero_point = int(zero_point)
    q_x = zero_point + x / scale
    q_x.clamp_(qmin, qmax).round_()
    q_x = q_x.round().byte()
    return q_x, scale, zero_point



#########################################################################################
##### Processing of input image
#########################################################################################

normalize = transforms.Normalize(mean=[0.485, 0.456, 0.406],
                                     std=[0.229, 0.224, 0.225])
test_transform = transforms.Compose([
        transforms.Resize(256),
        transforms.CenterCrop(224),
        transforms.ToTensor(),
        normalize,])
test_dataset = datasets.folder.ImageFolder(root='D:\\test', transform=test_transform)
test_loader = torch.utils.data.DataLoader(dataset=test_dataset,
                                          batch_size=128,
                                          shuffle=False, num_workers=10, pin_memory=True)
preprocess = transforms.Compose([
    transforms.Resize(256),
    transforms.CenterCrop(224),
    transforms.ToTensor(),
    transforms.Normalize(mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225]),
])

filename = "D:\\test\\n01440764\\ILSVRC2012_val_00000293.JPEG"
input_image = Image.open(filename)
input_tensor = preprocess(input_image)
input_batch = input_tensor.unsqueeze(0)
#########################################################################################
#########################################################################################
#########################################################################################

# ofmp of layer1 before adding torchextractor
a,b,c = quantize_tensor(input_batch)# to quantize the input tensor and return an int8 tensor, scale and zero point
input_qa = torch.quantize_per_tensor(torch.tensor(input_batch), b, c, torch.quint8)# Using quantize_per_tensor method of torch

model_quantized = torchvision.models.quantization.mobilenet_v2(pretrained=True, quantize=True)# Load a quantized mobilenet_v2 model
model_quantized.eval()
with torch.no_grad():
    output = model_quantized.features[0][0](input_qa)# Ofmp of layer1, datatype : quantized_tensor

print("FM of layer1 before tx_extractor:\n",output.int_repr())# Ofmp of layer1, datatype : int8 tensor

output1_clone = output.int_repr().detach().numpy()# Clone ofmp of layer1, datatype : ndarray



#########################################################################################
#########################################################################################
#########################################################################################

# ofmp of layer1 after adding torchextractor
model_quantized = tx.Extractor(model_quantized, ["features.0.0"])#Capture of the module inside first layer

model_output, features = model_quantized(input_batch)# Forward propagation
# feature_shapes = {name: f.shape for name, f in features.items()}
print(features['features.0.0']) # Ofmp of layer1, datatype : quantized_tensor
out1_clone = features['features.0.0'].int_repr().numpy() # Clone ofmp of layer1, datatype : ndarray

if(out1_clone.all() == output1_clone.all()):
    print(0)
else:
    print(1)


# #############################################################################################
# #############################################################################################
# #############################################################################################


print(b,"\n")
print(c,"\n")
