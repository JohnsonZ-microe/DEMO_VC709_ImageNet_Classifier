(* dont_touch = "true"*)(* keep_hierarchy = "yes" *) module mac_array_x9#
(
	parameter INPUT_NUM      =  9,
	parameter ACT_WIDTH      =  8,
	parameter WEIGHT_WIDTH   =  8,
	parameter M0_WIDTH       = 32,
	parameter M1_WIDTH       = 32,
	parameter OUTPUT_WIDTH   = 8,
	parameter DATA_WIDTH     = 8
)
(
	input                                 clk           ,
	input                                 rst_n         ,
	input                                 tlast         ,
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
     
    input  [INPUT_NUM*ACT_WIDTH-1:0]  SC_input,
    input  has_SC_in,  
     
	input           [OUTPUT_WIDTH-1:0]    input_zero    ,  
	input           [OUTPUT_WIDTH-1:0]    output_zero    ,
	input           [OUTPUT_WIDTH-1:0]    SC_zero_point,
	
	input signed        [M0_WIDTH-1:0]    m0            ,
	input signed        [M0_WIDTH-1:0]    SC_M2         ,
	
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
 	
//    //       --------     DEBUG  -------            //
//    output [DATA_WIDTH-1:0] conv_output0, conv_output1, conv_output2,
//    //---------------------------------------------//
 	
 	
	output             [9*OUTPUT_WIDTH-1:0] ofmp,
	output             write_valid         
);


wire [31:0] merge_out1, merge_out2, merge_out3;
wire [31:0] merge_out4, merge_out5, merge_out6;
wire [31:0] merge_out7, merge_out8, merge_out9;

wire acc_mode;
assign acc_mode = (mode==3'd3 || mode==3'd4);
wire merge_vld;

//mac_array_debug_if mac_array_debug_if1();
//adder_tree_debug_if adder_tree_debug_if1();
//M_s_debug_if M_s_DEBUG_IF1();
mac_array u_mac_array1
(
.clk           (clk),
.rst_n         (rst_n),
.tlast         (tlast),
.acc_mode (acc_mode),
.data          (data1),
.weight        (weight1),
.input_zero    (input_zero), 
.F_zero(SC_zero_point),   
.m0            (m0),
.m1            (m1_1),   
.m2(SC_M2),
.has_SC(has_SC_in),
.SC_input(SC_input[1*ACT_WIDTH-1:0*ACT_WIDTH]),
.merge_out          (merge_out1),
.merge_vld          (merge_vld)
//,.DEBUG_IF(mac_array_debug_if1),
//.adder_tree_DEBUG_IF(adder_tree_debug_if1),
//.M_s_DEBUG_IF(M_s_DEBUG_IF1)
 );
 
//mac_array_debug_if mac_array_debug_if2();
//adder_tree_debug_if adder_tree_debug_if2();
//M_s_debug_if M_s_DEBUG_IF2();
 mac_array u_mac_array2
(
.clk           (clk),
.rst_n         (rst_n),
.tlast         (tlast),
.acc_mode (acc_mode),
.data          (data2),
.weight        (weight2),
.input_zero    (input_zero),  
.F_zero(SC_zero_point),     
.m0            (m0),
.m1            (m1_2),   
.m2(SC_M2),
.has_SC(has_SC_in),
.SC_input(SC_input[2*ACT_WIDTH-1:1*ACT_WIDTH]),
.merge_out          (merge_out2),
.merge_vld          ()
//,.DEBUG_IF(mac_array_debug_if2),
//.adder_tree_DEBUG_IF(adder_tree_debug_if2),
//.M_s_DEBUG_IF(M_s_DEBUG_IF2)
 );
 
mac_array_debug_if mac_array_debug_if3();
adder_tree_debug_if adder_tree_debug_if3();
M_s_debug_if M_s_DEBUG_IF3();
 mac_array u_mac_array3
(
.clk           (clk),
.rst_n         (rst_n),
.tlast         (tlast),
.acc_mode (acc_mode),
.data          (data3),
.weight        (weight3),
.input_zero    (input_zero),  
.F_zero(SC_zero_point),     
.m0            (m0),
.m1            (m1_3),   
.m2(SC_M2),
.has_SC(has_SC_in),
.SC_input(SC_input[2*ACT_WIDTH-1:1*ACT_WIDTH]),
.merge_out          (merge_out3),
.merge_vld          ()
//,.DEBUG_IF(mac_array_debug_if3),
//.adder_tree_DEBUG_IF(adder_tree_debug_if3),
//.M_s_DEBUG_IF(M_s_DEBUG_IF3)
 );

 
 
 mac_array_debug_if mac_array_debug_if4();
 adder_tree_debug_if adder_tree_debug_if4();
 M_s_debug_if M_s_DEBUG_IF4();
 mac_array u_mac_array4
(
.clk           (clk),
.rst_n         (rst_n),
.tlast         (tlast),
.acc_mode (acc_mode),
.data          (data4),
.weight        (weight4),
.input_zero    (input_zero),  
.F_zero(SC_zero_point),     
.m0            (m0),
.m1            (m1_4),   
.m2(SC_M2),
.has_SC(has_SC_in),
.SC_input(SC_input[3*ACT_WIDTH-1:2*ACT_WIDTH]),
.merge_out          (merge_out4),
.merge_vld          ()
//,.DEBUG_IF(mac_array_debug_if4),
//.adder_tree_DEBUG_IF(adder_tree_debug_if4),
//.M_s_DEBUG_IF(M_s_DEBUG_IF4)
 );

