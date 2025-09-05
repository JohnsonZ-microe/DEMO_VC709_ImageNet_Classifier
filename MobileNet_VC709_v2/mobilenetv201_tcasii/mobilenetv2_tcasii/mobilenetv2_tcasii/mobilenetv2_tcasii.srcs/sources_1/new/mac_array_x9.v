module mac_array_x9#
(
	parameter INPUT_NUM      =  9,
	parameter ACT_WIDTH      =  8,
	parameter WEIGHT_WIDTH   =  8,
	parameter M0_WIDTH       = 32,
	parameter M1_WIDTH       = 32,
	parameter OUTPUT_WIDTH   = 8,
	parameter DATA_WIDTH = 8
)
(
	input                                 clk           ,
	input                                 rst_n         ,
	input                                 tlast         ,
    input                                 tlast_pw,
	input                        [2:0]    mode          ,
	
    input  signed    [INPUT_NUM*ACT_WIDTH-1:0]  data1       ,
    input  signed    [INPUT_NUM*ACT_WIDTH-1:0]  data2       ,
    input  signed    [INPUT_NUM*ACT_WIDTH-1:0]  data3       ,
    input  signed    [INPUT_NUM*ACT_WIDTH-1:0]  data4       ,
    input  signed    [INPUT_NUM*ACT_WIDTH-1:0]  data5       ,
    input  signed    [INPUT_NUM*ACT_WIDTH-1:0]  data6       ,
    input  signed    [INPUT_NUM*ACT_WIDTH-1:0]  data7       ,
    input  signed    [INPUT_NUM*ACT_WIDTH-1:0]  data8       ,
    input  signed    [INPUT_NUM*ACT_WIDTH-1:0]  data9       ,
        
    input  signed [INPUT_NUM*WEIGHT_WIDTH-1:0]  weight1       ,
    input  signed [INPUT_NUM*WEIGHT_WIDTH-1:0]  weight2       ,
    input  signed [INPUT_NUM*WEIGHT_WIDTH-1:0]  weight3       ,
    input  signed [INPUT_NUM*WEIGHT_WIDTH-1:0]  weight4       ,
    input  signed [INPUT_NUM*WEIGHT_WIDTH-1:0]  weight5       ,
    input  signed [INPUT_NUM*WEIGHT_WIDTH-1:0]  weight6       ,
    input  signed [INPUT_NUM*WEIGHT_WIDTH-1:0]  weight7       ,
    input  signed [INPUT_NUM*WEIGHT_WIDTH-1:0]  weight8       ,
    input  signed [INPUT_NUM*WEIGHT_WIDTH-1:0]  weight9       ,
        
	input           [OUTPUT_WIDTH-1:0]    input_zero    ,  
	input           [OUTPUT_WIDTH-1:0]    output_zero    ,
    input           [OUTPUT_WIDTH-1:0]    sc_zero,
	input shortcut_addr_sel,
	input signed        [M0_WIDTH-1:0]    m0            ,
    input avgpool_chan_done,
    input avgpool_chan_start,
	input [7:0] ifmap_size,
	input signed        [M1_WIDTH-1:0]    m1_1          , 
	input signed        [M1_WIDTH-1:0]    m1_2          ,
	input signed        [M1_WIDTH-1:0]    m1_3          ,
	input signed        [M1_WIDTH-1:0]    m1_4          ,
	input signed        [M1_WIDTH-1:0]    m1_5          ,
	input signed        [M1_WIDTH-1:0]    m1_6          ,
	input signed        [M1_WIDTH-1:0]    m1_7          ,
	input signed        [M1_WIDTH-1:0]    m1_8          ,  
	input signed        [M1_WIDTH-1:0]    m1_9          ,
	
	input                                 relu_enable   , 
 	
    //       --------     DEBUG  -------            //
    output [DATA_WIDTH-1:0] conv_output0, conv_output1, conv_output2,
    //---------------------------------------------//
 	
 	
	output             [9*OUTPUT_WIDTH-1:0] ofmap_write_0, ofmap_write_1, ofmap_write_2,
    output             [9*OUTPUT_WIDTH-1:0] ofmap_write_3, ofmap_write_4, ofmap_write_5,
    output             [9*OUTPUT_WIDTH-1:0] ofmap_write_6, ofmap_write_7, ofmap_write_8,
	output             write_valid         
);


        


