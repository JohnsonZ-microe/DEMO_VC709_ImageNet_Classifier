`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/09/05 08:01:47
// Design Name: 
// Module Name: avgpool
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


module avgpool#(
	parameter INPUT_NUM      =  9,
	parameter ACT_WIDTH      =  8,
	parameter WEIGHT_WIDTH   =  8,
	parameter OUTPUT_WIDTH   = 8 ,
	parameter SUM_WIDTH      = 32
)
(
	input                                 clk           ,
	input                                 rst_n         ,
    input                                 avgpool_chan_start,
    input                                avgpool_chan_done,
    input [SUM_WIDTH-1:0]                 adder_tree_sum,
    input  [7:0]                          ifmap_size,
    output reg [OUTPUT_WIDTH-1:0]                avgpool_out   ,
    output  reg                             avgpool_out_vld
    );

reg [SUM_WIDTH-1:0] avgpool_sum;

always @(posedge clk) begin
    if(!rst_n) begin
        avgpool_sum <= 0;
    end
    else if(avgpool_chan_done||avgpool_chan_start) begin
        avgpool_sum <= adder_tree_sum;
    end
    else if(adder_tree_sum === 32'bx)begin
        avgpool_sum <= avgpool_sum;
    end
    else avgpool_sum <= avgpool_sum + adder_tree_sum;
    
end

always @(posedge clk) begin
    if(!rst_n) begin
        avgpool_out_vld <= 0;
        avgpool_out <= 0;
    end
    else if(avgpool_chan_done) begin
        avgpool_out <= ((avgpool_sum * 1337) + 32'd32768) >> 16;
        avgpool_out_vld <= 1;
    end
    else begin
        avgpool_out_vld <= 0;
        avgpool_out <= avgpool_out;
    end
end
endmodule
