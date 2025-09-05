`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/06 12:05:09
// Design Name: 
// Module Name: PointwiseCNN_tb
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


module PointwiseCNN_tb();

bit clk;
always #10 clk = ~clk;

logic rst;
logic [31:0] reg_config_data_in;
logic [3:0] reg_config_addr;
logic reg_config_valid;
//--  1. Pointwise config register  --//
//--  coding scheme:
//--  [7:0] Ifmap_size  [17:8] Ifmap_channel  [28:18] Ofmap_channel  [29]:stride [30]: enable [31]: conv
logic [31:0] PW_config;
logic [7:0] ifmap_size;      
logic [10:0] ifmap_channel;   
logic [10:0] ofmap_channel;  
logic [1:0] Mode;                
assign PW_config = {Mode,ifmap_channel,ofmap_channel,ifmap_size};


//--  2. Input data and weight base address register --//
//--  coding scheme:
//--  [18:0] ifmap_base_addr   [19] ifmap_group_sel
logic [31:0] Input_base_addr;

logic [18:0] ifmap_base_addr;
logic ifmap_group_sel;
assign Input_base_addr = {12'b0,ifmap_group_sel, ifmap_base_addr};

//--  3. output data and bias base address register --//
//--  coding scheme:
//--  [15:0] Weight_base_addr  [17:16] Weight_output_bram_index
logic [31:0] Kernel_base_addr;

logic [15:0] Weight_base_addr;
logic [1:0] Weight_output_bram_index;
assign Kernel_base_addr = {14'b0, Weight_output_bram_index, Weight_base_addr};



//--  4. output data and bias base address register --//
//--  coding scheme:
//--  [18:0] Ofmap_base_addr  [30:19] Bias_base_addr
logic [31:0] Output_base_addr;
logic [18:0] Ofmap_base_addr;
logic [11:0] Bias_base_addr;
assign Output_base_addr = {1'b0,Bias_base_addr,Ofmap_base_addr};

logic signed [31:0] M0;
logic [7:0] input_zero_point;          

logic [18:0]Bram0_data_addr;
logic [18:0]Bram1_data_addr;
logic [18:0]Bram2_data_addr;
logic Bram_data_en; 

logic weight_reloading;
logic CCCF;                    //Convolution Channel calculation finished 
logic PWOC;                       //Pointwise Output Valid
logic complete;
logic PW_out;

logic [7:0]bram_ifmap_in_1;
logic [7:0]bram_ifmap_in_2;
logic [7:0]bram_ifmap_in_3;

logic [7:0]Bram_weight_input;

logic [7:0]bram_read_out_0, bram_read_out_1, bram_read_out_2, bram_read_out_3, bram_read_out_4, bram_read_out_5, bram_read_out_6;
logic [15:0] kernel_addr;
logic [15:0] bias_in;

PointwiseCNN PointwiseCNN0(
/////////////////------------------------------------------------/////////////////////
/////////////////////////////  [1]. Signal Declaration //////////////////////////////
/////////////////------------------------------------------------////////////////////
    .clk(clk),
    .rst(rst),
    
    /** User Config Register Signal Declaration **/
    .reg_config_data_in(reg_config_data_in),   // user config register data input  
    .reg_config_addr(reg_config_addr),       // user config register mapped address                
    .reg_config_valid(reg_config_valid),            // user config register data valid, when asserted, reg_config_data_in was written in corresponding register
    
    .channel_cnt(),
    .CPCF(),
    //DLM input
    .conv_res_valid(),
    .conv_res_input(),
    
    // Bram input values
    .Bram0_data_input(bram_ifmap_in_1),
    .Bram1_data_input(bram_ifmap_in_2),
    .Bram2_data_input(bram_ifmap_in_3),
    .Bram_weight_input(Bram_weight_input),
    .Bram_bias_input(bias_in),
    
    //Bram read control
    .Bram0_data_addr(Bram0_data_addr),
    .Bram1_data_addr(Bram1_data_addr),
    .Bram2_data_addr(Bram2_data_addr),
    .Bram_data_en(Bram_data_en), 
    
    .kernel_addr(kernel_addr),
    
    /** M0 input **/
    .M0_input(M0),
    .input_zero_point(input_zero_point),
    
/** External dataflow control signal Declaration **/
    .weight_reloading(weight_reloading),
    .CCCF(CCCF),                      //Convolution Channel calculation finished 
    .PWOC(PWOC),                       //Pointwise Output Valid
    .complete(complete),
    .PW_out(PW_out)
);

wire [5:0] bram_wea;

assign bram_wea = (ifmap_group_sel)? 6'b000111 : 6'b111000;
assign bram_ifmap_in_1 = (ifmap_group_sel)?  bram_read_out_3:bram_read_out_0;
assign bram_ifmap_in_2 = (ifmap_group_sel)?  bram_read_out_4:bram_read_out_1;
assign bram_ifmap_in_3 = (ifmap_group_sel)?  bram_read_out_5:bram_read_out_2;

reg [18:0]bram_read_addr_0,bram_read_addr_1,bram_read_addr_2,bram_read_addr_3,bram_read_addr_4,bram_read_addr_5; 
always@(*) begin
    if(ifmap_group_sel) begin
        bram_read_addr_0 <= 0;
        bram_read_addr_1 <= 0;
        bram_read_addr_2 <= 0;
        bram_read_addr_3 <= Bram0_data_addr;
        bram_read_addr_4 <= Bram1_data_addr;
        bram_read_addr_5 <= Bram2_data_addr;
    end
    else begin
        bram_read_addr_0 <= Bram0_data_addr;
        bram_read_addr_1 <= Bram1_data_addr;
        bram_read_addr_2 <= Bram2_data_addr;
        bram_read_addr_3 <= 0;
        bram_read_addr_4 <= 0;
        bram_read_addr_5 <= 0;
    end
end

DATA_BRAM_in_0 data_bram_in_0 (
  .clka(clk),    // input wire clka
  .ena(Bram_data_en),      // input wire ena
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
  .ena(Bram_data_en),      // input wire ena
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
  .ena(Bram_data_en),      // input wire ena
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
  .ena(Bram_data_en),      // input wire ena
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
  .ena(Bram_data_en),      // input wire ena
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
  .ena(Bram_data_en),      // input wire ena
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
  .ena(Bram_data_en),      // input wire ena
  .wea(0),      // input wire [0 : 0] wea
  .addra(kernel_addr),  // input wire [15 : 0] addra
  .dina(0),    // input wire [7 : 0] dina
  .douta(Bram_weight_input)  // output wire [7 : 0] douta
);


Bias_Bram0 Bias_Bram0(
  .clka(clk),    // input wire clka
  .ena(Bram_data_en),      // input wire ena
  .wea(0),      // input wire [0 : 0] wea
  .addra(bias_addr),  // input wire [14 : 0] addra
  .dina(0),    // input wire [31 : 0] dina
  .douta(bias_in)  // output wire [31 : 0] douta
);

initial begin
clk = 0;
rst = 1;
reg_config_data_in = 0;
reg_config_valid=0;
reg_config_addr =0;
M0 = 0;
#10
rst = 0;
#10
rst = 1;
// Pointwise config register
ifmap_size = 112;
ifmap_channel = 16;
ofmap_channel = 96;
Mode = 1;
M0 = 617;
input_zero_point = 130;
// Input data and weight base address register
ifmap_base_addr = 0;
Weight_base_addr = 0;
ifmap_group_sel = 0;

// output data and bias base address register
Ofmap_base_addr = 0;
Bias_base_addr = 0;
#20
reg_config_addr = 3;
reg_config_data_in = {1'b0,Bias_base_addr,Ofmap_base_addr}; 
reg_config_valid = 1;
#20
reg_config_addr = 2;
Weight_output_bram_index = 0;
reg_config_data_in = {14'b0,Weight_output_bram_index,Weight_base_addr};
#20
reg_config_addr = 1;
reg_config_data_in = {12'b0, ifmap_group_sel,ifmap_base_addr};
#20
reg_config_addr = 0;
reg_config_data_in = {Mode,ofmap_channel,ifmap_channel,ifmap_size};
#20
reg_config_valid = 0;
end
endmodule
