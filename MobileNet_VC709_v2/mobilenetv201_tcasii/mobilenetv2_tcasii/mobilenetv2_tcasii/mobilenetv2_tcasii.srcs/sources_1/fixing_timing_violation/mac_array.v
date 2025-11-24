module mac_array#
(
	parameter INPUT_NUM      =  9,
	parameter ACT_WIDTH      =  8,
	parameter WEIGHT_WIDTH   =  8,
	parameter M0_WIDTH       = 32,
	parameter M1_WIDTH       = 32,
	parameter OUTPUT_WIDTH   = 8 ,
	parameter ACC_WIDTH      = 32
)
(
	input                                 clk           ,
	input                                 rst_n         ,
	input                                 tlast         ,
	input								  tlast_pw  ,
	input                                 acc_mode      ,
	input								shortcut_addr_sel,
	input     [INPUT_NUM*ACT_WIDTH-1:0]   data          ,
	input     [INPUT_NUM*WEIGHT_WIDTH-1:0] weight       ,
	
	input           [OUTPUT_WIDTH-1:0]    input_zero    ,    
	input 		 	[OUTPUT_WIDTH-1:0]    Fx_zero   ,
	input      		[OUTPUT_WIDTH-1:0]    sc_zero,
	input signed        [M0_WIDTH-1:0]    m0            ,
	input signed        [M1_WIDTH-1:0]    m1            ,   

	input [2:0] mode,
	input 							   avgpool_chan_start,
	input avgpool_chan_done,
	input [7:0] ifmap_size,
	output             [31:0] merge_out,
	output [INPUT_NUM*OUTPUT_WIDTH-1:0] shortcut_output,
	output [OUTPUT_WIDTH-1:0] avgpool_out,
	output                 avgpool_out_vld,
	output             merge_vld,
	output                 sc_valid
 );
 
wire [32-1:0]            sum;
wire                 sum_vld;

wire tlast_mux;
assign tlast_mux = (acc_mode == 1) ? tlast_pw : tlast; // 
wire [ACT_WIDTH-1:0] MAC_data_in1;
wire [ACT_WIDTH-1:0] MAC_data_in2;
wire [ACT_WIDTH-1:0] MAC_data_in3;
wire [ACT_WIDTH-1:0] MAC_data_in4;
wire [ACT_WIDTH-1:0] MAC_data_in5;
wire [ACT_WIDTH-1:0] MAC_data_in6;
wire [ACT_WIDTH-1:0] MAC_data_in7;
wire [ACT_WIDTH-1:0] MAC_data_in8;
wire [ACT_WIDTH-1:0] MAC_data_in9;

 
wire signed [ACT_WIDTH:0] MAC_data_in_offset1;
wire signed [ACT_WIDTH:0] MAC_data_in_offset2;
wire signed [ACT_WIDTH:0] MAC_data_in_offset3;
wire signed [ACT_WIDTH:0] MAC_data_in_offset4;
wire signed [ACT_WIDTH:0] MAC_data_in_offset5;
wire signed [ACT_WIDTH:0] MAC_data_in_offset6;
wire signed [ACT_WIDTH:0] MAC_data_in_offset7;
wire signed [ACT_WIDTH:0] MAC_data_in_offset8;
wire signed [ACT_WIDTH:0] MAC_data_in_offset9;

wire [7:0] zero_mux;
assign zero_mux = ((mode == 3'd4) && (shortcut_addr_sel == 1'b1)) ? Fx_zero : input_zero; 
assign MAC_data_in_offset1 = MAC_data_in1 - zero_mux;
assign MAC_data_in_offset2 = MAC_data_in2 - zero_mux;
assign MAC_data_in_offset3 = MAC_data_in3 - zero_mux;
assign MAC_data_in_offset4 = MAC_data_in4 - zero_mux;
assign MAC_data_in_offset5 = MAC_data_in5 - zero_mux;
assign MAC_data_in_offset6 = MAC_data_in6 - zero_mux;
assign MAC_data_in_offset7 = MAC_data_in7 - zero_mux;
assign MAC_data_in_offset8 = MAC_data_in8 - zero_mux;
assign MAC_data_in_offset9 = MAC_data_in9 - zero_mux;

