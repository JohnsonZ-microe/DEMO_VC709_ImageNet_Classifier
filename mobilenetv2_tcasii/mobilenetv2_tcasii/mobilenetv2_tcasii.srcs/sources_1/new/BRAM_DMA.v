`timescale 1ns / 100ps
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
    parameter DATA_BRAM_ADDR_WIDTH = 15,
    parameter KERNEL_WIDTH = 8,
    parameter KERNEL_BRAM_ADDR_WIDTH = 16,
    parameter HORIZENTAL_VERTICAL_COUNTER_WIDTH = 8,
    parameter CHANNEL_PARRALISM = 9,
    parameter IFMAP_CHANNEL_WIDTH  = 10,
    parameter OFMAP_CHANNEL_WIDTH  = 11
)
(
    input clk,
    input rst,
    input[2:0] mode,
    input [HORIZENTAL_VERTICAL_COUNTER_WIDTH-1:0] ifmap_size,
    input [HORIZENTAL_VERTICAL_COUNTER_WIDTH-1:0] ofmap_size,
    input [IFMAP_CHANNEL_WIDTH-1:0] ifmap_channel,
    input [1:0] bram_st,
    //------------------------------------------------//
    //BRAM Data read channel
    input [DATA_BRAM_ADDR_WIDTH-1:0] Ifmap_base_addr,
    input [HORIZENTAL_VERTICAL_COUNTER_WIDTH-1:0] Ifmap_hori_num,        //center pixel h       
    input [HORIZENTAL_VERTICAL_COUNTER_WIDTH-1:0] Ifmap_vert_num,        //center pixel v
    input [IFMAP_CHANNEL_WIDTH-1:0] Ifmap_channel_num,
    
    output reg [CHANNEL_PARRALISM*DATA_WIDTH-1 : 0 ] Ifmap0_input, Ifmap1_input, Ifmap2_input,
    output reg [CHANNEL_PARRALISM*DATA_WIDTH-1 : 0 ] Ifmap3_input, Ifmap4_input, Ifmap5_input,
    output reg [CHANNEL_PARRALISM*DATA_WIDTH-1 : 0 ] Ifmap6_input, Ifmap7_input, Ifmap8_input,
    //BRAM Data Write channel
    input [DATA_BRAM_ADDR_WIDTH-1:0] Ofmap_base_addr,
    input [HORIZENTAL_VERTICAL_COUNTER_WIDTH-1:0] Ofmap_hori_num, 
    input [HORIZENTAL_VERTICAL_COUNTER_WIDTH-1:0] Ofmap_vert_num,
    input [OFMAP_CHANNEL_WIDTH-1:0] Ofmap_channel_num,
    input [OFMAP_CHANNEL_WIDTH-1:0] ofmap_channel,
    
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
    output [DATA_BRAM_ADDR_WIDTH-1:0] bram0_write_addr, bram1_write_addr, bram2_write_addr,
    output [DATA_BRAM_ADDR_WIDTH-1:0] bram3_write_addr, bram4_write_addr, bram5_write_addr,
    output [DATA_BRAM_ADDR_WIDTH-1:0] bram6_write_addr, bram7_write_addr, bram8_write_addr,
    
    input ofmap_valid,
    output reg [8:0]bram_write_wea,
    //-----------Shortcut test-----------------//
    input [DATA_BRAM_ADDR_WIDTH-1:0] SC_base_addr,
    input shortcut_addr_sel,
    output [HORIZENTAL_VERTICAL_COUNTER_WIDTH-1:0] read_h_block_idx,
    output [HORIZENTAL_VERTICAL_COUNTER_WIDTH-1:0] read_v_block_idx,
    output [HORIZENTAL_VERTICAL_COUNTER_WIDTH-1:0] write_h_block_idx,
    output [HORIZENTAL_VERTICAL_COUNTER_WIDTH-1:0] write_v_block_idx,
    output reg [7:0] row_block_num
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


    

    
    wire [1:0] read_local_hori_cnt;
    wire [1:0] read_local_vert_cnt;


    
    Divider Divider_read_h_by3(
    .clk(clk),
    .rst_n(rst),
	.dividend(Ifmap_hori_num),
	.quotient(read_h_block_idx),
	.remainders(read_local_hori_cnt)
);

    Divider Divider_read_v_by3(
    .clk(clk),
    .rst_n(rst),
	.dividend(Ifmap_vert_num),
	.quotient(read_v_block_idx),
	.remainders(read_local_vert_cnt)
);
    wire [7:0]ifmap_size_divide_by3;
    wire [1:0]ifmap_size_divide_by3_remainders;
    Divider Divider_ifmap_size_by3(
    .clk(clk),
    .rst_n(rst),
	.dividend(ifmap_size),
	.quotient(ifmap_size_divide_by3),
	.remainders(ifmap_size_divide_by3_remainders)
);
    
    // assign row_block_num = (ifmap_size_divide_by3_remainders==0)?ifmap_size_divide_by3:ifmap_size_divide_by3+1;
    always @(posedge clk) begin
        if(!rst) row_block_num <= 8'd0;
        else row_block_num <= (ifmap_size_divide_by3_remainders==0)?ifmap_size_divide_by3:ifmap_size_divide_by3+1;
    end

    wire [7:0]ofmap_size_divide_by3;
    wire [1:0]ofmap_size_divide_by3_remainders;
    wire [7:0] ofmap_row_block_num;
    Divider Divider_ofmap_size_by3(
    .clk(clk),
    .rst_n(rst),
	.dividend(ofmap_size),
	.quotient(ofmap_size_divide_by3),
	.remainders(ofmap_size_divide_by3_remainders)
);
    assign ofmap_row_block_num = (ofmap_size_divide_by3_remainders==0)?ofmap_size_divide_by3:ofmap_size_divide_by3+1;
    
    wire [3:0] read_scenarios;
    assign read_scenarios = {read_local_vert_cnt, read_local_hori_cnt};
    reg [3:0] read_scenarios_delay_1, read_scenarios_delay_2, read_scenarios_delay_3, read_scenarios_delay_4, read_scenarios_delay_5,read_scenarios_delay_6, read_scenarios_delay_7, read_scenarios_delay_8;
    reg [3:0] read_scenarios_mux;
    
    always@(posedge clk) begin
        if(!rst) begin
            read_scenarios_delay_1 <= 4'd0;
            read_scenarios_delay_2 <= 4'd0;
            read_scenarios_delay_3 <= 4'd0;
            read_scenarios_delay_4 <= 4'd0;
            read_scenarios_delay_5 <= 4'd0;
            read_scenarios_delay_6 <= 4'd0;
            read_scenarios_delay_7 <= 4'd0;
            read_scenarios_delay_8 <= 4'd0;
        end
        else begin
            read_scenarios_delay_1 <= read_scenarios;
            read_scenarios_delay_2 <= read_scenarios_delay_1;
            read_scenarios_delay_3 <= read_scenarios_delay_2;
            read_scenarios_delay_4 <= read_scenarios_delay_3;
            read_scenarios_delay_5 <= read_scenarios_delay_4;
            read_scenarios_delay_6 <= read_scenarios_delay_5;
            read_scenarios_delay_7 <= read_scenarios_delay_6;
            read_scenarios_delay_8 <= read_scenarios_delay_7;
        end
    end
    always @(*) begin
        case(mode)
            3'd1: read_scenarios_mux = read_scenarios_delay_5;
            3'd2: read_scenarios_mux = read_scenarios_delay_5;
            3'd4: read_scenarios_mux = 3'd5;
            default :read_scenarios_mux = read_scenarios_delay_5;          
        endcase
    end
    always@(posedge clk) begin
    if(!rst) begin
        Ifmap0_input <= 72'd0;
        Ifmap1_input <= 72'd0;
        Ifmap2_input <= 72'd0;
        Ifmap3_input <= 72'd0;
        Ifmap4_input <= 72'd0;
        Ifmap5_input <= 72'd0;
        Ifmap6_input <= 72'd0;
        Ifmap7_input <= 72'd0;
        Ifmap8_input <= 72'd0;
    end
    else
        case(read_scenarios_mux)
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
                Ifmap0_input <= 72'd0;
                Ifmap1_input <= 72'd0;
                Ifmap2_input <= 72'd0;
                Ifmap3_input <= 72'd0;
                Ifmap4_input <= 72'd0;
                Ifmap5_input <= 72'd0;
                Ifmap6_input <= 72'd0;
                Ifmap7_input <= 72'd0;
                Ifmap8_input <= 72'd0;
            end
        endcase
    end
    
    
 //------------------------------------------------------------//
 // bram_base_hori_block_addr subaddress generation   
    
always@(posedge clk) begin
    if(!rst) begin
        bram_base_hori_block_addr_0 <= 18'd0;
        bram_base_hori_block_addr_1 <= 18'd0;
        bram_base_hori_block_addr_2 <= 18'd0;
        bram_base_hori_block_addr_3 <= 18'd0;
        bram_base_hori_block_addr_4 <= 18'd0;
        bram_base_hori_block_addr_5 <= 18'd0;
        bram_base_hori_block_addr_6 <= 18'd0;
        bram_base_hori_block_addr_7 <= 18'd0;
        bram_base_hori_block_addr_8 <= 18'd0;
    end
    else begin
        case(read_scenarios)
            4'b0000: begin
                bram_base_hori_block_addr_0 <= read_h_block_idx    *ifmap_channel;
                bram_base_hori_block_addr_1 <= read_h_block_idx    *ifmap_channel;
                bram_base_hori_block_addr_2 <= (read_h_block_idx-1)*ifmap_channel;
                bram_base_hori_block_addr_3 <= read_h_block_idx    *ifmap_channel;
                bram_base_hori_block_addr_4 <= read_h_block_idx    *ifmap_channel;
                bram_base_hori_block_addr_5 <= (read_h_block_idx-1)*ifmap_channel;
                bram_base_hori_block_addr_6 <= read_h_block_idx    *ifmap_channel;
                bram_base_hori_block_addr_7 <= read_h_block_idx    *ifmap_channel;
                bram_base_hori_block_addr_8 <= (read_h_block_idx-1)*ifmap_channel;
            end
            4'b0001: begin
                bram_base_hori_block_addr_0 <= read_h_block_idx*ifmap_channel; 
                bram_base_hori_block_addr_1 <= read_h_block_idx*ifmap_channel;     
                bram_base_hori_block_addr_2 <= read_h_block_idx*ifmap_channel;     
                bram_base_hori_block_addr_3 <= read_h_block_idx*ifmap_channel; 
                bram_base_hori_block_addr_4 <= read_h_block_idx*ifmap_channel;     
                bram_base_hori_block_addr_5 <= read_h_block_idx*ifmap_channel;     
                bram_base_hori_block_addr_6 <= read_h_block_idx*ifmap_channel; 
                bram_base_hori_block_addr_7 <= read_h_block_idx*ifmap_channel;     
                bram_base_hori_block_addr_8 <= read_h_block_idx*ifmap_channel;     
            end
            4'b0010: begin
                bram_base_hori_block_addr_0 <= (read_h_block_idx+1)*ifmap_channel; 
                bram_base_hori_block_addr_1 <= read_h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_2 <= read_h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_3 <= (read_h_block_idx+1)*ifmap_channel;
                bram_base_hori_block_addr_4 <= read_h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_5 <= read_h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_6 <= (read_h_block_idx+1)*ifmap_channel; 
                bram_base_hori_block_addr_7 <= read_h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_8 <= read_h_block_idx    *ifmap_channel; 
            end
            4'b0100: begin
                bram_base_hori_block_addr_0 <= read_h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_1 <= read_h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_2 <= (read_h_block_idx-1)*ifmap_channel; 
                bram_base_hori_block_addr_3 <= read_h_block_idx    *ifmap_channel;
                bram_base_hori_block_addr_4 <= read_h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_5 <= (read_h_block_idx-1)*ifmap_channel;  
                bram_base_hori_block_addr_6 <= read_h_block_idx    *ifmap_channel;
                bram_base_hori_block_addr_7 <= read_h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_8 <= (read_h_block_idx-1)*ifmap_channel;  
            end
            4'b0101: begin
                bram_base_hori_block_addr_0 <= read_h_block_idx*ifmap_channel; 
                bram_base_hori_block_addr_1 <= read_h_block_idx*ifmap_channel; 
                bram_base_hori_block_addr_2 <= read_h_block_idx*ifmap_channel; 
                bram_base_hori_block_addr_3 <= read_h_block_idx*ifmap_channel; 
                bram_base_hori_block_addr_4 <= read_h_block_idx*ifmap_channel; 
                bram_base_hori_block_addr_5 <= read_h_block_idx*ifmap_channel; 
                bram_base_hori_block_addr_6 <= read_h_block_idx*ifmap_channel; 
                bram_base_hori_block_addr_7 <= read_h_block_idx*ifmap_channel; 
                bram_base_hori_block_addr_8 <= read_h_block_idx*ifmap_channel; 
            end
            4'b0110: begin
                bram_base_hori_block_addr_0 <= (read_h_block_idx+1)*ifmap_channel; 
                bram_base_hori_block_addr_1 <= read_h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_2 <= read_h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_3 <= (read_h_block_idx+1)*ifmap_channel;
                bram_base_hori_block_addr_4 <= read_h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_5 <= read_h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_6 <= (read_h_block_idx+1)*ifmap_channel;  
                bram_base_hori_block_addr_7 <= read_h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_8 <= read_h_block_idx    *ifmap_channel;
            end
            4'b1000: begin
                bram_base_hori_block_addr_0 <= read_h_block_idx    *ifmap_channel;
                bram_base_hori_block_addr_1 <= read_h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_2 <= (read_h_block_idx-1)*ifmap_channel; 
                bram_base_hori_block_addr_3 <= read_h_block_idx    *ifmap_channel;
                bram_base_hori_block_addr_4 <= read_h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_5 <= (read_h_block_idx-1)*ifmap_channel;  
                bram_base_hori_block_addr_6 <= read_h_block_idx    *ifmap_channel;
                bram_base_hori_block_addr_7 <= read_h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_8 <= (read_h_block_idx-1)*ifmap_channel; 
            end
            4'b1001: begin
                bram_base_hori_block_addr_0 <= read_h_block_idx*ifmap_channel; 
                bram_base_hori_block_addr_1 <= read_h_block_idx*ifmap_channel; 
                bram_base_hori_block_addr_2 <= read_h_block_idx*ifmap_channel; 
                bram_base_hori_block_addr_3 <= read_h_block_idx*ifmap_channel; 
                bram_base_hori_block_addr_4 <= read_h_block_idx*ifmap_channel; 
                bram_base_hori_block_addr_5 <= read_h_block_idx*ifmap_channel; 
                bram_base_hori_block_addr_6 <= read_h_block_idx*ifmap_channel; 
                bram_base_hori_block_addr_7 <= read_h_block_idx*ifmap_channel; 
                bram_base_hori_block_addr_8 <= read_h_block_idx*ifmap_channel; 
            end
            4'b1010: begin
                bram_base_hori_block_addr_0 <= (read_h_block_idx+1)*ifmap_channel; 
                bram_base_hori_block_addr_1 <= read_h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_2 <= read_h_block_idx    *ifmap_channel;
                bram_base_hori_block_addr_3 <= (read_h_block_idx+1)*ifmap_channel; 
                bram_base_hori_block_addr_4 <= read_h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_5 <= read_h_block_idx    *ifmap_channel;
                bram_base_hori_block_addr_6 <= (read_h_block_idx+1)*ifmap_channel;  
                bram_base_hori_block_addr_7 <= read_h_block_idx    *ifmap_channel; 
                bram_base_hori_block_addr_8 <= read_h_block_idx    *ifmap_channel;
            end
            default: begin
                bram_base_hori_block_addr_0 <= 18'd0;
                bram_base_hori_block_addr_1 <= 18'd0;
                bram_base_hori_block_addr_2 <= 18'd0;
                bram_base_hori_block_addr_3 <= 18'd0;
                bram_base_hori_block_addr_4 <= 18'd0;
                bram_base_hori_block_addr_5 <= 18'd0;
                bram_base_hori_block_addr_6 <= 18'd0;
                bram_base_hori_block_addr_7 <= 18'd0;
                bram_base_hori_block_addr_8 <= 18'd0;
            end
        endcase
    end
end

reg [15:0] row_mul_ifmap_channel;
always @(posedge clk) begin
    if(!rst) begin
        row_mul_ifmap_channel <= 16'd0;
    end
    else begin
        row_mul_ifmap_channel <= row_block_num * ifmap_channel;
    end
end
//------------------------------------------------------------//
 // bram_base_vert_block_addr subaddress generation   
    
always@(posedge clk) begin
    if(!rst) begin
        bram_base_vert_block_addr_0 <= 18'd0;
        bram_base_vert_block_addr_1 <= 18'd0;
        bram_base_vert_block_addr_2 <= 18'd0;
        bram_base_vert_block_addr_3 <= 18'd0;
        bram_base_vert_block_addr_4 <= 18'd0;
        bram_base_vert_block_addr_5 <= 18'd0;
        bram_base_vert_block_addr_6 <= 18'd0;
        bram_base_vert_block_addr_7 <= 18'd0;
        bram_base_vert_block_addr_8 <= 18'd0;
    
    end
    else begin
        case(read_scenarios)
            4'b0000: begin
                bram_base_vert_block_addr_0 <= read_v_block_idx    * row_mul_ifmap_channel;
                bram_base_vert_block_addr_1 <= read_v_block_idx    * row_mul_ifmap_channel;
                bram_base_vert_block_addr_2 <= read_v_block_idx    * row_mul_ifmap_channel;
                bram_base_vert_block_addr_3 <= read_v_block_idx    * row_mul_ifmap_channel;
                bram_base_vert_block_addr_4 <= read_v_block_idx    * row_mul_ifmap_channel;
                bram_base_vert_block_addr_5 <= read_v_block_idx    * row_mul_ifmap_channel;
                bram_base_vert_block_addr_6 <= (read_v_block_idx-1)* row_mul_ifmap_channel;
                bram_base_vert_block_addr_7 <= (read_v_block_idx-1)* row_mul_ifmap_channel;
                bram_base_vert_block_addr_8 <= (read_v_block_idx-1)* row_mul_ifmap_channel;
            end
            4'b0001: begin
                bram_base_vert_block_addr_0 <= read_v_block_idx    * row_mul_ifmap_channel;
                bram_base_vert_block_addr_1 <= read_v_block_idx    * row_mul_ifmap_channel;
                bram_base_vert_block_addr_2 <= read_v_block_idx    * row_mul_ifmap_channel;
                bram_base_vert_block_addr_3 <= read_v_block_idx    * row_mul_ifmap_channel;
                bram_base_vert_block_addr_4 <= read_v_block_idx    * row_mul_ifmap_channel;
                bram_base_vert_block_addr_5 <= read_v_block_idx    * row_mul_ifmap_channel;
                bram_base_vert_block_addr_6 <= (read_v_block_idx-1)* row_mul_ifmap_channel;
                bram_base_vert_block_addr_7 <= (read_v_block_idx-1)* row_mul_ifmap_channel;
                bram_base_vert_block_addr_8 <= (read_v_block_idx-1)* row_mul_ifmap_channel;
            end
            4'b0010: begin
                bram_base_vert_block_addr_0 <= read_v_block_idx    * row_mul_ifmap_channel;
                bram_base_vert_block_addr_1 <= read_v_block_idx    * row_mul_ifmap_channel;
                bram_base_vert_block_addr_2 <= read_v_block_idx    * row_mul_ifmap_channel;
                bram_base_vert_block_addr_3 <= read_v_block_idx    * row_mul_ifmap_channel;
                bram_base_vert_block_addr_4 <= read_v_block_idx    * row_mul_ifmap_channel;
                bram_base_vert_block_addr_5 <= read_v_block_idx    * row_mul_ifmap_channel;
                bram_base_vert_block_addr_6 <= (read_v_block_idx-1)* row_mul_ifmap_channel;
                bram_base_vert_block_addr_7 <= (read_v_block_idx-1)* row_mul_ifmap_channel;
                bram_base_vert_block_addr_8 <= (read_v_block_idx-1)* row_mul_ifmap_channel;
            end
            4'b0100: begin
                 bram_base_vert_block_addr_0 <= read_v_block_idx    * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_1 <= read_v_block_idx    * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_2 <= read_v_block_idx    * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_3 <= read_v_block_idx    * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_4 <= read_v_block_idx    * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_5 <= read_v_block_idx    * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_6 <= read_v_block_idx    * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_7 <= read_v_block_idx    * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_8 <= read_v_block_idx    * row_mul_ifmap_channel;
            end
            4'b0101: begin
                 bram_base_vert_block_addr_0 <= read_v_block_idx    * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_1 <= read_v_block_idx    * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_2 <= read_v_block_idx    * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_3 <= read_v_block_idx    * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_4 <= read_v_block_idx    * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_5 <= read_v_block_idx    * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_6 <= read_v_block_idx    * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_7 <= read_v_block_idx    * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_8 <= read_v_block_idx    * row_mul_ifmap_channel;
            end
            4'b0110: begin
                 bram_base_vert_block_addr_0 <= read_v_block_idx    * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_1 <= read_v_block_idx    * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_2 <= read_v_block_idx    * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_3 <= read_v_block_idx    * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_4 <= read_v_block_idx    * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_5 <= read_v_block_idx    * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_6 <= read_v_block_idx    * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_7 <= read_v_block_idx    * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_8 <= read_v_block_idx    * row_mul_ifmap_channel;
            end
            4'b1000: begin
                 bram_base_vert_block_addr_0 <= (read_v_block_idx+1)   * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_1 <= (read_v_block_idx+1)   * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_2 <= (read_v_block_idx+1)   * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_3 <= read_v_block_idx    * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_4 <= read_v_block_idx    * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_5 <= read_v_block_idx    * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_6 <= read_v_block_idx    * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_7 <= read_v_block_idx    * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_8 <= read_v_block_idx    * row_mul_ifmap_channel;
            end
            4'b1001: begin
                 bram_base_vert_block_addr_0 <= (read_v_block_idx+1)  * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_1 <= (read_v_block_idx+1)  * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_2 <= (read_v_block_idx+1)  * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_3 <= read_v_block_idx    * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_4 <= read_v_block_idx    * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_5 <= read_v_block_idx    * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_6 <= read_v_block_idx    * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_7 <= read_v_block_idx    * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_8 <= read_v_block_idx    * row_mul_ifmap_channel;
            end
            4'b1010: begin
                 bram_base_vert_block_addr_0 <= (read_v_block_idx+1) * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_1 <= (read_v_block_idx+1) * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_2 <= (read_v_block_idx+1) * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_3 <= read_v_block_idx    * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_4 <= read_v_block_idx    * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_5 <= read_v_block_idx    * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_6 <= read_v_block_idx    * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_7 <= read_v_block_idx    * row_mul_ifmap_channel;
                 bram_base_vert_block_addr_8 <= read_v_block_idx    * row_mul_ifmap_channel;
            end
            default: begin
                bram_base_vert_block_addr_0 <= 18'd0;
                bram_base_vert_block_addr_1 <= 18'd0;
                bram_base_vert_block_addr_2 <= 18'd0;
                bram_base_vert_block_addr_3 <= 18'd0;
                bram_base_vert_block_addr_4 <= 18'd0;
                bram_base_vert_block_addr_5 <= 18'd0;
                bram_base_vert_block_addr_6 <= 18'd0;
                bram_base_vert_block_addr_7 <= 18'd0;
                bram_base_vert_block_addr_8 <= 18'd0;
            end
        endcase
    end
end
wire [DATA_BRAM_ADDR_WIDTH-1:0] Ifmap_base_addr_mux;
reg [DATA_BRAM_ADDR_WIDTH-1:0] Ifmap_base_addr_reg, SC_base_addr_reg;

always@(posedge clk) begin
    if(!rst) begin
        Ifmap_base_addr_reg <= 0;
        SC_base_addr_reg <= 0;
    end
    else begin
        Ifmap_base_addr_reg <= Ifmap_base_addr;
        SC_base_addr_reg <= SC_base_addr;
    end
end

reg [IFMAP_CHANNEL_WIDTH-1:0] Ifmap_channel_num_reg1, Ifmap_channel_num_reg2, Ifmap_channel_num_reg3;
always @(posedge clk) begin
    if(!rst) begin
        Ifmap_channel_num_reg1 <= 0;
        Ifmap_channel_num_reg2 <= 0;
        Ifmap_channel_num_reg3 <= 0;
    end
    else begin
        Ifmap_channel_num_reg1 <= Ifmap_channel_num;
        Ifmap_channel_num_reg2 <= Ifmap_channel_num_reg1;
        Ifmap_channel_num_reg3 <= Ifmap_channel_num_reg2;
    end
end
assign Ifmap_base_addr_mux = ((mode == 3'd4) && (shortcut_addr_sel== 1))? SC_base_addr_reg : Ifmap_base_addr_reg;

assign bram0_read_addr = (Ifmap_base_addr_mux + bram_base_hori_block_addr_0 ) + ( bram_base_vert_block_addr_0 + Ifmap_channel_num_reg3);
assign bram1_read_addr = (Ifmap_base_addr_mux + bram_base_hori_block_addr_1 ) + ( bram_base_vert_block_addr_1 + Ifmap_channel_num_reg3);
assign bram2_read_addr = (Ifmap_base_addr_mux + bram_base_hori_block_addr_2 ) + ( bram_base_vert_block_addr_2 + Ifmap_channel_num_reg3);
assign bram3_read_addr = (Ifmap_base_addr_mux + bram_base_hori_block_addr_3 ) + ( bram_base_vert_block_addr_3 + Ifmap_channel_num_reg3);
assign bram4_read_addr = (Ifmap_base_addr_mux + bram_base_hori_block_addr_4 ) + ( bram_base_vert_block_addr_4 + Ifmap_channel_num_reg3);
assign bram5_read_addr = (Ifmap_base_addr_mux + bram_base_hori_block_addr_5 ) + ( bram_base_vert_block_addr_5 + Ifmap_channel_num_reg3);
assign bram6_read_addr = (Ifmap_base_addr_mux + bram_base_hori_block_addr_6 ) + ( bram_base_vert_block_addr_6 + Ifmap_channel_num_reg3);
assign bram7_read_addr = (Ifmap_base_addr_mux + bram_base_hori_block_addr_7 ) + ( bram_base_vert_block_addr_7 + Ifmap_channel_num_reg3);
assign bram8_read_addr = (Ifmap_base_addr_mux + bram_base_hori_block_addr_8 ) + ( bram_base_vert_block_addr_8 + Ifmap_channel_num_reg3);

wire [1:0] write_local_hori_cnt;
wire [1:0] write_local_vert_cnt;
wire [3:0] write_scenarios;

    Divider Divider_write_h_by3(
    .clk(clk),
    .rst_n(rst),
	.dividend(Ofmap_hori_num),
	.quotient(write_h_block_idx),
	.remainders(write_local_hori_cnt)
);

    Divider Divider_write_v_by3(
    .clk(clk),
    .rst_n(rst),
	.dividend(Ofmap_vert_num),
	.quotient(write_v_block_idx),
	.remainders(write_local_vert_cnt)
);
reg [2:0] mode_reg [0:9];
reg [2:0] mode_save;//if mode != 0 ,save mode
always @(posedge clk) begin
    if(!rst) begin
        mode_save <= 3'd0;
    end
    else begin
        if(mode != 3'd0) begin
            mode_save <= mode;
        end
    end
end

assign write_scenarios = {write_local_vert_cnt, write_local_hori_cnt};
reg [3:0] write_scenarios_reg[0:2];
always @(posedge clk) begin
    if(!rst) begin
        write_scenarios_reg[0] <= 4'd0;
        write_scenarios_reg[1] <= 4'd0;
        write_scenarios_reg[2] <= 4'd0;
    end
    else begin
        write_scenarios_reg[0] <= write_scenarios;
        write_scenarios_reg[1] <= write_scenarios_reg[0];
        write_scenarios_reg[2] <= write_scenarios_reg[1];
    end
end
wire [3:0] write_scenarios_mux;
assign write_scenarios_mux = (mode_save == 3'd3) ? write_scenarios_reg[2] : write_scenarios;
reg [8:0] bram_write_enable; 
reg ofmap_valid_reg;
always @(posedge clk) begin
    if(!rst) begin
        ofmap_valid_reg <= 1'b0;
    end
    else begin
        ofmap_valid_reg <= ofmap_valid;
    end
end
reg ofmap_valid_mux;
always @( *) begin
    case(mode_reg[5])
        3'd1: ofmap_valid_mux = ofmap_valid;
        3'd2: ofmap_valid_mux = ofmap_valid;
        3'd3: ofmap_valid_mux = ofmap_valid;
        default: ofmap_valid_mux = ofmap_valid;
    endcase
end
reg [2:0] mode_mux;
always @( *) begin
    case(mode_save)
        3'd1: mode_mux = mode_save;
        3'd2: mode_mux = mode_reg[5];
        3'd3: mode_mux = mode_save;
        default: mode_mux = mode_save;
    endcase
end
always@(*) begin
    if(ofmap_valid_mux) begin
        if(mode == 3'd4)begin
            bram_write_enable <= 9'b111111111;
        end
        else if (mode == 3'd5)begin
            bram_write_enable <= 9'b000000001;
        end
        else if (mode == 3'd6)begin
            bram_write_enable <= 9'b000000001;
        end
        else begin
        case(write_scenarios_mux)
                4'b0000: begin
                    bram_write_enable <= 9'b000000001;
                end
                4'b0001: begin
                    bram_write_enable <= 9'b000000010;
                end
                4'b0010: begin
                    bram_write_enable <= 9'b000000100;
                end
                4'b0100: begin
                    bram_write_enable <= 9'b000001000;
                end
                4'b0101: begin
                    bram_write_enable <= 9'b000010000;
                end
                4'b0110: begin
                    bram_write_enable <= 9'b000100000;
                end
                4'b1000: begin
                    bram_write_enable <= 9'b001000000;
                end
                4'b1001: begin
                    bram_write_enable <= 9'b010000000;
                end
                4'b1010: begin
                    bram_write_enable <= 9'b100000000;
                end
                default: begin
                    bram_write_enable <= 9'b000000000;
                end
        endcase
    end
    end
    else begin
        bram_write_enable <= 9'b000000000;
    end
end
reg [8:0] bram_write_enable_reg1, bram_write_enable_reg2,bram_write_enable_reg3, bram_write_enable_reg4, bram_write_enable_reg5;
always @(posedge clk) begin
    if(!rst) begin
        bram_write_enable_reg1 <= 9'd0;
        bram_write_enable_reg2 <= 9'd0;
        bram_write_enable_reg3 <= 9'd0;
        bram_write_enable_reg4 <= 9'd0;
        bram_write_enable_reg5 <= 9'd0;
    end
    else begin
        bram_write_enable_reg1 <= bram_write_enable;
        bram_write_enable_reg2 <= bram_write_enable_reg1;
        bram_write_enable_reg3 <= bram_write_enable_reg2;
        bram_write_enable_reg4 <= bram_write_enable_reg3;
        bram_write_enable_reg5 <= bram_write_enable_reg4;
    end
end

integer i;
always @(posedge clk) begin
    if(!rst) begin
        for (i = 0; i < 10; i = i + 1) begin
            mode_reg[i] <= 3'd0;
        end
    end
    else begin
        mode_reg[0] <= mode;
        for (i = 1; i < 10; i = i + 1) begin
            mode_reg[i] <= mode_reg[i-1];
        end
    end
end
always @(*) begin
    case(mode_mux)
        3'd1:begin
            bram_write_wea = mode_reg[0]==3'd1 ?bram_write_enable_reg2 : 9'b000000000;
        end
        3'd2:begin
            bram_write_wea = ofmap_valid ? bram_write_enable_reg5 : 9'b000000000;
        end
        3'd3:begin
            bram_write_wea = ofmap_valid ? bram_write_enable : 9'b000000000;
        end
        3'd4: begin
            bram_write_wea = ofmap_valid ? 9'b111111111 : 9'b000000000;
        end
        3'd5: begin
            bram_write_wea = ofmap_valid ? 9'b000000001 : 9'b000000000;
        end
        3'd6:begin
            bram_write_wea = ofmap_valid ? 9'b000000001 : 9'b000000000;
        end
        default: bram_write_wea = 9'b000000000;
    endcase
end
    reg [DATA_BRAM_ADDR_WIDTH-1:0] bram_write_vert_block_addr_0, bram_write_vert_block_addr_1, bram_write_vert_block_addr_2;
    reg [DATA_BRAM_ADDR_WIDTH-1:0] bram_write_vert_block_addr_3, bram_write_vert_block_addr_4, bram_write_vert_block_addr_5;
    reg [DATA_BRAM_ADDR_WIDTH-1:0] bram_write_vert_block_addr_6, bram_write_vert_block_addr_7, bram_write_vert_block_addr_8;
                                        
    reg [DATA_BRAM_ADDR_WIDTH-1:0] bram_write_hori_block_addr_0, bram_write_hori_block_addr_1, bram_write_hori_block_addr_2;
    reg [DATA_BRAM_ADDR_WIDTH-1:0] bram_write_hori_block_addr_3, bram_write_hori_block_addr_4, bram_write_hori_block_addr_5;
    reg [DATA_BRAM_ADDR_WIDTH-1:0] bram_write_hori_block_addr_6, bram_write_hori_block_addr_7, bram_write_hori_block_addr_8;
    
        
 //------------------------------------------------------------//
 // bram_write_hori_block_addr subaddress generation 
reg [OFMAP_CHANNEL_WIDTH-1:0] ofmap_channel_reg[0:4]; 
integer x;
always @(posedge clk) begin
    if(!rst)begin
        for(x=0;x<5;x=x+1) begin
            ofmap_channel_reg[x] <= 0;
        end
    end
    else begin
        ofmap_channel_reg[0] <= ofmap_channel;
        for(x=1;x<5;x=x+1) begin
            ofmap_channel_reg[x] <= ofmap_channel_reg[x-1];
        end
    end
end

reg [OFMAP_CHANNEL_WIDTH-1:0] ofmap_channel_save;
always @(posedge clk) begin
    if(!rst) begin
        ofmap_channel_save <= 0;
    end
    else begin
        if(ofmap_channel != 0) begin
            ofmap_channel_save <= ofmap_channel;
        end
    end
end
reg [1:0] bram_st_reg[0:6];
integer j;
always @(posedge clk) begin
    if(!rst) begin
        for(j=0;j<7;j=j+1) begin
            bram_st_reg[j] <= 2'd0;
        end
    end
    else begin
        bram_st_reg[0] <= bram_st;
        for(j=1;j<7;j=j+1) begin
            bram_st_reg[j] <= bram_st_reg[j-1];
        end
    end
end
always@(posedge clk) begin
    if(!rst) begin
        bram_write_hori_block_addr_0 <= 18'd0;
        bram_write_hori_block_addr_1 <= 18'd0;
        bram_write_hori_block_addr_2 <= 18'd0;
        bram_write_hori_block_addr_3 <= 18'd0;
        bram_write_hori_block_addr_4 <= 18'd0;
        bram_write_hori_block_addr_5 <= 18'd0;
        bram_write_hori_block_addr_6 <= 18'd0;
        bram_write_hori_block_addr_7 <= 18'd0;
        bram_write_hori_block_addr_8 <= 18'd0;
    end
    // else if(bram_st_reg[6] == 0)begin
    //     bram_write_hori_block_addr_0 <= 18'd0;
    //     bram_write_hori_block_addr_1 <= 18'd0;
    //     bram_write_hori_block_addr_2 <= 18'd0;
    //     bram_write_hori_block_addr_3 <= 18'd0;
    //     bram_write_hori_block_addr_4 <= 18'd0;
    //     bram_write_hori_block_addr_5 <= 18'd0;
    //     bram_write_hori_block_addr_6 <= 18'd0;
    //     bram_write_hori_block_addr_7 <= 18'd0;
    //     bram_write_hori_block_addr_8 <= 18'd0;
    // end
    else begin
        case(write_scenarios)
            4'b0000: begin
                bram_write_hori_block_addr_0 <= write_h_block_idx*ofmap_channel_save;
            end
            4'b0001: begin
                bram_write_hori_block_addr_1 <= write_h_block_idx*ofmap_channel_save;     
            end
            4'b0010: begin
                bram_write_hori_block_addr_2 <= write_h_block_idx*ofmap_channel_save;
            end
            4'b0100: begin
                bram_write_hori_block_addr_3 <= write_h_block_idx*ofmap_channel_save; 
            end
            4'b0101: begin
                bram_write_hori_block_addr_4 <= write_h_block_idx*ofmap_channel_save;
            end
            4'b0110: begin
                bram_write_hori_block_addr_5 <= write_h_block_idx*ofmap_channel_save;
            end
            4'b1000: begin
                bram_write_hori_block_addr_6 <= write_h_block_idx*ofmap_channel_save;
            end
            4'b1001: begin
                bram_write_hori_block_addr_7 <= write_h_block_idx*ofmap_channel_save;
            end
            4'b1010: begin
                bram_write_hori_block_addr_8 <= write_h_block_idx*ofmap_channel_save;
            end
            default: begin
                bram_write_hori_block_addr_0 <= 18'd0;
                bram_write_hori_block_addr_1 <= 18'd0;
                bram_write_hori_block_addr_2 <= 18'd0;
                bram_write_hori_block_addr_3 <= 18'd0;
                bram_write_hori_block_addr_4 <= 18'd0;
                bram_write_hori_block_addr_5 <= 18'd0;
                bram_write_hori_block_addr_6 <= 18'd0;
                bram_write_hori_block_addr_7 <= 18'd0;
                bram_write_hori_block_addr_8 <= 18'd0;
            end
        endcase
    end
end

// reg [17:0] ofmap_row_mul_channel_reg[0:3];
// integer k;
// always @(posedge clk) begin
//     if(!rst) begin
//         for(k=0;k<4;k=k+1) begin
//             ofmap_row_mul_channel_reg[k] <= 18'd0;
//         end
//     end
//     else begin
//         ofmap_row_mul_channel_reg[0] <= ofmap_row_block_num * ofmap_channel_reg[0];
//         for(k=1;k<4;k=k+1) begin
//             ofmap_row_mul_channel_reg[k] <= ofmap_row_mul_channel_reg[k-1];
//         end
//     end
// end
reg [17:0] ofmap_row_mul_channel_reg;
reg [7:0] ofmap_row_block_num_reg[0:6];
integer m;
always @(posedge clk) begin
    if(!rst) begin
        for(m=0;m<7;m=m+1) begin
            ofmap_row_block_num_reg[m] <= 8'd0;
        end
    end
    else begin
        ofmap_row_block_num_reg[0] <= ofmap_row_block_num;
        for(m=1;m<7;m=m+1) begin
            ofmap_row_block_num_reg[m] <= ofmap_row_block_num_reg[m-1];
        end
    end
end
always @(posedge clk) begin
    if(!rst) begin
        ofmap_row_mul_channel_reg <= 18'd0;
    end
    else begin
        ofmap_row_mul_channel_reg <= ofmap_row_block_num_reg[6] * ofmap_channel_save;
    end
end
reg [17:0] ofmap_row_mul_channel;
always @(posedge clk) begin
    if(!rst) begin
        ofmap_row_mul_channel <= 18'd0;
    end
    else begin
        if(ofmap_row_mul_channel_reg != 0) begin
            ofmap_row_mul_channel <= ofmap_row_mul_channel_reg;
        end
    end
end
//------------------------------------------------------------//
 // bram_base_vert_block_addr subaddress generation   
    
always@(posedge clk) begin
    if(!rst) begin
        bram_write_vert_block_addr_0 <= 18'd0;
        bram_write_vert_block_addr_1 <= 18'd0;
        bram_write_vert_block_addr_2 <= 18'd0;
        bram_write_vert_block_addr_3 <= 18'd0;
        bram_write_vert_block_addr_4 <= 18'd0;
        bram_write_vert_block_addr_5 <= 18'd0;
        bram_write_vert_block_addr_6 <= 18'd0;
        bram_write_vert_block_addr_7 <= 18'd0;
        bram_write_vert_block_addr_8 <= 18'd0;
    end
    // else if(bram_st_reg[6] == 0)begin
    //     bram_write_vert_block_addr_0 <= 18'd0;
    //     bram_write_vert_block_addr_1 <= 18'd0;
    //     bram_write_vert_block_addr_2 <= 18'd0;
    //     bram_write_vert_block_addr_3 <= 18'd0;
    //     bram_write_vert_block_addr_4 <= 18'd0;
    //     bram_write_vert_block_addr_5 <= 18'd0;
    //     bram_write_vert_block_addr_6 <= 18'd0;
    //     bram_write_vert_block_addr_7 <= 18'd0;
    //     bram_write_vert_block_addr_8 <= 18'd0;
    // end
    else begin
        case(write_scenarios)
            4'b0000: begin
                bram_write_vert_block_addr_0 <= write_v_block_idx* ofmap_row_mul_channel;
            end
            4'b0001: begin
                bram_write_vert_block_addr_1 <= write_v_block_idx* ofmap_row_mul_channel;
            end
            4'b0010: begin
                bram_write_vert_block_addr_2 <= write_v_block_idx* ofmap_row_mul_channel;
            end
            4'b0100: begin
                bram_write_vert_block_addr_3 <= write_v_block_idx* ofmap_row_mul_channel;
            end
            4'b0101: begin
                bram_write_vert_block_addr_4 <= write_v_block_idx* ofmap_row_mul_channel;
            end
            4'b0110: begin
                bram_write_vert_block_addr_5 <= write_v_block_idx* ofmap_row_mul_channel;
            end
            4'b1000: begin
                bram_write_vert_block_addr_6 <= write_v_block_idx* ofmap_row_mul_channel;
            end
            4'b1001: begin
                bram_write_vert_block_addr_7 <= write_v_block_idx* ofmap_row_mul_channel;
            end
            4'b1010: begin
                bram_write_vert_block_addr_8 <= write_v_block_idx* ofmap_row_mul_channel;
            end
            default: begin
                bram_write_vert_block_addr_0 <= 18'd0;
                bram_write_vert_block_addr_1 <= 18'd0;
                bram_write_vert_block_addr_2 <= 18'd0;
                bram_write_vert_block_addr_3 <= 18'd0;
                bram_write_vert_block_addr_4 <= 18'd0;
                bram_write_vert_block_addr_5 <= 18'd0;
                bram_write_vert_block_addr_6 <= 18'd0;
                bram_write_vert_block_addr_7 <= 18'd0;
                bram_write_vert_block_addr_8 <= 18'd0;
            end
        endcase
    end
end
reg[DATA_BRAM_ADDR_WIDTH-1:0] Ofmap_base_addr_reg1, Ofmap_base_addr_reg2, Ofmap_base_addr_reg3;
always @(posedge clk) begin
    if(!rst) begin
        Ofmap_base_addr_reg1 <= 16'd0;
        Ofmap_base_addr_reg2 <= 16'd0;
        Ofmap_base_addr_reg3 <= 16'd0;
    end
    else begin
        Ofmap_base_addr_reg1 <= Ofmap_base_addr;
        Ofmap_base_addr_reg2 <= Ofmap_base_addr_reg1;
        Ofmap_base_addr_reg3 <= Ofmap_base_addr_reg2;
    end
end
reg[15:0] Ofmap_base_addr_plus_channel, Ofmap_base_addr_plus_channel_reg1, Ofmap_base_addr_plus_channel_reg2;
always @(posedge clk) begin
    if(!rst) begin
        Ofmap_base_addr_plus_channel <= 16'd0;
        Ofmap_base_addr_plus_channel_reg1 <= 16'd0;
        Ofmap_base_addr_plus_channel_reg2 <= 16'd0;
    end
    else begin
        Ofmap_base_addr_plus_channel <= Ofmap_base_addr_reg3 + Ofmap_channel_num;
        Ofmap_base_addr_plus_channel_reg1 <= Ofmap_base_addr_plus_channel;
        Ofmap_base_addr_plus_channel_reg2 <= Ofmap_base_addr_plus_channel_reg1;
    end
end
assign bram0_write_addr = (mode == 3'd4) ? bram4_write_addr : Ofmap_base_addr_plus_channel_reg2 + bram_write_hori_block_addr_0 + bram_write_vert_block_addr_0 ;
assign bram1_write_addr = (mode == 3'd4) ? bram4_write_addr :Ofmap_base_addr_plus_channel_reg2 + bram_write_hori_block_addr_1 + bram_write_vert_block_addr_1 ;
assign bram2_write_addr = (mode == 3'd4) ? bram4_write_addr :Ofmap_base_addr_plus_channel_reg2 + bram_write_hori_block_addr_2 + bram_write_vert_block_addr_2 ;
assign bram3_write_addr = (mode == 3'd4) ? bram4_write_addr :Ofmap_base_addr_plus_channel_reg2 + bram_write_hori_block_addr_3 + bram_write_vert_block_addr_3 ;
assign bram4_write_addr = Ofmap_base_addr_plus_channel_reg2 + bram_write_hori_block_addr_4 + bram_write_vert_block_addr_4 ;
assign bram5_write_addr = (mode == 3'd4) ? bram4_write_addr :Ofmap_base_addr_plus_channel_reg2 + bram_write_hori_block_addr_5 + bram_write_vert_block_addr_5 ;
assign bram6_write_addr = (mode == 3'd4) ? bram4_write_addr :Ofmap_base_addr_plus_channel_reg2 + bram_write_hori_block_addr_6 + bram_write_vert_block_addr_6 ;
assign bram7_write_addr = (mode == 3'd4) ? bram4_write_addr :Ofmap_base_addr_plus_channel_reg2 + bram_write_hori_block_addr_7 + bram_write_vert_block_addr_7 ;
assign bram8_write_addr = (mode == 3'd4) ? bram4_write_addr :Ofmap_base_addr_plus_channel_reg2 + bram_write_hori_block_addr_8 + bram_write_vert_block_addr_8 ;

reg bram_read_en_nosync;
always @(posedge clk) begin
    if(!rst) begin
        bram_read_en_nosync <= 1'b0;
    end
    else begin
        bram_read_en_nosync <= (bram_st==1'b1);
    end
end
//assign bram_read_en = bram_read_en_nosync;
assign bram_read_en = (bram_st==1'b1);

endmodule
