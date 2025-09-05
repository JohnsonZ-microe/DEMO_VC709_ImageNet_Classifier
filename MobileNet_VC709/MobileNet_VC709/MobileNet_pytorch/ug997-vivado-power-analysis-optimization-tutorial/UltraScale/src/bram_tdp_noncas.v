// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.1.0 (lin64) Build 1471427 Wed Feb  3 18:31:16 MST 2016
// Date        : Mon Feb 15 11:46:05 2016
// Host        : xhdl3039 running 64-bit Red Hat Enterprise Linux Client release 5.9 (Tikanga)
// Command     : write_verilog -force non_cas.v
// Design      : bram_noncas
// Purpose     : This is a Verilog netlist of the current design or from a specific cell of the design. The output is an
//               IEEE 1364-2001 compliant Verilog HDL file that contains netlist information obtained from the input
//               design files.
// Device      : xcku040-ffva1156-2-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* AW = "12" *) (* DONT_TOUCH = "true" *) (* DW = "36" *) 
(* STRUCTURAL_NETLIST = "yes" *)
module bram_tdp_noncas
   (clkA,
    clkB,
    rstA,
    rstB,
    addrA,
    addrB,
    dinA,
    dinB,
    enA,
    enB,
    weA,
    weB,
    doutA,
    doutB);
  input clkA;
  input clkB;
  input rstA;
  input rstB;
  input [11:0]addrA;
  input [11:0]addrB;
  input [35:0]dinA;
  input [35:0]dinB;
  input enA;
  input enB;
  input weA;
  input weB;
  output [35:0]doutA;
  output [35:0]doutB;

  wire \<const0> ;
  wire \<const1> ;
  wire VCC_2;
  wire [11:0]addrA;
  wire [11:0]addrA_IBUF;
  wire [11:0]addrB;
  wire [11:0]addrB_IBUF;
  wire clkA;
  wire clkA_IBUF;
  wire clkA_IBUF_BUFG;
  wire clkB;
  wire clkB_IBUF;
  wire clkB_IBUF_BUFG;
  wire [35:0]dinA;
  wire [35:0]dinA_IBUF;
  wire [35:0]dinB;
  wire [35:0]dinB_IBUF;
  wire [35:0]doutA;
  wire doutA0;
  wire [35:0]doutA_1;
  wire [35:0]doutA_OBUF;
  wire \doutA_reg[0]_i_2_n_0 ;
  wire \doutA_reg[10]_i_2_n_0 ;
  wire \doutA_reg[11]_i_2_n_0 ;
  wire \doutA_reg[12]_i_2_n_0 ;
  wire \doutA_reg[13]_i_2_n_0 ;
  wire \doutA_reg[14]_i_2_n_0 ;
  wire \doutA_reg[15]_i_2_n_0 ;
  wire \doutA_reg[16]_i_2_n_0 ;
  wire \doutA_reg[17]_i_2_n_0 ;
  wire \doutA_reg[18]_i_2_n_0 ;
  wire \doutA_reg[19]_i_2_n_0 ;
  wire \doutA_reg[1]_i_2_n_0 ;
  wire \doutA_reg[20]_i_2_n_0 ;
  wire \doutA_reg[21]_i_2_n_0 ;
  wire \doutA_reg[22]_i_2_n_0 ;
  wire \doutA_reg[23]_i_2_n_0 ;
  wire \doutA_reg[24]_i_2_n_0 ;
  wire \doutA_reg[25]_i_2_n_0 ;
  wire \doutA_reg[26]_i_2_n_0 ;
  wire \doutA_reg[27]_i_2_n_0 ;
  wire \doutA_reg[28]_i_2_n_0 ;
  wire \doutA_reg[29]_i_2_n_0 ;
  wire \doutA_reg[2]_i_2_n_0 ;
  wire \doutA_reg[30]_i_2_n_0 ;
  wire \doutA_reg[31]_i_2_n_0 ;
  wire \doutA_reg[32]_i_2_n_0 ;
  wire \doutA_reg[33]_i_2_n_0 ;
  wire \doutA_reg[34]_i_2_n_0 ;
  wire \doutA_reg[35]_i_3_n_0 ;
  wire \doutA_reg[35]_i_4_n_0 ;
  wire \doutA_reg[3]_i_2_n_0 ;
  wire \doutA_reg[4]_i_2_n_0 ;
  wire \doutA_reg[5]_i_2_n_0 ;
  wire \doutA_reg[6]_i_2_n_0 ;
  wire \doutA_reg[7]_i_2_n_0 ;
  wire \doutA_reg[8]_i_2_n_0 ;
  wire \doutA_reg[9]_i_2_n_0 ;
  wire [35:0]doutB;
  wire doutB0;
  wire [35:0]doutB_1;
  wire [35:0]doutB_OBUF;
  wire \doutB_reg[0]_i_2_n_0 ;
  wire \doutB_reg[10]_i_2_n_0 ;
  wire \doutB_reg[11]_i_2_n_0 ;
  wire \doutB_reg[12]_i_2_n_0 ;
  wire \doutB_reg[13]_i_2_n_0 ;
  wire \doutB_reg[14]_i_2_n_0 ;
  wire \doutB_reg[15]_i_2_n_0 ;
  wire \doutB_reg[16]_i_2_n_0 ;
  wire \doutB_reg[17]_i_2_n_0 ;
  wire \doutB_reg[18]_i_2_n_0 ;
  wire \doutB_reg[19]_i_2_n_0 ;
  wire \doutB_reg[1]_i_2_n_0 ;
  wire \doutB_reg[20]_i_2_n_0 ;
  wire \doutB_reg[21]_i_2_n_0 ;
  wire \doutB_reg[22]_i_2_n_0 ;
  wire \doutB_reg[23]_i_2_n_0 ;
  wire \doutB_reg[24]_i_2_n_0 ;
  wire \doutB_reg[25]_i_2_n_0 ;
  wire \doutB_reg[26]_i_2_n_0 ;
  wire \doutB_reg[27]_i_2_n_0 ;
  wire \doutB_reg[28]_i_2_n_0 ;
  wire \doutB_reg[29]_i_2_n_0 ;
  wire \doutB_reg[2]_i_2_n_0 ;
  wire \doutB_reg[30]_i_2_n_0 ;
  wire \doutB_reg[31]_i_2_n_0 ;
  wire \doutB_reg[32]_i_2_n_0 ;
  wire \doutB_reg[33]_i_2_n_0 ;
  wire \doutB_reg[34]_i_2_n_0 ;
  wire \doutB_reg[35]_i_3_n_0 ;
  wire \doutB_reg[35]_i_4_n_0 ;
  wire \doutB_reg[3]_i_2_n_0 ;
  wire \doutB_reg[4]_i_2_n_0 ;
  wire \doutB_reg[5]_i_2_n_0 ;
  wire \doutB_reg[6]_i_2_n_0 ;
  wire \doutB_reg[7]_i_2_n_0 ;
  wire \doutB_reg[8]_i_2_n_0 ;
  wire \doutB_reg[9]_i_2_n_0 ;
  wire enA;
  wire enA_IBUF;
  wire enB;
  wire enB_IBUF;
  wire mem_reg_0_i_2_n_0;
  wire mem_reg_0_n_124;
  wire mem_reg_0_n_125;
  wire mem_reg_0_n_126;
  wire mem_reg_0_n_127;
  wire mem_reg_0_n_128;
  wire mem_reg_0_n_129;
  wire mem_reg_0_n_130;
  wire mem_reg_0_n_131;
  wire mem_reg_0_n_143;
  wire mem_reg_0_n_147;
  wire mem_reg_0_n_92;
  wire mem_reg_0_n_93;
  wire mem_reg_0_n_94;
  wire mem_reg_0_n_95;
  wire mem_reg_0_n_96;
  wire mem_reg_0_n_97;
  wire mem_reg_0_n_98;
  wire mem_reg_0_n_99;
  wire mem_reg_1_n_124;
  wire mem_reg_1_n_125;
  wire mem_reg_1_n_126;
  wire mem_reg_1_n_127;
  wire mem_reg_1_n_128;
  wire mem_reg_1_n_129;
  wire mem_reg_1_n_130;
  wire mem_reg_1_n_131;
  wire mem_reg_1_n_143;
  wire mem_reg_1_n_147;
  wire mem_reg_1_n_92;
  wire mem_reg_1_n_93;
  wire mem_reg_1_n_94;
  wire mem_reg_1_n_95;
  wire mem_reg_1_n_96;
  wire mem_reg_1_n_97;
  wire mem_reg_1_n_98;
  wire mem_reg_1_n_99;
  wire mem_reg_2_n_124;
  wire mem_reg_2_n_125;
  wire mem_reg_2_n_126;
  wire mem_reg_2_n_127;
  wire mem_reg_2_n_128;
  wire mem_reg_2_n_129;
  wire mem_reg_2_n_130;
  wire mem_reg_2_n_131;
  wire mem_reg_2_n_143;
  wire mem_reg_2_n_147;
  wire mem_reg_2_n_92;
  wire mem_reg_2_n_93;
  wire mem_reg_2_n_94;
  wire mem_reg_2_n_95;
  wire mem_reg_2_n_96;
  wire mem_reg_2_n_97;
  wire mem_reg_2_n_98;
  wire mem_reg_2_n_99;
  wire mem_reg_3_n_124;
  wire mem_reg_3_n_125;
  wire mem_reg_3_n_126;
  wire mem_reg_3_n_127;
  wire mem_reg_3_n_128;
  wire mem_reg_3_n_129;
  wire mem_reg_3_n_130;
  wire mem_reg_3_n_131;
  wire mem_reg_3_n_143;
  wire mem_reg_3_n_147;
  wire mem_reg_3_n_92;
  wire mem_reg_3_n_93;
  wire mem_reg_3_n_94;
  wire mem_reg_3_n_95;
  wire mem_reg_3_n_96;
  wire mem_reg_3_n_97;
  wire mem_reg_3_n_98;
  wire mem_reg_3_n_99;
  wire p_1_in0_out;
  wire rstA;
  wire rstA_IBUF;
  wire rstB;
  wire rstB_IBUF;
  wire weA;
  wire weA_IBUF;
  wire weB;
  wire weB_IBUF;

  GND GND
       (.G(\<const0> ));
  VCC VCC
       (.P(\<const1> ));
  VCC VCC_1
       (.P(VCC_2));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \addrA_IBUF[0]_inst 
       (.I(addrA[0]),
        .O(addrA_IBUF[0]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \addrA_IBUF[10]_inst 
       (.I(addrA[10]),
        .O(addrA_IBUF[10]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \addrA_IBUF[11]_inst 
       (.I(addrA[11]),
        .O(addrA_IBUF[11]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \addrA_IBUF[1]_inst 
       (.I(addrA[1]),
        .O(addrA_IBUF[1]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \addrA_IBUF[2]_inst 
       (.I(addrA[2]),
        .O(addrA_IBUF[2]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \addrA_IBUF[3]_inst 
       (.I(addrA[3]),
        .O(addrA_IBUF[3]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \addrA_IBUF[4]_inst 
       (.I(addrA[4]),
        .O(addrA_IBUF[4]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \addrA_IBUF[5]_inst 
       (.I(addrA[5]),
        .O(addrA_IBUF[5]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \addrA_IBUF[6]_inst 
       (.I(addrA[6]),
        .O(addrA_IBUF[6]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \addrA_IBUF[7]_inst 
       (.I(addrA[7]),
        .O(addrA_IBUF[7]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \addrA_IBUF[8]_inst 
       (.I(addrA[8]),
        .O(addrA_IBUF[8]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \addrA_IBUF[9]_inst 
       (.I(addrA[9]),
        .O(addrA_IBUF[9]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \addrB_IBUF[0]_inst 
       (.I(addrB[0]),
        .O(addrB_IBUF[0]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \addrB_IBUF[10]_inst 
       (.I(addrB[10]),
        .O(addrB_IBUF[10]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \addrB_IBUF[11]_inst 
       (.I(addrB[11]),
        .O(addrB_IBUF[11]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \addrB_IBUF[1]_inst 
       (.I(addrB[1]),
        .O(addrB_IBUF[1]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \addrB_IBUF[2]_inst 
       (.I(addrB[2]),
        .O(addrB_IBUF[2]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \addrB_IBUF[3]_inst 
       (.I(addrB[3]),
        .O(addrB_IBUF[3]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \addrB_IBUF[4]_inst 
       (.I(addrB[4]),
        .O(addrB_IBUF[4]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \addrB_IBUF[5]_inst 
       (.I(addrB[5]),
        .O(addrB_IBUF[5]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \addrB_IBUF[6]_inst 
       (.I(addrB[6]),
        .O(addrB_IBUF[6]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \addrB_IBUF[7]_inst 
       (.I(addrB[7]),
        .O(addrB_IBUF[7]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \addrB_IBUF[8]_inst 
       (.I(addrB[8]),
        .O(addrB_IBUF[8]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \addrB_IBUF[9]_inst 
       (.I(addrB[9]),
        .O(addrB_IBUF[9]));
 // (* XILINX_LEGACY_PRIM = "BUFG" *) 
 // BUFGCE #(
 //   .CE_TYPE("ASYNC")) 
 //   clkA_IBUF_BUFG_inst
 //      (.CE(VCC_2),
 //       .I(clkA_IBUF),
 //       .O(clkA_IBUF_BUFG));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF clkA_IBUF_inst
       (.I(clkA),
        .O(clkA_IBUF_BUFG));
 // (* XILINX_LEGACY_PRIM = "BUFG" *) 
 // BUFGCE #(
 //   .CE_TYPE("ASYNC")) 
 //   clkB_IBUF_BUFG_inst
 //      (.CE(VCC_2),
 //       .I(clkB_IBUF),
 //       .O(clkB_IBUF_BUFG));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF clkB_IBUF_inst
       (.I(clkB),
        .O(clkB_IBUF_BUFG));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinA_IBUF[0]_inst 
       (.I(dinA[0]),
        .O(dinA_IBUF[0]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinA_IBUF[10]_inst 
       (.I(dinA[10]),
        .O(dinA_IBUF[10]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinA_IBUF[11]_inst 
       (.I(dinA[11]),
        .O(dinA_IBUF[11]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinA_IBUF[12]_inst 
       (.I(dinA[12]),
        .O(dinA_IBUF[12]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinA_IBUF[13]_inst 
       (.I(dinA[13]),
        .O(dinA_IBUF[13]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinA_IBUF[14]_inst 
       (.I(dinA[14]),
        .O(dinA_IBUF[14]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinA_IBUF[15]_inst 
       (.I(dinA[15]),
        .O(dinA_IBUF[15]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinA_IBUF[16]_inst 
       (.I(dinA[16]),
        .O(dinA_IBUF[16]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinA_IBUF[17]_inst 
       (.I(dinA[17]),
        .O(dinA_IBUF[17]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinA_IBUF[18]_inst 
       (.I(dinA[18]),
        .O(dinA_IBUF[18]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinA_IBUF[19]_inst 
       (.I(dinA[19]),
        .O(dinA_IBUF[19]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinA_IBUF[1]_inst 
       (.I(dinA[1]),
        .O(dinA_IBUF[1]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinA_IBUF[20]_inst 
       (.I(dinA[20]),
        .O(dinA_IBUF[20]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinA_IBUF[21]_inst 
       (.I(dinA[21]),
        .O(dinA_IBUF[21]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinA_IBUF[22]_inst 
       (.I(dinA[22]),
        .O(dinA_IBUF[22]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinA_IBUF[23]_inst 
       (.I(dinA[23]),
        .O(dinA_IBUF[23]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinA_IBUF[24]_inst 
       (.I(dinA[24]),
        .O(dinA_IBUF[24]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinA_IBUF[25]_inst 
       (.I(dinA[25]),
        .O(dinA_IBUF[25]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinA_IBUF[26]_inst 
       (.I(dinA[26]),
        .O(dinA_IBUF[26]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinA_IBUF[27]_inst 
       (.I(dinA[27]),
        .O(dinA_IBUF[27]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinA_IBUF[28]_inst 
       (.I(dinA[28]),
        .O(dinA_IBUF[28]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinA_IBUF[29]_inst 
       (.I(dinA[29]),
        .O(dinA_IBUF[29]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinA_IBUF[2]_inst 
       (.I(dinA[2]),
        .O(dinA_IBUF[2]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinA_IBUF[30]_inst 
       (.I(dinA[30]),
        .O(dinA_IBUF[30]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinA_IBUF[31]_inst 
       (.I(dinA[31]),
        .O(dinA_IBUF[31]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinA_IBUF[32]_inst 
       (.I(dinA[32]),
        .O(dinA_IBUF[32]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinA_IBUF[33]_inst 
       (.I(dinA[33]),
        .O(dinA_IBUF[33]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinA_IBUF[34]_inst 
       (.I(dinA[34]),
        .O(dinA_IBUF[34]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinA_IBUF[35]_inst 
       (.I(dinA[35]),
        .O(dinA_IBUF[35]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinA_IBUF[3]_inst 
       (.I(dinA[3]),
        .O(dinA_IBUF[3]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinA_IBUF[4]_inst 
       (.I(dinA[4]),
        .O(dinA_IBUF[4]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinA_IBUF[5]_inst 
       (.I(dinA[5]),
        .O(dinA_IBUF[5]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinA_IBUF[6]_inst 
       (.I(dinA[6]),
        .O(dinA_IBUF[6]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinA_IBUF[7]_inst 
       (.I(dinA[7]),
        .O(dinA_IBUF[7]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinA_IBUF[8]_inst 
       (.I(dinA[8]),
        .O(dinA_IBUF[8]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinA_IBUF[9]_inst 
       (.I(dinA[9]),
        .O(dinA_IBUF[9]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinB_IBUF[0]_inst 
       (.I(dinB[0]),
        .O(dinB_IBUF[0]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinB_IBUF[10]_inst 
       (.I(dinB[10]),
        .O(dinB_IBUF[10]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinB_IBUF[11]_inst 
       (.I(dinB[11]),
        .O(dinB_IBUF[11]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinB_IBUF[12]_inst 
       (.I(dinB[12]),
        .O(dinB_IBUF[12]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinB_IBUF[13]_inst 
       (.I(dinB[13]),
        .O(dinB_IBUF[13]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinB_IBUF[14]_inst 
       (.I(dinB[14]),
        .O(dinB_IBUF[14]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinB_IBUF[15]_inst 
       (.I(dinB[15]),
        .O(dinB_IBUF[15]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinB_IBUF[16]_inst 
       (.I(dinB[16]),
        .O(dinB_IBUF[16]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinB_IBUF[17]_inst 
       (.I(dinB[17]),
        .O(dinB_IBUF[17]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinB_IBUF[18]_inst 
       (.I(dinB[18]),
        .O(dinB_IBUF[18]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinB_IBUF[19]_inst 
       (.I(dinB[19]),
        .O(dinB_IBUF[19]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinB_IBUF[1]_inst 
       (.I(dinB[1]),
        .O(dinB_IBUF[1]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinB_IBUF[20]_inst 
       (.I(dinB[20]),
        .O(dinB_IBUF[20]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinB_IBUF[21]_inst 
       (.I(dinB[21]),
        .O(dinB_IBUF[21]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinB_IBUF[22]_inst 
       (.I(dinB[22]),
        .O(dinB_IBUF[22]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinB_IBUF[23]_inst 
       (.I(dinB[23]),
        .O(dinB_IBUF[23]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinB_IBUF[24]_inst 
       (.I(dinB[24]),
        .O(dinB_IBUF[24]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinB_IBUF[25]_inst 
       (.I(dinB[25]),
        .O(dinB_IBUF[25]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinB_IBUF[26]_inst 
       (.I(dinB[26]),
        .O(dinB_IBUF[26]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinB_IBUF[27]_inst 
       (.I(dinB[27]),
        .O(dinB_IBUF[27]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinB_IBUF[28]_inst 
       (.I(dinB[28]),
        .O(dinB_IBUF[28]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinB_IBUF[29]_inst 
       (.I(dinB[29]),
        .O(dinB_IBUF[29]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinB_IBUF[2]_inst 
       (.I(dinB[2]),
        .O(dinB_IBUF[2]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinB_IBUF[30]_inst 
       (.I(dinB[30]),
        .O(dinB_IBUF[30]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinB_IBUF[31]_inst 
       (.I(dinB[31]),
        .O(dinB_IBUF[31]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinB_IBUF[32]_inst 
       (.I(dinB[32]),
        .O(dinB_IBUF[32]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinB_IBUF[33]_inst 
       (.I(dinB[33]),
        .O(dinB_IBUF[33]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinB_IBUF[34]_inst 
       (.I(dinB[34]),
        .O(dinB_IBUF[34]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinB_IBUF[35]_inst 
       (.I(dinB[35]),
        .O(dinB_IBUF[35]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinB_IBUF[3]_inst 
       (.I(dinB[3]),
        .O(dinB_IBUF[3]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinB_IBUF[4]_inst 
       (.I(dinB[4]),
        .O(dinB_IBUF[4]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinB_IBUF[5]_inst 
       (.I(dinB[5]),
        .O(dinB_IBUF[5]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinB_IBUF[6]_inst 
       (.I(dinB[6]),
        .O(dinB_IBUF[6]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinB_IBUF[7]_inst 
       (.I(dinB[7]),
        .O(dinB_IBUF[7]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinB_IBUF[8]_inst 
       (.I(dinB[8]),
        .O(dinB_IBUF[8]));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF \dinB_IBUF[9]_inst 
       (.I(dinB[9]),
        .O(dinB_IBUF[9]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutA[0]_i_1 
       (.I0(mem_reg_0_n_131),
        .I1(\doutA_reg[35]_i_3_n_0 ),
        .I2(\doutA_reg[0]_i_2_n_0 ),
        .O(doutA_1[0]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutA[10]_i_1 
       (.I0(mem_reg_1_n_130),
        .I1(\doutA_reg[35]_i_3_n_0 ),
        .I2(\doutA_reg[10]_i_2_n_0 ),
        .O(doutA_1[10]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutA[11]_i_1 
       (.I0(mem_reg_1_n_129),
        .I1(\doutA_reg[35]_i_3_n_0 ),
        .I2(\doutA_reg[11]_i_2_n_0 ),
        .O(doutA_1[11]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutA[12]_i_1 
       (.I0(mem_reg_1_n_128),
        .I1(\doutA_reg[35]_i_3_n_0 ),
        .I2(\doutA_reg[12]_i_2_n_0 ),
        .O(doutA_1[12]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutA[13]_i_1 
       (.I0(mem_reg_1_n_127),
        .I1(\doutA_reg[35]_i_3_n_0 ),
        .I2(\doutA_reg[13]_i_2_n_0 ),
        .O(doutA_1[13]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutA[14]_i_1 
       (.I0(mem_reg_1_n_126),
        .I1(\doutA_reg[35]_i_3_n_0 ),
        .I2(\doutA_reg[14]_i_2_n_0 ),
        .O(doutA_1[14]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutA[15]_i_1 
       (.I0(mem_reg_1_n_125),
        .I1(\doutA_reg[35]_i_3_n_0 ),
        .I2(\doutA_reg[15]_i_2_n_0 ),
        .O(doutA_1[15]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutA[16]_i_1 
       (.I0(mem_reg_1_n_124),
        .I1(\doutA_reg[35]_i_3_n_0 ),
        .I2(\doutA_reg[16]_i_2_n_0 ),
        .O(doutA_1[16]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutA[17]_i_1 
       (.I0(mem_reg_1_n_147),
        .I1(\doutA_reg[35]_i_3_n_0 ),
        .I2(\doutA_reg[17]_i_2_n_0 ),
        .O(doutA_1[17]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutA[18]_i_1 
       (.I0(mem_reg_2_n_131),
        .I1(\doutA_reg[35]_i_3_n_0 ),
        .I2(\doutA_reg[18]_i_2_n_0 ),
        .O(doutA_1[18]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutA[19]_i_1 
       (.I0(mem_reg_2_n_130),
        .I1(\doutA_reg[35]_i_3_n_0 ),
        .I2(\doutA_reg[19]_i_2_n_0 ),
        .O(doutA_1[19]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutA[1]_i_1 
       (.I0(mem_reg_0_n_130),
        .I1(\doutA_reg[35]_i_3_n_0 ),
        .I2(\doutA_reg[1]_i_2_n_0 ),
        .O(doutA_1[1]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutA[20]_i_1 
       (.I0(mem_reg_2_n_129),
        .I1(\doutA_reg[35]_i_3_n_0 ),
        .I2(\doutA_reg[20]_i_2_n_0 ),
        .O(doutA_1[20]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutA[21]_i_1 
       (.I0(mem_reg_2_n_128),
        .I1(\doutA_reg[35]_i_3_n_0 ),
        .I2(\doutA_reg[21]_i_2_n_0 ),
        .O(doutA_1[21]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutA[22]_i_1 
       (.I0(mem_reg_2_n_127),
        .I1(\doutA_reg[35]_i_3_n_0 ),
        .I2(\doutA_reg[22]_i_2_n_0 ),
        .O(doutA_1[22]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutA[23]_i_1 
       (.I0(mem_reg_2_n_126),
        .I1(\doutA_reg[35]_i_3_n_0 ),
        .I2(\doutA_reg[23]_i_2_n_0 ),
        .O(doutA_1[23]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutA[24]_i_1 
       (.I0(mem_reg_2_n_125),
        .I1(\doutA_reg[35]_i_3_n_0 ),
        .I2(\doutA_reg[24]_i_2_n_0 ),
        .O(doutA_1[24]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutA[25]_i_1 
       (.I0(mem_reg_2_n_124),
        .I1(\doutA_reg[35]_i_3_n_0 ),
        .I2(\doutA_reg[25]_i_2_n_0 ),
        .O(doutA_1[25]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutA[26]_i_1 
       (.I0(mem_reg_2_n_147),
        .I1(\doutA_reg[35]_i_3_n_0 ),
        .I2(\doutA_reg[26]_i_2_n_0 ),
        .O(doutA_1[26]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutA[27]_i_1 
       (.I0(mem_reg_3_n_131),
        .I1(\doutA_reg[35]_i_3_n_0 ),
        .I2(\doutA_reg[27]_i_2_n_0 ),
        .O(doutA_1[27]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutA[28]_i_1 
       (.I0(mem_reg_3_n_130),
        .I1(\doutA_reg[35]_i_3_n_0 ),
        .I2(\doutA_reg[28]_i_2_n_0 ),
        .O(doutA_1[28]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutA[29]_i_1 
       (.I0(mem_reg_3_n_129),
        .I1(\doutA_reg[35]_i_3_n_0 ),
        .I2(\doutA_reg[29]_i_2_n_0 ),
        .O(doutA_1[29]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutA[2]_i_1 
       (.I0(mem_reg_0_n_129),
        .I1(\doutA_reg[35]_i_3_n_0 ),
        .I2(\doutA_reg[2]_i_2_n_0 ),
        .O(doutA_1[2]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutA[30]_i_1 
       (.I0(mem_reg_3_n_128),
        .I1(\doutA_reg[35]_i_3_n_0 ),
        .I2(\doutA_reg[30]_i_2_n_0 ),
        .O(doutA_1[30]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutA[31]_i_1 
       (.I0(mem_reg_3_n_127),
        .I1(\doutA_reg[35]_i_3_n_0 ),
        .I2(\doutA_reg[31]_i_2_n_0 ),
        .O(doutA_1[31]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutA[32]_i_1 
       (.I0(mem_reg_3_n_126),
        .I1(\doutA_reg[35]_i_3_n_0 ),
        .I2(\doutA_reg[32]_i_2_n_0 ),
        .O(doutA_1[32]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutA[33]_i_1 
       (.I0(mem_reg_3_n_125),
        .I1(\doutA_reg[35]_i_3_n_0 ),
        .I2(\doutA_reg[33]_i_2_n_0 ),
        .O(doutA_1[33]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutA[34]_i_1 
       (.I0(mem_reg_3_n_124),
        .I1(\doutA_reg[35]_i_3_n_0 ),
        .I2(\doutA_reg[34]_i_2_n_0 ),
        .O(doutA_1[34]));
  LUT2 #(
    .INIT(4'h8)) 
    \doutA[35]_i_1 
       (.I0(weA_IBUF),
        .I1(enA_IBUF),
        .O(doutA0));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutA[35]_i_2 
       (.I0(mem_reg_3_n_147),
        .I1(\doutA_reg[35]_i_3_n_0 ),
        .I2(\doutA_reg[35]_i_4_n_0 ),
        .O(doutA_1[35]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutA[3]_i_1 
       (.I0(mem_reg_0_n_128),
        .I1(\doutA_reg[35]_i_3_n_0 ),
        .I2(\doutA_reg[3]_i_2_n_0 ),
        .O(doutA_1[3]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutA[4]_i_1 
       (.I0(mem_reg_0_n_127),
        .I1(\doutA_reg[35]_i_3_n_0 ),
        .I2(\doutA_reg[4]_i_2_n_0 ),
        .O(doutA_1[4]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutA[5]_i_1 
       (.I0(mem_reg_0_n_126),
        .I1(\doutA_reg[35]_i_3_n_0 ),
        .I2(\doutA_reg[5]_i_2_n_0 ),
        .O(doutA_1[5]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutA[6]_i_1 
       (.I0(mem_reg_0_n_125),
        .I1(\doutA_reg[35]_i_3_n_0 ),
        .I2(\doutA_reg[6]_i_2_n_0 ),
        .O(doutA_1[6]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutA[7]_i_1 
       (.I0(mem_reg_0_n_124),
        .I1(\doutA_reg[35]_i_3_n_0 ),
        .I2(\doutA_reg[7]_i_2_n_0 ),
        .O(doutA_1[7]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutA[8]_i_1 
       (.I0(mem_reg_0_n_147),
        .I1(\doutA_reg[35]_i_3_n_0 ),
        .I2(\doutA_reg[8]_i_2_n_0 ),
        .O(doutA_1[8]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutA[9]_i_1 
       (.I0(mem_reg_1_n_131),
        .I1(\doutA_reg[35]_i_3_n_0 ),
        .I2(\doutA_reg[9]_i_2_n_0 ),
        .O(doutA_1[9]));
  OBUF \doutA_OBUF[0]_inst 
       (.I(doutA_OBUF[0]),
        .O(doutA[0]));
  OBUF \doutA_OBUF[10]_inst 
       (.I(doutA_OBUF[10]),
        .O(doutA[10]));
  OBUF \doutA_OBUF[11]_inst 
       (.I(doutA_OBUF[11]),
        .O(doutA[11]));
  OBUF \doutA_OBUF[12]_inst 
       (.I(doutA_OBUF[12]),
        .O(doutA[12]));
  OBUF \doutA_OBUF[13]_inst 
       (.I(doutA_OBUF[13]),
        .O(doutA[13]));
  OBUF \doutA_OBUF[14]_inst 
       (.I(doutA_OBUF[14]),
        .O(doutA[14]));
  OBUF \doutA_OBUF[15]_inst 
       (.I(doutA_OBUF[15]),
        .O(doutA[15]));
  OBUF \doutA_OBUF[16]_inst 
       (.I(doutA_OBUF[16]),
        .O(doutA[16]));
  OBUF \doutA_OBUF[17]_inst 
       (.I(doutA_OBUF[17]),
        .O(doutA[17]));
  OBUF \doutA_OBUF[18]_inst 
       (.I(doutA_OBUF[18]),
        .O(doutA[18]));
  OBUF \doutA_OBUF[19]_inst 
       (.I(doutA_OBUF[19]),
        .O(doutA[19]));
  OBUF \doutA_OBUF[1]_inst 
       (.I(doutA_OBUF[1]),
        .O(doutA[1]));
  OBUF \doutA_OBUF[20]_inst 
       (.I(doutA_OBUF[20]),
        .O(doutA[20]));
  OBUF \doutA_OBUF[21]_inst 
       (.I(doutA_OBUF[21]),
        .O(doutA[21]));
  OBUF \doutA_OBUF[22]_inst 
       (.I(doutA_OBUF[22]),
        .O(doutA[22]));
  OBUF \doutA_OBUF[23]_inst 
       (.I(doutA_OBUF[23]),
        .O(doutA[23]));
  OBUF \doutA_OBUF[24]_inst 
       (.I(doutA_OBUF[24]),
        .O(doutA[24]));
  OBUF \doutA_OBUF[25]_inst 
       (.I(doutA_OBUF[25]),
        .O(doutA[25]));
  OBUF \doutA_OBUF[26]_inst 
       (.I(doutA_OBUF[26]),
        .O(doutA[26]));
  OBUF \doutA_OBUF[27]_inst 
       (.I(doutA_OBUF[27]),
        .O(doutA[27]));
  OBUF \doutA_OBUF[28]_inst 
       (.I(doutA_OBUF[28]),
        .O(doutA[28]));
  OBUF \doutA_OBUF[29]_inst 
       (.I(doutA_OBUF[29]),
        .O(doutA[29]));
  OBUF \doutA_OBUF[2]_inst 
       (.I(doutA_OBUF[2]),
        .O(doutA[2]));
  OBUF \doutA_OBUF[30]_inst 
       (.I(doutA_OBUF[30]),
        .O(doutA[30]));
  OBUF \doutA_OBUF[31]_inst 
       (.I(doutA_OBUF[31]),
        .O(doutA[31]));
  OBUF \doutA_OBUF[32]_inst 
       (.I(doutA_OBUF[32]),
        .O(doutA[32]));
  OBUF \doutA_OBUF[33]_inst 
       (.I(doutA_OBUF[33]),
        .O(doutA[33]));
  OBUF \doutA_OBUF[34]_inst 
       (.I(doutA_OBUF[34]),
        .O(doutA[34]));
  OBUF \doutA_OBUF[35]_inst 
       (.I(doutA_OBUF[35]),
        .O(doutA[35]));
  OBUF \doutA_OBUF[3]_inst 
       (.I(doutA_OBUF[3]),
        .O(doutA[3]));
  OBUF \doutA_OBUF[4]_inst 
       (.I(doutA_OBUF[4]),
        .O(doutA[4]));
  OBUF \doutA_OBUF[5]_inst 
       (.I(doutA_OBUF[5]),
        .O(doutA[5]));
  OBUF \doutA_OBUF[6]_inst 
       (.I(doutA_OBUF[6]),
        .O(doutA[6]));
  OBUF \doutA_OBUF[7]_inst 
       (.I(doutA_OBUF[7]),
        .O(doutA[7]));
  OBUF \doutA_OBUF[8]_inst 
       (.I(doutA_OBUF[8]),
        .O(doutA[8]));
  OBUF \doutA_OBUF[9]_inst 
       (.I(doutA_OBUF[9]),
        .O(doutA[9]));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[0] 
       (.C(clkA_IBUF_BUFG),
        .CE(doutA0),
        .D(doutA_1[0]),
        .Q(doutA_OBUF[0]),
        .R(rstA_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[0]_i_2 
       (.C(clkA_IBUF_BUFG),
        .CE(\doutA_reg[35]_i_3_n_0 ),
        .D(mem_reg_0_n_131),
        .Q(\doutA_reg[0]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[10] 
       (.C(clkA_IBUF_BUFG),
        .CE(doutA0),
        .D(doutA_1[10]),
        .Q(doutA_OBUF[10]),
        .R(rstA_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[10]_i_2 
       (.C(clkA_IBUF_BUFG),
        .CE(\doutA_reg[35]_i_3_n_0 ),
        .D(mem_reg_1_n_130),
        .Q(\doutA_reg[10]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[11] 
       (.C(clkA_IBUF_BUFG),
        .CE(doutA0),
        .D(doutA_1[11]),
        .Q(doutA_OBUF[11]),
        .R(rstA_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[11]_i_2 
       (.C(clkA_IBUF_BUFG),
        .CE(\doutA_reg[35]_i_3_n_0 ),
        .D(mem_reg_1_n_129),
        .Q(\doutA_reg[11]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[12] 
       (.C(clkA_IBUF_BUFG),
        .CE(doutA0),
        .D(doutA_1[12]),
        .Q(doutA_OBUF[12]),
        .R(rstA_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[12]_i_2 
       (.C(clkA_IBUF_BUFG),
        .CE(\doutA_reg[35]_i_3_n_0 ),
        .D(mem_reg_1_n_128),
        .Q(\doutA_reg[12]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[13] 
       (.C(clkA_IBUF_BUFG),
        .CE(doutA0),
        .D(doutA_1[13]),
        .Q(doutA_OBUF[13]),
        .R(rstA_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[13]_i_2 
       (.C(clkA_IBUF_BUFG),
        .CE(\doutA_reg[35]_i_3_n_0 ),
        .D(mem_reg_1_n_127),
        .Q(\doutA_reg[13]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[14] 
       (.C(clkA_IBUF_BUFG),
        .CE(doutA0),
        .D(doutA_1[14]),
        .Q(doutA_OBUF[14]),
        .R(rstA_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[14]_i_2 
       (.C(clkA_IBUF_BUFG),
        .CE(\doutA_reg[35]_i_3_n_0 ),
        .D(mem_reg_1_n_126),
        .Q(\doutA_reg[14]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[15] 
       (.C(clkA_IBUF_BUFG),
        .CE(doutA0),
        .D(doutA_1[15]),
        .Q(doutA_OBUF[15]),
        .R(rstA_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[15]_i_2 
       (.C(clkA_IBUF_BUFG),
        .CE(\doutA_reg[35]_i_3_n_0 ),
        .D(mem_reg_1_n_125),
        .Q(\doutA_reg[15]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[16] 
       (.C(clkA_IBUF_BUFG),
        .CE(doutA0),
        .D(doutA_1[16]),
        .Q(doutA_OBUF[16]),
        .R(rstA_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[16]_i_2 
       (.C(clkA_IBUF_BUFG),
        .CE(\doutA_reg[35]_i_3_n_0 ),
        .D(mem_reg_1_n_124),
        .Q(\doutA_reg[16]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[17] 
       (.C(clkA_IBUF_BUFG),
        .CE(doutA0),
        .D(doutA_1[17]),
        .Q(doutA_OBUF[17]),
        .R(rstA_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[17]_i_2 
       (.C(clkA_IBUF_BUFG),
        .CE(\doutA_reg[35]_i_3_n_0 ),
        .D(mem_reg_1_n_147),
        .Q(\doutA_reg[17]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[18] 
       (.C(clkA_IBUF_BUFG),
        .CE(doutA0),
        .D(doutA_1[18]),
        .Q(doutA_OBUF[18]),
        .R(rstA_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[18]_i_2 
       (.C(clkA_IBUF_BUFG),
        .CE(\doutA_reg[35]_i_3_n_0 ),
        .D(mem_reg_2_n_131),
        .Q(\doutA_reg[18]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[19] 
       (.C(clkA_IBUF_BUFG),
        .CE(doutA0),
        .D(doutA_1[19]),
        .Q(doutA_OBUF[19]),
        .R(rstA_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[19]_i_2 
       (.C(clkA_IBUF_BUFG),
        .CE(\doutA_reg[35]_i_3_n_0 ),
        .D(mem_reg_2_n_130),
        .Q(\doutA_reg[19]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[1] 
       (.C(clkA_IBUF_BUFG),
        .CE(doutA0),
        .D(doutA_1[1]),
        .Q(doutA_OBUF[1]),
        .R(rstA_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[1]_i_2 
       (.C(clkA_IBUF_BUFG),
        .CE(\doutA_reg[35]_i_3_n_0 ),
        .D(mem_reg_0_n_130),
        .Q(\doutA_reg[1]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[20] 
       (.C(clkA_IBUF_BUFG),
        .CE(doutA0),
        .D(doutA_1[20]),
        .Q(doutA_OBUF[20]),
        .R(rstA_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[20]_i_2 
       (.C(clkA_IBUF_BUFG),
        .CE(\doutA_reg[35]_i_3_n_0 ),
        .D(mem_reg_2_n_129),
        .Q(\doutA_reg[20]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[21] 
       (.C(clkA_IBUF_BUFG),
        .CE(doutA0),
        .D(doutA_1[21]),
        .Q(doutA_OBUF[21]),
        .R(rstA_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[21]_i_2 
       (.C(clkA_IBUF_BUFG),
        .CE(\doutA_reg[35]_i_3_n_0 ),
        .D(mem_reg_2_n_128),
        .Q(\doutA_reg[21]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[22] 
       (.C(clkA_IBUF_BUFG),
        .CE(doutA0),
        .D(doutA_1[22]),
        .Q(doutA_OBUF[22]),
        .R(rstA_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[22]_i_2 
       (.C(clkA_IBUF_BUFG),
        .CE(\doutA_reg[35]_i_3_n_0 ),
        .D(mem_reg_2_n_127),
        .Q(\doutA_reg[22]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[23] 
       (.C(clkA_IBUF_BUFG),
        .CE(doutA0),
        .D(doutA_1[23]),
        .Q(doutA_OBUF[23]),
        .R(rstA_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[23]_i_2 
       (.C(clkA_IBUF_BUFG),
        .CE(\doutA_reg[35]_i_3_n_0 ),
        .D(mem_reg_2_n_126),
        .Q(\doutA_reg[23]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[24] 
       (.C(clkA_IBUF_BUFG),
        .CE(doutA0),
        .D(doutA_1[24]),
        .Q(doutA_OBUF[24]),
        .R(rstA_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[24]_i_2 
       (.C(clkA_IBUF_BUFG),
        .CE(\doutA_reg[35]_i_3_n_0 ),
        .D(mem_reg_2_n_125),
        .Q(\doutA_reg[24]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[25] 
       (.C(clkA_IBUF_BUFG),
        .CE(doutA0),
        .D(doutA_1[25]),
        .Q(doutA_OBUF[25]),
        .R(rstA_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[25]_i_2 
       (.C(clkA_IBUF_BUFG),
        .CE(\doutA_reg[35]_i_3_n_0 ),
        .D(mem_reg_2_n_124),
        .Q(\doutA_reg[25]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[26] 
       (.C(clkA_IBUF_BUFG),
        .CE(doutA0),
        .D(doutA_1[26]),
        .Q(doutA_OBUF[26]),
        .R(rstA_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[26]_i_2 
       (.C(clkA_IBUF_BUFG),
        .CE(\doutA_reg[35]_i_3_n_0 ),
        .D(mem_reg_2_n_147),
        .Q(\doutA_reg[26]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[27] 
       (.C(clkA_IBUF_BUFG),
        .CE(doutA0),
        .D(doutA_1[27]),
        .Q(doutA_OBUF[27]),
        .R(rstA_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[27]_i_2 
       (.C(clkA_IBUF_BUFG),
        .CE(\doutA_reg[35]_i_3_n_0 ),
        .D(mem_reg_3_n_131),
        .Q(\doutA_reg[27]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[28] 
       (.C(clkA_IBUF_BUFG),
        .CE(doutA0),
        .D(doutA_1[28]),
        .Q(doutA_OBUF[28]),
        .R(rstA_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[28]_i_2 
       (.C(clkA_IBUF_BUFG),
        .CE(\doutA_reg[35]_i_3_n_0 ),
        .D(mem_reg_3_n_130),
        .Q(\doutA_reg[28]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[29] 
       (.C(clkA_IBUF_BUFG),
        .CE(doutA0),
        .D(doutA_1[29]),
        .Q(doutA_OBUF[29]),
        .R(rstA_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[29]_i_2 
       (.C(clkA_IBUF_BUFG),
        .CE(\doutA_reg[35]_i_3_n_0 ),
        .D(mem_reg_3_n_129),
        .Q(\doutA_reg[29]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[2] 
       (.C(clkA_IBUF_BUFG),
        .CE(doutA0),
        .D(doutA_1[2]),
        .Q(doutA_OBUF[2]),
        .R(rstA_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[2]_i_2 
       (.C(clkA_IBUF_BUFG),
        .CE(\doutA_reg[35]_i_3_n_0 ),
        .D(mem_reg_0_n_129),
        .Q(\doutA_reg[2]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[30] 
       (.C(clkA_IBUF_BUFG),
        .CE(doutA0),
        .D(doutA_1[30]),
        .Q(doutA_OBUF[30]),
        .R(rstA_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[30]_i_2 
       (.C(clkA_IBUF_BUFG),
        .CE(\doutA_reg[35]_i_3_n_0 ),
        .D(mem_reg_3_n_128),
        .Q(\doutA_reg[30]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[31] 
       (.C(clkA_IBUF_BUFG),
        .CE(doutA0),
        .D(doutA_1[31]),
        .Q(doutA_OBUF[31]),
        .R(rstA_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[31]_i_2 
       (.C(clkA_IBUF_BUFG),
        .CE(\doutA_reg[35]_i_3_n_0 ),
        .D(mem_reg_3_n_127),
        .Q(\doutA_reg[31]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[32] 
       (.C(clkA_IBUF_BUFG),
        .CE(doutA0),
        .D(doutA_1[32]),
        .Q(doutA_OBUF[32]),
        .R(rstA_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[32]_i_2 
       (.C(clkA_IBUF_BUFG),
        .CE(\doutA_reg[35]_i_3_n_0 ),
        .D(mem_reg_3_n_126),
        .Q(\doutA_reg[32]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[33] 
       (.C(clkA_IBUF_BUFG),
        .CE(doutA0),
        .D(doutA_1[33]),
        .Q(doutA_OBUF[33]),
        .R(rstA_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[33]_i_2 
       (.C(clkA_IBUF_BUFG),
        .CE(\doutA_reg[35]_i_3_n_0 ),
        .D(mem_reg_3_n_125),
        .Q(\doutA_reg[33]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[34] 
       (.C(clkA_IBUF_BUFG),
        .CE(doutA0),
        .D(doutA_1[34]),
        .Q(doutA_OBUF[34]),
        .R(rstA_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[34]_i_2 
       (.C(clkA_IBUF_BUFG),
        .CE(\doutA_reg[35]_i_3_n_0 ),
        .D(mem_reg_3_n_124),
        .Q(\doutA_reg[34]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[35] 
       (.C(clkA_IBUF_BUFG),
        .CE(doutA0),
        .D(doutA_1[35]),
        .Q(doutA_OBUF[35]),
        .R(rstA_IBUF));
  FDRE #(
    .INIT(1'b1)) 
    \doutA_reg[35]_i_3 
       (.C(clkA_IBUF_BUFG),
        .CE(\<const1> ),
        .D(mem_reg_0_i_2_n_0),
        .Q(\doutA_reg[35]_i_3_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[35]_i_4 
       (.C(clkA_IBUF_BUFG),
        .CE(\doutA_reg[35]_i_3_n_0 ),
        .D(mem_reg_3_n_147),
        .Q(\doutA_reg[35]_i_4_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[3] 
       (.C(clkA_IBUF_BUFG),
        .CE(doutA0),
        .D(doutA_1[3]),
        .Q(doutA_OBUF[3]),
        .R(rstA_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[3]_i_2 
       (.C(clkA_IBUF_BUFG),
        .CE(\doutA_reg[35]_i_3_n_0 ),
        .D(mem_reg_0_n_128),
        .Q(\doutA_reg[3]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[4] 
       (.C(clkA_IBUF_BUFG),
        .CE(doutA0),
        .D(doutA_1[4]),
        .Q(doutA_OBUF[4]),
        .R(rstA_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[4]_i_2 
       (.C(clkA_IBUF_BUFG),
        .CE(\doutA_reg[35]_i_3_n_0 ),
        .D(mem_reg_0_n_127),
        .Q(\doutA_reg[4]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[5] 
       (.C(clkA_IBUF_BUFG),
        .CE(doutA0),
        .D(doutA_1[5]),
        .Q(doutA_OBUF[5]),
        .R(rstA_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[5]_i_2 
       (.C(clkA_IBUF_BUFG),
        .CE(\doutA_reg[35]_i_3_n_0 ),
        .D(mem_reg_0_n_126),
        .Q(\doutA_reg[5]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[6] 
       (.C(clkA_IBUF_BUFG),
        .CE(doutA0),
        .D(doutA_1[6]),
        .Q(doutA_OBUF[6]),
        .R(rstA_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[6]_i_2 
       (.C(clkA_IBUF_BUFG),
        .CE(\doutA_reg[35]_i_3_n_0 ),
        .D(mem_reg_0_n_125),
        .Q(\doutA_reg[6]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[7] 
       (.C(clkA_IBUF_BUFG),
        .CE(doutA0),
        .D(doutA_1[7]),
        .Q(doutA_OBUF[7]),
        .R(rstA_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[7]_i_2 
       (.C(clkA_IBUF_BUFG),
        .CE(\doutA_reg[35]_i_3_n_0 ),
        .D(mem_reg_0_n_124),
        .Q(\doutA_reg[7]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[8] 
       (.C(clkA_IBUF_BUFG),
        .CE(doutA0),
        .D(doutA_1[8]),
        .Q(doutA_OBUF[8]),
        .R(rstA_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[8]_i_2 
       (.C(clkA_IBUF_BUFG),
        .CE(\doutA_reg[35]_i_3_n_0 ),
        .D(mem_reg_0_n_147),
        .Q(\doutA_reg[8]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[9] 
       (.C(clkA_IBUF_BUFG),
        .CE(doutA0),
        .D(doutA_1[9]),
        .Q(doutA_OBUF[9]),
        .R(rstA_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutA_reg[9]_i_2 
       (.C(clkA_IBUF_BUFG),
        .CE(\doutA_reg[35]_i_3_n_0 ),
        .D(mem_reg_1_n_131),
        .Q(\doutA_reg[9]_i_2_n_0 ),
        .R(\<const0> ));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutB[0]_i_1 
       (.I0(mem_reg_0_n_99),
        .I1(\doutB_reg[35]_i_3_n_0 ),
        .I2(\doutB_reg[0]_i_2_n_0 ),
        .O(doutB_1[0]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutB[10]_i_1 
       (.I0(mem_reg_1_n_98),
        .I1(\doutB_reg[35]_i_3_n_0 ),
        .I2(\doutB_reg[10]_i_2_n_0 ),
        .O(doutB_1[10]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutB[11]_i_1 
       (.I0(mem_reg_1_n_97),
        .I1(\doutB_reg[35]_i_3_n_0 ),
        .I2(\doutB_reg[11]_i_2_n_0 ),
        .O(doutB_1[11]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutB[12]_i_1 
       (.I0(mem_reg_1_n_96),
        .I1(\doutB_reg[35]_i_3_n_0 ),
        .I2(\doutB_reg[12]_i_2_n_0 ),
        .O(doutB_1[12]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutB[13]_i_1 
       (.I0(mem_reg_1_n_95),
        .I1(\doutB_reg[35]_i_3_n_0 ),
        .I2(\doutB_reg[13]_i_2_n_0 ),
        .O(doutB_1[13]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutB[14]_i_1 
       (.I0(mem_reg_1_n_94),
        .I1(\doutB_reg[35]_i_3_n_0 ),
        .I2(\doutB_reg[14]_i_2_n_0 ),
        .O(doutB_1[14]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutB[15]_i_1 
       (.I0(mem_reg_1_n_93),
        .I1(\doutB_reg[35]_i_3_n_0 ),
        .I2(\doutB_reg[15]_i_2_n_0 ),
        .O(doutB_1[15]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutB[16]_i_1 
       (.I0(mem_reg_1_n_92),
        .I1(\doutB_reg[35]_i_3_n_0 ),
        .I2(\doutB_reg[16]_i_2_n_0 ),
        .O(doutB_1[16]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutB[17]_i_1 
       (.I0(mem_reg_1_n_143),
        .I1(\doutB_reg[35]_i_3_n_0 ),
        .I2(\doutB_reg[17]_i_2_n_0 ),
        .O(doutB_1[17]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutB[18]_i_1 
       (.I0(mem_reg_2_n_99),
        .I1(\doutB_reg[35]_i_3_n_0 ),
        .I2(\doutB_reg[18]_i_2_n_0 ),
        .O(doutB_1[18]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutB[19]_i_1 
       (.I0(mem_reg_2_n_98),
        .I1(\doutB_reg[35]_i_3_n_0 ),
        .I2(\doutB_reg[19]_i_2_n_0 ),
        .O(doutB_1[19]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutB[1]_i_1 
       (.I0(mem_reg_0_n_98),
        .I1(\doutB_reg[35]_i_3_n_0 ),
        .I2(\doutB_reg[1]_i_2_n_0 ),
        .O(doutB_1[1]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutB[20]_i_1 
       (.I0(mem_reg_2_n_97),
        .I1(\doutB_reg[35]_i_3_n_0 ),
        .I2(\doutB_reg[20]_i_2_n_0 ),
        .O(doutB_1[20]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutB[21]_i_1 
       (.I0(mem_reg_2_n_96),
        .I1(\doutB_reg[35]_i_3_n_0 ),
        .I2(\doutB_reg[21]_i_2_n_0 ),
        .O(doutB_1[21]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutB[22]_i_1 
       (.I0(mem_reg_2_n_95),
        .I1(\doutB_reg[35]_i_3_n_0 ),
        .I2(\doutB_reg[22]_i_2_n_0 ),
        .O(doutB_1[22]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutB[23]_i_1 
       (.I0(mem_reg_2_n_94),
        .I1(\doutB_reg[35]_i_3_n_0 ),
        .I2(\doutB_reg[23]_i_2_n_0 ),
        .O(doutB_1[23]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutB[24]_i_1 
       (.I0(mem_reg_2_n_93),
        .I1(\doutB_reg[35]_i_3_n_0 ),
        .I2(\doutB_reg[24]_i_2_n_0 ),
        .O(doutB_1[24]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutB[25]_i_1 
       (.I0(mem_reg_2_n_92),
        .I1(\doutB_reg[35]_i_3_n_0 ),
        .I2(\doutB_reg[25]_i_2_n_0 ),
        .O(doutB_1[25]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutB[26]_i_1 
       (.I0(mem_reg_2_n_143),
        .I1(\doutB_reg[35]_i_3_n_0 ),
        .I2(\doutB_reg[26]_i_2_n_0 ),
        .O(doutB_1[26]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutB[27]_i_1 
       (.I0(mem_reg_3_n_99),
        .I1(\doutB_reg[35]_i_3_n_0 ),
        .I2(\doutB_reg[27]_i_2_n_0 ),
        .O(doutB_1[27]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutB[28]_i_1 
       (.I0(mem_reg_3_n_98),
        .I1(\doutB_reg[35]_i_3_n_0 ),
        .I2(\doutB_reg[28]_i_2_n_0 ),
        .O(doutB_1[28]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutB[29]_i_1 
       (.I0(mem_reg_3_n_97),
        .I1(\doutB_reg[35]_i_3_n_0 ),
        .I2(\doutB_reg[29]_i_2_n_0 ),
        .O(doutB_1[29]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutB[2]_i_1 
       (.I0(mem_reg_0_n_97),
        .I1(\doutB_reg[35]_i_3_n_0 ),
        .I2(\doutB_reg[2]_i_2_n_0 ),
        .O(doutB_1[2]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutB[30]_i_1 
       (.I0(mem_reg_3_n_96),
        .I1(\doutB_reg[35]_i_3_n_0 ),
        .I2(\doutB_reg[30]_i_2_n_0 ),
        .O(doutB_1[30]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutB[31]_i_1 
       (.I0(mem_reg_3_n_95),
        .I1(\doutB_reg[35]_i_3_n_0 ),
        .I2(\doutB_reg[31]_i_2_n_0 ),
        .O(doutB_1[31]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutB[32]_i_1 
       (.I0(mem_reg_3_n_94),
        .I1(\doutB_reg[35]_i_3_n_0 ),
        .I2(\doutB_reg[32]_i_2_n_0 ),
        .O(doutB_1[32]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutB[33]_i_1 
       (.I0(mem_reg_3_n_93),
        .I1(\doutB_reg[35]_i_3_n_0 ),
        .I2(\doutB_reg[33]_i_2_n_0 ),
        .O(doutB_1[33]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutB[34]_i_1 
       (.I0(mem_reg_3_n_92),
        .I1(\doutB_reg[35]_i_3_n_0 ),
        .I2(\doutB_reg[34]_i_2_n_0 ),
        .O(doutB_1[34]));
  LUT2 #(
    .INIT(4'h8)) 
    \doutB[35]_i_1 
       (.I0(weB_IBUF),
        .I1(enB_IBUF),
        .O(doutB0));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutB[35]_i_2 
       (.I0(mem_reg_3_n_143),
        .I1(\doutB_reg[35]_i_3_n_0 ),
        .I2(\doutB_reg[35]_i_4_n_0 ),
        .O(doutB_1[35]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutB[3]_i_1 
       (.I0(mem_reg_0_n_96),
        .I1(\doutB_reg[35]_i_3_n_0 ),
        .I2(\doutB_reg[3]_i_2_n_0 ),
        .O(doutB_1[3]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutB[4]_i_1 
       (.I0(mem_reg_0_n_95),
        .I1(\doutB_reg[35]_i_3_n_0 ),
        .I2(\doutB_reg[4]_i_2_n_0 ),
        .O(doutB_1[4]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutB[5]_i_1 
       (.I0(mem_reg_0_n_94),
        .I1(\doutB_reg[35]_i_3_n_0 ),
        .I2(\doutB_reg[5]_i_2_n_0 ),
        .O(doutB_1[5]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutB[6]_i_1 
       (.I0(mem_reg_0_n_93),
        .I1(\doutB_reg[35]_i_3_n_0 ),
        .I2(\doutB_reg[6]_i_2_n_0 ),
        .O(doutB_1[6]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutB[7]_i_1 
       (.I0(mem_reg_0_n_92),
        .I1(\doutB_reg[35]_i_3_n_0 ),
        .I2(\doutB_reg[7]_i_2_n_0 ),
        .O(doutB_1[7]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutB[8]_i_1 
       (.I0(mem_reg_0_n_143),
        .I1(\doutB_reg[35]_i_3_n_0 ),
        .I2(\doutB_reg[8]_i_2_n_0 ),
        .O(doutB_1[8]));
  LUT3 #(
    .INIT(8'hB8)) 
    \doutB[9]_i_1 
       (.I0(mem_reg_1_n_99),
        .I1(\doutB_reg[35]_i_3_n_0 ),
        .I2(\doutB_reg[9]_i_2_n_0 ),
        .O(doutB_1[9]));
  OBUF \doutB_OBUF[0]_inst 
       (.I(doutB_OBUF[0]),
        .O(doutB[0]));
  OBUF \doutB_OBUF[10]_inst 
       (.I(doutB_OBUF[10]),
        .O(doutB[10]));
  OBUF \doutB_OBUF[11]_inst 
       (.I(doutB_OBUF[11]),
        .O(doutB[11]));
  OBUF \doutB_OBUF[12]_inst 
       (.I(doutB_OBUF[12]),
        .O(doutB[12]));
  OBUF \doutB_OBUF[13]_inst 
       (.I(doutB_OBUF[13]),
        .O(doutB[13]));
  OBUF \doutB_OBUF[14]_inst 
       (.I(doutB_OBUF[14]),
        .O(doutB[14]));
  OBUF \doutB_OBUF[15]_inst 
       (.I(doutB_OBUF[15]),
        .O(doutB[15]));
  OBUF \doutB_OBUF[16]_inst 
       (.I(doutB_OBUF[16]),
        .O(doutB[16]));
  OBUF \doutB_OBUF[17]_inst 
       (.I(doutB_OBUF[17]),
        .O(doutB[17]));
  OBUF \doutB_OBUF[18]_inst 
       (.I(doutB_OBUF[18]),
        .O(doutB[18]));
  OBUF \doutB_OBUF[19]_inst 
       (.I(doutB_OBUF[19]),
        .O(doutB[19]));
  OBUF \doutB_OBUF[1]_inst 
       (.I(doutB_OBUF[1]),
        .O(doutB[1]));
  OBUF \doutB_OBUF[20]_inst 
       (.I(doutB_OBUF[20]),
        .O(doutB[20]));
  OBUF \doutB_OBUF[21]_inst 
       (.I(doutB_OBUF[21]),
        .O(doutB[21]));
  OBUF \doutB_OBUF[22]_inst 
       (.I(doutB_OBUF[22]),
        .O(doutB[22]));
  OBUF \doutB_OBUF[23]_inst 
       (.I(doutB_OBUF[23]),
        .O(doutB[23]));
  OBUF \doutB_OBUF[24]_inst 
       (.I(doutB_OBUF[24]),
        .O(doutB[24]));
  OBUF \doutB_OBUF[25]_inst 
       (.I(doutB_OBUF[25]),
        .O(doutB[25]));
  OBUF \doutB_OBUF[26]_inst 
       (.I(doutB_OBUF[26]),
        .O(doutB[26]));
  OBUF \doutB_OBUF[27]_inst 
       (.I(doutB_OBUF[27]),
        .O(doutB[27]));
  OBUF \doutB_OBUF[28]_inst 
       (.I(doutB_OBUF[28]),
        .O(doutB[28]));
  OBUF \doutB_OBUF[29]_inst 
       (.I(doutB_OBUF[29]),
        .O(doutB[29]));
  OBUF \doutB_OBUF[2]_inst 
       (.I(doutB_OBUF[2]),
        .O(doutB[2]));
  OBUF \doutB_OBUF[30]_inst 
       (.I(doutB_OBUF[30]),
        .O(doutB[30]));
  OBUF \doutB_OBUF[31]_inst 
       (.I(doutB_OBUF[31]),
        .O(doutB[31]));
  OBUF \doutB_OBUF[32]_inst 
       (.I(doutB_OBUF[32]),
        .O(doutB[32]));
  OBUF \doutB_OBUF[33]_inst 
       (.I(doutB_OBUF[33]),
        .O(doutB[33]));
  OBUF \doutB_OBUF[34]_inst 
       (.I(doutB_OBUF[34]),
        .O(doutB[34]));
  OBUF \doutB_OBUF[35]_inst 
       (.I(doutB_OBUF[35]),
        .O(doutB[35]));
  OBUF \doutB_OBUF[3]_inst 
       (.I(doutB_OBUF[3]),
        .O(doutB[3]));
  OBUF \doutB_OBUF[4]_inst 
       (.I(doutB_OBUF[4]),
        .O(doutB[4]));
  OBUF \doutB_OBUF[5]_inst 
       (.I(doutB_OBUF[5]),
        .O(doutB[5]));
  OBUF \doutB_OBUF[6]_inst 
       (.I(doutB_OBUF[6]),
        .O(doutB[6]));
  OBUF \doutB_OBUF[7]_inst 
       (.I(doutB_OBUF[7]),
        .O(doutB[7]));
  OBUF \doutB_OBUF[8]_inst 
       (.I(doutB_OBUF[8]),
        .O(doutB[8]));
  OBUF \doutB_OBUF[9]_inst 
       (.I(doutB_OBUF[9]),
        .O(doutB[9]));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[0] 
       (.C(clkB_IBUF_BUFG),
        .CE(doutB0),
        .D(doutB_1[0]),
        .Q(doutB_OBUF[0]),
        .R(rstB_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[0]_i_2 
       (.C(clkB_IBUF_BUFG),
        .CE(\doutB_reg[35]_i_3_n_0 ),
        .D(mem_reg_0_n_99),
        .Q(\doutB_reg[0]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[10] 
       (.C(clkB_IBUF_BUFG),
        .CE(doutB0),
        .D(doutB_1[10]),
        .Q(doutB_OBUF[10]),
        .R(rstB_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[10]_i_2 
       (.C(clkB_IBUF_BUFG),
        .CE(\doutB_reg[35]_i_3_n_0 ),
        .D(mem_reg_1_n_98),
        .Q(\doutB_reg[10]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[11] 
       (.C(clkB_IBUF_BUFG),
        .CE(doutB0),
        .D(doutB_1[11]),
        .Q(doutB_OBUF[11]),
        .R(rstB_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[11]_i_2 
       (.C(clkB_IBUF_BUFG),
        .CE(\doutB_reg[35]_i_3_n_0 ),
        .D(mem_reg_1_n_97),
        .Q(\doutB_reg[11]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[12] 
       (.C(clkB_IBUF_BUFG),
        .CE(doutB0),
        .D(doutB_1[12]),
        .Q(doutB_OBUF[12]),
        .R(rstB_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[12]_i_2 
       (.C(clkB_IBUF_BUFG),
        .CE(\doutB_reg[35]_i_3_n_0 ),
        .D(mem_reg_1_n_96),
        .Q(\doutB_reg[12]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[13] 
       (.C(clkB_IBUF_BUFG),
        .CE(doutB0),
        .D(doutB_1[13]),
        .Q(doutB_OBUF[13]),
        .R(rstB_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[13]_i_2 
       (.C(clkB_IBUF_BUFG),
        .CE(\doutB_reg[35]_i_3_n_0 ),
        .D(mem_reg_1_n_95),
        .Q(\doutB_reg[13]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[14] 
       (.C(clkB_IBUF_BUFG),
        .CE(doutB0),
        .D(doutB_1[14]),
        .Q(doutB_OBUF[14]),
        .R(rstB_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[14]_i_2 
       (.C(clkB_IBUF_BUFG),
        .CE(\doutB_reg[35]_i_3_n_0 ),
        .D(mem_reg_1_n_94),
        .Q(\doutB_reg[14]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[15] 
       (.C(clkB_IBUF_BUFG),
        .CE(doutB0),
        .D(doutB_1[15]),
        .Q(doutB_OBUF[15]),
        .R(rstB_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[15]_i_2 
       (.C(clkB_IBUF_BUFG),
        .CE(\doutB_reg[35]_i_3_n_0 ),
        .D(mem_reg_1_n_93),
        .Q(\doutB_reg[15]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[16] 
       (.C(clkB_IBUF_BUFG),
        .CE(doutB0),
        .D(doutB_1[16]),
        .Q(doutB_OBUF[16]),
        .R(rstB_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[16]_i_2 
       (.C(clkB_IBUF_BUFG),
        .CE(\doutB_reg[35]_i_3_n_0 ),
        .D(mem_reg_1_n_92),
        .Q(\doutB_reg[16]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[17] 
       (.C(clkB_IBUF_BUFG),
        .CE(doutB0),
        .D(doutB_1[17]),
        .Q(doutB_OBUF[17]),
        .R(rstB_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[17]_i_2 
       (.C(clkB_IBUF_BUFG),
        .CE(\doutB_reg[35]_i_3_n_0 ),
        .D(mem_reg_1_n_143),
        .Q(\doutB_reg[17]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[18] 
       (.C(clkB_IBUF_BUFG),
        .CE(doutB0),
        .D(doutB_1[18]),
        .Q(doutB_OBUF[18]),
        .R(rstB_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[18]_i_2 
       (.C(clkB_IBUF_BUFG),
        .CE(\doutB_reg[35]_i_3_n_0 ),
        .D(mem_reg_2_n_99),
        .Q(\doutB_reg[18]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[19] 
       (.C(clkB_IBUF_BUFG),
        .CE(doutB0),
        .D(doutB_1[19]),
        .Q(doutB_OBUF[19]),
        .R(rstB_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[19]_i_2 
       (.C(clkB_IBUF_BUFG),
        .CE(\doutB_reg[35]_i_3_n_0 ),
        .D(mem_reg_2_n_98),
        .Q(\doutB_reg[19]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[1] 
       (.C(clkB_IBUF_BUFG),
        .CE(doutB0),
        .D(doutB_1[1]),
        .Q(doutB_OBUF[1]),
        .R(rstB_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[1]_i_2 
       (.C(clkB_IBUF_BUFG),
        .CE(\doutB_reg[35]_i_3_n_0 ),
        .D(mem_reg_0_n_98),
        .Q(\doutB_reg[1]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[20] 
       (.C(clkB_IBUF_BUFG),
        .CE(doutB0),
        .D(doutB_1[20]),
        .Q(doutB_OBUF[20]),
        .R(rstB_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[20]_i_2 
       (.C(clkB_IBUF_BUFG),
        .CE(\doutB_reg[35]_i_3_n_0 ),
        .D(mem_reg_2_n_97),
        .Q(\doutB_reg[20]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[21] 
       (.C(clkB_IBUF_BUFG),
        .CE(doutB0),
        .D(doutB_1[21]),
        .Q(doutB_OBUF[21]),
        .R(rstB_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[21]_i_2 
       (.C(clkB_IBUF_BUFG),
        .CE(\doutB_reg[35]_i_3_n_0 ),
        .D(mem_reg_2_n_96),
        .Q(\doutB_reg[21]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[22] 
       (.C(clkB_IBUF_BUFG),
        .CE(doutB0),
        .D(doutB_1[22]),
        .Q(doutB_OBUF[22]),
        .R(rstB_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[22]_i_2 
       (.C(clkB_IBUF_BUFG),
        .CE(\doutB_reg[35]_i_3_n_0 ),
        .D(mem_reg_2_n_95),
        .Q(\doutB_reg[22]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[23] 
       (.C(clkB_IBUF_BUFG),
        .CE(doutB0),
        .D(doutB_1[23]),
        .Q(doutB_OBUF[23]),
        .R(rstB_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[23]_i_2 
       (.C(clkB_IBUF_BUFG),
        .CE(\doutB_reg[35]_i_3_n_0 ),
        .D(mem_reg_2_n_94),
        .Q(\doutB_reg[23]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[24] 
       (.C(clkB_IBUF_BUFG),
        .CE(doutB0),
        .D(doutB_1[24]),
        .Q(doutB_OBUF[24]),
        .R(rstB_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[24]_i_2 
       (.C(clkB_IBUF_BUFG),
        .CE(\doutB_reg[35]_i_3_n_0 ),
        .D(mem_reg_2_n_93),
        .Q(\doutB_reg[24]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[25] 
       (.C(clkB_IBUF_BUFG),
        .CE(doutB0),
        .D(doutB_1[25]),
        .Q(doutB_OBUF[25]),
        .R(rstB_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[25]_i_2 
       (.C(clkB_IBUF_BUFG),
        .CE(\doutB_reg[35]_i_3_n_0 ),
        .D(mem_reg_2_n_92),
        .Q(\doutB_reg[25]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[26] 
       (.C(clkB_IBUF_BUFG),
        .CE(doutB0),
        .D(doutB_1[26]),
        .Q(doutB_OBUF[26]),
        .R(rstB_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[26]_i_2 
       (.C(clkB_IBUF_BUFG),
        .CE(\doutB_reg[35]_i_3_n_0 ),
        .D(mem_reg_2_n_143),
        .Q(\doutB_reg[26]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[27] 
       (.C(clkB_IBUF_BUFG),
        .CE(doutB0),
        .D(doutB_1[27]),
        .Q(doutB_OBUF[27]),
        .R(rstB_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[27]_i_2 
       (.C(clkB_IBUF_BUFG),
        .CE(\doutB_reg[35]_i_3_n_0 ),
        .D(mem_reg_3_n_99),
        .Q(\doutB_reg[27]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[28] 
       (.C(clkB_IBUF_BUFG),
        .CE(doutB0),
        .D(doutB_1[28]),
        .Q(doutB_OBUF[28]),
        .R(rstB_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[28]_i_2 
       (.C(clkB_IBUF_BUFG),
        .CE(\doutB_reg[35]_i_3_n_0 ),
        .D(mem_reg_3_n_98),
        .Q(\doutB_reg[28]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[29] 
       (.C(clkB_IBUF_BUFG),
        .CE(doutB0),
        .D(doutB_1[29]),
        .Q(doutB_OBUF[29]),
        .R(rstB_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[29]_i_2 
       (.C(clkB_IBUF_BUFG),
        .CE(\doutB_reg[35]_i_3_n_0 ),
        .D(mem_reg_3_n_97),
        .Q(\doutB_reg[29]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[2] 
       (.C(clkB_IBUF_BUFG),
        .CE(doutB0),
        .D(doutB_1[2]),
        .Q(doutB_OBUF[2]),
        .R(rstB_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[2]_i_2 
       (.C(clkB_IBUF_BUFG),
        .CE(\doutB_reg[35]_i_3_n_0 ),
        .D(mem_reg_0_n_97),
        .Q(\doutB_reg[2]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[30] 
       (.C(clkB_IBUF_BUFG),
        .CE(doutB0),
        .D(doutB_1[30]),
        .Q(doutB_OBUF[30]),
        .R(rstB_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[30]_i_2 
       (.C(clkB_IBUF_BUFG),
        .CE(\doutB_reg[35]_i_3_n_0 ),
        .D(mem_reg_3_n_96),
        .Q(\doutB_reg[30]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[31] 
       (.C(clkB_IBUF_BUFG),
        .CE(doutB0),
        .D(doutB_1[31]),
        .Q(doutB_OBUF[31]),
        .R(rstB_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[31]_i_2 
       (.C(clkB_IBUF_BUFG),
        .CE(\doutB_reg[35]_i_3_n_0 ),
        .D(mem_reg_3_n_95),
        .Q(\doutB_reg[31]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[32] 
       (.C(clkB_IBUF_BUFG),
        .CE(doutB0),
        .D(doutB_1[32]),
        .Q(doutB_OBUF[32]),
        .R(rstB_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[32]_i_2 
       (.C(clkB_IBUF_BUFG),
        .CE(\doutB_reg[35]_i_3_n_0 ),
        .D(mem_reg_3_n_94),
        .Q(\doutB_reg[32]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[33] 
       (.C(clkB_IBUF_BUFG),
        .CE(doutB0),
        .D(doutB_1[33]),
        .Q(doutB_OBUF[33]),
        .R(rstB_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[33]_i_2 
       (.C(clkB_IBUF_BUFG),
        .CE(\doutB_reg[35]_i_3_n_0 ),
        .D(mem_reg_3_n_93),
        .Q(\doutB_reg[33]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[34] 
       (.C(clkB_IBUF_BUFG),
        .CE(doutB0),
        .D(doutB_1[34]),
        .Q(doutB_OBUF[34]),
        .R(rstB_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[34]_i_2 
       (.C(clkB_IBUF_BUFG),
        .CE(\doutB_reg[35]_i_3_n_0 ),
        .D(mem_reg_3_n_92),
        .Q(\doutB_reg[34]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[35] 
       (.C(clkB_IBUF_BUFG),
        .CE(doutB0),
        .D(doutB_1[35]),
        .Q(doutB_OBUF[35]),
        .R(rstB_IBUF));
  FDRE #(
    .INIT(1'b1)) 
    \doutB_reg[35]_i_3 
       (.C(clkB_IBUF_BUFG),
        .CE(\<const1> ),
        .D(p_1_in0_out),
        .Q(\doutB_reg[35]_i_3_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[35]_i_4 
       (.C(clkB_IBUF_BUFG),
        .CE(\doutB_reg[35]_i_3_n_0 ),
        .D(mem_reg_3_n_143),
        .Q(\doutB_reg[35]_i_4_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[3] 
       (.C(clkB_IBUF_BUFG),
        .CE(doutB0),
        .D(doutB_1[3]),
        .Q(doutB_OBUF[3]),
        .R(rstB_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[3]_i_2 
       (.C(clkB_IBUF_BUFG),
        .CE(\doutB_reg[35]_i_3_n_0 ),
        .D(mem_reg_0_n_96),
        .Q(\doutB_reg[3]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[4] 
       (.C(clkB_IBUF_BUFG),
        .CE(doutB0),
        .D(doutB_1[4]),
        .Q(doutB_OBUF[4]),
        .R(rstB_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[4]_i_2 
       (.C(clkB_IBUF_BUFG),
        .CE(\doutB_reg[35]_i_3_n_0 ),
        .D(mem_reg_0_n_95),
        .Q(\doutB_reg[4]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[5] 
       (.C(clkB_IBUF_BUFG),
        .CE(doutB0),
        .D(doutB_1[5]),
        .Q(doutB_OBUF[5]),
        .R(rstB_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[5]_i_2 
       (.C(clkB_IBUF_BUFG),
        .CE(\doutB_reg[35]_i_3_n_0 ),
        .D(mem_reg_0_n_94),
        .Q(\doutB_reg[5]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[6] 
       (.C(clkB_IBUF_BUFG),
        .CE(doutB0),
        .D(doutB_1[6]),
        .Q(doutB_OBUF[6]),
        .R(rstB_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[6]_i_2 
       (.C(clkB_IBUF_BUFG),
        .CE(\doutB_reg[35]_i_3_n_0 ),
        .D(mem_reg_0_n_93),
        .Q(\doutB_reg[6]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[7] 
       (.C(clkB_IBUF_BUFG),
        .CE(doutB0),
        .D(doutB_1[7]),
        .Q(doutB_OBUF[7]),
        .R(rstB_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[7]_i_2 
       (.C(clkB_IBUF_BUFG),
        .CE(\doutB_reg[35]_i_3_n_0 ),
        .D(mem_reg_0_n_92),
        .Q(\doutB_reg[7]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[8] 
       (.C(clkB_IBUF_BUFG),
        .CE(doutB0),
        .D(doutB_1[8]),
        .Q(doutB_OBUF[8]),
        .R(rstB_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[8]_i_2 
       (.C(clkB_IBUF_BUFG),
        .CE(\doutB_reg[35]_i_3_n_0 ),
        .D(mem_reg_0_n_143),
        .Q(\doutB_reg[8]_i_2_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[9] 
       (.C(clkB_IBUF_BUFG),
        .CE(doutB0),
        .D(doutB_1[9]),
        .Q(doutB_OBUF[9]),
        .R(rstB_IBUF));
  FDRE #(
    .INIT(1'b0)) 
    \doutB_reg[9]_i_2 
       (.C(clkB_IBUF_BUFG),
        .CE(\doutB_reg[35]_i_3_n_0 ),
        .D(mem_reg_1_n_99),
        .Q(\doutB_reg[9]_i_2_n_0 ),
        .R(\<const0> ));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF enA_IBUF_inst
       (.I(enA),
        .O(enA_IBUF));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF enB_IBUF_inst
       (.I(enB),
        .O(enB_IBUF));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-6 {cell *THIS*}} {SYNTH-7 {cell *THIS*}}" *) 
  (* RDADDR_COLLISION_HWCONFIG = "DELAYED_WRITE" *) 
  (* RTL_RAM_BITS = "147456" *) 
  (* RTL_RAM_NAME = "mem" *) 
  (* bram_addr_begin = "0" *) 
  (* bram_addr_end = "4095" *) 
  (* bram_slice_begin = "0" *) 
  (* bram_slice_end = "8" *) 
  RAMB36E2 #(
    .CASCADE_ORDER_A("NONE"),
    .CASCADE_ORDER_B("NONE"),
    .CLOCK_DOMAINS("INDEPENDENT"),
    .DOA_REG(0),
    .DOB_REG(0),
    .ENADDRENA("FALSE"),
    .ENADDRENB("FALSE"),
    .EN_ECC_PIPE("FALSE"),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .RDADDRCHANGEA("FALSE"),
    .RDADDRCHANGEB("FALSE"),
    .READ_WIDTH_A(9),
    .READ_WIDTH_B(9),
    .RSTREG_PRIORITY_A("RSTREG"),
    .RSTREG_PRIORITY_B("RSTREG"),
    .SIM_COLLISION_CHECK("ALL"),
    .SLEEP_ASYNC("FALSE"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("READ_FIRST"),
    .WRITE_MODE_B("READ_FIRST"),
    .WRITE_WIDTH_A(9),
    .WRITE_WIDTH_B(9)) 
    mem_reg_0
       (.ADDRARDADDR({addrB_IBUF,\<const1> ,\<const1> ,\<const1> }),
        .ADDRBWRADDR({addrA_IBUF,\<const1> ,\<const1> ,\<const1> }),
        .ADDRENA(\<const0> ),
        .ADDRENB(\<const0> ),
        .CASDIMUXA(\<const0> ),
        .CASDIMUXB(\<const0> ),
        .CASDINA({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .CASDINB({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .CASDINPA({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .CASDINPB({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .CASDOMUXA(\<const0> ),
        .CASDOMUXB(\<const0> ),
        .CASDOMUXEN_A(\<const0> ),
        .CASDOMUXEN_B(\<const0> ),
        .CASINDBITERR(\<const0> ),
        .CASINSBITERR(\<const0> ),
        .CASOREGIMUXA(\<const0> ),
        .CASOREGIMUXB(\<const0> ),
        .CASOREGIMUXEN_A(\<const0> ),
        .CASOREGIMUXEN_B(\<const0> ),
        .CLKARDCLK(clkB_IBUF_BUFG),
        .CLKBWRCLK(clkA_IBUF_BUFG),
        .DINADIN({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,dinB_IBUF[7:0]}),
        .DINBDIN({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,dinA_IBUF[7:0]}),
        .DINPADINP({\<const0> ,\<const0> ,\<const0> ,dinB_IBUF[8]}),
        .DINPBDINP({\<const0> ,\<const0> ,\<const0> ,dinA_IBUF[8]}),
        .DOUTADOUT({mem_reg_0_n_92,mem_reg_0_n_93,mem_reg_0_n_94,mem_reg_0_n_95,mem_reg_0_n_96,mem_reg_0_n_97,mem_reg_0_n_98,mem_reg_0_n_99}),
        .DOUTBDOUT({mem_reg_0_n_124,mem_reg_0_n_125,mem_reg_0_n_126,mem_reg_0_n_127,mem_reg_0_n_128,mem_reg_0_n_129,mem_reg_0_n_130,mem_reg_0_n_131}),
        .DOUTPADOUTP(mem_reg_0_n_143),
        .DOUTPBDOUTP(mem_reg_0_n_147),
        .ECCPIPECE(VCC_2),
        .ENARDEN(\<const1> ),
        .ENBWREN(\<const1> ),
        .INJECTDBITERR(\<const0> ),
        .INJECTSBITERR(\<const0> ),
        .REGCEAREGCE(\<const0> ),
        .REGCEB(\<const0> ),
        .RSTRAMARSTRAM(\<const0> ),
        .RSTRAMB(\<const0> ),
        .RSTREGARSTREG(\<const0> ),
        .RSTREGB(\<const0> ),
        .SLEEP(\<const0> ),
        .WEA({p_1_in0_out,p_1_in0_out,p_1_in0_out,p_1_in0_out}),
        .WEBWE({\<const0> ,\<const0> ,\<const0> ,\<const0> ,mem_reg_0_i_2_n_0,mem_reg_0_i_2_n_0,mem_reg_0_i_2_n_0,mem_reg_0_i_2_n_0}));
  LUT3 #(
    .INIT(8'h08)) 
    mem_reg_0_i_1
       (.I0(enB_IBUF),
        .I1(weB_IBUF),
        .I2(rstB_IBUF),
        .O(p_1_in0_out));
  LUT3 #(
    .INIT(8'h08)) 
    mem_reg_0_i_2
       (.I0(enA_IBUF),
        .I1(weA_IBUF),
        .I2(rstA_IBUF),
        .O(mem_reg_0_i_2_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-6 {cell *THIS*}} {SYNTH-7 {cell *THIS*}}" *) 
  (* RDADDR_COLLISION_HWCONFIG = "DELAYED_WRITE" *) 
  (* RTL_RAM_BITS = "147456" *) 
  (* RTL_RAM_NAME = "mem" *) 
  (* bram_addr_begin = "0" *) 
  (* bram_addr_end = "4095" *) 
  (* bram_slice_begin = "9" *) 
  (* bram_slice_end = "17" *) 
  RAMB36E2 #(
    .CASCADE_ORDER_A("NONE"),
    .CASCADE_ORDER_B("NONE"),
    .CLOCK_DOMAINS("INDEPENDENT"),
    .DOA_REG(0),
    .DOB_REG(0),
    .ENADDRENA("FALSE"),
    .ENADDRENB("FALSE"),
    .EN_ECC_PIPE("FALSE"),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .RDADDRCHANGEA("FALSE"),
    .RDADDRCHANGEB("FALSE"),
    .READ_WIDTH_A(9),
    .READ_WIDTH_B(9),
    .RSTREG_PRIORITY_A("RSTREG"),
    .RSTREG_PRIORITY_B("RSTREG"),
    .SIM_COLLISION_CHECK("ALL"),
    .SLEEP_ASYNC("FALSE"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("READ_FIRST"),
    .WRITE_MODE_B("READ_FIRST"),
    .WRITE_WIDTH_A(9),
    .WRITE_WIDTH_B(9)) 
    mem_reg_1
       (.ADDRARDADDR({addrB_IBUF,\<const1> ,\<const1> ,\<const1> }),
        .ADDRBWRADDR({addrA_IBUF,\<const1> ,\<const1> ,\<const1> }),
        .ADDRENA(\<const0> ),
        .ADDRENB(\<const0> ),
        .CASDIMUXA(\<const0> ),
        .CASDIMUXB(\<const0> ),
        .CASDINA({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .CASDINB({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .CASDINPA({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .CASDINPB({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .CASDOMUXA(\<const0> ),
        .CASDOMUXB(\<const0> ),
        .CASDOMUXEN_A(\<const0> ),
        .CASDOMUXEN_B(\<const0> ),
        .CASINDBITERR(\<const0> ),
        .CASINSBITERR(\<const0> ),
        .CASOREGIMUXA(\<const0> ),
        .CASOREGIMUXB(\<const0> ),
        .CASOREGIMUXEN_A(\<const0> ),
        .CASOREGIMUXEN_B(\<const0> ),
        .CLKARDCLK(clkB_IBUF_BUFG),
        .CLKBWRCLK(clkA_IBUF_BUFG),
        .DINADIN({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,dinB_IBUF[16:9]}),
        .DINBDIN({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,dinA_IBUF[16:9]}),
        .DINPADINP({\<const0> ,\<const0> ,\<const0> ,dinB_IBUF[17]}),
        .DINPBDINP({\<const0> ,\<const0> ,\<const0> ,dinA_IBUF[17]}),
        .DOUTADOUT({mem_reg_1_n_92,mem_reg_1_n_93,mem_reg_1_n_94,mem_reg_1_n_95,mem_reg_1_n_96,mem_reg_1_n_97,mem_reg_1_n_98,mem_reg_1_n_99}),
        .DOUTBDOUT({mem_reg_1_n_124,mem_reg_1_n_125,mem_reg_1_n_126,mem_reg_1_n_127,mem_reg_1_n_128,mem_reg_1_n_129,mem_reg_1_n_130,mem_reg_1_n_131}),
        .DOUTPADOUTP(mem_reg_1_n_143),
        .DOUTPBDOUTP(mem_reg_1_n_147),
        .ECCPIPECE(VCC_2),
        .ENARDEN(\<const1> ),
        .ENBWREN(\<const1> ),
        .INJECTDBITERR(\<const0> ),
        .INJECTSBITERR(\<const0> ),
        .REGCEAREGCE(\<const0> ),
        .REGCEB(\<const0> ),
        .RSTRAMARSTRAM(\<const0> ),
        .RSTRAMB(\<const0> ),
        .RSTREGARSTREG(\<const0> ),
        .RSTREGB(\<const0> ),
        .SLEEP(\<const0> ),
        .WEA({p_1_in0_out,p_1_in0_out,p_1_in0_out,p_1_in0_out}),
        .WEBWE({\<const0> ,\<const0> ,\<const0> ,\<const0> ,mem_reg_0_i_2_n_0,mem_reg_0_i_2_n_0,mem_reg_0_i_2_n_0,mem_reg_0_i_2_n_0}));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-6 {cell *THIS*}} {SYNTH-7 {cell *THIS*}}" *) 
  (* RDADDR_COLLISION_HWCONFIG = "DELAYED_WRITE" *) 
  (* RTL_RAM_BITS = "147456" *) 
  (* RTL_RAM_NAME = "mem" *) 
  (* bram_addr_begin = "0" *) 
  (* bram_addr_end = "4095" *) 
  (* bram_slice_begin = "18" *) 
  (* bram_slice_end = "26" *) 
  RAMB36E2 #(
    .CASCADE_ORDER_A("NONE"),
    .CASCADE_ORDER_B("NONE"),
    .CLOCK_DOMAINS("INDEPENDENT"),
    .DOA_REG(0),
    .DOB_REG(0),
    .ENADDRENA("FALSE"),
    .ENADDRENB("FALSE"),
    .EN_ECC_PIPE("FALSE"),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .RDADDRCHANGEA("FALSE"),
    .RDADDRCHANGEB("FALSE"),
    .READ_WIDTH_A(9),
    .READ_WIDTH_B(9),
    .RSTREG_PRIORITY_A("RSTREG"),
    .RSTREG_PRIORITY_B("RSTREG"),
    .SIM_COLLISION_CHECK("ALL"),
    .SLEEP_ASYNC("FALSE"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("READ_FIRST"),
    .WRITE_MODE_B("READ_FIRST"),
    .WRITE_WIDTH_A(9),
    .WRITE_WIDTH_B(9)) 
    mem_reg_2
       (.ADDRARDADDR({addrB_IBUF,\<const1> ,\<const1> ,\<const1> }),
        .ADDRBWRADDR({addrA_IBUF,\<const1> ,\<const1> ,\<const1> }),
        .ADDRENA(\<const0> ),
        .ADDRENB(\<const0> ),
        .CASDIMUXA(\<const0> ),
        .CASDIMUXB(\<const0> ),
        .CASDINA({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .CASDINB({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .CASDINPA({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .CASDINPB({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .CASDOMUXA(\<const0> ),
        .CASDOMUXB(\<const0> ),
        .CASDOMUXEN_A(\<const0> ),
        .CASDOMUXEN_B(\<const0> ),
        .CASINDBITERR(\<const0> ),
        .CASINSBITERR(\<const0> ),
        .CASOREGIMUXA(\<const0> ),
        .CASOREGIMUXB(\<const0> ),
        .CASOREGIMUXEN_A(\<const0> ),
        .CASOREGIMUXEN_B(\<const0> ),
        .CLKARDCLK(clkB_IBUF_BUFG),
        .CLKBWRCLK(clkA_IBUF_BUFG),
        .DINADIN({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,dinB_IBUF[25:18]}),
        .DINBDIN({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,dinA_IBUF[25:18]}),
        .DINPADINP({\<const0> ,\<const0> ,\<const0> ,dinB_IBUF[26]}),
        .DINPBDINP({\<const0> ,\<const0> ,\<const0> ,dinA_IBUF[26]}),
        .DOUTADOUT({mem_reg_2_n_92,mem_reg_2_n_93,mem_reg_2_n_94,mem_reg_2_n_95,mem_reg_2_n_96,mem_reg_2_n_97,mem_reg_2_n_98,mem_reg_2_n_99}),
        .DOUTBDOUT({mem_reg_2_n_124,mem_reg_2_n_125,mem_reg_2_n_126,mem_reg_2_n_127,mem_reg_2_n_128,mem_reg_2_n_129,mem_reg_2_n_130,mem_reg_2_n_131}),
        .DOUTPADOUTP(mem_reg_2_n_143),
        .DOUTPBDOUTP(mem_reg_2_n_147),
        .ECCPIPECE(VCC_2),
        .ENARDEN(\<const1> ),
        .ENBWREN(\<const1> ),
        .INJECTDBITERR(\<const0> ),
        .INJECTSBITERR(\<const0> ),
        .REGCEAREGCE(\<const0> ),
        .REGCEB(\<const0> ),
        .RSTRAMARSTRAM(\<const0> ),
        .RSTRAMB(\<const0> ),
        .RSTREGARSTREG(\<const0> ),
        .RSTREGB(\<const0> ),
        .SLEEP(\<const0> ),
        .WEA({p_1_in0_out,p_1_in0_out,p_1_in0_out,p_1_in0_out}),
        .WEBWE({\<const0> ,\<const0> ,\<const0> ,\<const0> ,mem_reg_0_i_2_n_0,mem_reg_0_i_2_n_0,mem_reg_0_i_2_n_0,mem_reg_0_i_2_n_0}));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-6 {cell *THIS*}} {SYNTH-7 {cell *THIS*}}" *) 
  (* RDADDR_COLLISION_HWCONFIG = "DELAYED_WRITE" *) 
  (* RTL_RAM_BITS = "147456" *) 
  (* RTL_RAM_NAME = "mem" *) 
  (* bram_addr_begin = "0" *) 
  (* bram_addr_end = "4095" *) 
  (* bram_slice_begin = "27" *) 
  (* bram_slice_end = "35" *) 
  RAMB36E2 #(
    .CASCADE_ORDER_A("NONE"),
    .CASCADE_ORDER_B("NONE"),
    .CLOCK_DOMAINS("INDEPENDENT"),
    .DOA_REG(0),
    .DOB_REG(0),
    .ENADDRENA("FALSE"),
    .ENADDRENB("FALSE"),
    .EN_ECC_PIPE("FALSE"),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .RDADDRCHANGEA("FALSE"),
    .RDADDRCHANGEB("FALSE"),
    .READ_WIDTH_A(9),
    .READ_WIDTH_B(9),
    .RSTREG_PRIORITY_A("RSTREG"),
    .RSTREG_PRIORITY_B("RSTREG"),
    .SIM_COLLISION_CHECK("ALL"),
    .SLEEP_ASYNC("FALSE"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("READ_FIRST"),
    .WRITE_MODE_B("READ_FIRST"),
    .WRITE_WIDTH_A(9),
    .WRITE_WIDTH_B(9)) 
    mem_reg_3
       (.ADDRARDADDR({addrB_IBUF,\<const1> ,\<const1> ,\<const1> }),
        .ADDRBWRADDR({addrA_IBUF,\<const1> ,\<const1> ,\<const1> }),
        .ADDRENA(\<const0> ),
        .ADDRENB(\<const0> ),
        .CASDIMUXA(\<const0> ),
        .CASDIMUXB(\<const0> ),
        .CASDINA({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .CASDINB({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .CASDINPA({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .CASDINPB({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .CASDOMUXA(\<const0> ),
        .CASDOMUXB(\<const0> ),
        .CASDOMUXEN_A(\<const0> ),
        .CASDOMUXEN_B(\<const0> ),
        .CASINDBITERR(\<const0> ),
        .CASINSBITERR(\<const0> ),
        .CASOREGIMUXA(\<const0> ),
        .CASOREGIMUXB(\<const0> ),
        .CASOREGIMUXEN_A(\<const0> ),
        .CASOREGIMUXEN_B(\<const0> ),
        .CLKARDCLK(clkB_IBUF_BUFG),
        .CLKBWRCLK(clkA_IBUF_BUFG),
        .DINADIN({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,dinB_IBUF[34:27]}),
        .DINBDIN({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,dinA_IBUF[34:27]}),
        .DINPADINP({\<const0> ,\<const0> ,\<const0> ,dinB_IBUF[35]}),
        .DINPBDINP({\<const0> ,\<const0> ,\<const0> ,dinA_IBUF[35]}),
        .DOUTADOUT({mem_reg_3_n_92,mem_reg_3_n_93,mem_reg_3_n_94,mem_reg_3_n_95,mem_reg_3_n_96,mem_reg_3_n_97,mem_reg_3_n_98,mem_reg_3_n_99}),
        .DOUTBDOUT({mem_reg_3_n_124,mem_reg_3_n_125,mem_reg_3_n_126,mem_reg_3_n_127,mem_reg_3_n_128,mem_reg_3_n_129,mem_reg_3_n_130,mem_reg_3_n_131}),
        .DOUTPADOUTP(mem_reg_3_n_143),
        .DOUTPBDOUTP(mem_reg_3_n_147),
        .ECCPIPECE(VCC_2),
        .ENARDEN(\<const1> ),
        .ENBWREN(\<const1> ),
        .INJECTDBITERR(\<const0> ),
        .INJECTSBITERR(\<const0> ),
        .REGCEAREGCE(\<const0> ),
        .REGCEB(\<const0> ),
        .RSTRAMARSTRAM(\<const0> ),
        .RSTRAMB(\<const0> ),
        .RSTREGARSTREG(\<const0> ),
        .RSTREGB(\<const0> ),
        .SLEEP(\<const0> ),
        .WEA({p_1_in0_out,p_1_in0_out,p_1_in0_out,p_1_in0_out}),
        .WEBWE({\<const0> ,\<const0> ,\<const0> ,\<const0> ,mem_reg_0_i_2_n_0,mem_reg_0_i_2_n_0,mem_reg_0_i_2_n_0,mem_reg_0_i_2_n_0}));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF rstA_IBUF_inst
       (.I(rstA),
        .O(rstA_IBUF));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF rstB_IBUF_inst
       (.I(rstB),
        .O(rstB_IBUF));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF weA_IBUF_inst
       (.I(weA),
        .O(weA_IBUF));
  (* XILINX_REPORT_XFORM = "IBUF" *) 
  IBUF weB_IBUF_inst
       (.I(weB),
        .O(weB_IBUF));
endmodule
