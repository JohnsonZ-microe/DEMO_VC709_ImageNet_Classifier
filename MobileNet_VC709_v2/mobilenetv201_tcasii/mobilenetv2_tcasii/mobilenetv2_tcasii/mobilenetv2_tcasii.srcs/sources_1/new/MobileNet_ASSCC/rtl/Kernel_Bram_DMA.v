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


module Kernel_Bram_DMA
#(
    parameter DATA_WIDTH = 8,
    parameter DATA_BRAM_ADDR_WIDTH = 14,
    parameter KERNEL_WIDTH = 8,
    parameter KERNEL_BRAM_ADDR_WIDTH = 16,
    parameter HORIZENTAL_VERTICAL_COUNTER_WIDTH = 8,
    parameter CHANNEL_PARRALISM = 9,
    parameter IFMAP_CHANNEL_WIDTH  = 10,
    parameter OFMAP_CHANNEL_WIDTH  = 11
)
(
    input clk,
    input rst,
    // Kernel BRAM read channel
    input [OFMAP_CHANNEL_WIDTH-1:0] kernel_pw_p,
    input [IFMAP_CHANNEL_WIDTH-1:0] kernel_base_channel,
    input [KERNEL_BRAM_ADDR_WIDTH-1:0] Kernel_base_addr,
    input [IFMAP_CHANNEL_WIDTH-1:0] Ifmap_channel_num,
    
    input [KERNEL_BRAM_ADDR_WIDTH-1:0] M1_base_addr,
    input [1:0] bram_st,
    
    output [CHANNEL_PARRALISM*DATA_WIDTH-1 : 0] kernel0_input, kernel1_input, kernel2_input,
    output [CHANNEL_PARRALISM*DATA_WIDTH-1 : 0] kernel3_input, kernel4_input, kernel5_input,
    output [CHANNEL_PARRALISM*DATA_WIDTH-1 : 0] kernel6_input, kernel7_input, kernel8_input,
    
    input [CHANNEL_PARRALISM*DATA_WIDTH-1 : 0] kernel0_read_input, kernel1_read_input, kernel2_read_input,
    input [CHANNEL_PARRALISM*DATA_WIDTH-1 : 0] kernel3_read_input, kernel4_read_input, kernel5_read_input,
    input [CHANNEL_PARRALISM*DATA_WIDTH-1 : 0] kernel6_read_input, kernel7_read_input, kernel8_read_input,
    //Weight BRAM driver
    output kernel_bram_en,
    output reg [KERNEL_BRAM_ADDR_WIDTH-1:0] kernel_read_addr0, kernel_read_addr1, kernel_read_addr2,
    output reg [KERNEL_BRAM_ADDR_WIDTH-1:0] kernel_read_addr3, kernel_read_addr4, kernel_read_addr5,
    output reg [KERNEL_BRAM_ADDR_WIDTH-1:0] kernel_read_addr6, kernel_read_addr7, kernel_read_addr8,
    
    //M1 BRAM driver
    output M1_bram_en,
    output reg [KERNEL_BRAM_ADDR_WIDTH-1:0] M1_read_addr,
    input [9*32-1:0] M1_bram_in,
    output [9*32-1:0] M1_out
    );
    
    assign kernel_bram_en = (bram_st==1'b1);
    
    assign kernel0_input = kernel0_read_input;
    assign kernel1_input = kernel1_read_input;
    assign kernel2_input = kernel2_read_input;
    assign kernel3_input = kernel3_read_input;
    assign kernel4_input = kernel4_read_input;
    assign kernel5_input = kernel5_read_input;
    assign kernel6_input = kernel6_read_input;
    assign kernel7_input = kernel7_read_input;
    assign kernel8_input = kernel8_read_input;
    
    reg [KERNEL_BRAM_ADDR_WIDTH-1:0] kernel_read_base_p;
    
    always@(posedge clk) begin
        if(!rst) kernel_read_base_p <= 0;
        else kernel_read_base_p <= kernel_pw_p*Ifmap_channel_num;

    end
    
    
    always@(posedge clk) begin
        if(!rst) begin
            kernel_read_addr0 <= 0;
            kernel_read_addr1 <= 0;
            kernel_read_addr2 <= 0;
            kernel_read_addr3 <= 0;
            kernel_read_addr4 <= 0;
            kernel_read_addr5 <= 0;
            kernel_read_addr6 <= 0;
            kernel_read_addr7 <= 0;
            kernel_read_addr8 <= 0;
        end
        else begin
            kernel_read_addr0 <= Kernel_base_addr + kernel_read_base_p + kernel_base_channel;
            kernel_read_addr1 <= Kernel_base_addr + kernel_read_base_p + kernel_base_channel;
            kernel_read_addr2 <= Kernel_base_addr + kernel_read_base_p + kernel_base_channel;
            kernel_read_addr3 <= Kernel_base_addr + kernel_read_base_p + kernel_base_channel;
            kernel_read_addr4 <= Kernel_base_addr + kernel_read_base_p + kernel_base_channel;
            kernel_read_addr5 <= Kernel_base_addr + kernel_read_base_p + kernel_base_channel;
            kernel_read_addr6 <= Kernel_base_addr + kernel_read_base_p + kernel_base_channel;
            kernel_read_addr7 <= Kernel_base_addr + kernel_read_base_p + kernel_base_channel;
            kernel_read_addr8 <= Kernel_base_addr + kernel_read_base_p + kernel_base_channel;
        end
    end
    
    assign M1_bram_en = (bram_st==1'b1);
    
    assign M1_out = M1_bram_in;
    
    reg [OFMAP_CHANNEL_WIDTH-1:0] kernel_pw_p_delay_1;
    always@(posedge clk) begin
        if(!rst) kernel_pw_p_delay_1 <= 0;
        else kernel_pw_p_delay_1 <= kernel_pw_p;
    end
    always@(posedge clk) begin 
        if(!rst) M1_read_addr <= 0;
        else M1_read_addr <= M1_base_addr + kernel_pw_p_delay_1; 
    end
    
endmodule
