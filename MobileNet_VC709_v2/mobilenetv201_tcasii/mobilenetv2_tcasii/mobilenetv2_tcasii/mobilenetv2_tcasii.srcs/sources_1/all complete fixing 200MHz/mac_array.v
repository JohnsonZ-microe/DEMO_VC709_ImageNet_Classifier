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
	input                                 complete      ,
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
	output                 sc_valid,
	output                 pw_valid
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


// wire signed [ACT_WIDTH:0] MAC_data_in_offset1;
// wire signed [ACT_WIDTH:0] MAC_data_in_offset2;
// wire signed [ACT_WIDTH:0] MAC_data_in_offset3;
// wire signed [ACT_WIDTH:0] MAC_data_in_offset4;
// wire signed [ACT_WIDTH:0] MAC_data_in_offset5;
// wire signed [ACT_WIDTH:0] MAC_data_in_offset6;
// wire signed [ACT_WIDTH:0] MAC_data_in_offset7;
// wire signed [ACT_WIDTH:0] MAC_data_in_offset8;
// wire signed [ACT_WIDTH:0] MAC_data_in_offset9;

// wire signed [ACT_WIDTH:0] MAC_data_in_offset1_Fxzero;
// wire signed [ACT_WIDTH:0] MAC_data_in_offset2_Fxzero;
// wire signed [ACT_WIDTH:0] MAC_data_in_offset3_Fxzero;
// wire signed [ACT_WIDTH:0] MAC_data_in_offset4_Fxzero;
// wire signed [ACT_WIDTH:0] MAC_data_in_offset5_Fxzero;
// wire signed [ACT_WIDTH:0] MAC_data_in_offset6_Fxzero;
// wire signed [ACT_WIDTH:0] MAC_data_in_offset7_Fxzero;
// wire signed [ACT_WIDTH:0] MAC_data_in_offset8_Fxzero;
// wire signed [ACT_WIDTH:0] MAC_data_in_offset9_Fxzero;

// wire signed [ACT_WIDTH:0] shortcut_data_in1, shortcut_data_in2, shortcut_data_in3, shortcut_data_in4, shortcut_data_in5,shortcut_data_in6, shortcut_data_in7, shortcut_data_in8, shortcut_data_in9;
(* max_fanout=25 *)reg signed [ACT_WIDTH:0] MAC_data_in_offset1;
(* max_fanout=25 *)reg signed [ACT_WIDTH:0] MAC_data_in_offset2;
(* max_fanout=25 *)reg signed [ACT_WIDTH:0] MAC_data_in_offset3;
(* max_fanout=25 *)reg signed [ACT_WIDTH:0] MAC_data_in_offset4;
(* max_fanout=25 *)reg signed [ACT_WIDTH:0] MAC_data_in_offset5;
(* max_fanout=25 *)reg signed [ACT_WIDTH:0] MAC_data_in_offset6;
(* max_fanout=25 *)reg signed [ACT_WIDTH:0] MAC_data_in_offset7;
(* max_fanout=25 *)reg signed [ACT_WIDTH:0] MAC_data_in_offset8;
(* max_fanout=25 *)reg signed [ACT_WIDTH:0] MAC_data_in_offset9;

(* max_fanout=25 *)reg signed [ACT_WIDTH:0] MAC_data_in_offset1_Fxzero;
(* max_fanout=25 *)reg signed [ACT_WIDTH:0] MAC_data_in_offset2_Fxzero;
(* max_fanout=25 *)reg signed [ACT_WIDTH:0] MAC_data_in_offset3_Fxzero;
(* max_fanout=25 *)reg signed [ACT_WIDTH:0] MAC_data_in_offset4_Fxzero;
(* max_fanout=25 *)reg signed [ACT_WIDTH:0] MAC_data_in_offset5_Fxzero;
(* max_fanout=25 *)reg signed [ACT_WIDTH:0] MAC_data_in_offset6_Fxzero;
(* max_fanout=25 *)reg signed [ACT_WIDTH:0] MAC_data_in_offset7_Fxzero;
(* max_fanout=25 *)reg signed [ACT_WIDTH:0] MAC_data_in_offset8_Fxzero;
(* max_fanout=25 *)reg signed [ACT_WIDTH:0] MAC_data_in_offset9_Fxzero;

