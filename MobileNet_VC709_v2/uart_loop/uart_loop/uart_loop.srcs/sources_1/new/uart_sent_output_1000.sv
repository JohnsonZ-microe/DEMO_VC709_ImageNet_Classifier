module uart_send_output_1000_sv(
	input            clk,
	input            rst_n,
	input      [3:0] current_state,
	input            sw2,
	
    output           send_en,                   //发送使能信号
    output     [7:0] send_data                  //待发送数据
);

logic [7:0] bram [0:999];

//assign bram[0] = 8'hea;
//assign bram[1] = 8'h00;
//assign bram[2] = 8'h00;
//assign bram[3] = 8'h00;

//assign bram[4] = 8'h70;
//assign bram[5] = 8'h08;


assign bram[0] = 8'hd0;
assign bram[1] = 8'h00;
assign bram[2] = 8'h00;
assign bram[3] = 8'h00;

assign bram[4] = 8'h7a;
assign bram[5] = 8'h86;


for(genvar i = 6; i < 1000; i++)begin
assign bram[i] = i;
end

//parameter define
parameter  CLK_FREQ = 200_000_000;            //系统时钟频率
parameter  UART_BPS = 115200;                //串口波特率
localparam  BPS_CNT  = CLK_FREQ/UART_BPS;   //为得到指定波特率，对系统时钟计数BPS_CNT次
localparam  BPS_CNT9 = BPS_CNT*10;

reg         key_down;
wire        add_cnt;

reg  [15:0] cnt_9b;
reg  [9:0]  addr;

reg [7:0]  dout;

assign add_cnt = key_down == 1'b1;
always@(posedge clk or negedge rst_n)
	if(!rst_n)
		key_down <= 'd0;
	else begin
		if(sw2 && current_state == 4'd1)
			key_down <= 1'b1;
		else if(add_cnt && (addr == 'd999) && (cnt_9b == BPS_CNT9 - 1'b1))
			key_down <= 1'b0;
		else
			key_down <= key_down;
	end

always@(posedge clk or negedge rst_n)begin
	if(!rst_n)
		cnt_9b <= 'd0;
	else if(add_cnt)begin
		if(cnt_9b == BPS_CNT9 - 1'b1)
			cnt_9b <= 'd0;
		else begin
			cnt_9b <= cnt_9b + 1'b1;
		end
	end
end

always@(posedge clk or negedge rst_n)begin
	if(!rst_n)
		addr <= 'd0;
	else if(add_cnt)begin
		if(cnt_9b == BPS_CNT9 - 1'b1)
			addr <= addr + 1'b1;
		else begin
			addr <= addr;
		end
	end
	else
		addr <= 'd0;
end


assign send_en = (cnt_9b == BPS_CNT9/2 - 1'b1) && add_cnt;
assign send_data = dout;

always@(posedge clk or negedge rst_n)begin
	if(!rst_n)
		dout <= 'd0;
	else
		dout <= bram[addr];
end 


    

  
    
endmodule
