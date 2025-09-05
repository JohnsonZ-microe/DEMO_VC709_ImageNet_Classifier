# -*- coding: utf-8 -*-
"""
Created on Tue Jan 25 12:37:30 2022

@author: 11351
"""

Shift_clamp = open("Shift_clamp.txt","w")

for case_i in range(16):
    with open("Shift_clamp.txt", 'a') as f:
        f.write("  // [%d] shift and clamp\n"%case_i  )
        f.write("  always@(*) begin \n")
        f.write("  if(clamp) begin\n")
        f.write("      if(oblock_out[%d]>0) oblock_write[%d] <= oblock_out[%d]>>16;\n"%(case_i,case_i,case_i))
        f.write("      else oblock_write[%d] <= 0;\n"%case_i)
        f.write("  end\n")
        f.write("  else oblock_write[%d] = oblock_out[%d]>>16;\n"%(case_i,case_i))
        f.write("  end\n")
        f.write("\n")
Shift_clamp.close()


