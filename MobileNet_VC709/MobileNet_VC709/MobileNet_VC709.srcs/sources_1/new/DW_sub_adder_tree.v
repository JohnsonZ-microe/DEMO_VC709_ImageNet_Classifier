module adder_tree
#(
parameter ADDER_WIDTH = 32,
parameter FILTER_WIDTH = 3,
parameter FILTER_HIGHT = 3
)

(
input clk,
input signed[ADDER_WIDTH * FILTER_WIDTH * FILTER_HIGHT - 1:0]adder_tree_data_in,
input valid_in,
input signed [31:0] M0_input,

output signed[ADDER_WIDTH-1:0]adder_tree_data_out,
output adder_valid
);

reg [2:0]adder_cnt = 0;
reg [ADDER_WIDTH - 1:0]adder_tmp_reg_1,adder_tmp_reg_2,adder_tmp_reg_3,adder_tmp_reg_4;
reg [ADDER_WIDTH - 1:0]adder_tmp_reg_5,adder_tmp_reg_6;


reg out_valid = 0;

assign  adder_valid = (adder_cnt == 5)?1:0;
assign  adder_tree_data_out = adder_tmp_reg_6;

always @(posedge clk)
begin
	if (valid_in && (adder_cnt == 5))
	begin 
		adder_cnt <= 0;
	end
	else if (valid_in)
	begin 
		adder_cnt <= adder_cnt + 1;
	end
	else 
	begin
		adder_cnt <= 0;
	end
end

always @(posedge clk)
begin 
	case(adder_cnt)
	0:
	begin 
		adder_tmp_reg_1 <= 0;
		adder_tmp_reg_2 <= 0;
		adder_tmp_reg_3 <= 0;
		adder_tmp_reg_4 <= 0;
		adder_tmp_reg_5 <= 0;
		adder_tmp_reg_6 <= 0;
	end
	1:
	begin 
		adder_tmp_reg_1 <= adder_tree_data_in[ADDER_WIDTH - 1:0] + adder_tree_data_in[2 * ADDER_WIDTH - 1:ADDER_WIDTH] + adder_tree_data_in[3 * ADDER_WIDTH - 1:2 * ADDER_WIDTH];
		adder_tmp_reg_2 <= adder_tree_data_in[4 * ADDER_WIDTH - 1:3 * ADDER_WIDTH] + adder_tree_data_in[5 * ADDER_WIDTH - 1:4 * ADDER_WIDTH] + adder_tree_data_in[6 * ADDER_WIDTH - 1:5 * ADDER_WIDTH];
		adder_tmp_reg_3 <= adder_tree_data_in[7 * ADDER_WIDTH - 1:6 * ADDER_WIDTH] + adder_tree_data_in[8 * ADDER_WIDTH - 1:7 * ADDER_WIDTH] + adder_tree_data_in[9 * ADDER_WIDTH - 1:8 * ADDER_WIDTH];
		adder_tmp_reg_4 <= 0;
		adder_tmp_reg_5 <= 0;
		adder_tmp_reg_6 <= 0;
	end
	2:
	begin
	    adder_tmp_reg_1 <= 0;
	    adder_tmp_reg_2 <= 0;
	    adder_tmp_reg_3 <= 0;
		adder_tmp_reg_4 <= adder_tmp_reg_1 + adder_tmp_reg_2 + adder_tmp_reg_3;
		adder_tmp_reg_5 <= 0;
		adder_tmp_reg_6 <= 0;
	end
	3:
	begin 
        adder_tmp_reg_1 <= 0;
	    adder_tmp_reg_2 <= 0;
	    adder_tmp_reg_3 <= 0;
        adder_tmp_reg_4 <= 0;
		adder_tmp_reg_5 <= M0_input*adder_tmp_reg_4;
        adder_tmp_reg_6 <= 0;
	end
	4:
	begin
        adder_tmp_reg_1 <= 0;
	    adder_tmp_reg_2 <= 0;
	    adder_tmp_reg_3 <= 0;
        adder_tmp_reg_4 <= 0;
        adder_tmp_reg_5 <= 0;
		adder_tmp_reg_6 <= adder_tmp_reg_5;
	end
	default:
	begin
        adder_tmp_reg_1 <= 0;
	    adder_tmp_reg_2 <= 0;
	    adder_tmp_reg_3 <= 0;
        adder_tmp_reg_4 <= 0;
        adder_tmp_reg_5 <= 0;
	    adder_tmp_reg_6 <= adder_tmp_reg_6;
	end 
	endcase
end


endmodule
