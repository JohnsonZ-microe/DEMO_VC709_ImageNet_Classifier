`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/10 00:44:54
// Design Name: 
// Module Name: ReLUandShift
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
(* dont_touch = "true"*)module ReLUandShift
#(
    parameter Num_Shift = 16
)
    (
    input signed [31:0] msm_shifted,
    input relu_enable,
    input signed [7:0] output_zero,
    output reg [7:0] ReLU_out
    );
    
    reg [31:0] rectifier_out;
    wire signed [31:0] mem_offset;
    assign mem_offset = msm_shifted-output_zero;
    //ReLUandshift
    always@(*)  begin
    if (relu_enable)
        rectifier_out = (mem_offset>0)? mem_offset>>Num_Shift: output_zero;
    else
        rectifier_out = mem_offset>>Num_Shift;
    end
    
    always@(*)begin
        if(rectifier_out[31:8] == 'd0)
            ReLU_out <= rectifier_out[7:0];
        else
            ReLU_out <= {8{1'b1}};
    end
endmodule
