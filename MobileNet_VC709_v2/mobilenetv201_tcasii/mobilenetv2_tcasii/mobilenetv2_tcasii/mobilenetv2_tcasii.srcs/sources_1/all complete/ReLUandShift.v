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


module ReLUandShift
#(
    parameter Num_Shift = 16
)
    (
    input signed [31:0] msm_shifted,
    input relu_enable,
    input [7:0] output_zero,
    output reg [7:0] ReLU_out
    );
    wire[31:0] test;
    wire[31:0] test1;
    wire signed [31:0] test2;
    wire[31:0] test3;
    reg signed [31:0] rectifier_out;
    wire[31:0] test4;
    // wire signed [31:0] mem_offset;
    // assign mem_offset = msm_shifted-output_zero;
    //assign mem_offset = (msm_shifted>>Num_Shift)+output_zero;
    //ReLUandshift
    assign test = $signed(msm_shifted + 32'd32768)>>>Num_Shift;
    assign test1 = $signed(msm_shifted + 32'd32768)>>>Num_Shift + $signed({24'd0,output_zero});
    assign test2 = $signed(msm_shifted + 32'd32768)>>>Num_Shift + $signed({24'd0,output_zero});
    assign test3 = ($signed(msm_shifted + 32'd32768)>>>Num_Shift) + $signed({24'd0,output_zero});
    assign test4 = (msm_shifted + 32'd32768)>>>Num_Shift + {24'd0,output_zero};
    always@(*)  begin
    if (relu_enable)
        //rectifier_out = ($signed(msm_shifted>>>Num_Shift) + $signed({24'd0,output_zero})> output_zero)? $signed(msm_shifted>>>Num_Shift) + $signed({24'd0,output_zero}) : output_zero;
        if(msm_shifted[15:0]== 16'h8000 && (msm_shifted[16]==output_zero[0]))begin
            rectifier_out = (msm_shifted> 0)?((msm_shifted+32'd32768)>>>Num_Shift) - 1  : output_zero;
        end
        else begin
            rectifier_out = (msm_shifted> 0)? (msm_shifted+32'd32768)>>>Num_Shift : output_zero;
        end
    else
        if(msm_shifted[15:0]== 16'h8000 && (msm_shifted[16]==output_zero[0]))begin
            rectifier_out = ($signed(msm_shifted + 32'd32768)>>>Num_Shift) + $signed({24'd0,output_zero}) - 1;
        end
        else begin
            rectifier_out = ($signed(msm_shifted + 32'd32768)>>>Num_Shift) + $signed({24'd0,output_zero});
        end
    end
    
    always @(*) begin
        if (rectifier_out <= 0)
            ReLU_out = 8'd0;           // 低端饱和到 0
        else if (rectifier_out >= 32'sd255)
            ReLU_out = 8'd255;         // 高端饱和到 255
        else
            ReLU_out = rectifier_out[7:0];    // 正常取低8位
    end
endmodule

