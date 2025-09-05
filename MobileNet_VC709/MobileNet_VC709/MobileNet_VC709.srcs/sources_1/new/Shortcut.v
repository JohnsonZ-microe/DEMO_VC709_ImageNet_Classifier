`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/01 09:47:57
// Design Name: 
// Module Name: Shortcut
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


module Shortcut(
    input clk,
    input rst,
    
    /** User Config Register Signal Declaration **/
    input [31:0] reg_config_data_in,   // user config register data input  
    input [3:0] reg_config_addr,       // user config register mapped address                
    input reg_config_valid,            // user config register data valid, when asserted, reg_config_data_in was written in corresponding register
    
    input [7:0] PW_in,
    
    input [7:0] ifmap_bram0, ifmap_bram1, ifmap_bram2,
    input [18:0] point_base_addr0, point_base_addr1, point_base_addr2,
    input [8:0] Channel_cnt,
    input bram0_en, bram1_en, bram2_en, //connected to the ena signal of PW_result_bram_writer 
    
    output [18:0] Data_bram0_addr, Data_bram1_addr, Data_bram2_addr,
    output Data_bram0_en, Data_bram1_en, Data_bram2_en,
    output [7:0] shortcut_res
    );
    
/** User Config Register Declaration **/
//--  1. Shortcut config register  --//
//--  coding scheme:
//--  [7:0] Ifmap_size  [17:8] Ifmap_channel  [28:18] Ofmap_channel  [29]:stride [30]: enable
    reg [31:0] SC_config;
    
    wire [18:0] ifmap_base_addr;
    assign ifmap_base_addr = SC_config[18:0];
    wire ena;
    assign ifmap_base_addr = SC_config[19];
 
always@(posedge clk) begin
    if(!rst) begin
        SC_config <= 0;
    end
    else if(reg_config_valid) begin
        case(reg_config_addr)
            4'd0: SC_config <= reg_config_data_in; 
            default:  
            begin
                SC_config <= SC_config;
            end
        endcase
    end
    else begin
        SC_config <= SC_config;
    end
end
    //--------- bram write address generation -----------//
assign Data_bram0_addr = ifmap_base_addr + point_base_addr0  + Channel_cnt;
assign Data_bram1_addr = ifmap_base_addr + point_base_addr1  + Channel_cnt;
assign Data_bram2_addr = ifmap_base_addr + point_base_addr2  + Channel_cnt;

reg [7:0] ifmap_input ;

// decide the ifmap source
always@(posedge clk) begin
    if(!rst) begin
        ifmap_input <= 0;
    end
    else  begin
        case({bram0_en, bram1_en, bram2_en})
            3'b100: ifmap_input <= ifmap_bram0;
            3'b010: ifmap_input <= ifmap_bram1;
            3'b001: ifmap_input <= ifmap_bram2;
            default: ifmap_input <= 0;
        endcase
    end
end

// Bram ready delay
reg [7:0] PW_in_delayed_1, PW_in_delayed_2;
always@(posedge clk) begin
    PW_in_delayed_1 <= PW_in;
    PW_in_delayed_2 <= PW_in_delayed_1;
end

// multiply and add
assign shortcut_res = ifmap_input + PW_in_delayed_2;
endmodule
