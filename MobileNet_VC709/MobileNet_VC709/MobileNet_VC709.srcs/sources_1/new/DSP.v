`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/31 11:44:27
// Design Name: 
// Module Name: DSP
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


module DSP(
    input clk,
    input rst,
    input signed [7:0] x,
    input signed [7:0] w,
    
    output reg signed [15:0] mul_res
    );
    
    always@(posedge clk) begin
    if(~rst) begin
       mul_res <= 0;
    end
    else begin
       mul_res <= w*x;
    end
    end
endmodule
