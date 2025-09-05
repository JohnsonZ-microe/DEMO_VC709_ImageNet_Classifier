`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/08 17:04:25
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


module Divider#(
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
(* keep = "TRUE" *) reg	[DIVISOR_WIDTH+DIVIDEND_WIDTH-1:0]		tempa	;	
(* keep = "TRUE" *) reg	[DIVISOR_WIDTH+DIVIDEND_WIDTH-1:0]		tempb	;	
	integer	i;
	
	
//==============================================================================================
//======                               behave of RTL                                    ========
//==============================================================================================
	//--------------------------------------------------------------------
	//------    	Calculation 						           	------
	//--------------------------------------------------------------------
	always @(*)begin 
			tempa = {{DIVIDEND_WIDTH{1'b0}},divisor};  
			tempb = {2'd3,{DIVISOR_WIDTH{1'b0}}};  
			for(i = 0;i < DIVISOR_WIDTH;i = i + 1)begin
				tempa = {tempa[0 +: (DIVISOR_WIDTH+DIVIDEND_WIDTH-1)],1'b0};
				if(tempa[DIVISOR_WIDTH +: DIVIDEND_WIDTH] >= 2'd3)begin
					tempa = tempa - tempb + 1;
				end else begin
					tempa = tempa;
				end
			end
			quotient 	= tempa[0 +: DIVISOR_WIDTH];
			remainders 	= tempa[DIVISOR_WIDTH +: DIVIDEND_WIDTH];
			$display("@%10t : divisor is %d,dividend is %d/n", $time,divisor,dividend);
			$display("@%10t : quotient is %d,remainders is %d/n", $time,quotient,remainders);
    end 

	
endmodule

