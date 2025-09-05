// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Wed Sep 22 19:42:33 2021
// Host        : DESKTOP-0IILSC3 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               D:/ZYNQ_PL/uart_loop/uart_loop/uart_loop.srcs/sources_1/ip/bram_output/bram_output_sim_netlist.v
// Design      : bram_output
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7vx690tffg1761-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "bram_output,blk_mem_gen_v8_4_2,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_2,Vivado 2018.3" *) 
(* NotValidForBitStream *)
module bram_output
   (clka,
    ena,
    wea,
    addra,
    dina,
    douta);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [14:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [7:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [7:0]douta;

  wire [14:0]addra;
  wire clka;
  wire [7:0]dina;
  wire [7:0]douta;
  wire ena;
  wire [0:0]wea;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [7:0]NLW_U0_doutb_UNCONNECTED;
  wire [14:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [14:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [7:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "15" *) 
  (* C_ADDRB_WIDTH = "15" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "5" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     2.535699 mW" *) 
  (* C_FAMILY = "virtex7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "1" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "bram_output.mem" *) 
  (* C_INIT_FILE_NAME = "bram_output.mif" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "1" *) 
  (* C_MEM_TYPE = "0" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "20000" *) 
  (* C_READ_DEPTH_B = "20000" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "8" *) 
  (* C_READ_WIDTH_B = "8" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "20000" *) 
  (* C_WRITE_DEPTH_B = "20000" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "8" *) 
  (* C_WRITE_WIDTH_B = "8" *) 
  (* C_XDEVICEFAMILY = "virtex7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  bram_output_blk_mem_gen_v8_4_2 U0
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(NLW_U0_doutb_UNCONNECTED[7:0]),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[14:0]),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[14:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[7:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web(1'b0));
endmodule

(* ORIG_REF_NAME = "bindec" *) 
module bram_output_bindec
   (ena_array,
    ena,
    addra);
  output [4:0]ena_array;
  input ena;
  input [2:0]addra;

  wire [2:0]addra;
  wire ena;
  wire [4:0]ena_array;

  LUT4 #(
    .INIT(16'h0008)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_i_1 
       (.I0(ena),
        .I1(addra[2]),
        .I2(addra[0]),
        .I3(addra[1]),
        .O(ena_array[4]));
  LUT4 #(
    .INIT(16'h0002)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_i_1__0 
       (.I0(ena),
        .I1(addra[2]),
        .I2(addra[0]),
        .I3(addra[1]),
        .O(ena_array[0]));
  LUT4 #(
    .INIT(16'h0008)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_i_1__1 
       (.I0(addra[0]),
        .I1(ena),
        .I2(addra[1]),
        .I3(addra[2]),
        .O(ena_array[1]));
  LUT4 #(
    .INIT(16'h0008)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_i_1__2 
       (.I0(addra[1]),
        .I1(ena),
        .I2(addra[0]),
        .I3(addra[2]),
        .O(ena_array[2]));
  LUT4 #(
    .INIT(16'h0080)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_i_1__3 
       (.I0(ena),
        .I1(addra[0]),
        .I2(addra[1]),
        .I3(addra[2]),
        .O(ena_array[3]));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_generic_cstr" *) 
module bram_output_blk_mem_gen_generic_cstr
   (douta,
    clka,
    ena,
    addra,
    dina,
    wea);
  output [7:0]douta;
  input clka;
  input ena;
  input [14:0]addra;
  input [7:0]dina;
  input [0:0]wea;

  wire [14:0]addra;
  wire clka;
  wire [7:0]dina;
  wire [7:0]douta;
  wire [39:0]douta_array;
  wire ena;
  wire [4:0]ena_array;
  wire [0:0]wea;

  bram_output_bindec \bindec_a.bindec_inst_a 
       (.addra(addra[14:12]),
        .ena(ena),
        .ena_array(ena_array));
  bram_output_blk_mem_gen_mux \has_mux_a.A 
       (.addra(addra[14:12]),
        .clka(clka),
        .douta(douta),
        .douta_array(douta_array),
        .ena(ena));
  bram_output_blk_mem_gen_prim_width \ramloop[0].ram.r 
       (.addra(addra[11:0]),
        .clka(clka),
        .dina(dina),
        .douta_array(douta_array[7:0]),
        .ena(ena),
        .ena_array(ena_array[0]),
        .wea(wea));
  bram_output_blk_mem_gen_prim_width__parameterized0 \ramloop[1].ram.r 
       (.addra(addra[11:0]),
        .clka(clka),
        .dina(dina),
        .douta_array(douta_array[15:8]),
        .ena(ena),
        .ena_array(ena_array[1]),
        .wea(wea));
  bram_output_blk_mem_gen_prim_width__parameterized1 \ramloop[2].ram.r 
       (.addra(addra[11:0]),
        .clka(clka),
        .dina(dina),
        .douta_array(douta_array[23:16]),
        .ena(ena),
        .ena_array(ena_array[2]),
        .wea(wea));
  bram_output_blk_mem_gen_prim_width__parameterized2 \ramloop[3].ram.r 
       (.addra(addra[11:0]),
        .clka(clka),
        .dina(dina),
        .douta_array(douta_array[31:24]),
        .ena(ena),
        .ena_array(ena_array[3]),
        .wea(wea));
  bram_output_blk_mem_gen_prim_width__parameterized3 \ramloop[4].ram.r 
       (.addra(addra[11:0]),
        .clka(clka),
        .dina(dina),
        .douta_array(douta_array[39:32]),
        .ena(ena),
        .ena_array(ena_array[4]),
        .wea(wea));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_mux" *) 
module bram_output_blk_mem_gen_mux
   (douta,
    douta_array,
    ena,
    addra,
    clka);
  output [7:0]douta;
  input [39:0]douta_array;
  input ena;
  input [2:0]addra;
  input clka;

  wire [2:0]addra;
  wire clka;
  wire [7:0]douta;
  wire \douta[0]_INST_0_i_1_n_0 ;
  wire \douta[0]_INST_0_i_2_n_0 ;
  wire \douta[1]_INST_0_i_1_n_0 ;
  wire \douta[1]_INST_0_i_2_n_0 ;
  wire \douta[2]_INST_0_i_1_n_0 ;
  wire \douta[2]_INST_0_i_2_n_0 ;
  wire \douta[3]_INST_0_i_1_n_0 ;
  wire \douta[3]_INST_0_i_2_n_0 ;
  wire \douta[4]_INST_0_i_1_n_0 ;
  wire \douta[4]_INST_0_i_2_n_0 ;
  wire \douta[5]_INST_0_i_1_n_0 ;
  wire \douta[5]_INST_0_i_2_n_0 ;
  wire \douta[6]_INST_0_i_1_n_0 ;
  wire \douta[6]_INST_0_i_2_n_0 ;
  wire \douta[7]_INST_0_i_1_n_0 ;
  wire \douta[7]_INST_0_i_2_n_0 ;
  wire [39:0]douta_array;
  wire ena;
  wire [2:0]sel_pipe;
  wire [2:0]sel_pipe_d1;

  MUXF7 \douta[0]_INST_0 
       (.I0(\douta[0]_INST_0_i_1_n_0 ),
        .I1(\douta[0]_INST_0_i_2_n_0 ),
        .O(douta[0]),
        .S(sel_pipe_d1[2]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[0]_INST_0_i_1 
       (.I0(douta_array[24]),
        .I1(douta_array[16]),
        .I2(sel_pipe_d1[1]),
        .I3(douta_array[8]),
        .I4(sel_pipe_d1[0]),
        .I5(douta_array[0]),
        .O(\douta[0]_INST_0_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \douta[0]_INST_0_i_2 
       (.I0(sel_pipe_d1[0]),
        .I1(douta_array[32]),
        .I2(sel_pipe_d1[1]),
        .O(\douta[0]_INST_0_i_2_n_0 ));
  MUXF7 \douta[1]_INST_0 
       (.I0(\douta[1]_INST_0_i_1_n_0 ),
        .I1(\douta[1]_INST_0_i_2_n_0 ),
        .O(douta[1]),
        .S(sel_pipe_d1[2]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[1]_INST_0_i_1 
       (.I0(douta_array[25]),
        .I1(douta_array[17]),
        .I2(sel_pipe_d1[1]),
        .I3(douta_array[9]),
        .I4(sel_pipe_d1[0]),
        .I5(douta_array[1]),
        .O(\douta[1]_INST_0_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \douta[1]_INST_0_i_2 
       (.I0(sel_pipe_d1[0]),
        .I1(douta_array[33]),
        .I2(sel_pipe_d1[1]),
        .O(\douta[1]_INST_0_i_2_n_0 ));
  MUXF7 \douta[2]_INST_0 
       (.I0(\douta[2]_INST_0_i_1_n_0 ),
        .I1(\douta[2]_INST_0_i_2_n_0 ),
        .O(douta[2]),
        .S(sel_pipe_d1[2]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[2]_INST_0_i_1 
       (.I0(douta_array[26]),
        .I1(douta_array[18]),
        .I2(sel_pipe_d1[1]),
        .I3(douta_array[10]),
        .I4(sel_pipe_d1[0]),
        .I5(douta_array[2]),
        .O(\douta[2]_INST_0_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \douta[2]_INST_0_i_2 
       (.I0(sel_pipe_d1[0]),
        .I1(douta_array[34]),
        .I2(sel_pipe_d1[1]),
        .O(\douta[2]_INST_0_i_2_n_0 ));
  MUXF7 \douta[3]_INST_0 
       (.I0(\douta[3]_INST_0_i_1_n_0 ),
        .I1(\douta[3]_INST_0_i_2_n_0 ),
        .O(douta[3]),
        .S(sel_pipe_d1[2]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[3]_INST_0_i_1 
       (.I0(douta_array[27]),
        .I1(douta_array[19]),
        .I2(sel_pipe_d1[1]),
        .I3(douta_array[11]),
        .I4(sel_pipe_d1[0]),
        .I5(douta_array[3]),
        .O(\douta[3]_INST_0_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \douta[3]_INST_0_i_2 
       (.I0(sel_pipe_d1[0]),
        .I1(douta_array[35]),
        .I2(sel_pipe_d1[1]),
        .O(\douta[3]_INST_0_i_2_n_0 ));
  MUXF7 \douta[4]_INST_0 
       (.I0(\douta[4]_INST_0_i_1_n_0 ),
        .I1(\douta[4]_INST_0_i_2_n_0 ),
        .O(douta[4]),
        .S(sel_pipe_d1[2]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[4]_INST_0_i_1 
       (.I0(douta_array[28]),
        .I1(douta_array[20]),
        .I2(sel_pipe_d1[1]),
        .I3(douta_array[12]),
        .I4(sel_pipe_d1[0]),
        .I5(douta_array[4]),
        .O(\douta[4]_INST_0_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \douta[4]_INST_0_i_2 
       (.I0(sel_pipe_d1[0]),
        .I1(douta_array[36]),
        .I2(sel_pipe_d1[1]),
        .O(\douta[4]_INST_0_i_2_n_0 ));
  MUXF7 \douta[5]_INST_0 
       (.I0(\douta[5]_INST_0_i_1_n_0 ),
        .I1(\douta[5]_INST_0_i_2_n_0 ),
        .O(douta[5]),
        .S(sel_pipe_d1[2]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[5]_INST_0_i_1 
       (.I0(douta_array[29]),
        .I1(douta_array[21]),
        .I2(sel_pipe_d1[1]),
        .I3(douta_array[13]),
        .I4(sel_pipe_d1[0]),
        .I5(douta_array[5]),
        .O(\douta[5]_INST_0_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \douta[5]_INST_0_i_2 
       (.I0(sel_pipe_d1[0]),
        .I1(douta_array[37]),
        .I2(sel_pipe_d1[1]),
        .O(\douta[5]_INST_0_i_2_n_0 ));
  MUXF7 \douta[6]_INST_0 
       (.I0(\douta[6]_INST_0_i_1_n_0 ),
        .I1(\douta[6]_INST_0_i_2_n_0 ),
        .O(douta[6]),
        .S(sel_pipe_d1[2]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[6]_INST_0_i_1 
       (.I0(douta_array[30]),
        .I1(douta_array[22]),
        .I2(sel_pipe_d1[1]),
        .I3(douta_array[14]),
        .I4(sel_pipe_d1[0]),
        .I5(douta_array[6]),
        .O(\douta[6]_INST_0_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \douta[6]_INST_0_i_2 
       (.I0(sel_pipe_d1[0]),
        .I1(douta_array[38]),
        .I2(sel_pipe_d1[1]),
        .O(\douta[6]_INST_0_i_2_n_0 ));
  MUXF7 \douta[7]_INST_0 
       (.I0(\douta[7]_INST_0_i_1_n_0 ),
        .I1(\douta[7]_INST_0_i_2_n_0 ),
        .O(douta[7]),
        .S(sel_pipe_d1[2]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[7]_INST_0_i_1 
       (.I0(douta_array[31]),
        .I1(douta_array[23]),
        .I2(sel_pipe_d1[1]),
        .I3(douta_array[15]),
        .I4(sel_pipe_d1[0]),
        .I5(douta_array[7]),
        .O(\douta[7]_INST_0_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \douta[7]_INST_0_i_2 
       (.I0(sel_pipe_d1[0]),
        .I1(douta_array[39]),
        .I2(sel_pipe_d1[1]),
        .O(\douta[7]_INST_0_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \no_softecc_norm_sel2.has_mem_regs.WITHOUT_ECC_PIPE.ce_pri.sel_pipe_d1_reg[0] 
       (.C(clka),
        .CE(ena),
        .D(sel_pipe[0]),
        .Q(sel_pipe_d1[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \no_softecc_norm_sel2.has_mem_regs.WITHOUT_ECC_PIPE.ce_pri.sel_pipe_d1_reg[1] 
       (.C(clka),
        .CE(ena),
        .D(sel_pipe[1]),
        .Q(sel_pipe_d1[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \no_softecc_norm_sel2.has_mem_regs.WITHOUT_ECC_PIPE.ce_pri.sel_pipe_d1_reg[2] 
       (.C(clka),
        .CE(ena),
        .D(sel_pipe[2]),
        .Q(sel_pipe_d1[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \no_softecc_sel_reg.ce_pri.sel_pipe_reg[0] 
       (.C(clka),
        .CE(ena),
        .D(addra[0]),
        .Q(sel_pipe[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \no_softecc_sel_reg.ce_pri.sel_pipe_reg[1] 
       (.C(clka),
        .CE(ena),
        .D(addra[1]),
        .Q(sel_pipe[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \no_softecc_sel_reg.ce_pri.sel_pipe_reg[2] 
       (.C(clka),
        .CE(ena),
        .D(addra[2]),
        .Q(sel_pipe[2]),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module bram_output_blk_mem_gen_prim_width
   (douta_array,
    clka,
    ena_array,
    ena,
    addra,
    dina,
    wea);
  output [7:0]douta_array;
  input clka;
  input [0:0]ena_array;
  input ena;
  input [11:0]addra;
  input [7:0]dina;
  input [0:0]wea;

  wire [11:0]addra;
  wire clka;
  wire [7:0]dina;
  wire [7:0]douta_array;
  wire ena;
  wire [0:0]ena_array;
  wire [0:0]wea;

  bram_output_blk_mem_gen_prim_wrapper_init \prim_init.ram 
       (.addra(addra),
        .clka(clka),
        .dina(dina),
        .douta_array(douta_array),
        .ena(ena),
        .ena_array(ena_array),
        .wea(wea));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module bram_output_blk_mem_gen_prim_width__parameterized0
   (douta_array,
    clka,
    ena_array,
    ena,
    addra,
    dina,
    wea);
  output [7:0]douta_array;
  input clka;
  input [0:0]ena_array;
  input ena;
  input [11:0]addra;
  input [7:0]dina;
  input [0:0]wea;

  wire [11:0]addra;
  wire clka;
  wire [7:0]dina;
  wire [7:0]douta_array;
  wire ena;
  wire [0:0]ena_array;
  wire [0:0]wea;

  bram_output_blk_mem_gen_prim_wrapper_init__parameterized0 \prim_init.ram 
       (.addra(addra),
        .clka(clka),
        .dina(dina),
        .douta_array(douta_array),
        .ena(ena),
        .ena_array(ena_array),
        .wea(wea));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module bram_output_blk_mem_gen_prim_width__parameterized1
   (douta_array,
    clka,
    ena_array,
    ena,
    addra,
    dina,
    wea);
  output [7:0]douta_array;
  input clka;
  input [0:0]ena_array;
  input ena;
  input [11:0]addra;
  input [7:0]dina;
  input [0:0]wea;

  wire [11:0]addra;
  wire clka;
  wire [7:0]dina;
  wire [7:0]douta_array;
  wire ena;
  wire [0:0]ena_array;
  wire [0:0]wea;

  bram_output_blk_mem_gen_prim_wrapper_init__parameterized1 \prim_init.ram 
       (.addra(addra),
        .clka(clka),
        .dina(dina),
        .douta_array(douta_array),
        .ena(ena),
        .ena_array(ena_array),
        .wea(wea));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module bram_output_blk_mem_gen_prim_width__parameterized2
   (douta_array,
    clka,
    ena_array,
    ena,
    addra,
    dina,
    wea);
  output [7:0]douta_array;
  input clka;
  input [0:0]ena_array;
  input ena;
  input [11:0]addra;
  input [7:0]dina;
  input [0:0]wea;

  wire [11:0]addra;
  wire clka;
  wire [7:0]dina;
  wire [7:0]douta_array;
  wire ena;
  wire [0:0]ena_array;
  wire [0:0]wea;

  bram_output_blk_mem_gen_prim_wrapper_init__parameterized2 \prim_init.ram 
       (.addra(addra),
        .clka(clka),
        .dina(dina),
        .douta_array(douta_array),
        .ena(ena),
        .ena_array(ena_array),
        .wea(wea));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module bram_output_blk_mem_gen_prim_width__parameterized3
   (douta_array,
    clka,
    ena_array,
    ena,
    addra,
    dina,
    wea);
  output [7:0]douta_array;
  input clka;
  input [0:0]ena_array;
  input ena;
  input [11:0]addra;
  input [7:0]dina;
  input [0:0]wea;

  wire [11:0]addra;
  wire clka;
  wire [7:0]dina;
  wire [7:0]douta_array;
  wire ena;
  wire [0:0]ena_array;
  wire [0:0]wea;

  bram_output_blk_mem_gen_prim_wrapper_init__parameterized3 \prim_init.ram 
       (.addra(addra),
        .clka(clka),
        .dina(dina),
        .douta_array(douta_array),
        .ena(ena),
        .ena_array(ena_array),
        .wea(wea));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module bram_output_blk_mem_gen_prim_wrapper_init
   (douta_array,
    clka,
    ena_array,
    ena,
    addra,
    dina,
    wea);
  output [7:0]douta_array;
  input clka;
  input [0:0]ena_array;
  input ena;
  input [11:0]addra;
  input [7:0]dina;
  input [0:0]wea;

  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_n_71 ;
  wire [11:0]addra;
  wire clka;
  wire [7:0]dina;
  wire [7:0]douta_array;
  wire ena;
  wire [0:0]ena_array;
  wire [0:0]wea;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:8]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED ;
  wire [3:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(1),
    .DOB_REG(0),
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
    .INIT_00(256'h564C5A394A41394754273E29263A453939372F2F2C2331705A434D2F2E284E57),
    .INIT_01(256'h283B304E4137262C3C523C4C484E454650633A4E41303E5843554C51332E1C4E),
    .INIT_02(256'h1E482C262048663A4F4E42575965433C564D3E3B423F3A3C39374048414E2035),
    .INIT_03(256'h31433A54464B37264148543B4654564F2D3E33452E655BA73F4C20575E1D3C45),
    .INIT_04(256'h4C5487604E794F80772E3D27393D3F3B27202F121A2621382D472C532D2F3C2F),
    .INIT_05(256'h3B58334F3C5F54494C4E2F595A3A45373B705D435549704C3647304037534C39),
    .INIT_06(256'h8B793D5B58545D5A61404C66453A4B626C4F5D50713E4A4D6B383F3956345F5B),
    .INIT_07(256'h424C5B385E8B8B8F644B5441384C565C625757546F404C8A939556576D515187),
    .INIT_08(256'h7E5686798A898860905362563666695D4E7D683D4B424B7F8C3F91769DB18F62),
    .INIT_09(256'h163E43483E4257464B4438293F49293239363F20565E3E51463A4C7047535F52),
    .INIT_0A(256'h23332E5A2B36493C2B40614E4F774F447448749585823C2B443A322521323121),
    .INIT_0B(256'h67464255483B64264555583D574A414C363839326C4A624969685C666123503E),
    .INIT_0C(256'h40475474553F4D5C583641382A543F3B3E453D26453D3E3F46304B4E5F122552),
    .INIT_0D(256'h5546384E4C43405B453A455765533A4255255B756D4A4D384449504A57405036),
    .INIT_0E(256'h61674B544344505456675C572E3B4447727B4E59484565534830515D355A4A53),
    .INIT_0F(256'h572C31694F52554F5C785F385938446341514C445746694E563F4852553F3C49),
    .INIT_10(256'h5056371C7F2C4A394D6B4E393554534B51444F4257844E485C55315468424449),
    .INIT_11(256'h58645A534E4F4F3E5C5039404C55444D5B5B5B5C46475D60392A453C29545065),
    .INIT_12(256'h5764473B284E60524B40516A3F4D44474D41525D624D5F62403D5A5241525334),
    .INIT_13(256'h413F50543D3C494B605749526452403E465B746059414B4A593F5E2259463352),
    .INIT_14(256'h4452592C5D4142623C4E3D624F5A5A5A56446A52613E3F4A43623E4A48485E5B),
    .INIT_15(256'h583749765E45555250364B5A4E31534D323F51504F4556574150515E50686542),
    .INIT_16(256'h5C2F67427E4E46634B3E602F676D6845684B496D384649483B3C47565550324E),
    .INIT_17(256'h3A575A5B62316D5D444951813C5B804E696051535F4352543C634A513E4E4C41),
    .INIT_18(256'h5B3167463D675B715E4E5542434B55516E6C4145414C3B424A43444A4A535E4F),
    .INIT_19(256'h5F522E595951555858413C3B3E5D5B4D574B56387449474B505F6966534B3C44),
    .INIT_1A(256'h46395D294245303F54453871683A62405556636B4A36536246625A4F49455552),
    .INIT_1B(256'h364B42464B264A40244A56344C7748526E404D683821293A516149444E4B3443),
    .INIT_1C(256'h442431324A32323C494A1A4C304038675D58613E53477391516845305D6A636C),
    .INIT_1D(256'h36684E3C414F4A32373D52634A3245294B59494F53575E555938234937526C46),
    .INIT_1E(256'h404E35466D3F3D513347483D3C445738693E254B5B4C58532B50353F474E5043),
    .INIT_1F(256'h5F424B446750564F53605951533B5F5552746980776C68A6646B394A30201B44),
    .INIT_20(256'h6449454A718B82A76F6A6B5C746E5A739A5148675465714B5261855B4B67523D),
    .INIT_21(256'h674A456E2E393B484D2E4355374037425C374E545C58646755848C5B496D2A56),
    .INIT_22(256'h55682C6A404A384E574F5B3F5F5C62677F426C525A595D644852675752495959),
    .INIT_23(256'h426B7C4868575C5F4A29473214715B59286542545E3D58564F514669536B5448),
    .INIT_24(256'h424A615A50516A5A4D58555B586F5D573D4C464949434F5A424548394B3D4C29),
    .INIT_25(256'h444F4D4E4341554D4C53594D453F4436554B54405A50505D3F3546423B433D4B),
    .INIT_26(256'h4F524850464A3A40464A4F3E5F574E4F575D494B51615D665655564A45424E42),
    .INIT_27(256'h5E5F57595B676055686267665D4D4B584C3C54514D4B565B6946504D38586458),
    .INIT_28(256'h5148374C405E3B45503E384C505F5E5E644F606360595C585281524F525B5458),
    .INIT_29(256'h7768694F4B496C484C5A465D554B7244603233452F423E5A68654A4F4A744E4D),
    .INIT_2A(256'h6C5B6669666D7E6D776374765A55506E56645F5565686049444C555B60754F80),
    .INIT_2B(256'h343547412A3938254C3F493B90A14246A191894E536B705A79777D616D68715F),
    .INIT_2C(256'h1E3C36405D5B50336830544E4E322E5F4B2D504352423E47645C50504A5E3946),
    .INIT_2D(256'h3F39463F5C484C4C514642413F3F4D4746493849384C45374D42453B54304652),
    .INIT_2E(256'h5555384D53373842453C39484D4D765C4F2A4A3C35494C414142413B4155424B),
    .INIT_2F(256'h3F2D3346394D563C37355632483647514A4F3754565A3C51494144353F3E3232),
    .INIT_30(256'h4F31454F316151463F462D6044563D504A2A493C4135524D423E4C3E4B40373C),
    .INIT_31(256'h544D3C4050494D24613C594452385D3E354D41584E3E46284E2855474946484B),
    .INIT_32(256'h4F62412043452E39423B5950423E4251565135405742485E155A4C41324E3D4E),
    .INIT_33(256'h302B4D423B444650474F4142563E523B473F3C2544274136444C344F3A4B3E4E),
    .INIT_34(256'h552E493F44313C4226482B433A34384D4250373F40583C40514F8E2938545045),
    .INIT_35(256'h3A36493C2844543B334C3B452F32374D45325B3D42484747494D425A323B4453),
    .INIT_36(256'h35773F6747494D6A4B545E5542582D494C3B4C455A414B23463D512F3F2C3F51),
    .INIT_37(256'h584C52644E35485533483A41414D4F404B583D482E643A3F3A6A4F5337414B34),
    .INIT_38(256'h49393A3546353F6053323A43552B463D4061474B443A40325B315F4B475A5645),
    .INIT_39(256'h3E3F4F4E525C3F424832552851485341625742442F44523256594264313C4A5F),
    .INIT_3A(256'h414B5342425E5354402E49612B43303D48432A693F42534361335849464D3B45),
    .INIT_3B(256'h294C413D42393D66513A45484E41607446462C2A59574854443C4F40424C3042),
    .INIT_3C(256'h3B3E364742392E3C573E3C455453444E456B335E5C5C57474240453E4C425B38),
    .INIT_3D(256'h58535947583F534B543E5E455141373F1E4050384B41512D352B2343614A434A),
    .INIT_3E(256'h4737524C4131482D24A1B4CCFDE06C5C4A5B5E49283125372B262D205E2D2E52),
    .INIT_3F(256'h2A513A4B3B30565749581F4B3B687C4D5352614A28452939484167413B33513E),
    .INIT_40(256'h3D4B282D351D3426331F4F494D547360505843505555342F514C3B4F4A56403F),
    .INIT_41(256'h7751533E77384B45723F3F4C5B3D522E1F5730342722502B56503C3D36476F41),
    .INIT_42(256'h5D41565A4E6054413E6D55716132543C3A623F4D454240202943653B44442676),
    .INIT_43(256'h3946697B76498043384F42394F45547145504D3D3D4451434895A58E9B845C51),
    .INIT_44(256'h5F505E3F59253237475B4948403543363E4E36403F3D3B314320564D407D5089),
    .INIT_45(256'h4242445A46443C5B5E4A432F3F474D5A49654A4D544B4C4E58566057424B505B),
    .INIT_46(256'h52776A454F43414A3F21383F44585B4D4442572E667048634869424744484A3D),
    .INIT_47(256'h261C492E51413C964653354C46504C4850726A5962575D4270344642273D5E5D),
    .INIT_48(256'h354E505851325339665130602150342D2E4D5B304B4C3C353550304420310026),
    .INIT_49(256'h21413C3335513A5A47464B5F54455F654D4E4A474D4061554A4560504E4C6229),
    .INIT_4A(256'h3E497E4EA1AB3A68928E952E264237484E271938361D20333A43413439302D31),
    .INIT_4B(256'h49285E434B4052494C65644959624C644A3C445F3F4150463B31686279514A39),
    .INIT_4C(256'h4257595D41325C5841433D5D5F5A54464063483449484E4940705E4D6A616536),
    .INIT_4D(256'h355C404C24464E42472C4C643F4651485C4E68524741566645414C374F574040),
    .INIT_4E(256'h4C47713D6129343D51463F4E4B615F513F573250594F3E3E5E524E366D545F5F),
    .INIT_4F(256'h516B77393A5B5346483053433A5868484D616449444E475B514834304D484F53),
    .INIT_50(256'h644A71426336604143404E37254442323E502A5A515B3A33524B313C655D3136),
    .INIT_51(256'h602A3360415B525C5F305F383049375A29715E612D633759435E51573A2B7743),
    .INIT_52(256'h3E4E433F436740415F3030585B2F563057614B51443B5157493C4946465C6439),
    .INIT_53(256'h205F448A424F5E5C2C5C4E4C3547624646454C45575E385F426534504C4F7850),
    .INIT_54(256'h4E453C494E67516451535B5F533F4A5B32646577494A4B6A404861597E493249),
    .INIT_55(256'h51506E435B486B7A4D504F5F48365A5A503A5A3C51353B6E4B3854394360524D),
    .INIT_56(256'h5B5B3B5E344E63514A335A4E4C3B5342682D4F4F4144634D2D4A5D505A505958),
    .INIT_57(256'h2D6763535B3A464E5953395C4A6865314D2B69646B5E6569442D44364E423E6D),
    .INIT_58(256'h4A4C755A46506D552A53404C4B427E3154554A6754462B464E44464162653F4C),
    .INIT_59(256'h46365C6B5A452E425F384852524C412E39606143382D4140584D406068463E48),
    .INIT_5A(256'h51524B713D57515E4263535159694E6A70483F363B2F3C424D50743E5854335F),
    .INIT_5B(256'h4E45252A353E62492E442D364E436C4244362A3F3828574B4D4F44455C4C584F),
    .INIT_5C(256'h73687057596F42523B416657502B5A2B2F383C42304D3245484D514A5442523B),
    .INIT_5D(256'h5741432A3F3B3033615A4338352F223329242E335D163C497634517969606262),
    .INIT_5E(256'h626141513F4F4A4F3B4C3C333C50415861405F3A453E45413C463C493D506065),
    .INIT_5F(256'h2E43265E45583D49505B4950483E39434E4F414D4B5658555855644E3A486743),
    .INIT_60(256'h29364033362E40483C4D554643533C515355495C5B514D413735404342515251),
    .INIT_61(256'h2A4D473E3D303D3E3B3145494F4749434A44383137503D5537413B2F394F605D),
    .INIT_62(256'h585847675144604F5B515846565152575D40242C394430333B4E3E504E663D3E),
    .INIT_63(256'h51605B4B57595B5E4D5156644B5E5859505D4D5256495F68586552645D7D6750),
    .INIT_64(256'h766160616F555D59507246515864705F6D5653895E694D5463585D5C5C5A435A),
    .INIT_65(256'h5543664E5A5D6E64595A48478965656A6882486453585862656147576854647B),
    .INIT_66(256'h5352A186619DB9AB8F739649547F7257684E5088805E625F60696D5358494E77),
    .INIT_67(256'h4F594B4E49473D303E4D4225483B54524F454B315048324845384346695F4C5C),
    .INIT_68(256'h5D56565A7C5C604F42534E5C43405640434D536E47404A4D54504B51584D4E3E),
    .INIT_69(256'h55513D52574C3E5C7B4C45544F43534044444A44544B4646493A413E3C5B5146),
    .INIT_6A(256'h47554D4D4E464F4B4E3E3D534B58554C54324238404F583D404E55475C3E223E),
    .INIT_6B(256'h44453C5B3E453F574A454A594244463A4144383D4C534C4D384F555D53583B45),
    .INIT_6C(256'h433B444E443B353B5367495153583E49504D414E3E3C3C4159593B3845374D51),
    .INIT_6D(256'h634655325A484246484536483E574652474A4E4D434D325040493F3347416053),
    .INIT_6E(256'h40364B28494A484E575F5138583D564F49504C4748463C513D434E3F605C442D),
    .INIT_6F(256'h46483D4C4448463A49503C544B4056664B424538443D524256514B41574F4D54),
    .INIT_70(256'h4F514252395B554B3B4D48455452465253243A493C4D3C4D504C52456256454D),
    .INIT_71(256'h4754434F53505E4950504D4D3D4B443E4A3839523E4F414B4952553F4B543E56),
    .INIT_72(256'h4A4D455C4C45473A5F57394A40404A4648415059494E434D524B4044453F3449),
    .INIT_73(256'h473E3D43554446584D404B5B554A5045403D4A4C4B5248614D4645354E4C2F39),
    .INIT_74(256'h4948405653443F396D4264336C43434D47225037504B49463B4B51592A49514C),
    .INIT_75(256'h4A4B3944434D5F564B3B5643434A67413E554E525948444C51535B424957423E),
    .INIT_76(256'h504B63534637412C4549505A51485A5758474F3F4A544C4D4C4C3D3D584E4147),
    .INIT_77(256'h474565564439464649474F5B405649664D59504340424348544153434E443F52),
    .INIT_78(256'h47583F515052384E3D4C584036453C49523A445D4A454A455234545764445058),
    .INIT_79(256'h424343535558515149323D4131424D42344E4B454E483E5B5338485445526043),
    .INIT_7A(256'h44442837433F674E4329352B4F4D34554F673C38502E425B5C5444464E3A4E55),
    .INIT_7B(256'h37493E24483C47404148404F44553B4147464A404848413A5B4B53475E535850),
    .INIT_7C(256'h5648484B303F343B4C454A3B4E4437413929494B4F495C424C3B38435955444D),
    .INIT_7D(256'h5A8A6456667A76565D4245474A4C3543564044354936476F714B522F273D3F67),
    .INIT_7E(256'h5B7F85675574486561724956799CA9F38D97A68DB5AC9389CF827175797B7174),
    .INIT_7F(256'h3A423F365F4266584E6C696A516C835E543C4E563D3639305F1E59757D75636C),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(9),
    .READ_WIDTH_B(9),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(9),
    .WRITE_WIDTH_B(9)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({1'b1,addra,1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,dina}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:8],douta_array}),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:1],\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_n_71 }),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ena_array),
        .ENBWREN(1'b0),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(ena),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .WEA({wea,wea,wea,wea}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module bram_output_blk_mem_gen_prim_wrapper_init__parameterized0
   (douta_array,
    clka,
    ena_array,
    ena,
    addra,
    dina,
    wea);
  output [7:0]douta_array;
  input clka;
  input [0:0]ena_array;
  input ena;
  input [11:0]addra;
  input [7:0]dina;
  input [0:0]wea;

  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_n_71 ;
  wire [11:0]addra;
  wire clka;
  wire [7:0]dina;
  wire [7:0]douta_array;
  wire ena;
  wire [0:0]ena_array;
  wire [0:0]wea;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:8]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED ;
  wire [3:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(1),
    .DOB_REG(0),
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
    .INIT_00(256'h413350785759404F5B45374236523F442B354935296859727C5E63434238493D),
    .INIT_01(256'h5A3244445C504D4449635C2D42533E3F3C2A4C2C3357384B31514B3834223844),
    .INIT_02(256'h4A455C4F2D48505C466B49706F42584B533D4F603B614E624C50415656545937),
    .INIT_03(256'h40625949463E4F574448484A5E53715A5C5F4757544A374E4C494F2C56443A6A),
    .INIT_04(256'h504F44403D5252595B4E554D65604340484B303A4D4F504F4A48475F62485D46),
    .INIT_05(256'h687B6033426766836D727A66648080727068774D614A4B5A4B453F50425B5B52),
    .INIT_06(256'h473C313619453F3E48512929596261263B3C2C246E9B4B523151676F836F5A6B),
    .INIT_07(256'h3660596B607C426789766D4C475A6D7C74592C346B5D5E295D1F37282539192E),
    .INIT_08(256'h6970676053467D48433E6565686E4B425A5F5B6678624E825E727A7A52654A35),
    .INIT_09(256'h5250525935364C40334124381D593D1E473B35335D4A1A285674733F595D6A46),
    .INIT_0A(256'h6E2D4A4633394A5F323B4647605943394031565F79544A2E2E58654E5B4B244D),
    .INIT_0B(256'h494649352B4A4650644A614246302D586E6D53615376565B2A4B4E473A41302F),
    .INIT_0C(256'h482D4A4138474247474F4A474838362C373C405A664766605935453A39574640),
    .INIT_0D(256'h5855513760432C403F3E2C343B4E444B3F3546404F56523658513E405C633F54),
    .INIT_0E(256'h48335055574A3F38364F463A4E5D4D424E554F5F44454B4B45383342454D5B4F),
    .INIT_0F(256'h234353363C5B44593D4B51614E414F2A483066566B3054402D41435F414A4A0F),
    .INIT_10(256'h485C4B4752614256554A4E312C4E3051555464554F553F686B2A431E4C403A4C),
    .INIT_11(256'h634B54173C674A4C323A3B4C384A464B4E4B5C47406271214E50304B48455858),
    .INIT_12(256'h5B5928475B41383D402C44433C27383F32424545435C4535463346593E554243),
    .INIT_13(256'h3F2F7424605028452E37442F3D3E41405A474E4E44432E2149424C6B464C4657),
    .INIT_14(256'h3B575661563B453C3E7047764C6561515A42553E39544957403C3F69444E4638),
    .INIT_15(256'h5B41493B444C436C55464C50512B3F66524C42252C4769454555303D60524D4E),
    .INIT_16(256'h464D3E553C556F4F573C3632445F484A46293B365B2B384E38635A502343423E),
    .INIT_17(256'h56504D5347693F4B3E3A665851683F4F52495347423F494C3D584A4A5632353E),
    .INIT_18(256'h2B2B44474443434B3D4D404D3F7F515C5230485C32243758336A3755473D4E31),
    .INIT_19(256'h3431333736385D374831575439194E6B564C3541603A404D566E2B245357354A),
    .INIT_1A(256'h276334275843372E393322293D232E1931302E2D3B442B3D3732043A40584E3A),
    .INIT_1B(256'h3F402E305742314C4B435260535C5A4F665F44533E523A492245321C29453C37),
    .INIT_1C(256'h2C364B113F2D4B38183B292A4D3D3C36335250423D42444D505B5A4843463431),
    .INIT_1D(256'h84B798854F6063456C6C61796D64586D5A756A78675E5A7F7A743A725F6D7D49),
    .INIT_1E(256'h3A263B393537162E5D3E544E37514B545E504D99A19882917AD3D1C38C8A88B2),
    .INIT_1F(256'h5658382F456544314D48241D2E2A4D4A5D2F332626012A312F3B43312E362E4B),
    .INIT_20(256'h58262239372036240D233126283B1A3222214831271812241D4B34635B594345),
    .INIT_21(256'h404D43403A5464573B314E5A4D4F4D5048514A46554B4136524C482E4F4D5139),
    .INIT_22(256'h3B4D4C434B474D5B553E5452464B464A4B43534C3F434E4B423B3D4447404F58),
    .INIT_23(256'h536332494548464F3F504B4F455C444B47433B304F474C554442354B4E413931),
    .INIT_24(256'h2A1D1F34413C5937332E3037453C52525953274949364A46364645483D342F38),
    .INIT_25(256'h744455444F4A424D6041562B2E4631243831525154513D5B455A4F4B4A534E26),
    .INIT_26(256'h35373C343154522040343541413A371342433C233A3D4E4863566D5B4C635F58),
    .INIT_27(256'h3F3A4D2C3452453C3C33334A343B454E2F423E444A3F433D2929202F383A4025),
    .INIT_28(256'h444F382839553F3D5457473062461D3D3E6457243329374B464F4E584E4B571F),
    .INIT_29(256'h5D44403E716C42484627575951463D434540635E6766454E5F553B57464F5048),
    .INIT_2A(256'h4E464A423A3E4D6E596459494F5684774F46646D6E4B3C4A5F2F492F4B50625F),
    .INIT_2B(256'h6B6D60324B3A4355444D477255595E8B62323C4445474D523D5C4C454A626340),
    .INIT_2C(256'h404354494456575D4A4D404F6A4B364E584969647F6C5C592F4B5141674F4D5B),
    .INIT_2D(256'h465152536D693A40585E774C322A53534A46634741595A2B51675B3A72334744),
    .INIT_2E(256'h753D735B3C5F5D38613B586869595D755F3D50435B494449414723644E513D55),
    .INIT_2F(256'h4D5F4F3B57662C51704C4C60606354914D4F3F38545C2166404C47612A4E427A),
    .INIT_30(256'h3F454550357247404C34426143504E553A36465F7B595643505A5E64484C5641),
    .INIT_31(256'h7143515D482A4A3851531C5156494E486850506244514A43354160394F622F47),
    .INIT_32(256'h3049593E6658496A555535665A5E452C6051655B5F3A57444545626846544559),
    .INIT_33(256'h3A59434037536C4C3D4A5C6E674C5C4D6B4E625E374F49374A41733B5F594251),
    .INIT_34(256'h3741645A615E4F73453F3F3D417169684D824175616160384B344B576F49545A),
    .INIT_35(256'h6E3B353C4A4F4E5D43315F2E4E34386C506C5B4F553C2F3D77455B536F626361),
    .INIT_36(256'h57583D55496E3E474A4D5D495D365B664750615B4B582E31536E484D3F645374),
    .INIT_37(256'h6831715E625E4E516C3D3A69632F3D594D2A4F5E3E3347454C506252575A643B),
    .INIT_38(256'h5855354E3A3A39675E783A466F7A6E69676E464B535B5A62386C505D5D345F3F),
    .INIT_39(256'h444832444D445A49415C4C475C30333A3C5A32665E5D574A3A2D3C5C4844514C),
    .INIT_3A(256'h3E54542D4051493D534B3A4D524B3A5A5C625A4B3E3E4D41384C503F4553212E),
    .INIT_3B(256'h0D39312C4020113A3850534D5568515A6F554D453A3C3037362D35315E28405C),
    .INIT_3C(256'h35453B391D332A403D2E433F44564C29403E5B5242354416252D1F3244424A44),
    .INIT_3D(256'h575D2F2B543B36415C3C2E4440423D422E3B3D4B38383736483D41443E4B4736),
    .INIT_3E(256'h282B3A46295039722E3223394F394833133822340C3F583038222C2927232022),
    .INIT_3F(256'h2C291B3827123B38263612291F1E3827404844665D5958615C73284846465959),
    .INIT_40(256'h40978157515F4A64535640444E5A424054693620252C322B772D3D402F2F3C26),
    .INIT_41(256'h6C4F5C2D734A41457631443F64176D583E2D515534614C593656447D79544455),
    .INIT_42(256'h5261636796624385815F5A5AB143857F888137403B4145405C3D4E5F41436E77),
    .INIT_43(256'h76B49E49533A37827E2F5C75499B866B4E57842673CCB0D36567686B574E5B67),
    .INIT_44(256'h6B725E652B31376E5C5E283E353B3D373E4A514F2F3730507954545C7C75B073),
    .INIT_45(256'h222E4B313A2D475D69355746412C343E4744513A4F6756625F6942446F795E5F),
    .INIT_46(256'h141922303E304133413C493F5E283438344B3E644048551B2A4B5F3C493C401A),
    .INIT_47(256'h4D5D5A2F616A39466A33585635291F262C351F2A3B382C212E23383A2125162D),
    .INIT_48(256'h643A575C585A3D48455442504B563F364B6245545F45703965284B52503A5B35),
    .INIT_49(256'h5B6B4D4F4A387140554D4A544E744A50514A585B564D4A515A57474E503F5B3F),
    .INIT_4A(256'h572C4042675F7E62552C48515936434B5E4E4D604C544866434F594A44506D5E),
    .INIT_4B(256'h4944394C514E564C50604652724C4A5651474B604F4C53523D4E4E294B424056),
    .INIT_4C(256'h6243484B4A4F4A69483B51384850576445685C4A4A52B6563E543B3A5B56524C),
    .INIT_4D(256'h493E5A534D483D5433424461454D3D5A6555476354465C5D625A3F3A58545250),
    .INIT_4E(256'h4D5E4D5453605C5365493C45455B5757374C4D47503B545954254C5036333C39),
    .INIT_4F(256'h53523E7239542A2E554A3448593F62414B5A5958583E5F40514A6549534A393F),
    .INIT_50(256'h293D5A4B4434484057544E724659515D4F65575A514361493D35454E42495653),
    .INIT_51(256'h594D2F5959443F4B5B46483550583C4746334962495B59645B555E5F4B4D4D58),
    .INIT_52(256'h5462514F52643F5D5D553E68394D4F405C584C375B483D5C3A365D3E5F555032),
    .INIT_53(256'h5F54454842534E5850595C624F5B54564D564D4C4E4152574056474F67474A55),
    .INIT_54(256'h55486445574E5B5A5A4F8054497C4E3E614D70605F515A6D544C565A60415F67),
    .INIT_55(256'h49426B524C575958444A63633D55444243685069606F4F62586D384C555D4B37),
    .INIT_56(256'h624D4D594D3B48575159614B484C4B41364C55333A3C3636533C467446665041),
    .INIT_57(256'h6A5D5C65604B4C535C644952616F454260454A6A46474638484B4B475953405B),
    .INIT_58(256'h5B44393F575C535758494E42512D65524F524C4B5F3A4D47415731554F4B5557),
    .INIT_59(256'h574B423E604A385A305C5825463E4D495142554A52545D5556514C60454B4748),
    .INIT_5A(256'h333C4B304A472C35585C3A4A5A461C46405857416D3F3A475636482940507334),
    .INIT_5B(256'h653E3C48492A2C36444E31383E3D31454D44453E55493A515C335551454C334A),
    .INIT_5C(256'h4D364A393A3B394B334B423F3A3A2F43563F3E32674A3E4C394A44322A2F513F),
    .INIT_5D(256'h33232E403926334C164334404332672B435371393D4E403C364E3B4D48373839),
    .INIT_5E(256'h2A362A32151737374A5347544A3B352D393A37303D49443C4745483C47426B4E),
    .INIT_5F(256'h1D242F2D412C363B34352C43474942393C3633311E523B323527312C2A302729),
    .INIT_60(256'h4E4146434D473F40484C544C36483E3D51343F3D33303531394E36363D463E32),
    .INIT_61(256'h4E39484945384E3C3C584843602F4E3D3E51403D3E2A3B424C4C3F475439443D),
    .INIT_62(256'h3F2F4C4248494B4D3B522E3B5142484E483B363A403B33453F383B3745494248),
    .INIT_63(256'h3D3D4B4F3E3F5E4A36485C4C5B505A4554463A44502F3A3F494D4325494D583E),
    .INIT_64(256'h323D49402434194750441F3D45475C3648654731445049524C464132484B2B5D),
    .INIT_65(256'h40423A545D483547315043595443553F282B373D23524F6562354F4947384844),
    .INIT_66(256'h4938246536312F5B6A51434F424356394C4D494838464E5134444E303F413943),
    .INIT_67(256'h3C3F5F574042504B655D9453354D6CAF67485286994B41283C46343E3F332C35),
    .INIT_68(256'h5F453C3F3F4445557B534B584560445E365647635B5A36483A417A486A594143),
    .INIT_69(256'h4D37553B6C63553D635B5B4D5C4D544EBF4E525B356570464F584D555D614453),
    .INIT_6A(256'h555E93455D494D5C5F5D435D55515042304E4340526453355169405972506F67),
    .INIT_6B(256'h37485446905D623C4B63634E44603F736F5B3645575D435A585C5954583C3E4A),
    .INIT_6C(256'h4F4E5B60374C530A494D41443C606E4347389A474B767C493E555957747E494D),
    .INIT_6D(256'h6A345D255C4071513352393E4845386556587261A54A415B6235593762BC543C),
    .INIT_6E(256'h424C314F3E4B4C463C4453555B82615B58433F6D495F5041524D6B58505C4755),
    .INIT_6F(256'h564745524C4A544D62754371426E7063554D496A3A32BD654E575D8B3A653348),
    .INIT_70(256'h5B584E5C436678414D3E56684B635558665443445F3D30723B5C5A464E645035),
    .INIT_71(256'h5657486B51515E424156733A60705033744E5953485A474631685947523C5748),
    .INIT_72(256'h2D5D345B67584D4B4A4836996D5D3D59637573536C7B714D6C5A515B39498AC5),
    .INIT_73(256'h685654556B6335225748604B64594154513B5C614E685F556C65584C5D546E58),
    .INIT_74(256'h633652535F3A86604F666A555B525546403C6AAC647A5C56515143784C663F47),
    .INIT_75(256'h615855408C89638D546A574B3E782F98514A536E5A566864FF496F65383D3E57),
    .INIT_76(256'h4959425E595F4E589C484E594F5E4E612D3A425C47583F544C6A3F57315F5C65),
    .INIT_77(256'h443B314542363E433441363939445F6E514D55534F30575F5A54617F5A2B4E62),
    .INIT_78(256'h394A342C363356323C692048415459473C3E344A4C471942463B323E43545F59),
    .INIT_79(256'h5B4942574B4533324E39436F45152A44564B625A59514D4F604A545554634751),
    .INIT_7A(256'h42272E335B362825360F232B6C434B6B63293038353A2F3A3258563E38333B42),
    .INIT_7B(256'h463A453A2B332A4F193C44544E57451E2E35333B3C334B2A3E492B301A231E3D),
    .INIT_7C(256'h3446501B4B2E3636593230293439462F26452D42341A22243E304E49394C2F10),
    .INIT_7D(256'h1E382D404E6841263F4536443B3C4A652A6B303A44353C4E463124385A304657),
    .INIT_7E(256'h546B6F6B5D5B66556342232F233340562E3A254D410E06062E2F1138294B4520),
    .INIT_7F(256'h5B53605D564A56634C5263434162605249405552625B6565434F43583C695A48),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(9),
    .READ_WIDTH_B(9),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(9),
    .WRITE_WIDTH_B(9)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({1'b1,addra,1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,dina}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:8],douta_array}),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:1],\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_n_71 }),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ena_array),
        .ENBWREN(1'b0),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(ena),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .WEA({wea,wea,wea,wea}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module bram_output_blk_mem_gen_prim_wrapper_init__parameterized1
   (douta_array,
    clka,
    ena_array,
    ena,
    addra,
    dina,
    wea);
  output [7:0]douta_array;
  input clka;
  input [0:0]ena_array;
  input ena;
  input [11:0]addra;
  input [7:0]dina;
  input [0:0]wea;

  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_n_71 ;
  wire [11:0]addra;
  wire clka;
  wire [7:0]dina;
  wire [7:0]douta_array;
  wire ena;
  wire [0:0]ena_array;
  wire [0:0]wea;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:8]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED ;
  wire [3:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(1),
    .DOB_REG(0),
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
    .INIT_00(256'h6D615B4976665766694F5365645B5D5D56515C54643E534D525D4C585E515E59),
    .INIT_01(256'h264D5C4B67383E3F5A5153313359334E4D4763534A46455F6263574D57543E52),
    .INIT_02(256'h4D565F5F715454494C3E3D250B21413B45464547676D77515F33555169745A54),
    .INIT_03(256'h2C3C1D2425294237282E32364E5730413B48551E2D37063C18243C3526453D4A),
    .INIT_04(256'h271721392424353349333D334A614127463F6A6968553F3F482D2A1843371C3A),
    .INIT_05(256'h412E30482C2D4C47383735343E3E352B302A23263E373B34483E385746293036),
    .INIT_06(256'h60729E3F4C23554A2F3A2A393AD3803046553A44323B652E44572C192A24293A),
    .INIT_07(256'h6D4D4F27622D59634E563F54514E587153656D5450602A5A64414FAD51674E27),
    .INIT_08(256'h44406E83514B7955464957624B344E6C4C575645523F6C7744364069544D3137),
    .INIT_09(256'h592956575247485D55895C3863504D635F594E59724F376463EF5B2F51533A2B),
    .INIT_0A(256'h506177295C3E243F66585C5B585F5D5447543D5F5A5A5B543C56415C747E826A),
    .INIT_0B(256'h5745455C5760294F69624A5E694C4D6550834E4A4D46525C5D53454140B94D5D),
    .INIT_0C(256'h4E505647383B3F693C4BAA633A7A81634F4A694C6B36585A46535F4A6C465342),
    .INIT_0D(256'h54603D814A385B4D68925C47415175476F4E635A52726A53543C6D3B5C47304F),
    .INIT_0E(256'h2666423B41554E5A3B4F3F2462643A436949285939712A396D433E2E6A587D3D),
    .INIT_0F(256'h33383F5B82565B6247296463642D3248445952687A375D5B68664A652E646D38),
    .INIT_10(256'h3A2760397744634B49785C514B6F5A5C5C35363B539B2F505A5967635D564838),
    .INIT_11(256'h4C3D68A6A254645B4C6E4D58305D575A455652745C464F4050504C7E584C5E52),
    .INIT_12(256'h576A47655D545873555A437C59467F7F545433425A5683773F7E4B513A577044),
    .INIT_13(256'h5E4F425C4361304B7D45315F8C5945792C41764656496A622E6C4050483B6254),
    .INIT_14(256'h46455E454B43582D4D53205A5B644B553E606B55584F565D43587A70415C483C),
    .INIT_15(256'h2D5253656138FF4840534D3E4C8966516A4F335771373469314E516C292D652D),
    .INIT_16(256'h524F594B585656524A5A53451A43253C518860344F55624F697747304E663E5F),
    .INIT_17(256'h4D4A46425250232A38523B524F1F623351815B5445605948695D445F6B626D47),
    .INIT_18(256'h424C2D515D33333D4D595B2F4132422F453B4D484B334652534A48554F53715C),
    .INIT_19(256'h4E1929152B2A3B453900312D3C372E826C333F3853594A5360514B4B1C0A3D41),
    .INIT_1A(256'h505342345B4D47242831393C23301E3F5232433C3A41455A5D4E4C472B27500F),
    .INIT_1B(256'h4F5D3622405831335B46391C2944292C432D63322044353D3D63535C3A243A5C),
    .INIT_1C(256'h7A8464986673607B3C645E675134334C20255D55573C5D5618457C412A2D2845),
    .INIT_1D(256'h5F43454229225344352A2C392232364D1F5A312D1D5D54403854657882927B51),
    .INIT_1E(256'h374532563D413732264559454D4132463B2B23314D565D2F5337504A68523E44),
    .INIT_1F(256'h5028292F51243F58623F424D512C433D5353474D684B4D592F2731374B564F4B),
    .INIT_20(256'h6A4D6849515858494849453A534E3C57605B3C10513C5354642D3039523F4435),
    .INIT_21(256'h09383C3D1A2B5523322E3D365157546D6F415958693D36534B5E533C3746424B),
    .INIT_22(256'h3B4E4B4C4C65306C39425B3E292B253A38333954544728363A5E4C3D464E4630),
    .INIT_23(256'h304D6532484731222F3D67382A2F735D67394C233E3B2443594A46523E624B3B),
    .INIT_24(256'h2C305731504B39363B4C352F4A281C41443621303F505043262520354C3E5F61),
    .INIT_25(256'h4D434A283F3B522F4B7F2548294B6030385138304043515F2D4E3C3849292E5E),
    .INIT_26(256'h46302D4C6C5A643F42367E4F4D33302B344A524771614655C053313D462D4245),
    .INIT_27(256'h3A7D4C4A9442144B3E3D463E612A5E5B673D4063465B44423926653A513B3656),
    .INIT_28(256'h54A94939735E4E693E4836623B393953493B32404C3E213B5A774F6E3F3B5466),
    .INIT_29(256'h424444523851664242413146566B594860503E50697E5149474E8F5047694552),
    .INIT_2A(256'h7651363E4E582A493C5B3A3A77473B604D394A383B503C69555D7A355B2C3F46),
    .INIT_2B(256'h52643532504C4D186521326352363B654095474A4555574C3A213D5E463D3455),
    .INIT_2C(256'h69777D435D5251425258463F5959534A556F3B3B532A3F4676433A6447414256),
    .INIT_2D(256'h351E393F5E59475553473F485635444247625B7183598E285D66413E344E2F4A),
    .INIT_2E(256'h37315C8037473A415C421F7F44543D51693A4347236261342854364342643652),
    .INIT_2F(256'h372F63404A3A70547A445252304D1639525A714334395753332E43675C505C58),
    .INIT_30(256'h4C4252252B5654424B69416351493E433A3F4D423F5863522B374E3970656D59),
    .INIT_31(256'h5D6A4D8E504C516F61484F4E6D624555428D785A316F565678772D412F704B62),
    .INIT_32(256'h353E3D3057484B59283F683F4C4463711A6F475F502B3B6A552A5758582D5C43),
    .INIT_33(256'h4A64165453796639374B4C3947434A343E534F4A3C4147624A6733533B393E48),
    .INIT_34(256'h466C5F536F463B4D61434D5F503C38304B4D3B7D474B84557A426C6F8F4F5654),
    .INIT_35(256'h215C4B48321D303D4480644568414E345C454141584949523D584C386C3A5047),
    .INIT_36(256'h7C989B7589429678858D8F917A69616A75FFB9B8B5CA8C997E55567D937D495D),
    .INIT_37(256'h4473552F47405D3D5434543862436D5E4B6B797A9A8C91916F3EAF667B8886A0),
    .INIT_38(256'h473C2A4B4635554A4B3F4D393A30572C5B719966626E559A5D8D687385464026),
    .INIT_39(256'h2D3C4E341F31324238463D57363F49494E3F582E38292A333746312A252B3342),
    .INIT_3A(256'h525F5D566861535935582844514D40372636584F4841325A38454D4E3A423821),
    .INIT_3B(256'h432A35374D313B4D3D2E4640563C48414A4F5842383F3E4E5043485341403137),
    .INIT_3C(256'h15634A2F293F443C5151555A3951341E25494654424455413E535717485C5C4F),
    .INIT_3D(256'h5941524E4850374F50502F4C4D464045472B302B34354D35434C3C3232455330),
    .INIT_3E(256'h4A3B42465C584049473248382D5B49515E4A5C593C57545A554A5E3421595548),
    .INIT_3F(256'h525335413436433D333552373754513B3A3F43432D3C2A38342D303B52466B51),
    .INIT_40(256'h282F2845483F473D422D223B344339413B3B4F44504E4A5145443C39553F3E2F),
    .INIT_41(256'h433144352A273134333E255B3A4731434A314E3E4F6B4A251C31253625274539),
    .INIT_42(256'h262D57343636433F3B48272443332F3440334E3F3D4A405157443536464F2936),
    .INIT_43(256'h35231B31292625363E3631515B54453A38303D4B3E3452273338344C45374521),
    .INIT_44(256'h56454F4C3342402D3F452F3640444B45363E30422B3E472D303E3C3B4E302D3E),
    .INIT_45(256'h314F394178532A68614D6A4068534D416A3B3E944C2374365443303720524736),
    .INIT_46(256'h7A423E314941434270523A314A4947525871423F3A5AC9A84A85334A58445C57),
    .INIT_47(256'h626F4D39453557595239443A395554556E7144615F387A404D86604A424C2F7F),
    .INIT_48(256'h453F2A315F3D8A47566235425D595C79313561468156B3F79A673D224043442E),
    .INIT_49(256'h45443C48563242447D9A3A303B456D5958546B3C5E50414D496759525A723883),
    .INIT_4A(256'h383F5F474F3A774E2E6378363646665555603693874539405F694C366A455F5D),
    .INIT_4B(256'h59552B72717F545636374540375B553F4E5C7D6C424C1E6C5335374F2D514853),
    .INIT_4C(256'h3E5A87457B5A2E609B4A246F4A495B2337497B495E3D6F5F8B43743A49934959),
    .INIT_4D(256'h3C744B51514053914C41474655594E36524637324C64444A485D643E7D434D4D),
    .INIT_4E(256'h6746653F365436488984514F7E3F586F51551B7F493B347A7C484171584C2340),
    .INIT_4F(256'h51283C376F6F485D533A2F505A73A04B354867596041635F5130BC364F60497E),
    .INIT_50(256'h3F51433E666838493C35B16861415936675E5B4F4F71638F525D5D6921555B36),
    .INIT_51(256'h5F30683F5841845130313C974A23625170321C41436355535E3D454D5C7B4F60),
    .INIT_52(256'h2B6C7252453F445B4D88635E3641431E4440677D685A2839605B2E3B38503D67),
    .INIT_53(256'h494384555E523A4E4C413C7D4D463D5B395D645F8A325236654A25484C50B057),
    .INIT_54(256'h3788503D992A57434776C13BBDA1746D3F4A46616A3840334C6B42478F5E4849),
    .INIT_55(256'h617B505F605C514D71735E8C806A6A8E70547E676E775C5D6D73324C514D2B54),
    .INIT_56(256'h5C4D342F513DBECEC892725A41537CA26F2D564452763B567A706366542D5E41),
    .INIT_57(256'h434F6640485C6248874148433B3D30464C414F4B4B423636504A3F313338542D),
    .INIT_58(256'h2A5E4A5D6851515D5076536A666E6846324D4D614645464150405340594F3145),
    .INIT_59(256'h7B7B3B404A4360383C49455E4C6E5A5B4A536F562A54382D30394249353A4941),
    .INIT_5A(256'h713A264B3F53575934463D463C49334132504A4E4647444C839383609A8F948C),
    .INIT_5B(256'h4A454D473F4729514582686C6656656E6E795761576B6233645A4557673F3751),
    .INIT_5C(256'h3A48433E56413C48393F474754504B505A5643554F4C5042472C433A423B5753),
    .INIT_5D(256'h534B51464B473E393C3C443248404B40403D3A485D37323846454D3F3A373642),
    .INIT_5E(256'h413456424F51534856474C5748474542474F393A453E4C61415F4C3D5651395F),
    .INIT_5F(256'h554B314F404B475F4C5047424B614F5F5C4B5758564B625C565455434A524553),
    .INIT_60(256'h573D274A29383F414050464A605A57444A3F44354743494F3A4742274C464450),
    .INIT_61(256'h535A51414F4B5A6C7E6864706D8074736E966E7D77847F8395997B872C383B3E),
    .INIT_62(256'h3B4D5D5959302D3D3746303751374B39283A4425334A573A413D5F41483F5163),
    .INIT_63(256'h4E474B3945313541324A3C44474C3B29372D4231403B352C303134353F325659),
    .INIT_64(256'h4B4B54523E6160483D4049603555654D363D493D5A31483F505F4661594D3754),
    .INIT_65(256'h474A404F4757454C4D6440603E4F71504C6C41443E1B534B303C4F4755693D47),
    .INIT_66(256'h4C45503E364C56455D3E36526C3E424955525B443654426457414F3D404F4F63),
    .INIT_67(256'h4A63303850435763462B564C55574E5C6C3948363934412E4E50404D4451585F),
    .INIT_68(256'h44384C3C4D435F4D3B58593F4549703D46512E46454D264C4B4B3158474F4936),
    .INIT_69(256'h4D3D6058344B63512E582D7A254A2C4D50504823547A33474952425A515B3B68),
    .INIT_6A(256'h4F5D5247444725492F204F753F384D51723B49422E3B47453C49474F4C3B465D),
    .INIT_6B(256'h6F5764605951603F35405B5079467A52454154344561453E4F6735573A564F57),
    .INIT_6C(256'h604257622F61625A4B544F454D344959384753424E32574944334849444D2E30),
    .INIT_6D(256'h6D513939474048544A28694D4542425C564D54475E3B385A3A5153403E465159),
    .INIT_6E(256'h424D324E3A5B4C3C4C2D6346533F456055285D48684F3B474E3B393D5C532E88),
    .INIT_6F(256'h334450704F2C6233354B364D3F34523A545A3B5C4B4A2F474A3B5B544A5F4760),
    .INIT_70(256'h8033543B4F6659474B4A45616B4C4F484338413361434A515D4E3E424A495352),
    .INIT_71(256'h31387A7D645A57412F4F755B4B574B3A46705065545F515D914849433C3E4059),
    .INIT_72(256'h525E4E4F453E57312F4B4C4D4D372B465F323D5359505F58433F5E44482F3A48),
    .INIT_73(256'h69664936666F5F476C323C5F4335504131433142572C3A58593A3E4A694B404B),
    .INIT_74(256'h40312C504C385663543B563D5D475157425251545853444641404A565E4D305D),
    .INIT_75(256'h587428323A384B61454245413B425C51565E5F4F42652D50373346433E414348),
    .INIT_76(256'h414B454F5D573748433B605B45404D385B53465C4F5253485B5D5554BC675468),
    .INIT_77(256'h323C3A272B28162B2A103D405B587C472C6C514045324E564F5C6F3A3A3B5338),
    .INIT_78(256'h4727374C4F4D4B36442B44402C2E36322F4E384B354F57474A3731443D51413A),
    .INIT_79(256'h374E20494B4941363F505D3B413C353452504A4643383F30403D3B343B414E46),
    .INIT_7A(256'h3B423E674E585222465341263230495344414C4A5B4532494831312F3A334737),
    .INIT_7B(256'h4F475348666D54605C4B42492F2E393928504D2C243A57453D4D3B4247371F2C),
    .INIT_7C(256'h4C4F4448545E6456525F394A4B592C334C4A46394D38394C38353940433E3E2E),
    .INIT_7D(256'h4C4737504636473F483939435738514E473D3E585C4C5051474C42434546614C),
    .INIT_7E(256'h3255414E394F47482C3B4A3E4C363B413B3C3D40373C45434343574D43554734),
    .INIT_7F(256'h4631413A474A442B2D181F271F2F2D3235333950484F51464A5845525053504A),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(9),
    .READ_WIDTH_B(9),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(9),
    .WRITE_WIDTH_B(9)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({1'b1,addra,1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,dina}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:8],douta_array}),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:1],\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_n_71 }),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ena_array),
        .ENBWREN(1'b0),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(ena),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .WEA({wea,wea,wea,wea}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module bram_output_blk_mem_gen_prim_wrapper_init__parameterized2
   (douta_array,
    clka,
    ena_array,
    ena,
    addra,
    dina,
    wea);
  output [7:0]douta_array;
  input clka;
  input [0:0]ena_array;
  input ena;
  input [11:0]addra;
  input [7:0]dina;
  input [0:0]wea;

  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_n_71 ;
  wire [11:0]addra;
  wire clka;
  wire [7:0]dina;
  wire [7:0]douta_array;
  wire ena;
  wire [0:0]ena_array;
  wire [0:0]wea;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:8]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED ;
  wire [3:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(1),
    .DOB_REG(0),
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
    .INIT_00(256'h4F3F3A3542524F59525E482E514653425D4A413A49451E4A1E2928442B282720),
    .INIT_01(256'h293C314E3E343F4D5D54532D3D6E58454C4964554C464359423D464449434054),
    .INIT_02(256'h3B46484D44384732283047394B3F492D383E403F453A455443394D494E403E3F),
    .INIT_03(256'h684E24A35F39592A224C353C20443F2E406E41603F32384F285A252B13393439),
    .INIT_04(256'h766A6131563B756847C12F2D886068465C5D5153AC4D312C30645C3D5C6B643A),
    .INIT_05(256'h375B5C3345416D43319E9A3149453165E68046476D2F524E6C333839453B433B),
    .INIT_06(256'h25467C4D567585B88B6A2E314F4333324D5542532F3D6C7945334D394F564B4C),
    .INIT_07(256'h5E6D6B446C5348522D64755959696F323A5847425175704C5C57505647463954),
    .INIT_08(256'h34694F9B335E441D663F2F1B56604B3B554D5663293037435E6C553A253F5F95),
    .INIT_09(256'h3F345B5F385A2C7558453C393E254B42525A499D5320635D416E36534A375B35),
    .INIT_0A(256'h5C6157666239806478435743266C44495B703B547082636E76404D1B4D41125B),
    .INIT_0B(256'h39214C35499A193D3D5E262EB35A323448288F204B613370C761415E50475723),
    .INIT_0C(256'h33574C7A555131915822466D5A35224F46904F5B283D4B666D476B6C27677337),
    .INIT_0D(256'h4126653A6846826D601BB62C677746766D4F4551355D3B8E6F8E785641642857),
    .INIT_0E(256'h79363A2A304D50545A5B1F9949574860362E66796A8336404C3E45596FA66F5A),
    .INIT_0F(256'h44394F51478A628269B53C42403638614948313E29714148565E8C7C39437A3D),
    .INIT_10(256'h383E28A5604D46346E6D3F164B5E365C403769444547A84E4E5A3D8121256422),
    .INIT_11(256'h2458734F634526307E4A2B76464E8958265B664C6D6946924478778050323D37),
    .INIT_12(256'h3E436D424557504A24554C3EA5583D41495055903C2D5436504F25793A3B4B28),
    .INIT_13(256'h6251717C60484D45506132514D3B485A767050446C2A404A4D79804CA97E6485),
    .INIT_14(256'h5E5752424E4C435D61665B6E363E525F56574C464D5C6E5459564B5C5B596A7C),
    .INIT_15(256'h3D35335970265054493A45353E4E6E485C536931654083AD776B69582F517A86),
    .INIT_16(256'h9452592D483F3543453046532B357A9CA0594D6E595761607D4732432D27161E),
    .INIT_17(256'h415450617D634779415157556558664B663E60775F6B7034202A763338403F49),
    .INIT_18(256'h8C755B91847D545F3B35376A2F233326440E4C4F524B4A3E5361694F304B3D4F),
    .INIT_19(256'h4252592D5E3C49521B295543534555864F5F4A90C85E945616446020424A6F53),
    .INIT_1A(256'h6B684F3723856AB9493C515E5A77635545903D6338777F5762354E583830344E),
    .INIT_1B(256'h4E546B77616A4F77485A5F67795A695C5760544A6568697A5469745B6C6A5D4C),
    .INIT_1C(256'h5A5C59715559716D635D766B635D665C6D535E5A614F6A5C4E5F50516249595D),
    .INIT_1D(256'h636573596D71565565715F65615F43566667596D696E676667604F585A486C66),
    .INIT_1E(256'h56413D4534335E4441484472786F686752493F575B68725E5478674D59585A5D),
    .INIT_1F(256'h3B27392E274142261A2A31196663344A353C3C6043442B3A5550676646646D4B),
    .INIT_20(256'h766D7B82655C4D2833533069535F394A6C1A0C3A192F30001A0A0B2A2649304D),
    .INIT_21(256'h5D544E594E4D56524D5560647B4B656872604B647E626F53585C637340675D60),
    .INIT_22(256'h4E30465B2C4936424F435E5568664D3163595B4D3C5D5C4156546654474B5B51),
    .INIT_23(256'h3A34464E4E564445474C5A615D3837434F5643546F30473B3F555362334C4039),
    .INIT_24(256'h3A5F5E46515535325656533F563549503D344A5746453F364B2E584135313F40),
    .INIT_25(256'h4C564C36404137593C322F48586746475F4A4E382F423769475136614B4E4734),
    .INIT_26(256'h3C514E4246555B2943443F3B5E56423E3E632E416E7D50433B243B4C484D4147),
    .INIT_27(256'h4854264C354B5352464340542530535D48312D4825484D556B52502263433D40),
    .INIT_28(256'h36493B4839484431483B6742573873483943453C4C5D324365454F56545F445B),
    .INIT_29(256'h6260373766373942313E5A625644556C5A5D5E4C5249405B473B4C2D56456050),
    .INIT_2A(256'h32493E532F554955655D554F3E4B312E3D42472D563045335C61544B2E45363B),
    .INIT_2B(256'h46282E345455494822612D3A46305E414E653D614A5C5540446E5A395643654E),
    .INIT_2C(256'h513A4531484D58515F474F5C2D414E313949424A504E394D564D4E883A3D5D50),
    .INIT_2D(256'h2F4951793C424C32405248455E2C4B48525654654444494963425C3155502759),
    .INIT_2E(256'h5F415C635357564C4D5F363C34413F36575E3839486944643F4A5F524F2E5544),
    .INIT_2F(256'h393C20164B533C602931485A842F385B4374725E323B584B611C56611F334F58),
    .INIT_30(256'h3F284944684D574C2E535B4C6E4B4F5C387D56553D4C3D395655324F534B2C5C),
    .INIT_31(256'h274C4543367546705F354A553A2F234333634538234C504C464640354B403C43),
    .INIT_32(256'h395A3E474430465D69494C544A435C5259443B2651564B46413D362A475D402C),
    .INIT_33(256'h1B2728295831292429483737333A29312538163928375B3D32342F212C2E4632),
    .INIT_34(256'h5262623F3749572C552D463E4D334C412E3F3534392B452C2B502A2A2D332F1D),
    .INIT_35(256'h684B5B5E5D615E6161212E4729384B307145464C494A324E462037294D172937),
    .INIT_36(256'h6763424A67694E66553A353F4A3643554C45493142473F475B2C6635584E6C7A),
    .INIT_37(256'h57455D6A5B61696255522D51574E3B715B605F7466494260564A5050523A3F41),
    .INIT_38(256'h47262A2C38276785394D42324E433A5F6D59687D8B4C485A2A6858484C673C37),
    .INIT_39(256'h3E3D493C28674356637962545A5C623E3F412B4E4A4A4D46463F32343E5A4E28),
    .INIT_3A(256'h3C395E44494A45595A452A394B3E305147545F423347304F6D20261C183C4648),
    .INIT_3B(256'h44324A2F473B2B2F3949463C3C4256563D233C464E5745613E5F3A2D312F5256),
    .INIT_3C(256'h414B5545514D354A4C4217366442785E68423F413B442F243D464F304B3B393E),
    .INIT_3D(256'h945D5F4D513D4345457F2C456030353C58425254334C3446503F444D425B515E),
    .INIT_3E(256'h50394E2970824F325E4563676B6A3962807A5E693E6C4D806199A36D62AF8772),
    .INIT_3F(256'h7F58394C6D58342D56555251635B574A6547443D636150605F4856335057334F),
    .INIT_40(256'h7F939C71443F4A4358606279814F9196626458575D35452B6C6A635355405247),
    .INIT_41(256'h2B58133048321A27373934578B3440A994B9EDC3C7A78AB0A7BBB09ED5BB99B0),
    .INIT_42(256'h35604C643A4D394A3B4F5D5E4144434052434C534144683A4D3B373D36514527),
    .INIT_43(256'h5B694231473E4A574138454B5C38404B413A4E4141613A3E554E36564D414452),
    .INIT_44(256'h395F3B4E5A3966524936652C2B5C5564544F524E3C5E3D4A2F4D514C5C2F3D55),
    .INIT_45(256'h3935282D5E563E35584B40475947565849323F325B4B454D52534C3C46454F32),
    .INIT_46(256'h405B3E624539384C543F1F51206D4B305C64603E3A4831374C36474553633D4D),
    .INIT_47(256'h454E624F4E42554D3958465D4146433A513E485755582D535349373C414A4C4E),
    .INIT_48(256'h4E48504A4B58475E3B4D604642474C53475D49614747445F545C354835465839),
    .INIT_49(256'h4F615352535129304A3C425B54435F1E4B56584055464D61455953264A3A3936),
    .INIT_4A(256'h4A3A4D56543F3D594854605347573B34484D4B341F494F563A45454242583355),
    .INIT_4B(256'h3A4D53532A5E3D514A58354F462F3E3B4B513B44533E4E514521543C4A354259),
    .INIT_4C(256'h4F293441644C4E3754503052474E5235483D673971413B4F303A474032502C3D),
    .INIT_4D(256'h53534D414C6E4D46424A444A5443494A5244554737484C414A5E4D434966343A),
    .INIT_4E(256'h543B5E40513E4454504A5541292C4065432F2C4B5A3D4C5D3E455C533846454A),
    .INIT_4F(256'h2E534C4463425A69414C525A4A4824393D53384152542D514641341A5F5F575F),
    .INIT_50(256'h443F54535740354C3D4A4B533C39634F3C60575D5B4E4741384E4C4E5F4D4C63),
    .INIT_51(256'h4C5D49364E54485F54564C385B4B4E4844282E4B4D59432D414A37424E553361),
    .INIT_52(256'h53392941373942312B5333594D4E403F33393938493E464D5831523F493A1475),
    .INIT_53(256'h4B3D3443554A5050404E3545433F374B3B4061444E4F2D3F4D59444D46454F36),
    .INIT_54(256'h652D2930393B5E5147634244514F3348424465365C4938593A4A64462D403C2E),
    .INIT_55(256'h7D46685D52495C525A574E36484746415F5A5F536A6D677367675D71805A4B66),
    .INIT_56(256'h56595150575F4B7356535157684D4C486B5A40425E5B48546C7D5D5366555568),
    .INIT_57(256'h41514046443E48565473666E6074556F455259634955493C5548645D3A6F5E68),
    .INIT_58(256'h656956526A3D445052594577605D57404F6D4F5049505A5D3B28505F30515A44),
    .INIT_59(256'h353C483A4B3D41314A4744243D2F312A4B4327282147393F57424A4F42605B72),
    .INIT_5A(256'h4C3C3A43453647464E3E4849494A5348383D3A403C4C353C36484C484B3F3939),
    .INIT_5B(256'h515043394439494A3B363D30423B443D3E383A44493A3840402D39374C594D34),
    .INIT_5C(256'h3F344C3444323837303B522C5A48434235503925433B2E453827534850463949),
    .INIT_5D(256'h423045524D4D474D4F3F604F4652624C454B504F6656534B54373D4F323C3E40),
    .INIT_5E(256'h555D826B6A5B69576D5F68716A6171667069766B585554656A4E734D5258422D),
    .INIT_5F(256'h464F4D493E3F564F494E43392835324B373F41521E48413F585C563D463E5867),
    .INIT_60(256'h455441504E4C45435168575847565E514257544A454844445E5A575A5A48543F),
    .INIT_61(256'h31254C4643295322603C54604A5A424E53583B3736454A313E5A54645230414C),
    .INIT_62(256'h495F6643301D4372334338453B5036523D42604051501442383B546C58484D3F),
    .INIT_63(256'h463742385A3C5156516B26373742484151586043642B572769564857405D3D3D),
    .INIT_64(256'h6C4C4E424840394538456C52406056554B47373A4F4E5C43463B574B3C385D5A),
    .INIT_65(256'h263149501F3C46564140392F4D5A313C3A3452541F3C42483F513C544E3B5B33),
    .INIT_66(256'h4C814171564243224551355D46574B4959353340427E4F2641464A4C54375158),
    .INIT_67(256'h2C513F45493C4E386549354158284156794A2B3A523A453F403B3C5946493D2A),
    .INIT_68(256'h433F5E4C6B3C43323438593E213F354B4B3B2C463D3D2F5D423B474A62684764),
    .INIT_69(256'h373F51402C47492D283F484F3F6438604134384B5E3C5A493F4B5C5A533B454E),
    .INIT_6A(256'h503721674A5430454A295A554E5D4B5643443A5A3E4A314C422E1C383C634728),
    .INIT_6B(256'h4C582C3651875A3D42464A3447513D5D3F3678415668514E45553D68441D6647),
    .INIT_6C(256'h484B4C4B5645443D3E61504E36523556483C3B4932384B3A3C5C57363837365F),
    .INIT_6D(256'h43455B4A33271D3754334C3B2E644543485F4448484A43414C58273E426F3F4F),
    .INIT_6E(256'h45374233664533635F5446585022764E384E4816295A37355A32522248495149),
    .INIT_6F(256'h324D4D6C344E56475F514C4A4A6748484C384A6766636244526B4A4D413B4154),
    .INIT_70(256'h432A3C40614B5A623E462B643F3E434E394D3C538B3F4142504042543C405940),
    .INIT_71(256'h5B414B5B605C3A4143444E625F48624A4D33624F2B203B5A4D5E6D495C306764),
    .INIT_72(256'h37504F515C54593F53578CBEA5B5FF809BA4837E61B86CD17967746B747E7278),
    .INIT_73(256'h58995560594D464B58877B8F9172795F37443E3C435A3F55542951534D3A396D),
    .INIT_74(256'h6D666C636E6E6238393E3C3547534C533D4236435832444E4247454443404E7F),
    .INIT_75(256'h5E5C626C6A54545D6B6E676C435F595F5066615C544E5563606E5C564E404872),
    .INIT_76(256'h504B783B3B4F5050482B3843383138285B53644D545D58505961406953716870),
    .INIT_77(256'h2E6245524E595F735C6B57546F7E6A5B606E4C5B40584D3E47584140303D5855),
    .INIT_78(256'h4A444032433D343E5442422A464A4A393B353D31323A3D394F2A3844442B2C37),
    .INIT_79(256'h3627454338493E3A49413142454341362C53345D51444B3B3234282238323437),
    .INIT_7A(256'h4B36483D3F3648352F2628483F363A35353A2E433E4D483F3A49364C47363C4A),
    .INIT_7B(256'h3965404A7155564235624E304B3823363125443448364C4842463D4737463943),
    .INIT_7C(256'h383552393D4C4829422724494936402C2C25304B4C3F4B3B303F5A3851302D47),
    .INIT_7D(256'h4843614557564F54535A5B5B696343646452644E4A4B3033392C504E354E5553),
    .INIT_7E(256'h262F425238393E492F4149391F484A2D48546954424266564E445D4751433F67),
    .INIT_7F(256'h4651484F4443481932333F3A413E3B473C422B464C3C4A48564F474A3944453C),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(9),
    .READ_WIDTH_B(9),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(9),
    .WRITE_WIDTH_B(9)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({1'b1,addra,1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,dina}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:8],douta_array}),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:1],\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_n_71 }),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ena_array),
        .ENBWREN(1'b0),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(ena),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .WEA({wea,wea,wea,wea}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module bram_output_blk_mem_gen_prim_wrapper_init__parameterized3
   (douta_array,
    clka,
    ena_array,
    ena,
    addra,
    dina,
    wea);
  output [7:0]douta_array;
  input clka;
  input [0:0]ena_array;
  input ena;
  input [11:0]addra;
  input [7:0]dina;
  input [0:0]wea;

  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_n_71 ;
  wire [11:0]addra;
  wire clka;
  wire [7:0]dina;
  wire [7:0]douta_array;
  wire ena;
  wire [0:0]ena_array;
  wire [0:0]wea;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:8]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED ;
  wire [3:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(1),
    .DOB_REG(0),
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
    .INIT_00(256'h6B563A59555F4B5B373B4A2E2E3D473C4D4A5F576E545568697E713A22384444),
    .INIT_01(256'h4B37654E4D4974513D5C51456A71543B4A414B53624C30414641543A50585225),
    .INIT_02(256'h5B445953335D5B67305D6C606C3C384E6758443D3B3153425C4A38494E483B48),
    .INIT_03(256'h573D595653775A675C654F4B56463B2A394246533A4D4E704D2458514A484B43),
    .INIT_04(256'h4A53534E2C3D3E424D46463E41476855433C39485D5368385945534762384D5A),
    .INIT_05(256'h515F3C5D4B4A4B546B433A295B5B5646526B4C3B3F3A474B424F422D3B4F4F61),
    .INIT_06(256'h57533F4728413C69573F33565B4B4A2F594F5368573A485A35754A563F484722),
    .INIT_07(256'h4D53405A4D3846465A4939503C4D3E32574257415D6A4E6A2D473D4632545E48),
    .INIT_08(256'h37503B234A65464C33403C2A654A444550465F314A423F5B5E3D3A4A5C406134),
    .INIT_09(256'h41365055634C5A64503C6865412D4638565834584E3548545258473137544F32),
    .INIT_0A(256'h523550375C3F5848403A733441594E6A4E3B5043374B5645563E4249583F3146),
    .INIT_0B(256'h6152434A39634D5B455A3F4F2E455948525360523765304841432E4E6F604E3E),
    .INIT_0C(256'h2E4656503A606E5A606647474B3944624E4739415E6745505E4657653C48563E),
    .INIT_0D(256'h4E574A6F534E4B5E5E633728414651433F53602C4F4B635B3C45415943314B45),
    .INIT_0E(256'h4847764E4F463C4E53514D544A60694D3B465955575E636837734D463E4F5840),
    .INIT_0F(256'h2E42424A64533118404465526546464154433F6244404A3E4545516D33494335),
    .INIT_10(256'h5E505D65774D4939464B54492D352E406D686A285A47504C4E5A56336E706069),
    .INIT_11(256'h6D4663726FCC88438885536E5F475B5D85747B989457635F7277786874665455),
    .INIT_12(256'h6B4E49427153635D4A2F4334455E5F43613256514E416D6A57596B575371665F),
    .INIT_13(256'h392F272E13492223202C23203414471D22303D282C421B235475646A605A5148),
    .INIT_14(256'h313C4748423042443129291C27341C332F1C27312C2E3538313C2D353C322D28),
    .INIT_15(256'h172E2B182C2A0B3838662F4237313A211E2F3D3C364A43394A423848362A262A),
    .INIT_16(256'h22363339372F3E405737303933B871A84A656D304931252809251C182F241C18),
    .INIT_17(256'h5C674046372778322219112D0C083B3D343C101F171D0D1F084B48422F373E3A),
    .INIT_18(256'h5573505F6F51462E57544941475230644E4B413856564E5A5E3B2D1C202E281F),
    .INIT_19(256'h4F4550205F546570515B6C1B514C3E47584E503F5133775A5A375B5A4D80766E),
    .INIT_1A(256'h4F38556B523F5C6B485D5258545E64695C54414A884955897B46656D42423F4C),
    .INIT_1B(256'h7D928C9C6D988C7D878185434A503B6F5854388247574778524C70494357495E),
    .INIT_1C(256'h3D4F371149304144363351236C99A999D4F7615179592E49716C6564476A597B),
    .INIT_1D(256'h7FA39B545D69A28E6C6D522752474B4E43223A2A0F32240919322F16323F4737),
    .INIT_1E(256'h4A5B889F7174585F6F815A5369967186627473725C5E493B407E5A6989606E69),
    .INIT_1F(256'h763E305239375048474A232846391B3A3D4339838A71645753586A758E79564F),
    .INIT_20(256'h656D3C53556053575137486551534844414E52445055564A454E505D403C6B56),
    .INIT_21(256'h51645957543A5E59715145333A32575651494D54474A4D4362603F3C49464445),
    .INIT_22(256'h493F594B474D413E3B3F4848573C4F3E44364336445051436F525A3851683648),
    .INIT_23(256'h394E3F365C54534C4A40313B4D61504E526359475A555449624B3C4E5650565C),
    .INIT_24(256'h5A4D44454C4D59594E483D506752544B5A654A443B465F454C4C4E4C65533C5C),
    .INIT_25(256'h6048394157365F43513157565B484640324555453B5552496D4A5E5151645D51),
    .INIT_26(256'h5C4C58514F5A5C504D4E505764585C3C582E584F44584E4B3C55566545483E61),
    .INIT_27(256'h545A474E5C4B546E5E7541624054493F5C43454A34474D43555C53524D524D56),
    .INIT_28(256'h445342485C483C4E3B4C4F5946374F66396751435F5E5A49224E415442554E50),
    .INIT_29(256'h3D4C643E285D563A694957493E493D635D575B484E3D684353523C6845495255),
    .INIT_2A(256'h355A665040595840726444524C6160595158565F3F4C47584C7256466452504F),
    .INIT_2B(256'h4361544B49594E6661583C435F78455144444749522D66425D44395A4B513A54),
    .INIT_2C(256'h613C4A426C686F393E636949543A5A54634B6F5C2D4445436D4D453648575049),
    .INIT_2D(256'h4858426A5D635152425C56553B59654A3A5C525A455647384D7438546B5D3A6C),
    .INIT_2E(256'h4B43594F64593F504C4546625F4D414B3A62504B6F5C54622B5B5242584C3E63),
    .INIT_2F(256'h4A5747585053404F6F5751504B4951523B5E4A3B695F466A504F54633A51564A),
    .INIT_30(256'h6A60584E3D3B453448402B2E474751423644303A34445F5439524A51543F504C),
    .INIT_31(256'h475C3C1E36575E3943443D395B3F3F645556373C37364951426C35314A403743),
    .INIT_32(256'h273D1C40312D3E3C53363E2123295033594C40374C2C242B2F602F43571B3634),
    .INIT_33(256'h3E513E492D45474C4646385229292D3042363E3A3C2A30313B0F1118303E4820),
    .INIT_34(256'h5E58433D433B343244443F3E3D40473C34433A5238302E4C393E3B43363C5C36),
    .INIT_35(256'h423D4834272C263C22162E211F1E2D482646413526433D4B4033375B212E2928),
    .INIT_36(256'h1D1C21251A1E12321643142B1B243528254136544A5338444041473F444B484A),
    .INIT_37(256'h394141404D37424D36393D37464548424D3B363851513E36544836333C0A2E2D),
    .INIT_38(256'h443D3C4B3D3B493D4C424B4E4939473B4B31413B48485249464A484349454141),
    .INIT_39(256'h373B474F4F44463F464534334746464141433C41483A30303F3D402B462F3847),
    .INIT_3A(256'h3934364A3C3B4A3C42414350423C43494C564841414B3F4847514D4D484B372F),
    .INIT_3B(256'h5749524A1930304B2A33323D3A413947373A4746624347384136283A2D3E4F2C),
    .INIT_3C(256'h28305A4A373B4A4443293934423934383E526C5556694455554E47535850385C),
    .INIT_3D(256'h403F461C4F313B2E3E423646544A4F383F382B403B4B4F4032383B5A4B5D3638),
    .INIT_3E(256'h5D813E2F3623383936433D303C3D4A2A42433749402E4421352D432E42353640),
    .INIT_3F(256'h4854535E605255694C3E7C496D654D4C6A5D55664E515E4E4A61534724637C40),
    .INIT_40(256'h61703F3D46605E597A63604949695754666F414E574A5A6E3E55474E695F604B),
    .INIT_41(256'h444D55662C44715671456733436D68654D664F634B455964555F4F6D56553B69),
    .INIT_42(256'h5B603438534D4B6A634752564D44464C4E677C87616C5770516B432F566A5862),
    .INIT_43(256'h56655A6A514C5A535C4C6D4C48644D554263623A7B60494D3F576649536A5272),
    .INIT_44(256'h7061494A5747656B5B65695A6542495D4B464F5E574F553655495C5A5D534946),
    .INIT_45(256'h6C67537361644F5D52576950544D2F514460644F4F582F5F694F4A4D445C6743),
    .INIT_46(256'h4A4A4F4858513352495B4C7061545559524C7F62564559585F505B454C724973),
    .INIT_47(256'h7C5749664A456D4954474A495161742D485A575D525550525C6A414B5F5D424B),
    .INIT_48(256'h5F5D4B60266A59575F638753706D4F68644D5171676738695E595A783A53335F),
    .INIT_49(256'h5362547B5B7A4B446A606B41366170614D52574E59496E524641534B5C6B6A5C),
    .INIT_4A(256'h5F5858384F6456484F4E626D4F5B7F3C7D4657664B626F6C4F4B36604172635E),
    .INIT_4B(256'h4050613B5B8466554B67516A52423E57756F4C4E68674E51656A8268556B4A6D),
    .INIT_4C(256'h4C4C616A4B4A4E5E5664645D4F43385C774055605C59595C56504C294B5C5554),
    .INIT_4D(256'h79824B66473E535F37464474584B6654606463785C715E3962674E4B5357666D),
    .INIT_4E(256'h5C634C486A547D88485D3F3A45695C6A3A5E7D65605D47474A6D5F685E656854),
    .INIT_4F(256'h564D3A3F645353413E675954595B60414742555658646261686D5C634A36305F),
    .INIT_50(256'h4430493473385672625C473A56525C4D4E365344335C47364B564C463C3C5337),
    .INIT_51(256'h3E513F4B2D243C25605A26291E2914372C3F4A36652259464254543B344C4942),
    .INIT_52(256'h2738473A2D313538501D363A392B374C5241463B46523B391936474244393240),
    .INIT_53(256'h3C335B414B3C3A4E3545504D4A3728444D3752624A1C152A4347272E3738324F),
    .INIT_54(256'h48373C4478304E541546443A2030683E6749413C4D424848486553474E464445),
    .INIT_55(256'h1B5E23692642462D4A49604E34393532385185236348495E5149433D3B2C2B55),
    .INIT_56(256'h53614D445C60643D505C4C3D3E40552552421E1F1B77786D45243E5B4D364636),
    .INIT_57(256'h3D27384245394555383E3A3E4E3C4841333C4A5553503E5D3E4F545E683E5661),
    .INIT_58(256'h5A44413E40534A3B545C37434E483B3C2F3F4D363D4D4C6A434246514848482F),
    .INIT_59(256'h4E343F4755505D3832585B2E5F3F414D3E4B5735484F51463C4F50564D493B3F),
    .INIT_5A(256'h3A4F4B3E313622273C43406C3F4B482A501C2C383C245F3B394131344C4D5059),
    .INIT_5B(256'h4448225D32463D61714E433F3C62434E464764403A363A5C393D713D3E39165B),
    .INIT_5C(256'h5D65466B403F58331A2C5C692F28402E293A4F452F62352E19265F402D352762),
    .INIT_5D(256'h3636276338464C56474831533B4D563A303F403A463B263F3338234B2B3D4442),
    .INIT_5E(256'h4E64866465673C3D593F5765303A743E3E4243383D774442525F4E503A37463F),
    .INIT_5F(256'h644E4C65662D385B71633319554C55563C2D4F2F4F72385547215F3C5C55353C),
    .INIT_60(256'h533F682D3848594B666A503C53486E39776F4552344F446E58453D4A3D365554),
    .INIT_61(256'h3654554FB4455F823D413D5A718B737A715C52435E4B44423D6E3A49433B4865),
    .INIT_62(256'h615666382C6476557450683A39462D42874E45695C7454603B483B2C67344B53),
    .INIT_63(256'h4B42411F4D4A6D3D53533D5D2261343F666027514F3D524B595841502A404A5A),
    .INIT_64(256'h583F5E314C574C42405C6C5C273C43884D535B62465E5A86733B5F4E594D6E71),
    .INIT_65(256'h545046576C4B533631384A3F455376837F2E5849447D27686E6340698975546A),
    .INIT_66(256'h727B604C37727147243155315C6F1E4F40591A3767355A404C57395049713355),
    .INIT_67(256'h67933F4D5B4D4C2C4D4748DC64334D5A6A4A4153504630403A7A304D5D3C6083),
    .INIT_68(256'h5E714A5E6243385667444F59864E6243495A64394D705D6462433E53347B583B),
    .INIT_69(256'h365B8164593F5F497D5574675E67773D46655C5F6260634A4C576A544E747A64),
    .INIT_6A(256'h694A5A83390D263A516344454A5E4745602E5B3C646252668D5046483563454A),
    .INIT_6B(256'h4F6953503F3E3461645030824951406C5A39213752953F945F436752804B769E),
    .INIT_6C(256'h3A4643743E43464C2C71873B6550304D6E36305F574C7361577F60904F374C4B),
    .INIT_6D(256'h515F51436B6B516E3F4656785660502E562E655C60403B455553505554233175),
    .INIT_6E(256'h4E6043505C445869474E70418945544A4F574A463B3E395651726F455F375D48),
    .INIT_6F(256'h7556514D3E4C7B7D5750355D285D5F3A4A454C735E3B5F3E5459645756414749),
    .INIT_70(256'hE74C4E516A5321434B3A33414E2834211D4B4B2F4148534D593037384F3D6C77),
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
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(9),
    .READ_WIDTH_B(9),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(9),
    .WRITE_WIDTH_B(9)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({1'b1,addra,1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,dina}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:8],douta_array}),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:1],\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_n_71 }),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ena_array),
        .ENBWREN(1'b0),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(ena),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .WEA({wea,wea,wea,wea}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_top" *) 
module bram_output_blk_mem_gen_top
   (douta,
    clka,
    ena,
    addra,
    dina,
    wea);
  output [7:0]douta;
  input clka;
  input ena;
  input [14:0]addra;
  input [7:0]dina;
  input [0:0]wea;

  wire [14:0]addra;
  wire clka;
  wire [7:0]dina;
  wire [7:0]douta;
  wire ena;
  wire [0:0]wea;

  bram_output_blk_mem_gen_generic_cstr \valid.cstr 
       (.addra(addra),
        .clka(clka),
        .dina(dina),
        .douta(douta),
        .ena(ena),
        .wea(wea));
endmodule

(* C_ADDRA_WIDTH = "15" *) (* C_ADDRB_WIDTH = "15" *) (* C_ALGORITHM = "1" *) 
(* C_AXI_ID_WIDTH = "4" *) (* C_AXI_SLAVE_TYPE = "0" *) (* C_AXI_TYPE = "1" *) 
(* C_BYTE_SIZE = "9" *) (* C_COMMON_CLK = "0" *) (* C_COUNT_18K_BRAM = "0" *) 
(* C_COUNT_36K_BRAM = "5" *) (* C_CTRL_ECC_ALGO = "NONE" *) (* C_DEFAULT_DATA = "0" *) 
(* C_DISABLE_WARN_BHV_COLL = "0" *) (* C_DISABLE_WARN_BHV_RANGE = "0" *) (* C_ELABORATION_DIR = "./" *) 
(* C_ENABLE_32BIT_ADDRESS = "0" *) (* C_EN_DEEPSLEEP_PIN = "0" *) (* C_EN_ECC_PIPE = "0" *) 
(* C_EN_RDADDRA_CHG = "0" *) (* C_EN_RDADDRB_CHG = "0" *) (* C_EN_SAFETY_CKT = "0" *) 
(* C_EN_SHUTDOWN_PIN = "0" *) (* C_EN_SLEEP_PIN = "0" *) (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     2.535699 mW" *) 
(* C_FAMILY = "virtex7" *) (* C_HAS_AXI_ID = "0" *) (* C_HAS_ENA = "1" *) 
(* C_HAS_ENB = "0" *) (* C_HAS_INJECTERR = "0" *) (* C_HAS_MEM_OUTPUT_REGS_A = "1" *) 
(* C_HAS_MEM_OUTPUT_REGS_B = "0" *) (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
(* C_HAS_REGCEA = "0" *) (* C_HAS_REGCEB = "0" *) (* C_HAS_RSTA = "0" *) 
(* C_HAS_RSTB = "0" *) (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
(* C_INITA_VAL = "0" *) (* C_INITB_VAL = "0" *) (* C_INIT_FILE = "bram_output.mem" *) 
(* C_INIT_FILE_NAME = "bram_output.mif" *) (* C_INTERFACE_TYPE = "0" *) (* C_LOAD_INIT_FILE = "1" *) 
(* C_MEM_TYPE = "0" *) (* C_MUX_PIPELINE_STAGES = "0" *) (* C_PRIM_TYPE = "1" *) 
(* C_READ_DEPTH_A = "20000" *) (* C_READ_DEPTH_B = "20000" *) (* C_READ_LATENCY_A = "1" *) 
(* C_READ_LATENCY_B = "1" *) (* C_READ_WIDTH_A = "8" *) (* C_READ_WIDTH_B = "8" *) 
(* C_RSTRAM_A = "0" *) (* C_RSTRAM_B = "0" *) (* C_RST_PRIORITY_A = "CE" *) 
(* C_RST_PRIORITY_B = "CE" *) (* C_SIM_COLLISION_CHECK = "ALL" *) (* C_USE_BRAM_BLOCK = "0" *) 
(* C_USE_BYTE_WEA = "0" *) (* C_USE_BYTE_WEB = "0" *) (* C_USE_DEFAULT_DATA = "0" *) 
(* C_USE_ECC = "0" *) (* C_USE_SOFTECC = "0" *) (* C_USE_URAM = "0" *) 
(* C_WEA_WIDTH = "1" *) (* C_WEB_WIDTH = "1" *) (* C_WRITE_DEPTH_A = "20000" *) 
(* C_WRITE_DEPTH_B = "20000" *) (* C_WRITE_MODE_A = "WRITE_FIRST" *) (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
(* C_WRITE_WIDTH_A = "8" *) (* C_WRITE_WIDTH_B = "8" *) (* C_XDEVICEFAMILY = "virtex7" *) 
(* ORIG_REF_NAME = "blk_mem_gen_v8_4_2" *) (* downgradeipidentifiedwarnings = "yes" *) 
module bram_output_blk_mem_gen_v8_4_2
   (clka,
    rsta,
    ena,
    regcea,
    wea,
    addra,
    dina,
    douta,
    clkb,
    rstb,
    enb,
    regceb,
    web,
    addrb,
    dinb,
    doutb,
    injectsbiterr,
    injectdbiterr,
    eccpipece,
    sbiterr,
    dbiterr,
    rdaddrecc,
    sleep,
    deepsleep,
    shutdown,
    rsta_busy,
    rstb_busy,
    s_aclk,
    s_aresetn,
    s_axi_awid,
    s_axi_awaddr,
    s_axi_awlen,
    s_axi_awsize,
    s_axi_awburst,
    s_axi_awvalid,
    s_axi_awready,
    s_axi_wdata,
    s_axi_wstrb,
    s_axi_wlast,
    s_axi_wvalid,
    s_axi_wready,
    s_axi_bid,
    s_axi_bresp,
    s_axi_bvalid,
    s_axi_bready,
    s_axi_arid,
    s_axi_araddr,
    s_axi_arlen,
    s_axi_arsize,
    s_axi_arburst,
    s_axi_arvalid,
    s_axi_arready,
    s_axi_rid,
    s_axi_rdata,
    s_axi_rresp,
    s_axi_rlast,
    s_axi_rvalid,
    s_axi_rready,
    s_axi_injectsbiterr,
    s_axi_injectdbiterr,
    s_axi_sbiterr,
    s_axi_dbiterr,
    s_axi_rdaddrecc);
  input clka;
  input rsta;
  input ena;
  input regcea;
  input [0:0]wea;
  input [14:0]addra;
  input [7:0]dina;
  output [7:0]douta;
  input clkb;
  input rstb;
  input enb;
  input regceb;
  input [0:0]web;
  input [14:0]addrb;
  input [7:0]dinb;
  output [7:0]doutb;
  input injectsbiterr;
  input injectdbiterr;
  input eccpipece;
  output sbiterr;
  output dbiterr;
  output [14:0]rdaddrecc;
  input sleep;
  input deepsleep;
  input shutdown;
  output rsta_busy;
  output rstb_busy;
  input s_aclk;
  input s_aresetn;
  input [3:0]s_axi_awid;
  input [31:0]s_axi_awaddr;
  input [7:0]s_axi_awlen;
  input [2:0]s_axi_awsize;
  input [1:0]s_axi_awburst;
  input s_axi_awvalid;
  output s_axi_awready;
  input [7:0]s_axi_wdata;
  input [0:0]s_axi_wstrb;
  input s_axi_wlast;
  input s_axi_wvalid;
  output s_axi_wready;
  output [3:0]s_axi_bid;
  output [1:0]s_axi_bresp;
  output s_axi_bvalid;
  input s_axi_bready;
  input [3:0]s_axi_arid;
  input [31:0]s_axi_araddr;
  input [7:0]s_axi_arlen;
  input [2:0]s_axi_arsize;
  input [1:0]s_axi_arburst;
  input s_axi_arvalid;
  output s_axi_arready;
  output [3:0]s_axi_rid;
  output [7:0]s_axi_rdata;
  output [1:0]s_axi_rresp;
  output s_axi_rlast;
  output s_axi_rvalid;
  input s_axi_rready;
  input s_axi_injectsbiterr;
  input s_axi_injectdbiterr;
  output s_axi_sbiterr;
  output s_axi_dbiterr;
  output [14:0]s_axi_rdaddrecc;

  wire \<const0> ;
  wire [14:0]addra;
  wire clka;
  wire [7:0]dina;
  wire [7:0]douta;
  wire ena;
  wire [0:0]wea;

  assign dbiterr = \<const0> ;
  assign doutb[7] = \<const0> ;
  assign doutb[6] = \<const0> ;
  assign doutb[5] = \<const0> ;
  assign doutb[4] = \<const0> ;
  assign doutb[3] = \<const0> ;
  assign doutb[2] = \<const0> ;
  assign doutb[1] = \<const0> ;
  assign doutb[0] = \<const0> ;
  assign rdaddrecc[14] = \<const0> ;
  assign rdaddrecc[13] = \<const0> ;
  assign rdaddrecc[12] = \<const0> ;
  assign rdaddrecc[11] = \<const0> ;
  assign rdaddrecc[10] = \<const0> ;
  assign rdaddrecc[9] = \<const0> ;
  assign rdaddrecc[8] = \<const0> ;
  assign rdaddrecc[7] = \<const0> ;
  assign rdaddrecc[6] = \<const0> ;
  assign rdaddrecc[5] = \<const0> ;
  assign rdaddrecc[4] = \<const0> ;
  assign rdaddrecc[3] = \<const0> ;
  assign rdaddrecc[2] = \<const0> ;
  assign rdaddrecc[1] = \<const0> ;
  assign rdaddrecc[0] = \<const0> ;
  assign rsta_busy = \<const0> ;
  assign rstb_busy = \<const0> ;
  assign s_axi_arready = \<const0> ;
  assign s_axi_awready = \<const0> ;
  assign s_axi_bid[3] = \<const0> ;
  assign s_axi_bid[2] = \<const0> ;
  assign s_axi_bid[1] = \<const0> ;
  assign s_axi_bid[0] = \<const0> ;
  assign s_axi_bresp[1] = \<const0> ;
  assign s_axi_bresp[0] = \<const0> ;
  assign s_axi_bvalid = \<const0> ;
  assign s_axi_dbiterr = \<const0> ;
  assign s_axi_rdaddrecc[14] = \<const0> ;
  assign s_axi_rdaddrecc[13] = \<const0> ;
  assign s_axi_rdaddrecc[12] = \<const0> ;
  assign s_axi_rdaddrecc[11] = \<const0> ;
  assign s_axi_rdaddrecc[10] = \<const0> ;
  assign s_axi_rdaddrecc[9] = \<const0> ;
  assign s_axi_rdaddrecc[8] = \<const0> ;
  assign s_axi_rdaddrecc[7] = \<const0> ;
  assign s_axi_rdaddrecc[6] = \<const0> ;
  assign s_axi_rdaddrecc[5] = \<const0> ;
  assign s_axi_rdaddrecc[4] = \<const0> ;
  assign s_axi_rdaddrecc[3] = \<const0> ;
  assign s_axi_rdaddrecc[2] = \<const0> ;
  assign s_axi_rdaddrecc[1] = \<const0> ;
  assign s_axi_rdaddrecc[0] = \<const0> ;
  assign s_axi_rdata[7] = \<const0> ;
  assign s_axi_rdata[6] = \<const0> ;
  assign s_axi_rdata[5] = \<const0> ;
  assign s_axi_rdata[4] = \<const0> ;
  assign s_axi_rdata[3] = \<const0> ;
  assign s_axi_rdata[2] = \<const0> ;
  assign s_axi_rdata[1] = \<const0> ;
  assign s_axi_rdata[0] = \<const0> ;
  assign s_axi_rid[3] = \<const0> ;
  assign s_axi_rid[2] = \<const0> ;
  assign s_axi_rid[1] = \<const0> ;
  assign s_axi_rid[0] = \<const0> ;
  assign s_axi_rlast = \<const0> ;
  assign s_axi_rresp[1] = \<const0> ;
  assign s_axi_rresp[0] = \<const0> ;
  assign s_axi_rvalid = \<const0> ;
  assign s_axi_sbiterr = \<const0> ;
  assign s_axi_wready = \<const0> ;
  assign sbiterr = \<const0> ;
  GND GND
       (.G(\<const0> ));
  bram_output_blk_mem_gen_v8_4_2_synth inst_blk_mem_gen
       (.addra(addra),
        .clka(clka),
        .dina(dina),
        .douta(douta),
        .ena(ena),
        .wea(wea));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_v8_4_2_synth" *) 
module bram_output_blk_mem_gen_v8_4_2_synth
   (douta,
    clka,
    ena,
    addra,
    dina,
    wea);
  output [7:0]douta;
  input clka;
  input ena;
  input [14:0]addra;
  input [7:0]dina;
  input [0:0]wea;

  wire [14:0]addra;
  wire clka;
  wire [7:0]dina;
  wire [7:0]douta;
  wire ena;
  wire [0:0]wea;

  bram_output_blk_mem_gen_top \gnbram.gnativebmg.native_blk_mem_gen 
       (.addra(addra),
        .clka(clka),
        .dina(dina),
        .douta(douta),
        .ena(ena),
        .wea(wea));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
