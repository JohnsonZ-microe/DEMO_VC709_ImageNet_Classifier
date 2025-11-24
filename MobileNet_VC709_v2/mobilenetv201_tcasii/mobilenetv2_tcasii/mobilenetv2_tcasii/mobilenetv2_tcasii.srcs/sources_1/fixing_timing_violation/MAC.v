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
		if (tlast)//tlast = (Mode==3'd3)?(Channel_cnt==ifmap_channel-1):(bram_st == CALCULATE);仅当pw执行到最后一个channel或者其他卷积模式在calculate阶段时才清零
			acc_reg <= data*weight;
		else
			acc_reg <= acc_reg + data*weight;
	end
end

assign psum_out = (acc_mode)? acc_reg:data*weight;//acc_mode = (mode==2'd3);如果是pw，输出累加结果，否则输出当前的乘积结果
endmodule