wire signed [WEIGHT_WIDTH-1:0] MAC_weight_in1;
wire signed [WEIGHT_WIDTH-1:0] MAC_weight_in2;
wire signed [WEIGHT_WIDTH-1:0] MAC_weight_in3;
wire signed [WEIGHT_WIDTH-1:0] MAC_weight_in4;
wire signed [WEIGHT_WIDTH-1:0] MAC_weight_in5;
wire signed [WEIGHT_WIDTH-1:0] MAC_weight_in6;
wire signed [WEIGHT_WIDTH-1:0] MAC_weight_in7;
wire signed [WEIGHT_WIDTH-1:0] MAC_weight_in8;
wire signed [WEIGHT_WIDTH-1:0] MAC_weight_in9;

wire [ACC_WIDTH-1:0] psum1;
wire [ACC_WIDTH-1:0] psum2;
wire [ACC_WIDTH-1:0] psum3;
wire [ACC_WIDTH-1:0] psum4;
wire [ACC_WIDTH-1:0] psum5;
wire [ACC_WIDTH-1:0] psum6;
wire [ACC_WIDTH-1:0] psum7;
wire [ACC_WIDTH-1:0] psum8;
wire [ACC_WIDTH-1:0] psum9;

wire [ACC_WIDTH-1:0] a1,a2,a3,a4,a5,a6,a7,a8,a9;


assign MAC_data_in1 = data[1*ACT_WIDTH-1:0*ACT_WIDTH];
assign MAC_data_in2 = data[2*ACT_WIDTH-1:1*ACT_WIDTH];
assign MAC_data_in3 = data[3*ACT_WIDTH-1:2*ACT_WIDTH];
assign MAC_data_in4 = data[4*ACT_WIDTH-1:3*ACT_WIDTH];
assign MAC_data_in5 = data[5*ACT_WIDTH-1:4*ACT_WIDTH];
assign MAC_data_in6 = data[6*ACT_WIDTH-1:5*ACT_WIDTH];
assign MAC_data_in7 = data[7*ACT_WIDTH-1:6*ACT_WIDTH];
assign MAC_data_in8 = data[8*ACT_WIDTH-1:7*ACT_WIDTH];
assign MAC_data_in9 = data[9*ACT_WIDTH-1:8*ACT_WIDTH];


assign MAC_weight_in1  = weight[1*ACT_WIDTH-1:0*ACT_WIDTH]; 
assign MAC_weight_in2  = weight[2*ACT_WIDTH-1:1*ACT_WIDTH]; 
assign MAC_weight_in3  = weight[3*ACT_WIDTH-1:2*ACT_WIDTH]; 
assign MAC_weight_in4  = weight[4*ACT_WIDTH-1:3*ACT_WIDTH]; 
assign MAC_weight_in5  = weight[5*ACT_WIDTH-1:4*ACT_WIDTH]; 
assign MAC_weight_in6  = weight[6*ACT_WIDTH-1:5*ACT_WIDTH]; 
assign MAC_weight_in7  = weight[7*ACT_WIDTH-1:6*ACT_WIDTH]; 
assign MAC_weight_in8  = weight[8*ACT_WIDTH-1:7*ACT_WIDTH]; 
assign MAC_weight_in9  = weight[9*ACT_WIDTH-1:8*ACT_WIDTH]; 

 
 MAC u_MAC1(
. clk      (clk),
. rst_n    (rst_n),
. tlast    (tlast_mux),
. acc_mode (acc_mode),
. data     (MAC_data_in_offset1),
. weight   (MAC_weight_in1),
. psum_out (psum1)
);

 MAC u_MAC2(
. clk      (clk),
. rst_n    (rst_n),
. tlast    (tlast_mux),
. acc_mode (acc_mode),
. data     (MAC_data_in_offset2),
. weight   (MAC_weight_in2),
. psum_out (psum2)
);

 MAC u_MAC3(
. clk      (clk),
. rst_n    (rst_n),
. tlast    (tlast_mux),
. acc_mode (acc_mode),
. data     (MAC_data_in_offset3),
. weight   (MAC_weight_in3),
. psum_out (psum3)
);

 MAC u_MAC4(
. clk      (clk),
. rst_n    (rst_n),
. tlast    (tlast_mux),
. acc_mode (acc_mode),
. data     (MAC_data_in_offset4),
. weight   (MAC_weight_in4),
. psum_out (psum4)
);

 MAC u_MAC5(
. clk      (clk),
. rst_n    (rst_n),
. tlast    (tlast_mux),
. acc_mode (acc_mode),
. data     (MAC_data_in_offset5),
. weight   (MAC_weight_in5),
. psum_out (psum5)
);

 MAC u_MAC6(
. clk      (clk),
. rst_n    (rst_n),
. tlast    (tlast_mux),
. acc_mode (acc_mode),
. data     (MAC_data_in_offset6),
. weight   (MAC_weight_in6),
. psum_out (psum6)
);

 MAC u_MAC7(
. clk      (clk),
. rst_n    (rst_n),
. tlast    (tlast_mux),
. acc_mode (acc_mode),
. data     (MAC_data_in_offset7),
. weight   (MAC_weight_in7),
. psum_out (psum7)
);

 MAC u_MAC8(
. clk      (clk),
. rst_n    (rst_n),
. tlast    (tlast_mux),
. acc_mode (acc_mode),
. data     (MAC_data_in_offset8),
. weight   (MAC_weight_in8),
. psum_out (psum8)
);

 MAC u_MAC9(
. clk      (clk),
. rst_n    (rst_n),
. tlast    (tlast_mux),
. acc_mode (acc_mode),
. data     (MAC_data_in_offset9),
. weight   (MAC_weight_in9),
. psum_out (psum9)
);

