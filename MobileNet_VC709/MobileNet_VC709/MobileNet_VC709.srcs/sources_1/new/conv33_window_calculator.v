`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/17 08:25:50
// Design Name: 
// Module Name: conv33_window_calculator
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


module conv33_window_calculator
#(
parameter DATA_WIDTH = 8, 
parameter WEIGHT_WIDTH = 8,
parameter BIAS_WIDTH = 8,
parameter ADDER_WIDTH = 32,
parameter FILTER_HIGHT = 3,
parameter FILTER_WIDTH = 3
)

(
input clk,ena,
input signed [DATA_WIDTH - 1:0]data_in_1,
input signed [DATA_WIDTH - 1:0]data_in_2,
input signed [DATA_WIDTH - 1:0]data_in_3,

input signed [WEIGHT_WIDTH - 1:0]weight_in_1,
input signed [WEIGHT_WIDTH - 1:0]weight_in_2,
input signed [WEIGHT_WIDTH - 1:0]weight_in_3,

input signed [31:0] M0_input,

output reg [1:0]filter_cnt,

input conv_channel_calculation_finishing,
output signed [31:0]data_out,
output valid_channel

);

reg [FILTER_HIGHT * FILTER_WIDTH * ADDER_WIDTH - 1:0] filter_reg = 0;


wire adder_valid_in;
wire adder_ena;

assign adder_ena = (filter_cnt == FILTER_WIDTH-1)? 1:0;
assign valid_channel = adder_valid_in;

//filter count (Conv33_local_hori_cnt delayed by 2clk, used to cover the 2clk delay of BRAM)
always @(posedge clk) begin
	if(ena && (filter_cnt == FILTER_WIDTH - 1))
	begin 
		if (conv_channel_calculation_finishing)
	  	filter_cnt <= 0;
		else filter_cnt <= filter_cnt;
	end 
	else if (ena)
	begin
		filter_cnt <= filter_cnt + 1; 
	end 
	else 
	begin
		filter_cnt <= 0; 
	end 
end 

// 3*3 window buffer
always @(posedge clk)
begin
	if (ena && adder_valid_in)
	begin 
		filter_reg <= 0;
	end 
	else if (ena)
	begin 
		case(filter_cnt)
		0:
		begin
			filter_reg[ADDER_WIDTH - 1:0] <= data_in_1 * weight_in_1;
			filter_reg[2 * ADDER_WIDTH - 1:ADDER_WIDTH] <= data_in_2 * weight_in_2;
			filter_reg[3 * ADDER_WIDTH - 1:2 * ADDER_WIDTH] <= data_in_3 * weight_in_3;
		end
		1:
		begin 
			filter_reg[4 * ADDER_WIDTH - 1:3 * ADDER_WIDTH] <= data_in_1 * weight_in_1;
			filter_reg[5 * ADDER_WIDTH - 1:4 * ADDER_WIDTH] <= data_in_2 * weight_in_2;
			filter_reg[6 * ADDER_WIDTH - 1:5 * ADDER_WIDTH] <= data_in_3 * weight_in_3;
		end
		2:
		begin 
			filter_reg[7 * ADDER_WIDTH - 1:6 * ADDER_WIDTH] <= data_in_1 * weight_in_1;
			filter_reg[8 * ADDER_WIDTH - 1:7 * ADDER_WIDTH] <= data_in_2 * weight_in_2;
			filter_reg[9 * ADDER_WIDTH - 1:8 * ADDER_WIDTH] <= data_in_3 * weight_in_3;
		end
		default:
		begin 
			filter_reg <= filter_reg;
		end
		endcase
	end
end 


adder_tree U0(
.clk(clk),
.valid_in(adder_ena),
.adder_tree_data_in(filter_reg),
.M0_input(M0_input),
.adder_tree_data_out(data_out),
.adder_valid(adder_valid_in)
);

endmodule

