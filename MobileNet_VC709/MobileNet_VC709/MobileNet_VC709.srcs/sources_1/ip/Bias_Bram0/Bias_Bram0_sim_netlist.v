// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sun Sep  5 00:26:09 2021
// Host        : LAPTOP-VQNT75JR running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               D:/Project_UM/MobileNet_VC709/MobileNet_VC709/MobileNet_VC709.srcs/sources_1/ip/Bias_Bram0/Bias_Bram0_sim_netlist.v
// Design      : Bias_Bram0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7vx690tffg1761-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "Bias_Bram0,blk_mem_gen_v8_4_2,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_2,Vivado 2018.3" *) 
(* NotValidForBitStream *)
module Bias_Bram0
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
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [31:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [31:0]douta;

  wire [14:0]addra;
  wire clka;
  wire [31:0]dina;
  wire [31:0]douta;
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
  wire [31:0]NLW_U0_doutb_UNCONNECTED;
  wire [14:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [14:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdata_UNCONNECTED;
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
  (* C_COUNT_18K_BRAM = "6" *) 
  (* C_COUNT_36K_BRAM = "14" *) 
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
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     14.231616 mW" *) 
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
  (* C_INIT_FILE = "Bias_Bram0.mem" *) 
  (* C_INIT_FILE_NAME = "Bias_Bram0.mif" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "1" *) 
  (* C_MEM_TYPE = "0" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "18432" *) 
  (* C_READ_DEPTH_B = "18432" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "32" *) 
  (* C_READ_WIDTH_B = "32" *) 
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
  (* C_WRITE_DEPTH_A = "18432" *) 
  (* C_WRITE_DEPTH_B = "18432" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "32" *) 
  (* C_WRITE_WIDTH_B = "32" *) 
  (* C_XDEVICEFAMILY = "virtex7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  Bias_Bram0_blk_mem_gen_v8_4_2 U0
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(NLW_U0_doutb_UNCONNECTED[31:0]),
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
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[31:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
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
module Bias_Bram0_bindec
   (ena_array,
    addra,
    ena);
  output [0:0]ena_array;
  input [3:0]addra;
  input ena;

  wire [3:0]addra;
  wire ena;
  wire [0:0]ena_array;

  LUT5 #(
    .INIT(32'h01000000)) 
    \ENOUT_inferred__7/i_ 
       (.I0(addra[2]),
        .I1(addra[1]),
        .I2(addra[0]),
        .I3(ena),
        .I4(addra[3]),
        .O(ena_array));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_generic_cstr" *) 
module Bias_Bram0_blk_mem_gen_generic_cstr
   (douta,
    clka,
    ena,
    addra,
    dina,
    wea);
  output [31:0]douta;
  input clka;
  input ena;
  input [14:0]addra;
  input [31:0]dina;
  input [0:0]wea;

  wire [14:0]addra;
  wire clka;
  wire [31:0]dina;
  wire [31:0]douta;
  wire ena;
  wire [8:8]ena_array;
  wire [17:0]p_19_out;
  wire [8:0]p_43_out;
  wire ram_douta;
  wire ram_ena;
  wire \ramloop[11].ram.r_n_0 ;
  wire \ramloop[11].ram.r_n_1 ;
  wire \ramloop[11].ram.r_n_2 ;
  wire \ramloop[11].ram.r_n_3 ;
  wire \ramloop[11].ram.r_n_4 ;
  wire \ramloop[11].ram.r_n_5 ;
  wire \ramloop[11].ram.r_n_6 ;
  wire \ramloop[11].ram.r_n_7 ;
  wire \ramloop[11].ram.r_n_8 ;
  wire \ramloop[11].ram.r_n_9 ;
  wire \ramloop[12].ram.r_n_0 ;
  wire \ramloop[12].ram.r_n_1 ;
  wire \ramloop[12].ram.r_n_2 ;
  wire \ramloop[12].ram.r_n_3 ;
  wire \ramloop[12].ram.r_n_4 ;
  wire \ramloop[12].ram.r_n_5 ;
  wire \ramloop[12].ram.r_n_6 ;
  wire \ramloop[12].ram.r_n_7 ;
  wire \ramloop[12].ram.r_n_8 ;
  wire \ramloop[12].ram.r_n_9 ;
  wire \ramloop[13].ram.r_n_0 ;
  wire \ramloop[13].ram.r_n_1 ;
  wire \ramloop[13].ram.r_n_2 ;
  wire \ramloop[13].ram.r_n_3 ;
  wire \ramloop[13].ram.r_n_4 ;
  wire \ramloop[13].ram.r_n_5 ;
  wire \ramloop[13].ram.r_n_6 ;
  wire \ramloop[13].ram.r_n_7 ;
  wire \ramloop[13].ram.r_n_8 ;
  wire \ramloop[13].ram.r_n_9 ;
  wire \ramloop[14].ram.r_n_0 ;
  wire \ramloop[14].ram.r_n_1 ;
  wire \ramloop[14].ram.r_n_2 ;
  wire \ramloop[14].ram.r_n_3 ;
  wire \ramloop[14].ram.r_n_4 ;
  wire \ramloop[14].ram.r_n_5 ;
  wire \ramloop[14].ram.r_n_6 ;
  wire \ramloop[14].ram.r_n_7 ;
  wire \ramloop[14].ram.r_n_8 ;
  wire \ramloop[16].ram.r_n_0 ;
  wire \ramloop[16].ram.r_n_1 ;
  wire \ramloop[16].ram.r_n_2 ;
  wire \ramloop[16].ram.r_n_3 ;
  wire \ramloop[16].ram.r_n_4 ;
  wire \ramloop[16].ram.r_n_5 ;
  wire \ramloop[16].ram.r_n_6 ;
  wire \ramloop[16].ram.r_n_7 ;
  wire \ramloop[16].ram.r_n_8 ;
  wire \ramloop[17].ram.r_n_0 ;
  wire \ramloop[17].ram.r_n_1 ;
  wire \ramloop[17].ram.r_n_2 ;
  wire \ramloop[17].ram.r_n_3 ;
  wire \ramloop[17].ram.r_n_4 ;
  wire \ramloop[17].ram.r_n_5 ;
  wire \ramloop[17].ram.r_n_6 ;
  wire \ramloop[17].ram.r_n_7 ;
  wire \ramloop[17].ram.r_n_8 ;
  wire \ramloop[18].ram.r_n_0 ;
  wire \ramloop[18].ram.r_n_1 ;
  wire \ramloop[18].ram.r_n_2 ;
  wire \ramloop[18].ram.r_n_3 ;
  wire \ramloop[18].ram.r_n_4 ;
  wire \ramloop[18].ram.r_n_5 ;
  wire \ramloop[18].ram.r_n_6 ;
  wire \ramloop[18].ram.r_n_7 ;
  wire \ramloop[18].ram.r_n_8 ;
  wire \ramloop[19].ram.r_n_0 ;
  wire \ramloop[19].ram.r_n_1 ;
  wire \ramloop[19].ram.r_n_2 ;
  wire \ramloop[19].ram.r_n_3 ;
  wire \ramloop[19].ram.r_n_4 ;
  wire \ramloop[19].ram.r_n_5 ;
  wire \ramloop[19].ram.r_n_6 ;
  wire \ramloop[19].ram.r_n_7 ;
  wire \ramloop[19].ram.r_n_8 ;
  wire \ramloop[1].ram.r_n_0 ;
  wire \ramloop[1].ram.r_n_1 ;
  wire \ramloop[1].ram.r_n_2 ;
  wire \ramloop[1].ram.r_n_3 ;
  wire \ramloop[2].ram.r_n_0 ;
  wire \ramloop[3].ram.r_n_0 ;
  wire \ramloop[3].ram.r_n_1 ;
  wire \ramloop[4].ram.r_n_0 ;
  wire \ramloop[5].ram.r_n_0 ;
  wire \ramloop[5].ram.r_n_1 ;
  wire \ramloop[5].ram.r_n_2 ;
  wire \ramloop[5].ram.r_n_3 ;
  wire \ramloop[5].ram.r_n_4 ;
  wire \ramloop[5].ram.r_n_5 ;
  wire \ramloop[5].ram.r_n_6 ;
  wire \ramloop[5].ram.r_n_7 ;
  wire \ramloop[5].ram.r_n_8 ;
  wire \ramloop[6].ram.r_n_0 ;
  wire \ramloop[6].ram.r_n_1 ;
  wire \ramloop[6].ram.r_n_2 ;
  wire \ramloop[6].ram.r_n_3 ;
  wire \ramloop[6].ram.r_n_4 ;
  wire \ramloop[6].ram.r_n_5 ;
  wire \ramloop[6].ram.r_n_6 ;
  wire \ramloop[6].ram.r_n_7 ;
  wire \ramloop[6].ram.r_n_8 ;
  wire \ramloop[7].ram.r_n_0 ;
  wire \ramloop[7].ram.r_n_1 ;
  wire \ramloop[7].ram.r_n_2 ;
  wire \ramloop[7].ram.r_n_3 ;
  wire \ramloop[7].ram.r_n_4 ;
  wire \ramloop[7].ram.r_n_5 ;
  wire \ramloop[7].ram.r_n_6 ;
  wire \ramloop[7].ram.r_n_7 ;
  wire \ramloop[7].ram.r_n_8 ;
  wire \ramloop[8].ram.r_n_0 ;
  wire \ramloop[8].ram.r_n_1 ;
  wire \ramloop[8].ram.r_n_2 ;
  wire \ramloop[8].ram.r_n_3 ;
  wire \ramloop[8].ram.r_n_4 ;
  wire \ramloop[8].ram.r_n_5 ;
  wire \ramloop[8].ram.r_n_6 ;
  wire \ramloop[8].ram.r_n_7 ;
  wire \ramloop[8].ram.r_n_8 ;
  wire [0:0]wea;

  Bias_Bram0_bindec \bindec_a.bindec_inst_a 
       (.addra(addra[14:11]),
        .ena(ena),
        .ena_array(ena_array));
  Bias_Bram0_blk_mem_gen_mux \has_mux_a.A 
       (.DOADO({\ramloop[1].ram.r_n_0 ,\ramloop[1].ram.r_n_1 ,\ramloop[1].ram.r_n_2 ,\ramloop[1].ram.r_n_3 }),
        .DOPADOP(\ramloop[8].ram.r_n_8 ),
        .addra(addra[14:11]),
        .clka(clka),
        .douta({douta[31:14],douta[12:0]}),
        .\douta[0] (ram_douta),
        .\douta[11] ({\ramloop[8].ram.r_n_0 ,\ramloop[8].ram.r_n_1 ,\ramloop[8].ram.r_n_2 ,\ramloop[8].ram.r_n_3 ,\ramloop[8].ram.r_n_4 ,\ramloop[8].ram.r_n_5 ,\ramloop[8].ram.r_n_6 ,\ramloop[8].ram.r_n_7 }),
        .\douta[11]_0 ({\ramloop[7].ram.r_n_0 ,\ramloop[7].ram.r_n_1 ,\ramloop[7].ram.r_n_2 ,\ramloop[7].ram.r_n_3 ,\ramloop[7].ram.r_n_4 ,\ramloop[7].ram.r_n_5 ,\ramloop[7].ram.r_n_6 ,\ramloop[7].ram.r_n_7 }),
        .\douta[11]_1 ({\ramloop[6].ram.r_n_0 ,\ramloop[6].ram.r_n_1 ,\ramloop[6].ram.r_n_2 ,\ramloop[6].ram.r_n_3 ,\ramloop[6].ram.r_n_4 ,\ramloop[6].ram.r_n_5 ,\ramloop[6].ram.r_n_6 ,\ramloop[6].ram.r_n_7 }),
        .\douta[11]_2 ({\ramloop[5].ram.r_n_0 ,\ramloop[5].ram.r_n_1 ,\ramloop[5].ram.r_n_2 ,\ramloop[5].ram.r_n_3 ,\ramloop[5].ram.r_n_4 ,\ramloop[5].ram.r_n_5 ,\ramloop[5].ram.r_n_6 ,\ramloop[5].ram.r_n_7 }),
        .\douta[12] (\ramloop[7].ram.r_n_8 ),
        .\douta[12]_0 (\ramloop[6].ram.r_n_8 ),
        .\douta[12]_1 (\ramloop[5].ram.r_n_8 ),
        .\douta[1] (\ramloop[2].ram.r_n_0 ),
        .\douta[21] ({\ramloop[14].ram.r_n_0 ,\ramloop[14].ram.r_n_1 ,\ramloop[14].ram.r_n_2 ,\ramloop[14].ram.r_n_3 ,\ramloop[14].ram.r_n_4 ,\ramloop[14].ram.r_n_5 ,\ramloop[14].ram.r_n_6 ,\ramloop[14].ram.r_n_7 }),
        .\douta[21]_0 ({\ramloop[13].ram.r_n_0 ,\ramloop[13].ram.r_n_1 ,\ramloop[13].ram.r_n_2 ,\ramloop[13].ram.r_n_3 ,\ramloop[13].ram.r_n_4 ,\ramloop[13].ram.r_n_5 ,\ramloop[13].ram.r_n_6 ,\ramloop[13].ram.r_n_7 }),
        .\douta[21]_1 ({\ramloop[12].ram.r_n_0 ,\ramloop[12].ram.r_n_1 ,\ramloop[12].ram.r_n_2 ,\ramloop[12].ram.r_n_3 ,\ramloop[12].ram.r_n_4 ,\ramloop[12].ram.r_n_5 ,\ramloop[12].ram.r_n_6 ,\ramloop[12].ram.r_n_7 }),
        .\douta[21]_2 ({\ramloop[11].ram.r_n_0 ,\ramloop[11].ram.r_n_1 ,\ramloop[11].ram.r_n_2 ,\ramloop[11].ram.r_n_3 ,\ramloop[11].ram.r_n_4 ,\ramloop[11].ram.r_n_5 ,\ramloop[11].ram.r_n_6 ,\ramloop[11].ram.r_n_7 }),
        .\douta[22] (\ramloop[14].ram.r_n_8 ),
        .\douta[22]_0 (\ramloop[13].ram.r_n_8 ),
        .\douta[22]_1 (\ramloop[12].ram.r_n_8 ),
        .\douta[22]_2 (\ramloop[11].ram.r_n_8 ),
        .\douta[2] (\ramloop[3].ram.r_n_0 ),
        .\douta[30] ({\ramloop[19].ram.r_n_0 ,\ramloop[19].ram.r_n_1 ,\ramloop[19].ram.r_n_2 ,\ramloop[19].ram.r_n_3 ,\ramloop[19].ram.r_n_4 ,\ramloop[19].ram.r_n_5 ,\ramloop[19].ram.r_n_6 ,\ramloop[19].ram.r_n_7 }),
        .\douta[30]_0 ({\ramloop[18].ram.r_n_0 ,\ramloop[18].ram.r_n_1 ,\ramloop[18].ram.r_n_2 ,\ramloop[18].ram.r_n_3 ,\ramloop[18].ram.r_n_4 ,\ramloop[18].ram.r_n_5 ,\ramloop[18].ram.r_n_6 ,\ramloop[18].ram.r_n_7 }),
        .\douta[30]_1 ({\ramloop[17].ram.r_n_0 ,\ramloop[17].ram.r_n_1 ,\ramloop[17].ram.r_n_2 ,\ramloop[17].ram.r_n_3 ,\ramloop[17].ram.r_n_4 ,\ramloop[17].ram.r_n_5 ,\ramloop[17].ram.r_n_6 ,\ramloop[17].ram.r_n_7 }),
        .\douta[30]_2 ({\ramloop[16].ram.r_n_0 ,\ramloop[16].ram.r_n_1 ,\ramloop[16].ram.r_n_2 ,\ramloop[16].ram.r_n_3 ,\ramloop[16].ram.r_n_4 ,\ramloop[16].ram.r_n_5 ,\ramloop[16].ram.r_n_6 ,\ramloop[16].ram.r_n_7 }),
        .\douta[31] (\ramloop[19].ram.r_n_8 ),
        .\douta[31]_0 (\ramloop[18].ram.r_n_8 ),
        .\douta[31]_1 (\ramloop[17].ram.r_n_8 ),
        .\douta[31]_2 (\ramloop[16].ram.r_n_8 ),
        .\douta[3] (\ramloop[4].ram.r_n_0 ),
        .ena(ena),
        .p_19_out(p_19_out),
        .p_43_out(p_43_out));
  Bias_Bram0_blk_mem_gen_prim_width \ramloop[0].ram.r 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram (ram_douta),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 (\ramloop[3].ram.r_n_1 ),
        .addra(addra[13:0]),
        .clka(clka),
        .dina(dina[0]),
        .ena(ena),
        .wea(wea));
  Bias_Bram0_blk_mem_gen_prim_width__parameterized9 \ramloop[10].ram.r 
       (.addra(addra),
        .clka(clka),
        .dina(dina[13]),
        .douta(douta[13]),
        .ena(ena),
        .wea(wea));
  Bias_Bram0_blk_mem_gen_prim_width__parameterized10 \ramloop[11].ram.r 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ({\ramloop[11].ram.r_n_0 ,\ramloop[11].ram.r_n_1 ,\ramloop[11].ram.r_n_2 ,\ramloop[11].ram.r_n_3 ,\ramloop[11].ram.r_n_4 ,\ramloop[11].ram.r_n_5 ,\ramloop[11].ram.r_n_6 ,\ramloop[11].ram.r_n_7 }),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 (\ramloop[11].ram.r_n_8 ),
        .addra(addra),
        .clka(clka),
        .dina(dina[22:14]),
        .ena(ena),
        .ena_0(\ramloop[11].ram.r_n_9 ),
        .wea(wea));
  Bias_Bram0_blk_mem_gen_prim_width__parameterized11 \ramloop[12].ram.r 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ({\ramloop[12].ram.r_n_0 ,\ramloop[12].ram.r_n_1 ,\ramloop[12].ram.r_n_2 ,\ramloop[12].ram.r_n_3 ,\ramloop[12].ram.r_n_4 ,\ramloop[12].ram.r_n_5 ,\ramloop[12].ram.r_n_6 ,\ramloop[12].ram.r_n_7 }),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 (\ramloop[12].ram.r_n_8 ),
        .addra(addra),
        .addra_12_sp_1(\ramloop[12].ram.r_n_9 ),
        .clka(clka),
        .dina(dina[22:14]),
        .ena(ena),
        .wea(wea));
  Bias_Bram0_blk_mem_gen_prim_width__parameterized12 \ramloop[13].ram.r 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ({\ramloop[13].ram.r_n_0 ,\ramloop[13].ram.r_n_1 ,\ramloop[13].ram.r_n_2 ,\ramloop[13].ram.r_n_3 ,\ramloop[13].ram.r_n_4 ,\ramloop[13].ram.r_n_5 ,\ramloop[13].ram.r_n_6 ,\ramloop[13].ram.r_n_7 }),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 (\ramloop[13].ram.r_n_8 ),
        .addra(addra),
        .addra_13_sp_1(\ramloop[13].ram.r_n_9 ),
        .clka(clka),
        .dina(dina[22:14]),
        .ena(ena),
        .wea(wea));
  Bias_Bram0_blk_mem_gen_prim_width__parameterized13 \ramloop[14].ram.r 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ({\ramloop[14].ram.r_n_0 ,\ramloop[14].ram.r_n_1 ,\ramloop[14].ram.r_n_2 ,\ramloop[14].ram.r_n_3 ,\ramloop[14].ram.r_n_4 ,\ramloop[14].ram.r_n_5 ,\ramloop[14].ram.r_n_6 ,\ramloop[14].ram.r_n_7 }),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 (\ramloop[14].ram.r_n_8 ),
        .addra(addra[11:0]),
        .clka(clka),
        .dina(dina[22:14]),
        .ena(ena),
        .ram_ena(ram_ena),
        .wea(wea));
  Bias_Bram0_blk_mem_gen_prim_width__parameterized14 \ramloop[15].ram.r 
       (.addra(addra[10:0]),
        .clka(clka),
        .dina(dina[31:14]),
        .ena(ena),
        .ena_array(ena_array),
        .p_19_out(p_19_out),
        .wea(wea));
  Bias_Bram0_blk_mem_gen_prim_width__parameterized15 \ramloop[16].ram.r 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ({\ramloop[16].ram.r_n_0 ,\ramloop[16].ram.r_n_1 ,\ramloop[16].ram.r_n_2 ,\ramloop[16].ram.r_n_3 ,\ramloop[16].ram.r_n_4 ,\ramloop[16].ram.r_n_5 ,\ramloop[16].ram.r_n_6 ,\ramloop[16].ram.r_n_7 }),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 (\ramloop[16].ram.r_n_8 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 (\ramloop[11].ram.r_n_9 ),
        .addra(addra[11:0]),
        .clka(clka),
        .dina(dina[31:23]),
        .ena(ena),
        .wea(wea));
  Bias_Bram0_blk_mem_gen_prim_width__parameterized16 \ramloop[17].ram.r 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ({\ramloop[17].ram.r_n_0 ,\ramloop[17].ram.r_n_1 ,\ramloop[17].ram.r_n_2 ,\ramloop[17].ram.r_n_3 ,\ramloop[17].ram.r_n_4 ,\ramloop[17].ram.r_n_5 ,\ramloop[17].ram.r_n_6 ,\ramloop[17].ram.r_n_7 }),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 (\ramloop[17].ram.r_n_8 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 (\ramloop[12].ram.r_n_9 ),
        .addra(addra[11:0]),
        .clka(clka),
        .dina(dina[31:23]),
        .ena(ena),
        .wea(wea));
  Bias_Bram0_blk_mem_gen_prim_width__parameterized17 \ramloop[18].ram.r 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ({\ramloop[18].ram.r_n_0 ,\ramloop[18].ram.r_n_1 ,\ramloop[18].ram.r_n_2 ,\ramloop[18].ram.r_n_3 ,\ramloop[18].ram.r_n_4 ,\ramloop[18].ram.r_n_5 ,\ramloop[18].ram.r_n_6 ,\ramloop[18].ram.r_n_7 }),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 (\ramloop[18].ram.r_n_8 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 (\ramloop[13].ram.r_n_9 ),
        .addra(addra[11:0]),
        .clka(clka),
        .dina(dina[31:23]),
        .ena(ena),
        .wea(wea));
  Bias_Bram0_blk_mem_gen_prim_width__parameterized18 \ramloop[19].ram.r 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ({\ramloop[19].ram.r_n_0 ,\ramloop[19].ram.r_n_1 ,\ramloop[19].ram.r_n_2 ,\ramloop[19].ram.r_n_3 ,\ramloop[19].ram.r_n_4 ,\ramloop[19].ram.r_n_5 ,\ramloop[19].ram.r_n_6 ,\ramloop[19].ram.r_n_7 }),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 (\ramloop[19].ram.r_n_8 ),
        .addra(addra),
        .clka(clka),
        .dina(dina[31:23]),
        .ena(ena),
        .ram_ena(ram_ena),
        .wea(wea));
  Bias_Bram0_blk_mem_gen_prim_width__parameterized0 \ramloop[1].ram.r 
       (.DOADO({\ramloop[1].ram.r_n_0 ,\ramloop[1].ram.r_n_1 ,\ramloop[1].ram.r_n_2 ,\ramloop[1].ram.r_n_3 }),
        .addra(addra),
        .clka(clka),
        .dina(dina[3:0]),
        .ena(ena),
        .wea(wea));
  Bias_Bram0_blk_mem_gen_prim_width__parameterized1 \ramloop[2].ram.r 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram (\ramloop[2].ram.r_n_0 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 (\ramloop[3].ram.r_n_1 ),
        .addra(addra[13:0]),
        .clka(clka),
        .dina(dina[1]),
        .ena(ena),
        .wea(wea));
  Bias_Bram0_blk_mem_gen_prim_width__parameterized2 \ramloop[3].ram.r 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram (\ramloop[3].ram.r_n_0 ),
        .addra(addra),
        .clka(clka),
        .dina(dina[2]),
        .ena(ena),
        .ena_0(\ramloop[3].ram.r_n_1 ),
        .wea(wea));
  Bias_Bram0_blk_mem_gen_prim_width__parameterized3 \ramloop[4].ram.r 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram (\ramloop[4].ram.r_n_0 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 (\ramloop[3].ram.r_n_1 ),
        .addra(addra[13:0]),
        .clka(clka),
        .dina(dina[3]),
        .ena(ena),
        .wea(wea));
  Bias_Bram0_blk_mem_gen_prim_width__parameterized4 \ramloop[5].ram.r 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ({\ramloop[5].ram.r_n_0 ,\ramloop[5].ram.r_n_1 ,\ramloop[5].ram.r_n_2 ,\ramloop[5].ram.r_n_3 ,\ramloop[5].ram.r_n_4 ,\ramloop[5].ram.r_n_5 ,\ramloop[5].ram.r_n_6 ,\ramloop[5].ram.r_n_7 }),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 (\ramloop[5].ram.r_n_8 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 (\ramloop[11].ram.r_n_9 ),
        .addra(addra[11:0]),
        .clka(clka),
        .dina(dina[12:4]),
        .ena(ena),
        .wea(wea));
  Bias_Bram0_blk_mem_gen_prim_width__parameterized5 \ramloop[6].ram.r 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ({\ramloop[6].ram.r_n_0 ,\ramloop[6].ram.r_n_1 ,\ramloop[6].ram.r_n_2 ,\ramloop[6].ram.r_n_3 ,\ramloop[6].ram.r_n_4 ,\ramloop[6].ram.r_n_5 ,\ramloop[6].ram.r_n_6 ,\ramloop[6].ram.r_n_7 }),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 (\ramloop[6].ram.r_n_8 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 (\ramloop[12].ram.r_n_9 ),
        .addra(addra[11:0]),
        .clka(clka),
        .dina(dina[12:4]),
        .ena(ena),
        .wea(wea));
  Bias_Bram0_blk_mem_gen_prim_width__parameterized6 \ramloop[7].ram.r 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ({\ramloop[7].ram.r_n_0 ,\ramloop[7].ram.r_n_1 ,\ramloop[7].ram.r_n_2 ,\ramloop[7].ram.r_n_3 ,\ramloop[7].ram.r_n_4 ,\ramloop[7].ram.r_n_5 ,\ramloop[7].ram.r_n_6 ,\ramloop[7].ram.r_n_7 }),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 (\ramloop[7].ram.r_n_8 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 (\ramloop[13].ram.r_n_9 ),
        .addra(addra[11:0]),
        .clka(clka),
        .dina(dina[12:4]),
        .ena(ena),
        .wea(wea));
  Bias_Bram0_blk_mem_gen_prim_width__parameterized7 \ramloop[8].ram.r 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ({\ramloop[8].ram.r_n_0 ,\ramloop[8].ram.r_n_1 ,\ramloop[8].ram.r_n_2 ,\ramloop[8].ram.r_n_3 ,\ramloop[8].ram.r_n_4 ,\ramloop[8].ram.r_n_5 ,\ramloop[8].ram.r_n_6 ,\ramloop[8].ram.r_n_7 }),
        .DOPADOP(\ramloop[8].ram.r_n_8 ),
        .addra(addra[11:0]),
        .clka(clka),
        .dina(dina[12:4]),
        .ena(ena),
        .ram_ena(ram_ena),
        .wea(wea));
  Bias_Bram0_blk_mem_gen_prim_width__parameterized8 \ramloop[9].ram.r 
       (.addra(addra[10:0]),
        .clka(clka),
        .dina(dina[12:4]),
        .ena(ena),
        .ena_array(ena_array),
        .p_43_out(p_43_out),
        .wea(wea));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_mux" *) 
module Bias_Bram0_blk_mem_gen_mux
   (douta,
    p_43_out,
    p_19_out,
    ena,
    addra,
    clka,
    DOADO,
    \douta[0] ,
    \douta[1] ,
    \douta[2] ,
    \douta[3] ,
    \douta[11] ,
    \douta[11]_0 ,
    \douta[11]_1 ,
    \douta[11]_2 ,
    DOPADOP,
    \douta[12] ,
    \douta[12]_0 ,
    \douta[12]_1 ,
    \douta[21] ,
    \douta[21]_0 ,
    \douta[21]_1 ,
    \douta[21]_2 ,
    \douta[22] ,
    \douta[22]_0 ,
    \douta[22]_1 ,
    \douta[22]_2 ,
    \douta[30] ,
    \douta[30]_0 ,
    \douta[30]_1 ,
    \douta[30]_2 ,
    \douta[31] ,
    \douta[31]_0 ,
    \douta[31]_1 ,
    \douta[31]_2 );
  output [30:0]douta;
  input [8:0]p_43_out;
  input [17:0]p_19_out;
  input ena;
  input [3:0]addra;
  input clka;
  input [3:0]DOADO;
  input [0:0]\douta[0] ;
  input [0:0]\douta[1] ;
  input [0:0]\douta[2] ;
  input [0:0]\douta[3] ;
  input [7:0]\douta[11] ;
  input [7:0]\douta[11]_0 ;
  input [7:0]\douta[11]_1 ;
  input [7:0]\douta[11]_2 ;
  input [0:0]DOPADOP;
  input [0:0]\douta[12] ;
  input [0:0]\douta[12]_0 ;
  input [0:0]\douta[12]_1 ;
  input [7:0]\douta[21] ;
  input [7:0]\douta[21]_0 ;
  input [7:0]\douta[21]_1 ;
  input [7:0]\douta[21]_2 ;
  input [0:0]\douta[22] ;
  input [0:0]\douta[22]_0 ;
  input [0:0]\douta[22]_1 ;
  input [0:0]\douta[22]_2 ;
  input [7:0]\douta[30] ;
  input [7:0]\douta[30]_0 ;
  input [7:0]\douta[30]_1 ;
  input [7:0]\douta[30]_2 ;
  input [0:0]\douta[31] ;
  input [0:0]\douta[31]_0 ;
  input [0:0]\douta[31]_1 ;
  input [0:0]\douta[31]_2 ;

  wire [3:0]DOADO;
  wire [0:0]DOPADOP;
  wire [3:0]addra;
  wire clka;
  wire [30:0]douta;
  wire [0:0]\douta[0] ;
  wire \douta[10]_INST_0_i_1_n_0 ;
  wire \douta[10]_INST_0_i_2_n_0 ;
  wire [7:0]\douta[11] ;
  wire [7:0]\douta[11]_0 ;
  wire [7:0]\douta[11]_1 ;
  wire [7:0]\douta[11]_2 ;
  wire \douta[11]_INST_0_i_1_n_0 ;
  wire \douta[11]_INST_0_i_2_n_0 ;
  wire [0:0]\douta[12] ;
  wire [0:0]\douta[12]_0 ;
  wire [0:0]\douta[12]_1 ;
  wire \douta[12]_INST_0_i_1_n_0 ;
  wire \douta[12]_INST_0_i_2_n_0 ;
  wire \douta[14]_INST_0_i_1_n_0 ;
  wire \douta[14]_INST_0_i_2_n_0 ;
  wire \douta[15]_INST_0_i_1_n_0 ;
  wire \douta[15]_INST_0_i_2_n_0 ;
  wire \douta[16]_INST_0_i_1_n_0 ;
  wire \douta[16]_INST_0_i_2_n_0 ;
  wire \douta[17]_INST_0_i_1_n_0 ;
  wire \douta[17]_INST_0_i_2_n_0 ;
  wire \douta[18]_INST_0_i_1_n_0 ;
  wire \douta[18]_INST_0_i_2_n_0 ;
  wire \douta[19]_INST_0_i_1_n_0 ;
  wire \douta[19]_INST_0_i_2_n_0 ;
  wire [0:0]\douta[1] ;
  wire \douta[20]_INST_0_i_1_n_0 ;
  wire \douta[20]_INST_0_i_2_n_0 ;
  wire [7:0]\douta[21] ;
  wire [7:0]\douta[21]_0 ;
  wire [7:0]\douta[21]_1 ;
  wire [7:0]\douta[21]_2 ;
  wire \douta[21]_INST_0_i_1_n_0 ;
  wire \douta[21]_INST_0_i_2_n_0 ;
  wire [0:0]\douta[22] ;
  wire [0:0]\douta[22]_0 ;
  wire [0:0]\douta[22]_1 ;
  wire [0:0]\douta[22]_2 ;
  wire \douta[22]_INST_0_i_1_n_0 ;
  wire \douta[22]_INST_0_i_2_n_0 ;
  wire \douta[23]_INST_0_i_1_n_0 ;
  wire \douta[23]_INST_0_i_2_n_0 ;
  wire \douta[24]_INST_0_i_1_n_0 ;
  wire \douta[24]_INST_0_i_2_n_0 ;
  wire \douta[25]_INST_0_i_1_n_0 ;
  wire \douta[25]_INST_0_i_2_n_0 ;
  wire \douta[26]_INST_0_i_1_n_0 ;
  wire \douta[26]_INST_0_i_2_n_0 ;
  wire \douta[27]_INST_0_i_1_n_0 ;
  wire \douta[27]_INST_0_i_2_n_0 ;
  wire \douta[28]_INST_0_i_1_n_0 ;
  wire \douta[28]_INST_0_i_2_n_0 ;
  wire \douta[29]_INST_0_i_1_n_0 ;
  wire \douta[29]_INST_0_i_2_n_0 ;
  wire [0:0]\douta[2] ;
  wire [7:0]\douta[30] ;
  wire [7:0]\douta[30]_0 ;
  wire [7:0]\douta[30]_1 ;
  wire [7:0]\douta[30]_2 ;
  wire \douta[30]_INST_0_i_1_n_0 ;
  wire \douta[30]_INST_0_i_2_n_0 ;
  wire [0:0]\douta[31] ;
  wire [0:0]\douta[31]_0 ;
  wire [0:0]\douta[31]_1 ;
  wire [0:0]\douta[31]_2 ;
  wire \douta[31]_INST_0_i_1_n_0 ;
  wire \douta[31]_INST_0_i_2_n_0 ;
  wire [0:0]\douta[3] ;
  wire \douta[4]_INST_0_i_1_n_0 ;
  wire \douta[4]_INST_0_i_2_n_0 ;
  wire \douta[5]_INST_0_i_1_n_0 ;
  wire \douta[5]_INST_0_i_2_n_0 ;
  wire \douta[6]_INST_0_i_1_n_0 ;
  wire \douta[6]_INST_0_i_2_n_0 ;
  wire \douta[7]_INST_0_i_1_n_0 ;
  wire \douta[7]_INST_0_i_2_n_0 ;
  wire \douta[8]_INST_0_i_1_n_0 ;
  wire \douta[8]_INST_0_i_2_n_0 ;
  wire \douta[9]_INST_0_i_1_n_0 ;
  wire \douta[9]_INST_0_i_2_n_0 ;
  wire ena;
  wire [17:0]p_19_out;
  wire [8:0]p_43_out;
  wire [3:0]sel_pipe;
  wire [3:0]sel_pipe_d1;

  LUT5 #(
    .INIT(32'h04FF0400)) 
    \douta[0]_INST_0 
       (.I0(sel_pipe_d1[1]),
        .I1(DOADO[0]),
        .I2(sel_pipe_d1[2]),
        .I3(sel_pipe_d1[3]),
        .I4(\douta[0] ),
        .O(douta[0]));
  MUXF7 \douta[10]_INST_0 
       (.I0(\douta[10]_INST_0_i_1_n_0 ),
        .I1(\douta[10]_INST_0_i_2_n_0 ),
        .O(douta[10]),
        .S(sel_pipe_d1[3]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[10]_INST_0_i_1 
       (.I0(\douta[11] [6]),
        .I1(\douta[11]_0 [6]),
        .I2(sel_pipe_d1[2]),
        .I3(\douta[11]_1 [6]),
        .I4(sel_pipe_d1[1]),
        .I5(\douta[11]_2 [6]),
        .O(\douta[10]_INST_0_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0004)) 
    \douta[10]_INST_0_i_2 
       (.I0(sel_pipe_d1[1]),
        .I1(p_43_out[6]),
        .I2(sel_pipe_d1[0]),
        .I3(sel_pipe_d1[2]),
        .O(\douta[10]_INST_0_i_2_n_0 ));
  MUXF7 \douta[11]_INST_0 
       (.I0(\douta[11]_INST_0_i_1_n_0 ),
        .I1(\douta[11]_INST_0_i_2_n_0 ),
        .O(douta[11]),
        .S(sel_pipe_d1[3]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[11]_INST_0_i_1 
       (.I0(\douta[11] [7]),
        .I1(\douta[11]_0 [7]),
        .I2(sel_pipe_d1[2]),
        .I3(\douta[11]_1 [7]),
        .I4(sel_pipe_d1[1]),
        .I5(\douta[11]_2 [7]),
        .O(\douta[11]_INST_0_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0004)) 
    \douta[11]_INST_0_i_2 
       (.I0(sel_pipe_d1[1]),
        .I1(p_43_out[7]),
        .I2(sel_pipe_d1[0]),
        .I3(sel_pipe_d1[2]),
        .O(\douta[11]_INST_0_i_2_n_0 ));
  MUXF7 \douta[12]_INST_0 
       (.I0(\douta[12]_INST_0_i_1_n_0 ),
        .I1(\douta[12]_INST_0_i_2_n_0 ),
        .O(douta[12]),
        .S(sel_pipe_d1[3]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[12]_INST_0_i_1 
       (.I0(DOPADOP),
        .I1(\douta[12] ),
        .I2(sel_pipe_d1[2]),
        .I3(\douta[12]_0 ),
        .I4(sel_pipe_d1[1]),
        .I5(\douta[12]_1 ),
        .O(\douta[12]_INST_0_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0004)) 
    \douta[12]_INST_0_i_2 
       (.I0(sel_pipe_d1[1]),
        .I1(p_43_out[8]),
        .I2(sel_pipe_d1[0]),
        .I3(sel_pipe_d1[2]),
        .O(\douta[12]_INST_0_i_2_n_0 ));
  MUXF7 \douta[14]_INST_0 
       (.I0(\douta[14]_INST_0_i_1_n_0 ),
        .I1(\douta[14]_INST_0_i_2_n_0 ),
        .O(douta[13]),
        .S(sel_pipe_d1[3]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[14]_INST_0_i_1 
       (.I0(\douta[21] [0]),
        .I1(\douta[21]_0 [0]),
        .I2(sel_pipe_d1[2]),
        .I3(\douta[21]_1 [0]),
        .I4(sel_pipe_d1[1]),
        .I5(\douta[21]_2 [0]),
        .O(\douta[14]_INST_0_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0004)) 
    \douta[14]_INST_0_i_2 
       (.I0(sel_pipe_d1[1]),
        .I1(p_19_out[0]),
        .I2(sel_pipe_d1[0]),
        .I3(sel_pipe_d1[2]),
        .O(\douta[14]_INST_0_i_2_n_0 ));
  MUXF7 \douta[15]_INST_0 
       (.I0(\douta[15]_INST_0_i_1_n_0 ),
        .I1(\douta[15]_INST_0_i_2_n_0 ),
        .O(douta[14]),
        .S(sel_pipe_d1[3]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[15]_INST_0_i_1 
       (.I0(\douta[21] [1]),
        .I1(\douta[21]_0 [1]),
        .I2(sel_pipe_d1[2]),
        .I3(\douta[21]_1 [1]),
        .I4(sel_pipe_d1[1]),
        .I5(\douta[21]_2 [1]),
        .O(\douta[15]_INST_0_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0004)) 
    \douta[15]_INST_0_i_2 
       (.I0(sel_pipe_d1[1]),
        .I1(p_19_out[1]),
        .I2(sel_pipe_d1[0]),
        .I3(sel_pipe_d1[2]),
        .O(\douta[15]_INST_0_i_2_n_0 ));
  MUXF7 \douta[16]_INST_0 
       (.I0(\douta[16]_INST_0_i_1_n_0 ),
        .I1(\douta[16]_INST_0_i_2_n_0 ),
        .O(douta[15]),
        .S(sel_pipe_d1[3]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[16]_INST_0_i_1 
       (.I0(\douta[21] [2]),
        .I1(\douta[21]_0 [2]),
        .I2(sel_pipe_d1[2]),
        .I3(\douta[21]_1 [2]),
        .I4(sel_pipe_d1[1]),
        .I5(\douta[21]_2 [2]),
        .O(\douta[16]_INST_0_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0004)) 
    \douta[16]_INST_0_i_2 
       (.I0(sel_pipe_d1[1]),
        .I1(p_19_out[2]),
        .I2(sel_pipe_d1[0]),
        .I3(sel_pipe_d1[2]),
        .O(\douta[16]_INST_0_i_2_n_0 ));
  MUXF7 \douta[17]_INST_0 
       (.I0(\douta[17]_INST_0_i_1_n_0 ),
        .I1(\douta[17]_INST_0_i_2_n_0 ),
        .O(douta[16]),
        .S(sel_pipe_d1[3]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[17]_INST_0_i_1 
       (.I0(\douta[21] [3]),
        .I1(\douta[21]_0 [3]),
        .I2(sel_pipe_d1[2]),
        .I3(\douta[21]_1 [3]),
        .I4(sel_pipe_d1[1]),
        .I5(\douta[21]_2 [3]),
        .O(\douta[17]_INST_0_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0004)) 
    \douta[17]_INST_0_i_2 
       (.I0(sel_pipe_d1[1]),
        .I1(p_19_out[3]),
        .I2(sel_pipe_d1[0]),
        .I3(sel_pipe_d1[2]),
        .O(\douta[17]_INST_0_i_2_n_0 ));
  MUXF7 \douta[18]_INST_0 
       (.I0(\douta[18]_INST_0_i_1_n_0 ),
        .I1(\douta[18]_INST_0_i_2_n_0 ),
        .O(douta[17]),
        .S(sel_pipe_d1[3]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[18]_INST_0_i_1 
       (.I0(\douta[21] [4]),
        .I1(\douta[21]_0 [4]),
        .I2(sel_pipe_d1[2]),
        .I3(\douta[21]_1 [4]),
        .I4(sel_pipe_d1[1]),
        .I5(\douta[21]_2 [4]),
        .O(\douta[18]_INST_0_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0004)) 
    \douta[18]_INST_0_i_2 
       (.I0(sel_pipe_d1[1]),
        .I1(p_19_out[4]),
        .I2(sel_pipe_d1[0]),
        .I3(sel_pipe_d1[2]),
        .O(\douta[18]_INST_0_i_2_n_0 ));
  MUXF7 \douta[19]_INST_0 
       (.I0(\douta[19]_INST_0_i_1_n_0 ),
        .I1(\douta[19]_INST_0_i_2_n_0 ),
        .O(douta[18]),
        .S(sel_pipe_d1[3]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[19]_INST_0_i_1 
       (.I0(\douta[21] [5]),
        .I1(\douta[21]_0 [5]),
        .I2(sel_pipe_d1[2]),
        .I3(\douta[21]_1 [5]),
        .I4(sel_pipe_d1[1]),
        .I5(\douta[21]_2 [5]),
        .O(\douta[19]_INST_0_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0004)) 
    \douta[19]_INST_0_i_2 
       (.I0(sel_pipe_d1[1]),
        .I1(p_19_out[5]),
        .I2(sel_pipe_d1[0]),
        .I3(sel_pipe_d1[2]),
        .O(\douta[19]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \douta[1]_INST_0 
       (.I0(sel_pipe_d1[1]),
        .I1(DOADO[1]),
        .I2(sel_pipe_d1[2]),
        .I3(sel_pipe_d1[3]),
        .I4(\douta[1] ),
        .O(douta[1]));
  MUXF7 \douta[20]_INST_0 
       (.I0(\douta[20]_INST_0_i_1_n_0 ),
        .I1(\douta[20]_INST_0_i_2_n_0 ),
        .O(douta[19]),
        .S(sel_pipe_d1[3]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[20]_INST_0_i_1 
       (.I0(\douta[21] [6]),
        .I1(\douta[21]_0 [6]),
        .I2(sel_pipe_d1[2]),
        .I3(\douta[21]_1 [6]),
        .I4(sel_pipe_d1[1]),
        .I5(\douta[21]_2 [6]),
        .O(\douta[20]_INST_0_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0004)) 
    \douta[20]_INST_0_i_2 
       (.I0(sel_pipe_d1[1]),
        .I1(p_19_out[6]),
        .I2(sel_pipe_d1[0]),
        .I3(sel_pipe_d1[2]),
        .O(\douta[20]_INST_0_i_2_n_0 ));
  MUXF7 \douta[21]_INST_0 
       (.I0(\douta[21]_INST_0_i_1_n_0 ),
        .I1(\douta[21]_INST_0_i_2_n_0 ),
        .O(douta[20]),
        .S(sel_pipe_d1[3]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[21]_INST_0_i_1 
       (.I0(\douta[21] [7]),
        .I1(\douta[21]_0 [7]),
        .I2(sel_pipe_d1[2]),
        .I3(\douta[21]_1 [7]),
        .I4(sel_pipe_d1[1]),
        .I5(\douta[21]_2 [7]),
        .O(\douta[21]_INST_0_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0004)) 
    \douta[21]_INST_0_i_2 
       (.I0(sel_pipe_d1[1]),
        .I1(p_19_out[7]),
        .I2(sel_pipe_d1[0]),
        .I3(sel_pipe_d1[2]),
        .O(\douta[21]_INST_0_i_2_n_0 ));
  MUXF7 \douta[22]_INST_0 
       (.I0(\douta[22]_INST_0_i_1_n_0 ),
        .I1(\douta[22]_INST_0_i_2_n_0 ),
        .O(douta[21]),
        .S(sel_pipe_d1[3]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[22]_INST_0_i_1 
       (.I0(\douta[22] ),
        .I1(\douta[22]_0 ),
        .I2(sel_pipe_d1[2]),
        .I3(\douta[22]_1 ),
        .I4(sel_pipe_d1[1]),
        .I5(\douta[22]_2 ),
        .O(\douta[22]_INST_0_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0004)) 
    \douta[22]_INST_0_i_2 
       (.I0(sel_pipe_d1[1]),
        .I1(p_19_out[8]),
        .I2(sel_pipe_d1[0]),
        .I3(sel_pipe_d1[2]),
        .O(\douta[22]_INST_0_i_2_n_0 ));
  MUXF7 \douta[23]_INST_0 
       (.I0(\douta[23]_INST_0_i_1_n_0 ),
        .I1(\douta[23]_INST_0_i_2_n_0 ),
        .O(douta[22]),
        .S(sel_pipe_d1[3]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[23]_INST_0_i_1 
       (.I0(\douta[30] [0]),
        .I1(\douta[30]_0 [0]),
        .I2(sel_pipe_d1[2]),
        .I3(\douta[30]_1 [0]),
        .I4(sel_pipe_d1[1]),
        .I5(\douta[30]_2 [0]),
        .O(\douta[23]_INST_0_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0004)) 
    \douta[23]_INST_0_i_2 
       (.I0(sel_pipe_d1[1]),
        .I1(p_19_out[9]),
        .I2(sel_pipe_d1[0]),
        .I3(sel_pipe_d1[2]),
        .O(\douta[23]_INST_0_i_2_n_0 ));
  MUXF7 \douta[24]_INST_0 
       (.I0(\douta[24]_INST_0_i_1_n_0 ),
        .I1(\douta[24]_INST_0_i_2_n_0 ),
        .O(douta[23]),
        .S(sel_pipe_d1[3]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[24]_INST_0_i_1 
       (.I0(\douta[30] [1]),
        .I1(\douta[30]_0 [1]),
        .I2(sel_pipe_d1[2]),
        .I3(\douta[30]_1 [1]),
        .I4(sel_pipe_d1[1]),
        .I5(\douta[30]_2 [1]),
        .O(\douta[24]_INST_0_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0004)) 
    \douta[24]_INST_0_i_2 
       (.I0(sel_pipe_d1[1]),
        .I1(p_19_out[10]),
        .I2(sel_pipe_d1[0]),
        .I3(sel_pipe_d1[2]),
        .O(\douta[24]_INST_0_i_2_n_0 ));
  MUXF7 \douta[25]_INST_0 
       (.I0(\douta[25]_INST_0_i_1_n_0 ),
        .I1(\douta[25]_INST_0_i_2_n_0 ),
        .O(douta[24]),
        .S(sel_pipe_d1[3]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[25]_INST_0_i_1 
       (.I0(\douta[30] [2]),
        .I1(\douta[30]_0 [2]),
        .I2(sel_pipe_d1[2]),
        .I3(\douta[30]_1 [2]),
        .I4(sel_pipe_d1[1]),
        .I5(\douta[30]_2 [2]),
        .O(\douta[25]_INST_0_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0004)) 
    \douta[25]_INST_0_i_2 
       (.I0(sel_pipe_d1[1]),
        .I1(p_19_out[11]),
        .I2(sel_pipe_d1[0]),
        .I3(sel_pipe_d1[2]),
        .O(\douta[25]_INST_0_i_2_n_0 ));
  MUXF7 \douta[26]_INST_0 
       (.I0(\douta[26]_INST_0_i_1_n_0 ),
        .I1(\douta[26]_INST_0_i_2_n_0 ),
        .O(douta[25]),
        .S(sel_pipe_d1[3]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[26]_INST_0_i_1 
       (.I0(\douta[30] [3]),
        .I1(\douta[30]_0 [3]),
        .I2(sel_pipe_d1[2]),
        .I3(\douta[30]_1 [3]),
        .I4(sel_pipe_d1[1]),
        .I5(\douta[30]_2 [3]),
        .O(\douta[26]_INST_0_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0004)) 
    \douta[26]_INST_0_i_2 
       (.I0(sel_pipe_d1[1]),
        .I1(p_19_out[12]),
        .I2(sel_pipe_d1[0]),
        .I3(sel_pipe_d1[2]),
        .O(\douta[26]_INST_0_i_2_n_0 ));
  MUXF7 \douta[27]_INST_0 
       (.I0(\douta[27]_INST_0_i_1_n_0 ),
        .I1(\douta[27]_INST_0_i_2_n_0 ),
        .O(douta[26]),
        .S(sel_pipe_d1[3]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[27]_INST_0_i_1 
       (.I0(\douta[30] [4]),
        .I1(\douta[30]_0 [4]),
        .I2(sel_pipe_d1[2]),
        .I3(\douta[30]_1 [4]),
        .I4(sel_pipe_d1[1]),
        .I5(\douta[30]_2 [4]),
        .O(\douta[27]_INST_0_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0004)) 
    \douta[27]_INST_0_i_2 
       (.I0(sel_pipe_d1[1]),
        .I1(p_19_out[13]),
        .I2(sel_pipe_d1[0]),
        .I3(sel_pipe_d1[2]),
        .O(\douta[27]_INST_0_i_2_n_0 ));
  MUXF7 \douta[28]_INST_0 
       (.I0(\douta[28]_INST_0_i_1_n_0 ),
        .I1(\douta[28]_INST_0_i_2_n_0 ),
        .O(douta[27]),
        .S(sel_pipe_d1[3]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[28]_INST_0_i_1 
       (.I0(\douta[30] [5]),
        .I1(\douta[30]_0 [5]),
        .I2(sel_pipe_d1[2]),
        .I3(\douta[30]_1 [5]),
        .I4(sel_pipe_d1[1]),
        .I5(\douta[30]_2 [5]),
        .O(\douta[28]_INST_0_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0004)) 
    \douta[28]_INST_0_i_2 
       (.I0(sel_pipe_d1[1]),
        .I1(p_19_out[14]),
        .I2(sel_pipe_d1[0]),
        .I3(sel_pipe_d1[2]),
        .O(\douta[28]_INST_0_i_2_n_0 ));
  MUXF7 \douta[29]_INST_0 
       (.I0(\douta[29]_INST_0_i_1_n_0 ),
        .I1(\douta[29]_INST_0_i_2_n_0 ),
        .O(douta[28]),
        .S(sel_pipe_d1[3]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[29]_INST_0_i_1 
       (.I0(\douta[30] [6]),
        .I1(\douta[30]_0 [6]),
        .I2(sel_pipe_d1[2]),
        .I3(\douta[30]_1 [6]),
        .I4(sel_pipe_d1[1]),
        .I5(\douta[30]_2 [6]),
        .O(\douta[29]_INST_0_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0004)) 
    \douta[29]_INST_0_i_2 
       (.I0(sel_pipe_d1[1]),
        .I1(p_19_out[15]),
        .I2(sel_pipe_d1[0]),
        .I3(sel_pipe_d1[2]),
        .O(\douta[29]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \douta[2]_INST_0 
       (.I0(sel_pipe_d1[1]),
        .I1(DOADO[2]),
        .I2(sel_pipe_d1[2]),
        .I3(sel_pipe_d1[3]),
        .I4(\douta[2] ),
        .O(douta[2]));
  MUXF7 \douta[30]_INST_0 
       (.I0(\douta[30]_INST_0_i_1_n_0 ),
        .I1(\douta[30]_INST_0_i_2_n_0 ),
        .O(douta[29]),
        .S(sel_pipe_d1[3]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[30]_INST_0_i_1 
       (.I0(\douta[30] [7]),
        .I1(\douta[30]_0 [7]),
        .I2(sel_pipe_d1[2]),
        .I3(\douta[30]_1 [7]),
        .I4(sel_pipe_d1[1]),
        .I5(\douta[30]_2 [7]),
        .O(\douta[30]_INST_0_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0004)) 
    \douta[30]_INST_0_i_2 
       (.I0(sel_pipe_d1[1]),
        .I1(p_19_out[16]),
        .I2(sel_pipe_d1[0]),
        .I3(sel_pipe_d1[2]),
        .O(\douta[30]_INST_0_i_2_n_0 ));
  MUXF7 \douta[31]_INST_0 
       (.I0(\douta[31]_INST_0_i_1_n_0 ),
        .I1(\douta[31]_INST_0_i_2_n_0 ),
        .O(douta[30]),
        .S(sel_pipe_d1[3]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[31]_INST_0_i_1 
       (.I0(\douta[31] ),
        .I1(\douta[31]_0 ),
        .I2(sel_pipe_d1[2]),
        .I3(\douta[31]_1 ),
        .I4(sel_pipe_d1[1]),
        .I5(\douta[31]_2 ),
        .O(\douta[31]_INST_0_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0004)) 
    \douta[31]_INST_0_i_2 
       (.I0(sel_pipe_d1[1]),
        .I1(p_19_out[17]),
        .I2(sel_pipe_d1[0]),
        .I3(sel_pipe_d1[2]),
        .O(\douta[31]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h04FF0400)) 
    \douta[3]_INST_0 
       (.I0(sel_pipe_d1[1]),
        .I1(DOADO[3]),
        .I2(sel_pipe_d1[2]),
        .I3(sel_pipe_d1[3]),
        .I4(\douta[3] ),
        .O(douta[3]));
  MUXF7 \douta[4]_INST_0 
       (.I0(\douta[4]_INST_0_i_1_n_0 ),
        .I1(\douta[4]_INST_0_i_2_n_0 ),
        .O(douta[4]),
        .S(sel_pipe_d1[3]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[4]_INST_0_i_1 
       (.I0(\douta[11] [0]),
        .I1(\douta[11]_0 [0]),
        .I2(sel_pipe_d1[2]),
        .I3(\douta[11]_1 [0]),
        .I4(sel_pipe_d1[1]),
        .I5(\douta[11]_2 [0]),
        .O(\douta[4]_INST_0_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0004)) 
    \douta[4]_INST_0_i_2 
       (.I0(sel_pipe_d1[1]),
        .I1(p_43_out[0]),
        .I2(sel_pipe_d1[0]),
        .I3(sel_pipe_d1[2]),
        .O(\douta[4]_INST_0_i_2_n_0 ));
  MUXF7 \douta[5]_INST_0 
       (.I0(\douta[5]_INST_0_i_1_n_0 ),
        .I1(\douta[5]_INST_0_i_2_n_0 ),
        .O(douta[5]),
        .S(sel_pipe_d1[3]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[5]_INST_0_i_1 
       (.I0(\douta[11] [1]),
        .I1(\douta[11]_0 [1]),
        .I2(sel_pipe_d1[2]),
        .I3(\douta[11]_1 [1]),
        .I4(sel_pipe_d1[1]),
        .I5(\douta[11]_2 [1]),
        .O(\douta[5]_INST_0_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0004)) 
    \douta[5]_INST_0_i_2 
       (.I0(sel_pipe_d1[1]),
        .I1(p_43_out[1]),
        .I2(sel_pipe_d1[0]),
        .I3(sel_pipe_d1[2]),
        .O(\douta[5]_INST_0_i_2_n_0 ));
  MUXF7 \douta[6]_INST_0 
       (.I0(\douta[6]_INST_0_i_1_n_0 ),
        .I1(\douta[6]_INST_0_i_2_n_0 ),
        .O(douta[6]),
        .S(sel_pipe_d1[3]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[6]_INST_0_i_1 
       (.I0(\douta[11] [2]),
        .I1(\douta[11]_0 [2]),
        .I2(sel_pipe_d1[2]),
        .I3(\douta[11]_1 [2]),
        .I4(sel_pipe_d1[1]),
        .I5(\douta[11]_2 [2]),
        .O(\douta[6]_INST_0_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0004)) 
    \douta[6]_INST_0_i_2 
       (.I0(sel_pipe_d1[1]),
        .I1(p_43_out[2]),
        .I2(sel_pipe_d1[0]),
        .I3(sel_pipe_d1[2]),
        .O(\douta[6]_INST_0_i_2_n_0 ));
  MUXF7 \douta[7]_INST_0 
       (.I0(\douta[7]_INST_0_i_1_n_0 ),
        .I1(\douta[7]_INST_0_i_2_n_0 ),
        .O(douta[7]),
        .S(sel_pipe_d1[3]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[7]_INST_0_i_1 
       (.I0(\douta[11] [3]),
        .I1(\douta[11]_0 [3]),
        .I2(sel_pipe_d1[2]),
        .I3(\douta[11]_1 [3]),
        .I4(sel_pipe_d1[1]),
        .I5(\douta[11]_2 [3]),
        .O(\douta[7]_INST_0_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0004)) 
    \douta[7]_INST_0_i_2 
       (.I0(sel_pipe_d1[1]),
        .I1(p_43_out[3]),
        .I2(sel_pipe_d1[0]),
        .I3(sel_pipe_d1[2]),
        .O(\douta[7]_INST_0_i_2_n_0 ));
  MUXF7 \douta[8]_INST_0 
       (.I0(\douta[8]_INST_0_i_1_n_0 ),
        .I1(\douta[8]_INST_0_i_2_n_0 ),
        .O(douta[8]),
        .S(sel_pipe_d1[3]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[8]_INST_0_i_1 
       (.I0(\douta[11] [4]),
        .I1(\douta[11]_0 [4]),
        .I2(sel_pipe_d1[2]),
        .I3(\douta[11]_1 [4]),
        .I4(sel_pipe_d1[1]),
        .I5(\douta[11]_2 [4]),
        .O(\douta[8]_INST_0_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0004)) 
    \douta[8]_INST_0_i_2 
       (.I0(sel_pipe_d1[1]),
        .I1(p_43_out[4]),
        .I2(sel_pipe_d1[0]),
        .I3(sel_pipe_d1[2]),
        .O(\douta[8]_INST_0_i_2_n_0 ));
  MUXF7 \douta[9]_INST_0 
       (.I0(\douta[9]_INST_0_i_1_n_0 ),
        .I1(\douta[9]_INST_0_i_2_n_0 ),
        .O(douta[9]),
        .S(sel_pipe_d1[3]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \douta[9]_INST_0_i_1 
       (.I0(\douta[11] [5]),
        .I1(\douta[11]_0 [5]),
        .I2(sel_pipe_d1[2]),
        .I3(\douta[11]_1 [5]),
        .I4(sel_pipe_d1[1]),
        .I5(\douta[11]_2 [5]),
        .O(\douta[9]_INST_0_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0004)) 
    \douta[9]_INST_0_i_2 
       (.I0(sel_pipe_d1[1]),
        .I1(p_43_out[5]),
        .I2(sel_pipe_d1[0]),
        .I3(sel_pipe_d1[2]),
        .O(\douta[9]_INST_0_i_2_n_0 ));
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
    \no_softecc_norm_sel2.has_mem_regs.WITHOUT_ECC_PIPE.ce_pri.sel_pipe_d1_reg[3] 
       (.C(clka),
        .CE(ena),
        .D(sel_pipe[3]),
        .Q(sel_pipe_d1[3]),
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
  FDRE #(
    .INIT(1'b0)) 
    \no_softecc_sel_reg.ce_pri.sel_pipe_reg[3] 
       (.C(clka),
        .CE(ena),
        .D(addra[3]),
        .Q(sel_pipe[3]),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module Bias_Bram0_blk_mem_gen_prim_width
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram ,
    clka,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 ,
    ena,
    addra,
    dina,
    wea);
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram ;
  input clka;
  input \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 ;
  input ena;
  input [13:0]addra;
  input [0:0]dina;
  input [0:0]wea;

  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 ;
  wire [13:0]addra;
  wire clka;
  wire [0:0]dina;
  wire ena;
  wire [0:0]wea;

  Bias_Bram0_blk_mem_gen_prim_wrapper_init \prim_init.ram 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_1 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 ),
        .addra(addra),
        .clka(clka),
        .dina(dina),
        .ena(ena),
        .wea(wea));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module Bias_Bram0_blk_mem_gen_prim_width__parameterized0
   (DOADO,
    clka,
    ena,
    addra,
    dina,
    wea);
  output [3:0]DOADO;
  input clka;
  input ena;
  input [14:0]addra;
  input [3:0]dina;
  input [0:0]wea;

  wire [3:0]DOADO;
  wire [14:0]addra;
  wire clka;
  wire [3:0]dina;
  wire ena;
  wire [0:0]wea;

  Bias_Bram0_blk_mem_gen_prim_wrapper_init__parameterized0 \prim_init.ram 
       (.DOADO(DOADO),
        .addra(addra),
        .clka(clka),
        .dina(dina),
        .ena(ena),
        .wea(wea));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module Bias_Bram0_blk_mem_gen_prim_width__parameterized1
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram ,
    clka,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 ,
    ena,
    addra,
    dina,
    wea);
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram ;
  input clka;
  input \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 ;
  input ena;
  input [13:0]addra;
  input [0:0]dina;
  input [0:0]wea;

  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 ;
  wire [13:0]addra;
  wire clka;
  wire [0:0]dina;
  wire ena;
  wire [0:0]wea;

  Bias_Bram0_blk_mem_gen_prim_wrapper_init__parameterized1 \prim_init.ram 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_1 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 ),
        .addra(addra),
        .clka(clka),
        .dina(dina),
        .ena(ena),
        .wea(wea));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module Bias_Bram0_blk_mem_gen_prim_width__parameterized10
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ,
    ena_0,
    clka,
    ena,
    addra,
    dina,
    wea);
  output [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ;
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  output ena_0;
  input clka;
  input ena;
  input [14:0]addra;
  input [8:0]dina;
  input [0:0]wea;

  wire [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ;
  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  wire [14:0]addra;
  wire clka;
  wire [8:0]dina;
  wire ena;
  wire ena_0;
  wire [0:0]wea;

  Bias_Bram0_blk_mem_gen_prim_wrapper_init__parameterized10 \prim_init.ram 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ),
        .addra(addra),
        .clka(clka),
        .dina(dina),
        .ena(ena),
        .ena_0(ena_0),
        .wea(wea));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module Bias_Bram0_blk_mem_gen_prim_width__parameterized11
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ,
    addra_12_sp_1,
    clka,
    ena,
    addra,
    dina,
    wea);
  output [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ;
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  output addra_12_sp_1;
  input clka;
  input ena;
  input [14:0]addra;
  input [8:0]dina;
  input [0:0]wea;

  wire [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ;
  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  wire [14:0]addra;
  wire addra_12_sn_1;
  wire clka;
  wire [8:0]dina;
  wire ena;
  wire [0:0]wea;

  assign addra_12_sp_1 = addra_12_sn_1;
  Bias_Bram0_blk_mem_gen_prim_wrapper_init__parameterized11 \prim_init.ram 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ),
        .addra(addra),
        .addra_12_sp_1(addra_12_sn_1),
        .clka(clka),
        .dina(dina),
        .ena(ena),
        .wea(wea));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module Bias_Bram0_blk_mem_gen_prim_width__parameterized12
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ,
    addra_13_sp_1,
    clka,
    ena,
    addra,
    dina,
    wea);
  output [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ;
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  output addra_13_sp_1;
  input clka;
  input ena;
  input [14:0]addra;
  input [8:0]dina;
  input [0:0]wea;

  wire [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ;
  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  wire [14:0]addra;
  wire addra_13_sn_1;
  wire clka;
  wire [8:0]dina;
  wire ena;
  wire [0:0]wea;

  assign addra_13_sp_1 = addra_13_sn_1;
  Bias_Bram0_blk_mem_gen_prim_wrapper_init__parameterized12 \prim_init.ram 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ),
        .addra(addra),
        .addra_13_sp_1(addra_13_sn_1),
        .clka(clka),
        .dina(dina),
        .ena(ena),
        .wea(wea));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module Bias_Bram0_blk_mem_gen_prim_width__parameterized13
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ,
    clka,
    ram_ena,
    ena,
    addra,
    dina,
    wea);
  output [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ;
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  input clka;
  input ram_ena;
  input ena;
  input [11:0]addra;
  input [8:0]dina;
  input [0:0]wea;

  wire [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ;
  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  wire [11:0]addra;
  wire clka;
  wire [8:0]dina;
  wire ena;
  wire ram_ena;
  wire [0:0]wea;

  Bias_Bram0_blk_mem_gen_prim_wrapper_init__parameterized13 \prim_init.ram 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ),
        .addra(addra),
        .clka(clka),
        .dina(dina),
        .ena(ena),
        .ram_ena(ram_ena),
        .wea(wea));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module Bias_Bram0_blk_mem_gen_prim_width__parameterized14
   (p_19_out,
    clka,
    ena_array,
    ena,
    addra,
    dina,
    wea);
  output [17:0]p_19_out;
  input clka;
  input [0:0]ena_array;
  input ena;
  input [10:0]addra;
  input [17:0]dina;
  input [0:0]wea;

  wire [10:0]addra;
  wire clka;
  wire [17:0]dina;
  wire ena;
  wire [0:0]ena_array;
  wire [17:0]p_19_out;
  wire [0:0]wea;

  Bias_Bram0_blk_mem_gen_prim_wrapper_init__parameterized14 \prim_init.ram 
       (.addra(addra),
        .clka(clka),
        .dina(dina),
        .ena(ena),
        .ena_array(ena_array),
        .p_19_out(p_19_out),
        .wea(wea));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module Bias_Bram0_blk_mem_gen_prim_width__parameterized15
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ,
    clka,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ,
    ena,
    addra,
    dina,
    wea);
  output [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ;
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  input clka;
  input \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  input ena;
  input [11:0]addra;
  input [8:0]dina;
  input [0:0]wea;

  wire [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ;
  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  wire [11:0]addra;
  wire clka;
  wire [8:0]dina;
  wire ena;
  wire [0:0]wea;

  Bias_Bram0_blk_mem_gen_prim_wrapper_init__parameterized15 \prim_init.ram 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_2 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ),
        .addra(addra),
        .clka(clka),
        .dina(dina),
        .ena(ena),
        .wea(wea));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module Bias_Bram0_blk_mem_gen_prim_width__parameterized16
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ,
    clka,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ,
    ena,
    addra,
    dina,
    wea);
  output [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ;
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  input clka;
  input \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  input ena;
  input [11:0]addra;
  input [8:0]dina;
  input [0:0]wea;

  wire [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ;
  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  wire [11:0]addra;
  wire clka;
  wire [8:0]dina;
  wire ena;
  wire [0:0]wea;

  Bias_Bram0_blk_mem_gen_prim_wrapper_init__parameterized16 \prim_init.ram 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_2 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ),
        .addra(addra),
        .clka(clka),
        .dina(dina),
        .ena(ena),
        .wea(wea));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module Bias_Bram0_blk_mem_gen_prim_width__parameterized17
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ,
    clka,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ,
    ena,
    addra,
    dina,
    wea);
  output [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ;
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  input clka;
  input \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  input ena;
  input [11:0]addra;
  input [8:0]dina;
  input [0:0]wea;

  wire [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ;
  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  wire [11:0]addra;
  wire clka;
  wire [8:0]dina;
  wire ena;
  wire [0:0]wea;

  Bias_Bram0_blk_mem_gen_prim_wrapper_init__parameterized17 \prim_init.ram 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_2 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ),
        .addra(addra),
        .clka(clka),
        .dina(dina),
        .ena(ena),
        .wea(wea));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module Bias_Bram0_blk_mem_gen_prim_width__parameterized18
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ,
    ram_ena,
    clka,
    ena,
    addra,
    dina,
    wea);
  output [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ;
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  output ram_ena;
  input clka;
  input ena;
  input [14:0]addra;
  input [8:0]dina;
  input [0:0]wea;

  wire [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ;
  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  wire [14:0]addra;
  wire clka;
  wire [8:0]dina;
  wire ena;
  wire ram_ena;
  wire [0:0]wea;

  Bias_Bram0_blk_mem_gen_prim_wrapper_init__parameterized18 \prim_init.ram 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ),
        .addra(addra),
        .clka(clka),
        .dina(dina),
        .ena(ena),
        .ram_ena(ram_ena),
        .wea(wea));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module Bias_Bram0_blk_mem_gen_prim_width__parameterized2
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram ,
    ena_0,
    clka,
    ena,
    addra,
    dina,
    wea);
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram ;
  output ena_0;
  input clka;
  input ena;
  input [14:0]addra;
  input [0:0]dina;
  input [0:0]wea;

  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram ;
  wire [14:0]addra;
  wire clka;
  wire [0:0]dina;
  wire ena;
  wire ena_0;
  wire [0:0]wea;

  Bias_Bram0_blk_mem_gen_prim_wrapper_init__parameterized2 \prim_init.ram 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram ),
        .addra(addra),
        .clka(clka),
        .dina(dina),
        .ena(ena),
        .ena_0(ena_0),
        .wea(wea));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module Bias_Bram0_blk_mem_gen_prim_width__parameterized3
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram ,
    clka,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 ,
    ena,
    addra,
    dina,
    wea);
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram ;
  input clka;
  input \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 ;
  input ena;
  input [13:0]addra;
  input [0:0]dina;
  input [0:0]wea;

  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 ;
  wire [13:0]addra;
  wire clka;
  wire [0:0]dina;
  wire ena;
  wire [0:0]wea;

  Bias_Bram0_blk_mem_gen_prim_wrapper_init__parameterized3 \prim_init.ram 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_1 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 ),
        .addra(addra),
        .clka(clka),
        .dina(dina),
        .ena(ena),
        .wea(wea));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module Bias_Bram0_blk_mem_gen_prim_width__parameterized4
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ,
    clka,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ,
    ena,
    addra,
    dina,
    wea);
  output [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ;
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  input clka;
  input \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  input ena;
  input [11:0]addra;
  input [8:0]dina;
  input [0:0]wea;

  wire [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ;
  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  wire [11:0]addra;
  wire clka;
  wire [8:0]dina;
  wire ena;
  wire [0:0]wea;

  Bias_Bram0_blk_mem_gen_prim_wrapper_init__parameterized4 \prim_init.ram 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_2 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ),
        .addra(addra),
        .clka(clka),
        .dina(dina),
        .ena(ena),
        .wea(wea));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module Bias_Bram0_blk_mem_gen_prim_width__parameterized5
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ,
    clka,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ,
    ena,
    addra,
    dina,
    wea);
  output [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ;
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  input clka;
  input \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  input ena;
  input [11:0]addra;
  input [8:0]dina;
  input [0:0]wea;

  wire [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ;
  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  wire [11:0]addra;
  wire clka;
  wire [8:0]dina;
  wire ena;
  wire [0:0]wea;

  Bias_Bram0_blk_mem_gen_prim_wrapper_init__parameterized5 \prim_init.ram 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_2 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ),
        .addra(addra),
        .clka(clka),
        .dina(dina),
        .ena(ena),
        .wea(wea));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module Bias_Bram0_blk_mem_gen_prim_width__parameterized6
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ,
    clka,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ,
    ena,
    addra,
    dina,
    wea);
  output [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ;
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  input clka;
  input \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  input ena;
  input [11:0]addra;
  input [8:0]dina;
  input [0:0]wea;

  wire [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ;
  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  wire [11:0]addra;
  wire clka;
  wire [8:0]dina;
  wire ena;
  wire [0:0]wea;

  Bias_Bram0_blk_mem_gen_prim_wrapper_init__parameterized6 \prim_init.ram 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ),
        .\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_2 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ),
        .addra(addra),
        .clka(clka),
        .dina(dina),
        .ena(ena),
        .wea(wea));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module Bias_Bram0_blk_mem_gen_prim_width__parameterized7
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ,
    DOPADOP,
    clka,
    ram_ena,
    ena,
    addra,
    dina,
    wea);
  output [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ;
  output [0:0]DOPADOP;
  input clka;
  input ram_ena;
  input ena;
  input [11:0]addra;
  input [8:0]dina;
  input [0:0]wea;

  wire [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ;
  wire [0:0]DOPADOP;
  wire [11:0]addra;
  wire clka;
  wire [8:0]dina;
  wire ena;
  wire ram_ena;
  wire [0:0]wea;

  Bias_Bram0_blk_mem_gen_prim_wrapper_init__parameterized7 \prim_init.ram 
       (.\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram ),
        .DOPADOP(DOPADOP),
        .addra(addra),
        .clka(clka),
        .dina(dina),
        .ena(ena),
        .ram_ena(ram_ena),
        .wea(wea));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module Bias_Bram0_blk_mem_gen_prim_width__parameterized8
   (p_43_out,
    clka,
    ena_array,
    ena,
    addra,
    dina,
    wea);
  output [8:0]p_43_out;
  input clka;
  input [0:0]ena_array;
  input ena;
  input [10:0]addra;
  input [8:0]dina;
  input [0:0]wea;

  wire [10:0]addra;
  wire clka;
  wire [8:0]dina;
  wire ena;
  wire [0:0]ena_array;
  wire [8:0]p_43_out;
  wire [0:0]wea;

  Bias_Bram0_blk_mem_gen_prim_wrapper_init__parameterized8 \prim_init.ram 
       (.addra(addra),
        .clka(clka),
        .dina(dina),
        .ena(ena),
        .ena_array(ena_array),
        .p_43_out(p_43_out),
        .wea(wea));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module Bias_Bram0_blk_mem_gen_prim_width__parameterized9
   (douta,
    clka,
    ena,
    addra,
    dina,
    wea);
  output [0:0]douta;
  input clka;
  input ena;
  input [14:0]addra;
  input [0:0]dina;
  input [0:0]wea;

  wire [14:0]addra;
  wire clka;
  wire [0:0]dina;
  wire [0:0]douta;
  wire ena;
  wire [0:0]wea;

  Bias_Bram0_blk_mem_gen_prim_wrapper_init__parameterized9 \prim_init.ram 
       (.addra(addra),
        .clka(clka),
        .dina(dina),
        .douta(douta),
        .ena(ena),
        .wea(wea));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module Bias_Bram0_blk_mem_gen_prim_wrapper_init
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 ,
    clka,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_1 ,
    ena,
    addra,
    dina,
    wea);
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 ;
  input clka;
  input \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_1 ;
  input ena;
  input [13:0]addra;
  input [0:0]dina;
  input [0:0]wea;

  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_1 ;
  wire [13:0]addra;
  wire clka;
  wire [0:0]dina;
  wire ena;
  wire [0:0]wea;
  wire [15:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOADO_UNCONNECTED ;
  wire [15:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOBDO_UNCONNECTED ;
  wire [1:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOPADOP_UNCONNECTED ;
  wire [1:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOPBDOP_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB18E1 #(
    .DOA_REG(1),
    .DOB_REG(0),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'hC6D065D19F133FAFD8F64F138453E25AD318B66D5D6768E660C06DE5DEC65F24),
    .INIT_01(256'hD036D2994B963392D73E19A6880DAD1FC7B98E4A067F221CABCE056BC504818A),
    .INIT_02(256'h9720C50092941FE36A3D6026283BF707C804BA7C008CCF952455F100A8C7000C),
    .INIT_03(256'h7D0AC76BE3F3539494B5A0F77FBE007F89F80862EB2DDBC619E9CED7DCF68CF0),
    .INIT_04(256'h2DC1E0B10E539A98A5D2EF81D7933258B0B9856A5E3E53C67B743F0101B04941),
    .INIT_05(256'h60D1A6B6DBA4A81204E6E8E905B30ED62A25E22C9527424C34597145E1639A4D),
    .INIT_06(256'h97B9B15AC61C5FA525617E9E255187C62EA595A2C2ED5580B8AF4321DB170001),
    .INIT_07(256'h182C8498302EC2E519102D71EA6141349DF6592116EC1477BC1C37BBB4BA51C9),
    .INIT_08(256'hCE99966B110550319E899D78AEACDCF5360764FE82E215E2B14E0CDD0DB99A09),
    .INIT_09(256'hA6B168AD769284B4ADD633BEBC61152BD36C09730162A91313A40471E33EB223),
    .INIT_0A(256'h27E33D081A9E89500BE7D060195166A1F6A6DA69E23E1ACA9B4D4C0505855152),
    .INIT_0B(256'hBD699B0C845900708F4EB3F970E8CAB4427F4CC053FB350601AA62D731CFC096),
    .INIT_0C(256'h9C84B18FFAFACA51089FD13C8A7826A51315B6319AB9D194184202AADC442047),
    .INIT_0D(256'h88C4E5D8265918972B21A3210DC033593D0D147A5D58154B55BA2F87A8F95D7F),
    .INIT_0E(256'hD6C3871D35A88905F9D7B3A2F19F998C39B31A92426D0E4B0858FD4786481BF8),
    .INIT_0F(256'h008788FA4014598F488643955CC6325CF0217EB923743E5F196875F2195B0819),
    .INIT_10(256'h969BBBD8DE2798D43A89020951C7600BE2B5D387817CA0B10749E2EA375EE9C1),
    .INIT_11(256'h98EB319578FBA8AC86784EAF9730BE3579F3108AA8C07AA6CAA73A93A0809AD2),
    .INIT_12(256'h102FF8414C2FD093ED166A533333025723A2E2F80FB164C6A0F9E2F382E1BF9D),
    .INIT_13(256'h87B8643F80077EBC17BE762C35EC357065970690E80380A168925285A516E01C),
    .INIT_14(256'h001982F18EB392452EFB1304C3758D443651C7BD01A4B8B4F770680BA5ADBE90),
    .INIT_15(256'h66CEA7B58874776A7369BCBD05A497BB0468F778826F30EFB083085E70557149),
    .INIT_16(256'h3FFCEF8F9C43368DB762E882E33A68B8A8EC7CEFDBFE4FD405295E204F33D9FE),
    .INIT_17(256'h8790D703054EBE27CE0C3C7C18350E900288309B6CD1B2B9EE8DC5BDC7F1A00F),
    .INIT_18(256'h0337460C226A91F037AD2F01DBEC109018F8EE9B39699E41E19915A75CC77298),
    .INIT_19(256'h764E1FF993266E0EF36052EC0781D20B2AC4603033B3694CC27B71A03C535D7B),
    .INIT_1A(256'hFD657CD45EAC52CB6EB818A2D2AE330E6E9A35D3B99DAF9778DDDAFAA00F402D),
    .INIT_1B(256'hD7EE5787EB1A1D73BECB526B30FC1DFF741E866B896E3308475924F44CFD20A0),
    .INIT_1C(256'h5FDB66836994E2573CC366DB9C89AF420294A478B7A17E987A66FF9BA078E052),
    .INIT_1D(256'hFDE40C68291BE63ED1A10F1178D79A4787A0FED84E71CE2D8F7013FB27C69531),
    .INIT_1E(256'hB8D43FAB0D0098E1D00A176725C9F387C35BDC750007FE7414FAB27ABF1E0E72),
    .INIT_1F(256'h6D7AD54D4D9DF146826EB3E9FA35434FC4851E390BC77B24167B345C1FB7392E),
    .INIT_20(256'h01CE199C87B0DB9A4244BC7BC13E3D07DDDEB6745E53D4E58049D472A57380C8),
    .INIT_21(256'hCEBFADD6CC471A0609F4C324277BFACF7951893440C1AF082C2E40BE0BBC1D82),
    .INIT_22(256'h2210F960B10387B42DFCC1027077EB4586E8E506D4CE079A1E92127B4CB1F403),
    .INIT_23(256'hB533DF8ABA687ED5B9B5415928525E66B7F22864D7FAE9DE806F4775D55EDD9C),
    .INIT_24(256'h4370BDD9687542021E882F966BD895999E18CBF4D5897EB32C9922ED50C0224E),
    .INIT_25(256'hD993490EC54901A573834A6BC7747AC2EDBF8BF57F38CA53306E613ED539E482),
    .INIT_26(256'h8B64C05F917DB0BED30755EF9D0A51EBE08192C7C10529EC18DDC1087A12A9F9),
    .INIT_27(256'h6297CEE501BEB07EE3FB8592EE0BD1AE95D0E67DA3AB16616D95DC1204FA9816),
    .INIT_28(256'h63A11733C6943CFC01EEB9FDF35519D488958403623B22ED83638AB34998AEE2),
    .INIT_29(256'h420E47960F82D8CE92B2F57C905D3F85333786BF5CEF9DBD09E39AEBC458E035),
    .INIT_2A(256'hC63E2550B61C0CD41DBE82D7DA0EB783A2AECA68C04BE14D866C5931CBE68907),
    .INIT_2B(256'h55C2233363694B5EC4CC41C7ABA10A75EFAC9DB4E540236BA3FA061C085AA00F),
    .INIT_2C(256'hBA1AE6AC809415CC72A483D505C946E992164419DF422FCF01FCBE266DCA5CD6),
    .INIT_2D(256'hE822F2E3AC2B2702970C594F4A2A8A2A5336B9A240B17B922AF3BE17FA3CBC80),
    .INIT_2E(256'h3BF54CBDA8682A28EEB255A28C371720DF8831C735E4C3D944A51AAC97CC8B0D),
    .INIT_2F(256'h1DA6B4C74359197AA1064AFAC78C83B7BFE22E83461A14D63AE0A77075784DB1),
    .INIT_30(256'hD513078B09A7488CD8AC459F05A80884164D6036E39A9317EDEE2F2A92A0C434),
    .INIT_31(256'h2405E002BBF6C71FD0F4629C9B33B1C2AEA50FF12D08897D163844D09991D728),
    .INIT_32(256'hDB579F626569A2612E755D0B28CDC3FC7DDCD3F702185990566ECF1B7500066D),
    .INIT_33(256'h4EBE5E8DC8841404FA47FDC3E05D1CCD0645E511F7E51554E5D10E205649989E),
    .INIT_34(256'hA34FEA40125E3384D3E934F7FF8C0FE789A2923A6D6124ACBBA92E6A9A0263F2),
    .INIT_35(256'h83F9E88AD0A17E2714B938598C6AE2D66DC6B83D90E2BD94B97F079A5DF59B61),
    .INIT_36(256'h5156F437BBD717A5E1A1E4F916A5F8252DC04F77A053F44D9870CEAEF354CDEA),
    .INIT_37(256'h1CAF0225123B80E104CB9ED7E2B4424E3273C62817401308CF5C5A6AD4575C10),
    .INIT_38(256'hB800654A2F8DD3F9B4CD8628A88D786F8D554E1546FE4131A5877423F1C3EA51),
    .INIT_39(256'hAA3BDDA5BC4C6B2EEE70029C475156C80D2A54AE51D43AD9B1B12B1C64EC1A05),
    .INIT_3A(256'h05F2B32514B6D326A124C65854B99E66C5978932570A31A44D945CE542165189),
    .INIT_3B(256'h0342E75C2F7C8799B7C0C069EB8A082D8DD5723F68323622059465396177002E),
    .INIT_3C(256'h89146640EFA93833CCA7A95667B6644D356197497900B8A439919F953E20299A),
    .INIT_3D(256'hC6A3AC4EF79340DB1484011AFDBFFE55C71D9FC53364A3DAC5548024120FDFD4),
    .INIT_3E(256'h19C49F6BE64A67780BDB76E42DD58ED4B0180C477AA7E98FE6E0196DDD5CDB75),
    .INIT_3F(256'h3016EB88F3EDFEE46546F33666768DF862DCC2F405B2F2F41A9DC2A2C98FFA5C),
    .INIT_A(18'h00000),
    .INIT_B(18'h00000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(1),
    .READ_WIDTH_B(1),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(18'h00000),
    .SRVAL_B(18'h00000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(1),
    .WRITE_WIDTH_B(1)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram 
       (.ADDRARDADDR(addra),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,dina}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOADO_UNCONNECTED [15:1],\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 }),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOBDO_UNCONNECTED [15:0]),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOPADOP_UNCONNECTED [1:0]),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOPBDOP_UNCONNECTED [1:0]),
        .ENARDEN(\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_1 ),
        .ENBWREN(1'b0),
        .REGCEAREGCE(ena),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .WEA({wea,wea}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module Bias_Bram0_blk_mem_gen_prim_wrapper_init__parameterized0
   (DOADO,
    clka,
    ena,
    addra,
    dina,
    wea);
  output [3:0]DOADO;
  input clka;
  input ena;
  input [14:0]addra;
  input [3:0]dina;
  input [0:0]wea;

  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_i_1__0_n_0 ;
  wire [3:0]DOADO;
  wire [14:0]addra;
  wire clka;
  wire [3:0]dina;
  wire ena;
  wire [0:0]wea;
  wire [15:4]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOADO_UNCONNECTED ;
  wire [15:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOBDO_UNCONNECTED ;
  wire [1:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOPADOP_UNCONNECTED ;
  wire [1:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOPBDOP_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB18E1 #(
    .DOA_REG(1),
    .DOB_REG(0),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h6D1F720BAEF565E1CA3406B526BBF657EA86AAABB417EF5FD057563A22006A4D),
    .INIT_01(256'hE0C0B69673092171C2DC4314ACF18DD6F72294671E137B10C54A6CC7C2E97FA4),
    .INIT_02(256'h040ED14092E814364ECF6919F7087B1526D22D96B4BDA8AA4AFDC676EB76D123),
    .INIT_03(256'hC1F2048E094A8C55213F3DBDE1369D8974C565C04F28ED720AF5D64AD5CB4470),
    .INIT_04(256'h9D7B5E538AF630A8A9F7038E36B7E097C3807D1F3200FCF8495F38E92DA81DF6),
    .INIT_05(256'h4A16FFF096005BDB3315A3F79BBF6B7D80A6A23428FDE989DA85DC2BDD98C14E),
    .INIT_06(256'h70EC73384EDCF2599709183AF127A39BCB9B9FFC43770E3F8D30D9E0C9092038),
    .INIT_07(256'h44C724B0EB1DCE3A09B29542BF3880B41D2762EDA62967287A3FB476F35B288C),
    .INIT_08(256'h2178E1C36C4221F0DCEA4353C8D2CF94259BF1E722E599BAC9F3F51688700493),
    .INIT_09(256'h5801FE4EF771DF77EB03F3F2711C6BDA9D5839C518545DEF24C86864A1470B1D),
    .INIT_0A(256'h26A6704B1C5BE0728F197C1787548E5DFBC817710AD9B18821617B35D426587D),
    .INIT_0B(256'h593F55C2907A125355EE0E44268A850688B8AA164A84CC98FE64414102DE97D2),
    .INIT_0C(256'hC6981611F278AF0F37C0A84A8363FFBEEABB84E6161322F837BB5C4E0B1FFD20),
    .INIT_0D(256'hA9BB8BC74F850D3BEED972BE9097043C7DF846550F0F44109DEF928402C7243A),
    .INIT_0E(256'hE282861794945952EDCEB6DC57D3CB8E157AFC40327B1F25FDDE7D8BC5A78694),
    .INIT_0F(256'hA40711EEE6B89413375668420AEEA56ED8AABFEC3199864DD58E4D31EEE17755),
    .INIT_10(256'h77B24FEFF7830DA396124AFC8CF86823D686795FE75061B382F84FDB2B92083E),
    .INIT_11(256'h2566A89DA863DDACFB0DE103710DDF932CB62547D6FE391492BFFC884A1C5A9E),
    .INIT_12(256'hDA1EB5DD8017C1F744DD8BD90DA8A837A938ADFD35AFEC9BAAF146E63399FE96),
    .INIT_13(256'hE803C7B010F77EBA8EDFE2A2E3D29BAD691A5F21B41A97EB92F634B9C29697E5),
    .INIT_14(256'h886AC9C4554EBBBBDB25D09CE8DA26BF0F32A1E4F7204A561B67D9D8EB477165),
    .INIT_15(256'h3A3453D8255FEEA3FBA73CEE8332A8F362C3F8939E6AC0678C51DAC0ADBE8497),
    .INIT_16(256'hEB55CA3D95C14D9441439944B20349F150A10A08B3774CD17809603D99FCA636),
    .INIT_17(256'hC19B513384DD9AE9BFC71CF5EEFFBE2EF6D823C6A5713C451F1D69D5C5D7A709),
    .INIT_18(256'h81EDF7DD9F98050291EBD99310EFC5970490136D191B9C8B0F3C7E25005D5FF7),
    .INIT_19(256'h43CFB569FC3D129F404EC89008BFA42DAE1249F83E933F068F99BFE1E6E5E82E),
    .INIT_1A(256'h00000000000000000000000000000000000000000000000000000000CF37ACE1),
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
    .INIT_A(18'h00000),
    .INIT_B(18'h00000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(4),
    .READ_WIDTH_B(4),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(18'h00000),
    .SRVAL_B(18'h00000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(4),
    .WRITE_WIDTH_B(4)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram 
       (.ADDRARDADDR({addra[11:0],1'b0,1'b0}),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,dina}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOADO_UNCONNECTED [15:4],DOADO}),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOBDO_UNCONNECTED [15:0]),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOPADOP_UNCONNECTED [1:0]),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOPBDOP_UNCONNECTED [1:0]),
        .ENARDEN(\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_i_1__0_n_0 ),
        .ENBWREN(1'b0),
        .REGCEAREGCE(ena),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .WEA({wea,wea}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0}));
  LUT4 #(
    .INIT(16'h0008)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_i_1__0 
       (.I0(ena),
        .I1(addra[14]),
        .I2(addra[12]),
        .I3(addra[13]),
        .O(\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_i_1__0_n_0 ));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module Bias_Bram0_blk_mem_gen_prim_wrapper_init__parameterized1
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 ,
    clka,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_1 ,
    ena,
    addra,
    dina,
    wea);
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 ;
  input clka;
  input \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_1 ;
  input ena;
  input [13:0]addra;
  input [0:0]dina;
  input [0:0]wea;

  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_1 ;
  wire [13:0]addra;
  wire clka;
  wire [0:0]dina;
  wire ena;
  wire [0:0]wea;
  wire [15:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOADO_UNCONNECTED ;
  wire [15:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOBDO_UNCONNECTED ;
  wire [1:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOPADOP_UNCONNECTED ;
  wire [1:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOPBDOP_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB18E1 #(
    .DOA_REG(1),
    .DOB_REG(0),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h038438D7592E7DF3ABCEB3A9030102FEDA8D20120101259CFFB708D0523521A5),
    .INIT_01(256'h543E00CB9CB466B96252B396699D31943866FE0D8400D9CFB1150057DD261607),
    .INIT_02(256'h0366E2D6A6B6801BC5D803589E1B81C19278118F583B26F9D3E30DF4E7E6BB22),
    .INIT_03(256'h0D3302304AC99CBF3555FDE2FB3561B6295587284943E94737936E9C7861AAC5),
    .INIT_04(256'hE2E70C50F5FB0F53756E15C6FCC8B05B3E3DDD0DD361C4F4AE9B0B68CDB5B9EA),
    .INIT_05(256'hDF30E9E948A7C5694FC4528CAE31FBA4171369E1526B2C0F52B8BD36A8B05FBD),
    .INIT_06(256'h02C1E26CF2EE83FA549B677170B073207E11FF8724ACFA69A218027D8A4A8A23),
    .INIT_07(256'h3F4EC95FA853B6B2B9CEB65665A5A8C9370F6BAD6BEDEB6C85235A7162E116BD),
    .INIT_08(256'hFFA8103B6794CAC922DD2274A71DF160352017A0EE81BD9C4EA11B6A25DC5F87),
    .INIT_09(256'h9DC1A99B23CEBA966716C24E079D50AE1AD9F60C361121EA3FEA2842DDE977EF),
    .INIT_0A(256'hDFB6B95790D0EDC493EA8C4AF89A9A021C58E41CCE70D12B7B6EBCDE8E60F47B),
    .INIT_0B(256'hF2639109B4E5534D7F93B774AA0B64759FF11CAA0C0C3430ED13A83C0FF86767),
    .INIT_0C(256'hAC021D84CD215381AF47E3A71F6F9DA02CB367D9B5623D36137232CE728C3170),
    .INIT_0D(256'hD26F090FCAAAF6072602BA2DF22AA7798F6D9404EB647B08EF4E71EA35525FF5),
    .INIT_0E(256'hDE99ED84765484734385F4496070D9B891B7094D96977408787D9F7F9A2920AF),
    .INIT_0F(256'h5814904D74567EF988EDED88E272748B8DA25398A47A3F87246AC47D4E217A3A),
    .INIT_10(256'hB6B079EFD5B61433CB282D6BEC6565C09AD5A8EF778432F82F181B711EC4F97A),
    .INIT_11(256'h34BABDAD40D59B9828F39604BE34D6BFE074A2B7612507BED59F86D60E2F2900),
    .INIT_12(256'h8F474DA7796B28B414413EF7CB91705C36C8940AA03941DC430B7114E437C670),
    .INIT_13(256'h799A5672312518B6F530123BE949314331CA6298B19188E1153B34AA703C46DB),
    .INIT_14(256'h04EE74078E1FC7CFA7295265B95E3801181375F06524CEC4C94A41122EB5C047),
    .INIT_15(256'h63551C6D886075B07E89FC934AF362970B6173DCB08D750E2A04DF7DE6976603),
    .INIT_16(256'hFCD9B4611144DFCF4556165CF3809D79BA8C5E5B74E9A7C51266CE02BBC80392),
    .INIT_17(256'h3D4B39C8443CD0F4C3A033554849A16109EAFC4AA416493E6C069E918F46403C),
    .INIT_18(256'h92C7882096B09199209139C62A51005992505CB4E021997C4264CD8ED9EEFEE3),
    .INIT_19(256'h8793FB599B91831EC06040948DB4624BED48D2690C1C01C87476F52ED30DF0E3),
    .INIT_1A(256'h2E578187B7C13124F55193E00ABA6FAAF087853D2DD8A2B6B694D904679E1E59),
    .INIT_1B(256'h1212313229B794017AB7220A750148C5C8E456908F9D781BCB51EAE965310DB8),
    .INIT_1C(256'hB4D4D2B89E5E170BF535FB098EDCF3A2F13CBC124028F4CFBED2349609853128),
    .INIT_1D(256'hE1555BEA77AD07B516F47C140B9C66931223CE78216216850D90B3FFFAA8132D),
    .INIT_1E(256'hDEFA1891F4096CE559859B1433190A95BD80F810E95805D4881B5E28337EB48F),
    .INIT_1F(256'h46C4D4EC93EAAC130000D72DB64A4C1F025369373A7E82FEEE3607FDBFD0B182),
    .INIT_20(256'h4B7D8B465A0B4AE94FF8C5034CDCE8ABD51756E26BD2005A036C128830FE0D8E),
    .INIT_21(256'hA015ADB2FB1214B7B20BF850F15A6CD9BE10220262EFFFFA9C18078648570E48),
    .INIT_22(256'h67FB24A9502F5DD103FC560AAF48855ECA534D7939DD78BACC259157785879D7),
    .INIT_23(256'hE418D015D8DC57E3A2AEDBCAA3BDC28AAC98A71404A74D3CD3AC90794968A7EA),
    .INIT_24(256'h3FD0DC57665D7B2942833727D5B233FE57219D6CF5C5A0A06266B36801AE07FB),
    .INIT_25(256'hF95BFD8777413CA2BBFE77E2CDB256F423DE09048AE817C0E58AF89D1D87132C),
    .INIT_26(256'h728ABF4FB40BB9310FBDAAD5907A8AF361E58769E4E50857BE8E5F4210E773C3),
    .INIT_27(256'h2C3C95B11E41F5D3E64D7D2109F9FE85837F38E4154C8FA82F7960F88BD4C646),
    .INIT_28(256'hA9FDE2D0DD11943A67E79FB1277DA41851C39FC976953F6829214A4AE1FACF71),
    .INIT_29(256'h9A82347FE94AE002E284B2C77B44FCE22BEFCF39C7CF9EAC6F4ABE3E1FA8BDD1),
    .INIT_2A(256'h6FFF87135F0DFDFD3F3A718EABC75C526575599D58B233B3756F4B4508E93E3F),
    .INIT_2B(256'h4ABA60D33F7FEBD4F9ED1DC5FFF35D4730CCE26F5819B3C8A06C4738A1949FD4),
    .INIT_2C(256'hFD82A668566B8A3EDC47464918D7AB5EBF283EC59AF77597C8CE156E32C9DE85),
    .INIT_2D(256'h4AF5BB754C6E8F8609F7308F84F7FE14B14F86D44467BD45F65EF4CE59AA4A72),
    .INIT_2E(256'hEFEC63746F5AEC5A628A0DAE0E22B68B6E0979F68924B502C1AA0C489ED34724),
    .INIT_2F(256'hD9565AE6C59E40C7762C3241055885D9357B4E5FE620313EF2F4F5A374FB7144),
    .INIT_30(256'h856575578E7CA24E2BFBACF28B8A3E2AFF444FE850186BD7CBFD96316F888669),
    .INIT_31(256'hC58E9DACD24F669AB03DA33488E571375BFA557674F624CF815CC52398FC4551),
    .INIT_32(256'h6D0D73E18002125341BF70EB745D531F6AE4E2AD42780FAB9E722432366EB61E),
    .INIT_33(256'h30DEC277E9025507A7F17FA4714C962012380FB5F72DA9E5A91567D3BAC49321),
    .INIT_34(256'hF784066D752B90763DFB738C16C56B4874BD42404833AE751FD250B879499D21),
    .INIT_35(256'hAB6747ACD6CAB077A368AC06114C5370A4E73759F1205FC298D7A894649975AE),
    .INIT_36(256'hF6EAACADC2B733C59791E6232FE3DDDCA63D98E5372B89BED574A26C8404B68D),
    .INIT_37(256'h91AB82F9CB783534C356B1D8B2B8CEA241D45090A0583E9EA71AAC18E2D51241),
    .INIT_38(256'h4F88155973C96C5EAED4D98425299C945F2A3E48E427BD213697ED5FBCAA4FDF),
    .INIT_39(256'hD9ABFC368DC24804E05EC1E68BE94DE9865E6474705269347B66AA2DDAEEC3A3),
    .INIT_3A(256'h4E73A9499E23AB2DDC2578056CB01E733F3B1EA85916A96ED64C6AB681ADB2FF),
    .INIT_3B(256'h1E60815154CCAB42CF0A3AD7406921EA79BDE37807DBC65C2314F74A0A21CF92),
    .INIT_3C(256'hB80EB2A760574BD850F7216712C4BC33F2B1154922CEA3A98A7F80C70C17F0BA),
    .INIT_3D(256'hA7E9901D49853D69D74697E5146008BD1CF112522B893A2601CE16AE262AA45B),
    .INIT_3E(256'h1668DC5C3AA064045E7307A77AA032CFBCD2BEFF9A61F0FBECA422B7BB557DB7),
    .INIT_3F(256'h2ED27B37BE0F95A70B92CAF900C119C23BB04D04594730C7A3EA815B046A4593),
    .INIT_A(18'h00000),
    .INIT_B(18'h00000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(1),
    .READ_WIDTH_B(1),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(18'h00000),
    .SRVAL_B(18'h00000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(1),
    .WRITE_WIDTH_B(1)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram 
       (.ADDRARDADDR(addra),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,dina}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOADO_UNCONNECTED [15:1],\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 }),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOBDO_UNCONNECTED [15:0]),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOPADOP_UNCONNECTED [1:0]),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOPBDOP_UNCONNECTED [1:0]),
        .ENARDEN(\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_1 ),
        .ENBWREN(1'b0),
        .REGCEAREGCE(ena),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .WEA({wea,wea}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module Bias_Bram0_blk_mem_gen_prim_wrapper_init__parameterized10
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ,
    ena_0,
    clka,
    ena,
    addra,
    dina,
    wea);
  output [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  output ena_0;
  input clka;
  input ena;
  input [14:0]addra;
  input [8:0]dina;
  input [0:0]wea;

  wire [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  wire [14:0]addra;
  wire clka;
  wire [8:0]dina;
  wire ena;
  wire ena_0;
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
    .INITP_00(256'h044044A19A099CD3748438A90011396C21044A0105031BE58610E20535936601),
    .INITP_01(256'h798040063550EB0130001A0080610C504C2880259400C50500C015FF1FFF0640),
    .INITP_02(256'h212AFB27E3279BDBEFB96F7F39BD37CEFBFDFEF54FEF9F5C7D60054286A3D87A),
    .INITP_03(256'h49000081000000072400C110ED5A82E43A0904DC650653660685EAE34C3C1648),
    .INITP_04(256'h531727DF7DE1EB3E3E1CA886A237AC969D263C9F001404080002008050000000),
    .INITP_05(256'h100A24080800000004414080806800000000310800000C0066A2B9B41CF793B8),
    .INITP_06(256'h30928049B7438145FAD72DCF48E233FA3FF975ECB3C7CEE273C8D729B3F3EF53),
    .INITP_07(256'h00010A00240202901C44501684A5907F2F59825E02A013552786855AC210D477),
    .INITP_08(256'h5183410000210080040242009A009CD02A2F269740080882C02200004043D820),
    .INITP_09(256'h1920001010810011110340004020004816110000220000000080000098803000),
    .INITP_0A(256'hA50DB0BAD6993B3A39EFC4E71AE6B1DB428F56D172CCB7203F4B773F03400052),
    .INITP_0B(256'h03182098A060038D0A3805933B572058DB397658C03289D3C2834F60D6C627BF),
    .INITP_0C(256'h10400500090000C1C02D09C00946918C104A44100A200B08540008141A084850),
    .INITP_0D(256'h61A9445B4677694CFE9DF9E2B7A581DC40F9BAC4B8005681C832342050290208),
    .INITP_0E(256'h8282393C7187D3B7DCE1B83D55A12FBEDBE17E9489E268E4CC6E89DA784E83B4),
    .INITP_0F(256'h00EF2C522EE428B130E6213055C09247D246E3B10467001305E190C39C39433A),
    .INIT_00(256'h4A55EEE19CAF8280FB5B71B91C5CFBF401FF996BD4B0FF9BA8729BDB475981E9),
    .INIT_01(256'hF430132829EAF52C002B61EE03030000FFFFE72C1413FFB41B342F1316FC32FF),
    .INIT_02(256'h0115161302F80EF90709121C2417FCFF484D00E6F453BBDEBBEBF10335CE1BA8),
    .INIT_03(256'h1118FF11181A16FF051B090A11FB011117FD171CDE08FE091D1A0D29240A1DFA),
    .INIT_04(256'h0D25040612150222130E0AFE002216FB1A18FCFEFF1947FD18F8FE0AF8D11317),
    .INIT_05(256'h33F6C2FD39FB0004EB740E0F00F22F2C0E1DF6FBF5191007FF16F809FD050CF9),
    .INIT_06(256'hFD5503F0E810C63B0104353EF79763E8D63404C6FFE70304FCFA00E97E25B9FF),
    .INIT_07(256'h0D0B341A5DFD440731E00315330D03335DFF05031FFDC800FA59FD4173000EFC),
    .INIT_08(256'h033053C6DFBEBCAACC987DB3AA7FE854055C01B934FCFA2305F304390037062E),
    .INIT_09(256'h131E457515813A24DF9D103458794D3422642CAF1AED5B5CC6C8D3DBC792AACE),
    .INIT_0A(256'hE24A5FFD57DB2140543F58535F6D4E50EEC6211238FE09D8293C770E56EBC6B8),
    .INIT_0B(256'h72DD5959E8D35818430CE815CC144575DF7F761B792601535203F61C23F947E9),
    .INIT_0C(256'hF96367084C371D5A049BFF26475915C14F54104BF5FD744D50DC61E4222B2F4B),
    .INIT_0D(256'h364AFFF009090A712F28167224844B58430736D8CF72B3462845284F5F534569),
    .INIT_0E(256'h1B17F4FB02FD28F50B9859FB030F8656DEF6BA45FD3AFCF400006C073E6D04FD),
    .INIT_0F(256'h13F9F4F1B3B60EFEFD4C121C053AC01B63FD040E8A3602BD390402283BCBEC8C),
    .INIT_10(256'hF90E0C0A43E3850ECC0DC9060608FFF3D8D9A7D8D62C122F1CF8FDFCFC12E23F),
    .INIT_11(256'h15CCE5DFF6FC2DEE0255C80E2A2304510D0E082A037D02FF555118360638F519),
    .INIT_12(256'h4824242AF7AAA5F8BBE46F0D9E14D1E1DF1B3469C6E07A5C17AE2270A7D35914),
    .INIT_13(256'hCCF2919AEB20CBEDC6BEC9CF9ECA00F4B5C6A0EDB7A0E01EDBF3C1CA21DD15F9),
    .INIT_14(256'h2011ECCFFD1608D9DB206CCCE0F119F2083BC3E2017FCDC3BEE3130CACCABB26),
    .INIT_15(256'hFD82BF2DD69D6AE1AA1CB3E48F0808BF1294D028DC77C0C609FFBAC0CFB997DF),
    .INIT_16(256'hE0BFCA160A04CCFF1607EA1812EAD6B9D51510EBFF07D085C9B429E7DB0A9DCF),
    .INIT_17(256'h0384FD9400007C0100CAFF5F2B7CE8F1CCF4CDE29D00C3F8210EDA0717FAD1E7),
    .INIT_18(256'hF0CFD20813FA617701E60AF6F1FF010F98B502E6A5F9FF0000186C88F8770B08),
    .INIT_19(256'h95067AD300FCFD06FEF101029BF8ABFEECA7F88AFB016B07FFF9FD798008F7FE),
    .INIT_1A(256'hB4F1F90CB9FC02FF057D2702A0E5FF4B16FA034B8100FFEA06E1F2ED00FFF59A),
    .INIT_1B(256'h0B08FCFFFF05F3CE14C70000E30C8D7FB06502ED06F6B10D58F2C1D6F8A28600),
    .INIT_1C(256'hE9AD87236EE87E9C30BC34EAD945F356BC076C4DAE5F2805E8E03C105FB4466B),
    .INIT_1D(256'h601BE16B39FB8E7EC4A36EB8934D9581EDFE767573830FF6989997D84D8C154F),
    .INIT_1E(256'h8282097348956794B5970486827E3C6F7D8F866973748E8E7C8F929773FCCAD7),
    .INIT_1F(256'h4DFA6354D62DAAF5435A60186325A22919978E6C9323243CCE855D039F7FA5E9),
    .INIT_20(256'h69F18FC2440C806579B691486587794C9436648892A92F1D78656F3FB98E9773),
    .INIT_21(256'h8BBCEF7453C15C7EEC9490896545F589A06D361B384E4E72C3AA7F816A734288),
    .INIT_22(256'h2FC2A29F8C66C77A8C5C5DFE1DF311FF6C4599695FF06B5486273B92F8927A76),
    .INIT_23(256'hD13DC4CFE4D079F3BE8FFF0A09DDF6023D01E3D1EAFF3052FD1C6CF17EBCEAB7),
    .INIT_24(256'hFE04FB0401A0FFC402A7ECF820EDFFFBE30FFF52EFFB4978FF0601F91AEEFB90),
    .INIT_25(256'hA67FEEF890C7FA4F1CEB6A8EFEB58B01FE77F52BF25B5252B309B8A693F56035),
    .INIT_26(256'h13EAFAF9FEC207F9F6F2FB987E98F8FDF183F467FF9A72BB0084CDF1F4F6211B),
    .INIT_27(256'h04F9F6D8123CF2FEC20108DF04AB70F94498FD9902FFDB40F42609E4E6FD7BFC),
    .INIT_28(256'h01BE7CE0F93A3300FCE8F0EE1AD59C21DB5813B305C0DCFA3600B2F3FF2C4E02),
    .INIT_29(256'h18DFEA4D4ABDE80EB720CB704215E43AC901B2C1E30F0EB4CB18F9DC61C41F08),
    .INIT_2A(256'h8056EA50701C503D753B138F2523797547537D58FBBE5A6A380D869DEC7B7855),
    .INIT_2B(256'h2E7FAD832E327AA7327C4301103E16BA4989FCEB936A56BC76433848F17B197B),
    .INIT_2C(256'hB8270A109481678096F2FB6BFB81637C6A896B73881855625B167F2F885B9D6B),
    .INIT_2D(256'h88345E75A4F62682A8EC7887872A52E14DD49A8C1A517475E53E66266D6E5533),
    .INIT_2E(256'h816E6C8ABC4B392C796280808A674547926208801EAC595E85285F45650D7C7C),
    .INIT_2F(256'h5D2A51EF7929193E0E505061E567A7456E32CE469BCA74296864682BF0435D47),
    .INIT_30(256'hE96429391757D6A2FBE4A5EEB5639282D0FBE6D6EAE5B5F260FF752FA23BFFF6),
    .INIT_31(256'h424CCAB93E08FCAD77D9079FA567877CDCA634E00D9BF1DC03559F32DF0047FA),
    .INIT_32(256'hB28BDA971504F8FBED9E6A0200F1FBC6FAF9422789A6FF3EECFFF1619000D26B),
    .INIT_33(256'h0F5DA6F8A1F3E1FE35D556FAED1410F870D9D6ED7DFF28CE99A5F82CE4F363B6),
    .INIT_34(256'h06A50688C7A50254DFF4E20A910CFF00820ED3FE9BC0FA76E8DEDF53F8C28AA9),
    .INIT_35(256'hF78AFFD8F943FF72DBFD775B797EA6FF141D9358EFE3327CFDEC0149A6DCF4F0),
    .INIT_36(256'hCA4DAFCE3CC49CF224F41F31800EAF9FA82B271B172560FB23C32E2923D708BF),
    .INIT_37(256'h2F0FF8F30658371CCA722DDE5275BC29E05F475E0123530E16F25875E16A22F8),
    .INIT_38(256'hB3E347392219D13A342D10F518005F32EEDC31F6318B346186F6E7D863DCDCE6),
    .INIT_39(256'h3F35E40500FFD8F7F922392D4BE2F740F7703B3D5EE534E014F200DCC324F834),
    .INIT_3A(256'h33712213223DD700C140CB1B2817631E665A08C25710EFD624C86BE621B744D6),
    .INIT_3B(256'h1657FC52FFD7BEFD1CC956D5F52B53D9D43130493B2CFD342AF02EDCC3E8EE53),
    .INIT_3C(256'hA805133739F06462DD27BF2351EF0FD3E4682DC8674E331A7299D1F8C7C9FAF9),
    .INIT_3D(256'h0BA10E1F0B2F188A0C6A950A0DB00B871043DC0FBFD4FEEB93FCF3A20A9B0116),
    .INIT_3E(256'h0B9AEF0B9E2310B49E76CA5CC50C701A0C11040C0D0BDAB09FEA0B05C011070C),
    .INIT_3F(256'h0AB70A09C2BC17F415AF0C0C12100C2D0CC5BA072C12240F0A02910A0BC50EEE),
    .INIT_40(256'hCE33F186B4C10BAC0A130D8D8F0738259C2193FF8A960F0ABF0CC818150A1013),
    .INIT_41(256'h15140BA19FBC07900F0BDE0B1717160B0F0A05C20012930C5109CA110C110CAF),
    .INIT_42(256'h094A0DB30E0EC5C8048211A62008121605B1A60FC1BDBEC9000B110B140CE3BE),
    .INIT_43(256'h3C28692D948AF52457847A08DEF7DFED2350BF1AC2364007812300AD048CF9C3),
    .INIT_44(256'hF4B868E6E23556A60DA265D72D6A4C83D02F0B9A8A9C98C6F6590AFE00415EC2),
    .INIT_45(256'hB2BC718691D204034B8F287A61AAA68C60EE30988C6EBF8415AE3BA48C706F9A),
    .INIT_46(256'hD15A6DDEA9817A219A99999D94827CD069778252D7859D4D8BA78E6B017B0B95),
    .INIT_47(256'h4DE642F5C8516DE3EE2945BF9A05DFB028F3E96EC41375D8759BA80E7BB14096),
    .INIT_48(256'hD6A612FFFC49B912DFBF7BA1954E7A1DA582FCBE79A3D0C8927387200E20DA78),
    .INIT_49(256'h748210968390207AEEA88C000F6C466F86827EC1378124796F6314712C5B026E),
    .INIT_4A(256'h3B65A37F9292C9B8C07ACA753A9E48CE4E7DA2A8334A7FA287A68B9E727D3964),
    .INIT_4B(256'h5DCA40F6A2ECE56A851D63F64A75ABE3617B6A7763479CA9BA26466F847DA4D4),
    .INIT_4C(256'h21B930BCAA7D93A94488CBA924394B8E397A86558E51623513BD7C0EEBC67A0A),
    .INIT_4D(256'hAA882ACD91928BB4938177B70AC0FBE38FE5AD6477A8742C8B92697328730722),
    .INIT_4E(256'h83B160054F1E925CD285486E9E98936AC7787C7389BA8D9358807EDD5772A2E1),
    .INIT_4F(256'h403830BA3F2E31B813AFDF805FA6A1939E7165008EAF5C86C8078E104EAA177E),
    .INIT_50(256'h3D215982AAB6BCCBAFEA3B891184A77B1B877B6968C1B73620D34EDB729795A3),
    .INIT_51(256'h076CEDEDFBF985628DF683BCD90BC5EF179F68F88BEEFCF76415C8F7FBD58264),
    .INIT_52(256'h2BFFD2A90C01F96FFCF10BA63FEB00699A89FCF93DB0FEE99A02FAA21D0C7409),
    .INIT_53(256'h92D1767EA5133F9C59816519FDC5EBBA15E303F95355FE83EEFD05D59F0C76FB),
    .INIT_54(256'h6616787BD16FF436D6FACB62300DFA6EE9783FBA038300FCF99877EEFD7510FA),
    .INIT_55(256'hAA93ABF6F90066E9CC35D325CACCE7FEFBFC000285F8650AF8EABF63B8ECA8FF),
    .INIT_56(256'h81FB09FA01E2E60B840095D3EEB68EF67A1CEBFDE9837E93500272FDFD48F37E),
    .INIT_57(256'hE85CD99D47EE77F404587374F7F113D0FF2BF3D6000000124860DCF1D41CA24F),
    .INIT_58(256'h80FF1CE0D2F5C311FDC31D2183AAE67B6810FF7E0A90B7CA6974F18D6859FDFB),
    .INIT_59(256'hFFF987015B07F801FD6E180D0220753A01552C81F2B6DBFDEAF9FE4268027D00),
    .INIT_5A(256'hF4FF7AC98070001B5652F0E11DD1FE35FD60EB02F9E05AFAA0B93DA3366AF2A3),
    .INIT_5B(256'hA41169A5970EFBF07904AFFBFF0D02F30AFAF79520E8F21447C07EA5E1D88807),
    .INIT_5C(256'h96C7F5FFFD9189C126CC71A79DFAC0EE7B61FF059DB40082DB9480ACF2055B07),
    .INIT_5D(256'hB4713040F4F1E038861CA2F0DD5D29555226062B36D91ED1A41D1AF54F2CF4D1),
    .INIT_5E(256'hD91891D0CB55057077C8E53957023F3FC11B358A0256CDFFDA350C9AAF1639FD),
    .INIT_5F(256'h830141192790C6E16D185FB5F1AA4B447D8ADC008548121AD34A73FCBA4D8036),
    .INIT_60(256'h4F943AF79645FE7225522409F572246E71FF4368AB40355266C722C390095C85),
    .INIT_61(256'h498F85DAC2C9B93C670C2341400714617A588287A8118689792E22BF77D03C29),
    .INIT_62(256'h5639781CE879EE4EEF7CC43213A11B4D9E3B2B20CB3BEFEF3572CD00DC34022C),
    .INIT_63(256'h1566EEE396378B4C42D52097BC3BF18937ED54135AF954125E3625F64D721B11),
    .INIT_64(256'h0F6A1D4AFF7C83E402ED86398DEEF125F53E35DA7047B8FDB2924491DE8E246D),
    .INIT_65(256'hC7D56F9F55D448892687EB55D7B409E90F0A8C50D8C5BAF8F8E686655D6A2316),
    .INIT_66(256'h2148723DF3616FBE02811348373B334B764A056112BA2230DCD7163E0D2937F9),
    .INIT_67(256'h258971D563447D3604F85A6D24A4C9491915504126F213FC945A433D3D331603),
    .INIT_68(256'h32D052E798130C95720DCE4BFD1878C3AD104912090FF1595233000EC35E6A8C),
    .INIT_69(256'hAFC8595DCB9B10840F5DAFCC8352F1C64B8EC49932FD8D4C8928F91513535104),
    .INIT_6A(256'hB340EEB6FE5F756204872C8C13208C040DF5C1F65B99D238D67FBF6269BA6EC2),
    .INIT_6B(256'hB56E97B87F7622C4E9C5AF72AF459CEEF241E3A4A6CAA919B1348D016BF30398),
    .INIT_6C(256'hE0C1EBC02587EDE873C8A5A11BEE9FE9FF5B4004AF097C5FBED58298EAFF2843),
    .INIT_6D(256'hEEFCE3EE6CF8242D68873CC9F6FA9DDDC7EDD5E49A01F9F0B086751B3786CF85),
    .INIT_6E(256'h66C1D30473B0A8AC0FED51978F86ECE26D7ACC78B993505378E83B74D3D3E47E),
    .INIT_6F(256'h4DDE5966BA44A9F2B0A0F15ADEA55FEE9FB57B789BC5897986F382F6C86CFAB7),
    .INIT_70(256'hB5EAD0ED4DD1EF467BDFB429E39EBDA4A47474D39A93F69CFFA1EBFC428F7E30),
    .INIT_71(256'hABF5BA14C5CC88287D4C8A90B7EF9F5DD0031CB7F7A408F886DB07FCE99FC32A),
    .INIT_72(256'hC9DF4B7CAEB90482B1FBE511E7A1EF9DAAC686032BE1008414C6C89A87C09BD7),
    .INIT_73(256'hFEFC2ED2DF08F1D2E7D4EA948CCBE5AA83F6FFB490FB757B2786BEA7BBC86E91),
    .INIT_74(256'h19FEAFF5349095F3F65FBD94028BB2F8071AF6E8FFDA16F4FCCFBDBCF8C0A877),
    .INIT_75(256'hA79096E1C91B795F63C3CF0258E87C0F991063FCDAC2BF3C3DC59DF090FE96F9),
    .INIT_76(256'h2E98969B6FD10DF9F8B17D9D72A4D4ABC8A4F6D803157BE3FCC033DFE634ED80),
    .INIT_77(256'hF50F0D15053AED47FF5D945E1D71B3395F20B3EEC239238F2155BBB7E0AD3560),
    .INIT_78(256'hD7527819C6D31A111002F2B69A1B0ECA69F7453E4342C8DB69308FD4CD398F05),
    .INIT_79(256'h211B754876EC33DBFAD7FB17400C14FABDAE3CF61B83233FEDDE66744C15BFE9),
    .INIT_7A(256'h2C5C4A3F65B94F2284B4CE9B16AFECD11A38061A5A13151F1B2137D85374ED8F),
    .INIT_7B(256'hDFD17CFA8339DF0CAFEB160B0DE1DA10FDBDFA161C19F1D1F661D4EE2B552DF6),
    .INIT_7C(256'h1DE573FD6EF68BCE9CFA1F1406086B20D81F299D4457FC5B7CA679501FF6CFFC),
    .INIT_7D(256'h542AF7CD6C639474FD96F691A0FFA869AD48E0D68D3C66D61F38E5CB151B7D1F),
    .INIT_7E(256'h3047BBB2A5D7BE4FF0D1B40A18F692202222EAB2A1842503F93EC2F0414E0ED9),
    .INIT_7F(256'h4328CC40320C071DEAA7D3267CF9FCC62FC8A449F8C932670BFE29FF7531E906),
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
       (.ADDRARDADDR({1'b1,addra[11:0],1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,dina[7:0]}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,dina[8]}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:8],\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 }),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:1],\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 }),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ena_0),
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
  LUT4 #(
    .INIT(16'h0002)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_i_1 
       (.I0(ena),
        .I1(addra[12]),
        .I2(addra[13]),
        .I3(addra[14]),
        .O(ena_0));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module Bias_Bram0_blk_mem_gen_prim_wrapper_init__parameterized11
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ,
    addra_12_sp_1,
    clka,
    ena,
    addra,
    dina,
    wea);
  output [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  output addra_12_sp_1;
  input clka;
  input ena;
  input [14:0]addra;
  input [8:0]dina;
  input [0:0]wea;

  wire [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  wire [14:0]addra;
  wire addra_12_sn_1;
  wire clka;
  wire [8:0]dina;
  wire ena;
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

  assign addra_12_sp_1 = addra_12_sn_1;
  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(1),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'hDD36B0B7154F244394DF98D706A4500C8858106C7A9A8F8476B4830E074454C0),
    .INITP_01(256'hD8D99358E7BAE7F4FEB4F92F007E74E1C6ABAF722EFFA97774C64F314DFE2A47),
    .INITP_02(256'h0000001000000000002C9000000200000000A0006E9EF071F342FD6B11AD3887),
    .INITP_03(256'h0D71841480088000010000001040000000012000001080140002100000080000),
    .INITP_04(256'h33B310940CA7D1F1683F08C2EF9A9D68AE348C190B58183CEF17B9B5577C45DD),
    .INITP_05(256'h6895EE29BBAA86E27AFFD774A522CD92DA8FE370793EAA5AA34593ABFFF8DF83),
    .INITP_06(256'hFCA20EFF0AB7E0CF06987D783E1DB4D18B0587F8ED3EEF620579AEC85EA4BC63),
    .INITP_07(256'hE873F20255F52C91980173692A0EBE026BB8EA92503A77F1E1E3170FA5E184F2),
    .INITP_08(256'h0000000080000000008000020088000002004000000000000001000200201000),
    .INITP_09(256'h0100000010010060004010000000000000000000000001000000200020000010),
    .INITP_0A(256'h7291C3AFD25978B78FD9B206164D2E516258588A12E8900C0200010820000408),
    .INITP_0B(256'h0B4BD428FBA31894437A446EBF345337636C5F7BA5EAB0F9242BE2D426CF526E),
    .INITP_0C(256'hB77BA254D7696EC9F4673BBFFD4A3E33C2B8E4F5174EC678E5092BB9FA4A975A),
    .INITP_0D(256'h27B8817F9CB731B607467BF99E28A7D8E1BBEED556CD7121F69DEBABEB4DBD7A),
    .INITP_0E(256'hB6EFBADF7B5BA681CA6DB8DDBEF4BD6BB398E558FF7B1F9B0C0D3A1DEB931AD0),
    .INITP_0F(256'h5DFDFFF4FFDD3FB6FFDF7EB77CFCDFDCAC71D7C26E01638A21AA152AC7A9CE8B),
    .INIT_00(256'h72C4090C11F4F5D2B8CC074421EF275B75CE52C699D91343E5EE022F1F5F2A09),
    .INIT_01(256'h4AD5D7DE4DCC8B18DE2ABBC33EE83EC5D6030F749E18EAF34A01457BFCF79E79),
    .INIT_02(256'h7BDAF1E8E929D805C74400F1B829FB87F210313AEEDCB2D2A319523180EC6A21),
    .INIT_03(256'hE7168E63F45501AF08D7BAD1F711D703206636E691131A011AC4AF0CBBEB1D4F),
    .INIT_04(256'h5A167A1C55F9EF7DBF30BE4495F2710396DE0FD90234787B0C55487992DA5F82),
    .INIT_05(256'hC65852CE47E13C52AFE00DCAECDCC1F8F85049D1CB6D071EF5D008F846DEDFFB),
    .INIT_06(256'h015B34FD44F33CE56CE203A5B6FFEEEE4550CF402CF9353E47FD4402433FC4E0),
    .INIT_07(256'hEEF375E3EFE121D33C10B7B734F1F11FB01EC8FA16244408D144F4C73BFEFBD1),
    .INIT_08(256'h26D33B4B909578DDC7DEDEEBE2BADE3B0F17F510D650C74F57EC093335DFD4BB),
    .INIT_09(256'h0EE0F0F64DE96048D5EE004D74B0FF5D77F40096CDF3B1F73670D5EE370154FD),
    .INIT_0A(256'h3C44F48EF1F5EB00C5FADBE1D5B2D6F1E63AD285EE573AE542DDD3F42DC2D8E8),
    .INIT_0B(256'hFFF78E3C51E1EB55F705D73CC93BFDE3848ECC12CEF5FCFD36F4F3C65635E033),
    .INIT_0C(256'h57BA6B22223B4C0055A3F7FAE5E0C5465CDFE5F940CD494FCCE3ED33484D3CFF),
    .INIT_0D(256'hD9C4D9E3EDCEFE34F545CFF92BD46786F5E7F0B6422434F94A29C57279EDCDDC),
    .INIT_0E(256'h98D1FE3649B1FCC6F5379CC2E54FBB19B08EFA3619C9FFD9E7EEDBFC35F03634),
    .INIT_0F(256'hFFEE64ADC91F3C27FDD19CE1C33ECCD4C8613BF86133CADA3AFF1DD7CA2F3128),
    .INIT_10(256'h1E1028D35E0130CCF210EE4C77FB5CC75402E5D7BD42D74BEB4D506300F2F5F1),
    .INIT_11(256'h9BFAD9E31231F1FC1AA0200D1C2FE425D2BDAFA9AFF55E8429E7EA59A915E5D2),
    .INIT_12(256'h1DF8CC09C872CC22F10432C3FAFACB26C5D6E7F01000014C20E9E7F50734268D),
    .INIT_13(256'hB666044E063BAF5224101014067C8118FD22D0404CB2D55DA9895C3A8C20859F),
    .INIT_14(256'h7E8E5441A892454DA00F52185687D36FAA21838D2DAE5C300127BD3EC411A61A),
    .INIT_15(256'hFB1D392634233E3D522BEA1DDEFD282DA74518EF3F688CBA0810A81389B5A226),
    .INIT_16(256'h064469B836B5B00B2DCF484D9FBF3DC43B781254517EB50E805C65301343161B),
    .INIT_17(256'h9344D5932F49358106762D4F016C444F272E35220B368E1FB16A73F7306A6A19),
    .INIT_18(256'h80510B2331033D2FE95A8D21E6068B96261EA05569678645C84079A5BF3EA483),
    .INIT_19(256'h256D48A534981439945D1C22530CEC7C956F08E437154370AE1C81183B5E3037),
    .INIT_1A(256'h647871844D7F425C44537CFD15084F39FDD3A21CA8A9079D34000BF11FE73F8F),
    .INIT_1B(256'h52054E30C26D34321739C6495A6B87F94967F4B9602F091530A55C296F2D1A0E),
    .INIT_1C(256'h02BF87DB7862DB5AC8F93B2F421D3B4E4737535E2F1C7862573E222342715D21),
    .INIT_1D(256'h48BB8A756B9000E89DDD59815A8C689CBA4C4637430365A06A9210522B422A22),
    .INIT_1E(256'hF4F21114643D7E754F7A2F4EF9374BA7E15F0F90178B267B4950453D36888D8D),
    .INIT_1F(256'h1C3B0384E1F95AC567CBF4C235BB09F2FE2D06798C62F5E5D8108785B2EA15CB),
    .INIT_20(256'h35209382FFD289F3ED908CF9F4E804A3E8D8B34DCAF978E2CDB5E1F442E28FF0),
    .INIT_21(256'h0EDDD202E882B7AF827B00F50AD486BEBCE8DBCAE993CBDAFF0440CB3EFF0F8E),
    .INIT_22(256'h74A94FA3D7F40DCC9803BCE8F010BD1E04A862D1A28DFE03BF93F7B3FDF3199C),
    .INIT_23(256'h0B904837DEB1B4BA1499E7C701E59A853E037D76DCF0D68A69AA7CBAE516BAF9),
    .INIT_24(256'hB2E2E71AD1F9FB607E916DE1DC02DEFAE56EE3CCB7C19F7573EF20514303E707),
    .INIT_25(256'h668DF074DA0F02A29980FBFB8BF1D1795D900301F2AA4D843EA89E950288B06F),
    .INIT_26(256'h03A396350F6A75B9DCA9BBA893EFB2E3D66283E5AFD5002BD8EBDEF58C05804D),
    .INIT_27(256'hC303A9C84F013EFEE971FF94478AAED28BC48B5E7B9704A2E61204F6DFBD8104),
    .INIT_28(256'hCABBA0EFFFB6F925F4FED371A00298839BCD03FFCFF9F767EE1E9503DA8B92F6),
    .INIT_29(256'h7330B99F0CAFD0F2191597D945980B77357C8E988D52BB0D111FC295907ED1A7),
    .INIT_2A(256'h4C35EBD4F177C0718524E3DFF3FF6633B01DACB6F607DDA97CE867F48A5D7BA2),
    .INIT_2B(256'hCFCB29F6E60FDA2CD11D0287C6ADEFBFB8CBFC1C001BFB8E15EAF5D3062D8010),
    .INIT_2C(256'hC527852104EB41AD6E0FDB4F2439FB65E8B42D4789EC079ECC3A16D01D13D628),
    .INIT_2D(256'h34BCE297CF4ED00EEAABE2FBB2CC92F6F5C23BF115F0FA9943E7E6DA14A5143A),
    .INIT_2E(256'hE92CE4EDAF008CD4ED2BFB569D05E63FE31B194643F4F860E4C9CA152235E86F),
    .INIT_2F(256'h17E4B44FE05F391DE41E28991DF73377F566D801F2ECBC070723C47EFC6284D6),
    .INIT_30(256'h2FF96ED0B6EBF22AD001D62F04FD2751CE49C3EBDCF73B8E2CB8DF107007F7C6),
    .INIT_31(256'h416A7E3B28FA94FB67DAECDDB35E32D0F56FFE3FD4ECCD45B0D4070BAC035D30),
    .INIT_32(256'hD4EAF641F0A11EDE4937CEDCE8E1FC15E0F7C918FDCCAEA600C246542951E332),
    .INIT_33(256'hB9010E47F109B6E14E1933281CD554D1F7495F1E6CC0F4FBD6E5AEEFEE1D7514),
    .INIT_34(256'h7F98D4F5EDD6E31423132ACBF0F504ECD911EDC30D871D4BDAF234F8323C23DF),
    .INIT_35(256'h0A57512906DFE702EA0203FE9F1336081ECBE9F9EFD15DEE20DFEDF2DD3B4200),
    .INIT_36(256'h6A61720CE043E962E16FFAEE2ED6CFE5E6F5FA4E253C093CFFF9246BF7DCD7DF),
    .INIT_37(256'hE7DAF9B0D3D25157A71FFE531416D43B012B740ACEEBFF55E1CDD7D8D2EDE1F4),
    .INIT_38(256'hDA65F11616E246DDF1DDD13D0A2470D4EA0D331A0DB70611EACAEFEB330BCC34),
    .INIT_39(256'hF0EFD30A5B2478E5C7DA870F4D61F0FB19323ED952FAB5E7410B0754C3F1F3F9),
    .INIT_3A(256'h21F96EFC6F242B430003E1CFBC04DA232FC7B1CC7FD4FAC4C4FDEDDC267A2BD1),
    .INIT_3B(256'h1BA0D012C101D1E9E0AACAD1E52A2025EFBEEE99CE19CE3DB90039D20545F45F),
    .INIT_3C(256'h3D14DD68FA0ECA0415182F56C9D1D692B74BF4FCD2E3A808405182070D49EE58),
    .INIT_3D(256'hE02153CBFD7124AA1C23000C130115BE5EE788DF4456F4C929F3C900DE4366E1),
    .INIT_3E(256'h38C474D748F061CCE0C5EFC85BEE3CF53235D966BCE0113BFF0722EC243736C7),
    .INIT_3F(256'hC0F5E61FBA001D3111D1DFD70F2A77F7F0E6E7C8145DE2A70D4F0F0B811CE605),
    .INIT_40(256'hC2423EBF45BB2B3EA547F5EA9488CE8168BA12DA435E525379B5592BC16017EF),
    .INIT_41(256'h4F2F706C5480CA673BC4CD7083322EDB064F6EBC58646C42A28A516642B9544A),
    .INIT_42(256'h6C4B56B3747673CB5C5128E0BDBC58969B703E729CE7A4BCBF795819B324485B),
    .INIT_43(256'h5AB1F6507793625CFB7774476D684BBD010FBF6A61624C7C705ABCBF32767AC3),
    .INIT_44(256'h3F54257F0777C24BD1D45E70F16245CA117CB3C85F2A595DBB6D65EB3BB4249A),
    .INIT_45(256'h12192BDC33BA7AD0D0BDD57365BB4671B8DB86CFB66BA7538B3D751376C5017F),
    .INIT_46(256'h2FF7B26029B36CCA6AB4BFCF78629E25542D6CB8B94F6965B592F15A78717443),
    .INIT_47(256'hC29AEC08C14E576A53C46C695ED3C978804D2AB675D384745A5C4F47996F69BE),
    .INIT_48(256'h5D7A08BF2A56397A37F6334CBFC361B53AB9BB6FB9B4C4631D7387085D5A12D4),
    .INIT_49(256'h736F7257B62ED87A5D706D8FB50574D66A6D1BC36C2130383ADD559E8F18776D),
    .INIT_4A(256'h2DF51148D030647477B53D77B5F46C5DBC6FC3C05554B3FA415D203F097B665A),
    .INIT_4B(256'h731C6FBA6DBD5151B57738B65C6E73BDC26970C17CBF12BD61BA2C8950C0AA15),
    .INIT_4C(256'hC54A6F17A339066C6327354C4ED9277ACE612D62FD2E6EF95CB7B498C3F39C75),
    .INIT_4D(256'hB6BDC2C44791B47761B046C357BBC457B5445A2F4CD633BF4802734BC6CF81D4),
    .INIT_4E(256'hD0C0CABABD9BF3C270C138DC4F30B6CC327121BD63B74AB5CAD8222B7365CAAB),
    .INIT_4F(256'hB8CA276BBA6290C26C99BC7BC24CB466F76943AD944F1D46C2C748C5BA77593F),
    .INIT_50(256'hD98F355AAB3F6F333E14D639D57D6F757715619435FD72CBC17472A9E96EC86B),
    .INIT_51(256'h735930C768BDE1D13573821C67C6497A702FBE57664C3D286141776473D4E475),
    .INIT_52(256'h019E33E22E2A900780FFEEA3FF0D0D66C45C34F1AD2E31298023144EE8B70142),
    .INIT_53(256'h58D7998E2823F17ABDF30877F7386F2F11CA03E1890B020BEF2D6879F16FDA1C),
    .INIT_54(256'h92A212B516BD9B042EEA0684E6BB3BDA410ED756FAF86E243DD935EA202737F3),
    .INIT_55(256'hEE261D03F9F0F8DED8D81FEAE21134EDD611EADF4812DB5F1027230712E2DF56),
    .INIT_56(256'hD7D60AF80802E82A18D60FF5DF0D08DA12F6D8C3E00F3822F303DDE30CF5FEFE),
    .INIT_57(256'h18D1E5F6160BE913F11E1DF23F0A44DCD3F02B4C2300FCF2E901E53EEEF4DBD8),
    .INIT_58(256'h1407C64508F3EA10E3E7181EE5F2E6EF00E30FEE072DE03409D8EE31EAFBF32A),
    .INIT_59(256'h0921D4101CE00C122707E81CF30DAEFFDFC7EF1B030DEF0AECF04EF627D91E1B),
    .INIT_5A(256'hFA31F6361EE920F5FBF4DB0AE105FF01C711F6E604430728FBD8F7FBFB0B28FC),
    .INIT_5B(256'h13FEFE012C23D5F20DD9E508E6E40A0717F422DE60FBE5F133FDDAE9F80BEEB9),
    .INIT_5C(256'hE909DBEEFCD7F4F41622F2E71CDE010D4FD92AF01D20F8D4240DFEC40EEDDAFA),
    .INIT_5D(256'h3DBC16461609F4FA24E8F9E6EF15F52500FF01192CF228250AF4D60BDFEDB80A),
    .INIT_5E(256'hE7FDD5E8F707F8E8CE15EA230601E3EC061610FAEB042610C71816E12AF2430B),
    .INIT_5F(256'h040C1F1EEC0FECFA0CE62D18DE0BF8F4F9FF17C809F33124160CEF01E30C1E1F),
    .INIT_60(256'hE9E6F0F5E606E31D23F81527F031D504EA1D44F601E7F2DA0BEB35EFFA12F904),
    .INIT_61(256'hDAF8EE2D26F51AF82B021128F23503F81B1DFB34E713EDFCCA24FCE1DF2D20F4),
    .INIT_62(256'h0F1B09F11AF5F9FF1FCB0401EDF1F803F3F4081D35F5CF020CF4E7DAE9270327),
    .INIT_63(256'hEAF30B051642E504F71FE6CEE2014901E5E5CC150EED0D0BD7C9F2EE38DF01BD),
    .INIT_64(256'hEDF2F8F6E7FC0EE110F20821FC0FFC142813B7F8FEC0E6180307F6F5620BF5D3),
    .INIT_65(256'hF5C5F0E100F20D120CFACC0B0CE1F7D4172BEFEAF913E6ECFF00D0F9DEF6E7CE),
    .INIT_66(256'hD0EF24EE0FFCBAD82EDDC40BE63106CA03FCEF0BF3F7F612FFF63127F3010CF9),
    .INIT_67(256'hE865D8F94FF9FDD912E8F6B4EB46DE98CC4BA13E3D5CD4FB47EF59954DCE32DB),
    .INIT_68(256'hEBD6A13E9A45BB7C2FF2462C988E35EBA61EF5F4BAC67AD448CEEFDAE748CF25),
    .INIT_69(256'hEAFBDAD338BCEC49C85752FBE881B1B6E9FFE09FD54AFDC5E00CCA8AAA18C2CB),
    .INIT_6A(256'h6AB941705CFFCA10F2C44858D9CF00C84AD0FFCB426C6DFF423FBE4F51486456),
    .INIT_6B(256'h7072EA4156183CF2EF45DFE6CA31ACC0BFF9CD5EF830CE43A5E158FB51F24FDF),
    .INIT_6C(256'hEB7B4FA6F6F168483B32C73BDC514C44C040C84549D1E4F3B1E945B7B31B6250),
    .INIT_6D(256'h064B104969E7E3B441CE45494DDFF7015AB2E3C0C247CFD85CACEBB1B64229DD),
    .INIT_6E(256'hE71B43DDE4CF4449AF59ECCB4390E8B07B01F3FC53474BECED4FCCC24DDA9749),
    .INIT_6F(256'h804AED7F57B9F8FFE82CB4CCCA496114A74535495C7A55D346D6F7FBE4C2D2AA),
    .INIT_70(256'hC2A0CC3FE740E7FBB74B2CF63E63EEB26E5354ABF652E157A4DA5CD9665783F0),
    .INIT_71(256'h264C504DE1FC3C6444183324C2D645AD4844C4C1E2681E486E4B01B3EAFB4FEA),
    .INIT_72(256'hE1B4C0DBD1C5E17F55AFEBAFCD2AF6EC3B6545E1C7C8B1ECDF487AC89A2496D6),
    .INIT_73(256'hD848DDE75C27CDEFDA421CFABF40423CCEA5EC9843F641EF28BF4AFFC66B3A44),
    .INIT_74(256'hE659EFE1F5AABF49F2FEF27547E33901CC3E6FF0D08A209C45E0D846D85CC053),
    .INIT_75(256'hFDE24C5954A7EB4561F3EC1CC1FEDBB8E652DFE5FE284E47FFE54FC4ED7E41C4),
    .INIT_76(256'h4FB7BE7FA753B6FF1FBD44B5BB45EAEDD16CC34644DAC028F6314F57813545EC),
    .INIT_77(256'hB262ECD540ECD347E6FEF144FDD5BEEBAB58B9DCCB4AC061F5FC0FCAC59CE3FF),
    .INIT_78(256'hE8C46E3F4DF1F0EBFB44D03CE9144BE7FDB04750E893D060AD4B1E68E24FEFFB),
    .INIT_79(256'h0C20E31E61380DB0DF0C931EAA0CED671C0C2BF490F01BF74E17FF28E13CFC0B),
    .INIT_7A(256'h4BE3FD74D482E10A03230F0C3B1469D31AF1EE1A160DDBFD9F110E0AD417CA62),
    .INIT_7B(256'hF642E262F19301190472DEFF871E34CBF3EB4DB928E5EEBDEBC8370E2308BA13),
    .INIT_7C(256'h19F8B9D3F9AD4E11D3F3B1E694AA094797D302B6F789AAB4ABBD13C2C16B0037),
    .INIT_7D(256'hF2C5C9B9B4BDD9B9BDE50EE3CAD08FAE10A9B7F3C3B8AC4CF106D5F209C589CB),
    .INIT_7E(256'hBBEAA4B0A3B9FEDAB4DB2BBB8DAE3ACB231DE9DCB6ACFACA9B01EDE215C1E537),
    .INIT_7F(256'h16A309D3F38866C59BA6C5D3ACE827C390AE8AA18FB6AFAD509A8AC14DC15E38),
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
       (.ADDRARDADDR({1'b1,addra[11:0],1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,dina[7:0]}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,dina[8]}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:8],\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 }),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:1],\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 }),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(addra_12_sn_1),
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
  LUT4 #(
    .INIT(16'h0008)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_i_1__0 
       (.I0(addra[12]),
        .I1(ena),
        .I2(addra[13]),
        .I3(addra[14]),
        .O(addra_12_sn_1));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module Bias_Bram0_blk_mem_gen_prim_wrapper_init__parameterized12
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ,
    addra_13_sp_1,
    clka,
    ena,
    addra,
    dina,
    wea);
  output [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  output addra_13_sp_1;
  input clka;
  input ena;
  input [14:0]addra;
  input [8:0]dina;
  input [0:0]wea;

  wire [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  wire [14:0]addra;
  wire addra_13_sn_1;
  wire clka;
  wire [8:0]dina;
  wire ena;
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

  assign addra_13_sp_1 = addra_13_sn_1;
  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(1),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'hFF7BE83E3FB79BFB7BEF9177EEEFB6D571BF37DDEF4EDF193ECBAF37FF56BF3D),
    .INITP_01(256'h014C4022048010C45D37FFF5D7FFFFFAEFCFFFEED7DC8C67D83ADF7EBB9BDEFF),
    .INITP_02(256'h50220044A008220C200830004A0610000CD0084108504A040C00F2900D085000),
    .INITP_03(256'h00020080C480601015442802940804410003528ABE8602304400000802112020),
    .INITP_04(256'hD521BB61381DCF252560184B5F4055003A1C22E83A8109088880704904C9BED4),
    .INITP_05(256'h1F2DAAA7DF60BC942370461A46B1B4804AC7C2FA465EA3A311B293210DE522C6),
    .INITP_06(256'hA7A20575246846F6A5D28C3A086B0A8126191B5C700065D8F63ACD5D0FE61615),
    .INITP_07(256'hF99E100C4480010E8B04C200609F5E88E12C26E782BF09593630A568C0802BB0),
    .INITP_08(256'h42E4E3EB66371EFFF1E1CE245ED19E19E094D85303976502F07965908D23DF9B),
    .INITP_09(256'hB2BF77CF2BF612B834933ECCB6CB29C0ED6F153EA70BBF2C0F96E261C783BA07),
    .INITP_0A(256'hBB7FA481FED13375A3662C9D045D7EB6056EF0DD9383A2F3EEAEE2C655816A8C),
    .INITP_0B(256'hB4EAC5310FBEB959C04D551C589572DFC18F1F16FF1F3724D9CE6A7BA79E364E),
    .INITP_0C(256'h00000080000000008A514971112022B59205AE0FB1D4416EBD74F2A3DC8D2A45),
    .INITP_0D(256'h0A0210100000000000000000044000004000000000000000080000020000C208),
    .INITP_0E(256'h00011C000088000010000000000000000000081002000000020A000000280AA0),
    .INITP_0F(256'h40020000000002140080004000820004010000000000092000C0004060008000),
    .INIT_00(256'hA8F5E3CC96C3AE940DCB0EC9428DC90BD12ACAD1E495E0B44846C88DCED203BC),
    .INIT_01(256'h2D28E6E0C5E9B120D4D02231C704FCCED90AC207B9F5A9E95006C0A333C7C7BD),
    .INIT_02(256'h90BBF83D95E6A2CA38C5451BA3D0ED00DBD710ABC4D6A4C7115135F9D2022BC3),
    .INIT_03(256'h3A9DC9A2152C03EBA722D3E1BBB7B2B4023DD48422F788F2C4B003C3A9B731BE),
    .INIT_04(256'hCEDEBA01AEC3A116F4CDCF0BC9E9D184B70C94BB5174B768AEF21FC039CD1A98),
    .INIT_05(256'h1B9DAF71FE06FDABFCB09506D2A1B5EEFC2C3AB02E3549E21CBCE1C112D2C6FB),
    .INIT_06(256'h1000F0C6F3EBD0BFCA03B2F515C2D8A4AE301FA2930DBACAB8D5B7B8F606D7AD),
    .INIT_07(256'hB0BD63C3BCA2B9EE32DBC1AF8B4DCCBBF1B8CD0EC21618041509F8B2F1D9C531),
    .INIT_08(256'hC51AB0F1EC07BDCED0001076B282D6B0D3B100CEC2B0D600CCBEC5D3AFBA9DB1),
    .INIT_09(256'hF2BB34F69B1854294441A7C6F22BAE15F6B110B08AA4B4A97AC5F6EAB9CAC539),
    .INIT_0A(256'hC8EA01990EE9FEBCD2B111FEC1E00C52C508360FFCC0044D36EAC30920BFB6D5),
    .INIT_0B(256'hB2FEA380FBE5D1D18E9C0411E892BFEDE0FBC1D6BDA7A2F5ACD5B44AF3F2C90F),
    .INIT_0C(256'hEC9F08C312A7D5A2C8AEF4DCF19FFFE9FCB9DFC199FAB9C0CAB6FF9CF801BC4B),
    .INIT_0D(256'h29AE5DCFA8E609C22E41ABF627C0A9C2F9F4B9FBFBBCF0FDD3CDAEB04DCB34F1),
    .INIT_0E(256'h64A6040172FFC390FB5606AD03029592020293F25A050604F7FF570004F95A79),
    .INIT_0F(256'h890103020203AEFC02FF6895F9F4050473FF034F010201A16284FF927A03F804),
    .INIT_10(256'h02550505EFFF97FC03AB6301F602750059AF80FF02037403068EA90253008069),
    .INIT_11(256'h8A037D00FACD6E040605020403935F01D2FEEAFD0303F504F70103F072039A68),
    .INIT_12(256'h055C5F05FD0404036AF851F79003036F03F90103FE04F604A582010304F87B05),
    .INIT_13(256'h594B9B08FFEE004FFEF6627D63A7860201710354D66506AD6FF90602540303FF),
    .INIT_14(256'h02F97A6DCBA5EE0306027C4F03F4FB52005375E9060204045C7A668F024D5600),
    .INIT_15(256'h8D00F7076B6E798200577B03F50304026982FFEF7B6F059B01064D0305036604),
    .INIT_16(256'hFF71FF7F0400046080020268FF7E03070354F902AA04F69103A65804D3FF6604),
    .INIT_17(256'h6CF701D76D668C019902EE8C0306F301906068086C65830250FE7B0564FF055A),
    .INIT_18(256'h53579802937BFD00005105FF540100FD03429E07035702070405F8027B610201),
    .INIT_19(256'h02FF050401F6046F5F02060200BE03038204015705584C55616C8B02FF03065F),
    .INIT_1A(256'hFF52FDFCF3FFFF05F2794D0301AFFD0104067E060102FF510203FFFF07020401),
    .INIT_1B(256'hAD01768602577181837604046360FFF082FF65FA0505F104FA006701FF01FF73),
    .INIT_1C(256'hFF9B5EFB85CA5504B906524FFF8154C20673646A92FF639FAAFF00626D0103FE),
    .INIT_1D(256'h038F0475C4F503FF01FF5E6259FE00949F9AFE02F30206870394010470A0FF65),
    .INIT_1E(256'hFEFB4D0559CD0202EF06620557037A8165FFFE06046B0205A9055BEC58720289),
    .INIT_1F(256'h62048A0102987D03597302786900F006907C04A74C019367FD010009A601629F),
    .INIT_20(256'h150C3FA621E8191DDCFD0422CA3048F2F60DF0FCF6C3D107DFF440FC0BF7151D),
    .INIT_21(256'hFD325218FA0A1B3AFA4028191E2F2C1552EFE9FD45262E0F1EDE070EF12A2BF9),
    .INIT_22(256'h2808FBE5E23EF53DF62A131701180CFF230A001DE42821BA2F3D270ADC023335),
    .INIT_23(256'h010AEDE5FC22E50C155A39F8F9E20C30111BC71A354FFA3BEFFCFA2FFB0A0C14),
    .INIT_24(256'h2AF814CCCAB0E1CE17F755382218172053F200F514FF11F3063F3A250530210D),
    .INIT_25(256'h0B28EA323DD810D32EE7E72401183417211412EAD746071A8EFC1826E537E3F0),
    .INIT_26(256'h1216EDE4DD021643051D09E7F9F72AF9F1F21C10E7D6EDF51145F7020BFA1FFF),
    .INIT_27(256'hE0FC25EF0DFE33DE050CD40C111E14EDE111D1E1E20AE1FF0DF7F3131C351AF8),
    .INIT_28(256'h20200E16F5E211F4F1FFF60425E22AEA1C0ACF210D07E646FBE0170E05E3E011),
    .INIT_29(256'h150118FE190629C0FA21F2FB0C23E80BF02B21C61216DAE31127EB27113807D9),
    .INIT_2A(256'h0DDD19350BBEFF3420F61FE8FBF8F40DEC21FC291604F5F9F401FC0D0611D0F6),
    .INIT_2B(256'h00F13C06EA23FB30F6F621024CDDD9FAEFE228220D00FB4BD9E6DBF5ED20F426),
    .INIT_2C(256'h16EE004608E8E80DF233F3D52C1C12F5ED38B4E528DB1922F515022400070A26),
    .INIT_2D(256'h230BDD180513EDDC09F8D7EC2C0B2F2110F0060E08F1F410350D1AF8DF1CEC1B),
    .INIT_2E(256'hDEDF2AF0E6EDF0EC1EDDF403121A201DE539D6F7EFF61B27FC1606E733FA1604),
    .INIT_2F(256'h3A0A27FBEFFCEEFB0325F41FDFF40AE9FD1EE032E108E908EF23EE122DE7D3E9),
    .INIT_30(256'h0B020521DFEBDEFADCDBBF122BFBDE3820331FE713C4E216364A14F328AB1AF2),
    .INIT_31(256'hEAFDDEFC0DFDEF02122BFDF1F714E22AEAE7321AFED70DEB2DF301F5CADF15DA),
    .INIT_32(256'h42E4FAD5000A0030010E2A1426181D0A2AFEF0200FF820FFEAF706F2EC0A361B),
    .INIT_33(256'h2330DC3710FDEA3D371B01F5F62E33D1030227FDFF16E3FF29FC18FBDFF60C24),
    .INIT_34(256'h32011212EF19331319E1EF0BF706D2F115061619E22CFA17EF2523271D0F21D4),
    .INIT_35(256'hFE00F80712EB01ECF3EE13FE0605EA2DDF281B2DFEFD30210D24F2DAF205DE1A),
    .INIT_36(256'h0526F70716FD1C1409E1D715EA0E100A2BF5130F02EACD10F8FCE9FB09DAF744),
    .INIT_37(256'hF80ECC3330DFEFEDFC05DB010803ED05240320171FEE06F915FAFBE51CDD01E0),
    .INIT_38(256'hFEEE122B291F011BF20D0416293515200413F418F62BE7E1FA12DCE245111118),
    .INIT_39(256'h150FEBF206FDE2220D1CFDEC07272112F329E9061FF435F20CFEEC0EE70E0F17),
    .INIT_3A(256'hEC100C222815EB22E92DCAEBE0DFECC8172D2B1BF7120CF11AE125FEDC0216D9),
    .INIT_3B(256'hF4F3FA11152122D81905E810D1CE19290B34F91E1AF3F10AEDD8CD0E2DFBE3AC),
    .INIT_3C(256'h16DDED0822181F13E70C35DCD2ECE6EB16F112F6F5FFF81FFF031610EC221B13),
    .INIT_3D(256'hFA18370FFD23F7EC101F2E002DE32906F9D9092E1C1AF62C0C290F0120211C17),
    .INIT_3E(256'h18FD1A0614F0111CE10915270415261E1D0503021A3A16CE192C2A23DFFBFF29),
    .INIT_3F(256'hE4E6E7F4FE2100EFC30E0FECF0E7E50606093EF6411D01370B070E1BF0E93346),
    .INIT_40(256'hED000114E0DB12D8020EDE2B1B14E5EFE8F21CC7DBE7E8ECE6170BEAE513F3E1),
    .INIT_41(256'hD6FBEBF90639173B19FFEFC2F20F01F318D4F1262AF917EDFC260EF70707090C),
    .INIT_42(256'h002633070F0BE9FBE41C03FB27F0C2E231E5E81718F111FF00161B2F271BFE05),
    .INIT_43(256'hF8FCE57379354F1DF94406F53CFC5E4DFAF749DADC9C46535FB94B884236D4CF),
    .INIT_44(256'h01FF37D3EDFFFBB9FBF625BC44435D9DBF0251E7FFF3C63E00BF3AFBEF3852EB),
    .INIT_45(256'hE4F0F98C464220F5FFFFF63E4B5842F9BCF5113ECFFAE01A072AFF434DF93A3D),
    .INIT_46(256'h59FCFA0037EBF33B3660F5FA51D3FFDD533D54EAF2FECFA0CCECFFFFF7EBDDFB),
    .INIT_47(256'h06F501005047FD00F3CFF23B43FE244ADEFDF80A4C49D9EFF8F68C04FE5586E8),
    .INIT_48(256'hFEFD520F09E7F8CBFC415602463ADDB8D720EFFCF602C900393E3A4B3EF9EAF6),
    .INIT_49(256'h3E364B42FBFAFDFFC50102F2C6D0F22BC9E6EF03283ABFB109DDDF39415351EF),
    .INIT_4A(256'hD807FB8E4FE7E6F854523C04FA4FE6ECBE30DECDF8EEFAE23F50EE55F9D74701),
    .INIT_4B(256'hFD9DE64FFBB842E71185E444FDFDF3F33E4643E143B749EB0344FBCBF2FEC046),
    .INIT_4C(256'hF43BF3D93FF5BC56FDE92B3BF248FDFD3184DA3FBD4055FAAEF93F0236414245),
    .INIT_4D(256'h7440FDF706DE3C23FF0121C8424878EF4441D1F6D6F5E91AC6FD0A42FAEB1217),
    .INIT_4E(256'h4106F806E83BFBFAF6C2F6E557F8CD294B7A03EF432AE84BF8CEDDF8B6013F78),
    .INIT_4F(256'hF041E4CE4644DC3EFD69AAF7FDFBD5ED01F0EFEC00F4EFD1FBAB3849D6C9FED2),
    .INIT_50(256'hB1EE494136FA12F9FA44564B5F5100F34EFADD07FF3DFE40F23E472EFEFF4704),
    .INIT_51(256'hF7D8EF76FFBFBD9AEB07EF3EC8F7FB10FFFFF1434847EE40F3FF000A3DF8B85E),
    .INIT_52(256'hFE2003D44652F5ECFE0B13483D02F3D9A105EA104F00B749D0EEF6ED4F40FFEF),
    .INIT_53(256'h3F47023E0DD93AFF3EE1FF40F3F8CE5DF3FDF6F32B8F7523F0FE40FFFFFA19F5),
    .INIT_54(256'h4A093C3F4BDB000045CF01FDC8F03DFD6BE3E8FCFACAF90FEC39E2BE02C0D57E),
    .INIT_55(256'hFE3FCA00003EF8F90CF5EE403FFFFD3E5743F248FAFC4055F83E02E6E4F83ED6),
    .INIT_56(256'hFAC9F0E5FAFFF549CAF13FF064744DF93D43E5FA2B4FF9CF3DF3EED289F14BF1),
    .INIT_57(256'hFA48D1ABEE3AD4FD24ECD8F8FDF0FBFAD400FC4463C77141FD036E063E4708FD),
    .INIT_58(256'hDE42FB015DDCCCF2B47B1ADCEBDAF9234780F8FD09F5EF574DE90441F2F4F910),
    .INIT_59(256'hB2DB3EFFD90051E4FEE5384FFAEEF9683FF6D10DF63EFF1949B7F3FEF93FE6DC),
    .INIT_5A(256'hFEBCEBE7F9FBF8FD014176DFEDDFE29E2A01F6FA41FFCFEC0D46BD0372F35B40),
    .INIT_5B(256'hFAF773440A633C99E9500144F8B9F2A73B0147F4FEF7E2F9435347FB21F8F84B),
    .INIT_5C(256'h46FD51FFFB164956DF3E0A7745DB66F558F5FFE9007D6E0CF7F550F4DAF2FDF2),
    .INIT_5D(256'hCCF109393A00003D15FF3D3CF1E314E93FF837FF78FE43E9444055FBB7C85EB8),
    .INIT_5E(256'h3D4E0A56E1FFFFEDFF4CF2FBFBFFBC3B9439FAFBD03E22E06DE047FFD1053BF4),
    .INIT_5F(256'hE53DF3FA40FE4A6ACAD0DB01BE006164FAC63D5E5CF952CC3C04F1FD41424090),
    .INIT_60(256'hFCF969DAF3FD3D02D52C5845E5AD01B37A00DA4CF701F83E37F06C1053ED3DFE),
    .INIT_61(256'hD11FF4ECF0F20FF902A6E6F807F20901D9FCBCF61E29E500C218F11A1212F6EC),
    .INIT_62(256'hF811F8E709040DCACEDD2EC816FD171700E91D240C1711FB09EDFC16C7C1F023),
    .INIT_63(256'hFC040ACE1628DD22041405061AF80CE1F853DF3ADDECCF101A122D09CDFCFFEA),
    .INIT_64(256'h250604F8040B41E8010BE5220C1C0C240E09EE27020BE415DE19EFBF14D404F7),
    .INIT_65(256'hF60D182CE616DC0F2FFA09EE191720EB0BDA1802DD0604FE16FEEDF901060BF4),
    .INIT_66(256'h12177A1C6F6D32492622514444383B82354C23364A0F1A88172F230027361C13),
    .INIT_67(256'h133420080B8333515A0202141C43172B4A3D041005174E0FFB4B142C08600958),
    .INIT_68(256'h11543F22575A52450F011E4F08270C1DFAF00B0B1914EE3563403357F50F4C07),
    .INIT_69(256'h69431129FA02273A09223C4B28821D0E4710283E2A62383A142F0A49100BFD11),
    .INIT_6A(256'h30033A2B26181B0C0B1A6E726D8726375041180D114C23192536307C2B5F7C02),
    .INIT_6B(256'h27FC1C149F20463657331222212B5533100E20163C2B0F1E160740013D5C1E40),
    .INIT_6C(256'h40716A0502E4043A4EFD6B3E1C2A251904072457270813054B3A3F533A502C4D),
    .INIT_6D(256'h5C51361E494E32424504117B766525161B32061F5155333D1715156F140D4423),
    .INIT_6E(256'h344252492311242D00061522560814361F2E2B29443A3168580709207586230D),
    .INIT_6F(256'h072E4321F045F90C800C1154613BEE3C585827FF8F4D5249671E0CFD7D0F6521),
    .INIT_70(256'h141847190D4C441B1C12FF1EFB37263421174F13E915FB2CDF3EFA6223476460),
    .INIT_71(256'h370128231C1DF96521280A3EE941FE2D145F26831A44092C183A167B24254111),
    .INIT_72(256'h23016A7B0343FE0E1D8A2A191680232C445A562213071B1E0A11124D2D4C623A),
    .INIT_73(256'h0B2C112C51191A5770174263280F53267E380B58FD01461A182251FE450A5143),
    .INIT_74(256'h3D3C30352E31166A35346F26441A2E0B0E800E3F12071C1B413127104B470312),
    .INIT_75(256'h314A51FC28291A141D524F21322A2F3F19160910421716603024615023214419),
    .INIT_76(256'h273A08641431252EE6382B5EF1433D0611252F1D5227253B0D25632C1150357E),
    .INIT_77(256'h211C4E1D14605A0140032D4C112D0FFC3E063AF2FFEE0942301139620E415F29),
    .INIT_78(256'h4AF3DB4D03462520840D5E581052152AFF335D2962261A001260232B30530E19),
    .INIT_79(256'h201C360A03451701F5FF214A4B3A1843101703482D311C4406ED1C533745721C),
    .INIT_7A(256'h3264391B1F1C1B4A0F2A702E1D0D7D5519380B37F74626FE263DFB5857160A6F),
    .INIT_7B(256'h33440637170E6CF83B0A5A8366090E185E1D5A363C37541829223F046F154632),
    .INIT_7C(256'h3110142514261630F0395B2B5124ED440A24375B6F1870602D3C313216FA0415),
    .INIT_7D(256'h7B244342762F0F37FB17536D04164D31312E01371737506009EC352A431E0E15),
    .INIT_7E(256'h42220B083A421737441D3D525709123C643333761A58EE0F260419E250FD3A80),
    .INIT_7F(256'h41FF07123F602E0C10604C563148F3200B1B3B1A1A1D6923300B871A27184B21),
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
       (.ADDRARDADDR({1'b1,addra[11:0],1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,dina[7:0]}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,dina[8]}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:8],\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 }),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:1],\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 }),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(addra_13_sn_1),
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
  LUT4 #(
    .INIT(16'h0008)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_i_1__1 
       (.I0(addra[13]),
        .I1(ena),
        .I2(addra[12]),
        .I3(addra[14]),
        .O(addra_13_sn_1));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module Bias_Bram0_blk_mem_gen_prim_wrapper_init__parameterized13
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ,
    clka,
    ram_ena,
    ena,
    addra,
    dina,
    wea);
  output [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  input clka;
  input ram_ena;
  input ena;
  input [11:0]addra;
  input [8:0]dina;
  input [0:0]wea;

  wire [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  wire [11:0]addra;
  wire clka;
  wire [8:0]dina;
  wire ena;
  wire ram_ena;
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
    .INITP_00(256'hBEF3702F92EFF68FF9D27DFFD3E4B0F700010000000810040000008000008002),
    .INITP_01(256'h7AEF8AB5F9F8DFE49F7652752EF602731A61E3A93E4FFF685039D2D2C7E23B69),
    .INITP_02(256'hFFD7F8F1697BE7EBFC9BD75BEAE8B2DA3194B689CB1F8FBBEC476EFCEB983FF1),
    .INITP_03(256'hF989BFF93D52F3937DA3DF59FD274BF672ECEBD7EFE3E14D65476DB69CDCFDFE),
    .INITP_04(256'hFE7FFBFCBD881220C8716B12D7A8417A734B41B2694B6373BED7A9BCEFFF9757),
    .INITP_05(256'hFE7FFB7FFBFFFDF3EEFFFBFFFFFCBFFFF7FFDFFFFDFF5AFF3F7E7FDFFDFF5FBE),
    .INITP_06(256'hBFFBE7BFC75CDDFBFFFD9F7DAE6FDFDF7BACFF7E7DE97FFBFDDFDBFDFFFBFAEF),
    .INITP_07(256'hFFFD6FDDFFFFFEFF5FBDFDEF7F7F7F5F9EFDEFFDFF46FE7FFFBEFFFFFFFB3EB9),
    .INITP_08(256'h000000000000000000000000FAFEDDF3FCB57AFDEFF1B9B7DFFAFBFB7FDF6533),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000020000000000000000040000),
    .INITP_0B(256'h0000000000000000040000000000000000000000000000000000000000000000),
    .INITP_0C(256'h9E13A3D12C48D30536B73688A334C26CC5A4D088000000000000000000000000),
    .INITP_0D(256'hFFFFFFFFBFFFFFFFFFFFFFFFAF85DED1F169A0549FFFC881F98A2ACB71FAB287),
    .INITP_0E(256'hFFFFFFFFFFFFFFFFFFFFFDFFFFFFFFFFFFFFF7FEFFFFFFFF7FFDFFFF7FFFFFFF),
    .INITP_0F(256'hFFFE7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFFEFFFFF),
    .INIT_00(256'h2931400F0F1609174504793177523136FB1B103062373A1A0A44305C7B2FFC27),
    .INIT_01(256'h05490911132B3764503E244112292D115C4A64231D11060FE92F272726263651),
    .INIT_02(256'h161850580E18270F071B030AFF5D1E3A044377E52703324F1D1E557036EB2323),
    .INIT_03(256'h193B280B190B234A041F3217460B41F513554C361E24584640210A4C24302436),
    .INIT_04(256'hBFBB009B5F26D0F5CB9FC21015BA0D96D51F88D2193E126DB88DABB10BC28FB6),
    .INIT_05(256'hAD84C5B2C28214C9CCB116B40916B80B089EB0B897C32BADFDCDAE6B3DC4A2C9),
    .INIT_06(256'h5A2E1A82312ABF22B6979224B99DB0CFBDC4CFBF0B9BBA0FD01F0E30D2ADC0C2),
    .INIT_07(256'hD318A9DB96E9CC0ABAA7E7CF40AAA9B11EC685C80D3016153912C324C0ADD4B7),
    .INIT_08(256'hB3AD0F170BB35FCDD3CBC2573C80BF102719AAAFB5179BD00DEEC8735B2E71C3),
    .INIT_09(256'h16A40DC1A6121212231FD0C7A80C21CC9BC0139D1817C60E87BE14B8182B8F14),
    .INIT_0A(256'h0D5ACEC1C4D8C11228BD3713A191C0B7A167B0CF9AB0B1CF1EBAC72CC117171B),
    .INIT_0B(256'h291A116FB71ED91516C3A479533011ADAC53D4121C24F0C7BE0CB443AE0816CB),
    .INIT_0C(256'h1144C420BCB4BC0CD6C5BDF018C6B2110B0F15121B13744017B684A85C7D8D85),
    .INIT_0D(256'hA21210AACE73BABD7ACFC1C935D2DF101FCF12DB9E16C9193A93BA9277B42DB0),
    .INIT_0E(256'h9CC79ECD991A13ABADB1CFDEB20E1A0DB1C21A99A9C0AA987FD3C22111C63B31),
    .INIT_0F(256'h0AAEAC4EB115C953DF61BB13D3C8C587E4350F92F71AA710B50AACCE0ABF11A3),
    .INIT_10(256'hB2BEC554BE16D0BCA3BB0ECDB71A070F1423BEC5B2D58FA2ADAA9EE6102147FA),
    .INIT_11(256'hA2BECA0FC1B107FD53AE0D3505CEBFD893A1B82FD0CECC20C09DC997C4B62912),
    .INIT_12(256'hC2AB10147B0AF0CF12113AADCAD56CE3A09B3F1597B7D1A7C913D09AC6157FB5),
    .INIT_13(256'h110DAFC30D1220BA94251BCD0E740F19B716C4BF12C6BB24990C31347C1120AB),
    .INIT_14(256'hE8D5B623C324980CE2CD6427C3181048B20CA29F28118A10ACA24661B729ED86),
    .INIT_15(256'h95B8B6ACB9CD2917C8050ED5B90EAEB1A7BC18CF2286C25B10BB13CFC518CDA3),
    .INIT_16(256'h36B7D114BA140EAD91ADC7D1D22BA6D6C298CB103393ACB9D4C4AF106A30BBA9),
    .INIT_17(256'hA2EB66D19FC5A19871C70FC91FCED9D0AA888CCF78151717BC9187BB13247390),
    .INIT_18(256'hBF420CA1AE860A1B97A670B8919E622CB3CBC0AFC5930ABF2BCDD3CCBAD5E049),
    .INIT_19(256'h13CBA81412BE51BB14EA25884CB7D6D530C7C317D2D31BC99F1D6BC948AEC613),
    .INIT_1A(256'hBFB8B511B29CB399D188D0123808C7BFB796B12D50013FD312F41300A5C905D7),
    .INIT_1B(256'h5CC975C74D0EC21BD49ECD2FBABA18128A8EB91AA80FD8ABC7E70F9E13A27BC1),
    .INIT_1C(256'hB7BCC0A0D1C911CF1C0D75294DD5A2C793CC1284B625AAB87CDCBB981BD0F172),
    .INIT_1D(256'h18E2CA91CFCD0ED2BC288F2D1718A5D0CFCD0BAE93B4CC820FD494B095141CAD),
    .INIT_1E(256'h110EA8B1DDCA02A10EE5539157078E0DBD9E97EA1814C792C01110A95E1E9B78),
    .INIT_1F(256'hBAD2BCA2991014D1D0140E1AA00F13CDC61BE6A7D2C3BBB87FC6902FAB1D11CB),
    .INIT_20(256'hA8CF8B25C3B99991D28AB9AEBCC97DCBC415498F34BFC5C9159428CC179FE38F),
    .INIT_21(256'h980DC1DEF7C2B32AC6981BAA13BCCBD2B92FD0149A0B1C9FC612AAF1A2730F0D),
    .INIT_22(256'h0DF8E904ED100EF104DB1C07EC0AFDF400EDEB181106FEFD1EE5FAF93602F5F8),
    .INIT_23(256'h05EBEEF00708F2FF1AF80C13F20FEBDC0CE0150A062007F1FD18FBEA0F07F50F),
    .INIT_24(256'hEDE904FA02DAF3F3F00CDD07E902081811F80A13060B1BEF08F8FBEBF701FB13),
    .INIT_25(256'hFDFB1006FA1201090DFEE7FB0C1708F519FCF800EC0FF6EB090B1FF40D0BED02),
    .INIT_26(256'hFA08FDE7F6EA0EFEE803063EF00A0C1003090CFF030FFD04000FF80410091606),
    .INIT_27(256'hC1C1FFE0ADCCBA172BC5E4B4B1B5A9AFC0D7C8B5FB19C0C1D1ADB2C0B0C51605),
    .INIT_28(256'hBDE0BFE3C9DD0FE8BCF8B1C3C4FFB5D041BD15E5C2DDBFBDFF0DBAC1ADFCF71E),
    .INIT_29(256'h1A19CBECF8C1E0D306B9BEC5C1C6BB1033AEE7BDBBA9D0C0BAED04DEC8EAA5D2),
    .INIT_2A(256'hE7B2EBC6E7EA26FDBED5BEBAC3CEF2B93DBD3FB3E603DF27C1C2CE92E3EEB9BC),
    .INIT_2B(256'hB7D6BAD515A4BEC3C1CDA6E4B7EFE6D4C0C813EDE87EDCB5B3F1B5C7A5BEB4B5),
    .INIT_2C(256'hD1C3EBB9B9F5CBF7B5C6BCE3CFCE3A02D436DBB2DCF9BFD5E0EDE9C0AAA6F6E2),
    .INIT_2D(256'hDAFBEA0EFCE2BD38B2D9BEC3BFE5B7C3C1C4ADC3CC0EAC9DB1C8E4E8C5C9C7DF),
    .INIT_2E(256'hC8D5C5BBCB01F2C9C4B0BEFAE4C4C0BABBA98AC4ABC81EF2F5AFC1EA181FD8EE),
    .INIT_2F(256'hDFDAB7CEB3C5B11C02D1E0B6C7C2B8FEBDBCB7E1B32DB4EE20DFFEFCB1ADABAD),
    .INIT_30(256'hDFB9C1B6BAF8E3FBCEC4BCB9A50BA9EFEEBAEFFCB93BBD26FAE9C428F2C1E1C5),
    .INIT_31(256'hE9B4BAE0C0B823B7E6DF21C7F8B9D1B7EBFA46CABF07D1FAE8B3F8E4FCA817B7),
    .INIT_32(256'h19ACE4ADF2F80AC7CBC4C630B98013BF569DE599E1F1ACD4BCBCE8BCB006BBF0),
    .INIT_33(256'h28B8ABC2E108C79DF60EBE0670BE1218B9C0DFB4FBB3D98D13D0D2DAC5CCC71C),
    .INIT_34(256'hC129BD07BCCFE6401EB8B80AC9E7C9CFE7E421B4AEBCF2DCC0A80BE2C9D2FEE0),
    .INIT_35(256'hA39DEEE9C3C6C9DBF1C8C7C0B8B04AE4AB2707BFC8C6F0CE03E9BCFDC4BF29BF),
    .INIT_36(256'hF6AB080F3CBDAFF4589E45BDDDDB4E45DEEE40EAD4D009CFB9BFB5DE9F15A3C1),
    .INIT_37(256'hDB61CDB4F6BDC4C7E1BFE9A1E610EECEEDBDBB053BBAB9D7D02FC5B3E190C0B0),
    .INIT_38(256'hBDAF9FB7BFB0C4D8BABBFCAFBD25BCE1282BB1BAC5BAD031C414B4F2E9342BAF),
    .INIT_39(256'hBBE1F6BCBCC5B3ACBE2ABEC2EFB3D035C0C5B0B5C0D3EFB3D7C8BCEDCCF2EEB5),
    .INIT_3A(256'hB7D6F9C3F4DAC9B031A91C2B2FBAB807AACCF2BBBDBCC90319EFB0FFC0EAADEF),
    .INIT_3B(256'h993719B3C8DBEE03FEADADE1CCBE1EC7C5CEBD28D7B3B9AEC9C1DDC0C08802FC),
    .INIT_3C(256'h0FD6B8BF90BBE2BD5190BAD3FAF7D5EB00EFF4B4E7A7DFE709C63B4BB3B4B1D9),
    .INIT_3D(256'h0DC631C5ECF1B0AFF55DB0FEBFF22BE0BBA1BDB5B3A735E1B7B9C34BBAC5B7BC),
    .INIT_3E(256'hBABFADB783DEB7F2ABBDBFC3AEFA95D7BAC4CCFAC7BACB09BDB4DBC2BDED76BF),
    .INIT_3F(256'hFEC4DFF5FCC6E4E5C4B8DBE7B3B834C614BBF030C1BEB1C8B0DD14F1A3BC49BB),
    .INIT_40(256'h22A9B1D1AAADAAE3D3DB14B5A1BBBEE905C5C30138CD12D3361BBFC30021BDF8),
    .INIT_41(256'hCEF136CDDCB9BECBE8C4BAC5C305C84CBDD5B9C2B40AABB7C0C7BBBDAF16F6BF),
    .INIT_42(256'hDEB9AD04DFBFC4E7DAE6B3C2240D0DD7AE0EB3B7C10533ADB64EE5BF0EC5FAB5),
    .INIT_43(256'hC0EBC7C7EFBA0E18E126DED50CC119C713FBC2C6C05DC74DB2C3C9BDD0BB29FE),
    .INIT_44(256'hC2B6F6DFB60EB91ABACBBD9CCACFD71AB4B943EFC4E11AEBB8D5BEE01238AFC7),
    .INIT_45(256'h3D3EA2D83F3B419BCA39BD41403F44423C393B3FAFAA3C3B393A413F3D3EA6A8),
    .INIT_46(256'h3FB43A9F3C359FBD409E413D3B9940A7AE3E91B73EBF3F3F9592403E419930DC),
    .INIT_47(256'hC49C3EF3933EFDA498403E3C3F3C3FCEC941DD403F403C3F3FC9D1C33EDE4139),
    .INIT_48(256'hCD3FAD3DCF92A38E3F3A3E413E3DC13FAF3DB540A69ED3A63E3D3A40A496403C),
    .INIT_49(256'h3FEC40959A413E3F3F3E42AD40948EE6403F9B9899429D403FBA4141403E3D3F),
    .INIT_4A(256'h3B3FAA4140AF3D8E403C3E8D3B3EB59EFFADA942EB943E3AB3959B3F403E90D4),
    .INIT_4B(256'h9B9BE9ABA6AB3DAD42D13C3E3FD13E3B403E413E407D40413F3EAEF93E3C3EDD),
    .INIT_4C(256'h3F383E403F97983C3E423FA7973D3E3F4042453E413DA4AE9A413EC6ABB33997),
    .INIT_4D(256'hF23B413F403E41A693AAC1403D413F973E403EBC41A940B1A5FCBE984041413E),
    .INIT_4E(256'hB040403E409BD39D3B403F3E419A3F94A43F98A13FAC40A0AD9B3D9EA43FAA3E),
    .INIT_4F(256'hA2403FCC3F3FA140999EB73E9D403A419B90B93D4193D834CD3EA9F09A429A40),
    .INIT_50(256'hBE40CD42B499983E3D3F3AC83FDAA542B841BB40D7E241E13F41BF3E42974095),
    .INIT_51(256'hA23F403DB4BC3E41AC983CC2433E999F413EAB40D63E974399253A38393B3D9A),
    .INIT_52(256'h3CA640A1413DFAB3B93E3FCB3EC33D3D9DEA9B3D3D418DAC3E3F94FA3F3AA38C),
    .INIT_53(256'h4041BA9A3F3F3CCBCA3F3D3B3F40C9DE41A09E403D3F8B3D9BE83E8D3E3FA83E),
    .INIT_54(256'hA142B897AA41419AB741C53E94C7C8B9C0B8A3BB95418E3A3E3F41BB4197423E),
    .INIT_55(256'h3AE13F3F9F403B3FE23FB240269FBABF9941409DB34140AFA5A14040A7443F3F),
    .INIT_56(256'h3F3F3F40403D41903D3F9D413FAF3EA2B1B9423D3E3E3A98419C4196ABB0AC3F),
    .INIT_57(256'h3FF7E73E3E403E3F40A93F3DC3413DA63F3C42413FE4963DB83D41D13ADBA13E),
    .INIT_58(256'h3E39B43F9E3B3F40A53FAEF2F73F40943D3AD53D403F3BADACB541993EAB418E),
    .INIT_59(256'h43B7A13F3D37A78FAB3E3E9A3C41A43E3C3E3D9FD04140423F3D37413D41AEA3),
    .INIT_5A(256'hA0EF403F413D8F3FFE463F3A9F993A979BA69840B13E2931C83DAA433F3E41BF),
    .INIT_5B(256'h9A3EB13D8EBC414290BF3FBF3E90A3B13F4140403F44A4AF413D3ABE403F4141),
    .INIT_5C(256'h3F42404045AC3F90403C3E3D419F3FE3413B3D9E383F3D523F449D3E4291443E),
    .INIT_5D(256'hA5403ACC9410F1E23F3F399A3E3FB63E953F9BAB3F3E423942A3A2D6413FB03E),
    .INIT_5E(256'hE0423E3B3F3F3FBAA539A640413E3F919A3F3FA3AE3DA6F7AFA13E3F8D973F8F),
    .INIT_5F(256'h3ED5B93BC8413F3B9340403E3DB63BD141E34040409542403E404241409E9A3E),
    .INIT_60(256'hCD40419B35423EE536CE403FA2C49A3940C03F3D40DA9F4240CBEB3FA93F9E40),
    .INIT_61(256'h409A3D3E2E3F9F93D597B33BA53D994094C33D3F3EF13DC0403E3E3C3C3FB29F),
    .INIT_62(256'h3F3E9D3A3F9B3F99403C3D433C3C3AB53F3EB0DC40BA95B43FAF3FE69A9E403D),
    .INIT_63(256'hE87039935B6657F1ED26621594DC2B52DFAC49A0065C067DA05C2F25D518101B),
    .INIT_64(256'hFA03FB076001CAC12804D3CB3B929B35B6FF9D171C40A7A23FE4A33B88DC211F),
    .INIT_65(256'hC78081DE55DA936F184899A287CF9FDF4E67F1E879D87369D14D2315DFEE1F47),
    .INIT_66(256'h0E1EF500C3C172533D7B8B3D7029933EF1C99A6E17E59275060B2E80515120FE),
    .INIT_67(256'h1A611C78A5F5CA30832118A3024CB26A9A22AA5C4669F4E9EE971BC741B75CC7),
    .INIT_68(256'h51E8F2A063531D8E5EF173DFD78AF3119C76B44347669B42E374620B93A5CAA9),
    .INIT_69(256'hCEBFFAEEF44237F9EF380335748DCBD7797BCC33F68FE0695F861E668F288FD8),
    .INIT_6A(256'h970344CC84C3E9B1E70AE095F1A1AEABF4E04C60B2855C16C876BD043830BEC1),
    .INIT_6B(256'hB9F6EEB5554B42CD6A199B2FF812495F9B4DA836306A2C4E33E91FB926C7225C),
    .INIT_6C(256'hB87A82088CBCE9B6FF861119B07E0BD1DDD04A997DDCD942A8BD01C0CECD57E5),
    .INIT_6D(256'hF6F7F2F7F5F5FAF2F6F3F1F6F5F4F6F7FBF4F5F3F5F1F3FCF2F3F4F3F2FBF7F5),
    .INIT_6E(256'hF102F4F4EDFFF6F8F0F7F1F7F6F2F9FBF0F6F4F7F3F5F5FDFAF1FCFBF5F2F9F2),
    .INIT_6F(256'hF3F4F2F2FCF5F8F2F7F6F3F4F2F7F4F6F7F1F4F2F7F3F2F6F6FAF1F2F7F2F3F7),
    .INIT_70(256'h00F3F5F8FAF4FBFAF0F2FBF4F9F8F4F4F9FBF2F3F1F0F5F6FCF7EFF2F1F9F8F7),
    .INIT_71(256'h07FFF5F2F2F6F8F6F8F2F3F6F2F402F9F2F4F5F5F9F6F4EFF3F8F5F4F1F3F3F3),
    .INIT_72(256'hF4FCF4F7F7F2F3F0F8F5F2F0F9F2F5F8F1F6F3F4F7FAF7F3F3F6F5F3F2F4F4F3),
    .INIT_73(256'hF7F1F5F4F2F6F5EDF1F6F9F1F1F8F9F5F4EFFCF602F9F4F6F0F3F9F4F4FAFD06),
    .INIT_74(256'hF9F8F3F3F9EFF6F6F0F4F1F6F8F5F3F8F7F2F7F0F4FDF5F3F6F8FAFAF9FDF7F5),
    .INIT_75(256'hF8F7F5F6F9F7F9F4F4F0F3F8F6F4F7F5F5F6F3F5FBF501F6F9F9F4EFF4F5F6F4),
    .INIT_76(256'hF2F5FBF4F8FAF6F3F6F8F0F3F0F4F6F7F7F1F1F8F3F4F1F5F6F5F9F5F9F5F5FB),
    .INIT_77(256'hEFF9F5FAF4F6F5F9F5F9F6F3F7F3F4F4F3FDF6F9F6F6F6ECF2F7EEF6F4F7F7FF),
    .INIT_78(256'hF6F5F2F8F5F6F6F2F4F0F701F7FBF1F4EFF3EFF5F3F9F3F7F4F8EEF9F1F5F5F9),
    .INIT_79(256'hF4F9F0F3F5F2F9F4F8F7F5EEF7F3F5F4F7F5F7F6FDF4F8F3F6F9F4F4F401FCF5),
    .INIT_7A(256'hF0F5F1F1F5F5F2F6FCF6FEF5F5F0FFEEF9F5F5F4F6F7F7F4F8F8F6F7F7F5F8F3),
    .INIT_7B(256'hF1F2F5F5F3F8FCF5F7F7FEF1F1F4F5F3F0F5F7F4F6F4F8F2F5F5F8F7F3FFF8F3),
    .INIT_7C(256'hF2FAF5FBFAF6F6F5F3F8F0F5F5F8F2F7F6FBF8F7F7F4F2F1F9FAF6F7FAF9F8F2),
    .INIT_7D(256'hF7F4F4F5F7F3F6FBF7F6FAF8F5F8F5EFF2F5FAF4F5F8F5F5F3F4F2F9F1F9F6F7),
    .INIT_7E(256'hF8FDF5F7F5F5F5F9FCF8F4F5F3F4F9F5F2F1F9F3F5F1F2F1F2F8F8F4F6F3F3F9),
    .INIT_7F(256'hF7F8F7F6FAF8F5F4F5F5F8F5F3F5FA0A00F8F9F9F5FAF3F5EFFAF4F5F8F8F2F7),
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
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,dina[7:0]}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,dina[8]}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:8],\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 }),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:1],\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 }),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ram_ena),
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
module Bias_Bram0_blk_mem_gen_prim_wrapper_init__parameterized14
   (p_19_out,
    clka,
    ena_array,
    ena,
    addra,
    dina,
    wea);
  output [17:0]p_19_out;
  input clka;
  input [0:0]ena_array;
  input ena;
  input [10:0]addra;
  input [17:0]dina;
  input [0:0]wea;

  wire [10:0]addra;
  wire clka;
  wire [17:0]dina;
  wire ena;
  wire [0:0]ena_array;
  wire [17:0]p_19_out;
  wire [0:0]wea;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:16]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED ;
  wire [3:2]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(1),
    .DOB_REG(0),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'hFFFFFF3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3FFFFFFFFFFFFFFFFFFFFFFCFFF),
    .INITP_01(256'hFFFFFFFFFFFFFFFFFFF3FFFF3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INITP_02(256'hFFFFFFFF3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INITP_03(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INITP_04(256'hFFFFF3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INITP_05(256'h555555555555555555555555555555555555555555555555FFFFFFFFFFFFFFCF),
    .INITP_06(256'h5555555555555555555555555555555555555555555555555555555555555555),
    .INITP_07(256'h5555555555555555555555555555555555555555555555555555555555555555),
    .INITP_08(256'h5555555555555555555555555555555555555555555555555555555555555555),
    .INITP_09(256'h5555555555555555555555555555555555555555555555555555555555555555),
    .INITP_0A(256'h5555555555555555555555555555555555555555555555555555555555555555),
    .INITP_0B(256'h5555555555555555555555555555555555555555555555555555555555555555),
    .INITP_0C(256'h5555555555555555555555555555555555555555555555555555555555555555),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000005555),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'hFFF3FFF5FFF6FFF9FFF0FFF7FFF7FFF7FFF10000FFF2FFF6FFF5FFF4FFF3FFF5),
    .INIT_01(256'hFFF6FFF1FFF6FFF4FFF2FFF7FFF6FFF5FFF7FFF6FFFAFFF3FFF7FFFAFFF4FFF9),
    .INIT_02(256'hFFEEFFF4FFF5FFF6FFF8FFF8FFF1FFF7FFF3FFF7FFF3FFF3FFFBFFF4FFF3FFF1),
    .INIT_03(256'hFFF3FFF2FFF9FFF1FFF9FFF5FFF4FFF5FFFAFFF3000BFFF2FFEEFFF5FFF6FFF3),
    .INIT_04(256'hFFF8FFFBFFF6FFF5FFF7FFFBFFF6FFF3FFFBFFEFFFF7FFF9FFF8FFF5FFF7FFEE),
    .INIT_05(256'hFFF5FFF4FFF8FFF7FFF4FFF7FFF1FFF6FFF6FFFFFFF5FFFEFFF7FFF5FFF9FFF5),
    .INIT_06(256'hFFFDFFF5FFF7FFF1FFF6FFFBFFF1FFF4FFF1FFF5FFF9FFF4FFFAFFF4FFF3FFF6),
    .INIT_07(256'hFFF5FFEFFFFDFFF5FFF5FFF9FFF5FFFAFFFAFFF8FFF4FFF50005FFF7FFF4FFF6),
    .INIT_08(256'hFFF5FFF8FFF6FFF3FFF6FFF2FFF4FFF3FFF9FFF4FFF3FFF4FFF9FFF7FFF6FFF6),
    .INIT_09(256'hFFF6FFF3FFF7FFF6FFF6FFF6FFF8FFF5FFF6FFF3FFF3FFF4FFFFFFFDFFFCFFF6),
    .INIT_0A(256'hFFF6FFF7FFF9FFF6FFF7FFF5FFF9FFF7FFF4FFFCFFF5FFF9FFF5FFF7FFF2FFF5),
    .INIT_0B(256'hFFFAFFF5FFF0FFF7FFF5FFF9FFF4FFF2FFF5FFF7FFF3FFF8FFF2FFF6FFF1FFF4),
    .INIT_0C(256'h0003FFF3FFF7FFF7FFF5FFF5FFF5FFFAFFF3FFF2FFF6FFF5FFF7FFF3FFF3FFF5),
    .INIT_0D(256'hFFF4FFF8FFF2FFF4FFF9FFF40002FFF1FFF5FFF7FFF0FFF7FFF5FFF7FFF3FFF3),
    .INIT_0E(256'hFFF3FFF7FFF4FFF6FFFEFFF4FFF3FFF0FFF2FFF8FFF3FFF7FFF2FFF5FFF7FFF3),
    .INIT_0F(256'hFFF7FFF7FFF8FFF3FFF3FFF8FFF7FFF3FFF4FFF7FFF6FFF5FFF6FFF4FFF5FFF3),
    .INIT_10(256'hFFF4FFF4FFF7FFF4FFF7FFF8FFF5FFF5FFF5FFF3FFF6FFF9FFF6FFF5FFF5FFF6),
    .INIT_11(256'hFFF1FFF8FFF3FFFCFFF4FFF2FFFDFFF6FFF9FFF0FFF8FFF6FFF6FFF6FFF3FFF7),
    .INIT_12(256'hFFF4FFF2FFF6FFF4FFF2FFF2FFF7FFF0FFF9FFFDFFFCFFF4FFF6FFF6FFF3FFF4),
    .INIT_13(256'hFFFAFFF6FFF7FFF5FFF0FFF1FFF8FFF0FFF3FFFBFFF9FFF5FFF5FFF6FFF1FFF5),
    .INIT_14(256'hFFF7FFF6FFF8FFF6FFF9FFF3FFF2FFF6FFF2FFF5FFF4FFF7FFFCFFFAFFF8FFF7),
    .INIT_15(256'hFFF6FFF8FFF7FFFAFFF0FFF2FFFFFFFAFFF4FFEFFFF1FFF6FFF6FFF3FFF4FFF5),
    .INIT_16(256'h0001FFF4FFF9FFF7FFF9FFFCFFF7FFEFFFF0FFFDFFF5FFF2FFF8FFF1FFF4FFF5),
    .INIT_17(256'hFFFEFFF0FFF1FFF4FFF2FFF7FFF8FFF2FFF5FFF4FFF4FFF5FFFAFFF4FFF6FFF6),
    .INIT_18(256'hFFF5FFF8FFF5FFF5FFF5FFF5FFF6FFF8FFF6FFF8FFF5FFF1FFF3FFF4FFF4FFF5),
    .INIT_19(256'hFFF7FFF3FFF8FFF9FFF9FFF2FFF6FFF6FFF8FFF7FFF3FFF5FFF8FFEFFFF9FFF8),
    .INIT_1A(256'hFFF5FFF7FFFEFFF5FFF5FFFAFFF4FFF3FFFEFFF8FFF2FFF8FFFAFFF6FFF7FFFB),
    .INIT_1B(256'hFFF6FFF3FFF2FFF4FFF8FFF9FFF1FFF1FFF2FFF2FFF7FFF8FFF2FFF3FFF6FFF1),
    .INIT_1C(256'hFFFEFFF7FFF5FFF8FFF70002FFF0FFF5FFF3FFF4FFF8FFF5FFF8FFF1FFF9FFF8),
    .INIT_1D(256'hFFFAFFF5FFF7FFF7FFF8FFF5FFF5FFF3FFF2FFF2FFEFFFF8FFF3FFF2FFFCFFF5),
    .INIT_1E(256'hFFF3FFF8FFF5FFFDFFFAFFF1FFF6FFF6FFF6FFF4FFF5FFF9FFFAFFFCFFF4FFF1),
    .INIT_1F(256'hFFF7FFF5FFF6FFF1FFF2FFF8FFF4FFFBFFF3FFF5FFF5FFF4FFFBFFF2FFF0FFF1),
    .INIT_20(256'hFFFBFFF6FFF3FFF5FFF4FFF8FFF4FFF5FFF6FFF2FFF5FFF3FFF4FFF6FFF2FFF4),
    .INIT_21(256'hFFF6FFF7FFF3FFF5FFF1FFF2FFF9FFF7FFF4FFFAFFF7FFF4FFF1FFFAFFF5FFF5),
    .INIT_22(256'hFFF2FFF6FFF1FFF5FFF7FFF2FFF6FFF2FFFBFFF7FFF6FFF9FFF6FFF9FFF8FFF8),
    .INIT_23(256'hFFF5FFFBFFF4FFF9FFF6FFF6FFF3FFF3FFF6FFF4FFF0FFF3FFFAFFF7FFF2FFF5),
    .INIT_24(256'hFFF3FFF5FFF8FFF5FFF7FFF8FFF4FFF6FFF6FFF1FFF2FFF5FFF8FFEDFFF3FFF3),
    .INIT_25(256'hFFF8FFF2FFFCFFF8FFF5FFF8FFF3FFF4FFFCFFFCFFFAFFEFFFF8FFFCFFF3FFF5),
    .INIT_26(256'hFFF8FFF6FFFFFFF7FFF3FFF2FFF9FFF4FFF3FFF6FFF5FFF5FFEFFFF3FFF6FFF1),
    .INIT_27(256'hFFFEFFF6FFF5FFF3FFF5FFF4FFF4FFF7FFF2FFF20001FFF3FFFAFFF2FFF4FFF5),
    .INIT_28(256'hFFF0FFF7FFF6FFF6FFF7FFF7FFF8FFF4FFF4FFF4FFF2FFF4FFEF0003FFF5FFF5),
    .INIT_29(256'hFFF5FFF0FFF5FFF4FFFAFFF6FFF0FFF1FFF6FFF9FFF1FFF9FFF7FFF6FFF6FFF5),
    .INIT_2A(256'h00BB00BC00BB00BB00BA00BB00BB00BC00BB00BB00BC00BC00BA00BB00BC00BD),
    .INIT_2B(256'h00BC00BC00BB00BC00BC00BC00BB00BC00BB00BD00BE00BC00BC00BC00BA00BB),
    .INIT_2C(256'h00BB00BD00BB00BB00BA00BC00BD00BB00BB00BB00BB00BC00BA00BC00BB00BB),
    .INIT_2D(256'h00BD00BB00BB00BA00BD00BD00BB00BB00BB00BB00BD00BC00BB00BC00BB00BB),
    .INIT_2E(256'h00BC00BD00BC00BB00BD00BA00BB00BC00BC00BB00BC00BC00BA00BB00BC00BD),
    .INIT_2F(256'h00BA00BA00BA00BC00BB00BB00BD00BB00BC00BB00BC00BA00B900BC00BC00BB),
    .INIT_30(256'h00BF00BA00BA00BA00BC00BB00BB00BC00BE00BC00BB00BB00BB00BA00BA00BC),
    .INIT_31(256'h00BB00BB00BB00BB00BA00BB00BA00BC00BB00BC00BB00BC00B900BB00BB00BC),
    .INIT_32(256'h00BC00BA00BB00BB00BA00BB00BB00BB00BA00B900BC00BC00BC00BA00BB00BB),
    .INIT_33(256'h00BB00BA00BB00BC00BB00BA00BE00BA00BA00BA00BC00BB00BB00BC00BB00BA),
    .INIT_34(256'h00BB00BC00BB00BC00BD00BC00BB00BC00B900BC00BB00BB00BC00BD00BC00BB),
    .INIT_35(256'h00BC00BB00BB00BB00BB00BB00BC00BB00BA00BB00BB00BC00BC00BD00BA00BB),
    .INIT_36(256'h00BC00BA00BB00BC00BD00BC00BB00B900BD00BA00BC00BC00BD00BC00BA00BC),
    .INIT_37(256'h00BE00BB00BA00BA00BB00BC00BD00BB00BB00BB00BB00BB00BC00BB00BC00BB),
    .INIT_38(256'h00BD00BB00BD00BE00BB00BC00BB00BC00BA00BC00BC00BA00BB00BB00BD00BA),
    .INIT_39(256'h00BB00BD00BA00BC00BD00BB00BA00BA00BC00BA00BC00BB00BB00BC00BB00BA),
    .INIT_3A(256'h00BB00BE00BB00BA00BA00BC00BB00BC00BC00BA00BB00BC00BC00BC00BB00BB),
    .INIT_3B(256'h00BB00BC00BC00BD00BA00B900BE00BB00BC00BB00BB00BC00BA00BB00BB00BB),
    .INIT_3C(256'h00BB00BB00BB00BB00BD00BC00BC00BB00BB00BB00BB00BC00BA00BB00BB00BB),
    .INIT_3D(256'h00BB00BC00BB00BB00BB00BC00BD00BC00BC00BC00BC00BC00BB00BC00BD00BB),
    .INIT_3E(256'h00BB00BC00BC00BC00BB00BB00BB00BB00BB00BB00BA00BA00BB00BA00BA00BB),
    .INIT_3F(256'h00BC00BC00BB00BB00BB00BC00BB00BB00BB00BB00BA00BC00BB00BA00BB00BC),
    .INIT_40(256'h00BD00BB00BC00BB00BB00BC00BD00BC00BD00BB00BB00BB00BB00BC00BC00BB),
    .INIT_41(256'h00BC00BC00BB00BA00BC00BC00BB00BC00BB00BC00BB00BB00BB00BA00BD00BB),
    .INIT_42(256'h00BC00BB00BA00BA00BB00BB00BA00BA00BC00BA00BB00BB00BB00BC00BB00BA),
    .INIT_43(256'h00BB00BC00BE00BD00BC00BC00BA00BA00BA00BC00BD00BA00BC00BB00BC00BA),
    .INIT_44(256'h00BC00BC00BC00BB00BA00B900BC00BD00BE00BB00BB00BB00BC00BD00BA00BD),
    .INIT_45(256'h00BC00BD00BD00BC00BC00BB00BC00BB00BB00BC00BB00BC00BC00BA00BC00BB),
    .INIT_46(256'h00BB00BB00BC00BC00BD00BB00BD00BC00BB00BC00BC00BA00BC00BC00BC00BE),
    .INIT_47(256'h00B900BA00BB00BA00BB00BB00BC00BC00BA00BE00BB00BD00BC00BC00BC00BD),
    .INIT_48(256'h00BB00BB00BB00BC00BC00B900BC00BD00BD00BC00BC00BB00BB00BB00BC00BC),
    .INIT_49(256'h00BC00BB00BC00BB00BB00BC00BC00BC00BB00BB00BB00BA00BC00BD00BA00BC),
    .INIT_4A(256'h00BC00BC00BB00BB00BD00BC00BB00BB00BC00BA00BA00BC00BC00BC00BC00BB),
    .INIT_4B(256'h00BB00BB00BC00BA00BC00BC00BC00BB00BC00BC00BC00BD00BA00BD00BE00BB),
    .INIT_4C(256'h00BD00BB00BC00BB00BB00BB00BC00BA00BC00BC00BD00BB00BA00BC00BC00BB),
    .INIT_4D(256'h00BC00BC00BC00BC00BC00BB00BC00BB00BC00BB00BC00BB00BD00BC00BC00BB),
    .INIT_4E(256'h00BB00BB00BC00BC00BC00BB00BA00BD00BC00BC00BB00BB00BC00BB00BB00BC),
    .INIT_4F(256'h00BC00BC00BC00BB00BC00BC00BD00BC00BB00BB00BC00BC00BB00BB00BD00BB),
    .INIT_50(256'h00BE00BC00BC00BD00BB00BC00BB00BC00BC00BB00BB00BA00BB00BD00BC00BD),
    .INIT_51(256'h00BB00BA00BB00BD00BB00BC00BB00BC00BB00BD00BD00BB00BC00BC00BB00BB),
    .INIT_52(256'h00BE00BC00BC00BB00BB00BD00BD00BD00BA00BF00BB00BD00BB00BC00BC00BA),
    .INIT_53(256'h00BE00BC00BB00BB00BC00BC00BD00BD00BC00BD00BB00BC00BC00BB00BC00BC),
    .INIT_54(256'h00BB00BB00BC00BD00BD00BC00BC00BC00BB00BD00BE00B800BA00BC00BD00BD),
    .INIT_55(256'h00BD00BA00BC00BD00BB00BC00BB00BC00BD00BB00BA00BD00BB00BA00BA00BA),
    .INIT_56(256'h00BC00BC00BB00BE00BC00BB00BB00BB00BB00BB00BB00BC00BB00BC00BA00BD),
    .INIT_57(256'h00BC00BB00BB00BC00BC00BB00BB00BA00BB00BC00BB00BB00BB00BC00BB00BB),
    .INIT_58(256'h00BB00BC00BD00BB00BC00BC00BC00BB00BD00BA00BC00BB00BD00BC00BC00BB),
    .INIT_59(256'h00BD00BB00BC00BC00BB00BB00BA00BC00BC00BD00BA00BC00BC00BB00BC00BD),
    .INIT_5A(256'h00BC00BC00BB00BA00BB00BB00BC00BC00BB00BD00BC00BD00BB00BB00BC00BC),
    .INIT_5B(256'h00BC00BB00BC00BC00BC00BC00BB00BB00BC00BA00BB00BC00BA00BB00BC00BC),
    .INIT_5C(256'h00BA00BC00BC00BC00BA00BA00BB00BB00BB00BA00BB00BB00BB00BB00BC00BB),
    .INIT_5D(256'h00BD00BD00BB00BC00BB00BB00BD00BC00BC00BD00BC00BB00BC00BB00BC00BA),
    .INIT_5E(256'h00BC00BC00BE00BC00BD00BD00BC00BC00BC00BD00BC00BD00BB00BD00BB00BB),
    .INIT_5F(256'h00BD00BA00BD00BB00BD00BD00BB00BA00BB00BA00BB00BB00BB00BC00BC00BC),
    .INIT_60(256'h00BD00BA00BC00BC00BB00BB00BB00BC00BB00BC00BB00BE00BC00BB00BB00BB),
    .INIT_61(256'h00BD00BA00BD00BD00BC00BC00BC00BC00BB00BB00C000BC00BB00BB00BC00BD),
    .INIT_62(256'h00BC00BB00BC00BB00BC00BE00BD00BB00BC00BD00BC00BC00BA00BD00BB00BD),
    .INIT_63(256'h00BC00BB00BA00BA00BB00BB00BA00BC00BE00BB00B900BA00BB00BC00BB00BB),
    .INIT_64(256'h00BB00BB00BB00BB00BB00BB00BB00BB00BB00BB00BB00BC00BB00BC00BD00BB),
    .INIT_65(256'h00BA00BC00BB00BB00BB00BB00BB00BD00BA00BB00BB00BB00BA00BB00BB00BB),
    .INIT_66(256'h00BB00BD00BB00BB00BC00BA00BD00BA00BC00BD00BC00BB00BB00BB00BB00BB),
    .INIT_67(256'h00BB00BC00BC00BA00BB00BB00BC00BC00BB00BD00BC00BD00BB00BC00BD00BD),
    .INIT_68(256'h0000000000000000000000000000000000BB00BB00BB00BB00BB00BB00B900BB),
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
    .READ_WIDTH_A(18),
    .READ_WIDTH_B(18),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(18),
    .WRITE_WIDTH_B(18)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({1'b1,addra,1'b1,1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,dina[16:9],dina[7:0]}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,dina[17],dina[8]}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:16],p_19_out[16:9],p_19_out[7:0]}),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:2],p_19_out[17],p_19_out[8]}),
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
module Bias_Bram0_blk_mem_gen_prim_wrapper_init__parameterized15
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ,
    clka,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_2 ,
    ena,
    addra,
    dina,
    wea);
  output [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  input clka;
  input \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_2 ;
  input ena;
  input [11:0]addra;
  input [8:0]dina;
  input [0:0]wea;

  wire [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_2 ;
  wire [11:0]addra;
  wire clka;
  wire [8:0]dina;
  wire ena;
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
    .INITP_00(256'h044044A19A099CD3748438A90011396C21044A01050300008610E20535936601),
    .INITP_01(256'h798040063550EB0130001A0080210C504C2880259400C50500C0150000000640),
    .INITP_02(256'h20220000000000000000000000000000000000000000005C7D60050286A3D87A),
    .INITP_03(256'h000000000000000000000000ED5A82E43A09045C650643660685E8E3041C1608),
    .INITP_04(256'h5317269F7DE1EB3E3E5CA884A237AC969D263C9F000000000000000000000000),
    .INITP_05(256'h00000000000000000000000000000000000000000000000066A2B9B418F693B8),
    .INITP_06(256'h30928049B7438145000000000000000000000000000000000000000000000000),
    .INITP_07(256'h00000000000000000000000084A5907F2F59825E02A013552786855AC210D477),
    .INITP_08(256'h5183410000210080040242000000000000000000000000000000000000000000),
    .INITP_09(256'h1920001000810011110340004020004816110000020000000080000098803000),
    .INITP_0A(256'hA50DB038D6193B3A39AFC4FF1AE6B1D9428F56D162CCB7203F4B773F03400052),
    .INITP_0B(256'h0318209800000000000000003B572058DB397658C03289D3C2834F60D6C627BB),
    .INITP_0C(256'h10400500090000C1C02D09C00946918C104A44100A200B08540008141A084850),
    .INITP_0D(256'h41A9445B4673694EF49DF9E2B7E581DC40F9BAC4B8005681C832342050290208),
    .INITP_0E(256'h000000007187D39BD8E0B83D55A13FFEDBE17E14C9EA68E4CC6E89DA784E83B4),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000FFFF00FF00FFFF0000FF0000FFFF00FFFF0000FFFF0000000000000000FF),
    .INIT_01(256'hFF00000000FFFF00000000FF00000000FFFFFF000000FF000000000000FF00FF),
    .INIT_02(256'h0000000000FF00FF000000000000FFFF01010100000100000000000101000100),
    .INIT_03(256'h0000FF00000000FF0000000000FF000000FF0000FF00FF0000000000000000FF),
    .INIT_04(256'h0000000000000000000000FF000000FF0000FFFFFF0000FF00FFFF00FFFF0000),
    .INIT_05(256'h00FFFFFF00FF0000FF00000000FF00000000FFFFFF000000FF00FF00FF0000FF),
    .INIT_06(256'hFF0000FFFF00FF0000000000FF0000FFFF0000FFFFFF0000FFFF00FF0000FFFF),
    .INIT_07(256'h0000000000FF000000FF00000000000000FF000000FF0000FF00FF00000000FF),
    .INIT_08(256'h010101000000000000000000000000000000000000FFFF0000FF000000000000),
    .INIT_09(256'h0000000000000000FFFF000000000000000000FF00FF00FF0000000000000000),
    .INIT_0A(256'hFF0000FF00FF00000000000000000000FFFF000000FF00FF0000000000FF00FF),
    .INIT_0B(256'h00FF0000FFFF00000000FF00FF000000FF000000000000000000FF0000FF00FF),
    .INIT_0C(256'hFF000000000000000000FF00000000FF00000000FFFF000000FF00FF00000000),
    .INIT_0D(256'h0000FFFF000000000000000000000000000000FFFF00FF000000000000000000),
    .INIT_0E(256'h0000FFFF00FF00FF00FF00FF00000000FFFFFF00FF00FFFF00000000000000FF),
    .INIT_0F(256'h00FFFFFFFF0000FFFF0000000000000000FF0000000000000000000000FFFF00),
    .INIT_10(256'hFF00000000FFFF00FF00FF000000FFFFFFFF00FFFF00000000FFFFFFFF00FF00),
    .INIT_11(256'h00FFFFFFFFFF00FF00FFFF00000000000000000000FF00FF000100000000FF00),
    .INIT_12(256'h01000101000000000000000100000000000101000000000000FF00FFFFFF0000),
    .INIT_13(256'h0000000000010000000000000000010000000000000000010000000001000100),
    .INIT_14(256'h0101000000010100000100000000010001010000010000000000010100000001),
    .INIT_15(256'h0000000100000000000100000001010001000001000000000100000000000000),
    .INIT_16(256'h0000000101010000010100010100000000010100000100000000010000010000),
    .INIT_17(256'h0000FF00000000000000FF000000FF0000000000000100000101000101000000),
    .INIT_18(256'h0000000000FF0000000000FFFFFF0000000000FF00FFFF0000000000FF000000),
    .INIT_19(256'h0000000000FFFF00FF00000000FF00FFFFFFFF00FF000000FFFFFF000000FFFF),
    .INIT_1A(256'h00FFFF0000FF00FF0000000000FFFF0000FF00000000FFFF00FFFF0000FFFF00),
    .INIT_1B(256'h0000FFFFFF00FF0000000000FF0000FF0000000000FF000000FF00FFFFFF0000),
    .INIT_1C(256'hFFFFFF00FFFF00FF00FF00FFFF00FF00FF0000000000FF00FFFFFF0000FF0000),
    .INIT_1D(256'h0101000101000101010101010101010100000101010101000101010001010101),
    .INIT_1E(256'h0101010101010101010101010101010101010101010101010101010101000000),
    .INIT_1F(256'h0100010100010100010101010101010101010101010101010001010101010100),
    .INIT_20(256'h0100010001010101010101010101010101010101010101010101010101010101),
    .INIT_21(256'h0101010101010101010101010101000101010101010101010001010101010101),
    .INIT_22(256'h0101010101010101010101000100010101010101010001010101010100010101),
    .INIT_23(256'hFF0000FFFFFF00FF0000FF0000FFFF000000FFFFFFFF0000FF0000FFFFFFFFFF),
    .INIT_24(256'hFF00FF000000FF000000FFFF00FFFFFFFF00FF00FFFF0000FF0000FF00FFFF00),
    .INIT_25(256'h0000FFFFFFFFFF0000FF00FFFFFF0000FF00FF00FF000000FF00000000FF0000),
    .INIT_26(256'h00FFFFFFFFFF00FFFFFFFF00000000FFFFFFFF00FF00FFFF0000FFFFFFFFFF00),
    .INIT_27(256'h00FF00FF0000FFFF000000FF00FFFFFF0000FF0000FFFF00FF0000FFFFFFFFFF),
    .INIT_28(256'h000000FFFF000000FFFFFFFF00FFFF00FF0000FF0000FFFFFF00FFFFFF000000),
    .INIT_29(256'h00FFFF0000FFFF00FF00FF000000FF00FF00FFFFFF0000FFFF00FFFF00FF0000),
    .INIT_2A(256'h0101010101010101010101010101010101010101000001010101010101010101),
    .INIT_2B(256'h0101010101010101010101010101010101010000010101000101010100010101),
    .INIT_2C(256'h0001010101010101010000010001010101010101010101010101010101010101),
    .INIT_2D(256'h0101010101000101010001010101010001000101010101010001010101010101),
    .INIT_2E(256'h0101010100010101010101010101010101010101010101010101010101010101),
    .INIT_2F(256'h0101010001010101010101010001000101010001010001010101010100010101),
    .INIT_30(256'h0001010001010000000000000101000000000001000000000100010101000000),
    .INIT_31(256'h0101010001010001000001010001010100000100010000000101000100010100),
    .INIT_32(256'h0001000001010000000001010100000000000101000000010000000101010001),
    .INIT_33(256'h0101000000000000010000000001010001000000010001000000000100000101),
    .INIT_34(256'h0100010100010101000000010101000101010000010000000000000000010001),
    .INIT_35(256'h0000000000010001000001000100000001010001000001000000010100000000),
    .INIT_36(256'hFF00FFFF00FFFFFF00FF00000000FFFFFF000000000000FF00FF000000FF00FF),
    .INIT_37(256'h0000FFFF00000000FF0000FF0000FF00FF0000000000000000FF0000FF0000FF),
    .INIT_38(256'hFFFF00000000FF00000000FF00000000FFFF00FF00FF000000FFFFFF00FFFFFF),
    .INIT_39(256'h0000FF0000FFFFFFFF00000000FFFF00FF00000000FF00FF00FF00FFFF00FF00),
    .INIT_3A(256'h000000000000FF00FF00FF0000000000000000FF0000FFFF00FF00FF00FF00FF),
    .INIT_3B(256'h0000FF00FFFFFFFF00FF00FFFF0000FFFF0000000000FF0000FF00FFFFFFFF00),
    .INIT_3C(256'hFF00000000FF0000FF00FF0000FF00FFFF0000FF0000000000FFFFFFFFFFFFFF),
    .INIT_3D(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_3E(256'h0101000101010101010101010101010101010101010100010101010101010101),
    .INIT_3F(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_40(256'h0101010101010101010101010101010101010100010101010101000101010101),
    .INIT_41(256'h0101010101010101010100010101010101010101010101010101010101010101),
    .INIT_42(256'h0101010101010101010101010101010101010101010101010101010101010001),
    .INIT_43(256'h0101000100010001010100010000000001010001010001010001010001000000),
    .INIT_44(256'h0001010000010001010101010101010100010100000001010000010001010101),
    .INIT_45(256'h0000000000FF0000000000000000FF0000FF00000000FF000000000000000000),
    .INIT_46(256'h00000000000000000000FF00000000FF0000000000000000FF00000000000000),
    .INIT_47(256'h00FF00FF000000FFFF0000000000FFFF00FF0000000000FF0000000000000000),
    .INIT_48(256'hFF0000FFFF000000FF000000000000000000FFFF000000000000000000000000),
    .INIT_49(256'h0000000000000000FF0000000000000000000000000000000000000000000000),
    .INIT_4A(256'h000000000000FF00000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h000000FF00FFFF00000000FF000000FF00000000000000000000000000000000),
    .INIT_4C(256'h00FF0000000000000000FF0000000000000000000000000000FF0000FF000000),
    .INIT_4D(256'h000000FF000000FF000000000000FFFF00FF0000000000000000000000000000),
    .INIT_4E(256'h0000000000000000FF000000000000FF0000000000000000000000FF000000FF),
    .INIT_4F(256'h000000FFFF0000FF0000FF00000000000000000000000000000000FF00000000),
    .INIT_50(256'h000000000000FFFF00FF000000000000000000000000000000FF00FF0000FF00),
    .INIT_51(256'h0000FFFFFFFFFFFF00FF0000FF00FFFF00FFFFFF00FFFFFF0000FFFFFFFFFFFF),
    .INIT_52(256'h00FFFF000000FF00FFFF0000FFFF0000FF00FFFF00FFFFFF0000FF0000000000),
    .INIT_53(256'h00FF00000000FF00FF000000FFFFFFFF00FF00FF00FFFF00FFFF00FF000000FF),
    .INIT_54(256'h000000FFFF00FF00FFFFFF0000FFFF00FF00FFFF000000FFFFFF00FFFF0000FF),
    .INIT_55(256'h0000FFFFFF0000FFFF00FE00FFFFFFFFFFFF000000FF0000FFFFFFFFFFFFFFFF),
    .INIT_56(256'hFFFF01FF00FFFF00000000FFFF0000FF0000FFFFFF00FFFF0000FFFFFF00FF00),
    .INIT_57(256'hFF00FF0000FF00FF00000000FFFF00FFFF00FFFF000000000000FFFFFF000000),
    .INIT_58(256'hFFFF00FF00FFFF00FFFF000000FFFF000000FF0000FFFFFFFF00FFFFFF00FFFF),
    .INIT_59(256'hFFFF00000000FF00FF0000000000FFFF00FF0000FFFFFFFF00FFFF0000000000),
    .INIT_5A(256'hFFFF0000000000000000FFFF0000FF00FF000000FF0000FFFFFF00FF0000FFFF),
    .INIT_5B(256'hFFFF00FFFF00FFFF0000FFFFFF0000FF00FFFFFF00FFFF0000FF00FFFF000000),
    .INIT_5C(256'h0000FFFFFF00FFFF00FF00FF00FFFFFF0000FF000000000000FF00FFFF000000),
    .INIT_5D(256'h0101010100010001010100000001010101010101010001000001010001010000),
    .INIT_5E(256'h0001000101010101010000010101010101010101010100000001010100000100),
    .INIT_5F(256'h000000000000FFFF000000FFFF0000000000FF0000000000FF0000FFFF000000),
    .INIT_60(256'h000000FFFF00FF0000000000FF00000000FF0000FF00000000FF00FF00000000),
    .INIT_61(256'h00FF00FF00FF0000000000000000000000000000FF000000000000FF00FF0000),
    .INIT_62(256'h00000000FF00FF000000FF000000000000000000FF00FFFF00000000FF000000),
    .INIT_63(256'h000000FF0000000000FF0000FF00FF0000FF000000FF0000000000FF00000000),
    .INIT_64(256'h00000000FF0000FF00FF000000FFFF00FF0000FF000000FFFF000000FFFF0000),
    .INIT_65(256'hFFFF0000000000000000FF00FFFF00FF00000000FF0000FFFFFF000000000000),
    .INIT_66(256'h00000000FF0000FF00000000000000000000000000000000FFFF0000000000FF),
    .INIT_67(256'h000000FF0000000000FF0000000000000000000000FF00FF0000000000000000),
    .INIT_68(256'h00FF00FF000000000000FF00FF0000FF000000000000FF0000000000FF000000),
    .INIT_69(256'hFFFF0000FF0000000000FFFF0000FF000000FFFF00FF00000000FF0000000000),
    .INIT_6A(256'hFF00FFFFFF000000000000000000000000FF00FF00FFFF00FF000000000000FF),
    .INIT_6B(256'h00FF000000000000FFFFFFFFFF0000FFFF00FFFFFF00FF00FFFF000000FF0000),
    .INIT_6C(256'hFF00FFFF00FFFFFFFFFFFF0000FF00FFFF000000000000FFFFFF00FFFFFF0000),
    .INIT_6D(256'hFFFFFFFF00FF0000FF0000FFFFFF00FEFFFFFFFFFF0000FFFFFFFF000000FF00),
    .INIT_6E(256'h00FF000000FFFF0000FFFFFF0000FFFF00FFFF00FF0000FF00FF0000FFFFFF00),
    .INIT_6F(256'h00FF0000000000FFFF00FF00FF0000FF00FF000000FF000000FF00FFFF00FFFF),
    .INIT_70(256'h00FFFFFFFF00000000FF0000FFFFFF00FF0000000000FFFFFF00FFFF00FF0000),
    .INIT_71(256'hFFFF0000FFFD000000FFFF00FFFFFF00FF000000FF0000FFFFFF00FFFF00FF00),
    .INIT_72(256'hFFFF0000FF0000FFFFFFFF00FF00FF0000FFFF00FF000000FFFFFF0000FF0000),
    .INIT_73(256'hFFFF00FFFF00FFFFFFFFFF00000000FF00FFFFFFFFFFFF00000000FF00FF0000),
    .INIT_74(256'h00FF00FF00FF00FFFF00FF00000000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFF00),
    .INIT_75(256'hFFFF00FFFF000000FFFFFF0000000000FF00FFFFFF0000000000FFFFFFFF00FF),
    .INIT_76(256'h00FFFFFF000000FFFF00000000FFFFFFFFFF00FF0000FFFFFF0000FFFF00FFFF),
    .INIT_77(256'h0001010101010001000101010101000101010000000101000101000000000101),
    .INIT_78(256'h0001010100000101010100000001010001000101010100000101000000010001),
    .INIT_79(256'h0101010101000100000000010101010000010100010101010000010101010000),
    .INIT_7A(256'h0101010101000101010000010100000001010101010101010101010001010000),
    .INIT_7B(256'h0000010001010001010001010100000100000001010100000001000001010100),
    .INIT_7C(256'h0100010001000100000001010101010100010100010100010100010101000000),
    .INIT_7D(256'h0101000001010101000000010100000101010001010101000101000001010101),
    .INIT_7E(256'h0101000100000001000000010100010101010001000101010001000001010100),
    .INIT_7F(256'h0101010101010101000000010000000001010001000001010100010001010001),
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
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,dina[7:0]}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,dina[8]}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:8],\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 }),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:1],\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 }),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_2 ),
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
module Bias_Bram0_blk_mem_gen_prim_wrapper_init__parameterized16
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ,
    clka,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_2 ,
    ena,
    addra,
    dina,
    wea);
  output [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  input clka;
  input \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_2 ;
  input ena;
  input [11:0]addra;
  input [8:0]dina;
  input [0:0]wea;

  wire [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_2 ;
  wire [11:0]addra;
  wire clka;
  wire [8:0]dina;
  wire ena;
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
    .INITP_00(256'hDD36B0B7154F244394DF98D70000000000000000000000000000000000000000),
    .INITP_01(256'hD8D99358E7BAE7F4FEB4F92F007E74E1C6ABAF722EFFA97774C64F314DFE2A47),
    .INITP_02(256'h00000000000000000000000000000000000000006E9EF071F342FD6B11AD3A87),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h6895EE29BBAA86E27AFFD774A522CD92DA8FE370000000000000000000000000),
    .INITP_06(256'hFCA20EFF0AB7E0CF06987D783E1DB4D18B0587F8ED3EEF6A0579AEC85EA4BC63),
    .INITP_07(256'hE873F20255F52C91980173692A0EBE026BB8EA92503A77F1E1E3170FA5E184F2),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h7291C3AFD25978B78FD9B2060000000000000000000000000000000000000000),
    .INITP_0B(256'h0B4BD428FBA31894437A446EBF345337636C5F7BA5EAB0F9242BE2D426CF526E),
    .INITP_0C(256'hB77BA254D7696EC9F4673BBFFD4A3E33C2B8E4F5174EC678E5092BB9FA4A975A),
    .INITP_0D(256'h27B8817F9CB731B607467BF99E28A7D8E1BBEED556CD7121F69DEBABEB4DBD7A),
    .INITP_0E(256'hB6EFBADF7B5BA681CA6DB8DDBEF4BD6BB398E558FF7B1F9B0C0D3A1DEB931AD1),
    .INITP_0F(256'h5DFDFFF4FFDD3FB6FFDF7EB77CFCDFDC000000000000000000000000C7A9CE8B),
    .INIT_00(256'h0101010101000000010001010100010101000100010001010000010101010101),
    .INIT_01(256'h0100000001000001000100000100010100010101010100000101010100000001),
    .INIT_02(256'h0100000000010001000101000001000100010101000000000001010101000101),
    .INIT_03(256'h0001010100010101010001000001010101010100010101010100000100000101),
    .INIT_04(256'h0101010101000001000100010000010101000100010101010101010100000101),
    .INIT_05(256'hFF0000FF00FF0000FFFF00FFFFFFFFFFFF0000FFFF000000FFFF00FF00FFFFFF),
    .INIT_06(256'h000000FF00FF00FF00FF0000FFFFFFFF0000FF0000FF000000FF00000000FFFF),
    .INIT_07(256'hFFFF00FFFFFF00FF0000FFFF00FFFF00FF00FFFF00000000FF00FFFF00FFFFFF),
    .INIT_08(256'h00FF0000FFFF00FFFFFFFFFFFFFFFF000000FF00FF00FF0000FF000000FFFFFF),
    .INIT_09(256'h00FFFFFF00FF0000FFFF000000FFFF0000FF0000FFFFFFFF0000FFFF000000FF),
    .INIT_0A(256'h0000FF00FFFFFF00FFFFFFFFFFFFFFFFFF00FF00FF0000FF00FFFFFF00FFFFFF),
    .INIT_0B(256'hFFFF000000FFFF00FF00FF00FF00FFFFFF00FF00FFFFFFFF00FFFFFF0000FF00),
    .INIT_0C(256'h000000000000000000FFFFFFFFFFFF0000FFFFFF00FF0000FFFFFF00000000FF),
    .INIT_0D(256'hFFFFFFFFFFFFFF00FF00FFFF00FF0000FFFFFFFFFF0000FF0000FF00FFFFFFFF),
    .INIT_0E(256'hFFFFFF0000FFFFFFFF00FFFFFF00FF00FFFFFF0000FFFFFFFFFFFFFF00FF0000),
    .INIT_0F(256'hFFFF00FFFF000000FFFF00FFFF0000FFFF0000FF0000FFFF00FF00FFFF000000),
    .INIT_10(256'h000000FF000000FFFF00FF00FFFF00FF0000FFFFFF00FF00FF00000000FFFFFF),
    .INIT_11(256'hFFFFFFFF0000FFFF00FF00000000FF00FFFFFFFFFFFF00FF00FFFF00FF00FFFF),
    .INIT_12(256'h00FFFF00FFFFFF00FF0000FFFFFFFF00FFFFFFFF0000000000FFFFFF000000FF),
    .INIT_13(256'h0101010101010101010101010101010100010001010101010101010101010101),
    .INIT_14(256'h0101010101010101010101010101000101010101010101010101010101010101),
    .INIT_15(256'h0101010101010101010100010000010100010100010101010101010101010101),
    .INIT_16(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_17(256'h0101010101010101010101010101010101010101010101010101010001010101),
    .INIT_18(256'h0101010101010101010101010001010101010101010101010101010101010101),
    .INIT_19(256'h0101010101010101010101010101000101010100010101010101010101010101),
    .INIT_1A(256'h0101010101010101010101000101010100010101010101010101010001000101),
    .INIT_1B(256'h0101010101010101010101010101010001010001010101010101010101010101),
    .INIT_1C(256'h0101010001010101010001010101010101010101010101010101010101010101),
    .INIT_1D(256'h0101010101010100010101010101010101010101010101010101010101010101),
    .INIT_1E(256'h0001010101010101010101010001010100010101010101010101010101010101),
    .INIT_1F(256'h0101010100000000010000000101010000010101010101010101010001000101),
    .INIT_20(256'h0101010001000000010000000000010101000101010001000000010001000100),
    .INIT_21(256'h0100000100000000010101000100000000010000000101010001010001000100),
    .INIT_22(256'h0101010100010100010101000000010201010100000101010101000000000101),
    .INIT_23(256'h0101010100000001010100000100010100010101000001010101010000010100),
    .INIT_24(256'h0000000100000000010101000001000100010100000001000100000101010101),
    .INIT_25(256'h0100000100010101010100000000000001010101000101010100010101010001),
    .INIT_26(256'h0101010100000101000100010100000000010000010101010000000001010100),
    .INIT_27(256'h0101000000010000000100000101000001010101010101010001010000000101),
    .INIT_28(256'h0001000000000100000000000001010100000100000000000001010101010000),
    .INIT_29(256'h0001000101010000010101010100010001010100010100010001000100010000),
    .INIT_2A(256'h0101000000010100010100000000000100010001000100010100010000010001),
    .INIT_2B(256'hFFFF00FFFF00FF00FF000000FFFFFFFFFFFFFF000000FFFF00FFFFFF00000000),
    .INIT_2C(256'hFF00FF0000FF00FF0000FF000000FF00FFFF0000FFFF00FFFF0000FF0000FF00),
    .INIT_2D(256'h00FFFFFFFF00FF00FFFFFFFFFFFFFFFFFFFF00FF00FFFFFF00FFFFFF00FF0000),
    .INIT_2E(256'hFF00FFFFFF00FFFFFF00FF00FF00FF00FF00000000FFFF00FFFFFF000000FF00),
    .INIT_2F(256'h00FFFF00FF000000FF0000FF00FF00FFFFFFFF00FFFFFF000000FF00FF0000FF),
    .INIT_30(256'h00FF00FFFFFFFF00FF00FF0000FF0000FF00FFFFFFFF000000FFFF000000FFFF),
    .INIT_31(256'h0000000000FF00FF00FFFFFFFF0000FFFF00FF00FFFFFF00FFFF0000FF000000),
    .INIT_32(256'hFFFFFF00FFFF00FF0000FFFFFFFFFF00FFFFFF00FFFFFFFF00FFFF00FF00FF00),
    .INIT_33(256'hFF000000FF00FFFF0000000000FF00FFFF00000000FFFFFFFFFFFFFFFF000000),
    .INIT_34(256'h0000FFFFFFFFFF00000000FFFFFF00FFFF00FFFF00FF0000FFFF00FF000000FF),
    .INIT_35(256'h0000000000FFFF00FF0000FFFF00000000FFFFFFFFFF00FF00FFFFFFFF000000),
    .INIT_36(256'h00000000FF00FF00FF00FFFF00FFFFFFFFFFFF0000000000FFFF0000FFFFFFFF),
    .INIT_37(256'hFFFFFFFFFFFF0000FF00FF000000FF0000000000FFFFFF00FFFFFFFFFFFFFFFF),
    .INIT_38(256'hFF00FF0000FF00FFFFFFFF00000000FFFF00000000FF0000FFFFFFFF0000FF00),
    .INIT_39(256'hFFFFFF00000000FFFFFFFF000000FFFF000000FF00FFFFFF00000000FFFFFFFF),
    .INIT_3A(256'h00FF00FF000000000000FFFFFF00FF0000FFFFFF00FFFFFFFFFFFFFF000000FF),
    .INIT_3B(256'h00FFFF00FF00FFFFFF00FFFFFF000000FFFFFF00FF00FF00FF0000FF0000FF00),
    .INIT_3C(256'h0000FF00FF00FF0000000000FFFFFF00FF00FFFFFFFFFF00000000000000FF00),
    .INIT_3D(256'hFF0000FFFF00000000000000000000FF00FFFFFF0000FFFF00FFFF00FF0000FF),
    .INIT_3E(256'h00FF00FF00FF00FFFFFFFFFF00FF00FF0000FF00FFFF0000FF0000FF000000FF),
    .INIT_3F(256'hFFFFFF00FF00000000FFFFFF0000FFFFFFFFFFFF0000FF00000000000000FF00),
    .INIT_40(256'h0101010101010101010100010101010101010100010101010101010101010101),
    .INIT_41(256'h0101010101010101010101010101010001010101010101010101010101010101),
    .INIT_42(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_43(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_44(256'h0101010101010101000101010001010101010101010101010101010101010101),
    .INIT_45(256'h0101010101010101000101010101010101010101010101010101010101010101),
    .INIT_46(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_47(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_48(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_49(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_4A(256'h0101010101010101010101010101010101010101010101000101010101010101),
    .INIT_4B(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_4C(256'h0101010101010101010101010101010101010101010101010101010101000101),
    .INIT_4D(256'h0101010101010101010001010101010101010101010101010101010101010101),
    .INIT_4E(256'h0101010001010101010101010101010101010101010101010100010101010101),
    .INIT_4F(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_50(256'h0101010101010101010101010101010101010101010001010101010100010101),
    .INIT_51(256'h0101010101010001010101010101010101010101010101010101010101010101),
    .INIT_52(256'h0101010001010001000000010001010100010100010101010101010100000101),
    .INIT_53(256'h0100000101010001010001000001010101000100000101010001010100010001),
    .INIT_54(256'h0101010001000001010001010000010001010001000000010100010001010100),
    .INIT_55(256'hFF000000FFFFFFFFFFFF00FFFF0000FFFF00FFFF0000FF000000000000FFFF00),
    .INIT_56(256'hFFFF00FF0000FF0000FF00FFFF0000FF00FFFFFFFF000000FF00FFFF00FFFFFF),
    .INIT_57(256'h00FFFFFF0000FF00FF0000FF000000FFFFFF00000000FFFFFF00FF00FFFFFFFF),
    .INIT_58(256'h0000FF0000FFFF00FFFF0000FFFFFFFF00FF00FF0000FF0000FFFF00FFFFFF00),
    .INIT_59(256'h0000FF0000FF00000000FF00FF00FFFFFFFFFF000000FF00FFFF00FF00FF0000),
    .INIT_5A(256'hFF00FF0000FF00FFFFFFFF00FF00FF00FF00FFFF00000000FFFFFFFFFF0000FF),
    .INIT_5B(256'h00FFFF000000FFFF00FFFF00FFFF000000FF00FFFFFFFFFF00FFFFFFFF00FFFF),
    .INIT_5C(256'hFF00FFFFFFFFFFFF0000FFFF00FF000000FF00FF0000FFFF0000FFFF00FFFFFF),
    .INIT_5D(256'h00FF00000000FFFF00FFFFFFFF00FF0000FF000000FF000000FFFF00FFFFFF00),
    .INIT_5E(256'hFFFFFFFFFF00FFFFFF00FF000000FFFF000000FFFF000000FF0000FF00FF0000),
    .INIT_5F(256'h00000000FF00FFFF00FF0000FF00FFFFFFFF00FF00FF00000000FF00FF000000),
    .INIT_60(256'hFFFFFFFFFF00FF0000FF0000FF00FF00FF0000FF00FFFFFF00FF00FFFF00FF00),
    .INIT_61(256'hFFFFFF0000FF00FF00000000FF0000FF0000FF00FF00FFFFFF00FFFFFF0000FF),
    .INIT_62(256'h000000FF00FFFFFF00FF0000FFFFFF00FFFF000000FFFF0000FFFFFFFF000000),
    .INIT_63(256'hFFFF00000000FF00FF00FFFFFF000000FFFFFF0000FF0000FFFFFFFF00FF00FF),
    .INIT_64(256'hFFFFFFFFFFFF00FF00FF0000FF00FF000000FFFFFFFFFF000000FFFF0000FFFF),
    .INIT_65(256'hFFFFFFFF00FF000000FFFF0000FFFFFF0000FFFFFF00FFFFFF00FFFFFFFFFFFF),
    .INIT_66(256'hFFFF00FF00FFFFFF00FFFF00FF0000FF00FFFF00FFFFFF00FFFF0000FF0000FF),
    .INIT_67(256'hFF00FFFF00FFFFFF00FFFFFFFF00FFFFFF00FF000000FF0000FF00FF00FF0000),
    .INIT_68(256'hFFFFFF00FF00FFFF00FF0000FFFF00FFFF00FFFFFFFF00FF00FFFFFFFF00FF00),
    .INIT_69(256'hFFFFFFFF00FFFF00FF0000FFFFFF00FFFFFFFF00FF00FFFFFF00FF00FF00FFFF),
    .INIT_6A(256'h00FF00FF00FFFF00FFFF0000FFFF00FF00FFFFFF000000FF0000FF00000000FF),
    .INIT_6B(256'hFFFFFF00000000FFFF00FFFFFF00FFFFFFFFFF00FFFFFF00FFFF00FF00FF00FF),
    .INIT_6C(256'hFF0000FFFFFFFF000000FF00FF000000FF00FF0000FFFFFFFFFF00FFFF000000),
    .INIT_6D(256'h0000000000FFFFFF00FF000000FFFF0000FFFFFFFF00FFFFFFFFFFFFFF0000FF),
    .INIT_6E(256'hFF0000FFFFFF0000FF00FFFF00FFFFFF0000FFFF000000FFFF00FFFF00FFFF00),
    .INIT_6F(256'h0000FF0000FFFFFFFF00FFFFFF000000FF000000000000FF00FFFFFFFFFFFFFF),
    .INIT_70(256'hFFFFFF00FF00FFFFFF0000FF0000FFFF000000FFFF00FF00FFFF00FF000000FF),
    .INIT_71(256'h00000000FFFF000000000000FFFF00FF0000FFFFFF00FF00000000FFFFFF00FF),
    .INIT_72(256'hFFFFFFFFFFFFFFFF00FFFFFFFF00FFFF000000FFFFFFFFFFFF0000FFFF00FFFF),
    .INIT_73(256'hFF00FFFF0000FFFFFF0000FFFF000000FFFFFF0000FF00FF00FF00FFFF000000),
    .INIT_74(256'hFF00FFFFFFFFFF00FFFFFFFF00FF0000FF00FFFFFFFF00FF00FFFF00FF00FFFF),
    .INIT_75(256'hFFFF0000FF00FF0000FFFF00FFFF00FFFF00FFFFFF000000FFFF00FFFFFF00FF),
    .INIT_76(256'h00FFFFFFFF00FFFF00FF00FFFF00FFFFFF00FF0000FFFF00FF000000000000FF),
    .INIT_77(256'hFF00FFFF00FFFF00FFFFFF00FFFFFFFFFF00FFFFFF00FF00FFFF00FFFFFFFFFF),
    .INIT_78(256'hFFFF000000FFFFFFFF00FF00FF0000FFFFFF0000FFFFFF00FF000000FF00FFFF),
    .INIT_79(256'h0101000101010100000100010001000101010100010001000101000100010001),
    .INIT_7A(256'h0100000100000001010101010101010001000001010100000001010100010001),
    .INIT_7B(256'h0001000100000101010000000101010000000100010000000000010101010001),
    .INIT_7C(256'h00FFFFFFFFFF0000FFFFFFFFFFFF0000FFFF00FFFFFFFFFFFFFF00FFFFFF0000),
    .INIT_7D(256'hFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFFFF00FF00FFFF00FFFFFF),
    .INIT_7E(256'hFFFFFFFFFFFFFFFFFFFF00FFFFFF00FF0000FFFFFFFFFFFFFF00FFFF00FFFF00),
    .INIT_7F(256'h00FF00FFFFFF00FFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFF00FF0000),
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
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,dina[7:0]}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,dina[8]}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:8],\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 }),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:1],\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 }),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_2 ),
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
module Bias_Bram0_blk_mem_gen_prim_wrapper_init__parameterized17
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ,
    clka,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_2 ,
    ena,
    addra,
    dina,
    wea);
  output [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  input clka;
  input \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_2 ;
  input ena;
  input [11:0]addra;
  input [8:0]dina;
  input [0:0]wea;

  wire [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_2 ;
  wire [11:0]addra;
  wire clka;
  wire [8:0]dina;
  wire ena;
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
    .INITP_00(256'hFF7BE83E3FB79BFB7BEF9177EEEFB6D571BF37DDEF4EDF193ECBAF37FF56BF3D),
    .INITP_01(256'h014C4022048010C45D37FFF5D7FFFFFAEFCFFFEED7DC8C67D83ADF7EBB9BDEFF),
    .INITP_02(256'h50220044A008220C200830004A0610000CD0084108504A040C00F2900D085000),
    .INITP_03(256'h00020080C480601015442802940804410003528ABE8602304400000802112020),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h42E4E3EB66371EFFF1E1CE245ED19E19E094D853000000000000000000000000),
    .INITP_09(256'hB2BF77CF2BF612B834933ECCB6CB29C0ED6F153EA70BBF2C0F96E261C783BA07),
    .INITP_0A(256'hBB7FA481FED13375A3662C9D045D7EB6056EF0DD9383A2F3EEAEE2C655816A8C),
    .INITP_0B(256'hB4EAC5310FBEB959C04D551C589572DFC18F1F16FF1F3724D9CE6A7BA79E364E),
    .INITP_0C(256'h00000000000000008A514971112022B59205AE0FB1D4416EBD74F2A3DC8D2A45),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'hFFFFFFFFFFFFFFFF00FF00FF00FFFF00FF00FFFFFFFFFFFF0000FFFFFFFF00FF),
    .INIT_01(256'h0000FFFFFFFFFF00FFFF0000FF00FFFFFF00FF00FFFFFFFF0000FFFF00FFFFFF),
    .INIT_02(256'hFFFFFF00FFFFFFFF00FF0000FFFFFF00FFFF00FFFFFFFFFF000000FFFF0000FF),
    .INIT_03(256'h00FFFFFF000000FFFF00FFFFFFFFFFFF0000FFFF00FFFFFFFFFF00FFFFFF00FF),
    .INIT_04(256'hFFFFFF00FFFFFF00FFFFFF00FFFFFFFFFF00FFFF00FFFF00FFFF00FF00FF00FF),
    .INIT_05(256'h00FFFFFFFF00FFFFFFFFFF00FFFFFFFFFF0000FF000000FF00FFFFFF00FFFFFF),
    .INIT_06(256'h0000FFFFFFFFFFFFFF00FFFF00FFFFFFFF0000FFFF00FFFFFFFFFFFFFF00FFFF),
    .INIT_07(256'hFFFFFFFFFFFFFFFF00FFFFFFFF00FFFFFFFFFF00FF0000000000FFFFFFFFFF00),
    .INIT_08(256'hFF00FFFFFF00FFFFFF0000FFFF00FFFFFFFF00FFFFFFFF00FFFFFFFFFFFFFFFF),
    .INIT_09(256'hFFFF00FFFF0000000000FFFFFF00FF00FFFF00FFFFFFFFFF00FFFFFFFFFFFF00),
    .INIT_0A(256'hFFFF00FF00FFFFFFFFFF00FFFFFF0000FF000000FFFF000000FFFF0000FFFFFF),
    .INIT_0B(256'hFFFFFF00FFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFF00),
    .INIT_0C(256'hFFFF00FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FF00),
    .INIT_0D(256'h00FF00FFFFFF00FF0000FFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FF00FF),
    .INIT_0E(256'h0000000000FF0000FF00000000000000000000FF00000000FFFF000000FF0000),
    .INIT_0F(256'h00000000000000FF00FF0000FFFF000000FF0000000000000000FF000000FF00),
    .INIT_10(256'h00000000FFFF00FF00000000FF00000000FF00FF000000000000000000000000),
    .INIT_11(256'h00000000FFFF00000000000000000000FFFFFFFF0000FF00FF0000FF00000000),
    .INIT_12(256'h00000000FF00000000FF00FF0000000000FF0000FF00FF000000000000FF0000),
    .INIT_13(256'h00000000FFFF0000FFFF00FF0000000000000000FF00000000FF0000000000FF),
    .INIT_14(256'h00FF0000FF00FF000000000000FFFF00000000FF000000000000000000000000),
    .INIT_15(256'h0000FF000000000000000000FF0000000000FFFF000000000000000000000000),
    .INIT_16(256'hFF00FF000000000000000000FF0000000000FF000000FF0000000000FFFF0000),
    .INIT_17(256'h00FF00FF000000000000FF000000FF00000000000000000000FF000000FF0000),
    .INIT_18(256'h000000000000FF00000000FF000000FF0000FF00000000000000FF0000000000),
    .INIT_19(256'h00FF000000FF00000000000000000000000000000000000000000000FF000000),
    .INIT_1A(256'hFF00FFFFFFFFFF00FF00000000FFFF00000000000000FF000000FFFF00000000),
    .INIT_1B(256'h0000000000000000000000000000FFFF00FF00FF0000FF00FF000000FF00FF00),
    .INIT_1C(256'hFF0000FF00FF000000000000FF0000000000000000FF000000FF0000000000FF),
    .INIT_1D(256'h000000FF00FF00FF00FF000000FF00000000FF00FF000000000000000000FF00),
    .INIT_1E(256'hFFFF000000FF0000FF0000000000000000FFFF0000000000000000FF00000000),
    .INIT_1F(256'h0000000000000000000000000000FF000000000000000000FF00000000000000),
    .INIT_20(256'h0101010101000101000001010001010000010000000000010000010001000101),
    .INIT_21(256'h0001010100010101000101010101010101000000010101010100010100010100),
    .INIT_22(256'h0101000000010001000101010101010001010101000101000101010100010101),
    .INIT_23(256'h0101000000010001010101000000010101010001010100010000000100010101),
    .INIT_24(256'h0100010000000000010001010101010101000100010001000101010101010101),
    .INIT_25(256'h0101000101000100010000010101010101010100000101010100010100010000),
    .INIT_26(256'h0101000000010101010101000000010000000101000000000101000101000100),
    .INIT_27(256'h0000010001000100010100010101010000010000000100000100000101010100),
    .INIT_28(256'h0101010100000100000000010100010001010001010100010000010101000001),
    .INIT_29(256'h0101010001010100000100000101000100010100010100000101000101010100),
    .INIT_2A(256'h0100010101000001010001000000000100010001010100000001000101010000),
    .INIT_2B(256'h0100010100010001000001010100000000000101010100010000000000010001),
    .INIT_2C(256'h0100010101000001000100000101010000010000010001010001010101010101),
    .INIT_2D(256'h0101000101010000010000000101010101000101010000010101010000010001),
    .INIT_2E(256'h0000010000000000010000010101010100010000000001010001010001000101),
    .INIT_2F(256'h0101010000000000010100010000010000010001000100010001000101000000),
    .INIT_30(256'h0101010100000000000000010100000101010100010000010101010001000100),
    .INIT_31(256'h0000000001000001010100000001000100000101000001000100010000000100),
    .INIT_32(256'h0100000001010101010101010101010101000001010001000000010000010101),
    .INIT_33(256'h0101000101000001010101000001010001010100000100000100010000000101),
    .INIT_34(256'h0101010100010101010000010001000001010101000100010001010101010100),
    .INIT_35(256'h0001000101000100000001000101000100010101000001010101000000010001),
    .INIT_36(256'h0101000101000101010000010001010101000101010000010000000001000001),
    .INIT_37(256'h0001000101000000000100010101000101010101010001000100000001000100),
    .INIT_38(256'h0000010101010101000101010101010101010001000100000001000001010101),
    .INIT_39(256'h0101000001000001010100000101010100010001010001000100000100010101),
    .INIT_3A(256'h0001010101010001000100000000000001010101000101000100010000010100),
    .INIT_3B(256'h0000000101010100010100010000010101010001010000010000000101000000),
    .INIT_3C(256'h0100000101010101000101000000000001000100000000010001010100010101),
    .INIT_3D(256'h0001010100010000010101010100010100000101010100010101010101010101),
    .INIT_3E(256'h0100010101000101000101010101010101010101010101000101010100000001),
    .INIT_3F(256'h0000000000010100000101000000000101010100010101010101010100000101),
    .INIT_40(256'h0001010100000100010100010101000000000100000000000001010000010000),
    .INIT_41(256'h0000000001010101010000000001010001000001010001000001010001010101),
    .INIT_42(256'h0101010101010000000101000100000001000001010001000101010101010001),
    .INIT_43(256'hFFFFFF0000000000FF0000FF00FF0000FFFF00FFFF00000000FF00FF0000FFFF),
    .INIT_44(256'h00FF00FFFFFFFF00FFFF00FF000000FFFF0000FFFFFFFF00000000FFFF0000FF),
    .INIT_45(256'hFFFFFFFF000000FFFFFFFF00000000FFFFFF0000FFFFFF000000FF0000FF0000),
    .INIT_46(256'h00FFFF0000FFFF000000FFFF00FFFFFF000000FFFFFFFF00FFFFFFFFFFFFFFFF),
    .INIT_47(256'h00FF00000000FF00FFFFFF0000FF0000FFFFFF000000FFFFFFFFFF00FF00FFFF),
    .INIT_48(256'hFFFF000000FFFFFFFF0000000000FFFFFF00FFFFFF00FF000000000000FFFFFF),
    .INIT_49(256'h00000000FFFFFFFFFF0000FF00FFFF00FFFFFF000000FF0000FFFF00000000FF),
    .INIT_4A(256'hFF00FF0000FFFFFF00000000FF00FFFFFF00FFFFFFFFFFFF0000FF00FFFF0000),
    .INIT_4B(256'hFFFFFF00FFFF00FF00FFFF00FFFFFFFF000000FF00FF00FF0000FFFFFFFFFF00),
    .INIT_4C(256'hFF00FFFF00FFFF00FFFF0000FF00FFFF0000FF00FF0000FFFFFF000000000000),
    .INIT_4D(256'h0000FFFF00FF0000FF0000FF0000FFFF0000FFFFFFFFFF00FFFF0000FFFF0000),
    .INIT_4E(256'h0000FF00FF00FFFFFFFFFFFF00FFFF00000000FF0000FF00FF00FFFFFF000000),
    .INIT_4F(256'hFF00FFFF0000FF00FF00FFFFFFFFFFFF00FFFFFF00FFFFFFFFFF0000FFFFFFFF),
    .INIT_50(256'h00FF00FF00FF00FFFF000000000000FF00FFFF00FF00FF00FF000000FFFF0000),
    .INIT_51(256'hFFFFFF00FFFFFF00FF00FF00FFFFFF00FFFFFF000000FF00FFFF000000FFFF00),
    .INIT_52(256'hFF0000FF0000FFFFFF0000000000FFFFFF00FF000000FF00FFFFFFFF0000FFFF),
    .INIT_53(256'h0000000000FF00FF00FFFF00FFFFFF00FFFFFFFF00000000FFFF00FFFFFF00FF),
    .INIT_54(256'h0000000000FF000000FF00FFFFFF00FF00FFFFFFFFFFFF00FF00FFFF00FFFF00),
    .INIT_55(256'hFF00FF000000FFFF00FFFF0000FFFF000000FF00FFFF0000FF0000FFFFFF00FF),
    .INIT_56(256'hFFFFFFFFFFFFFF00FFFF00FF000000FF0000FFFF0000FFFF00FFFFFF00FF00FF),
    .INIT_57(256'hFF00FFFFFF00FFFF00FFFFFFFFFFFFFFFF00FF0000FF0000FF000000000000FF),
    .INIT_58(256'hFF00FF0000FFFFFFFF0000FFFFFFFF000000FFFF00FFFF0000FF0000FFFFFF00),
    .INIT_59(256'hFFFF00FFFF0000FFFFFF0000FFFFFF0000FFFF00FF00FF0000FFFFFFFF00FFFF),
    .INIT_5A(256'hFFFFFFFFFFFFFFFF000000FFFFFFFFFF0000FFFF00FFFFFF0000FF0000FF0000),
    .INIT_5B(256'hFFFF0000000000FFFF000000FFFFFFFF000000FFFFFFFFFF000000FF00FFFF00),
    .INIT_5C(256'h00FF00FFFF000000FF0000FF00FF00FF00FFFFFF0000FF00FFFF00FFFFFFFFFF),
    .INIT_5D(256'hFFFF00000000000000FF0000FFFF00FF00FF00FF00FF00FF000000FFFFFF0000),
    .INIT_5E(256'h00000000FFFFFFFFFF00FFFFFFFFFF00FF00FFFFFF0000FF00FF00FFFF0000FF),
    .INIT_5F(256'hFF00FFFF00FF0000FFFFFF00FF00FF00FFFF000000FF00FF0000FFFF000000FF),
    .INIT_60(256'hFFFF00FFFFFF0000FF000000FFFF00FF0000FF00FF00FF0000FF000000FF00FF),
    .INIT_61(256'hFF00FFFFFFFF00FF00FFFFFF00FF0000FFFFFFFF0000FF00FF00FF000000FFFF),
    .INIT_62(256'hFF00FFFF000000FFFFFF00FF00FF000000FF0000000000FF00FFFF00FFFFFF00),
    .INIT_63(256'hFF0000FF0000FF000000000000FF00FFFF00FF00FFFFFF0000000000FFFFFFFF),
    .INIT_64(256'h000000FF000000FF0000FF00000000000000FF000000FF00FF00FFFF00FF00FF),
    .INIT_65(256'hFF000000FF00FF0000FF00FF000000FF00FF0000FF0000FF00FFFFFF000000FF),
    .INIT_66(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_67(256'h0101010101010101010101010101010101010101010101010001010101010101),
    .INIT_68(256'h0101010101010101010101010101010100000101010100010101010100010101),
    .INIT_69(256'h0101010100010101010101010101010101010101010101010101010101010001),
    .INIT_6A(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_6B(256'h0100010101010101010101010101010101010101010101010101010101010101),
    .INIT_6C(256'h0101010101000101010001010101010101010101010101010101010101010101),
    .INIT_6D(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_6E(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_6F(256'h0101010100010001010101010101000101010100010101010101010001010101),
    .INIT_70(256'h0101010101010101010100010001010101010101000100010001000101010101),
    .INIT_71(256'h0101010101010001010101010001000101010101010101010101010101010101),
    .INIT_72(256'h0101010101010001010101010101010101010101010101010101010101010101),
    .INIT_73(256'h0101010101010101010101010101010101010101000101010101010001010101),
    .INIT_74(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_75(256'h0101010001010101010101010101010101010101010101010101010101010101),
    .INIT_76(256'h0101010101010101000101010001010101010101010101010101010101010101),
    .INIT_77(256'h0101010101010101010101010101010001010100000001010101010101010101),
    .INIT_78(256'h0100000101010101010101010101010100010101010101010101010101010101),
    .INIT_79(256'h0101010101010101000001010101010101010101010101010100010101010101),
    .INIT_7A(256'h0101010101010101010101010101010101010101000101000101000101010101),
    .INIT_7B(256'h0101010101010100010101010101010101010101010101010101010101010101),
    .INIT_7C(256'h0101010101010101000101010101000101010101010101010101010101000101),
    .INIT_7D(256'h0101010101010101000101010101010101010101010101010100010101010101),
    .INIT_7E(256'h0101010101010101010101010101010101010101010100010101010001000101),
    .INIT_7F(256'h0100010101010101010101010101000101010101010101010101010101010101),
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
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,dina[7:0]}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,dina[8]}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:8],\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 }),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:1],\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 }),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_2 ),
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
module Bias_Bram0_blk_mem_gen_prim_wrapper_init__parameterized18
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ,
    ram_ena,
    clka,
    ena,
    addra,
    dina,
    wea);
  output [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  output ram_ena;
  input clka;
  input ena;
  input [14:0]addra;
  input [8:0]dina;
  input [0:0]wea;

  wire [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  wire [14:0]addra;
  wire clka;
  wire [8:0]dina;
  wire ena;
  wire ram_ena;
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
    .INITP_04(256'hFE7FFBFCBD881220C8716B12D7A8417A734B41B2694B63730000000000000000),
    .INITP_05(256'hFE7FFB7FFBFFFDF3EEFFFBFFFFFCBFFFF7FFDFFFFDFF5AFF3F7E7FDFFDFF5FBE),
    .INITP_06(256'hBFFBE7BFC75CDDFBFFFD9F7DAE6FDFDF7BACFF7E7DE97FFBFDDFDBFDFFFBFAEF),
    .INITP_07(256'hFFFD6FDDFFFFFEFF5FBDFDEF7F7F7F5F9EFDEFFDFF46FE7FFFBEFFFFFFFB3EB9),
    .INITP_08(256'h000000000000000000000000FAFEDDF3FCB57AFDEFF1B9B7DFFAFBFB7FDF6533),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h1E13A3D12C48D30536373688A334C26CC5A4D088000000000000000000000000),
    .INITP_0D(256'hFFFFFFFFBFFFFFFFFFFFFFFFAF85DED9F129A0549FBFC881F98A2ACB71FAB287),
    .INITP_0E(256'hFFFFFFFFFFFFFFFFFFFFFDFFFFFFFFFFFFFFF7FEFFFFFFFF7FFDFFFF7FFFFFFF),
    .INITP_0F(256'hFFFE7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFFEFFFFF),
    .INIT_00(256'h0101010101010101010101010101010100010101010101010101010101010001),
    .INIT_01(256'h0101010101010101010101010101010101010101010101010001010101010101),
    .INIT_02(256'h0101010101010101010101010001010101010100010101010101010101000101),
    .INIT_03(256'h0101010101010101010101010101010001010101010101010101010101010101),
    .INIT_04(256'h0000010001010000000000010100010100010000010101010000000001000000),
    .INIT_05(256'h0000000000010100000001000101000101000000000001000000000000000000),
    .INIT_06(256'h0001010001010001000000010000000000000000010000010001010100000000),
    .INIT_07(256'h0001000000000001000000000101000001000000010101010101000100000000),
    .INIT_08(256'h0000010101000000000000010101000101010000000100000100000100010100),
    .INIT_09(256'h0100010001010101010100000001010000000100010100010000010001010001),
    .INIT_0A(256'h0101000000000001010001010000000000000000000000000100000100010101),
    .INIT_0B(256'h0101010000010001010000010101010000000001010100000001000100010100),
    .INIT_0C(256'h0101000100000001000000000100000101010101010100010100000001010000),
    .INIT_0D(256'h0001010000000000010000000100000101000100010100010100000001000100),
    .INIT_0E(256'h0000000000010100000000000001010100000100000000000000000101000101),
    .INIT_0F(256'h0100000000010001000000010000000000010101000100010001000001000100),
    .INIT_10(256'h0000000100010000000101000001010101010000000000000000000001010100),
    .INIT_11(256'h0000000100000100010001010100000001000001000000010000000000000101),
    .INIT_12(256'h0000010100010000010101000000000000010101000000000001000000010000),
    .INIT_13(256'h0101000001010100000101000100010100010000010000010001010100010100),
    .INIT_14(256'h0000000100010001000000010001010100010000010100010000010000010001),
    .INIT_15(256'h0000000000000101000101000001000000000100010000000100010000010000),
    .INIT_16(256'h0100000100010100010000000001000000000001010000000000000100010000),
    .INIT_17(256'h0000000000000000000001000100000000000000000101010000000001010100),
    .INIT_18(256'h0001010000000101000001000000010100000000000001000000000000000001),
    .INIT_19(256'h0100000101000100010001010100000001000001000001000001000001000001),
    .INIT_1A(256'h0000000100000000000000010101000000000001010101000100010100000100),
    .INIT_1B(256'h0100000001010001000000010000010100000001000100000000010001000000),
    .INIT_1C(256'h0000000000000100010100010100000001000101000100000000000001000001),
    .INIT_1D(256'h0100000000000100000100010101000000000100000000000100010000010100),
    .INIT_1E(256'h0101000000000100010001000101000100000000010100000001010001010000),
    .INIT_1F(256'h0000000000010100000101010001010000010000000000000000000000010100),
    .INIT_20(256'h0000000100000000000000000000000000010100010000000100010001000000),
    .INIT_21(256'h0001000000000001000001000100000000010001000101000001000000000101),
    .INIT_22(256'h00FFFF00FF0000FF00FF0000FF00FFFF00FFFF000000FFFF00FFFFFF0000FFFF),
    .INIT_23(256'h00FFFFFF0000FFFF00FF0000FF00FFFF00FF0000000000FFFF00FFFF0000FF00),
    .INIT_24(256'hFFFF00FF00FFFFFFFF00FF00FF00000000FF0000000000FF00FFFFFFFF00FF00),
    .INIT_25(256'hFFFF0000FF00000000FFFFFF000000FF00FFFF00FF00FFFF000000FF0000FF00),
    .INIT_26(256'hFF00FFFFFFFF00FFFF000000FF000000000000FF0000FF000000FF0000000000),
    .INIT_27(256'hFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFF0000),
    .INIT_28(256'hFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFF00FF00FFFFFFFFFFFF00FFFFFFFFFF00),
    .INIT_29(256'h0000FFFFFFFFFFFF00FFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFF00FFFFFFFFFF),
    .INIT_2A(256'hFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFF00FF00FFFF00FF00FFFFFFFFFFFFFFFF),
    .INIT_2B(256'hFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_2C(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_2D(256'hFFFFFF00FFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF),
    .INIT_2E(256'hFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFF0000FFFF),
    .INIT_2F(256'hFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFF00FFFF00FFFFFFFFFFFFFF),
    .INIT_30(256'hFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFF00FF00FFFFFF00FFFFFFFF),
    .INIT_31(256'hFFFFFFFFFFFF00FFFFFF00FFFFFFFFFFFFFF00FFFF00FFFFFFFFFFFFFFFF00FF),
    .INIT_32(256'h00FFFFFFFFFF00FFFFFFFF00FF0000FF00FFFFFFFFFFFFFFFFFFFFFFFF00FFFF),
    .INIT_33(256'h00FFFFFFFF00FFFFFF00FF00FFFF0000FFFFFFFFFFFFFFFF00FFFFFFFFFFFF00),
    .INIT_34(256'hFF00FF00FFFFFF0000FFFF00FFFFFFFFFFFF00FFFFFFFFFFFFFF00FFFFFFFFFF),
    .INIT_35(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF0000FFFFFFFFFF00FFFFFFFFFF00FF),
    .INIT_36(256'hFFFF000000FFFFFF00FF00FFFFFF0000FFFF00FFFFFF00FFFFFFFFFFFF00FFFF),
    .INIT_37(256'hFF00FFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFF0000FFFFFFFF00FFFFFFFFFFFF),
    .INIT_38(256'hFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF0000FFFFFFFFFF00FF00FFFFFF0000FF),
    .INIT_39(256'hFFFFFFFFFFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_3A(256'hFFFFFFFFFFFFFFFF00FF000000FFFF00FFFFFFFFFFFFFF0000FFFFFFFFFFFFFF),
    .INIT_3B(256'hFF0000FFFFFFFF00FFFFFFFFFFFF00FFFFFFFF00FFFFFFFFFFFFFFFFFFFF00FF),
    .INIT_3C(256'h00FFFFFFFFFFFFFF00FFFFFFFFFFFFFF00FFFFFFFFFFFFFF00FF00FFFFFFFFFF),
    .INIT_3D(256'h00FF00FFFFFFFFFFFF00FFFFFFFF00FFFFFFFFFFFFFF00FFFFFFFF00FFFFFFFF),
    .INIT_3E(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFF),
    .INIT_3F(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FF00FFFF00FFFFFFFFFFFF00FFFFFF00FF),
    .INIT_40(256'h00FFFFFFFFFFFFFFFFFF00FFFFFFFFFF00FFFF0000FF00FF0000FFFF0000FFFF),
    .INIT_41(256'hFFFF00FFFFFFFFFFFFFFFFFFFF00FF00FFFFFFFFFF00FFFFFFFFFFFFFF00FFFF),
    .INIT_42(256'hFFFFFF00FFFFFFFFFFFFFFFF000000FFFF00FFFFFF0000FFFF00FFFF00FFFFFF),
    .INIT_43(256'hFFFFFFFFFFFF0000FF00FFFF00FF00FF00FFFFFFFF00FF00FFFFFFFFFFFF00FF),
    .INIT_44(256'hFFFFFFFFFF00FF00FFFFFFFFFFFFFF00FFFF00FFFFFF00FFFFFFFFFF0000FFFF),
    .INIT_45(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_46(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_47(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_48(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_49(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_4A(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_4B(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_4C(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_4D(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_4E(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_4F(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_50(256'h0101010101010101010101010100010101010101010101010101010101010101),
    .INIT_51(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_52(256'h0101010101010001010101010101010101010101010101010101010101010101),
    .INIT_53(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_54(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_55(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_56(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_57(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_58(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_59(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_5A(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_5B(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_5C(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_5D(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_5E(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_5F(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_60(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_61(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_62(256'h0101010101010101010101010101010101010101010101010101010101010101),
    .INIT_63(256'hFFFF000000FF00FFFF00FF0000FF0000FFFF00FF00000000FF000000FF000000),
    .INIT_64(256'hFF00FF000000FFFF0000FFFF00FF0000FFFF00000000FF0000FFFF00FFFF0000),
    .INIT_65(256'h0000FFFF00FFFF000000FFFF00FFFFFF0000FFFF00FFFF00FF000000FF000000),
    .INIT_66(256'h0000FF00FFFF000000FF0000FF000000FFFF00FF0000FFFF0000000000FF00FF),
    .INIT_67(256'h000000FFFFFFFF00000000FF0000FFFFFF00FF000000FFFFFFFF00FF000000FF),
    .INIT_68(256'h00FFFFFF000000FFFFFFFFFFFF00FF00FF00FFFF0000FF00FF00000000FFFFFF),
    .INIT_69(256'hFFFFFFFFFF0000FFFF000000FF00FF000000FF00FF00FF00FFFF0000FF00FFFF),
    .INIT_6A(256'hFF0000FFFFFFFFFFFF00FFFFFFFFFFFFFFFF0000FF000000FF000000000000FF),
    .INIT_6B(256'hFFFFFFFF000000FF0000FF00FF0000FFFF00FF000000000000FF00FF00FF0000),
    .INIT_6C(256'hFF00FF00FFFFFFFFFF00000000FF00FFFFFF00FFFFFFFF00FFFF00FFFF0000FF),
    .INIT_6D(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_6E(256'hFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_6F(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_70(256'h00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_71(256'h00FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_72(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_73(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF00),
    .INIT_74(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_75(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFF),
    .INIT_76(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_77(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_78(256'hFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_79(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF),
    .INIT_7A(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_7B(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_7C(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_7D(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_7E(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
    .INIT_7F(256'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF),
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
       (.ADDRARDADDR({1'b1,addra[11:0],1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,dina[7:0]}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,dina[8]}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:8],\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 }),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:1],\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 }),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ram_ena),
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
  LUT4 #(
    .INIT(16'h0080)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_i_1__2 
       (.I0(addra[12]),
        .I1(addra[13]),
        .I2(ena),
        .I3(addra[14]),
        .O(ram_ena));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module Bias_Bram0_blk_mem_gen_prim_wrapper_init__parameterized2
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 ,
    ena_0,
    clka,
    ena,
    addra,
    dina,
    wea);
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 ;
  output ena_0;
  input clka;
  input ena;
  input [14:0]addra;
  input [0:0]dina;
  input [0:0]wea;

  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 ;
  wire [14:0]addra;
  wire clka;
  wire [0:0]dina;
  wire ena;
  wire ena_0;
  wire [0:0]wea;
  wire [15:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOADO_UNCONNECTED ;
  wire [15:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOBDO_UNCONNECTED ;
  wire [1:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOPADOP_UNCONNECTED ;
  wire [1:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOPBDOP_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB18E1 #(
    .DOA_REG(1),
    .DOB_REG(0),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h2F01B040F32FBFADF768169272D2B35C8C56AE2511FF2040AEF72669FCB40F43),
    .INIT_01(256'h418C393C56712778A4E04DC643E77AE784AA6BAC5FE5BA650E33CD210D768691),
    .INIT_02(256'h2AA0D4503719F2776EDF0B53CF344FF325D3732A875B3BA763BF3CF77229D692),
    .INIT_03(256'h8FD3D797A4AF4E986B005D848EB7EF969729AC24170B8F8E21DD2B900EE6D79A),
    .INIT_04(256'hA552260C5F9AE8AAF7490FE5F1BB6E4E1C216D7C8273AD6404AD77AE6F554D4A),
    .INIT_05(256'h7DF1F533F43AC14B7B1727DB1A2404EAFF5167E6E4635E82AD78ACF672F19088),
    .INIT_06(256'hEDD31128BCEDC3B7DF1EF687FA88CA6560CDFE1EDF7ADA5C13A7F6C0771FC6BD),
    .INIT_07(256'h1C0D4B455D9C55F9F2EC38841C03FF93A136830A063F22534691A6402C2D8BBB),
    .INIT_08(256'h3E4CA2BD532932EAEB5213F938E70D29716368E6EDE4430443C42DE7DA09C974),
    .INIT_09(256'hD2219E47F648B671ECA7569E4C0C0CD3904911A9B54D7FC6B053996C284B4676),
    .INIT_0A(256'h7B7DA2DF953D850B6231D7D6356836FB0DC8AB834B028970E00BE8944CB25A3B),
    .INIT_0B(256'hCEC48B5A6C10DB320411C36DFFD4F30DA09A37FDAC4631E1FBE6A8558C1A4448),
    .INIT_0C(256'h92B097D9AC7E3A78CA06246E782975BBC7747C8DC2047EE6DC82034DE5E98964),
    .INIT_0D(256'hE6947F052FDD57882D2B4DDB6ABAFD80FFD1F9BB9CC6837799A496523DA11A4C),
    .INIT_0E(256'h34DF77B6E465AFBC1211CF3ADDF48053B68E6B1F377B1357AB4184E6E79A5AC0),
    .INIT_0F(256'h5F3F4297A12365189C34427A12F829C4C3A8AA9902BE9290F669595C055BC9FD),
    .INIT_10(256'h67B2082DC13E5E099489CB8ED785DF161B36F1B11338FB743D8F1ADBF7DA90C3),
    .INIT_11(256'h0AD455B24C13BFF1926993D80504045A3DADA0FF998A4B6A35963AA10AFDBF23),
    .INIT_12(256'h58C67C52C1CCC3D2AE0EEA630C61EA893773F7F0F684DE662D4B4E44937CF804),
    .INIT_13(256'hBF3A9B1EC441C1BC1BB3D6C76FC6ADE40B45CCD263BC508C7222C155945A64ED),
    .INIT_14(256'h96448A7671BDCF0635FB20DAB3832157A344FB3FF9A7751A8175BD345420358B),
    .INIT_15(256'hB7264906AAA797ED71C4604928C9C520037936896720451703B1719DF9696231),
    .INIT_16(256'hCB6FF61ADF2E55021FD5212C18C14A974A87A4135A0BE274E2085D6F551357E6),
    .INIT_17(256'h9B3C88A9BC9A5543E35F91839DC9C764D75175F30D6653EB74519D332578D822),
    .INIT_18(256'hAABFBE3F5DE367C155EC73A91ED3241DD263BBD1CB3B882DFA358834CFF0C531),
    .INIT_19(256'hCCD20EEAF90235FF50C99036B263DA044BC4172D4CD09A29F4BB4F00EECB51E8),
    .INIT_1A(256'h67A6ED645BDEA6A2527F9986D63080D9471993BB214D16A2745BBC76050D6365),
    .INIT_1B(256'hE88A6A532351F78302D25B5864AF8918E801510439D461A21DBD284512B6BAF0),
    .INIT_1C(256'h968C2051B87F08D7D4ADA2E7AB6598D3F6FA20FA6E9B2DC5360784B809AC9D2B),
    .INIT_1D(256'h15353800F3F33D486EF809E039B939D90389E79FDDB3F7BBD4F4F770A0EFB06B),
    .INIT_1E(256'h92FB493EC650BA2E42BBDD0FC23356F6CF93C21A540247426E1D0A964441A30A),
    .INIT_1F(256'h65DF376949B0D91E12EF0A3B236A6132615650DCB5D178867F3A96E61CBB97DA),
    .INIT_20(256'h83F8EAF6D3E64CF966606B37FFF49E61AC03147C0D26C25413DE702CCA8B66AA),
    .INIT_21(256'h87622E3730D4908E1933FCB4FDBFF7ECE77E2CC59DEE8A04CF3CF20DF9352477),
    .INIT_22(256'h851C07BD6CE723F8D842BDFE9C23AFDE046926B8AF54C2008656FDC2F1782A5D),
    .INIT_23(256'hC01F6174CBC963B243AA1BEFAEBB07EE986E61A0DDDCAD7CF0C48BB19F992373),
    .INIT_24(256'hF055C16E3FB15F78E92B971E4DF3FE5B51471897A54140C8A1BAF16BDA69E177),
    .INIT_25(256'h086FB4D0B7F25530BE2FD6347C2A3286DD27AD7ADB3992D53AFB5434615F419C),
    .INIT_26(256'hA62EC782FF56B8879C2052D2B9E5758C5F9FC97B9201D7E9AA7E54164F580C21),
    .INIT_27(256'h506EB1A51D25DC8F91428216D939D75EAAD71FE79BDB86C928B08525D52E06B1),
    .INIT_28(256'h7DBAEDD20D8293B7F7A33ACD6245745193A560F33FD1910F080E1822E624BE31),
    .INIT_29(256'h2A0E4DCB6BA265E8062A352F7E3B423D6B78F1581706656062A67227B6218F05),
    .INIT_2A(256'h707C7B3932E478CC2A660AC847AB54F9090123DDEE2F367F3B0262B905CAF206),
    .INIT_2B(256'hCBD8845DC73C1E13914E76A18AA122064F2CDA611B7DEF305645DD0B83F2BC90),
    .INIT_2C(256'h5FBE9F0487D91F02C425981CD78E7977371928A9E626ADBF6B95D44E4C49B1F1),
    .INIT_2D(256'hA4498E7046E1180E97DCF3E39877D87AFB67A840A928DE84BD4E3E3D25DDE634),
    .INIT_2E(256'h0C142B2AE7A45A03AA049726657ED24A7C043750E4EA4F3E2DFBA93A03877727),
    .INIT_2F(256'h72ED09C1C6708FBB4F1427578D06403B4DE3586B8350A42C3BB23BA1C18883D7),
    .INIT_30(256'h7825188C4A8CC754649D64A08C5A24D9C58A5FFB46D3F000AAA75024AE9E90E4),
    .INIT_31(256'h804A77F4B34800FF0ACF89CBA21D4BD65C6F5DD3C7FF049C5715988B17663C36),
    .INIT_32(256'hE4225AEAFEF36297E02D70D239DA76F02C2BAEB57D044CA2222AFDFCE04B9CB3),
    .INIT_33(256'hF81FF2E1211B52C8B3D6705204EEA650426019A5EE22FEFE5E638B345AA90801),
    .INIT_34(256'hEED1036F7D4F39EB2D80D16C96DC3F819C2D66D9505939A76ECA101795621276),
    .INIT_35(256'h9C41F467CAA0558547DCBE40AA4CA061BEBED00EF39F77DEFDBB00E6E8C0FD9F),
    .INIT_36(256'h8ADFAE643E433864E1D5D9B7D5FFFC2DDD4E0CBE01375C2D0167CBBFCA77668F),
    .INIT_37(256'hDD7750512F9D5904BB625D69C6DC8C03526FC9B6707A3B7BD8FA5907888ACA5E),
    .INIT_38(256'hE829E5850435D687DEA4337680443FC4BC538B239C8435A0487F58899EA32F8A),
    .INIT_39(256'h6A7C0FED7E2C12E6C90ED2DDF6FF54DF9B4225AAB2D72852D2CAD471A94C8E9F),
    .INIT_3A(256'hAEBC51933D868C4218183496414A1BC03204586564AB8DD807CDA865B6F66C70),
    .INIT_3B(256'h655CF6F7ACEB34DE4A303B8E65BCD80CD5A82D06A9C46370A62F5A0341D33A6D),
    .INIT_3C(256'h024415DB84BF75D90E5EC90CAC3EB41058B01F8A5E5D5D3325E7401885E17AF2),
    .INIT_3D(256'hA6C956099D029C646D5F54165F1C21331AD2311335CE824E72684899779B4B0C),
    .INIT_3E(256'h08EFF3CF4EF21F24A6786001639978B0B2BA3CA9241EA5946FD2F4E72C62B549),
    .INIT_3F(256'hFF7E335148C8A7193BFF6EA008251D2645C1997AF0FE54B70920D5504BCCE87F),
    .INIT_A(18'h00000),
    .INIT_B(18'h00000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(1),
    .READ_WIDTH_B(1),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(18'h00000),
    .SRVAL_B(18'h00000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(1),
    .WRITE_WIDTH_B(1)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram 
       (.ADDRARDADDR(addra[13:0]),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,dina}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOADO_UNCONNECTED [15:1],\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 }),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOBDO_UNCONNECTED [15:0]),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOPADOP_UNCONNECTED [1:0]),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOPBDOP_UNCONNECTED [1:0]),
        .ENARDEN(ena_0),
        .ENBWREN(1'b0),
        .REGCEAREGCE(ena),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .WEA({wea,wea}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0}));
  LUT2 #(
    .INIT(4'h2)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_i_1 
       (.I0(ena),
        .I1(addra[14]),
        .O(ena_0));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module Bias_Bram0_blk_mem_gen_prim_wrapper_init__parameterized3
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 ,
    clka,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_1 ,
    ena,
    addra,
    dina,
    wea);
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 ;
  input clka;
  input \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_1 ;
  input ena;
  input [13:0]addra;
  input [0:0]dina;
  input [0:0]wea;

  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_1 ;
  wire [13:0]addra;
  wire clka;
  wire [0:0]dina;
  wire ena;
  wire [0:0]wea;
  wire [15:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOADO_UNCONNECTED ;
  wire [15:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOBDO_UNCONNECTED ;
  wire [1:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOPADOP_UNCONNECTED ;
  wire [1:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOPBDOP_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB18E1 #(
    .DOA_REG(1),
    .DOB_REG(0),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h3D244CD0E75764046A51168EDFCD373D58618C3C9F1A23C2C4BBD79D149BC431),
    .INIT_01(256'h8BC16B42B3D216AA1AA6C1140F0D63A0DFBDA4A7862CBD0D00675019CC610F30),
    .INIT_02(256'h16FE34EE76D835AB95E1BAFC93DF972A7119080AECD332D3B3C32D77DBE9FEA2),
    .INIT_03(256'h1B7ADF1A9B23E212182638CAEF34A7BBF6426DBED13DEF751C834EF94F437BB6),
    .INIT_04(256'h95F62DBDCBC7992F49457097FE2BBF40A4F37B5A45C82351080650E7A953B6A6),
    .INIT_05(256'h2E58D4EAFB56DC863915C76E7034B9CD606DB8AC47E021D6306F785A3163E6A7),
    .INIT_06(256'hBFACBE10A1D30EEDE589515E56A2CD7A47D7DD8CC719ACFB0F410F5BBB70685A),
    .INIT_07(256'hA5C6869E80C0CD87AEC88D889A3A98471D7EE8C247FA066097BB3C60BCFD3951),
    .INIT_08(256'h317496C699999D8B1545A6781F27B099348C4E40D15EC60DB2FF63D7897D7676),
    .INIT_09(256'hDCA4952370D7EDDCC2EECEDFD067268372E78FF07BB83D8AEC7D961AF4CB5C77),
    .INIT_0A(256'h64ECEE8D9CD6AC0A28584DB8DF76C889A6B2C1EF672E95027B9CF60844E953F3),
    .INIT_0B(256'hBDAFDB3007B64F01033F0ED0743019194F7FF2BC4E72C7DAFD5D05144386378F),
    .INIT_0C(256'hBA439189A92D60CE670D21B3FA1EB67FCE84ABBF92D582607D9A3595264F4385),
    .INIT_0D(256'h4D58349809950DDAE5B13CB1DB2F2C885996E82E2640E679F9880F2C9F04F996),
    .INIT_0E(256'h1F9A6678CDBD5CA602600200F9FDC9DE8CD23258DB4132DEAE3F017ADDB1587B),
    .INIT_0F(256'hF4103AA0527BB90D1DC29D6F042F066E7FC484C8DD517178FAF7717281481C88),
    .INIT_10(256'h9D7DAD4F9C6C80E8B79DE032304290A547BCEA4263E84564A2B5BC016C55085F),
    .INIT_11(256'h0F510F41A9BEB0FD4C91C6271472AC4F831CEEDB7DDD524CE00E04E60EE07ED9),
    .INIT_12(256'hCDB7D15F746038806B1DB3C3CA7B37621AB8A1298146FF491B235ADFF2E89BEE),
    .INIT_13(256'h707FEF1349CD6DCDA883DD1CF05A5E1EA9A6A0329F4A6CC19E3D8F49094879DD),
    .INIT_14(256'h30D20034E06918A88D26E1544B3114B4935112C56FD3E53CD11AECDD798A885B),
    .INIT_15(256'h2E3447C0772B1BB5A5C94515650B3D94D6ACBE2A3F484609BB48180BF526E2DB),
    .INIT_16(256'h288D806C16A4CC8A8FFB6A155F55FAE6BB19C852CF27635BFB7855C4787F2839),
    .INIT_17(256'hDD28E514F8F8D8DC4561689C8442801A1F2FBB3BBBB25CCBC2B096528D40E944),
    .INIT_18(256'hD7A162A61A5BEBB0EED2155CD60B094C0CC671A8110DDE762AB6C4834E2583FC),
    .INIT_19(256'h05BC5E5101DC4DD6C0D8E6E69145EBF96601E8EA8EF3961D029954F30A0871E3),
    .INIT_1A(256'h2A370F2B2427EF504A64F19DD0E779538D391D620B53A075704A7A249E936996),
    .INIT_1B(256'h11DBCD51E9D5744B5B28E28AB649CA6642208723B29263AEEC661E18583DF5C5),
    .INIT_1C(256'hB9F4413C247AF07D9DC2FB0E37203A0110719B1D03B0329280E6D48AE5E55226),
    .INIT_1D(256'h6E53E24B0D64EC6E7096C48013C032E73258A86E06B1EFB3ADCBD4B1D48209AF),
    .INIT_1E(256'hADE06F65436C29D0A14642668384AE21B790365E9B1EFCC30F60163136D733FD),
    .INIT_1F(256'hF8F82492B712743476CAE7D5942468BA8B8444CF4D178CF9FFA702B0A63F66CF),
    .INIT_20(256'h07901740BEDDA5551910DB0AAD1424438CCD6F2CE3549E6113C9B29F3C95C01C),
    .INIT_21(256'h26AA906E3D46DEFB6F3A7B7E7D317F6539997DB08C936309D6EA03ADB7DE2B97),
    .INIT_22(256'h4771215856F8AA473294D4A9225D29E9E20B6A4294F41FBAE7FA62F80DDF7160),
    .INIT_23(256'h246AF18C83EEA4861CD3CB26F297586AC752C817140AD42EEEF4B49CB590122F),
    .INIT_24(256'hB4DD32D954C568FBF3C5D05C0835CFF1E854B1AB3D0D7FB14F2958CB42E68E11),
    .INIT_25(256'h3BB9A24C18B3C263922252481A309DBC36FE0260D2272411DC40BB4E997070EE),
    .INIT_26(256'hFA509A8AD42176B2E79236CE38408CFECAD5907487A522C6F3DA3E6DCB98AD65),
    .INIT_27(256'h69B2E03233BE343F54AEC7957C849F831F99FC91AC02558F2480C5744932948D),
    .INIT_28(256'hF36765843CFADF3AB89597A2F4184B61FC6158B2C60765FA6477850D9772152D),
    .INIT_29(256'h678B99FA287743B12C157897E1556634677B2D8E1EC9498A886E224CD5BB48DE),
    .INIT_2A(256'hA5CD189F8DC702621447B5032A80394C7EE69FC808F8927C8DD64679BDC2AD46),
    .INIT_2B(256'h9059BC200DF4B1C978459259DBD3D6B8312B8F342AA3B65A563E29F265832710),
    .INIT_2C(256'h308AE52D6EDE5D1F906EA6F093D601DEB69A253AA2963E57515F18BC267C7090),
    .INIT_2D(256'h7FF19E6775F1A9D42B333F12710B4A497D8B35355274E34EBB93427B67D59750),
    .INIT_2E(256'h6B4F7C92E3297EC92800ABECA524A375F4F20768459A4D69A701954DAA2568EA),
    .INIT_2F(256'hFC43336749BEA0AFC242080EB7E08E28AA9CD7AC999421D654D05F0C1F950C0E),
    .INIT_30(256'h46AA5FC310C8F9312369D7E4787DD6B56C15D670A2CEF74EF602813BA7BA5187),
    .INIT_31(256'h8E7F31BD26B88377B636D97F4FBF93ACAC85D0F4C4FB7E64A1C813B031A2C503),
    .INIT_32(256'h581F12D6BCEC810B16EAF9F927D32E03BBA7B9E80CA69A0F2447B313B5A23CBB),
    .INIT_33(256'h0DDB5611304A96F3EF1AD7BDB3322CBF3811711ABC8CE33F8BF138CDDC165376),
    .INIT_34(256'h76AA4A8A3091CD9BB31628BB0F789A192F88FB68E0514B6A35B30655F50B412A),
    .INIT_35(256'hDA11A4D7D845CCF42B9DAB2080EB3A8122CC9B5DA97F22A0033E5D955675131F),
    .INIT_36(256'hE74B16978DCE57E704E426648A1EE5F4B933FE6E65677E6FC1DDE4057880D688),
    .INIT_37(256'hC72B16BDDBBD925CAE9F921FD72EAB047B5B77FC2E1F935F550E819B96B47843),
    .INIT_38(256'h5AC24A692DAC54B4A1E5539696A48EA6F89B437E877B751FB1DAE4BB4086AC86),
    .INIT_39(256'hC749DB98A4899F145C42F61937C8D312BF70E800305B53BE56EF7945E9305648),
    .INIT_3A(256'hED38678F9BAC0CCF9FFFAE03F5731177A475C5597A74174B957E40FFA3E49703),
    .INIT_3B(256'h3E692F8E38E4B5EF322B319F2191FB11AA192E59445E811BBACF83E2F125F734),
    .INIT_3C(256'h183F930A3A20B8315E4817DA4315A637EE793AB9A0771CE6B18B95E74A37D7C3),
    .INIT_3D(256'h637544CBB760CC42ADF243AD24AEA447A41A8431896FF35C299ED4A1437FA62E),
    .INIT_3E(256'h4DE38BA42A5CC75A558380891762F1579E741E1052D0190483AFE9DFA209D345),
    .INIT_3F(256'hA7BAA9BB5DB419A73513047DCAF11E8959472EA16DB46E7FA6D1299D5FE28875),
    .INIT_A(18'h00000),
    .INIT_B(18'h00000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(1),
    .READ_WIDTH_B(1),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(18'h00000),
    .SRVAL_B(18'h00000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(1),
    .WRITE_WIDTH_B(1)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram 
       (.ADDRARDADDR(addra),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,dina}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOADO_UNCONNECTED [15:1],\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_0 }),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOBDO_UNCONNECTED [15:0]),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOPADOP_UNCONNECTED [1:0]),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOPBDOP_UNCONNECTED [1:0]),
        .ENARDEN(\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_1 ),
        .ENBWREN(1'b0),
        .REGCEAREGCE(ena),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .WEA({wea,wea}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module Bias_Bram0_blk_mem_gen_prim_wrapper_init__parameterized4
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ,
    clka,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_2 ,
    ena,
    addra,
    dina,
    wea);
  output [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  input clka;
  input \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_2 ;
  input ena;
  input [11:0]addra;
  input [8:0]dina;
  input [0:0]wea;

  wire [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_2 ;
  wire [11:0]addra;
  wire clka;
  wire [8:0]dina;
  wire ena;
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
    .INITP_00(256'h68DA261548C0583DE7EBFC1D0573C898ACB8AD627E430C6D794B28C1B1DD5BC4),
    .INITP_01(256'h6182FFE7B22D6A575FE189624DB369FC11C9746D166826ED6DD11BA8102D5F5B),
    .INITP_02(256'hCC30DAA735717FAEF2C3E818472C3961E046473DC64A38DC3EB18CDE3AF4EB5F),
    .INITP_03(256'hF627EA1DEAAB009C441E7A5C768C5760EE895BA1C3B7DE2B9DD1F991C5161E51),
    .INITP_04(256'hBE09D805C3EE6AB75B0E2891EDDA6D218153836811F87A3CFF8621D89F212C2E),
    .INITP_05(256'h4F728194CFF1F002EF0A899B6019D167A9128081EEC5BCD305EA7AFB9BB4E39A),
    .INITP_06(256'hDA0320E3BA442519E749D3AE927A32FEAB8B37CBF059BD3D2A04B4728E9B4CFE),
    .INITP_07(256'h44513EE1AAE64330C3EC6F43C27E2CE14863D054C00795E0134C39EAB715A787),
    .INITP_08(256'h2BA3DE2B18F44137F9BB9E3397B07100237418C5118F2DF4996B90B4CCD16D29),
    .INITP_09(256'h25E95DA4BAB17EF565F2952AFADAC3FC1C5C3BFCA0922FF047AAEC04ECEEECF8),
    .INITP_0A(256'hB0311E1702C53EF65EEB6398B9EAB3F7241BC4CCCE2FDB1F9FDA9F24A8609423),
    .INITP_0B(256'h7847D627FD89C4A47C276A7CF88A48D568052E101AA059EB92DEA546C93D45EE),
    .INITP_0C(256'hA330FDC14E18462176861DF0202804CB87587911D1070395A45647BF60281CD8),
    .INITP_0D(256'hB5EA5B4D8CB86540DFACF59D45B4789E1F87C50DAD6D765F2F2E952D67B8FC90),
    .INITP_0E(256'h5D773C54E7BB9A800E5F898C02BF19CF3A87CD2D7586A705B55D661E146513B1),
    .INITP_0F(256'h169D349409BFF3EBC945AFB9E6A5D8B6F31159EC57BE0DAB6203303C5E4154AF),
    .INIT_00(256'hB56497446444FB80940FA67B8837B678321A4A9F61E1F423DDCFE81659F100B5),
    .INIT_01(256'h7C68495F6F9107D64735DC438D2D2DE5A5ABF695B95FE360A0F04502E827FD40),
    .INIT_02(256'h875338241E0AFEE5DBF23EBE5497C82B8520DAD98B7B75EB6C03E04EAD50CA47),
    .INIT_03(256'h060022AE022CBEEC1B83F09D46966B2F16D88772C88BBB4C9BCDFD3F1AFA17B8),
    .INIT_04(256'hA0C6DD6001A10BF3B2B0D380CABBACDB1BDA66431406043EB2E608C2C08C506B),
    .INIT_05(256'hA30E14525F0B93404FE376866C352C8F5493ECCF44FE172F0285C059CB769100),
    .INIT_06(256'h554506147E92E4E261D0ECD8FED925E6BBEC6CF9DE316E44736B2A15ADAB9555),
    .INIT_07(256'hE711DA943CABA2ED6AC18FA9779D585ECF9D983B619EA859185F47AD2D6ED619),
    .INIT_08(256'h1CA413AC67AE01ADE135A113FDC75736D7BE02ACCD61EE82F8CB4EFD74559794),
    .INIT_09(256'hD9296182F779280E6F0FA1713C5DC7F6E76C73E5F99A026B53AEE0A30609649C),
    .INIT_0A(256'hFEA2B226C1B564E33FE7DCE26FD913877611D0235250E53901BB5B468187C063),
    .INIT_0B(256'h199267C9C391CD4D78806D63119ABE02A9E0ADA5E83678312B64F587C9FCF3B4),
    .INIT_0C(256'h01CF6112BA74F8B51756A731F519DE907D9A620FBDA43AFF21A22EBE2DE7DD91),
    .INIT_0D(256'h124E389445C26BB4A9FCC1B9913EE295AF5462673F8AE4336774707B0D9EAB86),
    .INIT_0E(256'h3236B80266DD12709359C0D3C3A7E28E101B01C1F4B2F19857B1A07EEFE535C3),
    .INIT_0F(256'h84887EC6B7B2BC271F2F7B91C832ABB316C069AD1365178B6BFC89D43B8CD2CD),
    .INIT_10(256'h64CB3F0D3357866B2BA5303D8FA53E2CD721B908D1601D0951827B64BF4ECAC5),
    .INIT_11(256'hA3EAE28FBD1CEAE31C6D960A7BCD47A5FB3451C440415A6D16FB47F52A098553),
    .INIT_12(256'hD8A43512F6BA0EA86D429456B2803D6676154BBD049AA69E5208F8730650F7A0),
    .INIT_13(256'hF2A8017EA4502A39A2E21DFDB9D2AD918C9A7BE63CCF6E15A89C5CE87647A48A),
    .INIT_14(256'h7E8008EB4937F7D04A6AC2E9D9A1699D83A4BF329FA3FF99823E8355FA057ED8),
    .INIT_15(256'h3F670247C36EDA410E6A321C30B2079CB64C6AB36900C6C04860CC4B5C456DC1),
    .INIT_16(256'h98FF6381E21C01D6F6490341924C2B5057FD15F858B6DF8C9B00E1CB0E121165),
    .INIT_17(256'h1C5C4DA1366722CE77C4FF8629B1FA51E85D8E4E886B047F52B87A9AFDB7FBB4),
    .INIT_18(256'hFFFFF3ABECB53E8B8AB2B39CF928789298B937FABDF5FF0D97425DF76507C734),
    .INIT_19(256'hDFDE542FCB31DA827ED820E737BFB93FA66C31FC7F300CCDFFE7FFED4DCC683F),
    .INIT_1A(256'hA62AD4E7A96408F949F557757500E24DE8D6005C1CBE44CE5E9EC8FBE6E0CFCB),
    .INIT_1B(256'h16460C11F7E3BFEA94500979AACA265E73CD70C622FF3E945F565CBE5786F5DA),
    .INIT_1C(256'h166C95037CD88907BF8D4F7DC9CFDD5DDBE201C17950AF88B7C58DF050091328),
    .INIT_1D(256'hFE6B9FA83DFB6ACFB98B42F82B6D0E9A9A856B6DCCD5F3B9D2F47168041D26D5),
    .INIT_1E(256'hECFBED23FC96817C61531AC71C5C2D9890B6621C0895615373B34F993568DD43),
    .INIT_1F(256'hA5C10B323F583A63BD5B3B43E57E158A7EF8942C8B6FD7EBB929EF48FE55DE86),
    .INIT_20(256'h4B3493ADFBFEE561D07CD6E302D2B656AE4B5599A3437200D639C8149ADD2414),
    .INIT_21(256'h3BA7F0328FC335F61087E1639DDB38EE19DD4C8C238A9FB8B7C3E81DAB9ADA58),
    .INIT_22(256'h921308E6C54C3FF178E805F7237B59F3C49E6D5C05F0A2FEF55154E896C2AED5),
    .INIT_23(256'h397C08730A5C13E55461A97C5A2EEB90F298B091E3D4039263A81EDC8D90C90B),
    .INIT_24(256'h6439692B29FAE4D5A1AC9A0366CDB30AFF2F45AA192B2A95FC9C958548FF550F),
    .INIT_25(256'hA60C1F7A5441ED457DBF368C8591107A957A5889C62852C6991CDE3A7C5DC440),
    .INIT_26(256'h4976E2D3298AA84B1535AF4BFBB4A11E7DF018CC14E6C554EBE647DE19BFAAAE),
    .INIT_27(256'h3BFACEE783E36953634A5C620618DC0EFB4681084E88DF26D7C8A248725C4316),
    .INIT_28(256'h41374FF80D1FDABCFBF97AB488D7457A7197E5A6210407126C04226CBD166B68),
    .INIT_29(256'h9B18F2405A4C327C6033CB951AA205AE9695A4EA05C6770C39DADCF8314ABEE2),
    .INIT_2A(256'h1680E069F53E41F7D44F78BED6AD06D72BC67470E1CC36FEE573449CB9C99F4F),
    .INIT_2B(256'h30E6416A45BC5B1C79150B10BFF31AFEB2534E596CFA6B85741BAD3E5FBBE484),
    .INIT_2C(256'hECAF520189A94F01EB07B88BF5D80A69A22FCEE6396383F19417FA204619E165),
    .INIT_2D(256'h9917E9854B90CCB8BFCAB71A4E71B40B9B5B66F85846922E5650D426DA2B2774),
    .INIT_2E(256'h9B409D7811F2D4E863F0188B88F55688F74516C1F3499501C79233253B4BE339),
    .INIT_2F(256'hCFDF037D8419F567F637444FD8345433BB92124427CFD86010A45A51FC873794),
    .INIT_30(256'hC9B8D398AE5BCE85F8F390B0E129EE5FCC9A139249E191F763DFACF4CA4EA92A),
    .INIT_31(256'hB7DAEC055F93608809F08B9C10F0076E4EAB376CB7499A009AF1CA1B393E5699),
    .INIT_32(256'hAFF6F99E02B90E4810730E9A787F8FC90BF14A05A93BAFF032B16017C24255AB),
    .INIT_33(256'h14D0253418BA07C5947740189BB46D3A89CA15CCC9FEA7B03549747C12C76B1E),
    .INIT_34(256'hD1D694B8201E794D2733642D285747412CB0B650F987299DEE9489B5FA7876A0),
    .INIT_35(256'h33328084C5FD0D3CCF1D932D6FF9BCE8E19E95ABF171EA04A845C417D1AA1B75),
    .INIT_36(256'hF1904E4524FCBF7A698BFDA736350015539BF74169D56E5048731F412F31AD91),
    .INIT_37(256'h4807A5BE966E4BE3BBC2C02E9AF83932016C1EFD41870951AC0EC4CE3B65DBA3),
    .INIT_38(256'h84CB556F139CE5F5555C4027CB09F31E61E0AF3E927CF88BCBF0B0FBFB626355),
    .INIT_39(256'h3B1C75C6ABA3201C623C8654714B4FE62B62B4E19EF00BDE2F633684704C66CC),
    .INIT_3A(256'h434E9280CE4DEB5C6E5DB0D11DF81BC412F8DD4DA6D3D6AD186E3E141F96D0FF),
    .INIT_3B(256'hC1B3F4996F8FDE3A75714AE64FC8DD32D37C999DD3C1A1ED31A4C81C20C02B72),
    .INIT_3C(256'h750F55FDDD569E0B53097EC1517829B94186A474D5C68A1D90315969688994D0),
    .INIT_3D(256'hD864ADBD60B0760CB9D25DD90115B332F31AB7694C3DDAB531FAB6E37D6E6038),
    .INIT_3E(256'hC2D96E1C52A02D09CCE7B83AB1E86CAD62BAE03B58CA36ED8746CEC30A4077E3),
    .INIT_3F(256'hE3DDB8DD4D2261A2FE3C822A2668D048BBBE8527055257D57DBCA9C96A5C1A6C),
    .INIT_40(256'h75CA43CD8DE5F267FE3A2E2B17EE650A7DB4072408DA8D50A7A883B69836051C),
    .INIT_41(256'hE4011DBB1E1326AA35C7F8DE039A4CBE01E355E0615F242ADDE66E3C47341BCA),
    .INIT_42(256'h1935FC5F1F700A9F365A0F0744DF4ACA672F101023C8B88324B19402B1E18042),
    .INIT_43(256'h5DB93840062622834BC3FD2CA21FF1BE80817B99E57BF0B32AC456F5D3595A02),
    .INIT_44(256'h06F3E6C66847E491BE19521A1A4D67F1648ED952790B24A2256479111EE08C63),
    .INIT_45(256'hD7093286992A6862773E3DA0965A72E1DD3A35BA2D47EDC92C147272B9D79788),
    .INIT_46(256'h6B2E8F715BCC661D53A14B0389457FB8D23520381C7457F67C945945A837BF03),
    .INIT_47(256'hF0AC3C61501565AE7DAA519E2687380EE73A5C2FE5474605445DC4663830907C),
    .INIT_48(256'hBDC684485CD19D0C224F5D4C1DB6AA7735C0253FB9F47312B1AFF980603EF57C),
    .INIT_49(256'h161C95FE2B9569B87CD21A2EECEDA03C78F14B24F83BBC557026360FEF785C02),
    .INIT_4A(256'hD0D811D49AF7E00604C5C09D03599ED397C9D303815BD229DE595BFBC9F7AB97),
    .INIT_4B(256'h81AA9B8F68ADF307E0C990CB6251ACC24537AC810046BD98FEB7ACAA6D2E3F6C),
    .INIT_4C(256'hE38176015EA427A8415AEC110447C67DE4EC9819D7A56E6A5F674207841C1F68),
    .INIT_4D(256'h4FD23B5F42F54970BA58BFF311D6AF7AB97ACF07636B1F8610F0E64021B4C014),
    .INIT_4E(256'hCA630EC80B9C0E108CA44751C74356AC4647F7AEEF197E26D57C28BA57B7AFC2),
    .INIT_4F(256'hDB0BF029657A704CC4F50106B261F342D5BA5F5DFB50C592BC8A6382E0B4923B),
    .INIT_50(256'hB2CE4F059F13CE740E0EED5A86972EAFB7563665BA169929F9FD88886679DBBD),
    .INIT_51(256'h71BAC87A266CB2F5B03BFA60D3A714BF58C427F81BE4F5F236056E6B621F9247),
    .INIT_52(256'h06B4A89DE3EAF77407D7932B5823975FDACD64EB8DB89716F59001A0F52A6EA7),
    .INIT_53(256'h16DFCCE2486B6B9DA63965CADDA6587B11212AD9ED4F8819C307E6AB58C62635),
    .INIT_54(256'h740308B6EE87C77EDFC0E6473333EAA142C7664BFCF2A395C9D0C2CBCB781B73),
    .INIT_55(256'h33C034601476D9C108520E89F7237760334FE32E0DA1A275749C534B6273C1C1),
    .INIT_56(256'h2E212A85F1FD36FF712DAD9A5A565CA838E83A40A8CBCC3258E298C150BBE399),
    .INIT_57(256'hC83E0E3646F81C2B1BCA96A9359E4F87D32CC4F01DD17718AA1DE71B7566E6E4),
    .INIT_58(256'hB2FCCAA66981D5C57ECEC0458C47FC3F8777E15F022D233C900FCE43ECF47BAA),
    .INIT_59(256'h9A59EAFEB49FDE8682C137F3AAD4E0CF3BE59BA75E9F3F658DAED8F91888E6A6),
    .INIT_5A(256'h940C0FB2AB5F085729AB27B6ADF522B9BDD00C8D6A79D77D34C4371500A02AC1),
    .INIT_5B(256'h50E92395A5DCF36BD70D8626A63888C2DBBE4270B51C12F5890E57646FD1C6DF),
    .INIT_5C(256'h1AA4DECB2ACC51B2351EA5DFB8DEC69532BF2A2E2909A0B56EED80A823F6BF12),
    .INIT_5D(256'hA30BCAF555D9F887E6A61DDFEC18845E11B31ABD342E2CDA0ECBF6B894756EB8),
    .INIT_5E(256'h7BE9050B8A67CEF828C4545FB5D11D19D93FE36A3F0BD9C0588CCFC58BFF1A7C),
    .INIT_5F(256'h0550BC11C412CEC36CC2DDAA779ABECB91689A6ABD298C0E81D4AFAFBCB156B3),
    .INIT_60(256'h67B6E491AD99945D6FE58E956C41EAD7776BA7A94A1A5F966E9A6740DE1E21C9),
    .INIT_61(256'h9623ACFD0E61AC7DC8D9F353A03F59B3F27F05DB0B08F6E45A719592D9EB9195),
    .INIT_62(256'h9613AC3EC161E026C4FDF841966BBAAF21B00C0D10B504EF367FF8D496160BAF),
    .INIT_63(256'hC911737F5D40592706227F983EE4B913C344B5212E7170530041B75AAA4122C6),
    .INIT_64(256'h16D68674C9FBA3E91E07545B2D5DA7BB886A570A2F256B02B1520A9138DB2BF3),
    .INIT_65(256'h2A5B78E6D6B18628EABC06A7966E8281AD3ECAE9A0BE8F0670197F4C8A4E3A7A),
    .INIT_66(256'h1123C26488C81541424EF265DD03A922A30DA0326E165E3E610A815AD04318B6),
    .INIT_67(256'hA2763643EB8C66AD0EC82284EC9AF806F82A70D59E1079527FC811BA36522424),
    .INIT_68(256'hF99C9303CA36526D16B0AA1636E48F4AC7A746258CE513E30F0FC2A185C46BBF),
    .INIT_69(256'h2566160FD25D16AFA2063D72A18EF96373A5640958318F1D5758A687543DC9E3),
    .INIT_6A(256'hBDA9A47EC818FFA2D4AE8ECD380E9FD5245E295B79AB295BD1D0AF8AE6D1EE59),
    .INIT_6B(256'h64C90FC6591E002A2F4243E1D891C844D484734DF5C44F78CD0382BF53368ADF),
    .INIT_6C(256'hAB650FFC98F3821F23266B59727DA9A7861384C028F6A0F2C18E6195AB3BDF49),
    .INIT_6D(256'h607381C3699F0C2F548FCB843A0429AD54A5DDA2FDF7FC2AED2B7F42322AA948),
    .INIT_6E(256'h52AAA9E68698323CFA262A69479AF3E3D9811CA745520508198236242AD41700),
    .INIT_6F(256'hCEC0282226B7F926B2C8635A7BB537C34511189D09C2F1EE2E2443EC4BB6122C),
    .INIT_70(256'h9A0B9F23A3194BCCDED09B18D794B2823DDEFE3089AC4EC85E6F49B4EBA52C5D),
    .INIT_71(256'hFE473639FD4251ACB1CEB4E85A476ABE99C9ACC5D3EF765F39D54A07C10B8159),
    .INIT_72(256'hE5B28F6139275374BA2F50FDA7F810C9FCBCFB59BC6791F1270CBCD9200C1F5C),
    .INIT_73(256'hD4C01356723E36BDF336C6DC0808F8327762E53A208DB0ED75232AAD47F52C25),
    .INIT_74(256'h3B99C04B8CCC93AEDA0168F6DF8637AE21AB0B00F858E68357153E7CC2549F67),
    .INIT_75(256'hF38FDB57365699C9C5095B1C76510CD2A544F66659CC1DF59C83F3E20BCCB39E),
    .INIT_76(256'hCBB63312CB4F7FEEEB9C552F32A15EEA03ECA1E803287C1D2DF5568A13BF713B),
    .INIT_77(256'h7EFAB22FDD76EEFABCE910750F75EE95516379A4C78B59B264A9C70230DAA91F),
    .INIT_78(256'h144192C6056F3A6CFB748A46A94876C436EC4698887863FA9A4F98E4E7FDF767),
    .INIT_79(256'hEE48B77B5FC60B3A1BD70D90BB6CAFCCE1502293555C07395AF2D911FF891016),
    .INIT_7A(256'hAD8A0A8E6349DA7048B3DEDC2B82B73E8077B09EE08DEC348087B4418C3193EA),
    .INIT_7B(256'h3E853D18BF4CECEB5021BD952884BCA6020AA0772460016B5262F5774F23B78E),
    .INIT_7C(256'h1FE2810631FE73279AF842DE2B594ABADB8EF344090FB36C4F622C9BE4A0EFB6),
    .INIT_7D(256'h523AAD8413F5E4AC0A3BECCC1C456651E6E2FEE443904F562898E73DAB162893),
    .INIT_7E(256'hD21A0DFC96E2D7365A634F831B088ECAF2E56267F5067E24137505DB797A6C79),
    .INIT_7F(256'h26E26E04ED04A9427FF3DF1034BA38090889080238BC24F49732745853CACC82),
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
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,dina[7:0]}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,dina[8]}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:8],\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 }),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:1],\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 }),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_2 ),
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
module Bias_Bram0_blk_mem_gen_prim_wrapper_init__parameterized5
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ,
    clka,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_2 ,
    ena,
    addra,
    dina,
    wea);
  output [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  input clka;
  input \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_2 ;
  input ena;
  input [11:0]addra;
  input [8:0]dina;
  input [0:0]wea;

  wire [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_2 ;
  wire [11:0]addra;
  wire clka;
  wire [8:0]dina;
  wire ena;
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
    .INITP_00(256'h652400727CAC7C79A5923E7B255BD5395E69991E9E894F236ED3513BE6D0C4C0),
    .INITP_01(256'h35A7BA31A029B1A3F31496D740381298F54F2CEE54A797DB682DFD72164A3658),
    .INITP_02(256'hEF7C49D58031CF1077BFC5A9B37AA61DAE5F03BBA29751116EB8337136563124),
    .INITP_03(256'hEA75F19204817B19807A89C66DCAF21FB8C38339F8A718D4E7F5E121B654C39B),
    .INITP_04(256'hFAC5D81F81C5BCE2F0819AFC77C69DC9BDAAE16B11982E7CF75355B7A9D53CEE),
    .INITP_05(256'h194DAFB8E5CD5CBD2A0535C7FE9E2E62F6C31F4F35C9641C219CC579B33EE9C0),
    .INITP_06(256'hB208FAA3F48C296577BBD961E7C76755D695CD5781F64F6072D80D7CAAAA7D7D),
    .INITP_07(256'h32171EB145486AB3E59B97B78DC389802385D5E9062C3ABE94E107FA8DCFB27C),
    .INITP_08(256'hFA1A91A65DF54AD89D1DCF1646A61C6EEE7C17E029829D4A8ECBB6FAB59A9BEB),
    .INITP_09(256'hF6C0484ACC7E9633DDD16442C07E7E13B1A998316DAF6EB36A3D3D0953F3672B),
    .INITP_0A(256'hEB8D31CE8BC2B560924412C3DABB8931C6382FDF5DA69A1043E5020F22897889),
    .INITP_0B(256'h608D1E274E1BA65BF6FC197C6371868A05B20B6208C2CB3BD26DE47BD0A00D2D),
    .INITP_0C(256'h9DF390F52A5FA532FA66FA701666CD17B34F1E9AAB568481D0690E12C182303B),
    .INITP_0D(256'h8F0D1F10C8C18EF507DD90C77D5BF161033871D54B03B2530E1B2F0A40E599F7),
    .INITP_0E(256'h976F28FE352A06AEB6CE5CF4E64A7EE63FD2F7D8ADE958B741704D63DA91B991),
    .INITP_0F(256'h8E9A64F2A54BA17B39D679B371EFE3D8A19A6028081F2252D73262A3119A96AD),
    .INIT_00(256'h925BB3C9202006C1692E6588883AC702943811C27C920E7F314A2EA686BE9E0F),
    .INIT_01(256'h3BE24397BDEC35AD5ACD94D8017E39E2C15B4D995593157A9DF55DC1E812E657),
    .INIT_02(256'h1D5CA08AF585449C3C6ACF683598CEFC96C7111B9D80C183677719E1B85AAC89),
    .INIT_03(256'hDBCAC3B3F3C70365EB6166FAC9827BA166BF9DE8F7DA72C624860CE0B621C5F6),
    .INIT_04(256'h50FBE6AFCDB114B6C682AE4C2EAC65B00596627E4B6AFF32AA52853749DA5038),
    .INIT_05(256'h29318E831190F6BC652E781DC22D3E46E9DACD0C96AA31F80F270D0DA82876A8),
    .INIT_06(256'h5FF7113B76B0B0B5F59199D976352C31CF83AE45491789EAE01A733CF5559484),
    .INIT_07(256'h89B6A2F010B4ECDD3BD63B53C6B1777BA01065C516E48C906A3392C5D5263DFF),
    .INIT_08(256'hA9427AC563C3395FB832FEB79FA714E5589C697BDA9B79EA01D1AAFADC1C4D5D),
    .INIT_09(256'h94E755C6FFF69C4F945E99617DD94CD6AEB06C11CAE58C40F1D0467EF3F18618),
    .INIT_0A(256'h928A609E2798B2C4672A07EC066C26464831E863028346E29B4845FB4618C57D),
    .INIT_0B(256'h7FF788DA08992127A47048D4237101517D5E7B64B6909AB4658ABD1657930322),
    .INIT_0C(256'h017951B28C395CB9F72105C7BEBF3B4FCFAE31BDF1B05BE1B184A0F3EA00E25C),
    .INIT_0D(256'hCB8D1A6F6B9D8AA12A28BF0D7A277A145AB4ED81BD6424883CB0E9CCD67574E5),
    .INIT_0E(256'h099F6EFEC99EEEBFE6735A5E6548756CF43B045FFB73F9467C7A9009CA3ADA63),
    .INIT_0F(256'h8ED89B5817BF974E14A258DDC57D98925608FEBB5ED0A9592540B09C21C7BD7D),
    .INIT_10(256'h57E5D4227A315BA092546D744D6B37305C7B148D9DC26A06CEEB834667B631FC),
    .INIT_11(256'hAD1C36B67C8DD0109DE03329A88D6022B9547718070B7924377AAEBDE956E8DA),
    .INIT_12(256'h2B66A79F1E71BEEAD21CA5CB11F05C24336E27B85EDD5308186809DCC8449905),
    .INIT_13(256'hE3E5C0596548FACC3B6771A665C884869D5CFE27014DECD607577CE06D6E7FF3),
    .INIT_14(256'hDE0A186CDA56F244F9385FDC5A764E24504C1DB3623292B37431C808F3A0DC06),
    .INIT_15(256'h3B8694572732CD555EA0F9083C5E862C872BD043FDD26751AC9983BF05F1E7B3),
    .INIT_16(256'h941B9A9F01D097831EEB610525EBDFC630C7061755335440DF891CEB9CF019B8),
    .INIT_17(256'hCF5917D1766207BF518655D1F7A22D4FCF79D83CB048B66643A8304EEFF41FB5),
    .INIT_18(256'h0CF1E6379BD29B857FAE91A1594F2AA97EEDFED9A68842331C3969EB1311A53C),
    .INIT_19(256'h0008A6831A65D306CA49001339D390D849174FE58B6FF37181914F170D6A55F4),
    .INIT_1A(256'h725262AF470A7DBF8221EC28BBDD394AE16E80AE0A936848857354339EEE9E92),
    .INIT_1B(256'h46C4EF4DAE650AC185F38B8491F8CC640EA67124CAF2935282795897C118D944),
    .INIT_1C(256'h197CA3300058B9D25462A338CC4DC99227A9E49ED8EB372C8D158AB82A35A125),
    .INIT_1D(256'hA60EAC15F207B5B46A190EDE0E00ADBD824FBED1C2A83CF166886EECF32627CB),
    .INIT_1E(256'h84ACA0BF8BF80AAE4C8D944EC1A55D8FAB7A2AD1F5933D765D37013EE3681D89),
    .INIT_1F(256'h33F1899B5F5520A76956F226154D318AF78D03896E639EEE05C094ABCFD0C71A),
    .INIT_20(256'h86C810CB2C3736CB1C2263F2FACA058DE9477C3CF154CD7679308A511E4735A8),
    .INIT_21(256'hA1178AE78E0343DE0CDC588D01972FFEE621A2BDD2F56B11522F8C26F39ED1FE),
    .INIT_22(256'hFD2FE13FAB4608BD3751D30907CC3A83DCE2EEDA73D10388A08E3797A5386B1E),
    .INIT_23(256'h02C09DAC4DA5E9187859483B763D32F697E76A19616C05CE046B6A24C62C89F3),
    .INIT_24(256'h1B0FB11C318F4BDF4C1404F884B12FAF8C36A56F5DADB9EF4A9051D946A27C6F),
    .INIT_25(256'hF8E328F3FCA2028D979BC17B51CCDCBEE212A273311A19B26714F5082ACA1725),
    .INIT_26(256'hD7EE8401B804E063569A083FFF999F935799A347EE83638038C6A88EAB5C00A0),
    .INIT_27(256'h82E99947B8C55E93849B8933E2885C2506CA024B683B1B04B6C82AD56DD2D901),
    .INIT_28(256'h44432291F3002982B19BF3F2B83DB26637AD5894ED9C704DB3BFB38DE111462A),
    .INIT_29(256'h149AA5D044670485F845FD05A466487DE85C9B321FFF4C0FB88CC8E138202F2D),
    .INIT_2A(256'h05BEE6800CE84F8D94BEBF7CE843B27178C056F15A821D957692BEC16CD6BE9C),
    .INIT_2B(256'hE33409514A949009B5481A8CAF6F6ECF003FF514923562976530454D021EA244),
    .INIT_2C(256'hAADA09DD6207FD42B51ED9D7A34FE99DB9C96F3CA9581C13E4F685CE4248E368),
    .INIT_2D(256'h040B5A7DB0A11A27CEA6CB51B5B146CDDDF4EA18912ABF327C40A54E801368B6),
    .INIT_2E(256'hC0AE3CFE0AB574DE668635F06698D107263BC39091A5D326FD2BB007A06AD504),
    .INIT_2F(256'hAF225B8058562C8FE106F144EBEAB5BE95263E4CFE9EFD8C29BC25F31232A628),
    .INIT_30(256'h707FA2EE7860980647C3363BBDE87B30DFC9C45A457BA451C45D9D82462E8E83),
    .INIT_31(256'hEE8B150EB2FB62BAEFAF5327ECCF0EC7F4631A1EA7A421685A9C85FF6BCE0BD9),
    .INIT_32(256'h8CAF3CC7D71267F56A71FA624FFA6D2F683989D127DFB931E0ECCE8B1CEF0D41),
    .INIT_33(256'h6B4C7D4A7F1930EC5A96F83E7BB428FB5B0F211EB590A2AA8018CDD9C8FF0428),
    .INIT_34(256'h8F7B71A61791A57A12481972340CB882DE89FFD6BA6E756340508B7D43AE03D7),
    .INIT_35(256'hE51F738E7B482D1630009F75C35C74D8751B1877B7FB943A4307029A4882D083),
    .INIT_36(256'h7109761A1AE7CB25907990AB7CD0B9E9C279E23EA69361E00E8A339C3F60DCDB),
    .INIT_37(256'hF2290F04C3AD06170138482CE4981F1DFFA68CBCA757F725C197DC5C3BD723B2),
    .INIT_38(256'hCCB9D5DB343D9C1F8F43206597801D477A60552A4883F3F590E13D9980FFEF0F),
    .INIT_39(256'h4E23D68F108224981985EE0BE90F2FA6B1E4DE029DCE453E4C46C0A36A33F4BF),
    .INIT_3A(256'h4420BCEEDD8F07407B4A33DB35910D6EB5E3DBBA143C13491901F3D32B19CE90),
    .INIT_3B(256'hBF51BF24B8E6CD206912E0D2F780B296DFAD5DB045D82360E9F325C6B5E7AB5C),
    .INIT_3C(256'hA1B06A8E4083C07AFC40E1FABED8563538D8DD28BCE1CD7C90B511E2804D5966),
    .INIT_3D(256'h87ED0002C99191320E4544049D72FCA908BA2FEF97599CC95A201BBC9278BE64),
    .INIT_3E(256'hBD68F4E31E81AAE6B7EDF306C49D6AD16CAD324587F26FE978C9E867F66BC6A1),
    .INIT_3F(256'h45A4F97DC07F61359B7675F8F10F387724A4808A8CB1DA4D4970FD4F88BDE997),
    .INIT_40(256'hD7E70886BCE595F652E64D91B81EB70EF8A5912F531E4E8B243B10795A9E83C7),
    .INIT_41(256'h14B7EA64310F1C1AC6CED058CCB13AC45B107DAD02872DDD99531311B4D11F1B),
    .INIT_42(256'h25B231A42EBB83B33A1FCD556DC7CF4109645A6F6DB70A8EDFE5B77436A64F90),
    .INIT_43(256'h3D564E6CCECCADC6E1C194CE8E9A55FEDD322E1B92DB7D751F1ACE632BCF3624),
    .INIT_44(256'h8A6C932BB5AAECFC9FA82EDEEB499130FA78386FC5B64CD9FC755CB498AF38D3),
    .INIT_45(256'hA076B31083FA79EFF9237D7B3680C01C04373565B92B6881499C89B84FE382A3),
    .INIT_46(256'h2FEDF5C573E12DEC358BA8740E18CC696A2392928C40047066692D358B499FEE),
    .INIT_47(256'hE69B8090D8CCC0819FB156708161A1BB58B0E1F54CC3682D5C94E732B96FBC81),
    .INIT_48(256'h96B2EDD16E6A49802DC30E94B65D1044D929D51DB0B38624985B99E23FF368F2),
    .INIT_49(256'hBD70EA365171B87877A4A5F522E874050BEDB8FAC85F003989ACB07BB542F37D),
    .INIT_4A(256'hB2CF83BAB6772833C50C042D47F25FA0507A0E2B67C49053017F2C2F6C956EEF),
    .INIT_4B(256'h17A02B2AEAE80E79FB8DD85D349F7DBE008A1B385D2BD7FDBC81CA6E879147AE),
    .INIT_4C(256'h22A6D7BE8AB3A034F996DAEF2B50A93036377ADE7C24C4390DF61D79DC9094FC),
    .INIT_4D(256'h6B33A5F908197BECEBA5DD8158DC9A6BC305EAA5D9CDBAB8FC450F22A23FF818),
    .INIT_4E(256'h7EEA7D03E0973BE1B16595DCE759B92BD82B8CAADE5406316F93003ED05EC5CF),
    .INIT_4F(256'hD5563D7B0D14AE996AF02FF7197BD94B5FA58AFB3D2F0868B7E67C8D5B87090E),
    .INIT_50(256'h7119E9D1181FEDFCD63D2BD788CD7541A4C986459C86271FE1A96D67B8BF1BF3),
    .INIT_51(256'h319C57736504F9A39BC488091C0CFCFA901A1BB6B00E9C5133EC18D11592E6C7),
    .INIT_52(256'hA40FAA728AAC77E9665B151A5F5BA8B8BDE1B1AC8EEF22D2ADCD58D7E194B57B),
    .INIT_53(256'hFD9BDDE98D80C2D163F4BC695DA3853CF16228DF1C27FE7A79F240525F162D3D),
    .INIT_54(256'h7C86E9A94F7AF452B1A8622CA4D72E059069A9B6EE54A50D18863D3629E7E14D),
    .INIT_55(256'h96F73F534D1AC9E7C5C1DBFBCF1537FF8B9829F8DFB5F0D03F8AB32E12F4B82A),
    .INIT_56(256'h69698A79632FF26F3FAA49CD7C333D08E8245882D22964E945D1D69CDFEDCA9F),
    .INIT_57(256'h38BD184123D49206DB3A71654984CE5D1E8B928C0A5D160F5570860D9CAE0A53),
    .INIT_58(256'h7DCEC4D5842C92D62FECE41FF37DAE17098566EF4F2F49DD4AA108D993D41BC4),
    .INIT_59(256'h95E8C32A4F4A28931012AED2EAEE6DF5E4D91A0EA6984CFD00E308FF20F17BE3),
    .INIT_5A(256'hD5080239270ED3E07C762822DF16A1FA692CD9401E1A7C6A7A8C6A1225B0FF91),
    .INIT_5B(256'hEA18B02E6AEEE6EC1CA5898E88E378639949D831FEF7165F91DCB8C8DB53D1A0),
    .INIT_5C(256'h44BF1C1E86395BE1751B4D7D1F8F4E2F9B529B051A030ED7289AECA2521F133C),
    .INIT_5D(256'h87CCC668F806F6B16733145A7CBE0EAF3A0A1B670C82EAE2B64BC0BC7991C7ED),
    .INIT_5E(256'hC7C182C5DE73ECA8BD39DD043A48BF57A2FF60FAAE54E158EC8C45FD1F894A31),
    .INIT_5F(256'h45E42BDCBC2486BA2DA97A8E4271F768FE65AB2E628D268D252DEE3FC77FC378),
    .INIT_60(256'h277E844F8FA1C7DAD8A4C2CBDD1F3E58B96878B161943560475E0E6ACE09863B),
    .INIT_61(256'h80CBE4CE83F97303B82C09D54DB52B3500C0627D5CE85ADAA80667E4318EF03A),
    .INIT_62(256'h0B3E45207852BE1ABE7E0109CB0B87F4A9162D198A2F66E864B36F0F32C0140F),
    .INIT_63(256'hC30A96D27B1218D10E3EB3A8B63CE11B22FD9016FC9BA24391046C9C5CC2AD6C),
    .INIT_64(256'hE6A954F739B685E205B0DD23EF497D42C549643606D1A26B71CDFB5E59913879),
    .INIT_65(256'h574489AD85A9E16C9D91AE30C158B176BF8653E8FA4368F512BC50BE444C5AC9),
    .INIT_66(256'h06E12976F94BF2F6FE2856A0B7F820CDFC5613871EC3C755B657383778439C0C),
    .INIT_67(256'h52FB44AA3505430E8B241E3F00E3F32E2A29F212F2D625C63AB3EDAB2000BE97),
    .INIT_68(256'h5C498A282F515EC9126123D983C2BED0BAD98EC5ABACEC6194045F453B79FCEF),
    .INIT_69(256'h346FDA1A811BF5E4E425A96A3492B5FD3AB6AFF465CC083C5CF8C1E342B4CB60),
    .INIT_6A(256'h13DF0BF24DFDBE9613DCB740D0A4493486585991888928A666643A347139CAE5),
    .INIT_6B(256'h08381EC42FB2B4FA56641C3610EB7E9021F570F0E22EBA9CA45AAA25FAC28479),
    .INIT_6C(256'hE429CFE215A77465C88240607800B7DFD2DF1212D9CBFEF742E0C67A20E75D22),
    .INIT_6D(256'h01F426626D22D76BF543AAF33F219FE5C250108A2AE3E63A5EBDD76DA9120725),
    .INIT_6E(256'h357AF8F74B379635A96B0AA4AB9811D07FC7E8C5DA28C473F2EDDEF118639CC3),
    .INIT_6F(256'h5E8FBDE37129165990D89A0931C8172732159DAC7280480C08CEE87C1F0A33E7),
    .INIT_70(256'h4BF88AFF0ABECE95604366B509B81C64F96C85DAE57A1E4BC6927B79C7D6DF8F),
    .INIT_71(256'hE54AEF80851241D1B20C4A2C30DD972772BA40BBAA149FBEDD61208C3FF1E992),
    .INIT_72(256'h2D82199E8F589BC9AD0FBAC54B0EADDAB2C4884B67EC7361880384A3F6603979),
    .INIT_73(256'h815E956A280625C7E0744273959E45653C4D801EE6C11AD0E11D52A41A4C8CC4),
    .INIT_74(256'h15A2AD48F56DE698CF60B1FC1544F83788C72C1BAB37D0B978812F349F96DB8C),
    .INIT_75(256'hC9B1A4A9FEBEC187DD277F9E56F81AD48C74DE47845DCCF8F698E547BECAAB85),
    .INIT_76(256'h77461E4BC8AC65E5817096C087AD7F2BBE4438F74B487E5D0195A573C9CF0417),
    .INIT_77(256'h2CBDB9D830948D96336970ACE92008FD7FB02A8DB66B0DF2A281D9C32A883860),
    .INIT_78(256'hFA020B60FA40DF7F060210790B403AC2666121411E7C9E937FA7B36206504630),
    .INIT_79(256'hE81FA2B655795AD8C981E7517F7ECEC951C046624E02A548789E6DD502CCC041),
    .INIT_7A(256'h4B4114064F23D5F4A80426BF7C720AEE965120777A51C2974579F90401353193),
    .INIT_7B(256'h4BE4E505F8A1C5E3B8D4479D9566939A708630DC4AE0F3F7D676F330B5E9AE49),
    .INIT_7C(256'h3FF6541DBE6FF869DAA4C9AE4E81A60F4E431860D250610FA0669AA11C7FD824),
    .INIT_7D(256'h7E5CCF2AA7557741EAD8B6DF9C9CADABFA56C5841F5F2A6600EA852E2F3403A8),
    .INIT_7E(256'h991CFC9670B79C2570C882E39032D157D14EFAD5521754DA4B02AED820090672),
    .INIT_7F(256'h6E95C4CEDBBCA4BE47BAC0F37060B5DE02A2EA2E8F3C049CCADC3EF5F4230A02),
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
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,dina[7:0]}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,dina[8]}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:8],\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 }),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:1],\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 }),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_2 ),
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
module Bias_Bram0_blk_mem_gen_prim_wrapper_init__parameterized6
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ,
    clka,
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_2 ,
    ena,
    addra,
    dina,
    wea);
  output [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  output [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  input clka;
  input \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_2 ;
  input ena;
  input [11:0]addra;
  input [8:0]dina;
  input [0:0]wea;

  wire [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  wire [0:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_2 ;
  wire [11:0]addra;
  wire clka;
  wire [8:0]dina;
  wire ena;
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
    .INITP_00(256'hC31B09FF570F0ABD6E7F825AFDB6F0318C5DEBE3F5710FC5088381F37C2770BB),
    .INITP_01(256'h90E62976873F200A8A2E0A1C999E8B9F7E1D1683E47B7CA9256F83A60A9C69DE),
    .INITP_02(256'hBD8C46BDB0E971FD920E77352F462BDD4E5DA13E187580D0CB9CF270566A2531),
    .INITP_03(256'hB01D106D37801ACB797B48FAE7492435E1A6EAC5888D63B4D3D9DD9998EB15F8),
    .INITP_04(256'h6FA72421CBA7985C11D5327A5D8144EDFB867251E36D7A836F29CD72A36D73DD),
    .INITP_05(256'h2A82D5645C917751BB63559BDA570DAB91D4ABBA052C6B8280743514238BBBB9),
    .INITP_06(256'hB7C4B46ED183DBC37239EFF18B697987482FA86C4A59DF09CC13CB73DCB8759B),
    .INITP_07(256'h82F4F660539AEBBB4AE983EE80C94DB29B3EE934105824281A1EC54201F2E492),
    .INITP_08(256'h1C261D8927DE38D4BF67C453169A9B6544D48FDE36CE7F5A6C401372005358FA),
    .INITP_09(256'h3A2C6DAAEE6BB604BF9E5111553F1778F82B7AA32F65BAF3C687A075BB9283A8),
    .INITP_0A(256'h30C15773E848ABF62B6587DB9E65AE97BF31C69BF809D36CA704FFD83788C2B7),
    .INITP_0B(256'hB9BABE966E9535ED3ED8B465D316C4A00744EE32E9D216AA135496A22593C51B),
    .INITP_0C(256'h846908AFF7E9234A97D3F145216839C814B82F0B8244F95F4D66C970DDB241A7),
    .INITP_0D(256'h8D40883AB48DBDAAD1DEA08E14FF78C43BE2CB86A8A0365A5B83B66FA10C9E8E),
    .INITP_0E(256'hBF952D83FEC96C41AB34AE30F59102F37EE0EDC69F35372D5028CBDBAFA00F15),
    .INITP_0F(256'hFA8648576A40112623DBB7D0CBA805566004B27BA1B047E4826800C54C1E475C),
    .INIT_00(256'h5C2B0ECB7B60FEE267508E92D535C035475943D57B335458DA27854828C70516),
    .INIT_01(256'hA28C2FB47CF409CD4BE4746E0A896C0F8D3ADD4BCBDE65B644DC8CAF257F544B),
    .INIT_02(256'h072826EF8CB2B92E5C58D80B841C335954376C19FBA9F3AD08C68AF1E60327A1),
    .INIT_03(256'h7F68CBC082BBDFB6EA38159FA9403DC5FE829080F6EAE39717F08FA0B8318013),
    .INIT_04(256'hF0FECC64801CCB8AA4C5718901072ACD8B55ABF869AF78A7B10D0AE07F877A5A),
    .INIT_05(256'hC0684432EC9CA22B98CA5D246D54D518321AE1FD4084160BB9F684EC190A463D),
    .INIT_06(256'hAB9AFBC0D9E85B8F0C9AE4323E9164231AFCDE12ECA6739BF9B0923BD2D9A9C2),
    .INIT_07(256'h051DBA5B6B60D3F1ACE10CD0AF5628133D15FB24413F9A72871EC38061A99F72),
    .INIT_08(256'hF20A8FB7867A1B55B0801E6048C98B9BE1CB4EBE79D258DDD0DDB930FCBE3A5E),
    .INIT_09(256'hE8B94B78E73C5E64D28208D8F064C1AE674E5AE326B6B5B325F03ECCD4C76DE3),
    .INIT_0A(256'hD88BF48429F5F301DCEF15BFE0E74345AD251503854C19FBE7ED3B88D13A77EB),
    .INIT_0B(256'h0BB9E62BB503BA54C7255A03307CC227B42B7F6297A66691C357C6A072273247),
    .INIT_0C(256'h20958FF13D0C318DCA1BE6FDEAE08AF3055FD4A8E2891A1D5B5E244BF4B0E690),
    .INIT_0D(256'hE9683FAD5F3B6950D6D4126167E265DBF4CA49C86123704123E640B503F7FEA5),
    .INIT_0E(256'h310C498AC4D2EFB1612960948D50FD66F9771A7856358B3CA9FFF82E883E7A85),
    .INIT_0F(256'h37B265A404A721EB964EE491707EB7C28E5AB1A40F5D8EBE0E08FCAB765AB1E5),
    .INIT_10(256'h7B8BBDD51C1972D963951D39E41D99F32AE8A4D2D7AC380DF24A2E6FC1A3CC05),
    .INIT_11(256'h355650085AB2B4E091BF105A4D760FAEFAB81E921A7D8399C79C92FDAA741D11),
    .INIT_12(256'h0724E99AE142C230842CFDB5C7C06FE2DF565B2C4A2581D20E30EDDE00CFA918),
    .INIT_13(256'h54EC6B3F66AEFCE931F1BFC5B0BEAC8E04ECA0D1DAFFF28EF982715CE1E1673D),
    .INIT_14(256'h63384D155E5FD9E70BA6C1FFDE8FB0997F20F8796B8D95F5F5EBAA9CF6D7664F),
    .INIT_15(256'h8519AF4AD05E591CAA82E422016831010547FDAF150AF86A3E8AA4C8C31F9F4C),
    .INIT_16(256'hDE54F1F99E078186BDBE66727E9F9AA864654A50EB7678D3F930E1255C9CB581),
    .INIT_17(256'h1231F7EDA88194E26E60A4987F690BEA0F75DBCFB5858801FA22D53D8EFE4095),
    .INIT_18(256'hE8A99F990A13AF5623EE151CB8E00332F71C6D1D344E56F80ED217FBE7C4F016),
    .INIT_19(256'hA8E81317433F72C9792CBB299CFBBC9B8F4F5F916B30BC3F9C4BCD27FAB54902),
    .INIT_1A(256'hD87D07A37CB27608C3191512D3F6212F6F892535FE8DE39CF50FFEDC47D6986D),
    .INIT_1B(256'hBCE65C73CFD4B1ED5C18434729EF381147D04E532EBA408C74D5E1B8AE43832B),
    .INIT_1C(256'h79CF6E7A495BA6371F6C96A7CBD7A5F291597C76766DBB6F895835C7495A79F7),
    .INIT_1D(256'h9906B2C314AA97C760F6C7C4FD01A5655C4BD46100E7985EE74C10DF18B885EF),
    .INIT_1E(256'h2DF8ACF49066F70BC703341F087FAC1F1FF04483C6090029122D2E46A6362F6B),
    .INIT_1F(256'h2CF1175B19A8C37CE73B40A3D83B902EAB5290244F7D27C68BB7197755CC7B29),
    .INIT_20(256'h7467F68CD95CDE74CF2C991A213189F6FDB8DAE244F0D866C9AC8FCCECEC627F),
    .INIT_21(256'h4DB85AAD0C643282B812F73ECB39166868EC684D1FCB9E35F0FF26EACDE38152),
    .INIT_22(256'hCFDB351E077B2CFF7E93C317D2B53C1C0FEC68FCB18F1A42D3F6149F95E40C57),
    .INIT_23(256'h7255706D5BD980BF9EEDEEF1971633206F86CA5917BBC620442F87739AA6EF33),
    .INIT_24(256'h9FC573A4CD01B3C0EBB633902F856C00A6AC587BBE731ACAE8FC6FF41EEB192A),
    .INIT_25(256'h26D742CE512E008E769712895000160A47EC624333B37CC59E35A5DC304EBE2E),
    .INIT_26(256'h0002690B5E8CB74C8F2F0B1EAF1C0667BF5E8CBD5226B08F6C9FC674CB55DEC8),
    .INIT_27(256'h2EF3F3BD5149868674F361D62E039D90C612F10D55D2083455C74DE96F689CC9),
    .INIT_28(256'h94D034FFBB3233F4C4D58A9560F68EA3ACD4BB66D77FAA66994D065308C0E2D2),
    .INIT_29(256'h91FA4D14548B1BC1F6EED82B6395FAEF423F25A5E7A4A079F1F9E487ADA69E14),
    .INIT_2A(256'h2D7D44DE4F29385DC3463182212815C5129ED733D594DD2654E11C84984CA7A8),
    .INIT_2B(256'h431E9D4875F637FF777A05C0477D2866E6303354AEEF2DB217D33FAFBF3ACDE4),
    .INIT_2C(256'hD7DDD9C53067DAD5B73E457E2DF1C1AA44D0EF32DCDE55BAD0063BE699C8B6E3),
    .INIT_2D(256'h6F6AFC9024C9A50D49C87EC039A225E61451D683B836C3953E87D0C331C8F247),
    .INIT_2E(256'hFA99E8AC50D35647528EE308C3F8FFB4DFD2C8510F29687C5573ECB634D12087),
    .INIT_2F(256'hD833DB1E4CF0E9162CD8BDE4987AD9672DCC1A6B4694C1AC4E4751CCE6B2A27B),
    .INIT_30(256'h0467D9B3CC07B2F1BD4A90D0C1B312CB96352B300D62F114C1E1F9A83AE7BDBD),
    .INIT_31(256'h6C4E13FCB0F1D70843C269901C458BCEDF78A89595A74DE9CE77C0EFF7904D4D),
    .INIT_32(256'h4031FEF4A27C60372A103A423D30214B5145A423A9137551A5DF94C4F9593EAF),
    .INIT_33(256'h3FD9278F0150CDB4C4AC053B99FD9B2C0A674D580026A5090E7EC960E16FF5F7),
    .INIT_34(256'hFEAA3587CFAEE3784961E54C95C857C3B0F103785D496F94D76BCCC4CF2CD53A),
    .INIT_35(256'h07C7F46606B33BAE9F6078309841C2EF5D613383760620956BF1FF4482695552),
    .INIT_36(256'h5DCD35BAAFC354DD0D2B45A33303A736C55DB1E6AC4334228D846240B5D5B998),
    .INIT_37(256'hA15E94C8CECCF80C4A7FFE66876E3CBA25A3804D7E7C876DFF4D36AF8233812F),
    .INIT_38(256'h9F802E1B5997F344201B4792F77AECBD6668B6045095809404132108736BC830),
    .INIT_39(256'hE1EE343A669FE52111225BFFB0916471346F4AEE7D18A7B009C5AA570C87476A),
    .INIT_3A(256'h7AC5F3B9E105A268E4581601F227932D90F065858619E91A20871DC88BE4029A),
    .INIT_3B(256'h9D00A6431D4544319621B0AC957D0CF29831795D31F580B86E00D27F470DFF7C),
    .INIT_3C(256'h1A7FBFF126A3171A054C5CFD39E9678978681F5E4081FE217A330FF982BDAC14),
    .INIT_3D(256'h0222A2F95DAB3AFC9801DB0F9DC43885263EE8D84C777A1411D4D67748E78E96),
    .INIT_3E(256'h39B737C14A1504608B07011509AE0F2438E92ADD8CFC08868FDCAF27485E0E5F),
    .INIT_3F(256'h38E4D84EF04132CE8B6752D29A04B955CBDA0E772DB8F2DD5C6AA1E9F397F8AC),
    .INIT_40(256'h5FC0A7B9FD67A4B4AADEC72DE0301027ACBE32BC5731D7658A3CF32D1701D56D),
    .INIT_41(256'hA55B43D77162A4EA02094B74409220AD6AA5BDED9D5D800BEE1CD00CED3DCC51),
    .INIT_42(256'h333687F6377E1D25F1287D50328248A41AD857771E44E81CF9F7DFE4188A6B7C),
    .INIT_43(256'hE385F25A08FECAEF1A85BECA28D332534DE54F69C38676CA6D48CE222F76F9A3),
    .INIT_44(256'hF666ECDAA15529234CAA5221250790BF46E24FBA5A1C9E866E4161EA89219DA7),
    .INIT_45(256'hAD6E58004164ECFD14EF1728C1366A0A78C32994252BFC2E44F4A63CB364DFC6),
    .INIT_46(256'h82FB8549917469CF98B9027496582DAF3D9699C0E227FF584490F3FE8EEE56ED),
    .INIT_47(256'h9A8FB7BC5C1116CBF382DA2342693AF2E79BFF36AB2BA8854AE9C6BA7F8C84FA),
    .INIT_48(256'hA904E15AE18D9F6B78C056F409642A715DA8CC324B3D71E351D1D9960B79088F),
    .INIT_49(256'h4D97A797D0C52116B1EC87AFDAA9009FED86F48CE50AC5245856C5681220BACF),
    .INIT_4A(256'hF158CD4055AEAED8F8EE4F0BA659A2ACE649FD4CB95324FFBD414D9D95401D12),
    .INIT_4B(256'h55D196B609FF0996720367A35ED6C3067C535990DA60B9B5934908FC5C419DE5),
    .INIT_4C(256'hA5E81AF8E533E7D180A6D5C3E9106680C3DE068BB63A80B18D0315E45B6A7489),
    .INIT_4D(256'hF246D689EFDCE58DFDA0AAA82AF27E77A17A05BD3C9C72CC426831287E790698),
    .INIT_4E(256'hEEC4D26020282841D5DE4D3A172AD9F03D46FD525BA665116A5BE6928A4579E9),
    .INIT_4F(256'h699C03C862F482D229C89B4E032DBA466D70EE81A80669A6051DD302D7DF4075),
    .INIT_50(256'h3ED3DB0C0A9069C96546A0F0D6BF0D14C829CE7FDF258E8ACDBDA573BFB78887),
    .INIT_51(256'h3AA7FB852170D077BE19B20ECAD419CA74C21983AB74C328D2FBEB3E8481AFC9),
    .INIT_52(256'hE58CE4910C8C50970BE7A338DF138BDDD7127CF7FB6C1B0CF9CDC08BF603CD45),
    .INIT_53(256'hDFF46E2BED0484DB61792C49645ACC76F0CE4F095B755509FCEFA97799D3CC03),
    .INIT_54(256'hEE38D8E442E28612F130FC7891246FD2594980FB79632A46527220ECC0943CB4),
    .INIT_55(256'h7AFF75A14548948F0B311D1F1897C08CEF0923316CCF7F53E7FDB77497C4A1F2),
    .INIT_56(256'h6C726892274626EC3CCA3C1647F477DB5D2D977E36A995A57F9CCBC424186B72),
    .INIT_57(256'h4F049FFD78A5CD442D9D98BE6F1D2F847CFAF70CFA489540F4E7A0B221B53DE7),
    .INIT_58(256'h9F4B6A3C45EB48CAF767B624E28F3229F3F6C862FFFE15C728477D9FAE799EE7),
    .INIT_59(256'h078A5B77BF48AC356FB1CC177F409572CDE854C5D4BF76921509704A240765BE),
    .INIT_5A(256'h2BD249B0E9F8BA05A393ABD726AD5C56C9042C7DB958DFF5FD8AF6282E555E78),
    .INIT_5B(256'h9D0997225353405FDB8470ECDBF47B345DBEDFC55015CDDE05AF8CF64E529AFD),
    .INIT_5C(256'h04FE24633CAB0D427A8B849826D4D89372C43F9726A8D2102406181AB5141307),
    .INIT_5D(256'hAF1FFEFF1EAD4BF7E24C3BC80469B18773EA1298682E7196B62BB7638EAAF021),
    .INIT_5E(256'hCBD022ACE394423C226D2C16584AD9B2422FE4020E4DF4288E2984970084A7AE),
    .INIT_5F(256'h954CF959B7D3AFC0845D2BB98D368F997044CAD9A4804E0354AA113441F24FF6),
    .INIT_60(256'h8249209EAD83DA52C2989C970A0DFDD8F8F48F5DD817F7B8CB6E84EBB98FF844),
    .INIT_61(256'hF41E54CAA67DE24EF3D35847D0B3942F78A840BA076636356EC3E7BBC620A356),
    .INIT_62(256'hDF884E5F9292524EB5272995B5DA4209C13C9258A0D8EB18256CEE051522A2C3),
    .INIT_63(256'h273EDF649CF77F4EAC4A3946F8C5A0598BD00F05D7C1ACF6CF20A738533C4C64),
    .INIT_64(256'h985E6213F7FEDE8D05D336F0C13C0D31FCFEEA5C05C16C7DE9D4BC9C6AE9C1D1),
    .INIT_65(256'h6A1BBC7BC118F491689CA09EE3B4E82BE6C35B642CCB33E4141D40DE0541D11C),
    .INIT_66(256'h3E422B678B274B36D65DC717DFC1CA969A141987D47E91F67A2D3952FCA923BC),
    .INIT_67(256'h6C054135DBD6A3C6B00EC28ECB1206AE0772EF62126E48FA4CE530A0BB5FB307),
    .INIT_68(256'hA7511F355789284030158DECE75BF308AE8A815A92A453BA13EBF3A111FD0BE9),
    .INIT_69(256'h2B6BA321C2C6CA5B23A311A3FD50AA2E5736C6CEE2C0185EDA36048E9CF9AF7E),
    .INIT_6A(256'h6E9FA1AA5929EECD3898584287DC0D4F9D8E3E5D5068B52673C4A8551D3886F9),
    .INIT_6B(256'h6343837E8A7A73BDDD91DEFA02E03A8ECD9935B6723B7E341AB79708441D1416),
    .INIT_6C(256'hC478FF07A38A32672C6F522E634AA96ECFFF590E09BB5D43DAF27B3C91DF27A6),
    .INIT_6D(256'hB084D5FB9144A57E11DA3FB8C3C4ECE1F6CEE2F4A819C85F40B76F3FAB899A06),
    .INIT_6E(256'h3FA026975538405E7CE68A731427DB77CC7234DF9BEA6FC3A794E8EBEA9FAC64),
    .INIT_6F(256'h8A913DB42142E119A1114B1475C1A2DEB36E248321277FC0046C216C911ECA2E),
    .INIT_70(256'h251619BCA8854718F228C56CA8502A5B474DDDFD1A1E3F15DD9E188D826349D1),
    .INIT_71(256'hFEF22CAEEBB6B6340F6A44C2D731FC2528C51BFE35367D72E8B9DA92ACD4D1D5),
    .INIT_72(256'h6258F8FDBEFB58A8642506900A1EAD67045F6184F4CF1A6697C7A54CCBDE6DB4),
    .INIT_73(256'h8EAA6B1BF2457E368340AFFF3842E380E15A7BFBF1361B4CF7593AA39968B721),
    .INIT_74(256'hD048A3F31C392CF088394B7B4D16C0466DE303ED467981AD707B24866D570EA7),
    .INIT_75(256'hA1E5D172A2F504E2590C3479C5A027712AE0EABC8BE71C6364D31844CAFE2DA2),
    .INIT_76(256'h9810E29771C74A927AEF0CDB6DD106564475378C6CA39032A2D6E5E788AB7BF7),
    .INIT_77(256'h5C64C8CF959FDFDE6D816D7F31796B0C51DCC0E609D9C06610ED2B33F23494DE),
    .INIT_78(256'h357D7F274CDD93CF5EEA7C0556C44E5AA315CC02DF5503A9AEA2DEB45C804C5F),
    .INIT_79(256'h8929051E5E1E1A505490B2B8887920089939CCDF74D1F2D127CC522784F849D1),
    .INIT_7A(256'hAA4389AAD89288B84190656E777141C4F1F6CFD3DDB9BA54885BE16D09CDD1B9),
    .INIT_7B(256'hE0F02544A84E86BB9F72DD991C6DB2270ACCA659FB37A5C1A9BEC2C7DA82CB4B),
    .INIT_7C(256'hB4BDB071920C499B99046BD8914974552E68332ADEC6EEF3CE3C474843DFB4BC),
    .INIT_7D(256'hC63BEAC157189A145DC3BD9070A12394FD466BE3B82A0348359B57F857821879),
    .INIT_7E(256'hF9119C3326B6C31F82D6A56356A10BEC46B90992B40892121835315133B71A54),
    .INIT_7F(256'hA20F62B34D5B936EF3C3C8A96A45DB65B94AA2F33946D0E0F8883E9F7FE3A2CF),
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
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,dina[7:0]}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,dina[8]}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:8],\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 }),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:1],\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_1 }),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_2 ),
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
module Bias_Bram0_blk_mem_gen_prim_wrapper_init__parameterized7
   (\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ,
    DOPADOP,
    clka,
    ram_ena,
    ena,
    addra,
    dina,
    wea);
  output [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  output [0:0]DOPADOP;
  input clka;
  input ram_ena;
  input ena;
  input [11:0]addra;
  input [8:0]dina;
  input [0:0]wea;

  wire [7:0]\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 ;
  wire [0:0]DOPADOP;
  wire [11:0]addra;
  wire clka;
  wire [8:0]dina;
  wire ena;
  wire ram_ena;
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
    .INITP_00(256'h91E79989431F1D045782626337932C1E18F347AF086EE7CCFF78EF2D036C179A),
    .INITP_01(256'h301BC99571A3C312E0B88101F16542784047ECC09B6ACD2FFFAE9AE7F499D3B5),
    .INITP_02(256'hB5B7CF2F6F54AB7EFA974CB96EFEEF44D0B325CC64D172AFECDE45F5A8B34BB3),
    .INITP_03(256'h0E4F67CF9557CF841A3505C677D8889BF8B817F43DFE03D56AE730BD1E0DD269),
    .INITP_04(256'h9A880F519F7AF9848DA98B6F878CDD19386FC19C205D6C80F72CE3047558F748),
    .INITP_05(256'h730F5F77F4AF4B4E46464522DE366428B60CFAB0D1106180AE723A0F3DD5D9D9),
    .INITP_06(256'h683D2B6509B8B647256C1267EB8852C4594F33A76CFED7FBEF6F849376472B62),
    .INITP_07(256'hA8FEF78DFBB63C5E1975594A77DF76A4419B4215BF60F5C06B27213E29149712),
    .INITP_08(256'h4FCA84AADFD07753F56C4F5C331263B6A14748071BEA0495EB3A91A1159826FA),
    .INITP_09(256'h7C80F21E4B653117C26E32B8AF92876215B4432897FB4D7AFEBC6CA610C461C9),
    .INITP_0A(256'hDD412D13D6CA2FF9F1C998537FD5A7E0AA5CD2100CE845E31635148E0537CECF),
    .INITP_0B(256'h73152BAC9CE5F538836D327C06E9E7E9042FFBEEB56D6C629BFEB42A82F40269),
    .INITP_0C(256'hE99F13FDC6500973722EBB811EE6D27F5309E581E133C200CF92A1A57A054277),
    .INITP_0D(256'h29015DF2DEA8954DE0A490CDA779CE5643CE60732C519D6654C0D0E2428DF671),
    .INITP_0E(256'h53047DDC71B8C80066DB8BA18F5319C80AB88F615F35430837FFFB435F592D88),
    .INITP_0F(256'h58B75DB2DF4F80A9359FCF38458ADAA8D6E4916483485E5FA2ADC093EC2D8125),
    .INIT_00(256'h624D3E7406CD7B790DB92F0FA4022C3BC3D099F8B2A8DB7CAC4A86DA1E115F6D),
    .INIT_01(256'hFCAA68E1C3555B5D5AFC220987DAD54179EFF1377DF0B0596563EB2DA693CEDE),
    .INIT_02(256'h1AD6A23B963D3C42B868EDA1682C02D09823275AA9A39FDDE20C9FD971265054),
    .INIT_03(256'h31AD2DDF92EADCB38D54CA969737083391189F4255641DD64500F9AE4DD2998B),
    .INIT_04(256'h9BAE93C44966FDC7563C263BE1DF99E8FBF23005E2FA5570E9B01FD7036BE42F),
    .INIT_05(256'hDB2574B51DD24A9673EBD7B50DDF54FE7E1A79379716001DBC6776BFD498B600),
    .INIT_06(256'h4E9150BF4922D86559220A2661822AC5924C5B341D0EBB790CC6273600620246),
    .INIT_07(256'h4A2441CA8982A16820F36727F7230FC29311DB538ACC32A3195F9ACD109A927E),
    .INIT_08(256'hE798EDD071174A8039BCADCEA1F3F9A22A5BD087EF7613DF2169EF3130F74FCF),
    .INIT_09(256'h535F3E2720CB65CFFC61E5BCECFA47930DAB9D8421663900E0CFD2813AA0160E),
    .INIT_0A(256'h411C3AFBB5328E8D22C256E4B93681232E313B47473F61CDF45EDF4986208DDF),
    .INIT_0B(256'h62EC75CEA9166DD41CD8BEDE4B4411BB929C1D4C18E6A2A5CA264A4D88C07214),
    .INIT_0C(256'hDE57FB085F4B0B9AA11EB9B30D37B2FF183BDD81D9001B37042CCD902E731A54),
    .INIT_0D(256'h823B41CCC945DEFBA3FEFCEB6E2C0C3E1D0D3D929A225767943C3F23E2841963),
    .INIT_0E(256'hFD9BC3075BC4B38364D8A00154F440531D63ED0CCD32BF9C80664A738EE07BF4),
    .INIT_0F(256'h1B35396C639D575DA9F714BC9B369979DFC784EA13A21945CE69572BF8553291),
    .INIT_10(256'hB2A93F9F0203525DFDA9BB22CA11201461E77B5B8FEBCB61CFB0EEE2C287FCB7),
    .INIT_11(256'h85080CF3DDC7D88E6223FEEFAFE7199B0CF7EF90CE8847DB2678DC8056F557BA),
    .INIT_12(256'hF84881D172B612CAD4074E86452B12C1DD6A9034AC7169B413343BE9EEC85FDB),
    .INIT_13(256'hA13947C5F85096FB0B75AF9CC48C48C42B56D5F4F1984C9E96B0E1BB24530A61),
    .INIT_14(256'h910C2E8247939C3EAC7BFA109C092DA234F318E247CDE3F2080D2D56E16E71DE),
    .INIT_15(256'hC1908524C1857E3BEE0BD959F017F8BEE48C0D714A263A4E12481E93B033FB9D),
    .INIT_16(256'h43FD9851CCFBC30F92059614631C783A99535FF51F5C9AE7AFE353D10CAC6D93),
    .INIT_17(256'h548FBEFF3BC9A3EF78FDF247882FEC7B790159B1137EAF872D962E3704D76B5A),
    .INIT_18(256'h079FD5F1AEF1E570839A0B8A562E165D5A60217044F7DC5EAF24B52B65574843),
    .INIT_19(256'hF5E96012EB43F50858B26F035DBCFCA24594912C801413562B320A43956F13FA),
    .INIT_1A(256'hC1E690F1F5C6922F95810B1078CD3AE23981DF7E2417AE236E9EF48D45EA8953),
    .INIT_1B(256'hA3183AC083050A4092AC168B140FA4F8F23A7226102E01E027AB8FDCF236B6FD),
    .INIT_1C(256'h449B38824C69CBCC972E7FC83A533510D917D98CE8D7CED662A246CBE5FEA3AC),
    .INIT_1D(256'h31013015E2BEE0617615A9300A808A00A5606BDB58C6D9346A0A057116F4D9AB),
    .INIT_1E(256'h27D9897D1AB80100D7FF7AAF5133379CC31AA43A0FBF6F85570E1FBAF6C126EA),
    .INIT_1F(256'h293CBFF47457A558DAC5C02B5F1903F0C0D2E42CC0F2C700D651CCA036AB6CB9),
    .INIT_20(256'h5E78326ABFBA16880EF232AA0C8A406C07E933C3B3309DA4A27A4168D7402A0C),
    .INIT_21(256'hC83A09682C27ED755B7294950DE847FCB3DBA77221723CEF4014AD3F9BC58F2C),
    .INIT_22(256'hA9F4BC0A361D140025F4673E58E5A37434201E932EEB521DFFBCBC62024D95D2),
    .INIT_23(256'h152D1CA167FED8D171D55B519B9F2F475CFA589CB8C0D9C39E3A75E7CF1E5075),
    .INIT_24(256'hF2EAE9CA7906BF519A9CCD2548F0B89D39BAFC65DF16590AE69F3F5CBD871004),
    .INIT_25(256'hED0F77465A9F37B821216D5346418D78F22B617022423A54CF6DBA02C876AD39),
    .INIT_26(256'h3D6DCC1C9025601C8A6665D1085F16FE3B34331125B1739967E2651D0EC095C8),
    .INIT_27(256'hA78074D38FAA15830529A78CC001AC11AA8441EFFC1439BA7A0A8C10E2AC91F1),
    .INIT_28(256'hDEBBFE3684E555E9FC1DA64BC7E468EE5DDCFB9112D81837D849929867C9F170),
    .INIT_29(256'hCD59B8E60BCEA194FB6BA9DC38525BA86DEA7EB33061E8DBE085FC5DCB567F1E),
    .INIT_2A(256'hC8B75AEC4F956119B4484846308FE071D511098E6348E1526347725DA7BBA04E),
    .INIT_2B(256'h67338B852C86970E2E593856B5D9B6859D4C88B9A8B7AB577E5C3819849802D3),
    .INIT_2C(256'h82D97727563CBD31BCBD44EB00880500F4D2A7012BA3D759539A40C4BDA79B01),
    .INIT_2D(256'h082684010F87985CB45B873E261ABB2A5FDE0C3743308777245D9F9FB4389997),
    .INIT_2E(256'hF4A5D3AC82D961065AAC49E9A4DC569B994CDDB9456F2DB2ECD057CCFB8F8325),
    .INIT_2F(256'h2065B3BA1856FDD91330D370E582A3A71C15FED08E62436A3812867ED4D87D2D),
    .INIT_30(256'h6067C17D2A8F1BD7F0DAD789381C9FB00A037D22B61D746898EE533A920F977B),
    .INIT_31(256'hBBF867368B2BB5A2EB5B2CAA6AEC000AE48CC86E694FF09A6B20C8246C0C3516),
    .INIT_32(256'hD3A42D74670571AA5A0ABC26DDB02DFEC2D6ACE5C743435BF269A1B2CA2BF8F2),
    .INIT_33(256'h9659BD93692FCB73F7A3BA32460C438CBAEACF57027565CDBCB6617EC878D8AB),
    .INIT_34(256'hC54C13EA2D31B69324121DCA3C1FFD6FBF4DE001115B23C34079EC633117CDE9),
    .INIT_35(256'hEC26863CA8BB5DF1D4CF3F0B232D54C966D3387305DD2578C449D3FE8742EFDB),
    .INIT_36(256'h1CF9FD2C764E699311BF4A93F81F13921F36516F3756C844FC65CD03C127671A),
    .INIT_37(256'hAF953934FA80B0D416B455E48E00EA80DDD9129BA168E035CDC10FEEDC669A4B),
    .INIT_38(256'h57CC0DBB55805BF82F824DB283B8BC1875C1CBCE3FFC974CADA9C840D1546A1F),
    .INIT_39(256'h6DE3F21BC650420C38706E1B156ADF0D49CC5C478C14281DD0CBA11C27F692AA),
    .INIT_3A(256'h34EC96C4C8AACDEBEA7E6725A399A613C7CD89D97FF7C625E38DDE7FA6322F44),
    .INIT_3B(256'hE935A122C208CD866560B1371DDCF3BC5C571FEB7ACFE902F46A5F9A9A72D640),
    .INIT_3C(256'hF44B4E49C39D7131F2D09C7D16F5059B6285B8B5BB6FDA0015AD51E3F5228AE4),
    .INIT_3D(256'h8ADEAB563A49C932F8C380AB7C79439B5BC556103CF3EA8C44B94BAB88CD730D),
    .INIT_3E(256'h0DC801D36048074BD26412A8D3045561DEE401C592DF9E40A70685B1A68ACB6C),
    .INIT_3F(256'h7AEC93B4568BC5D3AA923B13A899449D42ED258B6EB37E6A56A6EEBD08421F3E),
    .INIT_40(256'h93BBE9A28A3CC914663F61BB6C2BDAA168587E7A90D78F55A3EB9CF7F55DE772),
    .INIT_41(256'hAF5DE8B2B6C70CCE305E9948D509C22DE937839E2D56E3D1A09F5B352112D336),
    .INIT_42(256'h47DF804A44477064311D39BBB575119EBAFECC7F71D9A80E57667863A72C08F8),
    .INIT_43(256'h84720FA35E5508EB56CA76DE5ADD5A751B2B4413EDC47D32958651A1FDB75358),
    .INIT_44(256'hD7EDB5F110004F0D8474DE2F77DD9CC4AC0A37D8097CFAD307384A8F437BF04B),
    .INIT_45(256'hFC77E1C81DBBB93DECCBF56AF78D8CF4FCBC8AF5470BAD97325BF5E76C306980),
    .INIT_46(256'h5DCF3126881459166E18C30D94563F344EC8B533070292CC3DF7E0BEB77E28A1),
    .INIT_47(256'hD4E2A93F5B211C60054C394F262517C9FC3A0D9AD75DBE5C98CC90E7422A97A4),
    .INIT_48(256'hB058130988981773EDF516B07753B66296BD096C19A35C45954BD9865F7F9663),
    .INIT_49(256'hF56AF0B02BD290C70132D7FB7B3E369F0343EBE497E73080156C3D5E1F8DDC6C),
    .INIT_4A(256'h0ECB2C24E31CFF30BA922A6BBFEA3D696E12C09E2D9F5A470542C115A8864617),
    .INIT_4B(256'h392FA27992C1BE7B27279E6909222950F5914318FCC8D80283F5192B1E3F00B6),
    .INIT_4C(256'hED44AECC42C7EB0645001C259DBBB558D35D6192F81E7E6EF5095D4C74DA62F2),
    .INIT_4D(256'hF1E14486A183FCD939712F37EA67D48E36DD3CD9DD152F9B42D5D92EF6CBE4B1),
    .INIT_4E(256'h58145390F1EEF9AAA61A755346527B08A3EBE3AE9D78FA9F556CD7A73FF875B8),
    .INIT_4F(256'h8D4C9B3CC6BD2B18609A24006CA5B7675014F5F0C6F0215AF81E1523BA8ED5CB),
    .INIT_50(256'h0FC96FE1FC27F3C85B08A553D6C75E8ABC8D539836180C40C7D8B55A18842744),
    .INIT_51(256'h729E92FF346B1D01C2757A8E26D380B44FF42A11EC45CFE160F313562ED38E39),
    .INIT_52(256'hB329BBB3247879DEBDB643B756DF9B35D67A1FF22EF6A6AC5D174B2AA31324FA),
    .INIT_53(256'h9679260A242AD714CADE77854B5FAFB2AD554699D94B79DF6D1ADB0206C4B6E3),
    .INIT_54(256'h2D9C7093120430B0C8DCEA9D3F13D9AF0114F01F71616BF19B4EE882A6A15706),
    .INIT_55(256'hA9D66CA4F3A9C8765960D098CA8D233AF6795B37A7B253CD97B3A0C23A5DD868),
    .INIT_56(256'h07284517A2993056E840FF7F4466B529768866FD867FF5725CA3E07C815B8B8A),
    .INIT_57(256'hE74D508B3D9D21FB1006478CE05EB04F2600096410F5A749D213A0814407A4A0),
    .INIT_58(256'h98EB1AEDE9FC167CDA151DFAE8FDA90A0A87B6E9317A68F18DF0324F04CB13F7),
    .INIT_59(256'h70AA4D20FA0FC1FC0894D9EB9F57E7EAA9AB44D551A55641FEFA27FBBD4DFA3F),
    .INIT_5A(256'h0DFE946EF70AC0AAA267ACEEF8925E0AA20642B24E2DA84EFDFF1B288BB6C599),
    .INIT_5B(256'h0BE8697FD5646800EF80A4567A0EF01E46AD6919AA710D8C9DA6DEFDA69E4867),
    .INIT_5C(256'h38C7409230D38CD05BCD9EB111DFB8CB2EA44E9C40242A799AF0FC0615BE9EC3),
    .INIT_5D(256'hC4A01EF12018E3148FD407643AC6FB7A16B0C251F88146882E2C35AE3A926643),
    .INIT_5E(256'h9D01B14EA1EEF505518EDE631D2605B0601E6A43C81D8E40E6A53E5C565E7BFE),
    .INIT_5F(256'hE06196CCA16E70AF25E3D0B8DDEBA9337F4C3FEDAEA03A42DEA5FCB9B78B4827),
    .INIT_60(256'h8FC6EDCCC1C6FD52B1B7A528C8FEF1C747A100EA259C7B03B1711D778CEC31E6),
    .INIT_61(256'h4779DC6DF8A0431499BBE57C0B2849D4D92ADB3CCB17DD85402EF8B0F3CCEA54),
    .INIT_62(256'hC197B2427F639A109AB0EAA60C61EFDAF896E3B553D7479D885CF23D530FF38C),
    .INIT_63(256'h564F6F0E10F78F91BD3FBF18D3BDC3515B5E4893249331AAB46BFA1835EE9DA9),
    .INIT_64(256'h00366B08FB024C7B4824060BC4C554DADE9C5E9C5C005653D147BE34F5D0FA74),
    .INIT_65(256'hAA0DBCF5771A3BBEAE7EBDA28C07D05CF10AF55CFE25D1E96905749BFAF0A31B),
    .INIT_66(256'h668DD3689B7A53C87F2AEDB40411C752AAA438CA434914DFBDC6FD0C05E8F73B),
    .INIT_67(256'hCAAA769528A1FA32F6CF0475B822E1491C627A7CC292250990CE4D044D1FA53E),
    .INIT_68(256'hC4847E902BCC9AB881168E19AC80A11B289FAFE5F666C797AC08311CD0081881),
    .INIT_69(256'h4A18969AD3E7AE463CA576171F4A103874FA6A2C2A2F758315697F41A21FA97B),
    .INIT_6A(256'hDF0132925E367033C91DF7CFADD01ABF70FF1A73170E5857DD849B8EB4C7A59E),
    .INIT_6B(256'hFC94149533B467787199FE16C6F31431D24EE357EC13229095ECC2F57B51C98F),
    .INIT_6C(256'h90CD19C28AF727CC3A98FD4493A7A09C19BE692315411B91D09D7E722887D3EC),
    .INIT_6D(256'h6236986608331F9B56F011E4E2CE27AEAC4F1BEBA3430DE2A8408EE76FFAD332),
    .INIT_6E(256'h9389D1A5F94291A594D767C7E75F2B7A00EA24E70EF9F49079E093B421853ABE),
    .INIT_6F(256'h368301A02B081BED1003234ED4096BD56C2BA9B8276CDB792F1DBE7B66BDF452),
    .INIT_70(256'h559F05FE4A072D7C455C98E623D6C3A21815DEE3F5679F10D46F37C52FE4B217),
    .INIT_71(256'h0F1852AC25E13810D5F49CC2C7FE31F17643B758E9F806AE2228A89051C93610),
    .INIT_72(256'h3079CCEF6B892451F5026D2148715A3133239B620D46D96280FDFDCAF1E9C3DB),
    .INIT_73(256'hD0C86D5A5D355D9FE882B7228CF3DC27157A5DAE1292F65FE7115CAFE084E60E),
    .INIT_74(256'h3D5413096F059E01FC7D83C45C5E3C1D4590C3E57854C1961C78B11A4A130DA4),
    .INIT_75(256'h805245AC89DDAC38D3B9BE7EB0FC0C51A1EC2E69F8F6F3A234FD2C5881119AC7),
    .INIT_76(256'h30AB58B4A1D3D472C0DB4369379247C3421D063F19A830E98D7EBA3D20BB1EDE),
    .INIT_77(256'hAC00AAD28CBA4CEE9A1000C3CFAA7ABAFA1EFC85B4069B409B53084EDADD7BB4),
    .INIT_78(256'h6232A0DB624649C7C22A8CE700C8B8B4B9346BA451259790EFBF792F60B8E5BF),
    .INIT_79(256'h873B722B005A866A69E00A70A0F5B30D1BEE27F1ECE9E4FAEF04DDF0F233CC13),
    .INIT_7A(256'h5A4C6706C181FBC31D89BA4B0A471A27EF461617E5FF1212868D148AB3E9BB05),
    .INIT_7B(256'h894EFE4B5A06EC87FD8D0B05533053DA15C8702F823839CE7A56337EF52B7964),
    .INIT_7C(256'h44A710748DC5CDE0D5237C3F54B2ED14AA963E9A7BB4B89E57D74A74D150ADFC),
    .INIT_7D(256'h214C95D2F233ED20BAB5633757EB34CD9EADA57A8A8B39F32A456316A2E119B6),
    .INIT_7E(256'h04436870C86274D4026CE4DA2CABB1DAEDE85ABA1F9BF87BFCC982C9EE12A458),
    .INIT_7F(256'h625C19B68A2E1A985C05F0CF982840FC677FEC1CFC13B28B67A908346B061270),
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
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,dina[7:0]}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,dina[8]}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:8],\DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_0 }),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:1],DOPADOP}),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ram_ena),
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
module Bias_Bram0_blk_mem_gen_prim_wrapper_init__parameterized8
   (p_43_out,
    clka,
    ena_array,
    ena,
    addra,
    dina,
    wea);
  output [8:0]p_43_out;
  input clka;
  input [0:0]ena_array;
  input ena;
  input [10:0]addra;
  input [8:0]dina;
  input [0:0]wea;

  wire [10:0]addra;
  wire clka;
  wire [8:0]dina;
  wire ena;
  wire [0:0]ena_array;
  wire [8:0]p_43_out;
  wire [0:0]wea;
  wire [15:8]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOADO_UNCONNECTED ;
  wire [15:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOBDO_UNCONNECTED ;
  wire [1:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOPADOP_UNCONNECTED ;
  wire [1:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOPBDOP_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB18E1 #(
    .DOA_REG(1),
    .DOB_REG(0),
    .INITP_00(256'h32329FA95589A82007D38CA25BC2202BAFE150F953F2EA979037CE0915D234E3),
    .INITP_01(256'h2A5750D9E89B337605CAC454C45ABFCA314D5D8E1F2961A45507FF2D51C1834F),
    .INITP_02(256'h65929AB8CE2429CB23449B109809CE764B4164D2006B9A6A9BE156E94C76A18F),
    .INITP_03(256'h0A4B0BA8355274CA8FB83470A3F10AD13D667FCCCFEF72ABAFF1EBB63309F624),
    .INITP_04(256'h252B21B9D05A3AA9E1E8EF95E8F1660086D0E7525810561541C4FB13C28799FB),
    .INITP_05(256'h9AFA40FFB94539CC87AAF2EB9A0C5AEF622F8F09A45EF8956A35542D7E2CEB51),
    .INITP_06(256'h000000000000000000000000000000F312B7394252AF0302BF5D0782388CC82A),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'hF38358AFC00E0AAB61C925ED676880852470F0122C5991F96A500E63ACAE8E5A),
    .INIT_01(256'hD2A0D56F6FF31073F2329278097D13F6BD43174190E9FA509D2A05DE2F6D69A4),
    .INIT_02(256'h7D8A8EBA0D4EB82D58B7B13852748382BE588DE042D65804F0B07E4DB3022E82),
    .INIT_03(256'h5477B7B98D422F2E213B5D95F42A42CAD09BD1A8A01422F61E7ABB9EB5A7DC90),
    .INIT_04(256'h1434CEEA4991AB899AAA5DB73C8B077586A10E92181C3DCE8CB1672782A149B8),
    .INIT_05(256'hEE7C425FF67CB9D2E5483BF13C7820E0A4374B42390FA1EF8ECB5280C6E52718),
    .INIT_06(256'h390278D254849AA95B6317DE90EC13012C4521B12F73CDAB616337300F947706),
    .INIT_07(256'hA837B7E236D650E6461D832A83DDBEE795AB07E029DC7EDF3157B0C007C3E69E),
    .INIT_08(256'h6613E304B406F203E3A215C1D893513435BB6CF41FD3DFD8AAE869A26F41B5AC),
    .INIT_09(256'h5E4AB62161A76BFCDA9BE641A346801407A23232E3BC6BB571F60DAE798B571D),
    .INIT_0A(256'h3E598C18EB0373FABE44E11BFF0FDC4376B75028E50D3E6773A8E7B057DC29E3),
    .INIT_0B(256'h3ACAAC48CE19659A2AB151B32F93B3FD3AA3265B67EE6924B774932D49F80FC3),
    .INIT_0C(256'hFD65F6878D6BC5C33A5FDDB128213264047DD41D9DB63B29DB15651657D8B84A),
    .INIT_0D(256'h3A6F67851CFA73EAEA6D545ABE013D379B045DA0FFF4A78D680334DFD452C742),
    .INIT_0E(256'hE835040FB2D1C80CD00402C9B772C711831C9E6939496B0B5F678B6A0BA7E039),
    .INIT_0F(256'hEA3FBE4F44B9A03B598D1C8A2471B1C9097CFB68E1E31692BD03361ACA63ABB4),
    .INIT_10(256'h46288F23454EE7486EFD0DBD5E3B27D6D30586542065B90E5F7F2A4C52B2AFF9),
    .INIT_11(256'h6C3D93E3FD2F3834B3719E9AE80B5936C94252FE999AA57337FF3626E9DCFADD),
    .INIT_12(256'h93682CC3C227AB3BEA74FE197C86020E8CCE90950C031FC6E8C81EBAE7A31890),
    .INIT_13(256'h809B68FF389A35F6D9A50CDFECD53B9D2858039290C8E12C2F4EB55323276C90),
    .INIT_14(256'h83D1BF4EC4FB3B3A93D3D74CCCFF46047C00A4928316C737348F162EBC5414C9),
    .INIT_15(256'h63997465D5C926B5AE51542BC28AFC1DB4CC5534AF96627AC42D5E34AA89FDE1),
    .INIT_16(256'hB217CB8E5907BCDC1BD1B73009D239ECC152A987C9F31A9D3BC8CC325D493E05),
    .INIT_17(256'h6A11EBDA1C1B2933E5B90ECD355FFBA31A7905574458B1B4D977E386D441A739),
    .INIT_18(256'hB5F23657F87584826CE4BB9951C99324CC0BEDD53113B86D37E9B0AB2DC6F928),
    .INIT_19(256'hC291BEAC2D14D10CD07E1C146C50088C3AB1762604416B82A05D41033CED60DB),
    .INIT_1A(256'h7DA93860391AA50AF2725D5029C7D3E343D6AB1C84593D5DF2BC8B56858BFCC2),
    .INIT_1B(256'h099469D44C55A9E1507BCA76475EF86301D332AD669791D07A25AA707884ADB6),
    .INIT_1C(256'h5B4BCDDEB8547BF26C108D7C6E7E4BBDE3B07D15AC895FB5BBFA134098F91A5B),
    .INIT_1D(256'h6CD4C632F7273B91B19438ADD1DD3973AD6749F79DC5DD5F250DE884AAECDBA1),
    .INIT_1E(256'h25FC1DFDC5C46ED659C69569668DEB0113A669B37A2A0F9CA354067AC5A324AF),
    .INIT_1F(256'h42141EC1B7BC4D9DB09D328F01DC20C90F1EB70E6361E60477C3F7EA91608E91),
    .INIT_20(256'h5E9F7DE6BA50A16CBA38DF2FBFA2DC1C19C2354BD1936E74C1342B281B204437),
    .INIT_21(256'hE5A35D28569872CFC30023713CA87202F763BE9756E264E2427456B208A4D33E),
    .INIT_22(256'hF681792099A60D3B24C70F0ACA8144CCBC3630587714AE35B482C1C4F1CC53C0),
    .INIT_23(256'hF34820C6C657B54C14409D68B109C5E7957CC87F20C6494A6E9C610F6DB231C3),
    .INIT_24(256'h262C6FB70ABCCB66A48ABEDA383D11ECF15A5ACDA8E5B1E4145FACF1FFDE0348),
    .INIT_25(256'h88F8430A51344D48F95B987CAB58874C36B5C9CBDBE3FB168FBF9982268D1D4B),
    .INIT_26(256'h1E8C48C095BB05A8BEDA222C40591AE2C7A4AEACB27231FEF7E890C005E1369D),
    .INIT_27(256'h65DB0AE513C1CD19C51AF31050BDFB6BEDDE1872A064B04D5D918B1F95750748),
    .INIT_28(256'hF5E854BBC45E82BC8E21434681B78FDA4622DA865EB9AF5F5E7975FFB5B5A343),
    .INIT_29(256'h59E12DB90EF1FDA66333B6504EC0F1BF8CE5F95316F2925F566B2C4B58FC721C),
    .INIT_2A(256'hFABA15BDACAB93E6F8E0A665754B145F122E6CF69E4E8601FB760E76B130E857),
    .INIT_2B(256'h4AC473E7756FB4ABDECD98FB3038D1D06FE6D3A8B46AEB1DFE9B494AFEF1BF05),
    .INIT_2C(256'h6919332CD0815C61769C867D1DC4FA6316D45B1E601CC8589DAEC3E514D83537),
    .INIT_2D(256'hCEB5F0A53521B38E73B72E1D69BD7EDE69F80C64F8D2E9FCC9D4A93A02E08D58),
    .INIT_2E(256'h0A28586A9CC8A721221865FAE0EBE1CFA10320BF48FDBFF6DDED58BB94D3274C),
    .INIT_2F(256'hF7514A1ECB3A4CE0FBE560041FF2FFABBF790523857E7E7B50E247FA886592AE),
    .INIT_30(256'h37D837990B4B566E204E58F56C214305CC0F573E27451F8268C97B570DED9E28),
    .INIT_31(256'h2E8AA695ABE7E0157485CA32B8322B4B74E8E510A94B5AD6ECCBBEC42E69499D),
    .INIT_32(256'hF142F1F87FD55873BF67E6CD3B50F84AEF4502E8390A6DF56543E19681FD5876),
    .INIT_33(256'h99DFB5F4F2DCDD91860FA41F333E044758B770B22466B670E2691599F0DFCCB5),
    .INIT_34(256'h000000000000000000000000000000000000000000000000B18715E9D313BB3F),
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
    .INIT_A(18'h00000),
    .INIT_B(18'h00000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("PERFORMANCE"),
    .READ_WIDTH_A(9),
    .READ_WIDTH_B(9),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(18'h00000),
    .SRVAL_B(18'h00000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(9),
    .WRITE_WIDTH_B(9)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram 
       (.ADDRARDADDR({addra,1'b0,1'b0,1'b0}),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,dina[7:0]}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,dina[8]}),
        .DIPBDIP({1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOADO_UNCONNECTED [15:8],p_43_out[7:0]}),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOBDO_UNCONNECTED [15:0]),
        .DOPADOP({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOPADOP_UNCONNECTED [1],p_43_out[8]}),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM18.ram_DOPBDOP_UNCONNECTED [1:0]),
        .ENARDEN(ena_array),
        .ENBWREN(1'b0),
        .REGCEAREGCE(ena),
        .REGCEB(1'b0),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .WEA({wea,wea}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module Bias_Bram0_blk_mem_gen_prim_wrapper_init__parameterized9
   (douta,
    clka,
    ena,
    addra,
    dina,
    wea);
  output [0:0]douta;
  input clka;
  input ena;
  input [14:0]addra;
  input [0:0]dina;
  input [0:0]wea;

  wire [14:0]addra;
  wire clka;
  wire [0:0]dina;
  wire [0:0]douta;
  wire ena;
  wire [0:0]wea;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED ;
  wire [31:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED ;
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
    .INIT_00(256'h36F8D6745538EC11B6A69A9BF923D35BE5D3627FBC67031EFA5EDB601D89F272),
    .INIT_01(256'hC7DCBFF0E957E5730ED0671B186FF29C6150F7B28FF2CE1EF861E4E43147E88B),
    .INIT_02(256'h8363BFA6CFBC14A5C6382766B818641AF8EEC75BA1BC06ADC68095578D8E30AD),
    .INIT_03(256'hB12014F92144C93A0A6451C3EF55F8276B8856B9E952B38822160299CD6B9269),
    .INIT_04(256'h5EBD5E35E43C671FA67449A59F229EC49D1EBC172A2CA98D30057920C5BF15D4),
    .INIT_05(256'hC220B1A2C537D13BBE04566E75A2A7094945BC796AFA1AA907A8E555428E741A),
    .INIT_06(256'hE82955173B10CB993F2CC9B88FC88C700DDCBE4800E495246C6C5E12A246A217),
    .INIT_07(256'hD7C8D3FCEAF0279CD74E7DB630022E7F04C5739690BE42C380A7C44918DC0092),
    .INIT_08(256'h01BBF3B500F3A0B8403778FA394A51FCFCFD1765EB33E27D26496B634104530F),
    .INIT_09(256'h90DB09633CB7B8D63CA3986BF12F3F12A0CA76714D77CB3EF7DF995800FDFCC1),
    .INIT_0A(256'hA3EA1AC6097F2128CF008658022DC40870FF5A3F4EAB7BBCCB7CB40A044DCFE4),
    .INIT_0B(256'h59C1407B8038B31FA526088D187628E0C13F9753CAC526253A18FC54D8732E43),
    .INIT_0C(256'h944EE990B6710A6708EBD86BDF3E1313A3864F1E7B573DD2B99BFDF42723681C),
    .INIT_0D(256'h86FDD5323D4C2E0AD3F0250DDB0568588541433C4A908F972F8CAC0E253E7B0B),
    .INIT_0E(256'h8170ACD8EAAC7B459A30CDF9E2B0DD744A6E11CDE7D14A56B2E50A86622EC37E),
    .INIT_0F(256'hEB84B8ADCCFA35BC34B7EB13512DCA8D265A59266486F53FA91CE6611A7991A8),
    .INIT_10(256'h91EDA60EEABCE9B32CB1AC822ABD68940A16B01B84C72DEBB3EC08CBC543C487),
    .INIT_11(256'hA15902CC1897414E05F3E60C4A6B5AC8F78EBC167A4BA2BF2007916FE7EA8F1C),
    .INIT_12(256'h4F7DCB317DA5AC5B5511BEFB445C43B7D597C3CBC259426810B727850A1D0598),
    .INIT_13(256'h213D83F612F51DDB3A9BB6CA4C078E9E7A268FEBCF8386FDC99435991675BB4F),
    .INIT_14(256'hFEA3D05E08FA4D523AA09AA9EA6296A495B7F82005F972116B328F08D611B2F1),
    .INIT_15(256'h1297BDA2DBF725F48364BDCAAD1CA5EEC907BF089D17CDA21E7768FA5DAD02F6),
    .INIT_16(256'hEB317189C7AA36423FFB38E6B0CD3FFA06539010BFEE8C0F37F96E7C8927D5B5),
    .INIT_17(256'h5A9D5110B935C92AA4E511912092A3E1374D81969AD67471CF42C394E586CFBA),
    .INIT_18(256'hCD36D10EAD7FCCBB8BB455935A6F1585C94423E9588ADF169E1BB8894609B2AD),
    .INIT_19(256'h22E2113B49C07ED6FD87CE8F66AE7DF0B155C1307A8813648E7BC9510CB85463),
    .INIT_1A(256'hE2F6DDF622C88ACE2BD4666AE374017CCCFAF8CD99A8C69B226058ED25AD7F1A),
    .INIT_1B(256'hD59722F385DC14A41FB35AC02976805BEA1A43EBAB1B80EF2CC48C7F6F4A10C8),
    .INIT_1C(256'h0CD5006F036B55E94687705559A9433C1310E85BF6A8743FA760CA0FFCE5DEC9),
    .INIT_1D(256'h92E83CB03E19E2581D585ACA2019CCCF30B16F1A7EF2F2749A564D0AD77361AE),
    .INIT_1E(256'hB2EEB31F02BDF6F71F28FB853FD02D0EFB3DB5F618C44E348DB9917F6059FF42),
    .INIT_1F(256'hF952D9B8C8C317B243D08271BE4BB9BD44251C5D516C6E9B40AA2BC6E56365C0),
    .INIT_20(256'h2DA2C1E3BF0727FECCE697E23E50EE01ED5C967ABB4B2AFF1FFB80320BE5DD4E),
    .INIT_21(256'hFB9DD3A5FC8FC8569AD707ECDC7BDEAC446DB893616D9A48C32BB39497F266CB),
    .INIT_22(256'h84B12ABDAB0B74A0E3E046DFDD994B9F0DC98B11F5B63FEEA62B853085A6D30F),
    .INIT_23(256'hCD370C56593D422051C91E4A9DDDE6233462D97AD39F4BBD538EB0A8EF9570D1),
    .INIT_24(256'h432B3E572717A319E49F1F07F7973AE8A6360D591664B1654302486FD045B728),
    .INIT_25(256'h44AEAA2616C0471FCF1C48ACB636626FC4A9173A66687074F91AF2AE2709ADE2),
    .INIT_26(256'h1CF736E4DE5AD2260377C79AD3BEDFD42A66B3ADDB3C52820281F115352AC43C),
    .INIT_27(256'h842077363340275299E325B2DAC0480EF870D5DD626589678FD495C3E0177D86),
    .INIT_28(256'h605702486803DDBF52858CFBAD10083496002EA4AEE7C195494C663E528F8F8B),
    .INIT_29(256'hA3101C1E3FD74D9FF9C3FDF180D8F83C04B421CFC977E940124A301A13C05B9B),
    .INIT_2A(256'h993C1F4CC0B902E692A1B3C535AB37F386FD74DFD7731DD5D344844DB4AF5902),
    .INIT_2B(256'h8B55BFE419589BAB3C3F59A6176991EB40440F85F93A7CA964BC9ADAA3E52C56),
    .INIT_2C(256'h414DA0734D949688CFCB460D25D0D42321554289702925C932993FD4760E0C96),
    .INIT_2D(256'h0909395638BBC1C658A186ACD28BC0BAEA055D41EFAEAE09C5DEECD9535A0899),
    .INIT_2E(256'h56F65C300263FD1BD90541DDEC0B955D5D9ADEE918175709C4CB7E33BE89CFF5),
    .INIT_2F(256'h9ABE8ADE534A48964203E27C4B1FC64A6A851C7BE2406443DE1ACC09090175F3),
    .INIT_30(256'hCB6EC9CCFD4EF82635E7834AE7424C4F1DAC97B4840F82AEAA11DD01E45A10FD),
    .INIT_31(256'hA2DCE66466E5F547F5B81F7F2241A0B830E1C8D8D898FFC53DFFB6E846728C1C),
    .INIT_32(256'h7A1F88BA2CDA180A74A2D1ADABD693E1A33FC397DEBAD09EB65CF9F051CA9735),
    .INIT_33(256'h91BB0276BD6C8077B500E4F0359D7C5289A744F0F0221DA77C90A943ED5ED44E),
    .INIT_34(256'h5244A94C553AEDC91955BBEEF780A236E791AE61A58E1E9376E54D17D178F1E9),
    .INIT_35(256'hFD2B0D11115E4BA4622F05F2E4FCF5C732E73108908D8E4DE23B30C0607E8654),
    .INIT_36(256'h072B06607CE87E7B42FB416AAADCD37B0C038D23B3F88339E33812715B2CA43B),
    .INIT_37(256'h783B4C980DB9FA09301A522531B8F0B2D28CECF4156C1796A5D52E3D55234F7F),
    .INIT_38(256'h0E8E847AB63F32FF8BC925CAD014C29FDCFBDF42A77E0A240AEC1A830407DDAD),
    .INIT_39(256'hCD2A8BB080459EC88D77B605328FBDE07DA924043EBC660469B5C52C533853C1),
    .INIT_3A(256'hBFF55383B872C46D4D6D4F5284196BC9A9A8125BB1A918A2DFDD15CE16CF313C),
    .INIT_3B(256'h1E115792281306C54D40B9300DF14C0E063A5C2865556A5CCDB7C80EFD615F86),
    .INIT_3C(256'h9B603F0912FBBC1044DF122E7C9518718AA836394352F11A5F34A6E8A3D512F3),
    .INIT_3D(256'h4DA76D3D2EC2F44B75F1515D10BE3CEB07D49662B14F62CAC61110C760724BF2),
    .INIT_3E(256'h9556F7F59592F2ADCBC4F35BFD177DD859CAFF4636524DDB1BFE21BEFF1BBA30),
    .INIT_3F(256'h26BFCBC53FE67C97DEE2B7C440E30357C31E750AAFD76077F420886A674CD251),
    .INIT_40(256'h817005BFC141440A83B3345773F83FDE7EF508B7558CE67F141D4EFD1236C184),
    .INIT_41(256'h6BBECBCC86EEA4AC242D1DF9B429ED5B7541E951DD9A6013AA6D1E8D8ECE9CA8),
    .INIT_42(256'hF70DF60B339EB9FF7692AEE820F4977DEBD0DADC6C53BAA61F23D3129AD702BB),
    .INIT_43(256'h6E2D04F0DC08E16EFCBB20F3136BE7A8F780365BE9C623954CF26C578A241527),
    .INIT_44(256'hB4C34ED743C9352BD12B0A135BFABE19FAA0C9B2373D99C6C6B5A388AC747A60),
    .INIT_45(256'h7DD0534F9DBF986D03A1BBA14B339F9DBFA5C76E0A7DDEBC80DF4CF0551E0790),
    .INIT_46(256'h000000000000000000000000000000D6904FBFE2989A35C6AE62930A6314CAC0),
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
    .READ_WIDTH_A(1),
    .READ_WIDTH_B(1),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(1),
    .WRITE_WIDTH_B(1)) 
    \DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({1'b1,addra}),
        .ADDRBWRADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clka),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,dina}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:1],douta}),
        .DOBDO(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:0]),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:0]),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ena),
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
module Bias_Bram0_blk_mem_gen_top
   (douta,
    clka,
    ena,
    addra,
    dina,
    wea);
  output [31:0]douta;
  input clka;
  input ena;
  input [14:0]addra;
  input [31:0]dina;
  input [0:0]wea;

  wire [14:0]addra;
  wire clka;
  wire [31:0]dina;
  wire [31:0]douta;
  wire ena;
  wire [0:0]wea;

  Bias_Bram0_blk_mem_gen_generic_cstr \valid.cstr 
       (.addra(addra),
        .clka(clka),
        .dina(dina),
        .douta(douta),
        .ena(ena),
        .wea(wea));
endmodule

(* C_ADDRA_WIDTH = "15" *) (* C_ADDRB_WIDTH = "15" *) (* C_ALGORITHM = "1" *) 
(* C_AXI_ID_WIDTH = "4" *) (* C_AXI_SLAVE_TYPE = "0" *) (* C_AXI_TYPE = "1" *) 
(* C_BYTE_SIZE = "9" *) (* C_COMMON_CLK = "0" *) (* C_COUNT_18K_BRAM = "6" *) 
(* C_COUNT_36K_BRAM = "14" *) (* C_CTRL_ECC_ALGO = "NONE" *) (* C_DEFAULT_DATA = "0" *) 
(* C_DISABLE_WARN_BHV_COLL = "0" *) (* C_DISABLE_WARN_BHV_RANGE = "0" *) (* C_ELABORATION_DIR = "./" *) 
(* C_ENABLE_32BIT_ADDRESS = "0" *) (* C_EN_DEEPSLEEP_PIN = "0" *) (* C_EN_ECC_PIPE = "0" *) 
(* C_EN_RDADDRA_CHG = "0" *) (* C_EN_RDADDRB_CHG = "0" *) (* C_EN_SAFETY_CKT = "0" *) 
(* C_EN_SHUTDOWN_PIN = "0" *) (* C_EN_SLEEP_PIN = "0" *) (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     14.231616 mW" *) 
(* C_FAMILY = "virtex7" *) (* C_HAS_AXI_ID = "0" *) (* C_HAS_ENA = "1" *) 
(* C_HAS_ENB = "0" *) (* C_HAS_INJECTERR = "0" *) (* C_HAS_MEM_OUTPUT_REGS_A = "1" *) 
(* C_HAS_MEM_OUTPUT_REGS_B = "0" *) (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
(* C_HAS_REGCEA = "0" *) (* C_HAS_REGCEB = "0" *) (* C_HAS_RSTA = "0" *) 
(* C_HAS_RSTB = "0" *) (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
(* C_INITA_VAL = "0" *) (* C_INITB_VAL = "0" *) (* C_INIT_FILE = "Bias_Bram0.mem" *) 
(* C_INIT_FILE_NAME = "Bias_Bram0.mif" *) (* C_INTERFACE_TYPE = "0" *) (* C_LOAD_INIT_FILE = "1" *) 
(* C_MEM_TYPE = "0" *) (* C_MUX_PIPELINE_STAGES = "0" *) (* C_PRIM_TYPE = "1" *) 
(* C_READ_DEPTH_A = "18432" *) (* C_READ_DEPTH_B = "18432" *) (* C_READ_LATENCY_A = "1" *) 
(* C_READ_LATENCY_B = "1" *) (* C_READ_WIDTH_A = "32" *) (* C_READ_WIDTH_B = "32" *) 
(* C_RSTRAM_A = "0" *) (* C_RSTRAM_B = "0" *) (* C_RST_PRIORITY_A = "CE" *) 
(* C_RST_PRIORITY_B = "CE" *) (* C_SIM_COLLISION_CHECK = "ALL" *) (* C_USE_BRAM_BLOCK = "0" *) 
(* C_USE_BYTE_WEA = "0" *) (* C_USE_BYTE_WEB = "0" *) (* C_USE_DEFAULT_DATA = "0" *) 
(* C_USE_ECC = "0" *) (* C_USE_SOFTECC = "0" *) (* C_USE_URAM = "0" *) 
(* C_WEA_WIDTH = "1" *) (* C_WEB_WIDTH = "1" *) (* C_WRITE_DEPTH_A = "18432" *) 
(* C_WRITE_DEPTH_B = "18432" *) (* C_WRITE_MODE_A = "WRITE_FIRST" *) (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
(* C_WRITE_WIDTH_A = "32" *) (* C_WRITE_WIDTH_B = "32" *) (* C_XDEVICEFAMILY = "virtex7" *) 
(* ORIG_REF_NAME = "blk_mem_gen_v8_4_2" *) (* downgradeipidentifiedwarnings = "yes" *) 
module Bias_Bram0_blk_mem_gen_v8_4_2
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
  input [31:0]dina;
  output [31:0]douta;
  input clkb;
  input rstb;
  input enb;
  input regceb;
  input [0:0]web;
  input [14:0]addrb;
  input [31:0]dinb;
  output [31:0]doutb;
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
  input [31:0]s_axi_wdata;
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
  output [31:0]s_axi_rdata;
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
  wire [31:0]dina;
  wire [31:0]douta;
  wire ena;
  wire [0:0]wea;

  assign dbiterr = \<const0> ;
  assign doutb[31] = \<const0> ;
  assign doutb[30] = \<const0> ;
  assign doutb[29] = \<const0> ;
  assign doutb[28] = \<const0> ;
  assign doutb[27] = \<const0> ;
  assign doutb[26] = \<const0> ;
  assign doutb[25] = \<const0> ;
  assign doutb[24] = \<const0> ;
  assign doutb[23] = \<const0> ;
  assign doutb[22] = \<const0> ;
  assign doutb[21] = \<const0> ;
  assign doutb[20] = \<const0> ;
  assign doutb[19] = \<const0> ;
  assign doutb[18] = \<const0> ;
  assign doutb[17] = \<const0> ;
  assign doutb[16] = \<const0> ;
  assign doutb[15] = \<const0> ;
  assign doutb[14] = \<const0> ;
  assign doutb[13] = \<const0> ;
  assign doutb[12] = \<const0> ;
  assign doutb[11] = \<const0> ;
  assign doutb[10] = \<const0> ;
  assign doutb[9] = \<const0> ;
  assign doutb[8] = \<const0> ;
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
  assign s_axi_rdata[31] = \<const0> ;
  assign s_axi_rdata[30] = \<const0> ;
  assign s_axi_rdata[29] = \<const0> ;
  assign s_axi_rdata[28] = \<const0> ;
  assign s_axi_rdata[27] = \<const0> ;
  assign s_axi_rdata[26] = \<const0> ;
  assign s_axi_rdata[25] = \<const0> ;
  assign s_axi_rdata[24] = \<const0> ;
  assign s_axi_rdata[23] = \<const0> ;
  assign s_axi_rdata[22] = \<const0> ;
  assign s_axi_rdata[21] = \<const0> ;
  assign s_axi_rdata[20] = \<const0> ;
  assign s_axi_rdata[19] = \<const0> ;
  assign s_axi_rdata[18] = \<const0> ;
  assign s_axi_rdata[17] = \<const0> ;
  assign s_axi_rdata[16] = \<const0> ;
  assign s_axi_rdata[15] = \<const0> ;
  assign s_axi_rdata[14] = \<const0> ;
  assign s_axi_rdata[13] = \<const0> ;
  assign s_axi_rdata[12] = \<const0> ;
  assign s_axi_rdata[11] = \<const0> ;
  assign s_axi_rdata[10] = \<const0> ;
  assign s_axi_rdata[9] = \<const0> ;
  assign s_axi_rdata[8] = \<const0> ;
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
  Bias_Bram0_blk_mem_gen_v8_4_2_synth inst_blk_mem_gen
       (.addra(addra),
        .clka(clka),
        .dina(dina),
        .douta(douta),
        .ena(ena),
        .wea(wea));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_v8_4_2_synth" *) 
module Bias_Bram0_blk_mem_gen_v8_4_2_synth
   (douta,
    clka,
    ena,
    addra,
    dina,
    wea);
  output [31:0]douta;
  input clka;
  input ena;
  input [14:0]addra;
  input [31:0]dina;
  input [0:0]wea;

  wire [14:0]addra;
  wire clka;
  wire [31:0]dina;
  wire [31:0]douta;
  wire ena;
  wire [0:0]wea;

  Bias_Bram0_blk_mem_gen_top \gnbram.gnativebmg.native_blk_mem_gen 
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
