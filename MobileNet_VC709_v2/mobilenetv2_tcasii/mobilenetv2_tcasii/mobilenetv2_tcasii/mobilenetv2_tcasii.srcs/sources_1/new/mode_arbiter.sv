`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/21 18:33:45
// Design Name: 
// Module Name: mode_arbiter
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

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/09 21:45:32
// Design Name: 
// Module Name: mode_arbiter
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


(* dont_touch = "true"*)(* keep_hierarchy = "yes" *)module mode_arbiter
#(
    parameter BRAM_BAND_WIDTH = 72,
    parameter DATA_WIDTH = 8
)
(
    input clk,
    input rst,
    input [31:0] array_mac0_out, array_mac1_out, array_mac2_out,  
    input [31:0] array_mac3_out, array_mac4_out, array_mac5_out,
    input [31:0] array_mac6_out, array_mac7_out, array_mac8_out,
    input [2:0] mode,
    input relu_enable,
    input sum_valid,
    input [7:0] output_zero,
    
//    //       --------     DEBUG  -------            //
//    output [DATA_WIDTH-1:0] conv_output0, conv_output1, conv_output2,
//    //---------------------------------------------//
    
    output reg [BRAM_BAND_WIDTH-1:0] calculation_res,
    output reg write_valid
    );
    
//----------------- Normal CONV Mode -------------------//
    reg [31:0] conv_add_0, conv_add_1, conv_add_2;
    
    reg [1:0] conv_cnt;
    
    always@(posedge clk) begin
        if(!rst) begin
            conv_add_0 <= 0;
            conv_add_1 <= 0;
            conv_add_2 <= 0;
        end
        else if(mode==3'd1 && sum_valid) begin  // Conv Mode
            conv_add_0 <=  array_mac0_out + array_mac1_out + array_mac2_out;
            conv_add_1 <=  array_mac3_out + array_mac4_out + array_mac5_out;
            conv_add_2 <=  array_mac6_out + array_mac7_out + array_mac8_out;
        end
        else begin
            conv_add_0 <= 0;
            conv_add_1 <= 0;
            conv_add_2 <= 0;
        end
    end
    
    reg conv_33add_valid;
    always@(posedge clk) begin
        if(!rst) conv_33add_valid <= 0;
        else if(mode==3'd1) conv_33add_valid <= sum_valid;
        else conv_33add_valid <= 0;
    end
    
    //normal convolution counter, every turn three continuous channels are generated and buffered into the merge out register
    always@(posedge clk) begin
        if(!rst) conv_cnt<=0;
        else if(conv_33add_valid)
            if(conv_cnt==2) conv_cnt<=0;
            else conv_cnt <= conv_cnt + 1;
        else 
            conv_cnt <= 0;
    end
 
 
//       ---------------     DEBUG           --------------        //
    wire [DATA_WIDTH-1:0] conv_output0, conv_output1, conv_output2;
    
    //ReLUandshift
    ReLUandShift ReLUandShift0(
    .msm_shifted(conv_add_0),
    .relu_enable(relu_enable),
    .output_zero(output_zero),
    .ReLU_out(conv_output0)
    );

    ReLUandShift ReLUandShift1(
    .msm_shifted(conv_add_1),
    .relu_enable(relu_enable),
    .output_zero(output_zero),
    .ReLU_out(conv_output1)
    );
    
    ReLUandShift ReLUandShift2(
    .msm_shifted(conv_add_2),
    .relu_enable(relu_enable),
    .output_zero(output_zero),
    .ReLU_out(conv_output2)
    );

//----------------- DW Mode -------------------//  
    wire [DATA_WIDTH-1:0] ReLU_0_out, ReLU_1_out, ReLU_2_out;
    wire [DATA_WIDTH-1:0] ReLU_3_out, ReLU_4_out, ReLU_5_out;
    wire [DATA_WIDTH-1:0] ReLU_6_out, ReLU_7_out, ReLU_8_out; 
  
  
    //ReLUandshift
    ReLUandShift ReLUandShift_DW0(
    .msm_shifted(array_mac0_out),
    .relu_enable(relu_enable),
    .output_zero(output_zero),
    .ReLU_out(ReLU_0_out)
    );

    ReLUandShift ReLUandShift_DW1(
    .msm_shifted(array_mac1_out),
    .relu_enable(relu_enable),
    .output_zero(output_zero),
    .ReLU_out(ReLU_1_out)
    );
    
    ReLUandShift ReLUandShift_DW2(
    .msm_shifted(array_mac2_out),
    .relu_enable(relu_enable),
    .output_zero(output_zero),
    .ReLU_out(ReLU_2_out)
    );
    
    ReLUandShift ReLUandShift_DW3(
    .msm_shifted(array_mac3_out),
    .relu_enable(relu_enable),
    .output_zero(output_zero),
    .ReLU_out(ReLU_3_out)
    );

    ReLUandShift ReLUandShift_DW4(
    .msm_shifted(array_mac4_out),
    .relu_enable(relu_enable),
    .output_zero(output_zero),
    .ReLU_out(ReLU_4_out)
    );
    
    ReLUandShift ReLUandShift_DW5(
    .msm_shifted(array_mac5_out),
    .relu_enable(relu_enable),
    .output_zero(output_zero),
    .ReLU_out(ReLU_5_out)
    );
    
    ReLUandShift ReLUandShift_DW6(
    .msm_shifted(array_mac6_out),
    .relu_enable(relu_enable),
    .output_zero(output_zero),
    .ReLU_out(ReLU_6_out)
    );

    ReLUandShift ReLUandShift_DW7(
    .msm_shifted(array_mac7_out),
    .relu_enable(relu_enable),
    .output_zero(output_zero),
    .ReLU_out(ReLU_7_out)
    );
    
    ReLUandShift ReLUandShift_DW8(
    .msm_shifted(array_mac8_out),
    .relu_enable(relu_enable),
    .output_zero(output_zero),
    .ReLU_out(ReLU_8_out)
    );
    
    always@(posedge clk) begin
        if(!rst) begin
            calculation_res <= 0;
        end
        else if(mode==3'd1)begin  //conv mode
            case(conv_cnt)
                2'd0: begin
                    calculation_res[1*DATA_WIDTH-1:0*DATA_WIDTH] <= conv_output0;
                    calculation_res[2*DATA_WIDTH-1:1*DATA_WIDTH] <= conv_output1;
                    calculation_res[3*DATA_WIDTH-1:2*DATA_WIDTH] <= conv_output2;
                end
                2'd1: begin
                    calculation_res[4*DATA_WIDTH-1:3*DATA_WIDTH] <= conv_output0;
                    calculation_res[5*DATA_WIDTH-1:4*DATA_WIDTH] <= conv_output1;
                    calculation_res[6*DATA_WIDTH-1:5*DATA_WIDTH] <= conv_output2;
                end
                2'd2:  begin
                    calculation_res[7*DATA_WIDTH-1:6*DATA_WIDTH] <= conv_output0;
                    calculation_res[8*DATA_WIDTH-1:7*DATA_WIDTH] <= conv_output1;
                    calculation_res[9*DATA_WIDTH-1:8*DATA_WIDTH] <= conv_output2;
                end
                default:
                    calculation_res <= 0;
            endcase
        end
        else begin    //DW and PW and Avgpool mode
            if(sum_valid) begin
                calculation_res[1*DATA_WIDTH-1:0*DATA_WIDTH] <= ReLU_0_out;
                calculation_res[2*DATA_WIDTH-1:1*DATA_WIDTH] <= ReLU_1_out;
                calculation_res[3*DATA_WIDTH-1:2*DATA_WIDTH] <= ReLU_2_out;
                calculation_res[4*DATA_WIDTH-1:3*DATA_WIDTH] <= ReLU_3_out;
                calculation_res[5*DATA_WIDTH-1:4*DATA_WIDTH] <= ReLU_4_out;
                calculation_res[6*DATA_WIDTH-1:5*DATA_WIDTH] <= ReLU_5_out;
                calculation_res[7*DATA_WIDTH-1:6*DATA_WIDTH] <= ReLU_6_out;
                calculation_res[8*DATA_WIDTH-1:7*DATA_WIDTH] <= ReLU_7_out;
                calculation_res[9*DATA_WIDTH-1:8*DATA_WIDTH] <= ReLU_8_out;
            end
            else begin
                calculation_res[1*DATA_WIDTH-1:0*DATA_WIDTH] <= 0;
                calculation_res[2*DATA_WIDTH-1:1*DATA_WIDTH] <= 0;
                calculation_res[3*DATA_WIDTH-1:2*DATA_WIDTH] <= 0;
                calculation_res[4*DATA_WIDTH-1:3*DATA_WIDTH] <= 0;
                calculation_res[5*DATA_WIDTH-1:4*DATA_WIDTH] <= 0;
                calculation_res[6*DATA_WIDTH-1:5*DATA_WIDTH] <= 0;
                calculation_res[7*DATA_WIDTH-1:6*DATA_WIDTH] <= 0;
                calculation_res[8*DATA_WIDTH-1:7*DATA_WIDTH] <= 0;
                calculation_res[9*DATA_WIDTH-1:8*DATA_WIDTH] <= 0;
            end
        end
    end
    
    always@(posedge clk) begin
        if(!rst) write_valid <= 0;
        else if(mode==3'd0) write_valid <= 0;
        else if(mode==3'd1) write_valid <= (conv_cnt == 2'd2);
        else write_valid <= sum_valid;
    end
    
    
endmodule

