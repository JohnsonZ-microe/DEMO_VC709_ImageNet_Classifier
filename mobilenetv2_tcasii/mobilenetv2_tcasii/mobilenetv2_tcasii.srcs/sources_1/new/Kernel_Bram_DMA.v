`timescale 1ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/08 15:30:33
// Design Name: 
// Module Name: Kernel_Bram_DMA
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


module Kernel_Bram_DMA
#(
    parameter DATA_WIDTH = 8,
    parameter DATA_BRAM_ADDR_WIDTH = 15,
    parameter KERNEL_WIDTH = 8,
    parameter KERNEL_BRAM_ADDR_WIDTH = 16,
    parameter M1_BRAM_ADDR_WIDTH = 13,
    parameter HORIZENTAL_VERTICAL_COUNTER_WIDTH = 8,
    parameter CHANNEL_PARRALISM = 9,
    parameter IFMAP_CHANNEL_WIDTH  = 10,
    parameter OFMAP_CHANNEL_WIDTH  = 11
)
(
    input clk,
    input rst,
    // Kernel BRAM read channel
    input [OFMAP_CHANNEL_WIDTH-1:0] kernel_pw_p,
    input [IFMAP_CHANNEL_WIDTH-1:0] kernel_base_channel,
    input [KERNEL_BRAM_ADDR_WIDTH-1:0] Kernel_base_addr,
    input [IFMAP_CHANNEL_WIDTH-1:0] Ifmap_channel_num,
    input [2:0] mode,
    
    input [KERNEL_BRAM_ADDR_WIDTH-1:0] M1_base_addr,
    input [1:0] bram_st,
    
    output [CHANNEL_PARRALISM*DATA_WIDTH-1 : 0] kernel0_input, kernel1_input, kernel2_input,
    output [CHANNEL_PARRALISM*DATA_WIDTH-1 : 0] kernel3_input, kernel4_input, kernel5_input,
    output [CHANNEL_PARRALISM*DATA_WIDTH-1 : 0] kernel6_input, kernel7_input, kernel8_input,
    
    input [CHANNEL_PARRALISM*DATA_WIDTH-1 : 0] kernel0_read_input, kernel1_read_input, kernel2_read_input,
    input [CHANNEL_PARRALISM*DATA_WIDTH-1 : 0] kernel3_read_input, kernel4_read_input, kernel5_read_input,
    input [CHANNEL_PARRALISM*DATA_WIDTH-1 : 0] kernel6_read_input, kernel7_read_input, kernel8_read_input,
    //Weight BRAM driver
    (* max_fanout = 64 *) output kernel_bram_en,
    (* max_fanout = 64 *) output reg [KERNEL_BRAM_ADDR_WIDTH-1:0] kernel_read_addr0, kernel_read_addr1, kernel_read_addr2,//禁止综合工具优化这些寄存器，否则fanout极高
    (* max_fanout = 64 *) output reg [KERNEL_BRAM_ADDR_WIDTH-1:0] kernel_read_addr3, kernel_read_addr4, kernel_read_addr5,
    (* max_fanout = 64 *) output reg [KERNEL_BRAM_ADDR_WIDTH-1:0] kernel_read_addr6, kernel_read_addr7, kernel_read_addr8,
    
    //M1 BRAM driver
    output M1_bram_en,
    output reg [M1_BRAM_ADDR_WIDTH-1:0] M1_read_addr,
    input [9*32-1:0] M1_bram_in,
    output [9*32-1:0] M1_out
    );
    
    assign kernel_bram_en = (bram_st==1'b1);
    
    assign kernel0_input = kernel0_read_input;
    assign kernel1_input = kernel1_read_input;
    assign kernel2_input = kernel2_read_input;
    assign kernel3_input = kernel3_read_input;
    assign kernel4_input = kernel4_read_input;
    assign kernel5_input = kernel5_read_input;
    assign kernel6_input = kernel6_read_input;
    assign kernel7_input = kernel7_read_input;
    assign kernel8_input = kernel8_read_input;
    
    reg [KERNEL_BRAM_ADDR_WIDTH-1:0] kernel_read_base_p;
    wire[KERNEL_BRAM_ADDR_WIDTH-1:0] kernel_read_base_p_mux;
    reg [KERNEL_BRAM_ADDR_WIDTH-1:0] kernel_read_base_p_mux_reg;
    always @(posedge clk) begin
        if(!rst) kernel_read_base_p_mux_reg <= 0;
        else kernel_read_base_p_mux_reg <= (mode == 3'd3)?kernel_pw_p*Ifmap_channel_num : kernel_read_base_p;
    end
    // assign kernel_read_base_p_mux = (mode == 3'd3)?kernel_pw_p*Ifmap_channel_num : kernel_read_base_p;
    assign kernel_read_base_p_mux = kernel_read_base_p_mux_reg;
    always@(posedge clk) begin
        if(!rst) kernel_read_base_p <= 0;
        else if(mode == 3'd2) begin// mode == 2'd2: depthwise mode
            kernel_read_base_p <= 0;
        end
        else kernel_read_base_p <= kernel_pw_p*Ifmap_channel_num;

    end
reg [IFMAP_CHANNEL_WIDTH-1:0] kernel_base_channel_reg1, kernel_base_channel_reg2;
always@(posedge clk) begin
    if(!rst) begin
        kernel_base_channel_reg1 <= 0;
        kernel_base_channel_reg2 <= 0;
    end
    else begin
        kernel_base_channel_reg1 <= kernel_base_channel;
        kernel_base_channel_reg2 <= kernel_base_channel_reg1;
    end
end
wire [IFMAP_CHANNEL_WIDTH-1:0] kernel_base_channel_mux;
assign kernel_base_channel_mux = (mode == 3'd3)? kernel_base_channel_reg2 : kernel_base_channel;
// 用二维数组替代大量独立寄存器定义（维度1：地址索引0-8；维度2：级联寄存器1-4）
reg [KERNEL_BRAM_ADDR_WIDTH-1:0] kernel_read_addr_reg [0:8][0:3];
integer i,j;
always@(posedge clk) begin
    if(!rst) begin
        // 复位时通过双重循环清零所有寄存器
        for(i = 0; i <= 8; i = i + 1) begin
            for(j = 0; j < 4; j = j + 1) begin
                kernel_read_addr_reg[i][j] <= 0;
            end
        end
    end
    else begin
        // 第1级寄存器赋值（所有地址索引共享同一输入）
        for(i = 0; i <= 8; i = i + 1) begin
            kernel_read_addr_reg[i][0] <= Kernel_base_addr + kernel_read_base_p_mux + kernel_base_channel_mux;
        end
        // 第2-4级寄存器为前一级的延迟（级联关系）
        for(i = 0; i <= 8; i = i + 1) begin
            kernel_read_addr_reg[i][1] <= kernel_read_addr_reg[i][0];
            kernel_read_addr_reg[i][2] <= kernel_read_addr_reg[i][1];
            kernel_read_addr_reg[i][3] <= kernel_read_addr_reg[i][2];
        end
    end
end
    
    always @(*) begin
        case(mode)
            3'd1:begin
                kernel_read_addr0 = kernel_read_addr_reg[0][0];
                kernel_read_addr1 = kernel_read_addr_reg[1][0];
                kernel_read_addr2 = kernel_read_addr_reg[2][0];
                kernel_read_addr3 = kernel_read_addr_reg[3][0];
                kernel_read_addr4 = kernel_read_addr_reg[4][0];
                kernel_read_addr5 = kernel_read_addr_reg[5][0];
                kernel_read_addr6 = kernel_read_addr_reg[6][0];
                kernel_read_addr7 = kernel_read_addr_reg[7][0];
                kernel_read_addr8 = kernel_read_addr_reg[8][0];
            end
            3'd2:begin
                kernel_read_addr0 = kernel_read_addr_reg[0][3];
                kernel_read_addr1 = kernel_read_addr_reg[1][3];
                kernel_read_addr2 = kernel_read_addr_reg[2][3];
                kernel_read_addr3 = kernel_read_addr_reg[3][3];
                kernel_read_addr4 = kernel_read_addr_reg[4][3];
                kernel_read_addr5 = kernel_read_addr_reg[5][3];
                kernel_read_addr6 = kernel_read_addr_reg[6][3];
                kernel_read_addr7 = kernel_read_addr_reg[7][3];
                kernel_read_addr8 = kernel_read_addr_reg[8][3];
            end
            3'd3:begin
                kernel_read_addr0 = kernel_read_addr_reg[0][1];
                kernel_read_addr1 = kernel_read_addr_reg[1][1];
                kernel_read_addr2 = kernel_read_addr_reg[2][1];
                kernel_read_addr3 = kernel_read_addr_reg[3][1];
                kernel_read_addr4 = kernel_read_addr_reg[4][1];
                kernel_read_addr5 = kernel_read_addr_reg[5][1];
                kernel_read_addr6 = kernel_read_addr_reg[6][1];
                kernel_read_addr7 = kernel_read_addr_reg[7][1];
                kernel_read_addr8 = kernel_read_addr_reg[8][1];
            end
            default:begin
                kernel_read_addr0 = kernel_read_addr_reg[0][3];
                kernel_read_addr1 = kernel_read_addr_reg[1][3];
                kernel_read_addr2 = kernel_read_addr_reg[2][3];
                kernel_read_addr3 = kernel_read_addr_reg[3][3];
                kernel_read_addr4 = kernel_read_addr_reg[4][3];
                kernel_read_addr5 = kernel_read_addr_reg[5][3];
                kernel_read_addr6 = kernel_read_addr_reg[6][3];
                kernel_read_addr7 = kernel_read_addr_reg[7][3];
                kernel_read_addr8 = kernel_read_addr_reg[8][3];
            end
        endcase
    end
    assign M1_bram_en = (bram_st==1'b1);
    
    assign M1_out = M1_bram_in;
    
    reg [OFMAP_CHANNEL_WIDTH-1:0] kernel_pw_p_delay_1;
    always@(posedge clk) begin
        if(!rst) kernel_pw_p_delay_1 <= 0;
        else kernel_pw_p_delay_1 <= kernel_pw_p;
    end
    always@(posedge clk) begin 
        if(!rst) M1_read_addr <= 0;
        else M1_read_addr <= M1_base_addr + kernel_pw_p_delay_1; 
    end
    
endmodule
