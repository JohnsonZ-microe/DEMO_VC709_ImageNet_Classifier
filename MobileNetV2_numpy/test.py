# -*- coding: utf-8 -*-
"""
Created on Thu Nov 25 21:50:51 2021

@author: 11351
"""

import torch
from torch import nn

out_features = 48
in_features  = 24
w = nn.Parameter(torch.zeros([out_features, in_features]))
w_min, _ = torch.min(w, dim=1, out=None)
w_max, _ = torch.max(w, dim=1, out=None)

# w_max = torch.Tensor([1,2,3,4,5,6,7,8,9,10])
# w_min = torch.Tensor([-1,-2,-3,-4,-5,-6,-7,-8,-9,-10])
x = torch.stack([w_max.abs(), w_min.abs()], dim=1)
scale = torch.max(x, dim=1)
print(scale)