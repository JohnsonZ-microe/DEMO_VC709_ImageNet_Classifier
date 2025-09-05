module image_uart_decoder(
input              clk              ,
input              rst_n            ,
input              recv_vld         ,
input      [7:0]   recv_data        ,
output reg [14:0]  bram_addr_start  ,
output reg         bram_addr_vld    
);

wire recv_done;
reg  recv_vld_r1,recv_vld_r2;
assign recv_done = (~recv_vld_r2) & recv_vld_r1;
always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		recv_vld_r1 <= 'd0;
		recv_vld_r2 <= 'd0;
	end
	else begin
		recv_vld_r1 <= recv_vld;
		recv_vld_r2 <= recv_vld_r1;
	end
end



parameter CLK_FREQ = 200_000_000;         //定义系统时钟频率
localparam IDLE = 2'd0;
localparam REG  = 2'd1;
localparam CNT  = 2'd2;

reg [31:0] cnt_to_idle;
wire       cnt_done;
wire       reg_done;

reg [31:0] M1;
reg [7:0]  input_zero; 
reg [7:0]  data;

reg [1:0] next_state;
reg [1:0] current_state;


//ila_0 u_ila_0 (
//	.clk(clk), // input wire clk
//	.probe0(rst_n), // input wire [0:0]  probe0  
//	.probe1(recv_done), // input wire [0:0]  probe1 
//	.probe2(input_zero), // input wire [0:0]  probe2 
//	.probe3(recv_data), // input wire [7:0]  probe3 
//	.probe4(bram_addr_start), // input wire [14:0]  probe4 
//	.probe5(bram_addr_vld), // input wire [0:0]  probe5 
//	.probe6(cnt_to_idle), // input wire [31:0]  probe6 
//	.probe7(cnt_done), // input wire [0:0]  probe7 
//	.probe8(reg_done), // input wire [0:0]  probe8 
//	.probe9(M1), // input wire [31:0]  probe9 
//	.probe10(next_state), // input wire [1:0]  probe10 
//	.probe11(current_state), // input wire [1:0]  probe11
//	.probe12(data)
//);


 
always@(*)begin
	case(current_state)
		IDLE:begin
			if(recv_done)
				next_state <= REG;
			else
				next_state <= IDLE;
		end
		REG:begin
			if(reg_done)
				next_state <= CNT;
			else
				next_state <= REG;
		end
		CNT:begin
			if(cnt_done)
				next_state <= IDLE;
			else
				next_state <= CNT;
		end
		default:
			next_state <= IDLE;	
	endcase
end
always@(posedge clk or negedge rst_n)begin
	if(!rst_n)
		current_state <= IDLE;
	else
		current_state <= next_state;
end

reg [2:0] cnt_recv_done;
always@(posedge clk or negedge rst_n)begin
	if(!rst_n)
		cnt_recv_done <= 'd0;
	else begin
		if(current_state == REG)begin
			if(recv_done)
				cnt_recv_done <= cnt_recv_done + 1'b1;
		end
		else
			cnt_recv_done <= 'd0;
	end
end

