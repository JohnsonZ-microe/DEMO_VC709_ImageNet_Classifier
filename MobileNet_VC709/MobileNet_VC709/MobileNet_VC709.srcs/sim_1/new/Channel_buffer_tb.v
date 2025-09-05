`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/30 22:00:46
// Design Name: 
// Module Name: Channel_buffer_tb
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


module Channel_buffer_tb();

reg clk;
reg rst;
reg signed [8*320-1:0] result_in;
reg channel_load;
reg channel_disboarding;

wire [8-1:0] PW_result;
Channel_buffer Channel_buffer(
    .clk(clk),
    .rst(rst),
    .channel_load(channel_load),
    .channel_disboarding(channel_disboarding),
    .result_in(result_in),
    
    .PW_result(PW_result)
);

always #10 clk = ~clk;

integer i;
initial begin
    clk = 0;
    rst = 1;
    result_in = 0;
    channel_disboarding = 0;
    channel_load = 0;
    #20
    rst = 0;
    #20
    rst = 1;
    channel_load = 1;
    result_in[16*8-1:0] = 128'h0f0e0d0c0b0a090807060504030201;
    #20
    channel_load = 0;
    channel_disboarding = 1;
end

endmodule
