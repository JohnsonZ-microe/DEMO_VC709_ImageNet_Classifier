`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/30 20:43:42
// Design Name: 
// Module Name: Weight_loaded_buffer_tb
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


module Weight_loaded_buffer_tb();

reg clk;
reg rst;
reg signed [7:0] weight_in;
reg weight_loading;

wire [8*320-1:0] weight_out;
wire [16-1:0] weigth_out_sample;
Weight_loaded_buffer Weight_loaded_buffer0(
    .clk(clk),
    .rst(rst),
    .weight_in(weight_in),
    .weight_loading(weight_loading),
    
    .weight_out(weight_out)
    );
assign weigth_out_sample = weight_out[15:0];
always #10 clk = ~clk;

integer i;
initial begin
    clk = 0;
    rst = 1;
    weight_in = 0;
    weight_loading = 0;
    #10
    rst = 0;
    #10
    rst = 1;
    weight_loading = 1;
    for(i=0; i<320; i=i+1) begin
        weight_in = i;
        #20;
    end
    weight_loading = 0;
end
endmodule
