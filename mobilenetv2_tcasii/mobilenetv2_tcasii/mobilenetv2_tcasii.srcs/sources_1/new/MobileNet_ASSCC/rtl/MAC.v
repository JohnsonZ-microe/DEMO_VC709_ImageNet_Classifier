(*use_dsp = "yes"*)module MAC(
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
		if (tlast)
			acc_reg <= 0;
		else
			acc_reg <= acc_reg + data*weight;
	end
end

assign psum_out = (acc_mode)? acc_reg:data*weight;
endmodule
