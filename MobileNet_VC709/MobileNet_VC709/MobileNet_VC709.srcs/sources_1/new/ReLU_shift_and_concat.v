`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/05 01:08:13
// Design Name: 
// Module Name: ReLU_shift_and_concat
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


module ReLU_shift_and_concat
#(
parameter Num_Shift = 16
)
(
    input enable,
    input signed [31:0] conv_res,
    input signed [31:0] bias,
    output [7:0] Relu_out
    );

wire signed [31:0] shifter_out;
reg [31:0] rectifier_out;
assign shifter_out = conv_res+bias;

always@(*)  begin
if (enable)
    rectifier_out = (shifter_out>0)? shifter_out>>Num_Shift: 0;
else
    rectifier_out = shifter_out>>Num_Shift;
end

reg [7:0] handler_out;
always@(*) begin
    if(rectifier_out[31:8]==0) begin
        handler_out = rectifier_out[7:0];
    end
    else begin
        handler_out = 8'hff;
    end
end
assign Relu_out = handler_out;
endmodule
