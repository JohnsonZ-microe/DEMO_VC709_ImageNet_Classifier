`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/09/10 15:54:09
// Design Name: 
// Module Name: softmax
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


module softmax#(
	parameter INPUT_NUM      =  9,
	parameter DATA_WIDTH      =  8,
    parameter POW_WIDTH       =  32,
    parameter M0_WIDTH         =32,
    parameter DATA_BRAM_ADDR_WIDTH = 18,
    parameter TOPK_NUM       =  5,
    parameter TOPK_IDX_WIDTH     =  10,
    parameter BRAM_READ_CYCLE =  112,
    parameter VECTOR_LENGTH  = 1000
    )(
    input clk,
    input rst_n,
    input softmax_en,
    input signed [M0_WIDTH-1:0] m0,
    input signed [DATA_WIDTH-1:0]zero_point,
    input [INPUT_NUM*DATA_WIDTH-1:0] data_in,
    input [DATA_BRAM_ADDR_WIDTH-1:0] bram_read_base_addr,
    input [DATA_BRAM_ADDR_WIDTH-1:0] bram_write_base_addr,
    output reg [DATA_BRAM_ADDR_WIDTH-1:0] softmax_read_addr,
    output reg [DATA_BRAM_ADDR_WIDTH-1:0] softmax_write_addr,
    output reg [INPUT_NUM*DATA_WIDTH-1:0] softmax_out,
    output softmax_write_valid,
    output reg softmax_finish
    );


/////////////////------------------------------------------------/////////////////////
////////////////////               FSM                   ////////////////////////
/////////////////------------------------------------------------////////////////////
    
localparam IDLE        = 3'd0;
localparam STAGE1      = 3'd1;//stage1: save value into register
localparam STAGE2      = 3'd2;//stage2: find top5, calculate pow2 and sum
localparam STAGE3      = 3'd3;//stage3: calculate top5 pow2 value
localparam STAGE4      = 3'd4;//stage4: calculate top5 softmax value and idx
reg stage1_finish,stage2_finish,stage3_finish,stage4_finish;

reg [2:0] softmax_st;
reg [2:0] softmax_next_st;

always @(posedge clk or negedge rst_n)
begin
    if (!rst_n)
    begin
        softmax_st <= IDLE; 
    end 
    else if (softmax_en)
    begin 
        softmax_st <= softmax_next_st;
    end 
    else 
    begin
        softmax_st <= IDLE; 
    end  
end
    
always @(*)
    begin
    case (softmax_st)
        IDLE:
        begin 
            if (softmax_en) softmax_next_st = STAGE1;
            else softmax_next_st = IDLE;
        end 
        STAGE1:
        begin
            softmax_next_st = stage1_finish ? STAGE2 : STAGE1;
        end 
        STAGE2: 
        begin
            softmax_next_st = stage2_finish ? STAGE3 : STAGE2;
        end
        STAGE3:
        begin
            softmax_next_st = stage3_finish ? STAGE4 : STAGE3;
        end
        STAGE4:
        begin
            softmax_next_st = stage4_finish ? IDLE : STAGE4;
        end
        default: softmax_next_st = IDLE;
	endcase
end

/////////////////------------------------------------------------/////////////////////
////////////////////               Stage1 Implementation                   //////////
/////////////////------------------------------------------------////////////////////


reg signed [DATA_WIDTH-1:0] data_reg [0:VECTOR_LENGTH-1];
integer i;
reg [6:0]bram_read_counter;
reg [6:0]bram_read_counter_reg1, bram_read_counter_reg2, bram_read_counter_reg3;
always @(posedge clk) begin
    if(!rst_n)begin
        bram_read_counter_reg1 <= 0;
        bram_read_counter_reg2 <= 0;
        bram_read_counter_reg3 <= 0;
    end
    else begin
        bram_read_counter_reg1  <= bram_read_counter;
        bram_read_counter_reg2 <= bram_read_counter_reg1;
        bram_read_counter_reg3 <= bram_read_counter_reg2;
    end
end
wire signed [31:0] test1,test2,test3;
assign test1 = ($signed(data_in[DATA_WIDTH*1-1:DATA_WIDTH*0]) - zero_point);
assign test2 = m0*($signed(data_in[DATA_WIDTH*1-1:DATA_WIDTH*0]) - zero_point);
assign test3 = (m0*($signed(data_in[DATA_WIDTH*1-1:DATA_WIDTH*0]) - zero_point)) >> 8;
wire signed [8:0] zero_point_signed_9bit;
assign zero_point_signed_9bit = $signed({{1{zero_point[7]}}, zero_point}); // 8位有符号数扩展到9位
always@(posedge clk)begin
    if(!rst_n)begin
        for(i=0;i<VECTOR_LENGTH;i=i+1)begin
            data_reg[i]<=0;
        end
        bram_read_counter <=0;
        softmax_read_addr <= bram_read_base_addr;
        stage1_finish <= 1'b0;
    end
    else if(softmax_st == STAGE1 && stage1_finish == 0)begin
        if(bram_read_counter == BRAM_READ_CYCLE + 2)begin
            bram_read_counter <=0;
            data_reg[bram_read_counter_reg3*9+0] <= (m0*($signed({1'b0,data_in[DATA_WIDTH*1-1:DATA_WIDTH*0]}) - zero_point_signed_9bit)) >> 8;
            stage1_finish <=  1'b1;
        end
        else begin
            bram_read_counter <= bram_read_counter +1;
            softmax_read_addr <= bram_read_base_addr + bram_read_counter;
            data_reg[bram_read_counter_reg3*9+0] <= (m0*($signed({1'b0,data_in[DATA_WIDTH*1-1:DATA_WIDTH*0]}) - zero_point_signed_9bit)) >> 8;
            data_reg[bram_read_counter_reg3*9+1] <= (m0*($signed({1'b0,data_in[DATA_WIDTH*2-1:DATA_WIDTH*1]}) - zero_point_signed_9bit)) >> 8;
            data_reg[bram_read_counter_reg3*9+2] <= (m0*($signed({1'b0,data_in[DATA_WIDTH*3-1:DATA_WIDTH*2]}) - zero_point_signed_9bit)) >> 8;
            data_reg[bram_read_counter_reg3*9+3] <= (m0*($signed({1'b0,data_in[DATA_WIDTH*4-1:DATA_WIDTH*3]}) - zero_point_signed_9bit)) >> 8;
            data_reg[bram_read_counter_reg3*9+4] <= (m0*($signed({1'b0,data_in[DATA_WIDTH*5-1:DATA_WIDTH*4]}) - zero_point_signed_9bit)) >> 8;
            data_reg[bram_read_counter_reg3*9+5] <= (m0*($signed({1'b0,data_in[DATA_WIDTH*6-1:DATA_WIDTH*5]}) - zero_point_signed_9bit)) >> 8;
            data_reg[bram_read_counter_reg3*9+6] <= (m0*($signed({1'b0,data_in[DATA_WIDTH*7-1:DATA_WIDTH*6]}) - zero_point_signed_9bit)) >> 8;
            data_reg[bram_read_counter_reg3*9+7] <= (m0*($signed({1'b0,data_in[DATA_WIDTH*8-1:DATA_WIDTH*7]}) - zero_point_signed_9bit)) >> 8;
            data_reg[bram_read_counter_reg3*9+8] <= (m0*($signed({1'b0,data_in[DATA_WIDTH*9-1:DATA_WIDTH*8]}) - zero_point_signed_9bit)) >> 8;
        end
    end
    else begin
        stage1_finish <= 1'b0;
        bram_read_counter <=0;
        softmax_read_addr <= bram_read_base_addr;
    end
end
/////////////////------------------------------------------------/////////////////////
////////////////////               Stage2 Implementation                   //////////
/////////////////------------------------------------------------////////////////////
reg signed[DATA_WIDTH-1:0] topk_val [0:TOPK_NUM-1];
reg[TOPK_IDX_WIDTH-1:0] topk_idx [0:TOPK_NUM-1];

reg [TOPK_IDX_WIDTH-1:0] idx;

//find top5
always @(posedge clk) begin
    if(!rst_n)begin
        for (i=0;i<TOPK_NUM;i=i+1) begin
            topk_val[i] <= 0;
            topk_idx[i] <= 0;
        end
    end
    else if(softmax_st == STAGE2)begin
        if(idx < VECTOR_LENGTH) begin
            //compare with topk_val
            if(data_reg[idx] > topk_val[TOPK_NUM-1]) begin
                if(data_reg[idx] > topk_val[0])begin
                    {topk_val[0],topk_idx[0]} <= {data_reg[idx],idx};
                    {topk_val[1],topk_idx[1]} <= {topk_val[0],topk_idx[0]};
                    {topk_val[2],topk_idx[2]} <= {topk_val[1],topk_idx[1]};
                    {topk_val[3],topk_idx[3]} <= {topk_val[2],topk_idx[2]};
                    {topk_val[4],topk_idx[4]} <= {topk_val[3],topk_idx[3]};
                end
                else if(data_reg[idx] > topk_val[1])begin
                    {topk_val[1],topk_idx[1]} <= {data_reg[idx],idx};
                    {topk_val[2],topk_idx[2]} <= {topk_val[1],topk_idx[1]};
                    {topk_val[3],topk_idx[3]} <= {topk_val[2],topk_idx[2]};
                    {topk_val[4],topk_idx[4]} <= {topk_val[3],topk_idx[3]};
                end
                else if(data_reg[idx] > topk_val[2])begin
                    {topk_val[2],topk_idx[2]} <= {data_reg[idx],idx};
                    {topk_val[3],topk_idx[3]} <= {topk_val[2],topk_idx[2]};
                    {topk_val[4],topk_idx[4]} <= {topk_val[3],topk_idx[3]};
                end
                else if(data_reg[idx] > topk_val[3])begin
                    {topk_val[3],topk_idx[3]} <= {data_reg[idx],idx};
                    {topk_val[4],topk_idx[4]} <= {topk_val[3],topk_idx[3]};
                end
                else begin
                    {topk_val[4],topk_idx[4]} <= {data_reg[idx],idx};
                end
            end
        end
    end
    else begin
        for (i=0;i<TOPK_NUM;i=i+1) begin
            topk_val[i] <= topk_val[i];
            topk_idx[i] <= topk_idx[i];
        end
    end
end
//idx counter
always @(posedge clk) begin
    if(!rst_n)begin
        idx <= 0;
        stage2_finish <= 1'b0;
    end
    else if(softmax_st == STAGE2)begin
        if(idx == VECTOR_LENGTH - 1) begin
            idx <= 0;
            stage2_finish <= 1'b1;
        end
        else begin
            idx <= idx + 1;
            stage2_finish <= 1'b0;
        end
    end
    else begin
        idx <= 0;
        stage2_finish <= 1'b0;
    end
end

//pow2 and sum

reg [POW_WIDTH:0] pow2_initial;
reg [POW_WIDTH+3:0] pow2_sum;
wire [POW_WIDTH:0] pow2_current;
wire signed [DATA_WIDTH-1:0] diff;
wire [DATA_WIDTH-1:0] current_data;
assign current_data = data_reg[idx];
assign pow2_current = data_reg[idx]>topk_val[0]? pow2_initial:(pow2_initial >> (topk_val[0]-data_reg[idx]));
assign diff = data_reg[idx]>topk_val[0] ? data_reg[idx] - topk_val[0]:0;
always @(posedge clk) begin
    if(!rst_n)begin
        pow2_initial <= 33'h100000000;
        pow2_sum <= 0;
    end
    else if (softmax_st == STAGE2)begin
        if(data_reg[idx] > topk_val[0])begin
            pow2_sum <= (pow2_sum >> diff) + pow2_current;
        end
        else begin
            pow2_sum <= pow2_sum + pow2_current;  
        end
    end
    else begin
        pow2_sum <= pow2_sum;
    end
end

/////////////////------------------------------------------------/////////////////////
////////////////////               Stage3 Implementation                   //////////
/////////////////------------------------------------------------////////////////////
reg [POW_WIDTH:0] pow2_topk_val [0:TOPK_NUM-1];

reg [2:0] stage3_counter;
wire [9:0] topk_idx_current;
assign topk_idx_current = topk_idx[stage3_counter];
always @(posedge clk) begin
    if(!rst_n)begin
        for(i=0;i<TOPK_NUM;i=i+1)begin
            pow2_topk_val[i]<=0;
        end
    end
    else if(softmax_st == STAGE3)begin
        pow2_topk_val[stage3_counter]<= (pow2_initial >> (topk_val[0]-topk_val[stage3_counter]));
    end
    else begin
        for(i=0;i<TOPK_NUM;i=i+1)begin
            pow2_topk_val[i]<= pow2_topk_val[i];
        end
    end
end

//stage3 counter
always @(posedge clk) begin
    if(!rst_n)begin
        stage3_counter <= 0;
        stage3_finish <= 1'b0;
    end
    else if(softmax_st == STAGE3)begin
        if(stage3_counter == TOPK_NUM -1) begin
            stage3_counter <= 0;
            stage3_finish <= 1'b1;
        end
        else begin
            stage3_counter <= stage3_counter + 1;
            stage3_finish <= 1'b0;
        end
    end
    else begin
        stage3_counter <= 0;
        stage3_finish <= 1'b0;
    end
end
/////////////////------------------------------------------------/////////////////////
////////////////////               Stage4 Implementation                   //////////
/////////////////------------------------------------------------////////////////////
reg [2:0] stage4_counter;
reg [DATA_WIDTH-1:0] softmax_topk_val [0:TOPK_NUM-1];
wire [87:0] dout;
wire [7:0] softmax;
wire tvalid;
wire[47:0] dividend;
wire[39:0] divisor;

always @(posedge clk) begin
    if(!rst_n)begin
        stage4_counter <= 0;
        stage4_finish <= 1'b0;
    end
    else if(softmax_st == STAGE4)begin
        if(stage4_counter == TOPK_NUM -1) begin
            stage4_counter <= 0;
            stage4_finish <= 1'b1;
        end
        else begin
            stage4_counter <= stage4_counter + 1;
            stage4_finish <= 1'b0;
        end
    end
    else begin
        stage4_counter <= 0;
        stage4_finish <= 1'b0;
    end
end

assign dividend = {7'b0,pow2_topk_val[stage4_counter],8'b0};
assign divisor = {4'b0,pow2_sum};
assign softmax = tvalid ? (dout[48]?8'b11111111:dout[47:40]) : 8'b0;

div_gen_0 u_div (
  .aclk                 (clk),
  .s_axis_divisor_tdata     ({4'b0,pow2_sum}),
  .s_axis_dividend_tdata    ({7'b0,pow2_topk_val[stage4_counter],8'b0}),
  .m_axis_dout_tdata       (dout),
  .s_axis_divisor_tvalid   (softmax_next_st == STAGE4 && softmax_st == STAGE4),
  .s_axis_dividend_tvalid  (softmax_next_st == STAGE4 && softmax_st == STAGE4),
  .m_axis_dout_tvalid      (tvalid )
);
reg [2:0] softmax_counter;
always @(posedge clk) begin
    if(!rst_n)begin
        for(i=0;i<TOPK_NUM;i=i+1)begin
            softmax_topk_val[i]<=0;
        end
        softmax_counter <=0;
    end
    else if (tvalid)begin
        softmax_counter <= softmax_counter +1;
        softmax_topk_val[softmax_counter] <= softmax;
    end
    else begin
        for(i=0;i<TOPK_NUM;i=i+1)begin
            softmax_topk_val[i]<= softmax_topk_val[i];
        end
        softmax_counter <= softmax_counter;
    end
end
reg [1:0] output_counter;
wire [INPUT_NUM*DATA_WIDTH-1:0] softmax_idx,softmax_val;
//output result
always @(posedge clk) begin
    if(!rst_n)begin
        softmax_write_addr <= bram_write_base_addr;
        output_counter <=0;
        softmax_finish <= 0;
        softmax_out <= 0;
    end
    else if(softmax_counter == TOPK_NUM)begin
        case(output_counter)
            2'd0: begin
                softmax_write_addr <= bram_write_base_addr;
                output_counter <= output_counter + 1;
                softmax_out <= softmax_idx;
                end
            2'd1: begin
                softmax_write_addr <= bram_write_base_addr + 1;
                output_counter <= output_counter + 1;
                softmax_out <= softmax_val;
                end
            2'd2: begin
                softmax_finish <= 1'b1;
            end
            default: softmax_write_addr <= bram_write_base_addr;
        endcase
    end
    else begin
        softmax_write_addr <= bram_write_base_addr;
        output_counter <= 0;
        softmax_finish <= 0;
        softmax_out <= 0;
    end
end
assign softmax_write_valid = (softmax_counter == 3'd5 && softmax_finish == 0) ? 1'b1:1'b0;
assign softmax_idx = {topk_idx[4],2'b0,topk_idx[3],2'b0,topk_idx[2],2'b0,topk_idx[1],2'b0,topk_idx[0]};
assign softmax_val = {softmax_topk_val[4],softmax_topk_val[3],softmax_topk_val[2],softmax_topk_val[1],softmax_topk_val[0]};
endmodule
