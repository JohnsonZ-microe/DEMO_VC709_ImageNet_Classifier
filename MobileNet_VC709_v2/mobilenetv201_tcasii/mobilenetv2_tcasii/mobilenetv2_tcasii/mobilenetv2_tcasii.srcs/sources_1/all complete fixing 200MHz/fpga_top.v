`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/10/31 19:03:46
// Design Name: 
// Module Name: fpga_top
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


// module fpga_top
// #(
//     parameter BRAM_BAND_WIDTH = 72,
//     parameter DATA_WIDTH = 8,
//     parameter IFMAP_CHANNEL_WIDTH  = 10,
//     parameter OFMAP_CHANNEL_WIDTH  = 11,
//     parameter FM_SIZE_WIDTH  =  8,
//     parameter CHANNEL_PARA   =  9,
//     parameter BIAS_WIDTH = 32,
//     parameter HORIZENTAL_VERTICAL_COUNTER_WIDTH = 8,
//     parameter DATA_BRAM_ADDR_WIDTH = 15,
//     parameter KERNEL_BRAM_ADDR_WIDTH = 16,
//     parameter M1_BRAM_ADDR_WIDTH = 13
// )(
//     input  clk_in_p,
//     input  clk_in_n,
//     input  rstp_sys,
//     input  enable,
//     output  ram
//     );

//     wire [BRAM_BAND_WIDTH-1 :0] imp_data0,imp_data1,imp_data2,imp_data3,imp_data4,imp_data5,imp_data6,imp_data7,imp_data8;
//     wire [DATA_BRAM_ADDR_WIDTH-1:0] imp_addr0,imp_addr1,imp_addr2,imp_addr3,imp_addr4,imp_addr5,imp_addr6,imp_addr7,imp_addr8;
//     wire [8:0] imp_wea;

//     system_top # (
//     .BRAM_BAND_WIDTH(BRAM_BAND_WIDTH),
//     .DATA_WIDTH(DATA_WIDTH),
//     .IFMAP_CHANNEL_WIDTH(IFMAP_CHANNEL_WIDTH),
//     .OFMAP_CHANNEL_WIDTH(OFMAP_CHANNEL_WIDTH),
//     .FM_SIZE_WIDTH(FM_SIZE_WIDTH),
//     .CHANNEL_PARA(CHANNEL_PARA),
//     .BIAS_WIDTH(BIAS_WIDTH),
//     .HORIZENTAL_VERTICAL_COUNTER_WIDTH(HORIZENTAL_VERTICAL_COUNTER_WIDTH),
//     .DATA_BRAM_ADDR_WIDTH(DATA_BRAM_ADDR_WIDTH),
//     .KERNEL_BRAM_ADDR_WIDTH(KERNEL_BRAM_ADDR_WIDTH),
//     .M1_BRAM_ADDR_WIDTH(M1_BRAM_ADDR_WIDTH)
//   )
//   system_top_inst (
//     .clk_in_p(clk_in_p),
//     .clk_in_n(clk_in_n),
//     .rstp_sys(rstp_sys),
//     .enable(enable),
//     .ram(ram),
//     .imp_data0(imp_data0),
//     .imp_data1(imp_data1),
//     .imp_data2(imp_data2),
//     .imp_data3(imp_data3),
//     .imp_data4(imp_data4),
//     .imp_data5(imp_data5),
//     .imp_data6(imp_data6),
//     .imp_data7(imp_data7),
//     .imp_data8(imp_data8),
//     .imp_addr0(imp_addr0),
//     .imp_addr1(imp_addr1),
//     .imp_addr2(imp_addr2),
//     .imp_addr3(imp_addr3),
//     .imp_addr4(imp_addr4),
//     .imp_addr5(imp_addr5),
//     .imp_addr6(imp_addr6),
//     .imp_addr7(imp_addr7),
//     .imp_addr8(imp_addr8),
//     .imp_wea(imp_wea)
//   );
// endmodule
