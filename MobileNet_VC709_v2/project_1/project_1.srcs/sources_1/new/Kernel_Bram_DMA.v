`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/08 15:30:33
// Design Name: 
// Module Name: Kernel_Bram_DMA
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


module Kernel_Bram_DMA(
    input clk,
    input rst,
    // Kernel BRAM read channel
    input [CHANNEL_COUNTER_WIDTH-1:0] kernel_base_channel,
    input [DATA_BRAM_ADDR_WIDTH-1:0] Kernel_base_addr,
    
    output [CHANNEL_PARRALISM*DATA_WIDTH-1 : 0] kernel0_input, kernel1_input, kernel2_input,
    output [CHANNEL_PARRALISM*DATA_WIDTH-1 : 0] kernel3_input, kernel4_input, kernel5_input,
    output [CHANNEL_PARRALISM*DATA_WIDTH-1 : 0] kernel6_input, kernel7_input, kernel8_input,
    
    //Kernel BRAM driver
    output kernel_bram_en,
    output [KERNEL_BRAM_ADDR_WIDTH-1:0] kernel_read_addr0, kernel_read_addr1, kernel_read_addr2,
    output [KERNEL_BRAM_ADDR_WIDTH-1:0] kernel_read_addr3, kernel_read_addr4, kernel_read_addr5,
    output [KERNEL_BRAM_ADDR_WIDTH-1:0] kernel_read_addr6, kernel_read_addr7, kernel_read_addr8
    
    );
endmodule
