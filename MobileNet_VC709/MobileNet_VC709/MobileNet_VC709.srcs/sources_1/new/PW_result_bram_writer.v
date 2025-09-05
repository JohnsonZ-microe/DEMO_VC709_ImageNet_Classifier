`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/30 23:21:03
// Design Name: 
// Module Name: PW_result_bram_writer
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


module PW_result_bram_writer(
    input clk,
    input rst,
    input channel_disboarding,
    input [7:0] PW_res,
    input [7:0] Ifmap_hori_base_cnt,
    input [7:0] Ifmap_vert_base_cnt,
    input [2:0] Conv33_local_vert_cnt,
    input [10:0] ofmap_channel,
    input [18:0] output_base_addr,
    input [3:0] Ofmap_channel_round_cnt,
    
    output reg [7:0] Data_bram0_data,
    output [18:0] Data_bram0_addr,
    output reg [7:0] Data_bram1_data,
    output [18:0] Data_bram1_addr,
    output reg [7:0] Data_bram2_data,
    output [18:0] Data_bram2_addr,
   
    output reg SC_bram0_en, SC_bram1_en, SC_bram2_en,
    output [7:0] to_SC,
    input has_SC,
    input [7:0] SC_in
    );
   

// channel_disboarding delayed for shortcut
reg channel_disboarding_delay_1;
reg channel_disboarding_SC;
always@(posedge clk) begin
    if(!clk) begin
        channel_disboarding_delay_1 <= 0;
        channel_disboarding_SC <= 0;
    end
    else if(has_SC) begin
        channel_disboarding_delay_1 <= channel_disboarding;
        channel_disboarding_SC <= channel_disboarding_delay_1;
    end
    else begin
        channel_disboarding_delay_1 <= 0;
        channel_disboarding_SC <= 0;
    end
end
 
 
 
// signal bram_writeback
wire bram_writeback; 
assign bram_writeback = (has_SC)? channel_disboarding_SC: channel_disboarding;
//---------- Subaddress define -----------//
    reg [18:0] point_base_addr0, point_base_addr1, point_base_addr2;
    wire [18:0] channel_round_start_addr;
    assign channel_round_start_addr = 340*Ofmap_channel_round_cnt;
    
    assign to_SC = PW_res;
    wire [7:0] result_wb;
    assign result_wb = (has_SC)? PW_res: SC_in;

//--------- Define address shift ------------//
    wire [10:0] point_shift;
    assign point_shift = ofmap_channel;
    
//--------- bram_write_ena define-----------//
    reg bram_0_wea, bram_1_wea, bram_2_wea;
    
    always@(*)
    if(bram_writeback)
        case(Conv33_local_vert_cnt)
            0:
            begin
                bram_0_wea <= 1;
                SC_bram0_en <= 1;
                bram_1_wea <= 0;
                SC_bram1_en <= 0;
                bram_2_wea <= 0;
                SC_bram2_en <= 0;
            end
            1:
            begin
                bram_0_wea <= 0;
                SC_bram0_en <= 0;
                bram_1_wea <= 1;
                SC_bram1_en <= 1;
                bram_2_wea <= 0;
                SC_bram2_en <= 0;
            end
            2:
            begin
                bram_0_wea <= 0;
                SC_bram0_en <= 0;
                bram_1_wea <= 0;
                SC_bram1_en <= 0;
                bram_2_wea <= 1;  
                SC_bram2_en <= 1;                   
            end
            default
            begin
                bram_0_wea <= 0;
                SC_bram0_en <= 0;
                bram_1_wea <= 0;
                SC_bram1_en <= 0;
                bram_2_wea <= 0; 
                SC_bram2_en <= 0;
            end 
        endcase
    else begin
        bram_0_wea = 0;
        SC_bram0_en <= 0;
        bram_1_wea = 0;
        SC_bram1_en <= 0;
        bram_2_wea = 0;
        SC_bram2_en <= 0;
    end
  
  
    always@(posedge clk)
    if(!rst) begin
        Data_bram0_data = 0;
        Data_bram1_data = 0;
        Data_bram2_data = 0;
    end
    else if(bram_writeback)
        case(Conv33_local_vert_cnt)
            0:
            begin
                Data_bram0_data <= result_wb;
                Data_bram1_data <= 0;
                Data_bram2_data <= 0;
            end
            1:
            begin
                Data_bram0_data <= 0;
                Data_bram1_data <= result_wb;
                Data_bram2_data <= 0;
            end
            2:
            begin
                Data_bram0_data <= 0;
                Data_bram1_data <= 0;
                Data_bram2_data <= result_wb;                     
            end
            default
            begin
                Data_bram0_data <= 0;
                Data_bram1_data <= 0;
                Data_bram2_data <= 0; 
            end 
        endcase
    else begin
        Data_bram0_data = 0;
        Data_bram1_data = 0;
        Data_bram2_data = 0;
    end
    
//---------counter defines---------------
reg [8:0] Channel_cnt;
always@(posedge clk)
    if(!rst) begin
        Channel_cnt = 0;
    end
    else if(channel_disboarding)
        Channel_cnt = Channel_cnt+1;
    else Channel_cnt = 0;

// Channel_cnt delayed for SC
// channel_disboarding delayed for shortcut
reg [8:0] Channel_cnt_delay_1;
reg [8:0] Channel_cnt_delay_2;
always@(posedge clk) begin
    if(!clk) begin
        Channel_cnt_delay_1 <= 0;
        Channel_cnt_delay_2 <= 0;
    end
    else if(has_SC) begin
        Channel_cnt_delay_1 <= Channel_cnt;
        Channel_cnt_delay_2 <= Channel_cnt_delay_1;
    end
    else begin
        Channel_cnt_delay_1 <= 0;
        Channel_cnt_delay_2 <= 0;
    end
end

reg bram_writeback_pulse_gen;
wire bram_writeback_pulse;
always@(posedge clk)  begin
    if(!rst) 
        bram_writeback_pulse_gen <= 0;
    else 
        bram_writeback_pulse_gen <= bram_writeback;
end

assign bram_writeback_pulse = bram_writeback_pulse_gen&(~bram_writeback_pulse);
 
always@(posedge clk) begin
    if(!rst) begin
        point_base_addr0 <= 0;
        point_base_addr1 <= 0;
        point_base_addr2 <= 0;
    end
    else if(bram_writeback_pulse) begin
        case(Conv33_local_vert_cnt)
            0:
            begin
                point_base_addr0 <= point_base_addr0  + point_shift;
                point_base_addr1 <= point_base_addr1;
                point_base_addr2 <= point_base_addr2;
            end
            1:
            begin
                point_base_addr0 <= point_base_addr0;
                point_base_addr1 <= point_base_addr1 + point_shift;               
                point_base_addr2 <= point_base_addr2;               
            end
            2:
            begin
                point_base_addr0 <= point_base_addr0;
                point_base_addr1 <= point_base_addr1;               
                point_base_addr2 <= point_base_addr2 + point_shift;    
            end
            default:
            begin
                point_base_addr0 <= point_base_addr0;
                point_base_addr1 <= point_base_addr1;               
                point_base_addr2 <= point_base_addr2;    
            end
            endcase
    end
end

wire [8:0] channel_base_addr;
assign channel_base_addr = (has_SC)? Channel_cnt_delay_2: Channel_cnt;

//--------- bram write address generation -----------//
assign Data_bram0_addr = output_base_addr + point_base_addr0 + channel_round_start_addr + channel_base_addr;
assign Data_bram1_addr = output_base_addr + point_base_addr1 + channel_round_start_addr + channel_base_addr;
assign Data_bram2_addr = output_base_addr + point_base_addr2 + channel_round_start_addr + channel_base_addr;

endmodule
