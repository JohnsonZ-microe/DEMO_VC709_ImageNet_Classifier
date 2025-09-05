`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/30 12:03:31
// Design Name: 
// Module Name: Mul_Zero_Cal
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


module Mul_Zero_Cal(
    input clk,
    input rst,
    input [7:0] w_zero_point,
    input [7:0] x_zero_point,
    
    input signed [7:0] weight,
    input [7:0] x,
    
    output signed [31:0] res
    );
    
    wire signed [8:0] x_offset;
    assign x_offset = {1'b0, x} -  x_zero_point;
    wire signed [8:0] weight_offset;

    
endmodule