assign a1 = (mode == 3'd5) ? MAC_data_in1 : psum1;
assign a2 = (mode == 3'd5) ? MAC_data_in2 : psum2;
assign a3 = (mode == 3'd5) ? MAC_data_in3 : psum3;
assign a4 = (mode == 3'd5) ? MAC_data_in4 : psum4;
assign a5 = (mode == 3'd5) ? MAC_data_in5 : psum5;
assign a6 = (mode == 3'd5) ? MAC_data_in6 : psum6;
assign a7 = (mode == 3'd5) ? MAC_data_in7 : psum7;
assign a8 = (mode == 3'd5) ? MAC_data_in8 : psum8;
assign a9 = (mode == 3'd5) ? MAC_data_in9 : psum9;
adder_tree_9 u_adder_tree_9
(
.   clk (clk),
. rst_n (rst_n),
. tlast (tlast),
. acc_mode (acc_mode),
.    a1 (a1),
.    a2 (a2),
.    a3 (a3),
.    a4 (a4),
.    a5 (a5),
.    a6 (a6),
.    a7 (a7),
.    a8 (a8),
.    a9 (a9),
.   sum (sum),
.sum_vld(sum_vld)
);


//m0 delay
reg [M0_WIDTH-1:0]  m1_r1,m1_r2,m1_r3,m1_r4;

always@(posedge clk or negedge rst_n)
	if(!rst_n)begin
		m1_r1 <= 'd0;
		m1_r2 <= 'd0;
		m1_r3 <= 'd0;
		m1_r4 <= 'd0;
	end
	else begin
		m1_r1 <= m1;
		m1_r2 <= m1_r1;
		m1_r3 <= m1_r2;
		m1_r4 <= m1_r3;
	end
reg[31:0] sum_delay;
wire[31:0] sum_mux;
always @(posedge clk or negedge rst_n) begin
	if (!rst_n)
		sum_delay <= 32'd0;
	else
		sum_delay <= sum;
end
assign sum_mux = (mode == 2'd2) ? sum_delay : sum;

shortcut u_shortcut
(
.clk            (clk),
.rst_n          (rst_n),
.mode		  (mode),
.shortcut_addr_sel (shortcut_addr_sel),
.data0		  (MAC_data_in_offset1),
.data1		  (MAC_data_in_offset2),
.data2		  (MAC_data_in_offset3),
.data3		  (MAC_data_in_offset4),
.data4		  (MAC_data_in_offset5),
.data5		  (MAC_data_in_offset6),
.data6		  (MAC_data_in_offset7),
.data7		  (MAC_data_in_offset8),
.data8		  (MAC_data_in_offset9),
.m0			 (m0),
.m1			 (m1),
.x_zero        (input_zero),
.Fx_zero       (Fx_zero),
.sc_zero       (sc_zero),
.shortcut_output (shortcut_output),
.sc_valid	   (sc_valid)
);
m0xsigma_plus_m1 u_m0xsigma_plus_m1
(
.clk            (clk),
.rst_n          (rst_n),
.m0             (m0),
.m1             (m1_r4),     
.mac_array_out  (sum_mux),
.sum_vld        (sum_vld),
.merge_vld      (merge_vld),
.merge_out           (merge_out)   
);


avgpool u_avgpool (
.clk            (clk),
.rst_n          (rst_n),
.avgpool_chan_start (avgpool_chan_start),
.avgpool_chan_done (avgpool_chan_done),
.ifmap_size     (ifmap_size),
.adder_tree_sum (sum),
.avgpool_out	(avgpool_out),
.avgpool_out_vld (avgpool_out_vld)
  );

 
endmodule
