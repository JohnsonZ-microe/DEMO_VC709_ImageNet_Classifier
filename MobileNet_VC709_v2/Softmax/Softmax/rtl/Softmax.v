module Softmax(
	input clk,
	input rst_n,
	input en,
	input	[8-1 : 0] 	x_in,
	output 	[8-1 : 0]	Softmax_out,
	output 	[8-1 : 0]	out_idx,
	output			out_en
);


parameter wordlength = 8;
parameter vectorlength = 256;



/////////////////------------------------------------------------/////////////////////
////////////////////               FSM                   ////////////////////////
/////////////////------------------------------------------------////////////////////
    
localparam IDLE        = 2'd0;
localparam STAGE1      = 2'd1;
localparam STAGE2      = 2'd2;

wire stage1_finish, stage2_finish;
reg [1:0] accelerator_st;
reg [1:0] accelerator_next_st;

always @(posedge clk or negedge rst_n)
begin
    if (!rst_n)
    begin
        accelerator_st <= IDLE; 
    end 
    else if (en)
    begin 
        accelerator_st <= accelerator_next_st;
    end 
    else 
    begin
        accelerator_st <= IDLE; 
    end  
end
    
always @(*)
    begin
    case (accelerator_st)
        IDLE:
        begin 
            if (en) accelerator_next_st = STAGE1;
            else accelerator_next_st = IDLE;
        end 
        STAGE1:
        begin
            if (stage1_finish)
            begin 
                accelerator_next_st = STAGE2;
            end 
            else 
            begin
                accelerator_next_st = STAGE1;
            end 
        end 
        STAGE2: 
        begin
            if (stage2_finish)
            begin 
                accelerator_next_st = IDLE;
            end 
            else 
            begin
                accelerator_next_st = STAGE2;
            end 
        end
        default: accelerator_next_st = IDLE;
	endcase
end

/////////////////------------------------------------------------/////////////////////
////////////////////               Stage1 Implementation                   //////////
/////////////////------------------------------------------------////////////////////


wire [wordlength-1 : 0] maxbuf, mi, yi;


IntMax IntMax0(.a0(x_in), 
	.a1(maxbuf), 
	.val(mi), 
	.idx());


wire [wordlength-1 : 0] xi_m_mi;
assign xi_m_mi = x_in-mi;
Pow2 Pow2_i0( xi_m_mi, yi );

wire finish;
reg [8-1:0]	vector_pointer;
always@(posedge clk or negedge rst_n)	begin
	if(!rst_n)	begin
		vector_pointer <= 8'd0;
	end
	else begin
		if(accelerator_st == STAGE1) begin
			if(stage1_finish)
				vector_pointer <= 8'd0;
			else
				vector_pointer <= vector_pointer + 1'd1;
		end		
		else if(accelerator_st == STAGE2) begin
			if(stage2_finish)
				vector_pointer <= 8'd0;
			else
				vector_pointer <= vector_pointer + 1'd1;
		end 
		else begin
			vector_pointer <= 8'd0;
		end
	end
end

wire [8-1:0]	vector_pointer_add1;
assign vector_pointer_add1 = vector_pointer + 1'd1;

assign stage1_finish = (accelerator_st == STAGE1) && (vector_pointer == vectorlength-1'd1);

reg [wordlength-1 : 0] Max_Buffer;
always@(posedge clk or negedge rst_n)	begin
	if(!rst_n)	begin
		Max_Buffer <= 0;
	end
	else begin
		if(accelerator_st == STAGE1)	begin
			if(stage2_finish)
				Max_Buffer <= 0;
			else
				Max_Buffer <= mi;
		end		
		else begin
			Max_Buffer <= Max_Buffer;
		end 
	end
end
assign maxbuf = Max_Buffer[wordlength*vector_pointer_add1 +: wordlength];

wire [wordlength-1 : 0] diff_m, di;
assign diff_m = mi - maxbuf;


reg [2*wordlength-1 : 0] Sum_buffer;
always@(posedge clk or negedge rst_n)	begin
	if(!rst_n)	begin
		Sum_buffer <= 16'd0;
	end
	else begin
		if(accelerator_st == STAGE1)	begin
			if(stage2_finish)
				Sum_buffer <= 16'd0;
			else
				Sum_buffer <= Sum_buffer + di;
		end		
		else begin
			Sum_buffer <= Sum_buffer;
		end 
	end
end

wire [2*wordlength-1 : 0] di_m1;
assign di_m1 = Sum_buffer;
assign di = (di_m1 >> diff_m) + yi;

/////////////////------------------------------------------------/////////////////////
////////////////////               Stage2 Implementation                   //////////
/////////////////------------------------------------------------////////////////////

wire [23:0] y_i_shifted;
assign y_i_shifted = yi << (16-diff_m);


wire [24-1:0] quotient_out;
wire launch;
assign launch = (accelerator_st == STAGE2);

Div Div0( 
	.inst_clk(clk),
	.inst_rst_n(rst_n),
	.inst_a(y_i_shifted),
	.inst_b(di_m1),
	.quotient_inst(quotient_out),
	.remainder_inst(),
	.div_by_0_inst(),
	.inst_launch(launch),
	.inst_launch_id(vector_pointer),
	.pipe_full_inst(),
	.pipe_ovf_inst(),
	.inst_accept_n(1'd0),
	.arrive_inst(out_en),
	.arrive_id_inst(out_idx),
	.push_out_n_inst(),
	.pipe_census_inst() 
);


assign Softmax_out = quotient_out[wordlength-1 :0];

endmodule


