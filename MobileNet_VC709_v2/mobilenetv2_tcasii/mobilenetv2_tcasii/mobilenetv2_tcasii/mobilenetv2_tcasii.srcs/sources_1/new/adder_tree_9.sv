(* dont_touch = "true"*)module adder_tree_9#
(
	parameter IN_WIDTH  = 32,
	parameter OUT_WIDTH = 32

)
(
	input                                    clk,
	input                                  rst_n,
	input                                  tlast,
	input                               acc_mode,
	input  signed [IN_WIDTH-1:0]              a1,
	input  signed [IN_WIDTH-1:0]              a2,
	input  signed [IN_WIDTH-1:0]              a3,
	input  signed [IN_WIDTH-1:0]              a4,
	input  signed [IN_WIDTH-1:0]              a5,
	input  signed [IN_WIDTH-1:0]              a6,
	input  signed [IN_WIDTH-1:0]              a7,
	input  signed [IN_WIDTH-1:0]              a8,
	input  signed [IN_WIDTH-1:0]              a9,
	
	output reg signed [OUT_WIDTH-1:0]        sum,
	output                                sum_vld
	
// ----------------  DEBUG  -------------------  //
//    ,adder_tree_debug_if.PROBE DEBUG_IF
);


reg signed [IN_WIDTH-1:0]  b1,b2,b3,b4;
reg signed [IN_WIDTH-1:0]  c1,c2;
reg signed [IN_WIDTH-1:0]  d1;
reg signed [IN_WIDTH-1:0]  a9_r1,a9_r2,a9_r3;

wire      add;
reg       tlast_r0,tlast_r1,tlast_r2,tlast_r3,tlast_r4;

always@(posedge clk or negedge rst_n)
	if(!rst_n)begin
	    tlast_r0 <= 'd0;
		tlast_r1 <= 'd0;
		tlast_r2 <= 'd0;
		tlast_r3 <= 'd0;
		tlast_r4 <= 'd0;
	end
	else begin
	    tlast_r0 <= tlast;
		tlast_r1 <= tlast_r0;
		tlast_r2 <= tlast_r1;
		tlast_r3 <= tlast_r2;
		tlast_r4 <= tlast_r3;
	end

assign sum_vld = tlast_r4;

assign add = (acc_mode==1)? tlast: 1'b1;


always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		b1 <= 'd0;
		b2 <= 'd0;
		b3 <= 'd0;
		b4 <= 'd0;
	end
	else if(add)begin
		b1 <= a1 + a2;
		b2 <= a3 + a4;
		b3 <= a5 + a6;
		b4 <= a7 + a8;
	end
end

always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		c1 <= 'd0;
		c2 <= 'd0;
	end
	else begin
		c1 <= b1 + b2;
		c2 <= b3 + b4;
	end
end

always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		d1 <= 'd0;
	end
	else begin
		d1 <= c1 + c2;
	end
end

always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		a9_r1 <= 'd0;
		a9_r2 <= 'd0;
		a9_r3 <= 'd0;
	end
	else if(acc_mode) begin
	   if(add) begin
            a9_r1 <= a9;
            a9_r2 <= a9_r1;
            a9_r3 <= a9_r2;
        end
        else begin
            a9_r1 <= 0;
            a9_r2 <= 0;
            a9_r3 <= 0;
        end
	end
	else begin
        a9_r1 <= a9;
        a9_r2 <= a9_r1;
        a9_r3 <= a9_r2;
	end
end

always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		sum <= 'd0;
	end
	else 
		sum <= a9_r3 + d1; 
end

//------------------  DEBUG  ------------------ //
//always@(*) begin
//    DEBUG_IF.b1 <= b1;
//    DEBUG_IF.b2 <= b2;
//    DEBUG_IF.b3 <= b3;
//    DEBUG_IF.b4 <= b4;
    
//    DEBUG_IF.c1 <= c1;
//    DEBUG_IF.c2 <= c2;
    
//    DEBUG_IF.d1 <= d1;
//end


endmodule
