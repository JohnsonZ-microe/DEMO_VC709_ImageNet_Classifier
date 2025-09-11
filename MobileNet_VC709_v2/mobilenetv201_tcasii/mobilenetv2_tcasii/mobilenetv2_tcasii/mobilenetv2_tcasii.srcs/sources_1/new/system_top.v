`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/11 16:20:49
// Design Name: 
// Module Name: system_top
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


module system_top#
(
    parameter BRAM_BAND_WIDTH = 72,
    parameter DATA_WIDTH = 8,
    parameter IFMAP_CHANNEL_WIDTH  = 10,
    parameter OFMAP_CHANNEL_WIDTH  = 11,
    parameter FM_SIZE_WIDTH  =  8,
    parameter CHANNEL_PARA   =  9,
    parameter BIAS_WIDTH = 32,
    parameter HORIZENTAL_VERTICAL_COUNTER_WIDTH = 8,
    parameter DATA_BRAM_ADDR_WIDTH = 18,
    parameter KERNEL_BRAM_ADDR_WIDTH = 16,
    parameter M1_BRAM_ADDR_WIDTH = 13
)
(
    input clk,
    input rst,
    input enable,
    //-------------------DEBUG-------------------//
    input test_read_mode,  // 1'b1: tb control, 1'b0: normal control
    input [DATA_BRAM_ADDR_WIDTH-1:0] bram0_read_addr_tb,  // tb control read address
//    input [31:0] reg_config_data_in,   // user config register data input  
//    input [3:0] reg_config_addr,       // user config register mapped address  
    //       --------     DEBUG  -------            //
    output [DATA_WIDTH-1:0] conv_output0, conv_output1, conv_output2
    //---------------------------------------------//
             
//    input reg_config_valid            // user config register data valid, when asserted, reg_config_data_in was written in corresponding register
    );
    
//// ---------- cable between counter_dw and BRAM_DMA ----------------////
///
wire [DATA_BRAM_ADDR_WIDTH-1:0] Ifmap_base_addr;
wire [DATA_BRAM_ADDR_WIDTH-1:0] Ofmap_base_addr;
wire [DATA_BRAM_ADDR_WIDTH-1:0] SC_base_addr;

wire [FM_SIZE_WIDTH-1:0] ifmap_size;
wire [FM_SIZE_WIDTH-1:0] ofmap_size;
wire [IFMAP_CHANNEL_WIDTH-1:0] ifmap_channel;
wire [OFMAP_CHANNEL_WIDTH-1:0] ofmap_channel;
wire [FM_SIZE_WIDTH-1:0] ifmap_h_cnt;
wire [FM_SIZE_WIDTH-1:0] ifmap_v_cnt;
wire [IFMAP_CHANNEL_WIDTH-1:0] ifmap_channel_cnt;
wire [FM_SIZE_WIDTH-1:0] ofmap_h_cnt;
wire [FM_SIZE_WIDTH-1:0] ofmap_v_cnt;
wire [OFMAP_CHANNEL_WIDTH-1:0] ofmap_channel_cnt;

wire [1:0] calculation_state;
wire [BRAM_BAND_WIDTH-1 :0] Window00_in, Window01_in, Window02_in;
wire [BRAM_BAND_WIDTH-1 :0] Window10_in, Window11_in, Window12_in;
wire [BRAM_BAND_WIDTH-1 :0] Window20_in, Window21_in, Window22_in;

wire [BRAM_BAND_WIDTH-1 :0] Weight00_in, Weight01_in, Weight02_in;
wire [BRAM_BAND_WIDTH-1 :0] Weight10_in, Weight11_in, Weight12_in;
wire [BRAM_BAND_WIDTH-1 :0] Weight20_in, Weight21_in, Weight22_in;

wire ofmap_wea;
wire ofmap_valid_mux;
wire softmax_write_valid;

///
///------------------------------------------------------------------------

//// ---------- cable between counter_dw and Kernel_Bram_DMA ----------------////
///
wire [KERNEL_BRAM_ADDR_WIDTH-1:0] Kernel_base_addr;
wire [KERNEL_BRAM_ADDR_WIDTH-1:0] M1_base_addr;

wire   [OFMAP_CHANNEL_WIDTH-1:0] kernel_p;
wire   [IFMAP_CHANNEL_WIDTH-1:0] kernel_n;

wire   [9*32-1:0] bias_in;
///
///------------------------------------------------------------------------


//// ---------- cable between counter_dw and mac_array_x9 ----------------////
/// 
wire [BRAM_BAND_WIDTH-1:0] array_mac_0_data_in; 
wire [BRAM_BAND_WIDTH-1:0] array_mac_1_data_in; 
wire [BRAM_BAND_WIDTH-1:0] array_mac_2_data_in; 
wire [BRAM_BAND_WIDTH-1:0] array_mac_3_data_in; 
wire [BRAM_BAND_WIDTH-1:0] array_mac_4_data_in; 
wire [BRAM_BAND_WIDTH-1:0] array_mac_5_data_in; 
wire [BRAM_BAND_WIDTH-1:0] array_mac_6_data_in; 
wire [BRAM_BAND_WIDTH-1:0] array_mac_7_data_in; 
wire [BRAM_BAND_WIDTH-1:0] array_mac_8_data_in; 

wire [BRAM_BAND_WIDTH-1:0] array_mac_0_weight_in; 
wire [BRAM_BAND_WIDTH-1:0] array_mac_1_weight_in; 
wire [BRAM_BAND_WIDTH-1:0] array_mac_2_weight_in; 
wire [BRAM_BAND_WIDTH-1:0] array_mac_3_weight_in; 
wire [BRAM_BAND_WIDTH-1:0] array_mac_4_weight_in; 
wire [BRAM_BAND_WIDTH-1:0] array_mac_5_weight_in; 
wire [BRAM_BAND_WIDTH-1:0] array_mac_6_weight_in; 
wire [BRAM_BAND_WIDTH-1:0] array_mac_7_weight_in; 
wire [BRAM_BAND_WIDTH-1:0] array_mac_8_weight_in; 

wire [31:0] array_mac_0_M1_in; 
wire [31:0] array_mac_1_M1_in; 
wire [31:0] array_mac_2_M1_in; 
wire [31:0] array_mac_3_M1_in; 
wire [31:0] array_mac_4_M1_in; 
wire [31:0] array_mac_5_M1_in; 
wire [31:0] array_mac_6_M1_in; 
wire [31:0] array_mac_7_M1_in; 
wire [31:0] array_mac_8_M1_in; 

wire tlast;
wire tlast_no_sync;
wire tlast_pw;
wire [2:0] mode;
wire [31:0] M0 ;
wire [7:0] Input_zero_point;
wire [7:0] Output_zero_point;
wire [7:0] sc_zero;
wire ReLU_enable;
wire [BRAM_BAND_WIDTH-1:0] ofmap_write_0, ofmap_write_1, ofmap_write_2;
wire [BRAM_BAND_WIDTH-1:0] ofmap_write_3, ofmap_write_4, ofmap_write_5;
wire [BRAM_BAND_WIDTH-1:0] ofmap_write_6, ofmap_write_7, ofmap_write_8;
wire [BRAM_BAND_WIDTH-1:0] softmax_out;
wire ofmap_write_ena;


///
///------------------------------------------------------------------------

//// ---------- cable between counter_dw and central_control ----------------////
///
    wire busy;
    wire complete;
    wire [31:0] reg_config_data_in;
    wire [3:0] reg_config_addr; 
    wire reg_config_valid;
///
///------------------------------------------------------------------------

//// ---------- cable to Data Bram ----------------////
///
    wire data_bram_ena;
    wire [8:0]bram_write_wea;
    
    wire [DATA_BRAM_ADDR_WIDTH-1:0] bram0_read_addr, bram1_read_addr, bram2_read_addr;
    wire [DATA_BRAM_ADDR_WIDTH-1:0] bram3_read_addr, bram4_read_addr, bram5_read_addr;
    wire [DATA_BRAM_ADDR_WIDTH-1:0] bram6_read_addr, bram7_read_addr, bram8_read_addr;
    
    wire [BRAM_BAND_WIDTH-1 : 0 ] bram0_read_input, bram1_read_input, bram2_read_input;
    wire [BRAM_BAND_WIDTH-1 : 0 ] bram3_read_input, bram4_read_input, bram5_read_input;
    wire [BRAM_BAND_WIDTH-1 : 0 ] bram6_read_input, bram7_read_input, bram8_read_input;
    
    wire [DATA_BRAM_ADDR_WIDTH-1:0] bram0_write_addr, bram1_write_addr, bram2_write_addr;
    wire [DATA_BRAM_ADDR_WIDTH-1:0] bram3_write_addr, bram4_write_addr, bram5_write_addr;
    wire [DATA_BRAM_ADDR_WIDTH-1:0] bram6_write_addr, bram7_write_addr, bram8_write_addr;

    wire [DATA_BRAM_ADDR_WIDTH-1:0] softmax_write_addr;
    
    wire [BRAM_BAND_WIDTH-1 : 0 ] bram0_write_value, bram1_write_value, bram2_write_value;
    wire [BRAM_BAND_WIDTH-1 : 0 ] bram3_write_value, bram4_write_value, bram5_write_value;
    wire [BRAM_BAND_WIDTH-1 : 0 ] bram6_write_value, bram7_write_value, bram8_write_value;
///
///------------------------------------------------------------------------

//// ---------- cable to Kernel Bram ----------------////
///
wire [BRAM_BAND_WIDTH-1:0] kernel0_read_input, kernel1_read_input, kernel2_read_input;
wire [BRAM_BAND_WIDTH-1:0] kernel3_read_input, kernel4_read_input, kernel5_read_input;
wire [BRAM_BAND_WIDTH-1:0] kernel6_read_input, kernel7_read_input, kernel8_read_input;

wire [KERNEL_BRAM_ADDR_WIDTH-1:0] kernel_read_addr0, kernel_read_addr1, kernel_read_addr2;
wire [KERNEL_BRAM_ADDR_WIDTH-1:0] kernel_read_addr3, kernel_read_addr4, kernel_read_addr5;
wire [KERNEL_BRAM_ADDR_WIDTH-1:0] kernel_read_addr6, kernel_read_addr7, kernel_read_addr8;
wire kernel_bram_en;    
wire softmax_en;
wire M1_bram_en;                
wire [M1_BRAM_ADDR_WIDTH -1:0] M1_read_addr;
wire [9*32-1:0] M1_bram_in;
///                     
///------------------------------------------------------------------------
///--------------------DEBUG-------------------//

wire[DATA_BRAM_ADDR_WIDTH-1:0] bram0_read_addr_mux, bram1_read_addr_mux, bram2_read_addr_mux;
wire[DATA_BRAM_ADDR_WIDTH-1:0] bram3_read_addr_mux, bram4_read_addr_mux, bram5_read_addr_mux;
wire[DATA_BRAM_ADDR_WIDTH-1:0] bram6_read_addr_mux, bram7_read_addr_mux, bram8_read_addr_mux;
wire data_bram_ena_mux;
wire[DATA_BRAM_ADDR_WIDTH-1:0] softmax_read_addr;
assign bram0_read_addr_mux = test_read_mode?bram0_read_addr_tb:((softmax_en && softmax_finish == 0)? softmax_read_addr:bram0_read_addr);
assign bram1_read_addr_mux = test_read_mode?bram0_read_addr_tb:bram1_read_addr;
assign bram2_read_addr_mux = test_read_mode?bram0_read_addr_tb:bram2_read_addr;
assign bram3_read_addr_mux = test_read_mode?bram0_read_addr_tb:bram3_read_addr;
assign bram4_read_addr_mux = test_read_mode?bram0_read_addr_tb:bram4_read_addr;
assign bram5_read_addr_mux = test_read_mode?bram0_read_addr_tb:bram5_read_addr;
assign bram6_read_addr_mux = test_read_mode?bram0_read_addr_tb:bram6_read_addr;
assign bram7_read_addr_mux = test_read_mode?bram0_read_addr_tb:bram7_read_addr;
assign bram8_read_addr_mux = test_read_mode?bram0_read_addr_tb:bram8_read_addr;
assign data_bram_ena_mux = test_read_mode?1'b1:data_bram_ena;

assign ofmap_valid_mux = (mode == 3'd6) ? softmax_write_valid : ofmap_wea;
//--------------------Shortcut test-------------------//
wire [HORIZENTAL_VERTICAL_COUNTER_WIDTH-1:0] read_h_block_idx;
wire [HORIZENTAL_VERTICAL_COUNTER_WIDTH-1:0] read_v_block_idx;
wire [HORIZENTAL_VERTICAL_COUNTER_WIDTH-1:0] write_h_block_idx;
wire [HORIZENTAL_VERTICAL_COUNTER_WIDTH-1:0] write_v_block_idx;
wire [7:0] row_block_num;
wire shortcut_addr_sel;
wire avgpool_chan_done;
wire avgpool_chan_start;

central_control central_control0(
/** User Config Register Signal Declaration **/
    .clk(clk),
    .rst_n(rst),
    .ena(enable),
    .busy(busy),
    .complete(complete || softmax_finish),
    .reg_config_data_in(reg_config_data_in),    // user config register data input  
    .reg_config_addr(reg_config_addr),       // user config register mapped address                
    .reg_config_valid(reg_config_valid)       // user config register data valid, when asserted, reg_config_data_in was written in corresponding register
 );

counter_dw counter_dw0
(
    .clk(clk)     	    ,
    .rst_n(rst)   	    ,
	.enable(enable)		,
    .reg_config_data_in(reg_config_data_in),          // user config register data input  
    .reg_config_addr(reg_config_addr),             // user config register mapped address                
    .reg_config_valid(reg_config_valid),            // user config register data valid, when asserted, reg_config_data_in was written in corresponding register
    .busy(busy),
    .complete(complete),
    
    .ifmap_base_addr_out(Ifmap_base_addr),
    .ofmap_base_addr_out(Ofmap_base_addr),
    .SC_base_addr_out(SC_base_addr),
    .kernel_base_addr_out(Kernel_base_addr),
    .M1_base_addr_out(M1_base_addr),
    
    .ifmap_size_out(ifmap_size),    
    .ofmap_size_out(ofmap_size),
    .ifmap_channel_out(ifmap_channel),
    .ofmap_channel_out(ofmap_channel),
  
	.pos_x(ifmap_h_cnt),
	.pos_y(ifmap_v_cnt),
	.pos_z(ifmap_channel_cnt),
    
    .write_pos_x(ofmap_h_cnt),
    .write_pos_y(ofmap_v_cnt),
    .write_pos_z(ofmap_channel_cnt),
   
    .kernel_p(kernel_p), 
    .kernel_n(kernel_n),
	
	.Window00_in(Window00_in), .Window01_in(Window01_in), .Window02_in(Window02_in),        //input
	.Window10_in(Window10_in), .Window11_in(Window11_in), .Window12_in(Window12_in),        //input
	.Window20_in(Window20_in), .Window21_in(Window21_in), .Window22_in(Window22_in),        //input
	                                                     
    .Weight00_in(Weight00_in), .Weight01_in(Weight01_in), .Weight02_in(Weight02_in),        //input
	.Weight10_in(Weight10_in), .Weight11_in(Weight11_in), .Weight12_in(Weight12_in),        //input
	.Weight20_in(Weight20_in), .Weight21_in(Weight21_in), .Weight22_in(Weight22_in),        //input
	.bram_st_out(calculation_state),     //output
	
	.Bias_in(bias_in),                   //input
    
    .data1_to99(array_mac_0_data_in)       ,                    //output
    .data2_to99(array_mac_1_data_in)       ,                    //output
    .data3_to99(array_mac_2_data_in)       ,                    //output
    .data4_to99(array_mac_3_data_in)       ,                    //output
    .data5_to99(array_mac_4_data_in)       ,                    //output
    .data6_to99(array_mac_5_data_in)       ,                    //output
    .data7_to99(array_mac_6_data_in)       ,                    //output
    .data8_to99(array_mac_7_data_in)       ,                    //output
    .data9_to99(array_mac_8_data_in)       ,                    //output
	
	.weight1_to99(array_mac_0_weight_in)    ,                   //output
    .weight2_to99(array_mac_1_weight_in)    ,                   //output
    .weight3_to99(array_mac_2_weight_in)    ,                   //output
    .weight4_to99(array_mac_3_weight_in)    ,                   //output
    .weight5_to99(array_mac_4_weight_in)    ,                   //output
    .weight6_to99(array_mac_5_weight_in)    ,                   //output
    .weight7_to99(array_mac_6_weight_in)    ,                   //output
    .weight8_to99(array_mac_7_weight_in)    ,                   //output
    .weight9_to99(array_mac_8_weight_in)    ,                   //output
	                                                         
	.tlast(tlast),                                                 //output
  .tlast_no_sync(tlast_no_sync),                                 //output
  .tlast_pw(tlast_pw),                                       //output
	.M0_to_arrays(M0),                                            //output
	.Input_zero_point(Input_zero_point),                        //output
	.Output_zero_point(Output_zero_point),
  .sc_zero_point(sc_zero),                                            //output
	.ReLU_enable(ReLU_enable),
	.Mode(mode),                                                    //output
	.Array_Mac0_M1(array_mac_0_M1_in), .Array_Mac1_M1(array_mac_1_M1_in), .Array_Mac2_M1(array_mac_2_M1_in), 
	.Array_Mac3_M1(array_mac_3_M1_in), .Array_Mac4_M1(array_mac_4_M1_in), .Array_Mac5_M1(array_mac_5_M1_in),
    .Array_Mac6_M1(array_mac_6_M1_in), .Array_Mac7_M1(array_mac_7_M1_in), .Array_Mac8_M1(array_mac_8_M1_in),
	
	.write_valid(ofmap_write_ena),             //input
	.ofmap_wea(ofmap_wea),              //output
  .read_h_block_idx(read_h_block_idx), .read_v_block_idx(read_v_block_idx),
  .write_h_block_idx(write_h_block_idx), .write_v_block_idx(write_v_block_idx),
  .row_block_num(row_block_num),
  .shortcut_addr_sel(shortcut_addr_sel),
  .avgpool_chan_start(avgpool_chan_start),
  .avgpool_chan_done(avgpool_chan_done),
  .softmax_en(softmax_en)
);


mac_array_x9 mac_array_x9
(
	.clk(clk)           ,
	.rst_n(rst)         ,
	.tlast(tlast)         ,               //input
  .tlast_pw(tlast_pw) , //input
	.mode(mode)      ,
	
    .data1(array_mac_0_data_in)   ,                     //input
    .data2(array_mac_1_data_in)   ,                     //input
    .data3(array_mac_2_data_in)   ,                     //input
    .data4(array_mac_3_data_in)   ,                     //input
    .data5(array_mac_4_data_in)   ,                     //input
    .data6(array_mac_5_data_in)   ,                     //input
    .data7(array_mac_6_data_in)   ,                     //input
    .data8(array_mac_7_data_in)   ,                     //input
    .data9(array_mac_8_data_in)   ,                     //input
        
    .weight1(array_mac_0_weight_in)      ,                   //input
    .weight2(array_mac_1_weight_in)      ,                   //input
    .weight3(array_mac_2_weight_in)      ,                   //input
    .weight4(array_mac_3_weight_in)      ,                   //input
    .weight5(array_mac_4_weight_in)      ,                   //input
    .weight6(array_mac_5_weight_in)      ,                   //input
    .weight7(array_mac_6_weight_in)      ,                   //input
    .weight8(array_mac_7_weight_in)      ,                   //input
    .weight9(array_mac_8_weight_in)      ,                   //input
        
	.input_zero(Input_zero_point)    ,                   //input
	.output_zero(Output_zero_point)  ,
	.sc_zero(sc_zero)  ,                   //input
  .shortcut_addr_sel(shortcut_addr_sel),
	.m0(M0)            ,                   //input
  .avgpool_chan_start(avgpool_chan_start),
  .avgpool_chan_done(avgpool_chan_done),
  .ifmap_size(ifmap_size),
	
    .m1_1(array_mac_0_M1_in)         ,                   //input
    .m1_2(array_mac_1_M1_in)         ,                   //input
    .m1_3(array_mac_2_M1_in)         ,                   //input
    .m1_4(array_mac_3_M1_in)         ,                   //input
    .m1_5(array_mac_4_M1_in)         ,                   //input
    .m1_6(array_mac_5_M1_in)         ,                   //input
    .m1_7(array_mac_6_M1_in)         ,                   //input
    .m1_8(array_mac_7_M1_in)         ,                   //input
    .m1_9(array_mac_8_M1_in)         ,                   //input
	
	// -------------  DEBUG ------------ //
	.conv_output0(conv_output0), .conv_output1(conv_output1), .conv_output2(conv_output2),
	
	.relu_enable(ReLU_enable)  ,                   //input
 	
	.ofmap_write_0(ofmap_write_0),                             //output
  .ofmap_write_1(ofmap_write_1),                             //output
  .ofmap_write_2(ofmap_write_2),                             //output
  .ofmap_write_3(ofmap_write_3),                             //output
  .ofmap_write_4(ofmap_write_4),                             //output
  .ofmap_write_5(ofmap_write_5),                             //output
  .ofmap_write_6(ofmap_write_6),                             //output
  .ofmap_write_7(ofmap_write_7),                             //output
  .ofmap_write_8(ofmap_write_8),                             //output
	.write_valid(ofmap_write_ena)                       //output   
);

BRAM_DMA BRAM_DMA0
(
    .clk(clk),
    .rst(rst),
    .mode(mode),
    .ifmap_size(ifmap_size),
    .ofmap_size(ofmap_size),
    .ifmap_channel(ifmap_channel),
    .bram_st(calculation_state),
    //------------------------------------------------//
    //BRAM Data read channel
    .Ifmap_base_addr(Ifmap_base_addr),
    .Ifmap_hori_num(ifmap_h_cnt),        //center pixel h       
    .Ifmap_vert_num(ifmap_v_cnt),        //center pixel v
    .Ifmap_channel_num(ifmap_channel_cnt),
    
    .Ifmap0_input(Window00_in), .Ifmap1_input(Window01_in), .Ifmap2_input(Window02_in),                   //output
    .Ifmap3_input(Window10_in), .Ifmap4_input(Window11_in), .Ifmap5_input(Window12_in),                   //output
    .Ifmap6_input(Window20_in), .Ifmap7_input(Window21_in), .Ifmap8_input(Window22_in),                   //output
    //BRAM Data Write channel
    .Ofmap_base_addr(Ofmap_base_addr),
    .Ofmap_hori_num(ofmap_h_cnt), 
    .Ofmap_vert_num(ofmap_v_cnt),
    .Ofmap_channel_num(ofmap_channel_cnt),
    .ofmap_channel(ofmap_channel),
    .ofmap_valid(ofmap_valid_mux),
    //shortcut
    .SC_base_addr(SC_base_addr),
    
    //data BRAM driver
    //--- read channel ---/
    .bram0_read_addr(bram0_read_addr), .bram1_read_addr(bram1_read_addr), .bram2_read_addr(bram2_read_addr),
    .bram3_read_addr(bram3_read_addr), .bram4_read_addr(bram4_read_addr), .bram5_read_addr(bram5_read_addr),
    .bram6_read_addr(bram6_read_addr), .bram7_read_addr(bram7_read_addr), .bram8_read_addr(bram8_read_addr),
    
    .bram_read_en(data_bram_ena),
    .bram0_read_input(bram0_read_input), .bram1_read_input(bram1_read_input), .bram2_read_input(bram2_read_input),
    .bram3_read_input(bram3_read_input), .bram4_read_input(bram4_read_input), .bram5_read_input(bram5_read_input),
    .bram6_read_input(bram6_read_input), .bram7_read_input(bram7_read_input), .bram8_read_input(bram8_read_input),
    //--- write channel ---/    
    .bram0_write_addr(bram0_write_addr), .bram1_write_addr(bram1_write_addr), .bram2_write_addr(bram2_write_addr),
    .bram3_write_addr(bram3_write_addr), .bram4_write_addr(bram4_write_addr), .bram5_write_addr(bram5_write_addr),
    .bram6_write_addr(bram6_write_addr), .bram7_write_addr(bram7_write_addr), .bram8_write_addr(bram8_write_addr),
    
    .bram_write_wea(bram_write_wea),                                //output
    .read_h_block_idx(read_h_block_idx), .read_v_block_idx(read_v_block_idx), //output
    .write_h_block_idx(write_h_block_idx), .write_v_block_idx(write_v_block_idx), //output
    .row_block_num(row_block_num),
    .shortcut_addr_sel(shortcut_addr_sel)
    );

Kernel_Bram_DMA Kernel_Bram_DMA0
(
    .clk(clk),
    .rst(rst),
    .mode(mode), 
    // Kernel BRAM read channel
    .kernel_pw_p(kernel_p) ,                                //input
    .kernel_base_channel(kernel_n),                        //input
    .Kernel_base_addr(Kernel_base_addr),                           //input
    .Ifmap_channel_num(ifmap_channel),                          //input
    
    .M1_base_addr(M1_base_addr),                               //input
    .bram_st(calculation_state),                                    //input
    
    .kernel0_input(Weight00_in), .kernel1_input(Weight01_in), .kernel2_input(Weight02_in),          //output
    .kernel3_input(Weight10_in), .kernel4_input(Weight11_in), .kernel5_input(Weight12_in),          //output
    .kernel6_input(Weight20_in), .kernel7_input(Weight21_in), .kernel8_input(Weight22_in),          //output
    
    .kernel0_read_input(kernel0_read_input), .kernel1_read_input(kernel1_read_input), .kernel2_read_input(kernel2_read_input),            //input
    .kernel3_read_input(kernel3_read_input), .kernel4_read_input(kernel4_read_input), .kernel5_read_input(kernel5_read_input),            //input
    .kernel6_read_input(kernel6_read_input), .kernel7_read_input(kernel7_read_input), .kernel8_read_input(kernel8_read_input),            //input
    //Weight BRAM driver
    .kernel_bram_en(kernel_bram_en),
    .kernel_read_addr0(kernel_read_addr0), .kernel_read_addr1(kernel_read_addr1), .kernel_read_addr2(kernel_read_addr2),
    .kernel_read_addr3(kernel_read_addr3), .kernel_read_addr4(kernel_read_addr4), .kernel_read_addr5(kernel_read_addr5),
    .kernel_read_addr6(kernel_read_addr6), .kernel_read_addr7(kernel_read_addr7), .kernel_read_addr8(kernel_read_addr8),
    
    //M1 BRAM driver
    .M1_bram_en(M1_bram_en),                  
    .M1_read_addr(M1_read_addr),
    .M1_bram_in(M1_bram_in),
    .M1_out(bias_in)
    );
softmax u_softmax(
    .clk(clk),
    .rst_n(rst),
    .softmax_en(softmax_en),
    .m0(M0),
    .zero_point(Output_zero_point),
    .data_in(bram0_read_input),
    .bram_read_base_addr(Ifmap_base_addr),
    .bram_write_base_addr(Ofmap_base_addr),
    .softmax_read_addr(softmax_read_addr),
    .softmax_write_addr(softmax_write_addr),
    .softmax_out(softmax_out),
    .softmax_write_valid(softmax_write_valid),
    .softmax_finish(softmax_finish)
);
wire [71:0] ofmap_write_0_mux;
assign ofmap_write_0_mux = (softmax_write_valid == 1'b1) ? softmax_out : ofmap_write_0;
wire [17:0] bram0_write_addr_mux;
assign bram0_write_addr_mux = (softmax_write_valid == 1'b1) ?  softmax_write_addr :bram0_write_addr; 
Data_BRAM_0 Data_Bram_0 (
  .clka(clk),    // input wire clka
  .ena(data_bram_ena),      // input wire ena
  .wea(bram_write_wea[0]),      // input wire [0 : 0] wea
  .addra(bram0_write_addr_mux),  // input wire [13 : 0] addra
  .dina(ofmap_write_0_mux),    // input wire [71 : 0] dina
  .clkb(clk),    // input wire clkb
  .enb(data_bram_ena_mux),      // input wire enb
  .addrb(bram0_read_addr_mux),  // input wire [13 : 0] addrb
  .doutb(bram0_read_input)  // output wire [71 : 0] doutb
);

Data_Bram_1 Data_Bram_1 (
  .clka(clk),    // input wire clka
  .ena(data_bram_ena),      // input wire ena
  .wea(bram_write_wea[1]),      // input wire [0 : 0] wea
  .addra(bram1_write_addr),  // input wire [13 : 0] addra
  .dina(ofmap_write_1),    // input wire [71 : 0] dina
  .clkb(clk),    // input wire clkb
  .enb(data_bram_ena_mux),      // input wire enb
  .addrb(bram1_read_addr_mux),  // input wire [13 : 0] addrb
  .doutb(bram1_read_input)  // output wire [71 : 0] doutb
);

Data_Bram_2 Data_Bram_2 (
  .clka(clk),    // input wire clka
  .ena(data_bram_ena),      // input wire ena
  .wea(bram_write_wea[2]),      // input wire [0 : 0] wea
  .addra(bram2_write_addr),  // input wire [13 : 0] addra
  .dina(ofmap_write_2),    // input wire [71 : 0] dina
  .clkb(clk),    // input wire clkb
  .enb(data_bram_ena_mux),      // input wire enb
  .addrb(bram2_read_addr_mux),  // input wire [13 : 0] addrb
  .doutb(bram2_read_input)  // output wire [71 : 0] doutb
);

Data_Bram_3 Data_Bram_3 (
  .clka(clk),    // input wire clka
  .ena(data_bram_ena),      // input wire ena
  .wea(bram_write_wea[3]),      // input wire [0 : 0] wea
  .addra(bram3_write_addr),  // input wire [13 : 0] addra
  .dina(ofmap_write_3),    // input wire [71 : 0] dina
  .clkb(clk),    // input wire clkb
  .enb(data_bram_ena_mux),      // input wire enb
  .addrb(bram3_read_addr_mux),  // input wire [13 : 0] addrb
  .doutb(bram3_read_input)  // output wire [71 : 0] doutb
);

//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
Data_Bram_4 Data_Bram_4 (
  .clka(clk),    // input wire clka
  .ena(data_bram_ena),      // input wire ena
  .wea(bram_write_wea[4]),      // input wire [0 : 0] wea
  .addra(bram4_write_addr),  // input wire [13 : 0] addra
  .dina(ofmap_write_4),    // input wire [71 : 0] dina
  .clkb(clk),    // input wire clkb
  .enb(data_bram_ena_mux),      // input wire enb
  .addrb(bram4_read_addr_mux),  // input wire [13 : 0] addrb
  .doutb(bram4_read_input)  // output wire [71 : 0] doutb
);

Data_Bram_5 Data_Bram_5 (
  .clka(clk),    // input wire clka
  .ena(data_bram_ena),      // input wire ena
  .wea(bram_write_wea[5]),      // input wire [0 : 0] wea
  .addra(bram5_write_addr),  // input wire [13 : 0] addra
  .dina(ofmap_write_5),    // input wire [71 : 0] dina
  .clkb(clk),    // input wire clkb
  .enb(data_bram_ena_mux),      // input wire enb
  .addrb(bram5_read_addr_mux),  // input wire [13 : 0] addrb
  .doutb(bram5_read_input)  // output wire [71 : 0] doutb
);

Data_Bram_6 Data_Bram_6 (
  .clka(clk),    // input wire clka
  .ena(data_bram_ena),      // input wire ena
  .wea(bram_write_wea[6]),      // input wire [0 : 0] wea
  .addra(bram6_write_addr),  // input wire [13 : 0] addra
  .dina(ofmap_write_6),    // input wire [71 : 0] dina
  .clkb(clk),    // input wire clkb
  .enb(data_bram_ena_mux),      // input wire enb
  .addrb(bram6_read_addr_mux),  // input wire [13 : 0] addrb
  .doutb(bram6_read_input)  // output wire [71 : 0] doutb
);

Data_Bram_7 Data_Bram_7 (
  .clka(clk),    // input wire clka
  .ena(data_bram_ena),      // input wire ena
  .wea(bram_write_wea[7]),      // input wire [0 : 0] wea
  .addra(bram7_write_addr),  // input wire [13 : 0] addra
  .dina(ofmap_write_7),    // input wire [71 : 0] dina
  .clkb(clk),    // input wire clkb
  .enb(data_bram_ena_mux),      // input wire enb
  .addrb(bram7_read_addr_mux),  // input wire [13 : 0] addrb
  .doutb(bram7_read_input)  // output wire [71 : 0] doutb
);

Data_Bram_8 Data_Bram_8 (
  .clka(clk),    // input wire clka
  .ena(data_bram_ena),      // input wire ena
  .wea(bram_write_wea[8]),      // input wire [0 : 0] wea
  .addra(bram8_write_addr),  // input wire [13 : 0] addra
  .dina(ofmap_write_8),    // input wire [71 : 0] dina
  .clkb(clk),    // input wire clkb
  .enb(data_bram_ena_mux),      // input wire enb
  .addrb(bram8_read_addr_mux),  // input wire [13 : 0] addrb
  .doutb(bram8_read_input)  // output wire [71 : 0] doutb
);

Kernel_Bram_0 Kernel_Bram_0 (
  .clka(clk),    // input wire clka
  .ena(kernel_bram_en),      // input wire ena
  .wea(1'b0),      // input wire [0 : 0] wea
  .addra(kernel_read_addr0),  // input wire [15 : 0] addra
  .dina(0),    // input wire [71 : 0] dina
  .douta(kernel0_read_input)  // output wire [71 : 0] douta
);

Kernel_Bram_1 Kernel_Bram_1 (
  .clka(clk),    // input wire clka
  .ena(kernel_bram_en),      // input wire ena
  .wea(1'b0),      // input wire [0 : 0] wea
  .addra(kernel_read_addr1),  // input wire [15 : 0] addra
  .dina(0),    // input wire [71 : 0] dina
  .douta(kernel1_read_input)  // output wire [71 : 0] douta
);

Kernel_Bram_2 Kernel_Bram_2 (
  .clka(clk),    // input wire clka
  .ena(kernel_bram_en),      // input wire ena
  .wea(1'b0),      // input wire [0 : 0] wea
  .addra(kernel_read_addr2),  // input wire [15 : 0] addra
  .dina(0),    // input wire [71 : 0] dina
  .douta(kernel2_read_input)  // output wire [71 : 0] douta
);

Kernel_Bram_3 Kernel_Bram_3 (
  .clka(clk),    // input wire clka
  .ena(kernel_bram_en),      // input wire ena
  .wea(1'b0),      // input wire [0 : 0] wea
  .addra(kernel_read_addr3),  // input wire [15 : 0] addra
  .dina(0),    // input wire [71 : 0] dina
  .douta(kernel3_read_input)  // output wire [71 : 0] douta
);

Kernel_Bram_4 Kernel_Bram_4 (
  .clka(clk),    // input wire clka
  .ena(kernel_bram_en),      // input wire ena
  .wea(1'b0),      // input wire [0 : 0] wea
  .addra(kernel_read_addr4),  // input wire [15 : 0] addra
  .dina(0),    // input wire [71 : 0] dina
  .douta(kernel4_read_input)  // output wire [71 : 0] douta
);

Kernel_Bram_5 Kernel_Bram_5 (
  .clka(clk),    // input wire clka
  .ena(kernel_bram_en),      // input wire ena
  .wea(1'b0),      // input wire [0 : 0] wea
  .addra(kernel_read_addr5),  // input wire [15 : 0] addra
  .dina(0),    // input wire [71 : 0] dina
  .douta(kernel5_read_input)  // output wire [71 : 0] douta
);

Kernel_Bram_6 Kernel_Bram_6 (
  .clka(clk),    // input wire clka
  .ena(kernel_bram_en),      // input wire ena
  .wea(1'b0),      // input wire [0 : 0] wea
  .addra(kernel_read_addr6),  // input wire [15 : 0] addra
  .dina(0),    // input wire [71 : 0] dina
  .douta(kernel6_read_input)  // output wire [71 : 0] douta
);

Kernel_Bram_7 Kernel_Bram_7 (
  .clka(clk),    // input wire clka
  .ena(kernel_bram_en),      // input wire ena
  .wea(1'b0),      // input wire [0 : 0] wea
  .addra(kernel_read_addr7),  // input wire [15 : 0] addra
  .dina(0),    // input wire [71 : 0] dina
  .douta(kernel7_read_input)  // output wire [71 : 0] douta
);

Kernel_Bram_8 Kernel_Bram_8 (
  .clka(clk),    // input wire clka
  .ena(kernel_bram_en),      // input wire ena
  .wea(1'b0),      // input wire [0 : 0] wea
  .addra(kernel_read_addr8),  // input wire [15 : 0] addra
  .dina(0),    // input wire [71 : 0] dina
  .douta(kernel8_read_input)  // output wire [71 : 0] douta
);

M1_Bram M1_Bram (
  .clka(clk),    // input wire clka
  .ena(M1_bram_en),      // input wire ena
  .wea(1'b0),      // input wire [0 : 0] wea
  .addra(M1_read_addr),  // input wire [15 : 0] addra
  .dina(0),    // input wire [71 : 0] dina
  .douta(M1_bram_in)  // output wire [71 : 0] douta
);
endmodule
