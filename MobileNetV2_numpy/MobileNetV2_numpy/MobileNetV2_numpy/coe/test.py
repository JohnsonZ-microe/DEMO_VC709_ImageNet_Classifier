import pickle
import numpy as np
with open("layer51_M1.p", "rb") as f:
    M1_list = pickle.load(f)
print(M1_list[201])
pass