wire signed [ACT_WIDTH:0] shortcut_data_in1, shortcut_data_in2, shortcut_data_in3, shortcut_data_in4, shortcut_data_in5,shortcut_data_in6, shortcut_data_in7, shortcut_data_in8, shortcut_data_in9;
// wire [7:0] zero_mux;
// //zero reg
// reg [7:0] Fx_zero_reg, input_zero_reg;
// always @(posedge clk) begin
// 	if(!rst_n) begin
// 		Fx_zero_reg <= 8'd0;
// 		input_zero_reg <= 8'd0;
// 	end
// 	else begin
// 		Fx_zero_reg <= Fx_zero;
// 		input_zero_reg <= input_zero;
// 	end
// end
// assign zero_mux = ((mode == 3'd4) && (shortcut_addr_sel == 1'b1)) ? Fx_zero_reg : input_zero_reg; 
always @(posedge clk) begin
	if(!rst_n)begin
		MAC_data_in_offset1 <= 0;
		MAC_data_in_offset2 <= 0;
		MAC_data_in_offset3 <= 0;
		MAC_data_in_offset4 <= 0;
		MAC_data_in_offset5 <= 0;
		MAC_data_in_offset6 <= 0;
		MAC_data_in_offset7 <= 0;
		MAC_data_in_offset8 <= 0;
		MAC_data_in_offset9 <= 0;
	end
	else begin
		MAC_data_in_offset1 <= MAC_data_in1 - input_zero;
		MAC_data_in_offset2 <= MAC_data_in2 - input_zero;
		MAC_data_in_offset3 <= MAC_data_in3 - input_zero;
		MAC_data_in_offset4 <= MAC_data_in4 - input_zero;
		MAC_data_in_offset5 <= MAC_data_in5 - input_zero;
		MAC_data_in_offset6 <= MAC_data_in6 - input_zero;
		MAC_data_in_offset7 <= MAC_data_in7 - input_zero;
		MAC_data_in_offset8 <= MAC_data_in8 - input_zero;
		MAC_data_in_offset9 <= MAC_data_in9 - input_zero;
	end
end

always @(posedge clk) begin
	if(!rst_n)begin
		MAC_data_in_offset1_Fxzero <= 0;
		MAC_data_in_offset2_Fxzero <= 0;
		MAC_data_in_offset3_Fxzero <= 0;
		MAC_data_in_offset4_Fxzero <= 0;
		MAC_data_in_offset5_Fxzero <= 0;
		MAC_data_in_offset6_Fxzero <= 0;
		MAC_data_in_offset7_Fxzero <= 0;
		MAC_data_in_offset8_Fxzero <= 0;
		MAC_data_in_offset9_Fxzero <= 0;
	end
	else begin
		MAC_data_in_offset1_Fxzero <= MAC_data_in1 - Fx_zero;
		MAC_data_in_offset2_Fxzero <= MAC_data_in2 - Fx_zero;
		MAC_data_in_offset3_Fxzero <= MAC_data_in3 - Fx_zero;
		MAC_data_in_offset4_Fxzero <= MAC_data_in4 - Fx_zero;
		MAC_data_in_offset5_Fxzero <= MAC_data_in5 - Fx_zero;
		MAC_data_in_offset6_Fxzero <= MAC_data_in6 - Fx_zero;
		MAC_data_in_offset7_Fxzero <= MAC_data_in7 - Fx_zero;
		MAC_data_in_offset8_Fxzero <= MAC_data_in8 - Fx_zero;
		MAC_data_in_offset9_Fxzero <= MAC_data_in9 - Fx_zero;
	end
end
// assign MAC_data_in_offset1 = MAC_data_in1 - input_zero;
// assign MAC_data_in_offset2 = MAC_data_in2 - input_zero;
// assign MAC_data_in_offset3 = MAC_data_in3 - input_zero;
// assign MAC_data_in_offset4 = MAC_data_in4 - input_zero;
// assign MAC_data_in_offset5 = MAC_data_in5 - input_zero;
// assign MAC_data_in_offset6 = MAC_data_in6 - input_zero;
// assign MAC_data_in_offset7 = MAC_data_in7 - input_zero;
// assign MAC_data_in_offset8 = MAC_data_in8 - input_zero;
// assign MAC_data_in_offset9 = MAC_data_in9 - input_zero;

// assign MAC_data_in_offset1_Fxzero = MAC_data_in1 - Fx_zero;
// assign MAC_data_in_offset2_Fxzero = MAC_data_in2 - Fx_zero;
// assign MAC_data_in_offset3_Fxzero = MAC_data_in3 - Fx_zero;
// assign MAC_data_in_offset4_Fxzero = MAC_data_in4 - Fx_zero;
// assign MAC_data_in_offset5_Fxzero = MAC_data_in5 - Fx_zero;
// assign MAC_data_in_offset6_Fxzero = MAC_data_in6 - Fx_zero;
// assign MAC_data_in_offset7_Fxzero = MAC_data_in7 - Fx_zero;
// assign MAC_data_in_offset8_Fxzero = MAC_data_in8 - Fx_zero;
// assign MAC_data_in_offset9_Fxzero = MAC_data_in9 - Fx_zero;

