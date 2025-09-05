`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/31 11:49:02
// Design Name: 
// Module Name: ACC
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

module ACC(
    input clk,
    input rst,
    input ena,
    input signed [7:0] x,
    input signed [7:0] w,
    input signed [31:0] x_z,
    
    output reg signed [31:0] acc_res 
    );
    always@(posedge clk) begin
    if(~rst) begin
       acc_res <= 0;
    end
    else if(ena)
       acc_res <= acc_res + w*(x-x_z);
    else 
       acc_res <= 0;
    end
    
endmodule