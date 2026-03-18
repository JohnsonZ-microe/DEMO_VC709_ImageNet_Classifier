//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
//Date        : Mon Mar 16 03:27:21 2026
//Host        : DESKTOP-0U402MD running 64-bit major release  (build 9200)
//Command     : generate_target system_wrapper.bd
//Design      : system_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module system_wrapper
   (CLKIN,
    bram_addr_a_0,
    bram_clk_a_0,
    bram_en_a_0,
    bram_rddata_a_0,
    bram_rst_a_0,
    bram_we_a_0,
    bram_wrdata_a_0,
    clk_n,
    clk_p,
    pcie_7x_mgt_rtl_0_rxn,
    pcie_7x_mgt_rtl_0_rxp,
    pcie_7x_mgt_rtl_0_txn,
    pcie_7x_mgt_rtl_0_txp,
    reset_rtl_0,
    user_lnk_up_0);
  input CLKIN;
  output [24:0]bram_addr_a_0;
  output bram_clk_a_0;
  output bram_en_a_0;
  input [127:0]bram_rddata_a_0;
  output bram_rst_a_0;
  output [15:0]bram_we_a_0;
  output [127:0]bram_wrdata_a_0;
  input clk_n;
  input clk_p;
  input [3:0]pcie_7x_mgt_rtl_0_rxn;
  input [3:0]pcie_7x_mgt_rtl_0_rxp;
  output [3:0]pcie_7x_mgt_rtl_0_txn;
  output [3:0]pcie_7x_mgt_rtl_0_txp;
  input reset_rtl_0;
  output user_lnk_up_0;

  wire CLKIN;
  wire [24:0]bram_addr_a_0;
  wire bram_clk_a_0;
  wire bram_en_a_0;
  wire [127:0]bram_rddata_a_0;
  wire bram_rst_a_0;
  wire [15:0]bram_we_a_0;
  wire [127:0]bram_wrdata_a_0;
  wire clk_n;
  wire clk_p;
  wire [3:0]pcie_7x_mgt_rtl_0_rxn;
  wire [3:0]pcie_7x_mgt_rtl_0_rxp;
  wire [3:0]pcie_7x_mgt_rtl_0_txn;
  wire [3:0]pcie_7x_mgt_rtl_0_txp;
  wire reset_rtl_0;
  wire user_lnk_up_0;

  system system_i
       (.CLKIN(CLKIN),
        .bram_addr_a_0(bram_addr_a_0),
        .bram_clk_a_0(bram_clk_a_0),
        .bram_en_a_0(bram_en_a_0),
        .bram_rddata_a_0(bram_rddata_a_0),
        .bram_rst_a_0(bram_rst_a_0),
        .bram_we_a_0(bram_we_a_0),
        .bram_wrdata_a_0(bram_wrdata_a_0),
        .clk_n(clk_n),
        .clk_p(clk_p),
        .pcie_7x_mgt_rtl_0_rxn(pcie_7x_mgt_rtl_0_rxn),
        .pcie_7x_mgt_rtl_0_rxp(pcie_7x_mgt_rtl_0_rxp),
        .pcie_7x_mgt_rtl_0_txn(pcie_7x_mgt_rtl_0_txn),
        .pcie_7x_mgt_rtl_0_txp(pcie_7x_mgt_rtl_0_txp),
        .reset_rtl_0(reset_rtl_0),
        .user_lnk_up_0(user_lnk_up_0));
endmodule