always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		M1 <= 'd0;
		input_zero <= 'd0;
		data <= 'd0;
	end
	else begin
		case(current_state)
			IDLE:begin
				if(recv_done)
					M1[31:24] <= recv_data;
				else begin
					M1         <= 'd0;
					input_zero <= 'd0;
					data       <= 'd0;
				end
			end
			REG:begin
				if(recv_done && (cnt_recv_done == 'd0))
					 M1[23:16] <= recv_data;
				else if(recv_done && (cnt_recv_done == 'd1))
					 M1[15:8]<= recv_data;	
				else if(recv_done && (cnt_recv_done == 'd2))
					 M1[7:0]<= recv_data;
				else if(recv_done && (cnt_recv_done == 'd3))
					input_zero <= recv_data;
				else if(recv_done && (cnt_recv_done == 'd4))
					data <= recv_data;
			end
			default:begin
				    M1         <= M1;
					input_zero <= input_zero;
					data       <= data;
			end
		endcase
	end
end

assign reg_done = (current_state == REG) && recv_done && (cnt_recv_done == 'd4);
assign cnt_done = (current_state == CNT) && (cnt_to_idle == CLK_FREQ/100 - 1'b1);  

always@(posedge clk or negedge rst_n)begin
	if(!rst_n)
		cnt_to_idle <= 'd0;
	else begin
		if(current_state == CNT)begin
			if(recv_done)
				cnt_to_idle <= 'd0;
			else
				cnt_to_idle <= cnt_to_idle + 1'b1;
		end
		else
			cnt_to_idle <= 'd0;
	end
end

always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		bram_addr_start <= 'd0; 
	    bram_addr_vld   <= 'd0; 
	end
	else begin
		if((current_state == CNT) && (cnt_done))begin
			bram_addr_vld   <= 'd1;
			if((M1 == 32'h000000ea) && (input_zero == 8'h70) && (data == 8'h08))begin
				bram_addr_start <= 'd0; 
			end
			else if((M1 == 32'h000000d0) && (input_zero == 8'h65) && (data == 8'h46))begin
				bram_addr_start <= 'd1000; 
			end
			else if((M1 == 32'h000000e0) && (input_zero == 8'h77) && (data == 8'h00))begin
				bram_addr_start <= 'd2000; 
			end
			else if((M1 == 32'h000000e4) && (input_zero == 8'h73) && (data == 8'h5f))begin
				bram_addr_start <= 'd3000; 
			end
			else if((M1 == 32'h000000dc) && (input_zero == 8'h71) && (data == 8'h42))begin
				bram_addr_start <= 'd4000; 
			end
			else if((M1 == 32'h000000d7) && (input_zero == 8'h77) && (data == 8'ha0))begin
				bram_addr_start <= 'd5000; 
			end
			else if((M1 == 32'h000000c7) && (input_zero == 8'h70) && (data == 8'h6c))begin
				bram_addr_start <= 'd6000; 
			end
			else if((M1 == 32'h000000eb) && (input_zero == 8'h71) && (data == 8'hd6))begin
				bram_addr_start <= 'd7000; 
			end
			else if((M1 == 32'h000000eb) && (input_zero == 8'h71) && (data == 8'h9e))begin
				bram_addr_start <= 'd8000; 
			end
			else if((M1 == 32'h000000eb) && (input_zero == 8'h71) && (data == 8'hdb))begin
				bram_addr_start <= 'd9000; 
			end
			else if((M1 == 32'h000000ea) && (input_zero == 8'h70) && (data == 8'h9b))begin
				bram_addr_start <= 'd10000; 
			end
			else if((M1 == 32'h000000e0) && (input_zero == 8'h73) && (data == 8'h16))begin
				bram_addr_start <= 'd11000; 
			end
			else if((M1 == 32'h000000df) && (input_zero == 8'h77) && (data == 8'h9a))begin
				bram_addr_start <= 'd12000; 
			end
			else if((M1 == 32'h000000e4) && (input_zero == 8'h6d) && (data == 8'h01))begin
				bram_addr_start <= 'd13000; 
			end
			else if((M1 == 32'h000000de) && (input_zero == 8'h75) && (data == 8'h56))begin
				bram_addr_start <= 'd14000; 
			end
			else if((M1 == 32'h000000dd) && (input_zero == 8'h77) && (data == 8'h93))begin
				bram_addr_start <= 'd15000; 
			end
			else if((M1 == 32'h000000b9) && (input_zero == 8'h80) && (data == 8'h86))begin
				bram_addr_start <= 'd16000; 
			end
			else if((M1 == 32'h000000d0) && (input_zero == 8'h7a) && (data == 8'h86))begin
				bram_addr_start <= 'd17000; 
			end
			else if((M1 == 32'h000000e3) && (input_zero == 8'h72) && (data == 8'hc1))begin
				bram_addr_start <= 'd18000; 
			end
			else if((M1 == 32'h000000ea) && (input_zero == 8'h70) && (data == 8'ha8))begin
				bram_addr_start <= 'd19000; 
			end
		end
		else if((current_state == IDLE) && (recv_done))begin
			bram_addr_start <= 'd0; 
	    	bram_addr_vld   <= 'd0; 
		end
	end
end


    
    
endmodule
