module shift_register#
(
	parameter len_shift_register = 17
)
(
    input clk,
    input rst_n,
    input tlast,
    input [31:0] bias,
    input [31:0] MAC_out1,
    input [31:0] MAC_out2,
    input [31:0] MAC_out3,
    input [31:0] MAC_out4,
    input [31:0] MAC_out5,
    input [31:0] MAC_out6,
    input [31:0] MAC_out7,
    input [31:0] MAC_out8,
    input [31:0] MAC_out9,
    input [31:0] MAC_out10,
    input [31:0] MAC_out11,
    input [31:0] MAC_out12,
    input [31:0] MAC_out13,
    input [31:0] MAC_out14,
    input [31:0] MAC_out15,
    input [31:0] MAC_out16,
    output reg signed [31:0] shift_register_out
    );
    reg [31*len_shift_register:0] shift_register;
    wire signed [31:0]            shift_register_0;
    
    assign shift_register_0 = shift_register[31:0];
    
    always@(posedge clk or negedge rst_n)begin
    	if(!rst_n) 
    		shift_register <= 'd0;
    	else begin
    		if(tlast)
    			shift_register <= {MAC_out16,MAC_out15,MAC_out14,MAC_out13,MAC_out12,MAC_out11,MAC_out10,MAC_out9,MAC_out8,MAC_out7,MAC_out6,MAC_out5,MAC_out4,MAC_out3,MAC_out2,MAC_out1,bias};
    		else
    			shift_register <= shift_register >> 32;
    	end
    end

	always@(posedge clk or negedge rst_n)begin
		if(!rst_n)
			shift_register_out <= 'd0;
		else
			if(tlast)
				shift_register_out <= 'd0;
			else
				shift_register_out <= shift_register_0 + shift_register_out;
	end


endmodule