wire [31:0] merge_out1, merge_out2, merge_out3;
wire [31:0] merge_out4, merge_out5, merge_out6;
wire [31:0] merge_out7, merge_out8, merge_out9;

wire acc_mode;
assign acc_mode = (mode==2'd3);
wire merge_vld;
wire [INPUT_NUM*DATA_WIDTH-1:0] ofmp;
wire [INPUT_NUM*DATA_WIDTH-1:0] shortcut_output_1, shortcut_output_2, shortcut_output_3;
wire [INPUT_NUM*DATA_WIDTH-1:0] shortcut_output_4, shortcut_output_5, shortcut_output_6;
wire [INPUT_NUM*DATA_WIDTH-1:0] shortcut_output_7, shortcut_output_8, shortcut_output_9;
wire write_valid_nosc;
wire sc_valid;
wire[7:0] avgpool_out1, avgpool_out2, avgpool_out3;
wire[7:0] avgpool_out4, avgpool_out5, avgpool_out6;
wire[7:0] avgpool_out7, avgpool_out8, avgpool_out9;
wire avgpool_out_vld;
mac_array u_mac_array1
(
.clk           (clk),
.rst_n         (rst_n),
.tlast         (tlast),
.tlast_pw (tlast_pw),
.acc_mode (acc_mode),
.shortcut_addr_sel (shortcut_addr_sel),
.data          (data1),
.weight        (weight1),
.input_zero    (input_zero), 
.Fx_zero       (output_zero),   
.sc_zero       (sc_zero),
.m0            (m0),
.m1            (m1_1),   
.mode         (mode),
.avgpool_chan_start(avgpool_chan_start),
.avgpool_chan_done(avgpool_chan_done),
.ifmap_size(ifmap_size),
.avgpool_out      (avgpool_out1),
.avgpool_out_vld  (avgpool_out_vld),
.merge_out          (merge_out1),
.shortcut_output(shortcut_output_1),
.merge_vld          (merge_vld),
.sc_valid          (sc_valid)
 );
 
 mac_array u_mac_array2
(
.clk           (clk),
.rst_n         (rst_n),
.tlast         (tlast),
.tlast_pw (tlast_pw),
.acc_mode (acc_mode),
.shortcut_addr_sel (shortcut_addr_sel),
.data          (data2),
.weight        (weight2),
.input_zero    (input_zero),    
.Fx_zero       (output_zero),   
.sc_zero       (sc_zero),
.m0            (m0),
.m1            (m1_2),   
.mode         (mode),
.avgpool_chan_start(avgpool_chan_start),
.avgpool_chan_done(avgpool_chan_done),
.ifmap_size(ifmap_size),
.avgpool_out      (avgpool_out2),
.avgpool_out_vld  (),
.merge_out          (merge_out2),
.shortcut_output(shortcut_output_2),
.merge_vld          (),
.sc_valid          ()
 );
 
 mac_array u_mac_array3
(
.clk           (clk),
.rst_n         (rst_n),
.tlast         (tlast),
.tlast_pw (tlast_pw),
.acc_mode (acc_mode),
.shortcut_addr_sel (shortcut_addr_sel),
.data          (data3),
.weight        (weight3),
.input_zero    (input_zero),  
.Fx_zero       (output_zero),   
.sc_zero       (sc_zero),
.m0            (m0),
.m1            (m1_3),   
.mode         (mode),
.avgpool_chan_start(avgpool_chan_start),
.avgpool_chan_done(avgpool_chan_done),
.ifmap_size(ifmap_size),
.avgpool_out      (avgpool_out3),
.avgpool_out_vld  (),
.merge_out          (merge_out3),
.shortcut_output(shortcut_output_3),
.merge_vld          (),
.sc_valid          ()
 );
 
 mac_array u_mac_array4
(
.clk           (clk),
.rst_n         (rst_n),
.tlast         (tlast),
.tlast_pw (tlast_pw),
.acc_mode (acc_mode),
.shortcut_addr_sel (shortcut_addr_sel),
.data          (data4),
.weight        (weight4),
.input_zero    (input_zero),  
.Fx_zero       (output_zero),   
.sc_zero       (sc_zero),  
.m0            (m0),
.m1            (m1_4),   
.mode         (mode),
.avgpool_chan_start(avgpool_chan_start),
.avgpool_chan_done(avgpool_chan_done),
.ifmap_size(ifmap_size),
.avgpool_out      (avgpool_out4),
.avgpool_out_vld  (),
.merge_out          (merge_out4),
.shortcut_output(shortcut_output_4),
.merge_vld          (),
.sc_valid          ()
 );

 
 mac_array u_mac_array5
(
.clk           (clk),
.rst_n         (rst_n),
.tlast         (tlast),
.tlast_pw (tlast_pw),
.acc_mode      (acc_mode),
.shortcut_addr_sel (shortcut_addr_sel),
.data          (data5),
.weight        (weight5),
.input_zero    (input_zero),   
.Fx_zero       (output_zero),   
.sc_zero       (sc_zero), 
.m0            (m0),
.m1            (m1_5),   
.mode         (mode),
.avgpool_chan_start(avgpool_chan_start),
.avgpool_chan_done(avgpool_chan_done),
.ifmap_size(ifmap_size),
.avgpool_out      (avgpool_out5),
.avgpool_out_vld  (),
.merge_out          (merge_out5),
.shortcut_output(shortcut_output_5),
.merge_vld          (),
.sc_valid          ()
 );
 
 mac_array u_mac_array6
(
.clk           (clk),
.rst_n         (rst_n),
.tlast         (tlast),
.tlast_pw (tlast_pw),
.acc_mode      (acc_mode),
.shortcut_addr_sel (shortcut_addr_sel),
.data          (data6),
.weight        (weight6),
.input_zero    (input_zero),    
.Fx_zero       (output_zero),   
.sc_zero       (sc_zero),
.m0            (m0),
.m1            (m1_6),   
.mode         (mode),
.avgpool_chan_start(avgpool_chan_start),
.avgpool_chan_done(avgpool_chan_done),
.ifmap_size(ifmap_size),
.avgpool_out      (avgpool_out6),
.avgpool_out_vld  (),
.merge_out          (merge_out6),
.shortcut_output(shortcut_output_6),
.merge_vld          (),
.sc_valid          ()
 );
 
 mac_array u_mac_array7
(
.clk           (clk),
.rst_n         (rst_n),
.tlast         (tlast),
.tlast_pw (tlast_pw),
.acc_mode      (acc_mode),
.shortcut_addr_sel (shortcut_addr_sel),
.data          (data7),
.weight        (weight7),
.input_zero    (input_zero),
.Fx_zero       (output_zero),   
.sc_zero       (sc_zero),    
.m0            (m0),
.m1            (m1_7),   
.mode         (mode),
.avgpool_chan_start(avgpool_chan_start),
.avgpool_chan_done(avgpool_chan_done),
.ifmap_size(ifmap_size),
.merge_out          (merge_out7),
.avgpool_out      (avgpool_out7),
.avgpool_out_vld  (),
.shortcut_output(shortcut_output_7),
.merge_vld          (),
.sc_valid          ()
 );
 
 mac_array u_mac_array8
(
.clk           (clk),
.rst_n         (rst_n),
.tlast         (tlast),
.tlast_pw (tlast_pw),
.acc_mode      (acc_mode),
.shortcut_addr_sel (shortcut_addr_sel),
.data          (data8),
.weight        (weight8),
.input_zero    (input_zero),  
.Fx_zero       (output_zero),   
.sc_zero       (sc_zero),  
.m0            (m0),
.m1            (m1_8),   
.mode         (mode),
.avgpool_chan_start(avgpool_chan_start),
.avgpool_chan_done(avgpool_chan_done),
.ifmap_size(ifmap_size),
.merge_out          (merge_out8),
.avgpool_out      (avgpool_out8),
.avgpool_out_vld  (),
.shortcut_output(shortcut_output_8),
.merge_vld          (),
.sc_valid          ()
 );
 
 mac_array u_mac_array9
(
.clk           (clk),
.rst_n         (rst_n),
.tlast         (tlast),
.tlast_pw (tlast_pw),
.acc_mode      (acc_mode),
.shortcut_addr_sel (shortcut_addr_sel),
.data          (data9),
.weight        (weight9),
.input_zero    (input_zero),  
.Fx_zero       (output_zero),   
.sc_zero       (sc_zero),  
.m0            (m0),
.m1            (m1_9),   
.mode         (mode),
.avgpool_chan_start(avgpool_chan_start),
.avgpool_chan_done(avgpool_chan_done),
.ifmap_size(ifmap_size),
.merge_out          (merge_out9),
.avgpool_out      (avgpool_out9),
.avgpool_out_vld  (),
.shortcut_output(shortcut_output_9),
.merge_vld    (),
.sc_valid    ()
 );
 
mode_arbiter mode_arbiter0(
    .clk(clk),
    .rst(rst_n),
    .array_mac0_out(merge_out1), .array_mac1_out(merge_out2), .array_mac2_out(merge_out3),  
    .array_mac3_out(merge_out4), .array_mac4_out(merge_out5), .array_mac5_out(merge_out6),
    .array_mac6_out(merge_out7), .array_mac7_out(merge_out8), .array_mac8_out(merge_out9),
    .mode(mode),
    .relu_enable(relu_enable),
    .sum_valid(merge_vld),
    .output_zero(output_zero),
    // --------- DEBUG ---------- //
    .conv_output0(conv_output0), .conv_output1(conv_output1), .conv_output2(conv_output2),
    
    .calculation_res(ofmp),
    .write_valid(write_valid_nosc)
    );
wire[71:0] avgpool_output;
assign avgpool_output = {avgpool_out9, avgpool_out8, avgpool_out7, avgpool_out6, avgpool_out5, avgpool_out4, avgpool_out3, avgpool_out2, avgpool_out1};
assign write_valid =  (mode == 3'd5)? avgpool_out_vld : ((mode == 3'd4) ? sc_valid : write_valid_nosc);
assign ofmap_write_0 = (mode == 3'd5)? avgpool_output : ((mode == 3'd4) ? shortcut_output_1 : ofmp);
assign ofmap_write_1 = (mode == 3'd4) ? shortcut_output_2 : ofmp;
assign ofmap_write_2 = (mode == 3'd4) ? shortcut_output_3 : ofmp;
assign ofmap_write_3 = (mode == 3'd4) ? shortcut_output_4 : ofmp;
assign ofmap_write_4 = (mode == 3'd4) ? shortcut_output_5 : ofmp;
assign ofmap_write_5 = (mode == 3'd4) ? shortcut_output_6 : ofmp;
assign ofmap_write_6 = (mode == 3'd4) ? shortcut_output_7 : ofmp;
assign ofmap_write_7 = (mode == 3'd4) ? shortcut_output_8 : ofmp;
assign ofmap_write_8 = (mode == 3'd4) ? shortcut_output_9 : ofmp;
endmodule