assign shortcut_data_in1 = shortcut_addr_sel == 1'b1 ? MAC_data_in_offset1_Fxzero : MAC_data_in_offset1;
assign shortcut_data_in2 = shortcut_addr_sel == 1'b1 ? MAC_data_in_offset2_Fxzero : MAC_data_in_offset2;
assign shortcut_data_in3 = shortcut_addr_sel == 1'b1 ? MAC_data_in_offset3_Fxzero : MAC_data_in_offset3;
assign shortcut_data_in4 = shortcut_addr_sel == 1'b1 ? MAC_data_in_offset4_Fxzero : MAC_data_in_offset4;
assign shortcut_data_in5 = shortcut_addr_sel == 1'b1 ? MAC_data_in_offset5_Fxzero : MAC_data_in_offset5;
assign shortcut_data_in6 = shortcut_addr_sel == 1'b1 ? MAC_data_in_offset6_Fxzero : MAC_data_in_offset6;
assign shortcut_data_in7 = shortcut_addr_sel == 1'b1 ? MAC_data_in_offset7_Fxzero : MAC_data_in_offset7;
assign shortcut_data_in8 = shortcut_addr_sel == 1'b1 ? MAC_data_in_offset8_Fxzero : MAC_data_in_offset8;
assign shortcut_data_in9 = shortcut_addr_sel == 1'b1 ? MAC_data_in_offset9_Fxzero : MAC_data_in_offset9;


// wire signed [WEIGHT_WIDTH-1:0] MAC_weight_in1;
// wire signed [WEIGHT_WIDTH-1:0] MAC_weight_in2;
// wire signed [WEIGHT_WIDTH-1:0] MAC_weight_in3;
// wire signed [WEIGHT_WIDTH-1:0] MAC_weight_in4;
// wire signed [WEIGHT_WIDTH-1:0] MAC_weight_in5;
// wire signed [WEIGHT_WIDTH-1:0] MAC_weight_in6;
// wire signed [WEIGHT_WIDTH-1:0] MAC_weight_in7;
// wire signed [WEIGHT_WIDTH-1:0] MAC_weight_in8;
// wire signed [WEIGHT_WIDTH-1:0] MAC_weight_in9;

(* max_fanout=25 *)reg signed [WEIGHT_WIDTH-1:0] MAC_weight_in1;
(* max_fanout=25 *)reg signed [WEIGHT_WIDTH-1:0] MAC_weight_in2;
(* max_fanout=25 *)reg signed [WEIGHT_WIDTH-1:0] MAC_weight_in3;
(* max_fanout=25 *)reg signed [WEIGHT_WIDTH-1:0] MAC_weight_in4;
(* max_fanout=25 *)reg signed [WEIGHT_WIDTH-1:0] MAC_weight_in5;
(* max_fanout=25 *)reg signed [WEIGHT_WIDTH-1:0] MAC_weight_in6;
(* max_fanout=25 *)reg signed [WEIGHT_WIDTH-1:0] MAC_weight_in7;
(* max_fanout=25 *)reg signed [WEIGHT_WIDTH-1:0] MAC_weight_in8;
(* max_fanout=25 *)reg signed [WEIGHT_WIDTH-1:0] MAC_weight_in9;

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

always @(posedge clk) begin
	if(!rst_n)begin
		MAC_weight_in1 <= 0;
		MAC_weight_in2 <= 0;
		MAC_weight_in3 <= 0;
		MAC_weight_in4 <= 0;
		MAC_weight_in5 <= 0;
		MAC_weight_in6 <= 0;
		MAC_weight_in7 <= 0;
		MAC_weight_in8 <= 0;
		MAC_weight_in9 <= 0;
	end
	else begin
		MAC_weight_in1 <= weight[1*ACT_WIDTH-1:0*ACT_WIDTH];
		MAC_weight_in2 <= weight[2*ACT_WIDTH-1:1*ACT_WIDTH];
		MAC_weight_in3 <= weight[3*ACT_WIDTH-1:2*ACT_WIDTH];
		MAC_weight_in4 <= weight[4*ACT_WIDTH-1:3*ACT_WIDTH];
		MAC_weight_in5 <= weight[5*ACT_WIDTH-1:4*ACT_WIDTH];
		MAC_weight_in6 <= weight[6*ACT_WIDTH-1:5*ACT_WIDTH];
		MAC_weight_in7 <= weight[7*ACT_WIDTH-1:6*ACT_WIDTH];
		MAC_weight_in8 <= weight[8*ACT_WIDTH-1:7*ACT_WIDTH];
		MAC_weight_in9 <= weight[9*ACT_WIDTH-1:8*ACT_WIDTH];
	end
