`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/21 18:06:12
// Design Name: 
// Module Name: MAC
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

(*use_dsp = "yes"*)(* dont_touch = "true"*)module MAC(
    input     				     clk     ,
    input     				     rst_n   ,
    input       	             tlast   ,
    input                        acc_mode,
    input      signed [8:0]      data    ,
    input      signed [7:0]      weight  ,
    output     signed [31:0]     psum_out
);
reg signed [31:0] acc_reg;

always@(posedge clk)begin
	if(!rst_n)  begin
		acc_reg <= 'd0;   
	end
	else begin
	   if(acc_mode)
	       if (tlast)
	           acc_reg <= 0;
		   else 
			   acc_reg <= acc_reg + data*weight;
       else    
            acc_reg <= data*weight;
	end
end

assign psum_out = acc_reg;
endmodule
