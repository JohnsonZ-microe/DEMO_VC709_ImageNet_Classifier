module Divider#(
	 parameter	DIVISOR_WIDTH		= 8
	,parameter	DIVIDEND_WIDTH		= 2
)(
	 input	wire	[DIVISOR_WIDTH-1:0]		dividend

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
	// always @(*)begin 
	// 		tempa = divisor;  
	// 		tempb = 8'd3;
	// 		quotient   = 8'd0;
	// 		for(i = 0;i <= 100;i = i + 1)begin
	// 			if(tempa >= tempb)begin
	// 				tempa = tempa - tempb;
	// 				quotient = quotient + 1'b1;
	// 			end 
	// 			else begin
	// 				tempa = tempa;
	// 				quotient = quotient;
	// 			end
	// 		end
	// 		quotient 	= quotient;
	// 		remainders 	= tempa;
    // end 
//----------------------------------------
localparam K = 16'd21846;// 2^16/3 的近似值
reg [23:0] product;    // 乘法结果（8位×16位=24位？不，8×16=24，但实际用16位系数足够）
reg [7:0] q_approx;    // 近似商
reg [7:0] r_theo;      // 理论余数
// 组合逻辑运算（单周期完成）
always @(*) begin
    
    // 步骤1：计算X×K（8位×16位=24位，取高16位参与移位）
    product = dividend * K;  // 结果为24位，实际有效部分是高16位
    
    // 步骤2：近似商 = (X×K) >> 16（取高8位）
    // q_approx = product[15:16-8];  // 等效于右移16位后的整数部分
    
    // 步骤3：计算理论余数并校正
	quotient = product[23:16]; // 近似商
    remainders = dividend - 3 * quotient; // 理论余数
    
    // 校正逻辑（确保结果精确）
    // if (r_theo >= 3) begin
    //     quotient = q_approx + 1'b1;
    //     remainders = r_theo - 3;
    // end else begin
    //     quotient = q_approx;
    //     remainders = r_theo[1:0];  // 余数最多为2，取低2位
    // end
end
	
endmodule