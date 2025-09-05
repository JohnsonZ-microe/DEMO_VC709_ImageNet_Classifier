`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/21 18:32:32
// Design Name: 
// Module Name: divider
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
(* dont_touch = "true"*)module Divider#(
	 parameter	DIVISOR_WIDTH		= 8
	,parameter	DIVIDEND_WIDTH		= 2
)(
	 input	wire	[DIVISOR_WIDTH-1:0]		divisor

	//------------------------------------------------//
	,output	reg		[DIVISOR_WIDTH-1:0]		quotient	
	,output	reg		[DIVIDEND_WIDTH-1:0]	remainders
);
//==============================================================================================
//======								define signal									========
//==============================================================================================
(* keep = "TRUE" *) reg	[DIVISOR_WIDTH-1:0]		tempa	;	
(* keep = "TRUE" *) reg	[DIVISOR_WIDTH-1:0]		tempb	;	
	integer	i;

	
//==============================================================================================
//======                               behave of RTL                                    ========
//==============================================================================================
	//--------------------------------------------------------------------
	//------    	Calculation 						           	------
	//--------------------------------------------------------------------
	always @(*)begin 
			tempa = divisor;  
			tempb = 8'd3;
			quotient   = 8'd0;
			for(i = 0;i <= 100;i = i + 1)begin
				if(tempa >= tempb)begin
					tempa = tempa - tempb;
					quotient = quotient + 1'b1;
				end 
				else begin
					tempa = tempa;
					quotient = quotient;
				end
			end
			quotient 	= quotient;
			remainders 	= tempa;
    end 

	
endmodule