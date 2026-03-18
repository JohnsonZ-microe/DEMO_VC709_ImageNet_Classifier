// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Tue Mar 10 16:30:58 2026
// Host        : DESKTOP-0U402MD running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               D:/Postgraduate/project/MobileNet/mobilenetv2_tcasii/mobilenetv2_tcasii/mobilenetv2_tcasii/mobilenetv2_tcasii.srcs/sources_1/ip/Kernel_Bram_1/Kernel_Bram_1_stub.v
// Design      : Kernel_Bram_1
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx690tffg1761-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_2,Vivado 2018.3" *)
module Kernel_Bram_1(clka, ena, wea, addra, dina, clkb, enb, addrb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,ena,wea[0:0],addra[15:0],dina[71:0],clkb,enb,addrb[15:0],doutb[71:0]" */;
  input clka;
  input ena;
  input [0:0]wea;
  input [15:0]addra;
  input [71:0]dina;
  input clkb;
  input enb;
  input [15:0]addrb;
  output [71:0]doutb;
endmodule