// mac_array_debug_if mac_array_debug_if5();
// adder_tree_debug_if adder_tree_debug_if5();
// M_s_debug_if M_s_DEBUG_IF5();
 mac_array u_mac_array5
(
.clk           (clk),
.rst_n         (rst_n),
.tlast         (tlast),
.acc_mode      (acc_mode),
.data          (data5),
.weight        (weight5),
.input_zero    (input_zero),  
.F_zero(SC_zero_point),     
.m0            (m0),
.m1            (m1_5),  
.m2(SC_M2),
.has_SC(has_SC_in),
.SC_input(SC_input[4*ACT_WIDTH-1:3*ACT_WIDTH]), 
.merge_out          (merge_out5),
.merge_vld          ()
//,.DEBUG_IF(mac_array_debug_if5),
//.adder_tree_DEBUG_IF(adder_tree_debug_if5),
//.M_s_DEBUG_IF(M_s_DEBUG_IF5)
 );
 
// mac_array_debug_if mac_array_debug_if6();
// adder_tree_debug_if adder_tree_debug_if6();
// M_s_debug_if M_s_DEBUG_IF6();
 mac_array u_mac_array6
(
.clk           (clk),
.rst_n         (rst_n),
.tlast         (tlast),
.acc_mode      (acc_mode),
.data          (data6),
.weight        (weight6),
.input_zero    (input_zero), 
.F_zero(SC_zero_point),      
.m0            (m0),
.m1            (m1_6), 
.m2(SC_M2),
.has_SC(has_SC_in),
.SC_input(SC_input[5*ACT_WIDTH-1:4*ACT_WIDTH]),  
.merge_out          (merge_out6),
.merge_vld          ()
//,.DEBUG_IF(mac_array_debug_if6),
//.adder_tree_DEBUG_IF(adder_tree_debug_if6),
//.M_s_DEBUG_IF(M_s_DEBUG_IF6)
 );
 
// mac_array_debug_if mac_array_debug_if7();
// adder_tree_debug_if adder_tree_debug_if7();
// M_s_debug_if M_s_DEBUG_IF7();
 mac_array u_mac_array7
(
.clk           (clk),
.rst_n         (rst_n),
.tlast         (tlast),
.acc_mode      (acc_mode),
.data          (data7),
.weight        (weight7),
.input_zero    (input_zero),  
.F_zero(SC_zero_point),     
.m0            (m0),
.m1            (m1_7),   
.m2(SC_M2),
.has_SC(has_SC_in),
.SC_input(SC_input[6*ACT_WIDTH-1:5*ACT_WIDTH]),
.merge_out          (merge_out7),
.merge_vld          ()
//,.DEBUG_IF(mac_array_debug_if7),
//.adder_tree_DEBUG_IF(adder_tree_debug_if7),
//.M_s_DEBUG_IF(M_s_DEBUG_IF7)
 );
 
// mac_array_debug_if mac_array_debug_if8();
// adder_tree_debug_if adder_tree_debug_if8();
// M_s_debug_if M_s_DEBUG_IF8();
 mac_array u_mac_array8
(
.clk           (clk),
.rst_n         (rst_n),
.tlast         (tlast),
.acc_mode      (acc_mode),
.data          (data8),
.weight        (weight8),
.input_zero    (input_zero),  
.F_zero(SC_zero_point),     
.m0            (m0),
.m1            (m1_8),   
.m2(SC_M2),
.has_SC(has_SC_in),
.SC_input(SC_input[7*ACT_WIDTH-1:6*ACT_WIDTH]),
.merge_out          (merge_out8),
.merge_vld          ()
//,.DEBUG_IF(mac_array_debug_if8),
//.adder_tree_DEBUG_IF(adder_tree_debug_if8),
//.M_s_DEBUG_IF(M_s_DEBUG_IF8)
 );
// mac_array_debug_if mac_array_debug_if9();
// adder_tree_debug_if adder_tree_debug_if9();
// M_s_debug_if M_s_DEBUG_IF9();
 mac_array u_mac_array9
(
.clk           (clk),
.rst_n         (rst_n),
.tlast         (tlast),
.acc_mode      (acc_mode),
.data          (data9),
.weight        (weight9),
.input_zero    (input_zero),   
.F_zero(SC_zero_point),    
.m0            (m0),
.m1            (m1_9),   
.m2(SC_M2),
.has_SC(has_SC_in),
.SC_input(SC_input[8*ACT_WIDTH-1:7*ACT_WIDTH]),
.merge_out          (merge_out9),
.merge_vld    ()
//,.DEBUG_IF(mac_array_debug_if9),
//.adder_tree_DEBUG_IF(adder_tree_debug_if9),
//.M_s_DEBUG_IF(M_s_DEBUG_IF9)
 );
 
//------------  Array MAC Monitor ----------------//
// array_mac_monitor array_mac_monitor1(
//    clk, rst_n,
//    mac_array_debug_if1, mac_array_debug_if2, mac_array_debug_if3,
//    adder_tree_debug_if1, adder_tree_debug_if2, adder_tree_debug_if3,
//    M_s_DEBUG_IF1, M_s_DEBUG_IF2, M_s_DEBUG_IF3
//    );
//------------  DEBUG ----------------------------//
 

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
//    .conv_output0(conv_output0), .conv_output1(conv_output1), .conv_output2(conv_output2),
    
    .calculation_res(ofmp),
    .write_valid(write_valid)
    );
    
endmodule

