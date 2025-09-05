`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/08 11:27:39
// Design Name: 
// Module Name: BRAM_DMA
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


module BRAM_DMA
#(
    parameter DATA_WIDTH = 8,
    parameter DATA_BRAM_ADDR_WIDTH = 19,
    parameter KERNEL_WIDTH = 8,
    parameter KERNEL_BRAM_ADDR_WIDTH = 19,
    parameter HORIZENTAL_VERTICAL_COUNTER_WIDTH = 8,
    parameter CHANNEL_PARRALISM = 9,
    parameter CHANNEL_COUNTER_WIDTH = 11
)
(
    input clk,
    input rst,
    input [HORIZENTAL_VERTICAL_COUNTER_WIDTH-1:0] ifmap_size,
    input [CHANNEL_COUNTER_WIDTH-1:0] ifmap_channel,
    //------------------------------------------------//
    //BRAM Data read channel
    input [DATA_BRAM_ADDR_WIDTH-1:0] Ifmap_base_addr,
    input [HORIZENTAL_VERTICAL_COUNTER_WIDTH-1:0] Ifmap_hori_num,        //center pixel h       
    input [HORIZENTAL_VERTICAL_COUNTER_WIDTH-1:0] Ifmap_vert_num,        //center pixel v
    input [CHANNEL_COUNTER_WIDTH-1:0] Ifmap_channel_num,
    input bram_en,
    
    output reg [CHANNEL_PARRALISM*DATA_WIDTH-1 : 0 ] Ifmap0_input, Ifmap1_input, Ifmap2_input,
    output reg [CHANNEL_PARRALISM*DATA_WIDTH-1 : 0 ] Ifmap3_input, Ifmap4_input, Ifmap5_input,
    output reg [CHANNEL_PARRALISM*DATA_WIDTH-1 : 0 ] Ifmap6_input, Ifmap7_input, Ifmap8_input,
    //BRAM Data Write channel
    input [DATA_BRAM_ADDR_WIDTH-1:0] Ofmap_base_addr,
    input [HORIZENTAL_VERTICAL_COUNTER_WIDTH-1:0] Ofmap_hori_num, 
    input [HORIZENTAL_VERTICAL_COUNTER_WIDTH-1:0] Ofmap_vert_num,
    input [HORIZENTAL_VERTICAL_COUNTER_WIDTH-1:0] Ofmap_channel_num,
    input bram_wea,
    
    //data BRAM driver
    //--- read channel ---/
    output [DATA_BRAM_ADDR_WIDTH-1:0] bram0_read_addr, bram1_read_addr, bram2_read_addr,
    output [DATA_BRAM_ADDR_WIDTH-1:0] bram3_read_addr, bram4_read_addr, bram5_read_addr,
    output [DATA_BRAM_ADDR_WIDTH-1:0] bram6_read_addr, bram7_read_addr, bram8_read_addr,
    
    output bram_read_en,
    input [CHANNEL_PARRALISM*DATA_WIDTH-1 : 0 ] bram0_read_input, bram1_read_input, bram2_read_input,
    input [CHANNEL_PARRALISM*DATA_WIDTH-1 : 0 ] bram3_read_input, bram4_read_input, bram5_read_input,
    input [CHANNEL_PARRALISM*DATA_WIDTH-1 : 0 ] bram6_read_input, bram7_read_input, bram8_read_input,
    //--- write channel ---/    
    input [DATA_BRAM_ADDR_WIDTH-1:0] bram0_write_addr, bram1_write_addr, bram2_write_addr,
    input [DATA_BRAM_ADDR_WIDTH-1:0] bram3_write_addr, bram4_write_addr, bram5_write_addr,
    input [DATA_BRAM_ADDR_WIDTH-1:0] bram6_write_addr, bram7_write_addr, bram8_write_addr,
    
    output bram_write_en,
    output [CHANNEL_PARRALISM*DATA_WIDTH-1 : 0 ] bram0_write_value, bram1_write_value, bram2_write_value,
    output [CHANNEL_PARRALISM*DATA_WIDTH-1 : 0 ] bram3_write_value, bram4_write_value, bram5_write_value,
    output [CHANNEL_PARRALISM*DATA_WIDTH-1 : 0 ] bram6_write_value, bram7_write_value, bram8_write_value
    
    );
    
    
    /** Subaddress Declaration **/
    /////////////////////////////
    reg [DATA_BRAM_ADDR_WIDTH-1:0] bram_base_vert_block_addr_0, bram_base_vert_block_addr_1, bram_base_vert_block_addr_2;
    reg [DATA_BRAM_ADDR_WIDTH-1:0] bram_base_vert_block_addr_3, bram_base_vert_block_addr_4, bram_base_vert_block_addr_5;
    reg [DATA_BRAM_ADDR_WIDTH-1:0] bram_base_vert_block_addr_6, bram_base_vert_block_addr_7, bram_base_vert_block_addr_8;
    
    reg [DATA_BRAM_ADDR_WIDTH-1:0] bram_base_hori_block_addr_0, bram_base_hori_block_addr_1, bram_base_hori_block_addr_2;
    reg [DATA_BRAM_ADDR_WIDTH-1:0] bram_base_hori_block_addr_3, bram_base_hori_block_addr_4, bram_base_hori_block_addr_5;
    reg [DATA_BRAM_ADDR_WIDTH-1:0] bram_base_hori_block_addr_6, bram_base_hori_block_addr_7, bram_base_hori_block_addr_8;
    wire [DATA_BRAM_ADDR_WIDTH-1:0] bram_conv_channel_round_addr;
    reg [DATA_BRAM_ADDR_WIDTH-1:0] bram_point_addr;

    wire [HORIZENTAL_VERTICAL_COUNTER_WIDTH-1:0] h_block_idx;
    wire [HORIZENTAL_VERTICAL_COUNTER_WIDTH-1:0] v_block_idx;
    
    wire [1:0] local_hori_cnt;
    wire [1:0] local_vert_cnt;
    
    Divider Divider_h_by3(
	.divisor(Ifmap_hori_num),
	.quotient(h_block_idx),
	.remainders(local_hori_cnt)
);

    Divider Divider_v_by3(
	.divisor(Ifmap_vert_num),
	.quotient(v_block_idx),
	.remainders(local_vert_cnt)
);
    wire [7:0]ifmap_size_divide_by3;
    wire [1:0]ifmap_size_divide_by3_remainders;
    wire [7:0] row_block_num;
    Divider Divider_ifmap_size_by3(
	.divisor(ifmap_size),
	.quotient(ifmap_size_divide_by3),
	.remainders(ifmap_size_divide_by3_remainders)
);
    assign row_block_num = (ifmap_size_divide_by3_remainders==0)?ifmap_size_divide_by3:ifmap_size_divide_by3+1;
    
    
    wire [3:0] scenarios;
    assign scenarios = {local_hori_cnt, local_vert_cnt};
    
    always@(*) begin
        case(scenarios)
            4'b0000: begin
                Ifmap0_input <= bram8_read_input;
                Ifmap1_input <= bram6_read_input;
                Ifmap2_input <= bram7_read_input;
                Ifmap3_input <= bram2_read_input;
                Ifmap4_input <= bram0_read_input;
                Ifmap5_input <= bram1_read_input;
                Ifmap6_input <= bram5_read_input;
                Ifmap7_input <= bram3_read_input;
                Ifmap8_input <= bram4_read_input;
            end
            4'b0001: begin
                Ifmap0_input <= bram6_read_input;
                Ifmap1_input <= bram7_read_input;
                Ifmap2_input <= bram8_read_input;
                Ifmap3_input <= bram0_read_input;
                Ifmap4_input <= bram1_read_input;
                Ifmap5_input <= bram2_read_input;
                Ifmap6_input <= bram3_read_input;
                Ifmap7_input <= bram4_read_input;
                Ifmap8_input <= bram5_read_input;
            end
            4'b0010: begin
                Ifmap0_input <= bram7_read_input;
                Ifmap1_input <= bram8_read_input;
                Ifmap2_input <= bram6_read_input;
                Ifmap3_input <= bram1_read_input;
                Ifmap4_input <= bram2_read_input;
                Ifmap5_input <= bram0_read_input;
                Ifmap6_input <= bram4_read_input;
                Ifmap7_input <= bram5_read_input;
                Ifmap8_input <= bram3_read_input;
            end
            4'b0100: begin
                Ifmap0_input <= bram2_read_input;
                Ifmap1_input <= bram0_read_input;
                Ifmap2_input <= bram1_read_input;
                Ifmap3_input <= bram5_read_input;
                Ifmap4_input <= bram3_read_input;
                Ifmap5_input <= bram4_read_input;
                Ifmap6_input <= bram8_read_input;
                Ifmap7_input <= bram6_read_input;
                Ifmap8_input <= bram7_read_input;
            end
            4'b0101: begin
                Ifmap0_input <= bram0_read_input;
                Ifmap1_input <= bram1_read_input;
                Ifmap2_input <= bram2_read_input;
                Ifmap3_input <= bram3_read_input;
                Ifmap4_input <= bram4_read_input;
                Ifmap5_input <= bram5_read_input;
                Ifmap6_input <= bram6_read_input;
                Ifmap7_input <= bram7_read_input;
                Ifmap8_input <= bram8_read_input;
            end
            4'b0110: begin
                Ifmap0_input <= bram1_read_input;
                Ifmap1_input <= bram2_read_input;
                Ifmap2_input <= bram0_read_input;
                Ifmap3_input <= bram4_read_input;
                Ifmap4_input <= bram5_read_input;
                Ifmap5_input <= bram3_read_input;
                Ifmap6_input <= bram7_read_input;
                Ifmap7_input <= bram8_read_input;
                Ifmap8_input <= bram6_read_input;
            end
            4'b1000: begin
                Ifmap0_input <= bram5_read_input;
                Ifmap1_input <= bram3_read_input;
                Ifmap2_input <= bram4_read_input;
                Ifmap3_input <= bram8_read_input;
                Ifmap4_input <= bram6_read_input;
                Ifmap5_input <= bram7_read_input;
                Ifmap6_input <= bram2_read_input;
                Ifmap7_input <= bram0_read_input;
                Ifmap8_input <= bram1_read_input;
            end
            4'b1001: begin
                Ifmap0_input <= bram3_read_input;
                Ifmap1_input <= bram4_read_input;
                Ifmap2_input <= bram5_read_input;
                Ifmap3_input <= bram6_read_input;
                Ifmap4_input <= bram7_read_input;
                Ifmap5_input <= bram8_read_input;
                Ifmap6_input <= bram0_read_input;
                Ifmap7_input <= bram1_read_input;
                Ifmap8_input <= bram2_read_input;
            end
            4'b1010: begin
                Ifmap0_input <= bram4_read_input;
                Ifmap1_input <= bram5_read_input;
                Ifmap2_input <= bram3_read_input;
                Ifmap3_input <= bram7_read_input;
                Ifmap4_input <= bram8_read_input;
                Ifmap5_input <= bram6_read_input;
                Ifmap6_input <= bram1_read_input;
                Ifmap7_input <= bram2_read_input;
                Ifmap8_input <= bram0_read_input;
            end
            default: begin
                Ifmap0_input <= 0;
                Ifmap1_input <= 0;
                Ifmap2_input <= 0;
                Ifmap3_input <= 0;
                Ifmap4_input <= 0;
                Ifmap5_input <= 0;
                Ifmap6_input <= 0;
                Ifmap7_input <= 0;
                Ifmap8_input <= 0;
            end
        endcase
    end
    
    
 //------------------------------------------------------------//
 // bram_base_hori_block_addr subaddress generation   
    
    always@(posedge clk) begin
    if(!rst) begin
        bram_base_hori_block_addr_0 <= 0;
        bram_base_hori_block_addr_1 <= 0;
        bram_base_hori_block_addr_2 <= 0;
        bram_base_hori_block_addr_3 <= 0;
        bram_base_hori_block_addr_4 <= 0;
        bram_base_hori_block_addr_5 <= 0;
        bram_base_hori_block_addr_6 <= 0;
        bram_base_hori_block_addr_7 <= 0;
        bram_base_hori_block_addr_8 <= 0;
    
    end
    else begin
        case(scenarios)
            4'b0000: begin
                bram_base_hori_block_addr_0 <= (h_block_idx-1)*ifmap_channel;
                bram_base_hori_block_addr_1 <= h_block_idx    *ifmap_channel;
                bram_base_hori_block_addr_2 <= h_block_idx    *ifmap_channel;
                bram_base_hori_block_addr_3 <= (h_block_idx-1)*ifmap_channel;
                bram_base_hori_block_addr_4 <= h_block_idx    *ifmap_channel;
                bram_base_hori_block_addr_5 <= h_block_idx    *ifmap_channel;
                bram_base_hori_block_addr_6 <= (h_block_idx-1)*ifmap_channel;
                bram_base_hori_block_addr_7 <= h_block_idx    *ifmap_channel;
                bram_base_hori_block_addr_8 <= h_block_idx    *ifmap_channel;
            end
            4'b0001: begin
                bram_base_hori_block_addr_0 <= h_block_idx*ifmap_channel; 
                bram_base_hori_block_addr_1 <= h_block_idx*ifmap_channel;     
                bram_base_hori_block_addr_2 <= h_block_idx*ifmap_channel;     
                bram_base_hori_block_addr_3 <= h_block_idx*ifmap_channel; 
                bram_base_hori_block_addr_4 <= h_block_idx*ifmap_channel;     
                bram_base_hori_block_addr_5 <= h_block_idx*ifmap_channel;     
                bram_base_hori_block_addr_6 <= h_block_idx*ifmap_channel; 
                bram_base_hori_block_addr_7 <= h_block_idx*ifmap_channel;     
                bram_base_hori_block_addr_8 <= h_block_idx*ifmap_channel;     
            end
            4'b0010: begin
                bram_base_hori_block_addr_0 <= h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_1 <= h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_2 <= (h_block_idx+1)*ifmap_channel; 
                bram_base_hori_block_addr_3 <= h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_4 <= h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_5 <= (h_block_idx+1)*ifmap_channel; 
                bram_base_hori_block_addr_6 <= h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_7 <= h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_8 <= (h_block_idx+1)*ifmap_channel; 
            end
            4'b0100: begin
                bram_base_hori_block_addr_0 <= (h_block_idx-1)*ifmap_channel; 
                bram_base_hori_block_addr_1 <= h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_2 <= h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_3 <= (h_block_idx-1)*ifmap_channel; 
                bram_base_hori_block_addr_4 <= h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_5 <= h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_6 <= (h_block_idx-1)*ifmap_channel; 
                bram_base_hori_block_addr_7 <= h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_8 <= h_block_idx    *ifmap_channel; 
            end
            4'b0101: begin
                bram_base_hori_block_addr_0 <= h_block_idx*ifmap_channel; 
                bram_base_hori_block_addr_1 <= h_block_idx*ifmap_channel; 
                bram_base_hori_block_addr_2 <= h_block_idx*ifmap_channel; 
                bram_base_hori_block_addr_3 <= h_block_idx*ifmap_channel; 
                bram_base_hori_block_addr_4 <= h_block_idx*ifmap_channel; 
                bram_base_hori_block_addr_5 <= h_block_idx*ifmap_channel; 
                bram_base_hori_block_addr_6 <= h_block_idx*ifmap_channel; 
                bram_base_hori_block_addr_7 <= h_block_idx*ifmap_channel; 
                bram_base_hori_block_addr_8 <= h_block_idx*ifmap_channel; 
            end
            4'b0110: begin
                bram_base_hori_block_addr_0 <= h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_1 <= h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_2 <= (h_block_idx+1)*ifmap_channel; 
                bram_base_hori_block_addr_3 <= h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_4 <= h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_5 <= (h_block_idx+1)*ifmap_channel; 
                bram_base_hori_block_addr_6 <= h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_7 <= h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_8 <= (h_block_idx+1)*ifmap_channel; 
            end
            4'b1000: begin
                bram_base_hori_block_addr_0 <= (h_block_idx-1)*ifmap_channel; 
                bram_base_hori_block_addr_1 <= h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_2 <= h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_3 <= (h_block_idx-1)*ifmap_channel; 
                bram_base_hori_block_addr_4 <= h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_5 <= h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_6 <= (h_block_idx-1)*ifmap_channel; 
                bram_base_hori_block_addr_7 <= h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_8 <= h_block_idx    *ifmap_channel; 
            end
            4'b1001: begin
                bram_base_hori_block_addr_0 <= h_block_idx*ifmap_channel; 
                bram_base_hori_block_addr_1 <= h_block_idx*ifmap_channel; 
                bram_base_hori_block_addr_2 <= h_block_idx*ifmap_channel; 
                bram_base_hori_block_addr_3 <= h_block_idx*ifmap_channel; 
                bram_base_hori_block_addr_4 <= h_block_idx*ifmap_channel; 
                bram_base_hori_block_addr_5 <= h_block_idx*ifmap_channel; 
                bram_base_hori_block_addr_6 <= h_block_idx*ifmap_channel; 
                bram_base_hori_block_addr_7 <= h_block_idx*ifmap_channel; 
                bram_base_hori_block_addr_8 <= h_block_idx*ifmap_channel; 
            end
            4'b1010: begin
                bram_base_hori_block_addr_0 <= h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_1 <= h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_2 <= (h_block_idx+1)*ifmap_channel; 
                bram_base_hori_block_addr_3 <= h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_4 <= h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_5 <= (h_block_idx+1)*ifmap_channel; 
                bram_base_hori_block_addr_6 <= h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_7 <= h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_8 <= (h_block_idx+1)*ifmap_channel; 
            end
            default: begin
                bram_base_hori_block_addr_0 <= 0;
                bram_base_hori_block_addr_1 <= 0;
                bram_base_hori_block_addr_2 <= 0;
                bram_base_hori_block_addr_3 <= 0;
                bram_base_hori_block_addr_4 <= 0;
                bram_base_hori_block_addr_5 <= 0;
                bram_base_hori_block_addr_6 <= 0;
                bram_base_hori_block_addr_7 <= 0;
                bram_base_hori_block_addr_8 <= 0;
            end
        endcase
    end
end

//------------------------------------------------------------//
 // bram_base_vert_block_addr subaddress generation   
    
    always@(posedge clk) begin
    if(!rst) begin
        bram_base_vert_block_addr_0 <= 0;
        bram_base_vert_block_addr_1 <= 0;
        bram_base_vert_block_addr_2 <= 0;
        bram_base_vert_block_addr_3 <= 0;
        bram_base_vert_block_addr_4 <= 0;
        bram_base_vert_block_addr_5 <= 0;
        bram_base_vert_block_addr_6 <= 0;
        bram_base_vert_block_addr_7 <= 0;
        bram_base_vert_block_addr_8 <= 0;
    
    end
    else begin
        case(scenarios)
            4'b0000: begin
                bram_base_vert_block_addr_0 <= (v_block_idx-1)* row_block_num*ifmap_channel;
                bram_base_vert_block_addr_1 <= (v_block_idx-1)* row_block_num*ifmap_channel;
                bram_base_vert_block_addr_2 <= (v_block_idx-1)* row_block_num*ifmap_channel;
                bram_base_vert_block_addr_3 <= v_block_idx    * row_block_num*ifmap_channel;
                bram_base_vert_block_addr_4 <= v_block_idx    * row_block_num*ifmap_channel;
                bram_base_vert_block_addr_5 <= v_block_idx    * row_block_num*ifmap_channel;
                bram_base_vert_block_addr_6 <= v_block_idx    * row_block_num*ifmap_channel;
                bram_base_vert_block_addr_7 <= v_block_idx    * row_block_num*ifmap_channel;
                bram_base_vert_block_addr_8 <= v_block_idx    * row_block_num*ifmap_channel;
            end
            4'b0001: begin
                 bram_base_vert_block_addr_0 <= (v_block_idx-1)* row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_1 <= (v_block_idx-1)* row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_2 <= (v_block_idx-1)* row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_3 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_4 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_5 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_6 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_7 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_8 <= v_block_idx    * row_block_num*ifmap_channel;
            end
            4'b0010: begin
                 bram_base_vert_block_addr_0 <= (v_block_idx-1)* row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_1 <= (v_block_idx-1)* row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_2 <= (v_block_idx-1)* row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_3 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_4 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_5 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_6 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_7 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_8 <= v_block_idx    * row_block_num*ifmap_channel;
            end
            4'b0100: begin
                 bram_base_vert_block_addr_0 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_1 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_2 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_3 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_4 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_5 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_6 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_7 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_8 <= v_block_idx    * row_block_num*ifmap_channel;
            end
            4'b0101: begin
                 bram_base_vert_block_addr_0 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_1 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_2 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_3 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_4 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_5 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_6 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_7 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_8 <= v_block_idx    * row_block_num*ifmap_channel;
            end
            4'b0110: begin
                 bram_base_vert_block_addr_0 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_1 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_2 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_3 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_4 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_5 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_6 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_7 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_8 <= v_block_idx    * row_block_num*ifmap_channel;
            end
            4'b1000: begin
                 bram_base_vert_block_addr_0 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_1 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_2 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_3 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_4 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_5 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_6 <= (v_block_idx+1)* row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_7 <= (v_block_idx+1)* row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_8 <= (v_block_idx+1)* row_block_num*ifmap_channel;
            end
            4'b1001: begin
                 bram_base_vert_block_addr_0 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_1 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_2 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_3 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_4 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_5 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_6 <= (v_block_idx+1)* row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_7 <= (v_block_idx+1)* row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_8 <= (v_block_idx+1)* row_block_num*ifmap_channel;
            end
            4'b1010: begin
                 bram_base_vert_block_addr_0 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_1 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_2 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_3 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_4 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_5 <= v_block_idx    * row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_6 <= (v_block_idx+1)* row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_7 <= (v_block_idx+1)* row_block_num*ifmap_channel;
                 bram_base_vert_block_addr_8 <= (v_block_idx+1)* row_block_num*ifmap_channel;
            end
            default: begin
                bram_base_vert_block_addr_0 <= 0;
                bram_base_vert_block_addr_1 <= 0;
                bram_base_vert_block_addr_2 <= 0;
                bram_base_vert_block_addr_3 <= 0;
                bram_base_vert_block_addr_4 <= 0;
                bram_base_vert_block_addr_5 <= 0;
                bram_base_vert_block_addr_6 <= 0;
                bram_base_vert_block_addr_7 <= 0;
                bram_base_vert_block_addr_8 <= 0;
            end
        endcase
    end
end
    
assign bram0_read_addr = Ifmap_base_addr + bram_base_hori_block_addr_0 + bram_base_vert_block_addr_0 + Ifmap_channel_num;
assign bram1_read_addr = Ifmap_base_addr + bram_base_hori_block_addr_1 + bram_base_vert_block_addr_1 + Ifmap_channel_num;
assign bram2_read_addr = Ifmap_base_addr + bram_base_hori_block_addr_2 + bram_base_vert_block_addr_2 + Ifmap_channel_num;
assign bram3_read_addr = Ifmap_base_addr + bram_base_hori_block_addr_3 + bram_base_vert_block_addr_3 + Ifmap_channel_num;
assign bram4_read_addr = Ifmap_base_addr + bram_base_hori_block_addr_4 + bram_base_vert_block_addr_4 + Ifmap_channel_num;
assign bram5_read_addr = Ifmap_base_addr + bram_base_hori_block_addr_5 + bram_base_vert_block_addr_5 + Ifmap_channel_num;
assign bram6_read_addr = Ifmap_base_addr + bram_base_hori_block_addr_6 + bram_base_vert_block_addr_6 + Ifmap_channel_num;
assign bram7_read_addr = Ifmap_base_addr + bram_base_hori_block_addr_7 + bram_base_vert_block_addr_7 + Ifmap_channel_num;
assign bram8_read_addr = Ifmap_base_addr + bram_base_hori_block_addr_8 + bram_base_vert_block_addr_8 + Ifmap_channel_num;

endmodule
