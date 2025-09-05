`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/31 15:13:05
// Design Name: 
// Module Name: AvgPooling
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


module AvgPooling
#(
parameter IFMAP_SIZE = 7,
parameter IFMAP_CHANNEL = 1280,
parameter ROW_ADDR_SHIFT = IFMAP_SIZE*1280,
parameter DIVIDE_TREE_STAGE = 3
)
(
    input clk,
    input rst,
    
    input Avepool_start,
    output complete,
    
    input [7:0] data_bram0_in,
    input [7:0] data_bram1_in,
    input [7:0] data_bram2_in,
    input [18:0] ifmap_base_addr,
    input [18:0] ofmap_base_addr,
    output bram0_en, bram1_en, bram2_en,
    output [18:0] bram0_data_addr,
    output [18:0] bram1_data_addr,
    output [18:0] bram2_data_addr,
    output [7:0] avepool_res,
    output bram_ave_out_wea,
    output bram_ave_out_addr
    );
  
    
//counters
reg [7:0] Ifmap_hori_base_cnt;
reg [7:0] Ifmap_vert_base_cnt; 
reg [10:0] Channel_cnt;
reg [2:0] Avepool_local_vert_cnt;  
reg [2:0] Divide_cnt = 0;  
    
    
//
reg [31:0] Accum_reg;
reg divide_done;
/////////////////------------------------------------------------/////////////////////
////////////////////               [3]. FSM                   ////////////////////////
/////////////////------------------------------------------------////////////////////
reg [2:0]pool_st = 0;
reg [2:0]pool_next_st = 0;

localparam IDLE   = 0;   // one clap for reset counter
localparam ACCUM  = 1;   // accumulate for the 14 * 14 * 64 input data feature
localparam DIVIDE = 2;   


always @(posedge clk)
begin
    pool_st <= pool_next_st;
end 

always @(*)
begin
    case(pool_st)
        IDLE:
        begin
            pool_next_st = ACCUM; 
        end 
        ACCUM: 
        begin 
            if (Avepool_local_vert_cnt == 2 && Ifmap_hori_base_cnt == IFMAP_SIZE-1)
            begin 
                pool_next_st = DIVIDE;
            end 
            else 
            begin
                pool_next_st = ACCUM; 
            end 
        end 
        
        DIVIDE:
        begin
             if (Divide_cnt == DIVIDE_TREE_STAGE - 1)
             begin
                pool_next_st = IDLE; 
             end 
             else 
             begin
                pool_next_st = DIVIDE; 
             end 
        end 
        default: pool_next_st = ACCUM;
    endcase 
end 



/////////////////------------------------------------------------/////////////////////
////////////////////        [4]. Counters Definition             ////////////////////////
/////////////////------------------------------------------------////////////////////
//-- 1. Ifmap_hori_base_cnt(IHB)  --//
// Specify the central corner point at a 3*3 convolution in ifmap/ofmap
always @(posedge clk)
    begin
        if(!rst) begin
            Ifmap_hori_base_cnt <= 0;
        end
        else if(Avepool_start)
            if (Ifmap_hori_base_cnt == IFMAP_SIZE-1)
                Ifmap_hori_base_cnt <= 0;
            else 
                Ifmap_hori_base_cnt <= Ifmap_hori_base_cnt + 1;
        else begin
            Ifmap_hori_base_cnt <= 0;
        end
    end 
    
// 2. Avepool_local_vert_cnt(AVLOC) : specify the location of continuous 3 vertical raws in a 3*3 convolution for the purpose of generating different BRAM output order
always @(posedge clk) begin
    if(!rst) begin
        Avepool_local_vert_cnt <= 0;
    end
    else if(Avepool_start)
    begin 
        if (Avepool_local_vert_cnt == 2 && Ifmap_hori_base_cnt == IFMAP_SIZE-1)
            Avepool_local_vert_cnt <= 0;
        else if (Ifmap_hori_base_cnt == IFMAP_SIZE-1)
            Avepool_local_vert_cnt <= Avepool_local_vert_cnt + 1;
        else 
            Avepool_local_vert_cnt <= Avepool_local_vert_cnt; 
     end
     else
        Avepool_local_vert_cnt <= Avepool_local_vert_cnt;
end

// -- 3. Channel_cnt(CC)
always@(posedge clk) begin
    if(!rst) begin
        Channel_cnt <= 0;
    end
    else if(Avepool_start) begin
        if(Channel_cnt == 1280-1)
            Channel_cnt <= 0;
        else if(Avepool_local_vert_cnt == 2 && Ifmap_hori_base_cnt == IFMAP_SIZE-1)
            Channel_cnt <= Channel_cnt+1; 
        else
            Channel_cnt <= Channel_cnt;
    end
    else Channel_cnt<= 0;
end

// -- 4. Divide_cnt(CC)
always @(posedge clk)
begin
    if (pool_st == DIVIDE)
    begin 
        Divide_cnt <= Divide_cnt + 1'b1;
    end  
    else 
    begin
        Divide_cnt <= 0; 
    end 
end 

reg [31:0] Data_divide_tmp_reg_1;
reg [31:0] Data_divide_tmp_reg_2;
reg [31:0] Data_divide_tmp_reg_3;
reg [31:0] Data_divide_tmp_reg_4;
reg [31:0] Data_divide_tmp_reg_5;
reg [31:0] Data_divide_tmp_reg_6;
reg [31:0] Data_divide_tmp_reg_7;
reg [31:0] Data_divide_tmp_reg_8;
reg [31:0] Data_divide_tmp_reg_9;
reg [31:0] Data_divide_tmp_reg_10;

// -- accumulated value divide by 49  (*1337/2^16)
always @(posedge clk)
begin
     if (pool_st == DIVIDE)
     begin
        case(Divide_cnt)
        0:
        begin
             Data_divide_tmp_reg_1 <= Accum_reg >> 6;
             Data_divide_tmp_reg_2 <= Accum_reg >> 8;
             Data_divide_tmp_reg_3 <= Accum_reg >> 11;
             Data_divide_tmp_reg_4 <= Accum_reg >> 12;
             Data_divide_tmp_reg_5 <= Accum_reg >> 13;
             Data_divide_tmp_reg_6 <= Accum_reg >> 16;
        end 
        1:
        begin 
             Data_divide_tmp_reg_7 <= Data_divide_tmp_reg_1 + Data_divide_tmp_reg_4;
             Data_divide_tmp_reg_8 <= Data_divide_tmp_reg_2 + Data_divide_tmp_reg_5;
             Data_divide_tmp_reg_9 <= Data_divide_tmp_reg_3 + Data_divide_tmp_reg_6;
        end 
        2:
        begin
             Data_divide_tmp_reg_10 <= Data_divide_tmp_reg_7 + Data_divide_tmp_reg_8 + Data_divide_tmp_reg_9;  
        end 
        default:
        begin
             Data_divide_tmp_reg_1 <= Data_divide_tmp_reg_1;
             Data_divide_tmp_reg_2 <= Data_divide_tmp_reg_2;
             Data_divide_tmp_reg_3 <= Data_divide_tmp_reg_3;
             Data_divide_tmp_reg_4 <= Data_divide_tmp_reg_4;
             Data_divide_tmp_reg_5 <= Data_divide_tmp_reg_5;
             Data_divide_tmp_reg_6 <= Data_divide_tmp_reg_6;  
             Data_divide_tmp_reg_7 <= Data_divide_tmp_reg_7;
             Data_divide_tmp_reg_8 <= Data_divide_tmp_reg_8;
             Data_divide_tmp_reg_9 <= Data_divide_tmp_reg_9;
             Data_divide_tmp_reg_10 <= Data_divide_tmp_reg_10;
        end 
        endcase 
    end 
    else 
    begin
        Data_divide_tmp_reg_1 <= Data_divide_tmp_reg_1;
        Data_divide_tmp_reg_2 <= Data_divide_tmp_reg_2;
        Data_divide_tmp_reg_3 <= Data_divide_tmp_reg_3;
        Data_divide_tmp_reg_4 <= Data_divide_tmp_reg_4;
        Data_divide_tmp_reg_5 <= Data_divide_tmp_reg_5;
        Data_divide_tmp_reg_6 <= Data_divide_tmp_reg_6;  
        Data_divide_tmp_reg_7 <= Data_divide_tmp_reg_7;
        Data_divide_tmp_reg_8 <= Data_divide_tmp_reg_8;
        Data_divide_tmp_reg_9 <= Data_divide_tmp_reg_9;
        Data_divide_tmp_reg_10 <= Data_divide_tmp_reg_10;
    end 
end 
    
always@(posedge clk) begin
    if(!rst) 
        divide_done <= 0;
    else if(Divide_cnt==2)
        divide_done <= 1;
    else
        divide_done <= 0;
end
    
    
//------------ data_input_address_generation ----------------//
reg [18:0] bram_row_addr_base;
wire [18:0] bram_point_addr_base;
wire [18:0] bram_channel_addr_base;

assign bram0_data_addr = ifmap_base_addr + bram_row_addr_base + bram_point_addr_base + bram_channel_addr_base;
assign bram1_data_addr = ifmap_base_addr + bram_row_addr_base + bram_point_addr_base + bram_channel_addr_base;
assign bram2_data_addr = ifmap_base_addr + bram_row_addr_base + bram_point_addr_base + bram_channel_addr_base;

always@(posedge clk) begin
    if(!rst)
        bram_row_addr_base <= 0;
    else if(Ifmap_hori_base_cnt == IFMAP_SIZE-1)
        bram_row_addr_base <= bram_row_addr_base + ROW_ADDR_SHIFT;
    else 
        bram_row_addr_base <= bram_row_addr_base;
end

assign bram_point_addr_base = Ifmap_hori_base_cnt*IFMAP_CHANNEL;
assign bram_channel_addr_base = Channel_cnt;

always@(posedge clk) begin
    if(~rst) begin
        Accum_reg <= 0;
    end
    else if(Divide_cnt==1) 
        Accum_reg <= 0;
    else if(pool_st==ACCUM) begin
        Accum_reg <= data_bram0_in + data_bram1_in + data_bram2_in;
    end
    else
        Accum_reg <= Accum_reg;
end
endmodule
