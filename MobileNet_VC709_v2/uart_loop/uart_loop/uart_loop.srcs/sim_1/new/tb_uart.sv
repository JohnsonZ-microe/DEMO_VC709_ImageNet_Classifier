`timescale 1ns / 100ps

module tb_uart;

logic clk;
logic rst_n;
logic start;
logic tx_data;
logic sw1;
logic sw2;

initial begin
clk = 1'b1;
rst_n = 1'b0;
start = 1'b0;
sw1 = 1'b0;
sw2 = 1'b0;
#200 rst_n = 1'b1;
#200 start = 1'b1;
sw1 = 1'b1;
sw2 = 1'b1;
end

logic uart_txd;

uart_loopback_top u_uart_loopback_top(
.sys_clk    (clk) ,            //外部50M时钟
.sys_rst_n  (rst_n) ,          //外部复位信号，低有效
.uart_rxd   (tx_data) ,           //UART接收端口
.uart_txd   (uart_txd),         //UART发送端口
.sw1(sw1),
.sw2(sw2)
);

always#10 clk = ~clk; 
    
parameter  CLK_FREQ = 50000000;              //系统时钟频率
parameter  UART_BPS = 115200;                //串口波特率
localparam  BPS_CNT  = CLK_FREQ/UART_BPS;     //为得到指定波特率，对系统时钟计数BPS_CNT次

reg [15:0] clk_cnt;                         //系统时钟计数器


//*****************************************************
//**                    main code
//*****************************************************

//进入发送过程后，启动系统时钟计数器
always @(posedge clk or negedge rst_n) begin         
    if (!rst_n)                             
        clk_cnt <= 16'd0;                                  
    else if (start) begin                 //处于发送过程
        if (clk_cnt < BPS_CNT - 1)
            clk_cnt <= clk_cnt + 1'b1;
        else
            clk_cnt <= 16'd0;               //对系统时钟计数达一个波特率周期后清零
    end
    else                             
        clk_cnt <= 16'd0; 				    //发送过程结束
end

always_ff@(posedge clk or negedge rst_n)begin
	if(!rst_n)
		tx_data <= 1'b0;
	else begin
		if(clk_cnt == BPS_CNT - 1)
			tx_data <= ~tx_data;
	end
end


endmodule
