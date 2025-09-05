`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/30 20:14:57
// Design Name: 
// Module Name: Weight_loaded_buffer
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
module Weight_loaded_buffer(
    input clk,
    input rst,
    input signed [7:0] weight_in,            //input [7:0] weight to load
    input weight_loading,                    //input indicates the weight is loading
    
    output [8*320-1:0] weight_out            //output [8*320-1:0] weight output
    );
    integer byte_index;
    reg [8*320-1:0] weight_reg;
    
    always@(posedge clk) begin
    if(!rst) 
        weight_reg <= 0;
    else if(weight_loading) begin
        weight_reg[7:0] <= weight_in;
        for (byte_index = 0; byte_index <= 320-2; byte_index = byte_index+1) begin
        weight_reg[((byte_index+1)*8) +: 8 ] <= weight_reg[(byte_index*8) +: 8 ];
        end
    end
    else
        weight_reg <= weight_reg;
    end 
    assign weight_out=weight_reg;
    
endmodule
