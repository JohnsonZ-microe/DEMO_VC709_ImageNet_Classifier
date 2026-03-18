(*use_dsp = "yes"*)module m0xsigma_plus_m1#
(
	parameter M0_WIDTH       = 32,
	parameter M1_WIDTH       = 32
)
(
	input                                 clk           ,
	input                                 rst_n         ,
	input signed        [M0_WIDTH-1:0]    m0            ,
	input signed        [M1_WIDTH-1:0]    m1            ,     
	
	input signed        [31:0]            mac_array_out ,
	input                                 sum_vld       ,
	input relu_enable,
	output reg                merge_vld                 ,
	output reg        [31:0]  merge_out    
);
    //由于时序无法满足，当前位宽设计会导致综合工具使用两个dsp进行运算，因此将m0 m1截断为18位
	//尝试将mac_array_out截断为24位
	reg signed [17:0] m0_trunc;
	reg signed [31:0] mac_array_out_trunc;
	reg signed [M1_WIDTH-1:0] m1_reg;
	always @(posedge clk) begin
		if(!rst_n) begin
			m0_trunc <= 18'd0;
			mac_array_out_trunc <= 24'd0;
			m1_reg <= 32'd0;
		end
		else begin
			m0_trunc <= m0[17:0];
			mac_array_out_trunc <= mac_array_out;
			m1_reg <= m1;
		end
	end
	reg sum_vld_reg;
	//sum_vld信号穿透太深，路径极长。
	always @(posedge clk) begin
		if(!rst_n)
			sum_vld_reg <= 1'b0;
		else
			sum_vld_reg <= sum_vld;
	end

    always@(posedge clk or negedge rst_n)begin
    	if(!rst_n)
    		merge_out <= 'd0;
    	else
    		if(sum_vld_reg)//sum_vld 为四级延迟的tlast信号
    			merge_out <=  m0_trunc * mac_array_out_trunc + m1_reg ;
    end
    
    always@(posedge clk) begin
        if(!rst_n)
            merge_vld<=0;
        else
            merge_vld<=sum_vld_reg;//将四级延迟的tlast信号传递给merge_vld
    end
    
endmodule
