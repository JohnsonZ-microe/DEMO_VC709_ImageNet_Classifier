`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/09/22 17:28:46
// Design Name: 
// Module Name: divider_tb
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


module divider_tb(

    );
reg clk;
reg [7:0] dividend;
wire [7:0] quotient;
wire [1:0] remainders;

always #2.5 clk = ~clk;
initial begin
    clk = 0;
    dividend = 8'd0;
end
always #5 dividend = dividend + 1;
Divider Divider_inst (
    .dividend(dividend),
    .quotient(quotient),
    .remainders(remainders)
  );
endmodule
