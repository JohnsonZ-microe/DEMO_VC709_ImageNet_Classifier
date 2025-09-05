# -*- coding: utf-8 -*-
"""
Created on Thu Aug 26 11:37:19 2021

@author: 11351
"""
import numpy as np
import torchvision
import torch
from torchvision import transforms, datasets
from PIL import Image
from torchvision import transforms
import torchextractor as tx
import math
import matplotlib.pyplot as plt

# model_quantized = torchvision.models.mobilenet_v2(pretrained=True)
list_in=[1,2,3,4,4,4,4,4,4,6,6,6,6,6,8,9,10,10]

def polygon_line_fitting(list_in): 
    list_rtn = []
    tunning_point_index = []
    length_index = []
    lencnt = 1
    for i in range(len(list_in)):
        if i == 0:
            tunning_point_index.append(0)
            list_rtn.append(list_in[0])
        elif list_in[i] == list_in[i-1]:
            lencnt = lencnt+1
        else:
            list_rtn.append(list_in[i])
            tunning_point_index.append(i)
            length_index.append(lencnt)
    return list_rtn, tunning_point_index, length_index

list_rtn, tunning_point_index, length_index = polygon_line_fitting(list_in)
    