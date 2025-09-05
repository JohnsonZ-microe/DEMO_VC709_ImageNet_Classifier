`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/17 15:15:49
// Design Name: 
// Module Name: depthwise_driver
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


module depthwise_driver(
    input clk,
    input rst,
    input [31:0] reg_config_data_in,
    input reg_config_valid,
    input [3:0] reg_config_addr,
    input signed [31:0] M0,
    input signed [7:0] input_zero_point,
    output complete,
    output [31: 0] bram_ofmap_out_1, bram_ofmap_out_2, bram_ofmap_out_3
    );
    
wire bram_ifmap_in_ena;

wire [7: 0]bram_ifmap_in_1;
wire [7: 0]bram_ifmap_in_2;
wire [7: 0]bram_ifmap_in_3;

//wire [7: 0]bram_ofmap_out_1;
//wire [7: 0]bram_ofmap_out_2;
//wire [7: 0]bram_ofmap_out_3;

wire [7: 0]conv_data_out;

wire [18:0]bram_ofmap_addr_1,bram_ofmap_addr_2,bram_ofmap_addr_3;                                   //bram write address
reg [18:0]bram_read_addr_0,bram_read_addr_1,bram_read_addr_2,bram_read_addr_3,bram_read_addr_4,bram_read_addr_5; 
wire [7:0] bram_read_out_0, bram_read_out_1, bram_read_out_2, bram_read_out_3, bram_read_out_4, bram_read_out_5;
wire [18:0]bram_ifmap_addr_0,bram_ifmap_addr_1,bram_ifmap_addr_2;

wire [7:0] bram_weight_in_1,bram_weight_in_2,bram_weight_in_3;
wire [11:0] kernel_addr;

wire [31:0] bias_in;
wire [14:0] bias_addr;

wire ifmap_group_sel;

depthwise33 depthwise33_0
(
.clk(clk),
.rst(rst),
.reg_config_data_in(reg_config_data_in),
.reg_config_addr(reg_config_addr),
.reg_config_valid(reg_config_valid),

.M0_input(M0),
.input_zero_point(input_zero_point),
//bram's output ifmap data (read data)
.bram_ifmap_in_1(bram_ifmap_in_1),
.bram_ifmap_in_2(bram_ifmap_in_2),
.bram_ifmap_in_3(bram_ifmap_in_3), 
.bram_ifmap_in_ena(bram_ifmap_in_ena),
.bram_ofmap_out_1(bram_ofmap_out_1),
.bram_ofmap_out_2(bram_ofmap_out_2),
.bram_ofmap_out_3(bram_ofmap_out_3), //bram's output ifmap data (read data)
.bram_ofmap_addr_1(bram_ofmap_addr_1),
.bram_ofmap_addr_2(bram_ofmap_addr_2),
.bram_ofmap_addr_3(bram_ofmap_addr_3),                                   //bram write address
.bram_ifmap_addr_1(bram_ifmap_addr_0),
.bram_ifmap_addr_2(bram_ifmap_addr_1),
.bram_ifmap_addr_3(bram_ifmap_addr_2),                                   //bram read address

.ifmap_group_sel(ifmap_group_sel),
.bram_weight_in_1(bram_weight_in_1),
.bram_weight_in_2(bram_weight_in_2),
.bram_weight_in_3(bram_weight_in_3),
.kernel_addr(kernel_addr),

.bias_in(bias_in),
.bias_addr(bias_addr),

.complete(complete)
);

wire [5:0] bram_wea;
assign bram_wea = (ifmap_group_sel)? 6'b000111 : 6'b111000;
assign bram_ifmap_in_1 = (ifmap_group_sel)?  bram_read_out_3:bram_read_out_0;
assign bram_ifmap_in_2 = (ifmap_group_sel)?  bram_read_out_4:bram_read_out_1;
assign bram_ifmap_in_3 = (ifmap_group_sel)?  bram_read_out_5:bram_read_out_2;

always@(*) begin
    if(ifmap_group_sel) begin
        bram_read_addr_0 <= 0;
        bram_read_addr_1 <= 0;
        bram_read_addr_2 <= 0;
        bram_read_addr_3 <= bram_ifmap_addr_0;
        bram_read_addr_4 <= bram_ifmap_addr_1;
        bram_read_addr_5 <= bram_ifmap_addr_2;
    end
    else begin
        bram_read_addr_0 <= bram_ifmap_addr_0;
        bram_read_addr_1 <= bram_ifmap_addr_1;
        bram_read_addr_2 <= bram_ifmap_addr_2;
        bram_read_addr_3 <= 0;
        bram_read_addr_4 <= 0;
        bram_read_addr_5 <= 0;
    end
end

DATA_BRAM_in_0 data_bram_in_0 (
  .clka(clk),    // input wire clka
  .ena(bram_ifmap_in_ena),      // input wire ena
  .wea(bram_wea[0]),      // input wire [0 : 0] wea
  .addra(bram_read_addr_0),  // input wire [18 : 0] addra
  .dina(),    // input wire [7 : 0] dina
  .douta(bram_read_out_0),  // output wire [7 : 0] douta
  .clkb(clk),    // input wire clkb
  .enb(0),      // input wire enb
  .web(0),      // input wire [0 : 0] web
  .addrb(0),  // input wire [18 : 0] addrb
  .dinb(0),    // input wire [7 : 0] dinb
  .doutb()  // output wire [7 : 0] doutb
);

DATA_BRAM_in_1 data_bram_in_1 (
  .clka(clk),    // input wire clka
  .ena(bram_ifmap_in_ena),      // input wire ena
  .wea(bram_wea[1]),      // input wire [0 : 0] wea
  .addra(bram_read_addr_1),  // input wire [18 : 0] addra
  .dina(),    // input wire [7 : 0] dina
  .douta(bram_read_out_1),  // output wire [7 : 0] douta
  .clkb(clk),    // input wire clkb
  .enb(0),      // input wire enb
  .web(0),      // input wire [0 : 0] web
  .addrb(0),  // input wire [18 : 0] addrb
  .dinb(0),    // input wire [7 : 0] dinb
  .doutb()  // output wire [7 : 0] doutb
);
DATA_BRAM_in_2 data_bram_in_2 (
  .clka(clk),    // input wire clka
  .ena(bram_ifmap_in_ena),      // input wire ena
  .wea(bram_wea[2]),      // input wire [0 : 0] wea
  .addra(bram_read_addr_2),  // input wire [18 : 0] addra
  .dina(),    // input wire [7 : 0] dina
  .douta(bram_read_out_2),  // output wire [7 : 0] douta
  .clkb(clk),    // input wire clkb
  .enb(0),      // input wire enb
  .web(0),      // input wire [0 : 0] web
  .addrb(0),  // input wire [18 : 0] addrb
  .dinb(0),    // input wire [7 : 0] dinb
  .doutb()  // output wire [7 : 0] doutb
);

DATA_BRAM_in_3 data_bram_in_3 (
  .clka(clk),    // input wire clka
  .ena(bram_ifmap_in_ena),      // input wire ena
  .wea(bram_wea[3]),      // input wire [0 : 0] wea
  .addra(bram_read_addr_3),  // input wire [18 : 0] addra
  .dina(),    // input wire [7 : 0] dina
  .douta(bram_read_out_3),  // output wire [7 : 0] douta
  .clkb(clk),    // input wire clkb
  .enb(0),      // input wire enb
  .web(0),      // input wire [0 : 0] web
  .addrb(0),  // input wire [18 : 0] addrb
  .dinb(0),    // input wire [7 : 0] dinb
  .doutb()  // output wire [7 : 0] doutb
);

DATA_BRAM_in_4 data_bram_in_4 (
  .clka(clk),    // input wire clka
  .ena(bram_ifmap_in_ena),      // input wire ena
  .wea(bram_wea[4]),      // input wire [0 : 0] wea
  .addra(bram_read_addr_4),  // input wire [18 : 0] addra
  .dina(),    // input wire [7 : 0] dina
  .douta(bram_read_out_4),  // output wire [7 : 0] douta
  .clkb(clk),    // input wire clkb
  .enb(0),      // input wire enb
  .web(0),      // input wire [0 : 0] web
  .addrb(0),  // input wire [18 : 0] addrb
  .dinb(0),    // input wire [7 : 0] dinb
  .doutb()  // output wire [7 : 0] doutb
);

DATA_BRAM_in_5 data_bram_in_5 (
  .clka(clk),    // input wire clka
  .ena(bram_ifmap_in_ena),      // input wire ena
  .wea(bram_wea[5]),      // input wire [0 : 0] wea
  .addra(bram_read_addr_5),  // input wire [18 : 0] addra
  .dina(),    // input wire [7 : 0] dina
  .douta(bram_read_out_5),  // output wire [7 : 0] douta
  .clkb(clk),    // input wire clkb
  .enb(0),      // input wire enb
  .web(0),      // input wire [0 : 0] web
  .addrb(0),  // input wire [18 : 0] addrb
  .dinb(0),    // input wire [7 : 0] dinb
  .doutb()  // output wire [7 : 0] doutb
);
Kernel_BRAM_0 kernel_bram_0 (
  .clka(clk),    // input wire clka
  .ena(bram_ifmap_in_ena),      // input wire ena
  .wea(0),      // input wire [0 : 0] wea
  .addra(kernel_addr),  // input wire [11 : 0] addra
  .dina(0),    // input wire [7 : 0] dina
  .douta(bram_weight_in_1)  // output wire [7 : 0] douta
);

Kernel_BRAM_1 kernel_bram_1 (
  .clka(clk),    // input wire clka
  .ena(bram_ifmap_in_ena),      // input wire ena
  .wea(0),      // input wire [0 : 0] wea
  .addra(kernel_addr),  // input wire [11 : 0] addra
  .dina(0),    // input wire [7 : 0] dina
  .douta(bram_weight_in_2)  // output wire [7 : 0] douta
);


Kernel_BRAM_2 kernel_bram_2 (
  .clka(clk),    // input wire clka
  .ena(bram_ifmap_in_ena),      // input wire ena
  .wea(0),      // input wire [0 : 0] wea
  .addra(kernel_addr),  // input wire [11 : 0] addra
  .dina(0),    // input wire [7 : 0] dina
  .douta(bram_weight_in_3)  // output wire [7 : 0] douta
);

Bias_Bram0 Bias_Bram0(
  .clka(clk),    // input wire clka
  .ena(bram_ifmap_in_ena),      // input wire ena
  .wea(0),      // input wire [0 : 0] wea
  .addra(bias_addr),  // input wire [14 : 0] addra
  .dina(0),    // input wire [31 : 0] dina
  .douta(bias_in)  // output wire [31 : 0] douta
);
endmodule
