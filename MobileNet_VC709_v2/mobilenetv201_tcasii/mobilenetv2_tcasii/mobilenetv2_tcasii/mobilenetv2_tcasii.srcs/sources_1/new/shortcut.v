`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2025/08/09 07:40:47
// Design Name:
// Module Name: shortcut
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


module shortcut
  #(
     parameter INPUT_NUM      =  9,
     parameter M0_WIDTH       = 32,
     parameter M1_WIDTH       = 32,
     parameter OUTPUT_WIDTH   = 8,
     parameter DATA_WIDTH = 8,
     parameter NUM_SHIFT = 16,
     parameter MUL_WIDTH = 32
   )
   (
     input clk,
     input rst_n,
     input[2:0] mode,
     input shortcut_addr_sel,
     input     signed [DATA_WIDTH:0]  data0       ,
     input     signed [DATA_WIDTH:0]  data1       ,
     input     signed [DATA_WIDTH:0]  data2       ,
     input     signed [DATA_WIDTH:0]  data3       ,
     input     signed [DATA_WIDTH:0]  data4       ,
     input     signed [DATA_WIDTH:0]  data5       ,
     input     signed [DATA_WIDTH:0]  data6       ,
     input     signed [DATA_WIDTH:0]  data7       ,
     input     signed [DATA_WIDTH:0]  data8       ,
     input      [DATA_WIDTH-1:0]  x_zero,
     input      [DATA_WIDTH-1:0]  Fx_zero,
     input      [DATA_WIDTH-1:0]  sc_zero,
     input signed        [M0_WIDTH-1:0]    m0            ,
     input signed        [M1_WIDTH-1:0]    m1            ,
     output      [INPUT_NUM*DATA_WIDTH-1:0]  shortcut_output,
     output reg sc_valid
   );
  reg signed data_src,shortcut_addr_sel_delay;//指示数据是x还是Fx       x:0  Fx:1
  reg data_src_delay1, data_src_delay2;
  reg signed [MUL_WIDTH-1:0] x_offset_m0_0, x_offset_m0_1, x_offset_m0_2;
  reg signed [MUL_WIDTH-1:0] x_offset_m0_3, x_offset_m0_4, x_offset_m0_5;
  reg signed [MUL_WIDTH-1:0] x_offset_m0_6, x_offset_m0_7, x_offset_m0_8;
  reg signed [MUL_WIDTH-1:0] Fx_offset_m1_0, Fx_offset_m1_1, Fx_offset_m1_2;
  reg signed [MUL_WIDTH-1:0] Fx_offset_m1_3, Fx_offset_m1_4, Fx_offset_m1_5;
  reg signed [MUL_WIDTH-1:0] Fx_offset_m1_6, Fx_offset_m1_7, Fx_offset_m1_8;
  reg [DATA_WIDTH-1:0] shortcut_output_0, shortcut_output_1, shortcut_output_2;
  reg [DATA_WIDTH-1:0] shortcut_output_3, shortcut_output_4, shortcut_output_5;
  reg [DATA_WIDTH-1:0] shortcut_output_6, shortcut_output_7, shortcut_output_8;

  always @(posedge clk)
  begin
    if (!rst_n)
    begin
      data_src <= 0;
      shortcut_addr_sel_delay <= 0;
      data_src_delay1 <= 0;
      data_src_delay2 <= 0;
      sc_valid <= 0;
    end
    else
    begin
      shortcut_addr_sel_delay <= shortcut_addr_sel;
      data_src <= shortcut_addr_sel_delay;
      data_src_delay1 <= data_src;
      data_src_delay2 <= data_src_delay1;
      sc_valid <= data_src_delay2;
    end
  end
  //multiply data with m0 or m1
  always@(posedge clk)
  begin
    if(!rst_n)
    begin
      x_offset_m0_0 <= 0;
      x_offset_m0_1 <= 0;
      x_offset_m0_2 <= 0;
      x_offset_m0_3 <= 0;
      x_offset_m0_4 <= 0;
      x_offset_m0_5 <= 0;
      x_offset_m0_6 <= 0;
      x_offset_m0_7 <= 0;
      x_offset_m0_8 <= 0;
      Fx_offset_m1_0 <= 0;
      Fx_offset_m1_1 <= 0;
      Fx_offset_m1_2 <= 0;
      Fx_offset_m1_3 <= 0;
      Fx_offset_m1_4 <= 0;
      Fx_offset_m1_5 <= 0;
      Fx_offset_m1_6 <= 0;
      Fx_offset_m1_7 <= 0;
      Fx_offset_m1_8 <= 0;
    end
    else
    begin
      case (data_src)
        1'b0:
        begin
          x_offset_m0_0 <= data0*m0;
          x_offset_m0_1 <= data1*m0;
          x_offset_m0_2 <= data2*m0;
          x_offset_m0_3 <= data3*m0;
          x_offset_m0_4 <= data4*m0;
          x_offset_m0_5 <= data5*m0;
          x_offset_m0_6 <= data6*m0;
          x_offset_m0_7 <= data7*m0;
          x_offset_m0_8 <= data8*m0;
        end
        1'b1:
        begin
          Fx_offset_m1_0 <= data0*m1;
          Fx_offset_m1_1 <= data1*m1;
          Fx_offset_m1_2 <= data2*m1;
          Fx_offset_m1_3 <= data3*m1;
          Fx_offset_m1_4 <= data4*m1;
          Fx_offset_m1_5 <= data5*m1;
          Fx_offset_m1_6 <= data6*m1;
          Fx_offset_m1_7 <= data7*m1;
          Fx_offset_m1_8 <= data8*m1;
        end
        default:
        begin
          x_offset_m0_0 <= 0;
          x_offset_m0_1 <= 0;
          x_offset_m0_2 <= 0;
          x_offset_m0_3 <= 0;
          x_offset_m0_4 <= 0;
          x_offset_m0_5 <= 0;
          x_offset_m0_6 <= 0;
          x_offset_m0_7 <= 0;
          x_offset_m0_8 <= 0;
          Fx_offset_m1_0 <= 0;
          Fx_offset_m1_1 <= 0;
          Fx_offset_m1_2 <= 0;
          Fx_offset_m1_3 <= 0;
          Fx_offset_m1_4 <= 0;
          Fx_offset_m1_5 <= 0;
          Fx_offset_m1_6 <= 0;
          Fx_offset_m1_7 <= 0;
          Fx_offset_m1_8 <= 0;
        end
      endcase
    end
  end
  wire [31:0] rectifier_out0,rectifier_out1,rectifier_out2;
  wire [31:0] rectifier_out3,rectifier_out4,rectifier_out5;
  wire [31:0] rectifier_out6,rectifier_out7,rectifier_out8;
  assign    rectifier_out0 = ( ($signed(Fx_offset_m1_0) + $signed(x_offset_m0_0) + 32'sd32768) >>> NUM_SHIFT ) + $signed({24'd0, sc_zero});
  assign    rectifier_out1 = ( ($signed(Fx_offset_m1_1) + $signed(x_offset_m0_1) + 32'sd32768) >>> NUM_SHIFT ) + $signed({24'd0, sc_zero});
  assign    rectifier_out2 = ( ($signed(Fx_offset_m1_2) + $signed(x_offset_m0_2) + 32'sd32768) >>> NUM_SHIFT ) + $signed({24'd0, sc_zero});
  assign    rectifier_out3 = ( ($signed(Fx_offset_m1_3) + $signed(x_offset_m0_3) + 32'sd32768) >>> NUM_SHIFT ) + $signed({24'd0, sc_zero});
  assign    rectifier_out4 = ( ($signed(Fx_offset_m1_4) + $signed(x_offset_m0_4) + 32'sd32768) >>> NUM_SHIFT ) + $signed({24'd0, sc_zero});
  assign    rectifier_out5 = ( ($signed(Fx_offset_m1_5) + $signed(x_offset_m0_5) + 32'sd32768) >>> NUM_SHIFT ) + $signed({24'd0, sc_zero});
  assign    rectifier_out6 = ( ($signed(Fx_offset_m1_6) + $signed(x_offset_m0_6) + 32'sd32768) >>> NUM_SHIFT ) + $signed({24'd0, sc_zero});
  assign    rectifier_out7 = ( ($signed(Fx_offset_m1_7) + $signed(x_offset_m0_7) + 32'sd32768) >>> NUM_SHIFT ) + $signed({24'd0, sc_zero});
  assign    rectifier_out8 = ( ($signed(Fx_offset_m1_8) + $signed(x_offset_m0_8) + 32'sd32768) >>> NUM_SHIFT ) + $signed({24'd0, sc_zero});

  always @(posedge clk)
  begin
    if(!rst_n)
    begin
      shortcut_output_0 <= 0;
      shortcut_output_1 <= 0;
      shortcut_output_2 <= 0;
      shortcut_output_3 <= 0;
      shortcut_output_4 <= 0;
      shortcut_output_5 <= 0;
      shortcut_output_6 <= 0;
      shortcut_output_7 <= 0;
      shortcut_output_8 <= 0;
    end
    else if(data_src)
    begin
      shortcut_output_0 <= rectifier_out0[31] ? 8'd0 : (rectifier_out0 >= 32'sd255 ? 8'd255 : rectifier_out0[7:0]);
      shortcut_output_1 <= rectifier_out1[31] ? 8'd0 : (rectifier_out1 >= 32'sd255 ? 8'd255 : rectifier_out1[7:0]);
      shortcut_output_2 <= rectifier_out2[31] ? 8'd0 : (rectifier_out2 >= 32'sd255 ? 8'd255 : rectifier_out2[7:0]);
      shortcut_output_3 <= rectifier_out3[31] ? 8'd0 : (rectifier_out3 >= 32'sd255 ? 8'd255 : rectifier_out3[7:0]);
      shortcut_output_4 <= rectifier_out4[31] ? 8'd0 : (rectifier_out4 >= 32'sd255 ? 8'd255 : rectifier_out4[7:0]);
      shortcut_output_5 <= rectifier_out5[31] ? 8'd0 : (rectifier_out5 >= 32'sd255 ? 8'd255 : rectifier_out5[7:0]);
      shortcut_output_6 <= rectifier_out6[31] ? 8'd0 : (rectifier_out6 >= 32'sd255 ? 8'd255 : rectifier_out6[7:0]);
      shortcut_output_7 <= rectifier_out7[31] ? 8'd0 : (rectifier_out7 >= 32'sd255 ? 8'd255 : rectifier_out7[7:0]);
      shortcut_output_8 <= rectifier_out8[31] ? 8'd0 : (rectifier_out8 >= 32'sd255 ? 8'd255 : rectifier_out8[7:0]);
    end
    else
    begin
      shortcut_output_0 <= shortcut_output_0;
      shortcut_output_1 <= shortcut_output_1;
      shortcut_output_2 <= shortcut_output_2;
      shortcut_output_3 <= shortcut_output_3;
      shortcut_output_4 <= shortcut_output_4;
      shortcut_output_5 <= shortcut_output_5;
      shortcut_output_6 <= shortcut_output_6;
      shortcut_output_7 <= shortcut_output_7;
      shortcut_output_8 <= shortcut_output_8;
    end
  end

  assign shortcut_output = {shortcut_output_8, shortcut_output_7, shortcut_output_6,
                            shortcut_output_5, shortcut_output_4, shortcut_output_3,
                            shortcut_output_2, shortcut_output_1, shortcut_output_0};
endmodule
