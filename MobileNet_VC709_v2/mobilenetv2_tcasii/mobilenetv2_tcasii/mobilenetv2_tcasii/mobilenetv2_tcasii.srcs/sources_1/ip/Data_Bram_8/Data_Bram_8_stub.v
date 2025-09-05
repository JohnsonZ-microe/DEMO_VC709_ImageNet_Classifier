// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sun Sep 12 16:54:23 2021
// Host        : LAPTOP-VQNT75JR running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/Project_UM/MobileNet_VC709_v2/mobilenetv2_tcasii/mobilenetv2_tcasii/mobilenetv2_tcasii/mobilenetv2_tcasii.srcs/sources_1/ip/Data_Bram_8/Data_Bram_8_stub.v
// Design      : Data_Bram_8
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx690tffg1761-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_2,Vivado 2018.3" *)
module Data_Bram_8(clka, ena, wea, addra, dina, clkb, enb, addrb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,ena,wea[0:0],addra[13:0],dina[71:0],clkb,enb,addrb[13:0],doutb[71:0]" */;
  input clka;
  input ena;
  input [0:0]wea;
  input [13:0]addra;
  input [71:0]dina;
  input clkb;
  input enb;
  input [13:0]addrb;
  output [71:0]doutb;
endmodule
