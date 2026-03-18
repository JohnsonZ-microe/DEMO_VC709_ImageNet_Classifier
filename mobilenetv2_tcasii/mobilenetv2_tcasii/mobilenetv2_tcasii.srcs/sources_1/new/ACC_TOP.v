`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/05/2026 06:42:37 PM
// Design Name: 
// Module Name: PCIE_top
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


module ACC_TOP(
    clk_n,
    clk_p,
    diff_clock_rtl_0_clk_n,
    diff_clock_rtl_0_clk_p,
    pcie_7x_mgt_rtl_0_rxn,
    pcie_7x_mgt_rtl_0_rxp,
    pcie_7x_mgt_rtl_0_txn,
    pcie_7x_mgt_rtl_0_txp,
    reset_rtl_0,
    user_lnk_up_0);
  input clk_p,clk_n;
  input [0:0]diff_clock_rtl_0_clk_n;
  input [0:0]diff_clock_rtl_0_clk_p;
  input [3:0]pcie_7x_mgt_rtl_0_rxn;
  input [3:0]pcie_7x_mgt_rtl_0_rxp;
  output [3:0]pcie_7x_mgt_rtl_0_txn;
  output [3:0]pcie_7x_mgt_rtl_0_txp;
  input reset_rtl_0;
  output wire user_lnk_up_0;
  
  wire CLKIN;
  wire [24:0]bram_addr_a_0;
  wire bram_clk_a_0;
  wire bram_en_a_0;
  wire [127:0]bram_rddata_a_0;
  wire bram_rst_a_0;
  wire [15:0]bram_we_a_0;
  wire [127:0]bram_wrdata_a_0;
  wire rstn_accelerator;
  IBUFDS_GTE2 refclk_ibuf (
    .CEB             ( 1'b0              ),
    .I               ( diff_clock_rtl_0_clk_p    ),
    .IB              ( diff_clock_rtl_0_clk_n    ),
    .O               ( CLKIN       ),
    .ODIV2           (                   )
);

// Reset input buffer ----------------------------------------------
IBUF   sys_reset_n_ibuf (
    .I               ( reset_rtl_0       ),
    .O               ( pcie_rstn         )
);
 

system_top #(
    .BRAM_BAND_WIDTH(72),
    .DATA_WIDTH(8),
    .IFMAP_CHANNEL_WIDTH(10),
    .OFMAP_CHANNEL_WIDTH(11),
    .FM_SIZE_WIDTH(8),
    .CHANNEL_PARA(9),
    .BIAS_WIDTH(32),
    .HORIZENTAL_VERTICAL_COUNTER_WIDTH(8),
    .DATA_BRAM_ADDR_WIDTH(15),
    .KERNEL_BRAM_ADDR_WIDTH(16),
    .M1_BRAM_ADDR_WIDTH(13)
) ACC_core (
    .clk(bram_clk_a_0),
    // .rstp_sys(!rstn_accelerator),
    // .rstn_accelerator(!rstn_accelerator),
    // .control_source(control_source_out),
    .pcie_addr(bram_addr_a_0[24:4]),
    .pcie_write_ena(&bram_we_a_0),
    .pcie_data_in(bram_wrdata_a_0[71:0]),
    .pcie_data_out(bram_rddata_a_0[71:0])
);

system_wrapper system_wrapper_i
   (.CLKIN(CLKIN),
    .clk_n(clk_n),
    .clk_p(clk_p),
    .bram_addr_a_0(bram_addr_a_0),
    .bram_clk_a_0(bram_clk_a_0),
    .bram_en_a_0(bram_en_a_0),
    .bram_rddata_a_0(bram_rddata_a_0),
    .bram_rst_a_0(),
    .bram_we_a_0(bram_we_a_0),
    .bram_wrdata_a_0(bram_wrdata_a_0),
    .pcie_7x_mgt_rtl_0_rxn(pcie_7x_mgt_rtl_0_rxn),
    .pcie_7x_mgt_rtl_0_rxp(pcie_7x_mgt_rtl_0_rxp),
    .pcie_7x_mgt_rtl_0_txn(pcie_7x_mgt_rtl_0_txn),
    .pcie_7x_mgt_rtl_0_txp(pcie_7x_mgt_rtl_0_txp),
    .reset_rtl_0(pcie_rstn),
    .user_lnk_up_0(user_lnk_up_0));
  
endmodule

