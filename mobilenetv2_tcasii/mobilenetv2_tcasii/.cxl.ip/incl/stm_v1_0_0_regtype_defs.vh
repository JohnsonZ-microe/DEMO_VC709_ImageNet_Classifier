// STM's version of QID_WIDTH, in case QDMA changes its define to 12
// interface to QDMA has problem if != 11 bits
// stm_h2c ctx_acc   has problem if >16 bits.
`ifndef QID_W_STM
`define QID_W_STM 11
`endif

`ifndef STM_REGTYPE_DEFS_VH
`define STM_REGTYPE_DEFS_VH

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
// This file needs to be included in all modules so that all the modules can commonly 
// reference state_transitions
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

// Piecesd taken from axi4mm_axi_bridge.vh
// Only ifdef SOFT_IP versions needed per Ravi
// 4/12/2018

// Everything is sychronous pos edge

`timescale 1 ps / 1 ps


`define STM_NO_RST_REG(clk, reset_n, q, d) \
always @(posedge clk) q <= d;

`define STM_RST_REG(clk, reset_n, q, d, rstval) \
always @(posedge clk) begin  \
  if (~reset_n) q <= rstval; \
  else q <= d;               \
end

`define STM_RST_EN_REG(clk, reset_n, q, d, rstval, en) \
always @(posedge clk) begin  \
  if (~reset_n) q <= rstval; \
  else if (en) q <= d;       \
end

`define STM_DIY_REG(clk, reset_n) \
always @(posedge clk) 


`endif

//`define XSRREG_XDMA(clk, reset_n, q, d, rstval) \
//`XSRREG_SYNC (clk, reset_n, q, d, rstval)
//
//`define XSRREG_SYNC(clk, reset_n, q, d, rstval) \
//always @(posedge clk) begin  \
//  if (~reset_n) q <= rstval; \
//  else q <= d;               \
//end;
//
//`define XSRREG_HARD_CLR(clk, reset_n, q, d) \
//`XPREG_NORESET(clk, q, d) 
//
//// this was not defined in axi4mm_axi_bridge.vh
//`define XPREG_NORESET(clk, q, d) \
//always @(posedge clk) q <= d;
//
//`define XSRREG_EN_XDMA(clk, reset_n, q, d, rstval, en) \
//`XSRREG_SYNC_EN(clk, reset_n, q, d, rstval, en)
//
//`define XSRREG_SYNC_EN(clk, reset_n, q, d, rstval, en) \
//always @(posedge clk) begin  \
//  if (~reset_n) q <= rstval; \
//  else if (en) q <= d;       \
//end;
//
//`define XLREG_XDMA(clk, reset_n) \
//`XLREGS_SYNC(clk, reset_n)
//
//`define XLREGS_SYNC(clk, reset_n) \
//always @(posedge clk) 
