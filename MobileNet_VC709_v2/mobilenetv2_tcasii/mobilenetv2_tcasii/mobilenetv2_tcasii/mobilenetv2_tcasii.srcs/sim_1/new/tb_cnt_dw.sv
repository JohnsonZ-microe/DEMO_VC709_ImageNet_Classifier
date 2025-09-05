`timescale 1ns / 100ps

module tb_cnt_dw;

logic signed [8:0] cnt_x_central, cnt_y_central;
logic padding;
assign padding = 1'b1;

logic clk;
logic rst_n;
logic [9:0] cnt_channel



always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin 
		cnt_x_central		<=	1 -	padding;
		cnt_y_central		<=	1 -	padding;
		cnt_channel         <=         0   ;
	end
	
	else begin
		if(enable)
			if(cnt_channel >= ifmap_channel- CHANNEL_PARA)begin	
				cnt_channel <= 0;
				if(cnt_x_central  <=  ifmap_size)					
				begin
					cnt_x_central <= 1 - padding;
					if(cnt_y_central  <=  ifmap_size) begin
						cnt_y_central <= 1 - padding;
					end
					else begin
						cnt_y_central <= cnt_y_central + stride;
						
					end
				end
				else
				begin
					cnt_x_central <= cnt_x_central + stride;
				end
			end
				
			else begin
				cnt_channel <= cnt_channel + CHANNEL_PARA;
			end
	end
end


endmodule
