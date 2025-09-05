`timescale 1ns / 100ps

module tb_adder_tree_9;
logic clk;
logic rst_n;
logic start;

initial begin
clk   = 1'b1;
rst_n = 1'b0;
start = 1'b0;
#200 rst_n = 1'b1;
#200 start = 1'b1;
end

always#2.5 clk = ~clk;

logic [31:0] cnt;

always@(posedge clk or negedge rst_n)begin
	if(!rst_n)
		cnt <= 'd0;
	else begin
		if(start)begin
			if(cnt == 'd1023)
				cnt <= 'd0;
			else
				cnt <= cnt + 1'b1; 
		end
	end
end

reg tlast;

always@(*)begin
	if(cnt <= 'd100)
		tlast <= 1'b0;
	else if(cnt == 'd101)
		tlast <= 1'b1;
	else if(cnt == 'd201)
		tlast <= 1'b1;
	else if((cnt >= 'd300) && (cnt <= 'd400))
		tlast <= 1'b1;
	else
		tlast <= 1'b0;
end

logic sum_vld;
logic signed [31:0] mac_array_out;
adder_tree_9 u_adder_tree_9
(
.   clk (clk),
. rst_n (rst_n),
. tlast (tlast), 
.    a1 (cnt),
.    a2 (cnt),
.    a3 (cnt),
.    a4 (cnt),
.    a5 (cnt),
.    a6 (cnt),
.    a7 (cnt),
.    a8 (cnt),
.    a9 (cnt),
.   sum (mac_array_out),
. sum_vld (sum_vld)
);
endmodule
