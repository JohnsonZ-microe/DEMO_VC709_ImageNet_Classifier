`timescale 1ns / 100ps
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
    parameter DATA_BRAM_ADDR_WIDTH = 15,
    parameter KERNEL_BRAM_ADDR_WIDTH = 16,
    parameter M1_BRAM_ADDR_WIDTH = 13
)
(
  //  input clk_in_p,
  //  input clk_in_n,
    input clk,
    //-----------------DEBUG------------------//
    // input rstp_sys,
    // input rstn_accelerator,
    // input control_source,
    //---------------DEBUG END--------------//
    input [31:0] pcie_addr,
    input [71:0] pcie_data_in,
    input pcie_write_ena,
    output [71:0] pcie_data_out
    // output ram,
    // output  imp_data0,imp_data1,imp_data2,imp_data3,imp_data4,imp_data5,imp_data6,imp_data7,imp_data8,
    // output  imp_addr0,imp_addr1,imp_addr2,imp_addr3,imp_addr4,imp_addr5,imp_addr6,imp_addr7,imp_addr8,
    // output [8:0] imp_wea
    //-------------------DEBUG-------------------//
    //input test_read_mode,  // 1'b1: tb control, 1'b0: normal control
    //input [DATA_BRAM_ADDR_WIDTH-1:0] bram0_read_addr_tb,  // tb control read address
//    input [31:0] reg_config_data_in,   // user config register data input  
//    input [3:0] reg_config_addr,       // user config register mapped address  
    //       --------     DEBUG  -------            //
    //output [DATA_WIDTH-1:0] conv_output0, conv_output1, conv_output2
    //---------------------------------------------//
             
//    input reg_config_valid            // user config register data valid, when asserted, reg_config_data_in was written in corresponding register
    );

  
// ------------- pcie interface -------------- //
// wire clk;
wire [8:0] pcie_data_bram_en;
wire [8:0] pcie_kernel_bram_en;
reg       pcie_m1_bram_en;
reg control_source = 1'b0;
wire [1:0] control_state;
wire rstp_sys, rstn_accelerator;
(* KEEP = "true", DONT_TOUCH = "true" *)reg [31:0] pcie_addr_reg [0:18];
(* KEEP = "true", DONT_TOUCH = "true" *)reg [71:0] pcie_data_in_reg[0:18];
reg [71:0] pcie_data_out_reg;
integer i,j;
always @(posedge clk) begin
  if(!rstp_sys) begin
    for(i = 0; i < 19; i = i + 1) begin
      pcie_addr_reg[i]    <= 32'd0;
      pcie_data_in_reg[i] <= 72'd0;
    end
  end
  else begin
    for(i = 0; i < 19; i = i + 1) begin
      pcie_addr_reg[i]    <= pcie_addr;
      pcie_data_in_reg[i] <= pcie_data_in;
    end
  end
end
reg[20:0] pcie_addr_buffer [0:5];
always @(posedge clk) begin
  if(!rstp_sys) begin
    for(j = 0; j < 6; j = j + 1) begin
      pcie_addr_buffer[j] <= 21'd0;
    end
  end
  else begin
    pcie_addr_buffer[0] <= pcie_addr[20:0];
    for(j = 1; j < 6; j = j + 1) begin
      pcie_addr_buffer[j] <= pcie_addr_buffer[j-1];
    end
  end
end
reg[17:0] pcie_bram_we;
always@(posedge clk)begin
  if(control_source == 0) begin
    if(((&pcie_addr_buffer[5]) == 1) && (&pcie_data_in == 1) ) control_source <= 1'b1; // when pcie_addr and pcie_data_in all 1
  end
  else begin
    if((&pcie_addr_buffer[5]== 1) && (pcie_data_in == 72'h00_00ff_ff00_00ff_ff00) )control_source <= 1'b0;
  end 
end

reg control_source_reg;
always @(posedge clk) begin
    control_source_reg <= control_source;
end

assign rstp_sys = (control_source_reg != control_source) ? 1'b0 : 1'b1;
assign rstn_accelerator = (control_source_reg != control_source) ? 1'b0 : 1'b1;

always@(*)begin
      pcie_bram_we = 18'd0;
  if(control_source==1'b0) begin
    if((pcie_addr_reg[0][20:16] < 5'd19)&&(pcie_addr_reg[0][20:16] > 5'd0))begin
      pcie_bram_we[pcie_addr_reg[0][20:16]-1] = 1'b1;
    end
    else begin
      pcie_bram_we = 18'd0;
    end
  end
  else begin
    pcie_bram_we = 18'd0;
  end
end
reg [12:0] m1_write_addr;
always @(posedge clk) begin
  if(!rstp_sys) begin
    pcie_m1_bram_en <= 0;
    m1_write_addr <= 0;
  end
  else if(control_source==1'b0 && pcie_addr_reg[18][1:0]==2'd3 && pcie_write_ena_reg && pcie_addr_reg[18][20:16]==5'd19)begin
    pcie_m1_bram_en <= 1'b1;
    m1_write_addr <= pcie_addr_reg[18][14:2];
  end
  else begin
    pcie_m1_bram_en <= 1'b0;
end
end


assign  pcie_data_bram_en = pcie_bram_we[8:0];
assign  pcie_kernel_bram_en = pcie_bram_we[17:9];


assign pcie_data_out = pcie_data_out_reg;
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


reg [IFMAP_CHANNEL_WIDTH-1:0] ifmap_channel_reg;
reg [OFMAP_CHANNEL_WIDTH-1:0] ofmap_channel_reg;
wire rst_n;
assign rst_n = ~rstp_sys;
    
// wire locked;
// wire clk;
always @(posedge clk) begin
  if(!rstn_accelerator) begin
    ifmap_channel_reg <= 0;
    ofmap_channel_reg <= 0;
  end
  else begin
    ifmap_channel_reg <= ifmap_channel;
    ofmap_channel_reg <= ofmap_channel;
  end
end
///
///------------------------------------------------------------------------




// clk_wiz_0 clk_gen
// (
//     // Clock out ports
//     .clk_out1(clk),        // output clk_out1
//     // Status and control signals
//     .reset(1'b0),           // input reset
//     .locked(locked),       // output locked
//     // Clock in ports
//     .clk_in1_p(clk_in_p),    // input clk_in1_p
//     .clk_in1_n(clk_in_n));   // input clk_in1_n

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
// assign ram = complete;
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
reg[BRAM_BAND_WIDTH-1:0] bram0_read_input_reg, bram1_read_input_reg, bram2_read_input_reg, bram3_read_input_reg, bram4_read_input_reg;
reg[BRAM_BAND_WIDTH-1:0] bram5_read_input_reg, bram6_read_input_reg, bram7_read_input_reg, bram8_read_input_reg;
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
//reg
reg [BRAM_BAND_WIDTH-1:0] kernel0_read_input_reg, kernel1_read_input_reg, kernel2_read_input_reg;
reg [BRAM_BAND_WIDTH-1:0] kernel3_read_input_reg, kernel4_read_input_reg, kernel5_read_input_reg;
reg [BRAM_BAND_WIDTH-1:0] kernel6_read_input_reg, kernel7_read_input_reg, kernel8_read_input_reg;
///                     
///------------------------------------------------------------------------
///--------------------DEBUG-------------------//

wire[DATA_BRAM_ADDR_WIDTH-1:0] bram0_read_addr_mux, bram1_read_addr_mux, bram2_read_addr_mux;
wire[DATA_BRAM_ADDR_WIDTH-1:0] bram3_read_addr_mux, bram4_read_addr_mux, bram5_read_addr_mux;
wire[DATA_BRAM_ADDR_WIDTH-1:0] bram6_read_addr_mux, bram7_read_addr_mux, bram8_read_addr_mux;
wire data_bram_ena_mux;
wire[DATA_BRAM_ADDR_WIDTH-1:0] softmax_read_addr;
wire softmax_finish;
wire pw_valid;
//-----------------------------------DEBUG-------------------------------//
// assign bram0_read_addr_mux = test_read_mode?bram0_read_addr_tb:((softmax_en && softmax_finish == 0)? softmax_read_addr:bram0_read_addr);
// assign bram1_read_addr_mux = test_read_mode?bram0_read_addr_tb:bram1_read_addr;
// assign bram2_read_addr_mux = test_read_mode?bram0_read_addr_tb:bram2_read_addr;
// assign bram3_read_addr_mux = test_read_mode?bram0_read_addr_tb:bram3_read_addr;
// assign bram4_read_addr_mux = test_read_mode?bram0_read_addr_tb:bram4_read_addr;
// assign bram5_read_addr_mux = test_read_mode?bram0_read_addr_tb:bram5_read_addr;
// assign bram6_read_addr_mux = test_read_mode?bram0_read_addr_tb:bram6_read_addr;
// assign bram7_read_addr_mux = test_read_mode?bram0_read_addr_tb:bram7_read_addr;
// assign bram8_read_addr_mux = test_read_mode?bram0_read_addr_tb:bram8_read_addr;
// assign data_bram_ena_mux = test_read_mode?1'b1:data_bram_ena;
//------------------------------------------------------------------------//
assign bram0_read_addr_mux = ((softmax_en && softmax_finish == 0)? softmax_read_addr:bram0_read_addr);
assign bram1_read_addr_mux = bram1_read_addr;
assign bram2_read_addr_mux = bram2_read_addr;
assign bram3_read_addr_mux = bram3_read_addr;
assign bram4_read_addr_mux = bram4_read_addr;
assign bram5_read_addr_mux = bram5_read_addr;
assign bram6_read_addr_mux = bram6_read_addr;
assign bram7_read_addr_mux = bram7_read_addr;
assign bram8_read_addr_mux = bram8_read_addr;
assign data_bram_ena_mux = data_bram_ena;

reg [2:0] mode_reg,mode_reg2,mode_reg3,mode_reg4;
always @(posedge clk) begin
    if(!rstn_accelerator) begin
      mode_reg <= 3'd0;
      mode_reg2 <= 3'd0;
      mode_reg3 <= 3'd0;
      mode_reg4 <= 3'd0;
    end
    else begin
      mode_reg <= mode;
      mode_reg2 <= mode_reg;
      mode_reg3 <= mode_reg2;
      mode_reg4 <= mode_reg3;
    end 
end

assign ofmap_valid_mux = (mode_reg == 3'd6) ? softmax_write_valid : ofmap_write_ena;
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
    .rst_n(rstn_accelerator),
    .busy(busy),
    .complete(complete || softmax_finish),
    .control_state(control_state),
    .reg_config_data_in(reg_config_data_in),    // user config register data input  
    .reg_config_addr(reg_config_addr),       // user config register mapped address                
    .reg_config_valid(reg_config_valid),       // user config register data valid, when asserted, reg_config_data_in was written in corresponding register
    .control_source(control_source)
 );

counter_dw counter_dw0
(
    .clk(clk)     	    ,
    .rst_n(rstn_accelerator)   	    ,
	.enable(control_source)		,
    .reg_config_data_in(reg_config_data_in),          // user config register data input  
    .reg_config_addr(reg_config_addr),             // user config register mapped address                
    .reg_config_valid(reg_config_valid),            // user config register data valid, when asserted, reg_config_data_in was written in corresponding register
    .busy(busy),
    .complete(complete),
    .softmax_finish(softmax_finish),
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
  .shortcut_sel(shortcut_addr_sel),
  .avgpool_chan_start(avgpool_chan_start),
  .avgpool_chan_done(avgpool_chan_done),
  .softmax_en(softmax_en),
  .pw_valid(pw_valid)
);
reg [7:0] Output_zero_point_reg;
always @(posedge clk) begin
  if(!rstp_sys) Output_zero_point_reg <= 0;
  else Output_zero_point_reg <= Output_zero_point;
end

mac_array_x9 mac_array_x9
(
	.clk(clk)           ,
	.rst_n(rstn_accelerator)         ,
	.tlast(tlast)         ,               //input
  .tlast_pw(tlast_pw) , //input
	.mode(mode_reg)      ,
  .complete(complete),
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
	.output_zero(Output_zero_point_reg)  ,
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
	.write_valid(ofmap_write_ena),                       //output   
  .pw_valid(pw_valid)
);

BRAM_DMA BRAM_DMA0
(
    .clk(clk),
    .rst(rstn_accelerator),
    .mode(mode_reg),
    .ifmap_size(ifmap_size),
    .ofmap_size(ofmap_size),
    .ifmap_channel(ifmap_channel_reg),
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
    .ofmap_channel(ofmap_channel_reg),
    .ofmap_valid(ofmap_valid_mux),
    //shortcut
    .SC_base_addr(SC_base_addr),
    
    //data BRAM driver
    //--- read channel ---/
    .bram0_read_addr(bram0_read_addr), .bram1_read_addr(bram1_read_addr), .bram2_read_addr(bram2_read_addr),
    .bram3_read_addr(bram3_read_addr), .bram4_read_addr(bram4_read_addr), .bram5_read_addr(bram5_read_addr),
    .bram6_read_addr(bram6_read_addr), .bram7_read_addr(bram7_read_addr), .bram8_read_addr(bram8_read_addr),
    
    .bram_read_en(data_bram_ena),
    .bram0_read_input(bram0_read_input_reg), .bram1_read_input(bram1_read_input_reg), .bram2_read_input(bram2_read_input_reg),
    .bram3_read_input(bram3_read_input_reg), .bram4_read_input(bram4_read_input_reg), .bram5_read_input(bram5_read_input_reg),
    .bram6_read_input(bram6_read_input_reg), .bram7_read_input(bram7_read_input_reg), .bram8_read_input(bram8_read_input_reg),
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
    .rst(rstn_accelerator),
    .mode(mode_reg), 
    // Kernel BRAM read channel
    .kernel_pw_p(kernel_p) ,                                //input
    .kernel_base_channel(kernel_n),                        //input
    .Kernel_base_addr(Kernel_base_addr),                           //input
    .Ifmap_channel_num(ifmap_channel_reg),                          //input
    
    .M1_base_addr(M1_base_addr),                               //input
    .bram_st(calculation_state),                                    //input
    
    .kernel0_input(Weight00_in), .kernel1_input(Weight01_in), .kernel2_input(Weight02_in),          //output
    .kernel3_input(Weight10_in), .kernel4_input(Weight11_in), .kernel5_input(Weight12_in),          //output
    .kernel6_input(Weight20_in), .kernel7_input(Weight21_in), .kernel8_input(Weight22_in),          //output
    
    .kernel0_read_input(kernel0_read_input_reg), .kernel1_read_input(kernel1_read_input_reg), .kernel2_read_input(kernel2_read_input_reg),            //input
    .kernel3_read_input(kernel3_read_input_reg), .kernel4_read_input(kernel4_read_input_reg), .kernel5_read_input(kernel5_read_input_reg),            //input
    .kernel6_read_input(kernel6_read_input_reg), .kernel7_read_input(kernel7_read_input_reg), .kernel8_read_input(kernel8_read_input_reg),            //input
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
    .rst_n(rstn_accelerator),
    .softmax_en(softmax_en),
    .m0(M0),
    .zero_point(Output_zero_point_reg),
    .data_in(bram0_read_input_reg),
    .bram_read_base_addr(Ifmap_base_addr),
    .bram_write_base_addr(Ofmap_base_addr),
    .softmax_read_addr(softmax_read_addr),
    .softmax_write_addr(softmax_write_addr),
    .softmax_out(softmax_out),
    .softmax_write_valid(softmax_write_valid),
    .softmax_finish(softmax_finish)
);
reg softmax_write_valid_reg;
always @(posedge clk) begin
  if(!rstn_accelerator) begin
    softmax_write_valid_reg <= 1'b0;
  end
  else begin
    softmax_write_valid_reg <= softmax_write_valid;
  end

end
wire [71:0] ofmap_write_0_mux;
assign ofmap_write_0_mux = (softmax_write_valid_reg == 1'b1) ? softmax_out : ofmap_write_0;
wire [14:0] bram0_write_addr_mux;
assign bram0_write_addr_mux = (softmax_write_valid_reg == 1'b1) ?  softmax_write_addr :bram0_write_addr; 

//duplicate register to reduce fanout
// reg data_bram_ena_0, data_bram_ena_1, data_bram_ena_2, data_bram_ena_3, data_bram_ena_4, data_bram_ena_5, data_bram_ena_6, data_bram_ena_7,data_bram_ena_8;
// always @(posedge clk) begin
//   if(!rst_n) begin
//     data_bram_ena_0 <= 1'b0;
//     data_bram_ena_1 <= 1'b0;
//     data_bram_ena_2 <= 1'b0;
//     data_bram_ena_3 <= 1'b0;
//     data_bram_ena_4 <= 1'b0;
//     data_bram_ena_5 <= 1'b0;
//     data_bram_ena_6 <= 1'b0;
//     data_bram_ena_7 <= 1'b0;
//     data_bram_ena_8 <= 1'b0;
//   end
//   else begin
//     data_bram_ena_0 <= data_bram_ena;
//     data_bram_ena_1 <= data_bram_ena;
//     data_bram_ena_2 <= data_bram_ena;
//     data_bram_ena_3 <= data_bram_ena;
//     data_bram_ena_4 <= data_bram_ena;
//     data_bram_ena_5 <= data_bram_ena;
//     data_bram_ena_6 <= data_bram_ena;
//     data_bram_ena_7 <= data_bram_ena;
//     data_bram_ena_8 <= data_bram_ena;
//   end
// end

(* KEEP = "true", DONT_TOUCH = "true" , max_fanout = 64 *)reg data_bram_ena_0,data_bram_ena_1, data_bram_ena_2, data_bram_ena_3, data_bram_ena_4, data_bram_ena_5, data_bram_ena_6, data_bram_ena_7,data_bram_ena_8;
(* KEEP = "true", DONT_TOUCH = "true" *)reg [14:0] bram_write_addr_reg[0:8][0:4];
(* KEEP = "true", DONT_TOUCH = "true" *)reg [DATA_BRAM_ADDR_WIDTH-1:0] bram0_read_addr_mux_reg, bram1_read_addr_mux_reg, bram2_read_addr_mux_reg;
(* KEEP = "true", DONT_TOUCH = "true" *)reg [DATA_BRAM_ADDR_WIDTH-1:0] bram3_read_addr_mux_reg, bram4_read_addr_mux_reg, bram5_read_addr_mux_reg;
(* KEEP = "true", DONT_TOUCH = "true" *)reg [DATA_BRAM_ADDR_WIDTH-1:0] bram6_read_addr_mux_reg, bram7_read_addr_mux_reg, bram8_read_addr_mux_reg;

always @(posedge clk) begin
  if(!rstn_accelerator)begin
    for(i=0;i<9;i=i+1) begin
      for(j=0;j<5;j=j+1) begin
        bram_write_addr_reg[i][j] <= 0;
      end
    end
  end
  else begin
    bram_write_addr_reg[0][0] <= bram0_write_addr_mux;
    bram_write_addr_reg[1][0] <= bram1_write_addr;
    bram_write_addr_reg[2][0] <= bram2_write_addr;
    bram_write_addr_reg[3][0] <= bram3_write_addr;
    bram_write_addr_reg[4][0] <= bram4_write_addr;
    bram_write_addr_reg[5][0] <= bram5_write_addr;
    bram_write_addr_reg[6][0] <= bram6_write_addr;
    bram_write_addr_reg[7][0] <= bram7_write_addr;
    bram_write_addr_reg[8][0] <= bram8_write_addr;
    for (i=0;i<9;i=i+1)begin
      for(j=1;j<5;j=j+1)begin
      bram_write_addr_reg[i][j] <= bram_write_addr_reg[i][j-1];
      end
    end
  end
end
reg [14:0] bram_write_addr[0:8];
reg [2:0] mode_save;//if mode != 0 ,save mode
always @(posedge clk) begin
    if(!rstn_accelerator)begin
        mode_save <= 3'd0;
    end
    else begin
        if(mode != 3'd0) begin
            mode_save <= mode;
        end
    end
end
always @( *) begin
  if(control_source == 1'b0) begin
    for(i=0;i<9;i=i+1) bram_write_addr[i] = pcie_addr_reg[i][14:0];
  end
  else begin
    case(mode_save)
      3'd1:for(i=0;i<9;i=i+1) bram_write_addr[i] = bram_write_addr_reg[i][1];
      3'd2:for(i=0;i<9;i=i+1) bram_write_addr[i] = bram_write_addr_reg[i][4];
      3'd3:for(i=0;i<9;i=i+1) bram_write_addr[i] = bram_write_addr_reg[i][1];
      3'd6:begin
       bram_write_addr[0] = bram0_write_addr_mux;
            for(i=1;i<9;i=i+1)bram_write_addr[i] = 0;
       end
      default:for(i=0;i<9;i=i+1) bram_write_addr[i] = bram_write_addr_reg[i][4];
    endcase
  end
end
always @(posedge clk) begin
  if(!rstn_accelerator) begin
    data_bram_ena_0 <= 1'b0;
    data_bram_ena_1 <= 1'b0;
    data_bram_ena_2 <= 1'b0;
    data_bram_ena_3 <= 1'b0;
    data_bram_ena_4 <= 1'b0;
    data_bram_ena_5 <= 1'b0;
    data_bram_ena_6 <= 1'b0;
    data_bram_ena_7 <= 1'b0;
    data_bram_ena_8 <= 1'b0;
    bram0_read_addr_mux_reg <= 0;
    bram1_read_addr_mux_reg <= 0;
    bram2_read_addr_mux_reg <= 0;
    bram3_read_addr_mux_reg <= 0;
    bram4_read_addr_mux_reg <= 0;
    bram5_read_addr_mux_reg <= 0;
    bram6_read_addr_mux_reg <= 0;
    bram7_read_addr_mux_reg <= 0;
    bram8_read_addr_mux_reg <= 0;
  end
  else begin
    bram0_read_addr_mux_reg <= bram0_read_addr_mux;
    bram1_read_addr_mux_reg <= bram1_read_addr_mux;
    bram2_read_addr_mux_reg <= bram2_read_addr_mux;
    bram3_read_addr_mux_reg <= bram3_read_addr_mux;
    bram4_read_addr_mux_reg <= bram4_read_addr_mux;
    bram5_read_addr_mux_reg <= bram5_read_addr_mux;
    bram6_read_addr_mux_reg <= bram6_read_addr_mux;
    bram7_read_addr_mux_reg <= bram7_read_addr_mux;
    bram8_read_addr_mux_reg <= bram8_read_addr_mux;
  end
end


always @(posedge clk) begin
  if(!rstn_accelerator)begin
    bram0_read_input_reg <= 0;
    bram1_read_input_reg <= 0;
    bram2_read_input_reg <= 0;
    bram3_read_input_reg <= 0;
    bram4_read_input_reg <= 0;
    bram5_read_input_reg <= 0;
    bram6_read_input_reg <= 0;
    bram7_read_input_reg <= 0;
    bram8_read_input_reg <= 0;
  end
  else begin
    bram0_read_input_reg <= bram0_read_input;
    bram1_read_input_reg <= bram1_read_input;
    bram2_read_input_reg <= bram2_read_input;
    bram3_read_input_reg <= bram3_read_input;
    bram4_read_input_reg <= bram4_read_input;
    bram5_read_input_reg <= bram5_read_input;
    bram6_read_input_reg <= bram6_read_input;
    bram7_read_input_reg <= bram7_read_input;
    bram8_read_input_reg <= bram8_read_input;
  end
end

reg [71:0] ofmap_write_0_reg1, ofmap_write_1_reg1, ofmap_write_2_reg1, ofmap_write_3_reg1, ofmap_write_4_reg1;
reg [71:0] ofmap_write_5_reg1, ofmap_write_6_reg1, ofmap_write_7_reg1, ofmap_write_8_reg1;
reg [71:0] ofmap_write_0_reg2, ofmap_write_1_reg2, ofmap_write_2_reg2, ofmap_write_3_reg2, ofmap_write_4_reg2;
reg [71:0] ofmap_write_5_reg2, ofmap_write_6_reg2, ofmap_write_7_reg2, ofmap_write_8_reg2;
always @(posedge clk) begin
  if(!rstn_accelerator) begin
    ofmap_write_0_reg1 <= 0; 
    ofmap_write_1_reg1 <= 0; 
    ofmap_write_2_reg1 <= 0; 
    ofmap_write_3_reg1 <= 0; 
    ofmap_write_4_reg1 <= 0;
    ofmap_write_5_reg1 <= 0; 
    ofmap_write_6_reg1 <= 0; 
    ofmap_write_7_reg1 <= 0; 
    ofmap_write_8_reg1 <= 0;
    ofmap_write_0_reg2 <= 0; 
    ofmap_write_1_reg2 <= 0; 
    ofmap_write_2_reg2 <= 0; 
    ofmap_write_3_reg2 <= 0; 
    ofmap_write_4_reg2 <= 0;
    ofmap_write_5_reg2 <= 0; 
    ofmap_write_6_reg2 <= 0; 
    ofmap_write_7_reg2 <= 0; 
    ofmap_write_8_reg2 <= 0;
  end
  else begin
    ofmap_write_0_reg1 <= ofmap_write_0_mux;
    ofmap_write_1_reg1 <= ofmap_write_1;
    ofmap_write_2_reg1 <= ofmap_write_2;
    ofmap_write_3_reg1 <= ofmap_write_3;
    ofmap_write_4_reg1 <= ofmap_write_4;
    ofmap_write_5_reg1 <= ofmap_write_5;
    ofmap_write_6_reg1 <= ofmap_write_6;
    ofmap_write_7_reg1 <= ofmap_write_7;
    ofmap_write_8_reg1 <= ofmap_write_8;
    ofmap_write_0_reg2 <= ofmap_write_0_reg1;
    ofmap_write_1_reg2 <= ofmap_write_1_reg1;
    ofmap_write_2_reg2 <= ofmap_write_2_reg1;
    ofmap_write_3_reg2 <= ofmap_write_3_reg1;
    ofmap_write_4_reg2 <= ofmap_write_4_reg1;
    ofmap_write_5_reg2 <= ofmap_write_5_reg1;
    ofmap_write_6_reg2 <= ofmap_write_6_reg1;
    ofmap_write_7_reg2 <= ofmap_write_7_reg1;
    ofmap_write_8_reg2 <= ofmap_write_8_reg1;
  end
end
reg [71:0] ofmap_write_0_reg_mux, ofmap_write_1_mux, ofmap_write_2_mux, ofmap_write_3_mux;
reg [71:0] ofmap_write_4_mux, ofmap_write_5_mux, ofmap_write_6_mux, ofmap_write_7_mux, ofmap_write_8_mux;
always @(*) begin
  if(control_source == 1'b0) begin
    ofmap_write_0_reg_mux = pcie_data_in_reg[0];
    ofmap_write_1_mux = pcie_data_in_reg[1];
    ofmap_write_2_mux = pcie_data_in_reg[2];
    ofmap_write_3_mux = pcie_data_in_reg[3];
    ofmap_write_4_mux = pcie_data_in_reg[4];
    ofmap_write_5_mux = pcie_data_in_reg[5];
    ofmap_write_6_mux = pcie_data_in_reg[6];
    ofmap_write_7_mux = pcie_data_in_reg[7];
    ofmap_write_8_mux = pcie_data_in_reg[8];
    end
  else begin
    case(mode_reg3)
      3'd1:begin
        ofmap_write_0_reg_mux = ofmap_write_0_reg2;
        ofmap_write_1_mux = ofmap_write_1_reg2;
        ofmap_write_2_mux = ofmap_write_2_reg2;
        ofmap_write_3_mux = ofmap_write_3_reg2;
        ofmap_write_4_mux = ofmap_write_4_reg2;
        ofmap_write_5_mux = ofmap_write_5_reg2;
        ofmap_write_6_mux = ofmap_write_6_reg2;
        ofmap_write_7_mux = ofmap_write_7_reg2;
        ofmap_write_8_mux = ofmap_write_8_reg2;
      end
      3'd2:begin
        ofmap_write_0_reg_mux = ofmap_write_0_mux;
        ofmap_write_1_mux = ofmap_write_1;
        ofmap_write_2_mux = ofmap_write_2;
        ofmap_write_3_mux = ofmap_write_3;
        ofmap_write_4_mux = ofmap_write_4;
        ofmap_write_5_mux = ofmap_write_5;
        ofmap_write_6_mux = ofmap_write_6;
        ofmap_write_7_mux = ofmap_write_7;
        ofmap_write_8_mux = ofmap_write_8;
      end
      default :begin
        ofmap_write_0_reg_mux = ofmap_write_0_mux;
        ofmap_write_1_mux = ofmap_write_1;
        ofmap_write_2_mux = ofmap_write_2;
        ofmap_write_3_mux = ofmap_write_3;
        ofmap_write_4_mux = ofmap_write_4;
        ofmap_write_5_mux = ofmap_write_5;
        ofmap_write_6_mux = ofmap_write_6;
        ofmap_write_7_mux = ofmap_write_7;
        ofmap_write_8_mux = ofmap_write_8;
      end
        
    endcase
  end
end

reg [8:0]data_bram_we;
reg pcie_write_ena_reg;
always @(posedge clk) begin
  if(!rstp_sys) begin
    pcie_write_ena_reg <= 1'b0;
  end
  else begin
    pcie_write_ena_reg <= pcie_write_ena;
  end
end

reg [8:0] bram_write_wea_reg;
always @(posedge clk) begin
  if(!rstp_sys) begin
    bram_write_wea_reg <= 9'd0;
  end
  else begin
    bram_write_wea_reg <= bram_write_wea;
  end
end

always @( *) begin
  if(control_source == 1'b0) begin
    data_bram_we = pcie_data_bram_en & {9{pcie_write_ena_reg}};
  end
  else begin
    if(control_state == 2'd3) data_bram_we = 9'd0;
    else data_bram_we = bram_write_wea_reg;
  end
end

reg [71:0] pcie_data_out_buf[0:18];
always @(posedge clk) begin
  if(!rstp_sys) begin
    for(i=0;i<19;i=i+1) pcie_data_out_buf[i] <= 72'd0;
  end
  else begin
    pcie_data_out_buf[0] <= bram0_read_input;
    pcie_data_out_buf[1] <= bram1_read_input;
    pcie_data_out_buf[2] <= bram2_read_input;
    pcie_data_out_buf[3] <= bram3_read_input;
    pcie_data_out_buf[4] <= bram4_read_input;
    pcie_data_out_buf[5] <= bram5_read_input;
    pcie_data_out_buf[6] <= bram6_read_input;
    pcie_data_out_buf[7] <= bram7_read_input;
    pcie_data_out_buf[8] <= bram8_read_input;
    pcie_data_out_buf[9] <= kernel0_read_input;
    pcie_data_out_buf[10] <= kernel1_read_input;
    pcie_data_out_buf[11] <= kernel2_read_input;
    pcie_data_out_buf[12] <= kernel3_read_input;
    pcie_data_out_buf[13] <= kernel4_read_input;
    pcie_data_out_buf[14] <= kernel5_read_input;
    pcie_data_out_buf[15] <= kernel6_read_input;
    pcie_data_out_buf[16] <= kernel7_read_input;
    pcie_data_out_buf[17] <= kernel8_read_input;
    pcie_data_out_buf[18] <= M1_bram_in[71:0];
  end
end
reg [31:0] pcie_read_sel_delay[0:1];
always @(posedge clk) begin
  if(!rstp_sys) begin
    pcie_read_sel_delay[0] <= 32'd0;
    pcie_read_sel_delay[1] <= 32'd0;
  end
  else begin
    pcie_read_sel_delay[0] <= pcie_addr_reg[0];
    pcie_read_sel_delay[1] <= pcie_read_sel_delay[0];
  end
end
always @(posedge clk) begin
  if(!rstp_sys) begin
    pcie_data_out_reg <= 72'd0;
  end
  else if((control_source == 1'b0) && (pcie_read_sel_delay[1][20:16] <= 5'd18))begin
    pcie_data_out_reg <= pcie_data_out_buf[pcie_read_sel_delay[1][20:16]];
    // case(pcie_addr_reg[0][20:16])
    //   5'b00000:pcie_data_out_reg <= bram0_read_input;
    //   5'b00001:pcie_data_out_reg <= bram1_read_input;
    //   5'b00010:pcie_data_out_reg <= bram2_read_input;
    //   5'b00011:pcie_data_out_reg <= bram3_read_input;
    //   5'b00100:pcie_data_out_reg <= bram4_read_input;
    //   5'b00101:pcie_data_out_reg <= bram5_read_input;
    //   5'b00110:pcie_data_out_reg <= bram6_read_input;
    //   5'b00111:pcie_data_out_reg <= bram7_read_input;
    //   5'b01000:pcie_data_out_reg <= bram8_read_input;
    //   5'b01001:pcie_data_out_reg <= kernel0_read_input;
    //   5'b01010:pcie_data_out_reg <= kernel1_read_input;
    //   5'b01011:pcie_data_out_reg <= kernel2_read_input;
    //   5'b01100:pcie_data_out_reg <= kernel3_read_input;
    //   5'b01101:pcie_data_out_reg <= kernel4_read_input;
    //   5'b01110:pcie_data_out_reg <= kernel5_read_input;
    //   5'b01111:pcie_data_out_reg <= kernel6_read_input;
    //   5'b10000:pcie_data_out_reg <= kernel7_read_input;
    //   5'b10001:pcie_data_out_reg <= kernel8_read_input;
    //   5'b10010:pcie_data_out_reg <= M1_bram_in[71:0];
    //   // 5'b11111:pcie_data_out_reg <= mac_signature;
    //   default: pcie_data_out_reg <= 72'd0;
    // endcase
  end
  else if (control_source == 1'b1) begin
    if(control_state == 2'd3) pcie_data_out_reg <= 72'hff_ffff_ffff_ffff_ffff;
    else pcie_data_out_reg <= 72'd0;
  end
  else begin
    pcie_data_out_reg <= 0;
  end
end

reg [14:0] pcie_addr_reg2 [0:8];
always@(posedge clk)begin
    if(!rstn_accelerator)begin
        for(i=0;i<9;i=i+1) pcie_addr_reg2[i] <= 15'd0;
    end
    else begin
        for(i=0;i<9;i=i+1) pcie_addr_reg2[i] <= pcie_addr_reg[i][14:0];
    end
end

reg [14:0] bram_read_addr [0:8];
always @( *) begin
  if(control_source == 1'b0) begin
    for(i=0;i<9;i=i+1) bram_read_addr[i] = pcie_addr_reg2[i];
  end
  else begin
    bram_read_addr[0] = bram0_read_addr_mux_reg;
    bram_read_addr[1] = bram1_read_addr_mux_reg;
    bram_read_addr[2] = bram2_read_addr_mux_reg;
    bram_read_addr[3] = bram3_read_addr_mux_reg;
    bram_read_addr[4] = bram4_read_addr_mux_reg;
    bram_read_addr[5] = bram5_read_addr_mux_reg;
    bram_read_addr[6] = bram6_read_addr_mux_reg;
    bram_read_addr[7] = bram7_read_addr_mux_reg;
    bram_read_addr[8] = bram8_read_addr_mux_reg;
  end
end

(* KEEP = "true", DONT_TOUCH = "true" *)reg [KERNEL_BRAM_ADDR_WIDTH-1:0] kernel_read_addr0_reg, kernel_read_addr1_reg, kernel_read_addr2_reg;
(* KEEP = "true", DONT_TOUCH = "true" *)reg [KERNEL_BRAM_ADDR_WIDTH-1:0] kernel_read_addr3_reg, kernel_read_addr4_reg, kernel_read_addr5_reg;
(* KEEP = "true", DONT_TOUCH = "true" *)reg [KERNEL_BRAM_ADDR_WIDTH-1:0] kernel_read_addr6_reg, kernel_read_addr7_reg, kernel_read_addr8_reg;
wire[M1_BRAM_ADDR_WIDTH-1:0] M1_read_addr_mux;
ila_0 ila_0(
.clk(clk),
.probe0(central_control0.cnt_layer),
.probe1(data_bram_we),
.probe2(control_source),
.probe3(softmax_out),
.probe4(softmax_write_valid),
.probe5(complete),
.probe6(rstn_accelerator),
.probe7(pcie_addr_reg[0]),
.probe8(pcie_bram_we),
.probe9(pcie_write_ena_reg),
.probe10(pcie_data_out),
.probe11(counter_dw0.bram_st),//2bit
.probe12(pcie_data_out),
.probe13(pcie_data_in),
.probe14(pcie_addr),
.probe15(pcie_write_ena),
.probe16(rstp_sys),
.probe17(pcie_data_in_reg[14]),
.probe18(control_state),
.probe19(control_source_reg),
.probe20(mode),
.probe21(ofmap_write_0_reg_mux),
.probe22(bram_write_addr[0]),
.probe23(bram_write_wea_reg),
.probe24(softmax_write_addr),
.probe25(u_softmax.softmax_idx),
.probe26(u_softmax.softmax_val),
.probe27(u_softmax.idx),
.probe28(u_softmax.softmax_st),
.probe29(u_softmax.data_reg),
.probe30(u_softmax.idx_reg[5]),
.probe31(u_softmax.data_offset)
);


Data_BRAM_0 Data_Bram_0 (
  .clka(clk),    // input wire clka
  .ena(1'b1),      // input wire ena
  .wea(data_bram_we[0]),      // input wire [0 : 0] wea
  .addra(bram_write_addr[0]),  // input wire [13 : 0] addra
  .dina(ofmap_write_0_reg_mux),    // input wire [71 : 0] dina
  .clkb(clk),    // input wire clkb
  .enb(1'b1),      // input wire enb
  .addrb(bram_read_addr[0]),  // input wire [13 : 0] addrb
  .doutb(bram0_read_input)  // output wire [71 : 0] doutb
);

Data_Bram_1 Data_Bram_1 (
  .clka(clk),    // input wire clka
  .ena(1'b1),      // input wire ena
  .wea(data_bram_we[1]),      // input wire [0 : 0] wea
  .addra(bram_write_addr[1]),  // input wire [13 : 0] addra
  .dina(ofmap_write_1_mux),    // input wire [71 : 0] dina
  .clkb(clk),    // input wire clkb
  .enb(1'b1),      // input wire enb
  .addrb(bram_read_addr[1]),  // input wire [13 : 0] addrb
  .doutb(bram1_read_input)  // output wire [71 : 0] doutb
);

Data_Bram_2 Data_Bram_2 (
  .clka(clk),    // input wire clka
  .ena(1'b1),      // input wire ena
  .wea(data_bram_we[2]),      // input wire [0 : 0] wea
  .addra(bram_write_addr[2]),  // input wire [13 : 0] addra
  .dina(ofmap_write_2_mux),    // input wire [71 : 0] dina
  .clkb(clk),    // input wire clkb
  .enb(1'b1),      // input wire enb
  .addrb(bram_read_addr[2]),  // input wire [13 : 0] addrb
  .doutb(bram2_read_input)  // output wire [71 : 0] doutb
);

Data_Bram_3 Data_Bram_3 (
  .clka(clk),    // input wire clka
  .ena(1'b1),      // input wire ena
  .wea(data_bram_we[3]),      // input wire [0 : 0] wea
  .addra(bram_write_addr[3]),  // input wire [13 : 0] addra
  .dina(ofmap_write_3_mux),    // input wire [71 : 0] dina
  .clkb(clk),    // input wire clkb
  .enb(1'b1),      // input wire enb
  .addrb(bram_read_addr[3]),  // input wire [13 : 0] addrb
  .doutb(bram3_read_input)  // output wire [71 : 0] doutb
);

//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
Data_Bram_4 Data_Bram_4 (
  .clka(clk),    // input wire clka
  .ena(1'b1),      // input wire ena
  .wea(data_bram_we[4]),      // input wire [0 : 0] wea
  .addra(bram_write_addr[4]),  // input wire [13 : 0] addra
  .dina(ofmap_write_4_mux),    // input wire [71 : 0] dina
  .clkb(clk),    // input wire clkb
  .enb(1'b1),      // input wire enb
  .addrb(bram_read_addr[4]),  // input wire [13 : 0] addrb
  .doutb(bram4_read_input)  // output wire [71 : 0] doutb
);

Data_Bram_5 Data_Bram_5 (
  .clka(clk),    // input wire clka
  .ena(1'b1),      // input wire ena
  .wea(data_bram_we[5]),      // input wire [0 : 0] wea
  .addra(bram_write_addr[5]),  // input wire [13 : 0] addra
  .dina(ofmap_write_5_mux),    // input wire [71 : 0] dina
  .clkb(clk),    // input wire clkb
  .enb(1'b1),      // input wire enb
  .addrb(bram_read_addr[5]),  // input wire [13 : 0] addrb
  .doutb(bram5_read_input)  // output wire [71 : 0] doutb
);

Data_Bram_6 Data_Bram_6 (
  .clka(clk),    // input wire clka
  .ena(1'b1),      // input wire ena
  .wea(data_bram_we[6]),      // input wire [0 : 0] wea
  .addra(bram_write_addr[6]),  // input wire [13 : 0] addra
  .dina(ofmap_write_6_mux),    // input wire [71 : 0] dina
  .clkb(clk),    // input wire clkb
  .enb(1'b1),      // input wire enb
  .addrb(bram_read_addr[6]),  // input wire [13 : 0] addrb
  .doutb(bram6_read_input)  // output wire [71 : 0] doutb
);

Data_Bram_7 Data_Bram_7 (
  .clka(clk),    // input wire clka
  .ena(1'b1),      // input wire ena
  .wea(data_bram_we[7]),      // input wire [0 : 0] wea
  .addra(bram_write_addr[7]),  // input wire [13 : 0] addra
  .dina(ofmap_write_7_mux),    // input wire [71 : 0] dina
  .clkb(clk),    // input wire clkb
  .enb(1'b1),      // input wire enb
  .addrb(bram_read_addr[7]),  // input wire [13 : 0] addrb
  .doutb(bram7_read_input)  // output wire [71 : 0] doutb
);

Data_Bram_8 Data_Bram_8 (
  .clka(clk),    // input wire clka
  .ena(1'b1),      // input wire ena
  .wea(data_bram_we[8]),      // input wire [0 : 0] wea
  .addra(bram_write_addr[8]),  // input wire [13 : 0] addra
  .dina(ofmap_write_8_mux),    // input wire [71 : 0] dina
  .clkb(clk),    // input wire clkb
  .enb(1'b1),      // input wire enb
  .addrb(bram_read_addr[8]),  // input wire [13 : 0] addrb
  .doutb(bram8_read_input)  // output wire [71 : 0] doutb
);
//-----------------------implementation---------------------//
// assign imp_data0 = ofmap_write_0_mux[BRAM_BAND_WIDTH-1];
// assign imp_data1 = ofmap_write_1[BRAM_BAND_WIDTH-1];
// assign imp_data2 = ofmap_write_2[BRAM_BAND_WIDTH-1];
// assign imp_data3 = ofmap_write_3[BRAM_BAND_WIDTH-1];
// assign imp_data4 = ofmap_write_4[BRAM_BAND_WIDTH-1];
// assign imp_data5 = ofmap_write_5[BRAM_BAND_WIDTH-1];
// assign imp_data6 = ofmap_write_6[BRAM_BAND_WIDTH-1];
// assign imp_data7 = ofmap_write_7[BRAM_BAND_WIDTH-1];
// assign imp_data8 = ofmap_write_8[BRAM_BAND_WIDTH-1];
// assign imp_addr0 = bram0_write_addr_mux[DATA_BRAM_ADDR_WIDTH-1];
// assign imp_addr1 = bram1_write_addr[DATA_BRAM_ADDR_WIDTH-1];
// assign imp_addr2 = bram2_write_addr[DATA_BRAM_ADDR_WIDTH-1];
// assign imp_addr3 = bram3_write_addr[DATA_BRAM_ADDR_WIDTH-1];
// assign imp_addr4 = bram4_write_addr[DATA_BRAM_ADDR_WIDTH-1];
// assign imp_addr5 = bram5_write_addr[DATA_BRAM_ADDR_WIDTH-1];
// assign imp_addr6 = bram6_write_addr[DATA_BRAM_ADDR_WIDTH-1];
// assign imp_addr7 = bram7_write_addr[DATA_BRAM_ADDR_WIDTH-1];
// assign imp_addr8 = bram8_write_addr[DATA_BRAM_ADDR_WIDTH-1];
// assign imp_wea = bram_write_wea;

// duplicate register to reduce fanout
// (* KEEP = "true", DONT_TOUCH = "true" *)reg kernel_bram_en_0, kernel_bram_en_1, kernel_bram_en_2, kernel_bram_en_3, kernel_bram_en_4, kernel_bram_en_5, kernel_bram_en_6, kernel_bram_en_7, kernel_bram_en_8;
// always @(posedge clk) begin
//   if(!rst_n) begin
//     kernel_bram_en_0 <= 1'b0;
//     kernel_bram_en_1 <= 1'b0;
//     kernel_bram_en_2 <= 1'b0;
//     kernel_bram_en_3 <= 1'b0;
//     kernel_bram_en_4 <= 1'b0;
//     kernel_bram_en_5 <= 1'b0;
//     kernel_bram_en_6 <= 1'b0;
//     kernel_bram_en_7 <= 1'b0;
//     kernel_bram_en_8 <= 1'b0;
//   end
//   else begin
//     kernel_bram_en_0 <= kernel_bram_en;
//     kernel_bram_en_1 <= kernel_bram_en;
//     kernel_bram_en_2 <= kernel_bram_en;
//     kernel_bram_en_3 <= kernel_bram_en;
//     kernel_bram_en_4 <= kernel_bram_en;
//     kernel_bram_en_5 <= kernel_bram_en;
//     kernel_bram_en_6 <= kernel_bram_en;
//     kernel_bram_en_7 <= kernel_bram_en;
//     kernel_bram_en_8 <= kernel_bram_en;
//   end
// end
//----------------------implementation----------------------//

//-----------------------Kernel BRAM---------------------//
always @(posedge clk) begin
  if((!rstn_accelerator) || (!rstp_sys)) begin
    kernel_read_addr0_reg <= 0;
    kernel_read_addr1_reg <= 0;
    kernel_read_addr2_reg <= 0;
    kernel_read_addr3_reg <= 0;
    kernel_read_addr4_reg <= 0;
    kernel_read_addr5_reg <= 0;
    kernel_read_addr6_reg <= 0;
    kernel_read_addr7_reg <= 0;
    kernel_read_addr8_reg <= 0;
  end
  else if (control_source == 1'b0) begin
    kernel_read_addr0_reg <= pcie_addr_reg[9][KERNEL_BRAM_ADDR_WIDTH-1:0];
    kernel_read_addr1_reg <= pcie_addr_reg[10][KERNEL_BRAM_ADDR_WIDTH-1:0];
    kernel_read_addr2_reg <= pcie_addr_reg[11][KERNEL_BRAM_ADDR_WIDTH-1:0];
    kernel_read_addr3_reg <= pcie_addr_reg[12][KERNEL_BRAM_ADDR_WIDTH-1:0];
    kernel_read_addr4_reg <= pcie_addr_reg[13][KERNEL_BRAM_ADDR_WIDTH-1:0];
    kernel_read_addr5_reg <= pcie_addr_reg[14][KERNEL_BRAM_ADDR_WIDTH-1:0];
    kernel_read_addr6_reg <= pcie_addr_reg[15][KERNEL_BRAM_ADDR_WIDTH-1:0];
    kernel_read_addr7_reg <= pcie_addr_reg[16][KERNEL_BRAM_ADDR_WIDTH-1:0];
    kernel_read_addr8_reg <= pcie_addr_reg[17][KERNEL_BRAM_ADDR_WIDTH-1:0];
  end
  else begin
    kernel_read_addr0_reg <= kernel_read_addr0;
    kernel_read_addr1_reg <= kernel_read_addr1;
    kernel_read_addr2_reg <= kernel_read_addr2;
    kernel_read_addr3_reg <= kernel_read_addr3;
    kernel_read_addr4_reg <= kernel_read_addr4;
    kernel_read_addr5_reg <= kernel_read_addr5;
    kernel_read_addr6_reg <= kernel_read_addr6;
    kernel_read_addr7_reg <= kernel_read_addr7;
    kernel_read_addr8_reg <= kernel_read_addr8;
  end
end

always @(posedge clk) begin
  if(!rstn_accelerator) begin
    kernel0_read_input_reg <= 0;
    kernel1_read_input_reg <= 0;
    kernel2_read_input_reg <= 0;
    kernel3_read_input_reg <= 0;
    kernel4_read_input_reg <= 0;
    kernel5_read_input_reg <= 0;
    kernel6_read_input_reg <= 0;
    kernel7_read_input_reg <= 0;
    kernel8_read_input_reg <= 0;
  end
  else begin
    kernel0_read_input_reg <= kernel0_read_input;
    kernel1_read_input_reg <= kernel1_read_input;
    kernel2_read_input_reg <= kernel2_read_input;
    kernel3_read_input_reg <= kernel3_read_input;
    kernel4_read_input_reg <= kernel4_read_input;
    kernel5_read_input_reg <= kernel5_read_input;
    kernel6_read_input_reg <= kernel6_read_input;
    kernel7_read_input_reg <= kernel7_read_input;
    kernel8_read_input_reg <= kernel8_read_input;
  end
end

reg [8:0] kernel_wea;
always @(*) begin
  for(i=0;i<9;i=i+1) begin
      kernel_wea[i] = (control_source == 1'b0) && pcie_kernel_bram_en[i] && pcie_write_ena_reg;
  end
end

Kernel_Bram_0 Kernel_Bram_0 (
  //----------------PCIe-----------------//
  .clka(clk),    // input wire clka
  .ena(pcie_kernel_bram_en[0]),      // input wire ena
  .wea(kernel_wea[0]),      // input wire [0 : 0] wea
  .addra(pcie_addr_reg[9][15:0]),  // input wire [15 : 0] addra
  .dina(pcie_data_in_reg[9]),    // input wire [71 : 0] dina
  //-------------Accelerator--------------//
  .clkb(clk),
  .enb(1'b1),      // input wire enb
  .addrb(kernel_read_addr0_reg),  // input wire [15 : 0] addrb
  .doutb(kernel0_read_input)  // output wire [71 : 0] douta
);

Kernel_Bram_1 Kernel_Bram_1 (
  //-----------------PCIe-----------------//
  .clka(clk),    // input wire clka
  .ena(pcie_kernel_bram_en[1]),      // input wire ena
  .wea(kernel_wea[1]),      // input wire [0 : 0] wea
  .addra(pcie_addr_reg[10][15:0]),  // input wire [15 : 0] addra
  .dina(pcie_data_in_reg[10]),    // input wire [71 : 0] dina
  //-------------Accelerator--------------//
  .clkb(clk),
  .enb(1'b1),      // input wire enb
  .addrb(kernel_read_addr1_reg),  // input wire [15 : 0] addrb
  .doutb(kernel1_read_input)  // output wire [71 : 0] douta
);

Kernel_Bram_2 Kernel_Bram_2 (
  //-----------------PCIe-----------------//
  .clka(clk),    // input wire clka
  .ena(pcie_kernel_bram_en[2]),      // input wire ena
  .wea(kernel_wea[2]),      // input wire [0 : 0] wea
  .addra(pcie_addr_reg[11][15:0]),  // input wire [15 : 0] addra
  .dina(pcie_data_in_reg[11]),    // input wire [71 : 0] dina
  //-------------Accelerator--------------//
  .clkb(clk),
  .enb(1'b1),      // input wire enb
  .addrb(kernel_read_addr2_reg),  // input wire [15 : 0] addrb
  .doutb(kernel2_read_input)  // output wire [71 : 0] douta
);

Kernel_Bram_3 Kernel_Bram_3 (
  //-----------------PCIe-----------------//
  .clka(clk),    // input wire clka
  .ena(pcie_kernel_bram_en[3]),      // input wire ena
  .wea(kernel_wea[3]),      // input wire [0 : 0] wea
  .addra(pcie_addr_reg[12][15:0]),  // input wire [15 : 0] addra
  .dina(pcie_data_in_reg[12]),    // input wire [71 : 0] dina
  //-------------Accelerator--------------//
  .clkb(clk),
  .enb(1'b1),      // input wire enb
  .addrb(kernel_read_addr3_reg),  // input wire [15 : 0] addrb
  .doutb(kernel3_read_input)  // output wire [71 : 0] douta
);

Kernel_Bram_4 Kernel_Bram_4 (
  //-----------------PCIe-----------------//
  .clka(clk),    // input wire clka
  .ena(pcie_kernel_bram_en[4]),      // input wire ena
  .wea(kernel_wea[4]),      // input wire [0 : 0] wea
  .addra(pcie_addr_reg[13][15:0]),  // input wire [15 : 0] addra
  .dina(pcie_data_in_reg[13]),    // input wire [71 : 0] dina
  //-------------Accelerator--------------//
  .clkb(clk),
  .enb(1'b1),      // input wire enb
  .addrb(kernel_read_addr4_reg),  // input wire [15 : 0] addrb
  .doutb(kernel4_read_input)  // output wire [71 : 0] douta
);

Kernel_Bram_5 Kernel_Bram_5 (
  //-----------------PCIe-----------------//
  .clka(clk),    // input wire clka
  .ena(pcie_kernel_bram_en[5]),      // input wire ena
  .wea(kernel_wea[5]),      // input wire [0 : 0] wea
  .addra(pcie_addr_reg[14][15:0]),  // input wire [15 : 0] addra
  .dina(pcie_data_in_reg[14]),    // input wire [71 : 0] dina
  //-------------Accelerator--------------//
  .clkb(clk),
  .enb(1'b1),      // input wire enb
  .addrb(kernel_read_addr5_reg),  // input wire [15 : 0] addrb
  .doutb(kernel5_read_input)  // output wire [71 : 0] douta
);

Kernel_Bram_6 Kernel_Bram_6 (
  //-----------------PCIe-----------------//
  .clka(clk),    // input wire clka
  .ena(pcie_kernel_bram_en[6]),      // input wire ena
  .wea(kernel_wea[6]),      // input wire [0 : 0] wea
  .addra(pcie_addr_reg[15][15:0]),  // input wire [15 : 0] addra
  .dina(pcie_data_in_reg[15]),    // input wire [71 : 0] dina
  //-------------Accelerator--------------//
  .clkb(clk),
  .enb(1'b1),      // input wire enb
  .addrb(kernel_read_addr6_reg),  // input wire [15 : 0] addrb
  .doutb(kernel6_read_input)  // output wire [71 : 0] douta
);

Kernel_Bram_7 Kernel_Bram_7 (
  //-----------------PCIe-----------------//
  .clka(clk),    // input wire clka
  .ena(pcie_kernel_bram_en[7]),      // input wire ena
  .wea(kernel_wea[7]),      // input wire [0 : 0] wea
  .addra(pcie_addr_reg[16][15:0]),  // input wire [15 : 0] addra
  .dina(pcie_data_in_reg[16]),    // input wire [71 : 0] dina
  //-------------Accelerator--------------//
  .clkb(clk),
  .enb(1'b1),      // input wire enb
  .addrb(kernel_read_addr7_reg),  // input wire [15 : 0] addrb
  .doutb(kernel7_read_input)  // output wire [71 : 0] douta
);

Kernel_Bram_8 Kernel_Bram_8 (
  //-----------------PCIe-----------------//
  .clka(clk),    // input wire clka
  .ena(pcie_kernel_bram_en[8]),      // input wire ena
  .wea(kernel_wea[8]),      // input wire [0 : 0] wea
  .addra(pcie_addr_reg[17][15:0]),  // input wire [15 : 0] addra
  .dina(pcie_data_in_reg[17]),    // input wire [71 : 0] dina
  //-------------Accelerator--------------//
  .clkb(clk),
  .enb(1'b1),      // input wire enb
  .addrb(kernel_read_addr8_reg),  // input wire [15 : 0] addrb
  .doutb(kernel8_read_input)  // output wire [71 : 0] douta
);


//-----------------------M1 BRAM-----------------------//
reg [288-1:0] m1_data_in_buf;
always @(posedge clk) begin
  if(!rstp_sys) begin
    m1_data_in_buf <= 0;
  end
  else begin
    case(pcie_addr_reg[18][1:0])
      2'd0: m1_data_in_buf[287:216] <= pcie_data_in_reg[18];
      2'd1: m1_data_in_buf[215:144] <= pcie_data_in_reg[18];
      2'd2: m1_data_in_buf[143:72] <= pcie_data_in_reg[18];
      2'd3: m1_data_in_buf[71:0] <= pcie_data_in_reg[18];
      default:
      m1_data_in_buf <= 288'd0;
    endcase
  end
end


assign M1_read_addr_mux = (control_source == 1'b0) ? pcie_addr_reg[18][14:2] : M1_read_addr;
M1_Bram M1_Bram (
  //-----------------PCIe-----------------//
  .clka(clk),    // input wire clka
  .ena(pcie_m1_bram_en),      // input wire ena
  .wea(pcie_m1_bram_en),      // input wire [0 : 0] wea
  .addra(m1_write_addr),  // input wire [15 : 0] addra
  .dina(m1_data_in_buf),    // input wire [71 : 0] dina
  //-------------Accelerator--------------//
  .clkb(clk),    // input wire clkb
  .enb(1'b1),      // input wire enb
  .addrb(M1_read_addr_mux),  // input wire [15 : 0] addrb
  .doutb(M1_bram_in)  // output wire [71 : 0] douta
);


endmodule
