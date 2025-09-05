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
	output reg                merge_vld                 ,
	output reg        [31:0]  merge_out    
);
        
    always@(posedge clk or negedge rst_n)begin
    	if(!rst_n)
    		merge_out <= 'd0;
    	else
    		if(sum_vld)
    			merge_out <= m0 * mac_array_out + m1;
    end
    
    always@(posedge clk) begin
        if(!rst_n)
            merge_vld<=0;
        else
            merge_vld<=sum_vld;
    end
    
endmodule
