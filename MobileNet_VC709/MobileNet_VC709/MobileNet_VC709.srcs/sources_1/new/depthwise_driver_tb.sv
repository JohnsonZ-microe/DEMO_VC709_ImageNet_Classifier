`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/17 16:48:42
// Design Name: 
// Module Name: depthwise_driver_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module depthwise_driver_tb;
bit clk;
logic rst;
logic [31:0] reg_config_data_in;
logic [3:0] reg_config_addr;
     
//--  1. Depthwise config register  --//
//--  coding scheme:
//--  [7:0] Ifmap_size  [17:8] Ifmap_channel  [28:18] Ofmap_channel  [29]:stride [30]: enable [31]: conv
logic [7:0] ifmap_size;      
logic [9:0] ifmap_channel;   
logic [10:0] ofmap_channel;  
logic stride;                
logic ena;                   
logic conv;        
logic [7:0] input_zero_point;          


//--  2. Input data and weight base address register --//
//--  coding scheme:
//--  [18:0] ifmap_base_addr  [30:19] Weight_base_addr  [31] ifmap_group_sel
logic [31:0] Input_base_addr;

logic [18:0] ifmap_base_addr;
logic [11:0] Weight_base_addr;
logic ifmap_group_sel;
assign Input_base_addr = {ifmap_group_sel, Weight_base_addr, ifmap_base_addr};

//--  3. output data and bias base address register --//
//--  coding scheme:
//--  [18:0] Ofmap_base_addr  [30:19] Bias_base_addr
logic [31:0] Output_base_addr;
logic [18:0] Ofmap_base_addr;
logic [11:0] Bias_base_addr;
assign Output_base_addr = {1'b0,Bias_base_addr,Ofmap_base_addr};

logic signed [31:0] M0;
logic reg_config_valid;
logic complete;
logic signed [31: 0]bram_ofmap_out_1;
logic signed [31: 0]bram_ofmap_out_2;
logic signed [31: 0]bram_ofmap_out_3;

logic signed [7:0] bram_ofmap_out_sample;

depthwise_driver depthwise_driver0(
    .clk(clk),
    .rst(rst),
    .reg_config_data_in(reg_config_data_in),
    .reg_config_valid(reg_config_valid),
    .reg_config_addr(reg_config_addr),
    .M0(M0),
    .input_zero_point(input_zero_point),
    .complete(complete),
    .bram_ofmap_out_1(bram_ofmap_out_1),
    .bram_ofmap_out_2(bram_ofmap_out_2),
    .bram_ofmap_out_3(bram_ofmap_out_3) //bram's output ifmap data (read data)
    );

always #10 clk = ~clk;

initial begin
rst = 1;
reg_config_data_in = 0;
reg_config_valid=0;
reg_config_addr =0;
M0 = 0;
#10
rst = 0;
#10
rst = 1;
// Depthwise config register
ifmap_size = 224;
ifmap_channel = 3;
ofmap_channel = 32;
stride = 1;
ena = 1;
conv = 1;
M0 = 208;
input_zero_point = 101;
// Input data and weight base address register
ifmap_base_addr = 0;
Weight_base_addr = 0;
ifmap_group_sel = 0;

// output data and bias base address register
Ofmap_base_addr = 0;
Bias_base_addr = 0;
#20
reg_config_addr = 2;
reg_config_data_in = {1'b0,Bias_base_addr,Ofmap_base_addr}; 
reg_config_valid = 1;
#20
reg_config_addr = 1;
reg_config_data_in = {ifmap_group_sel,Weight_base_addr,ifmap_base_addr};
#20
reg_config_addr = 0;
reg_config_data_in = {conv,ena,stride,ofmap_channel,ifmap_channel,ifmap_size};
#20
reg_config_valid = 0;
end

endmodule
