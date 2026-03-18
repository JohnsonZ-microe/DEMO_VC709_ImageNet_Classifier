`timescale 1ns / 100ps

module tb_mac_array_x9;

parameter INPUT_NUM      =  9 ;
parameter ACT_WIDTH      =  8 ;
parameter WEIGHT_WIDTH   =  8 ;
parameter M0_WIDTH       = 32 ;
parameter M1_WIDTH       = 32 ;
parameter DATA_WIDTH     = ACT_WIDTH + WEIGHT_WIDTH ;
parameter OUTPUT_WIDTH   = 8  ;


logic                                 clk           ;//
logic                                 rst_n         ;//
logic                                 start         ;//
logic                                 tlast         ;//
logic     [INPUT_NUM*DATA_WIDTH-1:0]  data1         ;//
logic     [INPUT_NUM*DATA_WIDTH-1:0]  data2         ;//
logic     [INPUT_NUM*DATA_WIDTH-1:0]  data3         ;//
logic     [INPUT_NUM*DATA_WIDTH-1:0]  data4         ;//
logic     [INPUT_NUM*DATA_WIDTH-1:0]  data5         ;//
logic     [INPUT_NUM*DATA_WIDTH-1:0]  data6         ;//
logic     [INPUT_NUM*DATA_WIDTH-1:0]  data7         ;//
logic     [INPUT_NUM*DATA_WIDTH-1:0]  data8         ;//
logic     [INPUT_NUM*DATA_WIDTH-1:0]  data9         ;//
logic           [OUTPUT_WIDTH-1:0]    input_zero    ;//

assign input_zero = 'd128;    


logic signed        [M0_WIDTH-1:0]    m0            ;

assign m0 = 'd2;

logic signed        [M1_WIDTH-1:0]    m1_1          ; 
logic signed        [M1_WIDTH-1:0]    m1_2          ;
logic signed        [M1_WIDTH-1:0]    m1_3          ;
logic signed        [M1_WIDTH-1:0]    m1_4          ;
logic signed        [M1_WIDTH-1:0]    m1_5          ;
logic signed        [M1_WIDTH-1:0]    m1_6          ;
logic signed        [M1_WIDTH-1:0]    m1_7          ;
logic signed        [M1_WIDTH-1:0]    m1_8          ;  
logic signed        [M1_WIDTH-1:0]    m1_9          ;

assign      m1_1   = -1; 
assign      m1_2   = -1;
assign      m1_3   = -1;
assign      m1_4   = -1;
assign      m1_5   = -1;
assign      m1_6   = -1;
assign      m1_7   = -1;
assign      m1_8   = -1;  
assign      m1_9   = -1;


logic                                 relu_enable   ; 

assign relu_enable = 1'b1;

logic             [OUTPUT_WIDTH-1:0]  output_zero   ;

assign  output_zero = 'd100;

logic             [OUTPUT_WIDTH-1:0]  ofmp1         ;
logic             [OUTPUT_WIDTH-1:0]  ofmp2         ;
logic             [OUTPUT_WIDTH-1:0]  ofmp3         ;
logic             [OUTPUT_WIDTH-1:0]  ofmp4         ;
logic             [OUTPUT_WIDTH-1:0]  ofmp5         ;
logic             [OUTPUT_WIDTH-1:0]  ofmp6         ;
logic             [OUTPUT_WIDTH-1:0]  ofmp7         ;
logic             [OUTPUT_WIDTH-1:0]  ofmp8         ;
logic             [OUTPUT_WIDTH-1:0]  ofmp9         ;

initial begin
clk = 1'b1;
rst_n = 1'b0;
start = 1'b0;
#200 rst_n = 1'b1;
#200 start = 1'b1;
end

always#2.5 clk = ~clk;

logic [7:0] cnt;



always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		cnt <= 'd0;
	end
	else begin
		# 1 ;
		if(start)begin
			if(cnt == 'd20)
				cnt <= 'd0;
			else
				cnt <= cnt + 1'b1;
		end
	end
end 

mac_array_x9 u_macc_array_x9
(
. clk         (clk        ) ,
. rst_n       (rst_n      ) ,
. tlast       (tlast      ) ,
. data1       (data1      ) ,
. data2       (data2      ) ,
. data3       (data3      ) ,
. data4       (data4      ) ,
. data5       (data5      ) ,
. data6       (data6      ) ,
. data7       (data7      ) ,
. data8       (data8      ) ,
. data9       (data9      ) ,
. input_zero  (input_zero ) ,    
. m0          (m0         ) ,
. m1_1        (m1_1       ) , 
. m1_2        (m1_2       ) ,
. m1_3        (m1_3       ) ,
. m1_4        (m1_4       ) ,
. m1_5        (m1_5       ) ,
. m1_6        (m1_6       ) ,
. m1_7        (m1_7       ) ,
. m1_8        (m1_8       ) ,  
. m1_9        (m1_9       ) ,
. relu_enable (relu_enable) , 
. output_zero (output_zero) ,
. ofmp1       (ofmp1      ) ,
. ofmp2       (ofmp2      ) ,
. ofmp3       (ofmp3      ) ,
. ofmp4       (ofmp4      ) ,
. ofmp5       (ofmp5      ) ,
. ofmp6       (ofmp6      ) ,
. ofmp7       (ofmp7      ) ,
. ofmp8       (ofmp8      ) ,
. ofmp9       (ofmp9      ) 
);

wire [7:0] cnt_plus1;
wire [7:0] cnt_plus2;
wire [7:0] cnt_plus3;
wire [7:0] cnt_plus4;
wire [7:0] cnt_plus5;
wire [7:0] cnt_plus6;
wire [7:0] cnt_plus7;
wire [7:0] cnt_plus8;
wire [7:0] cnt_plus9;






assign data1   = {cnt,cnt_plus1,cnt,cnt_plus1,cnt,cnt_plus1,cnt,cnt_plus1,cnt,cnt_plus1,cnt,cnt_plus1,cnt,cnt_plus1,cnt,cnt_plus1,cnt,cnt_plus1} ;
assign data2   = {cnt,cnt_plus2,cnt,cnt_plus2,cnt,cnt_plus2,cnt,cnt_plus2,cnt,cnt_plus2,cnt,cnt_plus2,cnt,cnt_plus2,cnt,cnt_plus2,cnt,cnt_plus2} ;
assign data3   = {cnt,cnt_plus3,cnt,cnt_plus3,cnt,cnt_plus3,cnt,cnt_plus3,cnt,cnt_plus3,cnt,cnt_plus3,cnt,cnt_plus3,cnt,cnt_plus3,cnt,cnt_plus3} ;
assign data4   = {cnt,cnt_plus4,cnt,cnt_plus4,cnt,cnt_plus4,cnt,cnt_plus4,cnt,cnt_plus4,cnt,cnt_plus4,cnt,cnt_plus4,cnt,cnt_plus4,cnt,cnt_plus4} ;
assign data5   = {cnt,cnt_plus5,cnt,cnt_plus5,cnt,cnt_plus5,cnt,cnt_plus5,cnt,cnt_plus5,cnt,cnt_plus5,cnt,cnt_plus5,cnt,cnt_plus5,cnt,cnt_plus5} ;
assign data6   = {cnt,cnt_plus6,cnt,cnt_plus6,cnt,cnt_plus6,cnt,cnt_plus6,cnt,cnt_plus6,cnt,cnt_plus6,cnt,cnt_plus6,cnt,cnt_plus6,cnt,cnt_plus6} ;
assign data7   = {cnt,cnt_plus7,cnt,cnt_plus7,cnt,cnt_plus7,cnt,cnt_plus7,cnt,cnt_plus7,cnt,cnt_plus7,cnt,cnt_plus7,cnt,cnt_plus7,cnt,cnt_plus7} ;
assign data8   = {cnt,cnt_plus8,cnt,cnt_plus8,cnt,cnt_plus8,cnt,cnt_plus8,cnt,cnt_plus8,cnt,cnt_plus8,cnt,cnt_plus8,cnt,cnt_plus8,cnt,cnt_plus8} ;
assign data9   = {cnt,cnt_plus9,cnt,cnt_plus9,cnt,cnt_plus9,cnt,cnt_plus9,cnt,cnt_plus9,cnt,cnt_plus9,cnt,cnt_plus9,cnt,cnt_plus9,cnt,cnt_plus9} ;

always@(*)begin
	if(cnt == 'd0 || cnt == 'd2 || cnt == 'd6 || cnt == 'd10 || (cnt <= 'd20) && (cnt >= 'd13))
		tlast = 1'b1;
	else
		tlast = 1'b0;
end

assign cnt_plus1 = cnt + 'd1;
assign cnt_plus2 = cnt + 'd2;
assign cnt_plus3 = cnt + 'd3;
assign cnt_plus4 = cnt + 'd4;
assign cnt_plus5 = cnt + 'd5;
assign cnt_plus6 = cnt + 'd6;
assign cnt_plus7 = cnt + 'd7;
assign cnt_plus8 = cnt + 'd8;
assign cnt_plus9 = cnt + 'd9;

endmodule










