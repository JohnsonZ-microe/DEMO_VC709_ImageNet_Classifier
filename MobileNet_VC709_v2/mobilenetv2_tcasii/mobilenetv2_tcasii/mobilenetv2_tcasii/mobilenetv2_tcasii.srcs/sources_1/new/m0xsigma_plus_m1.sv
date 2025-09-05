(*use_dsp = "yes"*)(* dont_touch = "true"*)module m0xsigma_plus_m1#
(
	parameter M0_WIDTH       = 32,
	parameter M1_WIDTH       = 32
)
(
	input                                 clk           ,
	input                                 rst_n         ,
	input                                 has_SC        ,
	input       [31:0]                    SC_merge      ,      //M2(Fq-Fz)<<16

	input signed        [M0_WIDTH-1:0]    m0            ,
	input signed        [M1_WIDTH-1:0]    m1            ,  
	
	input signed        [31:0]            mac_array_out ,
	input                                 sum_vld       ,
	output reg                merge_vld                 ,
	output reg        [31:0]  merge_out
	//----------- DEBUG  ------------//
//	,M_s_debug_if.PROBE M_s_DEBUG_IF 
);
       
    wire [31:0] SC_sub;
    assign SC_sub = (has_SC)? SC_merge: 0;
    always@(posedge clk)begin
    	if(!rst_n)
    		merge_out <= 'd0;
    	else
    		if(sum_vld)
    			merge_out <= m0 * mac_array_out + m1 + SC_sub;
    end
    
    always@(posedge clk) begin
        if(!rst_n)
            merge_vld<=0;
        else
            merge_vld<=sum_vld;
    end
    
//------------------ DEBUG --------------- //
//    always@(*) begin
//    M_s_DEBUG_IF.m0 <= m0;
//    M_s_DEBUG_IF.m1 <= m1;
//    M_s_DEBUG_IF.mac_array_out <= mac_array_out;
//    M_s_DEBUG_IF.merge_out <= merge_out;
//    end
    
endmodule
