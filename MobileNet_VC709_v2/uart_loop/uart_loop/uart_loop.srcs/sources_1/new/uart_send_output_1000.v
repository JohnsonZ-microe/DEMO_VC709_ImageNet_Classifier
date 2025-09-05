module uart_send_output_1000(
	input            clk,
	input            rst_n,
	input      [3:0] current_state,
	input            sw2,
	input      [14:0] addr_start,
	
    output           send_en,                   //发送使能信号
    output     [7:0] send_data                  //待发送数据
);

//parameter define
parameter  CLK_FREQ = 200_000_000;            //系统时钟频率
parameter  UART_BPS = 115200;                //串口波特率
localparam  BPS_CNT  = CLK_FREQ/UART_BPS;   //为得到指定波特率，对系统时钟计数BPS_CNT次
localparam  BPS_CNT10 = BPS_CNT;

reg         key_down;
wire        add_cnt;

reg  [15:0] cnt_10b;
reg  [14:0]  addr;
wire [7:0]  dout;

reg add_cnt_second;
wire end_cnt_second;
reg [31:0] cnt_second;

always@(posedge clk or negedge rst_n)begin
	if(!rst_n)
		add_cnt_second <= 'd0;
	else begin
		if(add_cnt_second == 'd0)begin
			if(sw2 && (current_state == 4'd1) && (cnt_second == 'd0))
				add_cnt_second <= 'd1;
		end
		else if(add_cnt_second == 'd1)begin
			if(end_cnt_second)
				add_cnt_second <= 'd0;
		end
	end
end

assign end_cnt_second = add_cnt_second && (cnt_second == 5*CLK_FREQ - 1'b1);
always@(posedge clk or negedge rst_n)begin
	if(!rst_n)
		cnt_second <= 'd0;
	else if(add_cnt_second)begin
		if(end_cnt_second)
			cnt_second <= 'd0;
		else
			cnt_second <= cnt_second + 1'b1;
	end
end

assign add_cnt = key_down == 1'b1;
always@(posedge clk or negedge rst_n)
	if(!rst_n)
		key_down <= 'd0;
	else begin
		if(sw2 && (current_state == 4'd1) && (cnt_second == 'd0))
			key_down <= 1'b1;
		else if(add_cnt && (addr == addr_start + 10'd999) && (cnt_10b == BPS_CNT10 - 1'b1))
			key_down <= 1'b0;
		else
			key_down <= key_down;
	end

always@(posedge clk or negedge rst_n)begin
	if(!rst_n)
		cnt_10b <= 'd0;
	else if(add_cnt)begin
		if(cnt_10b == BPS_CNT10 - 1'b1)
			cnt_10b <= 'd0;
		else begin
			cnt_10b <= cnt_10b + 1'b1;
		end
	end
end

always@(posedge clk or negedge rst_n)begin
	if(!rst_n)
		addr <= 'd0;
	else if(add_cnt)begin
		if((addr == addr_start + 10'd999) && (cnt_10b == BPS_CNT10 - 1'b1))
			addr <= addr_start;
		else if(cnt_10b == BPS_CNT10 - 1'b1)
			addr <= addr + 1'b1;
		else begin
			addr <= addr;
		end
	end
	else if(sw2 && (current_state == 4'd1) && (cnt_second == 'd0))begin
		addr <= addr_start;
	end
end


assign send_en = (cnt_10b == BPS_CNT10/2 - 1'b1) && add_cnt;
assign send_data = dout;

bram_output u_bram_output(
  .clka(clk),    // input wire clka
  .ena(1'b1),      // input wire ena
  .wea(1'b0),      // input wire [0 : 0] wea
  .addra(addr),  // input wire [9 : 0] addra
  .dina('d0),    // input wire [7 : 0] dina
  .douta(dout)  // output wire [7 : 0] douta
);    
        
endmodule
