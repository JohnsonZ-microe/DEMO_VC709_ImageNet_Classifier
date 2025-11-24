`ifndef STM_STRUCT_DEFS_VH
`define STM_STRUCT_DEFS_VH
`endif
// `include "pciecoredefines.h" -kkc temp workaround
//-----------------------------------------------------------------------------
// $Id: 
//-----------------------------------------------------------------------------
// axi_bridge.vh
//-----------------------------------------------------------------------------
// (c) Copyright 2010 - 2016 Xilinx, Inc. All rights reserved.
//
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and 
// international copyright and other intellectual property
// laws.
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
//-----------------------------------------------------------------------------
// Filename:        stm_v1_0_0_regtype_defs.vh
//
// Description:     
//                  
// This define bus bundles common between stm_h2c & stm_slr
//                            and between stm_c2h & stm_slr
//                   
//                  
// VHDL-Standard:   VHDL'93
//-----------------------------------------------------------------------------
// Structure:   
//              Include file
//
//-----------------------------------------------------------------------------
// Revision:        v1.05.a
// Date:            06/28/12
//
//-----------------------------------------------------------------------------

`ifndef STM_STRUCT_DEF
`define STM_STRUCT_DEF

// h2c ---data--> fabric
typedef struct packed {
  logic [511:0] tdata;
  logic [ 15:0] tdestt;
//logic         tvalid;
  logic         tlast;
  logic         tuser;
  logic         tsop; 
} dto_da_fifo_tt;
//localparam DTO_DA_FIFO_BITS=$bits(dto_otx_fifo_out);
	

// h2c <--pkt_crdt--- fabric
typedef struct packed {
//logic         vld;
  logic [15:0]  fid;
  logic [15:0]  crdt;
//  logic [C_STM_TID_WIDTH-1:0]   tid; // throw this out eventually
  logic [7:0] tid;
} stma_pkt_crdt_t;
//localparam STMA_PKT_CRDT_BITS=$bits(stmax_pcdt_in);


// c2h <--data--- fabric
typedef struct packed {
  logic [511:0] tdata;
//logic [C_STM_TID_WIDTH-1:0] tid;  
  logic [7:0] tid;
//logic         tvalid;
  logic         tlast;
  logic         tuser;
} dti_da_fifo_t;
//localparam DTI_DA_FIFO_BITS=$bits(dti_dax_in);


// c2h ---dsc_avl--> fabric
typedef struct packed { 
//logic        tvalid;
  logic [15:0] tdestt;
  logic [15:0] fid;
  logic [15:0] avl;
} stm_c2h_avl_dsc_tt;
//localparam STM_C2H_AVL_DSC_BITS=$bits(c2h_avx_fifo_avl);

//-----------------------------------------------------------------------------
//Debug structs
//-----------------------------------------------------------------------------
typedef struct packed {
    logic [15:0]    num_c2h_beats_in;
    logic [15:0]    num_c2h_pkts_in;
} stm_prt_c2h_dbg_reg32b_0_t;

typedef struct packed {
    logic [15:0]    num_h2c_beats_out;
    logic [15:0]    num_h2c_pkts_out;
} stm_prt_h2c_dbg_reg32b_0_t;

typedef struct packed {
    stm_prt_c2h_dbg_reg32b_0_t  reg0;
} stm_prt_c2h_dbg_reg_t;

typedef struct packed {
    stm_prt_h2c_dbg_reg32b_0_t  reg0;
} stm_prt_h2c_dbg_reg_t;
//-----------------------------------------------------------------------------

`endif