end
// assign MAC_weight_in1  = weight[1*ACT_WIDTH-1:0*ACT_WIDTH]; 
// assign MAC_weight_in2  = weight[2*ACT_WIDTH-1:1*ACT_WIDTH]; 
// assign MAC_weight_in3  = weight[3*ACT_WIDTH-1:2*ACT_WIDTH]; 
// assign MAC_weight_in4  = weight[4*ACT_WIDTH-1:3*ACT_WIDTH]; 
// assign MAC_weight_in5  = weight[5*ACT_WIDTH-1:4*ACT_WIDTH]; 
// assign MAC_weight_in6  = weight[6*ACT_WIDTH-1:5*ACT_WIDTH]; 
// assign MAC_weight_in7  = weight[7*ACT_WIDTH-1:6*ACT_WIDTH]; 
// assign MAC_weight_in8  = weight[8*ACT_WIDTH-1:7*ACT_WIDTH]; 
// assign MAC_weight_in9  = weight[9*ACT_WIDTH-1:8*ACT_WIDTH]; 


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

reg first_tlast;
reg [2:0] mode_reg[0:1];
always @(posedge clk) begin
	if(!rst_n)begin
		mode_reg[0] <= 3'd0;
		mode_reg[1] <= 3'd0;
	end
	else begin
		mode_reg[0] <= mode;
		mode_reg[1] <= mode_reg[0];
	end
end
always@(posedge clk)begin
	if(!rst_n)begin
		first_tlast <= 0;
	end
	else if ((mode_reg[0]==0)&&(mode==3'd3))begin
		first_tlast <= 1'd1;
	end
	else if(tlast_mux)begin
		first_tlast <= 1'd0;
	end
	else begin
		first_tlast <= first_tlast;
	end
end

adder_tree_9 u_adder_tree_9
(
.   clk (clk),
. rst_n (rst_n),
. tlast (tlast_mux),
.first_tlast (first_tlast),
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
.sum_vld(sum_vld),
.pw_valid(pw_valid)
);


//m0 delay
reg [M0_WIDTH-1:0]  m1_r1,m1_r2,m1_r3,m1_r4,m1_r5,m1_r6,m1_r7,m1_r8,m1_r9,m1_r10,m1_r11;

always@(posedge clk or negedge rst_n)
	if(!rst_n)begin
		m1_r1 <= 'd0;
		m1_r2 <= 'd0;
		m1_r3 <= 'd0;
		m1_r4 <= 'd0;
		m1_r5 <= 'd0;
		m1_r6 <= 'd0;
		m1_r7 <= 'd0;
		m1_r8 <= 'd0;
		m1_r9 <= 'd0;
		m1_r10 <= 'd0;
		m1_r11 <= 'd0;
	end
	else begin
		m1_r1 <= m1;
		m1_r2 <= m1_r1;
		m1_r3 <= m1_r2;
		m1_r4 <= m1_r3;
		m1_r5 <= m1_r4;
		m1_r6 <= m1_r5;
		m1_r7 <= m1_r6;
		m1_r8 <= m1_r7;
		m1_r9 <= m1_r8;
		m1_r10 <= m1_r9;
		m1_r11 <= m1_r10;
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
.shortcut_addr_sel (shortcut_addr_sel),
.complete	   (complete),
.data0		  (shortcut_data_in1),
.data1		  (shortcut_data_in2),
.data2		  (shortcut_data_in3),
.data3		  (shortcut_data_in4),
.data4		  (shortcut_data_in5),
.data5		  (shortcut_data_in6),
.data6		  (shortcut_data_in7),
.data7		  (shortcut_data_in8),
.data8		  (shortcut_data_in9),
.m0			 (m0),
.m1			 (m1),
.x_zero        (input_zero),
.Fx_zero       (Fx_zero),
.sc_zero       (sc_zero),
.shortcut_output (shortcut_output),
.sc_valid	   (sc_valid)
);
reg [M0_WIDTH-1:0] m1_mux;
always @( *) begin
	case(mode_reg[1])
		3'd1: m1_mux = m1_r9;
		3'd2: m1_mux = m1_r10;
		3'd3: m1_mux = m1_r11;
		default :m1_mux = 0;
	endcase	
end


reg [M0_WIDTH-1:0] m0_reg [8:0];
integer i;
always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		for (i = 0; i < 9; i = i + 1) begin
			m0_reg[i] <= 0;
		end
	end
	else begin
		m0_reg[0] <= m0;
		for (i = 1; i < 9; i = i + 1) begin
			m0_reg[i] <= m0_reg[i-1];
		end
	end
end
m0xsigma_plus_m1 u_m0xsigma_plus_m1
(
.clk            (clk),
.rst_n          (rst_n),
.m0             (m0_reg[8]),
.m1             (m1_mux),     
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
