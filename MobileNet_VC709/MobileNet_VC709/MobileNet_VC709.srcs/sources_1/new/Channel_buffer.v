`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/30 21:28:58
// Design Name: 
// Module Name: Channel_buffer
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


module Channel_buffer(
    input clk,
    input rst,
    input channel_load,
    input channel_disboarding,
    input signed [32*320-1:0] result_in,
    input signed [31:0] M0,
    input signed [31:0] bias_in,
    input ReLU_ena,
    
    output [7:0] ReLU_output
    );
    
    reg signed [31:0] ReLU_input;
    
    integer byte_index;
    reg [32*320-1:0] channel_reg;
    
    always@(posedge clk) begin
    if(!rst) 
        channel_reg <= 0;
    else if(channel_load) 
        for (byte_index = 0; byte_index <= 320-1; byte_index = byte_index+1) begin
        channel_reg[(byte_index*32) +: 32 ] <= result_in[(byte_index*32) +: 32 ] * M0;
        end
    else if(channel_disboarding) begin
        for (byte_index = 1; byte_index <= 320-1; byte_index = byte_index+1) begin
        channel_reg[((byte_index-1)*32) +: 32 ] <= channel_reg[(byte_index*32) +: 32 ];
        end
        ReLU_input <= channel_reg[31:0];
    end
    else
        channel_reg <= channel_reg;
    end
    
    ReLU_shift_and_concat ReLU_shift_and_concat1(
    .enable(ReLU_ena),
    .conv_res(ReLU_input),
    .bias(bias_in),
    .Relu_out(ReLU_output)
);


endmodule
