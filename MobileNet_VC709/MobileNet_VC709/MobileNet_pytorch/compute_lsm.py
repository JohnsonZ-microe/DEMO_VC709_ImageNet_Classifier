# -*- coding: utf-8 -*-
"""
Created on Tue Aug 31 15:34:57 2021

@author: 11351
"""

def compute_lcm(x, y):

   # choose the greater number
   if x > y:
       greater = x
   else:
       greater = y

   while(True):
       if((greater % x == 0) and (greater % y == 0)):
           lcm = greater
           break
       greater += 1

   return lcm

num1 = 49
num2 = 256

print("The L.C.M. is", compute_lcm(num1, num2))