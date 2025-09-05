`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/23 10:46:18
// Design Name: 
// Module Name: interfaces
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


interface mac_array_debug_if
#(
	parameter INPUT_NUM      =  9,
	parameter ACT_WIDTH      =  8,
	parameter WEIGHT_WIDTH   =  8,
	parameter M0_WIDTH       = 32,
	parameter M1_WIDTH       = 32,
	parameter OUTPUT_WIDTH   = 8,
	parameter DATA_WIDTH = 8
);

logic [ACT_WIDTH:0] MAC_data_offset1, MAC_data_offset2, MAC_data_offset3;
logic [ACT_WIDTH:0] MAC_data_offset4, MAC_data_offset5, MAC_data_offset6;
logic [ACT_WIDTH:0] MAC_data_offset7, MAC_data_offset8, MAC_data_offset9;

logic [ACT_WIDTH-1:0] MAC_weight_in1, MAC_weight_in2, MAC_weight_in3;
logic [ACT_WIDTH-1:0] MAC_weight_in4, MAC_weight_in5, MAC_weight_in6;
logic [ACT_WIDTH-1:0] MAC_weight_in7, MAC_weight_in8, MAC_weight_in9;

logic [32-1:0] a1, a2, a3, a4, a5, a6, a7, a8, a9;
logic [32-1:0] sum;

modport MONITOR (
input MAC_data_offset1, MAC_data_offset2, MAC_data_offset3,
input MAC_data_offset4, MAC_data_offset5, MAC_data_offset6,
input MAC_data_offset7, MAC_data_offset8, MAC_data_offset9,
input MAC_weight_in1, MAC_weight_in2, MAC_weight_in3,
input MAC_weight_in4, MAC_weight_in5, MAC_weight_in6,
input MAC_weight_in7, MAC_weight_in8, MAC_weight_in9,
input a1, a2, a3, a4, a5, a6, a7, a8, a9,
input sum
); 

modport PROBE (
output MAC_data_offset1, MAC_data_offset2, MAC_data_offset3,
output MAC_data_offset4, MAC_data_offset5, MAC_data_offset6,
output MAC_data_offset7, MAC_data_offset8, MAC_data_offset9,
output MAC_weight_in1, MAC_weight_in2, MAC_weight_in3,
output MAC_weight_in4, MAC_weight_in5, MAC_weight_in6,
output MAC_weight_in7, MAC_weight_in8, MAC_weight_in9,
output a1, a2, a3, a4, a5, a6, a7, a8, a9,
output sum
); 
endinterface

interface adder_tree_debug_if#(
	parameter IN_WIDTH  =  32
);
    logic [IN_WIDTH-1:0]  b1,b2,b3,b4;
    logic [IN_WIDTH-1:0]  c1,c2;
    logic [IN_WIDTH-1:0]  d1;

    modport MONITOR( 
    input b1,b2,b3,b4,
    input c1,c2,
    input d1
    );
    modport PROBE( 
    output b1,b2,b3,b4,
    output c1,c2,
    output d1
    );
endinterface

interface M_s_debug_if#(
    parameter IN_WIDTH  =  32
);
    logic [IN_WIDTH-1:0] m0;
    logic [IN_WIDTH-1:0] m1; 
    logic [IN_WIDTH-1:0] mac_array_out;
    logic [IN_WIDTH-1:0] merge_out;
    
    modport MONITOR( 
    input m0, m1,
    input mac_array_out,
    input merge_out
    );
    
    modport PROBE( 
    output m0, m1,
    output mac_array_out,
    output merge_out
    );
    
endinterface

interface Data_Bram_DEBUG_if#(
    parameter DATA_BRAM_ADDR_WIDTH = 14
);
    logic [DATA_BRAM_ADDR_WIDTH-1:0] addra;
    logic [71 : 0] dina;
    logic [DATA_BRAM_ADDR_WIDTH-1:0] addrb;
    logic [71 : 0] doutb;
    
    modport MONITOR(
    input addra, dina, addrb, doutb
    );
endinterface

interface Kernel_Bram_DEBUG_if#(
    parameter KERNEL_BRAM_ADDR_WIDTH = 16
);
    logic [KERNEL_BRAM_ADDR_WIDTH-1:0] addra;
    logic [71 : 0] douta;
    
    modport MONITOR(
    input addra, douta
    );
endinterface

interface M1_Bram_DEBUG_if#(
    parameter KERNEL_BRAM_ADDR_WIDTH = 16
);
    logic [12:0] addra;
    logic [287 : 0] douta;
    
    modport MONITOR(
    input addra, douta
    );
endinterface