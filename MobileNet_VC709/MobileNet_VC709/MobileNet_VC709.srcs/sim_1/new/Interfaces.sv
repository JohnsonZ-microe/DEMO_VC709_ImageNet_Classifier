`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/17 08:04:19
// Design Name: 
// Module Name: Interfaces
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


interface depthwise33_ifc(input bit clk);
    
    logic rst;
    logic [31:0] reg_config_data_in;
    
    logic conv_res_valid;
    
    logic intr_out;
    logic bram_rd_busy_out;
    logic bram_rd_busy_in;   //bram rd busy signal input 
    logic intr_in;          //interupt signal input
    
    clocking cb @(posedge clk);
        output rst, reg_config_data_in, bram_rd_busy_in, intr_in;
        input intr_out, bram_rd_busy_out;
        
endinterface //depthwise33_ifc
