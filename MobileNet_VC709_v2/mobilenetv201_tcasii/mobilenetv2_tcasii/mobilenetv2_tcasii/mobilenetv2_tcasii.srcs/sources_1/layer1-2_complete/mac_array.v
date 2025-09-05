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
	input                                 acc_mode      ,
	input     [INPUT_NUM*ACT_WIDTH-1:0]   data          ,
	input     [INPUT_NUM*WEIGHT_WIDTH-1:0] weight       ,
	
	input           [OUTPUT_WIDTH-1:0]    input_zero    ,    
	
	input signed        [M0_WIDTH-1:0]    m0            ,
	input signed        [M1_WIDTH-1:0]    m1            ,   

	input [1:0] mode,
	
	output             [31:0] merge_out,
	output             merge_vld
 );
 
wire [32-1:0]            sum;
wire                 sum_vld;
 
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

assign MAC_data_in_offset1 = MAC_data_in1 - input_zero;
assign MAC_data_in_offset2 = MAC_data_in2 - input_zero;
assign MAC_data_in_offset3 = MAC_data_in3 - input_zero;
assign MAC_data_in_offset4 = MAC_data_in4 - input_zero;
assign MAC_data_in_offset5 = MAC_data_in5 - input_zero;
assign MAC_data_in_offset6 = MAC_data_in6 - input_zero;
assign MAC_data_in_offset7 = MAC_data_in7 - input_zero;
assign MAC_data_in_offset8 = MAC_data_in8 - input_zero;
assign MAC_data_in_offset9 = MAC_data_in9 - input_zero;

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
. tlast    (tlast),
. acc_mode (acc_mode),
. data     (MAC_data_in_offset1),
. weight   (MAC_weight_in1),
. psum_out (psum1)
);

 MAC u_MAC2(
. clk      (clk),
. rst_n    (rst_n),
. tlast    (tlast),
. acc_mode (acc_mode),
. data     (MAC_data_in_offset2),
. weight   (MAC_weight_in2),
. psum_out (psum2)
);

 MAC u_MAC3(
. clk      (clk),
. rst_n    (rst_n),
. tlast    (tlast),
. acc_mode (acc_mode),
. data     (MAC_data_in_offset3),
. weight   (MAC_weight_in3),
. psum_out (psum3)
);

 MAC u_MAC4(
. clk      (clk),
. rst_n    (rst_n),
. tlast    (tlast),
. acc_mode (acc_mode),
. data     (MAC_data_in_offset4),
. weight   (MAC_weight_in4),
. psum_out (psum4)
);

 MAC u_MAC5(
. clk      (clk),
. rst_n    (rst_n),
. tlast    (tlast),
. acc_mode (acc_mode),
. data     (MAC_data_in_offset5),
. weight   (MAC_weight_in5),
. psum_out (psum5)
);

 MAC u_MAC6(
. clk      (clk),
. rst_n    (rst_n),
. tlast    (tlast),
. acc_mode (acc_mode),
. data     (MAC_data_in_offset6),
. weight   (MAC_weight_in6),
. psum_out (psum6)
);

 MAC u_MAC7(
. clk      (clk),
. rst_n    (rst_n),
. tlast    (tlast),
. acc_mode (acc_mode),
. data     (MAC_data_in_offset7),
. weight   (MAC_weight_in7),
. psum_out (psum7)
);

 MAC u_MAC8(
. clk      (clk),
. rst_n    (rst_n),
. tlast    (tlast),
. acc_mode (acc_mode),
. data     (MAC_data_in_offset8),
. weight   (MAC_weight_in8),
. psum_out (psum8)
);

 MAC u_MAC9(
. clk      (clk),
. rst_n    (rst_n),
. tlast    (tlast),
. acc_mode (acc_mode),
. data     (MAC_data_in_offset9),
. weight   (MAC_weight_in9),
. psum_out (psum9)
);


adder_tree_9 u_adder_tree_9
(
.   clk (clk),
. rst_n (rst_n),
. tlast (tlast),
. acc_mode (acc_mode),
.    a1 (psum1),
.    a2 (psum2),
.    a3 (psum3),
.    a4 (psum4),
.    a5 (psum5),
.    a6 (psum6),
.    a7 (psum7),
.    a8 (psum8),
.    a9 (psum9),
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

 
endmodule
