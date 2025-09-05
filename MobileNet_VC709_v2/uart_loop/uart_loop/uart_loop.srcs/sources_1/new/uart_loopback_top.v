//****************************************Copyright (c)***********************************//
//原子哥在线教学平台：www.yuanzige.com
//技术支持：www.openedv.com
//淘宝店铺：http://openedv.taobao.com 
//关注微信公众平台微信号："正点原子"，免费获取ZYNQ & FPGA & STM32 & LINUX资料。
//版权所有，盗版必究。
//Copyright(C) 正点原子 2018-2028
//All rights reserved	                               
//----------------------------------------------------------------------------------------
// File name:           uart_loopback_top
// Last modified Date:  2019/10/9 9:56:36
// Last Version:        V1.0
// Descriptions:        开发板通过串口接收PC发送的字符，然后将收到的字符发送给PC
//----------------------------------------------------------------------------------------
// Created by:          正点原子
// Created date:        2019/10/9 9:56:36
// Version:             V1.0
// Descriptions:        The original version
//
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module uart_loopback_top(
    input           sys_clk,
    input           sys_rst_n,          //外部复位信号，低有效
    
    input            sw1,
    input            sw2,

    input           uart_rxd,           //UART接收端口
    output          uart_txd,           //UART发送端口
    output          led0,
    output          led1,
    output          led2,
    output          led3,
    output          led4,
    output          led5,
    output          led6,
    output          led7
    
    );
    
wire rst_n;
assign rst_n = sys_rst_n;

//parameter define
parameter  CLK_FREQ = 200_000_000;         //定义系统时钟频率
parameter  UART_BPS = 115200;              //定义串口波特率
parameter  DEBOUNCE_CNT = CLK_FREQ/2;

assign led3 = 1'b0;
assign led4 = (rst_n)?1:0;
assign led5 = (rst_n)?1:0;
assign led6 = (rst_n)?1:0;
assign led7 = (rst_n)?1:0;

    
//wire define   
wire       uart_recv_done;              //UART接收完成
wire [7:0] uart_recv_data;              //UART接收数据
wire       uart_send_en;                //UART发送使能
wire [7:0] uart_send_data;              //UART发送数据
wire       uart_tx_busy;                //UART发送忙状态标志



//*****************************************************
//**                    main code
//*****************************************************

reg [3:0]   current_state;
reg         sw1_flag;
reg [31:0]  cnt_sw1_flag;

always@(posedge sys_clk or negedge rst_n)begin
	if(!rst_n)
		cnt_sw1_flag <= 'd0;
	else if(sw1_flag)begin
		if(cnt_sw1_flag == DEBOUNCE_CNT - 1'b1)
			cnt_sw1_flag <= 'd0;
		else
			cnt_sw1_flag <= cnt_sw1_flag + 1'b1;
	end
end

assign led0 = current_state[0];
assign led1 = uart_recv_done;




always@(posedge sys_clk or negedge rst_n)begin
	if(!rst_n)
		sw1_flag <= 1'b0;
	else begin
		if(sw1)
			sw1_flag <= 1'b1;
		else if(cnt_sw1_flag == DEBOUNCE_CNT - 1'b1)
			sw1_flag <= 1'b0;
	end
end	

always@(posedge sys_clk or negedge rst_n)begin
	if(!rst_n)
		current_state <= 'd0;
	else begin
		if((cnt_sw1_flag == DEBOUNCE_CNT - 1'b1) && (sw1_flag) &&(sw1))
			if(current_state == 'd0)
				current_state <= 'd1;
			else if(current_state == 'd1)
				current_state <= 'd0;		
	end
end



wire        bram_out_vld;
wire [7:0]  bram_out;

//串口接收模块     
uart_recv #(                          
    .CLK_FREQ       (CLK_FREQ),         //设置系统时钟频率
    .UART_BPS       (UART_BPS))         //设置串口接收波特率
u_uart_recv(                 
    .sys_clk        (sys_clk), 
    .sys_rst_n      (rst_n),
    
    .uart_rxd       (uart_rxd),
    .uart_done      (uart_recv_done),
    .uart_data      (uart_recv_data)
    );

//串口发送模块    
uart_send #(                          
    .CLK_FREQ       (CLK_FREQ),         //设置系统时钟频率
    .UART_BPS       (UART_BPS))         //设置串口发送波特率
u_uart_send(                 
    .sys_clk        (sys_clk),
    .sys_rst_n      (rst_n),
     
    .uart_en        (uart_send_en),
    .uart_din       (uart_send_data),
    .uart_tx_busy   (uart_tx_busy),
    .uart_txd       (uart_txd)
    );
    
reg 	    send_en_buff;
reg [7:0] send_data_buff;

always@(*)begin
	if(current_state == 'd0)begin
		send_en_buff   <=  uart_recv_done;
		send_data_buff <=  uart_recv_data;
	end
	else if(current_state == 'd1)begin
		send_en_buff   <=  bram_out_vld;
	 	send_data_buff <=  bram_out;
	end
	else begin
		send_en_buff   <=  'd0;
	 	send_data_buff <=  'd0;
	end
end
    
//串口环回模块    
uart_loop u_uart_loop(
    .sys_clk        (sys_clk),             
    .sys_rst_n      (rst_n),
               
    .recv_done      (send_en_buff ),   //接收一帧数据完成标志信号
    .recv_data      (send_data_buff),   //接收的数据 
   
    .tx_busy        (uart_tx_busy),     //发送忙状态标志      
    .send_en        (uart_send_en),     //发送使能信号
    .send_data      (uart_send_data)    //待发送数据
);
wire [14:0] addr_start;

uart_send_output_1000#(                          
    .CLK_FREQ       (CLK_FREQ),         //设置系统时钟频率
    .UART_BPS       (UART_BPS)         //设置串口发送波特率
) u_uart_send_output_1000         
(
.   clk            (sys_clk),
.   rst_n          (rst_n),
.   current_state  (current_state),
.   sw2            (sw2),
.   addr_start     (addr_start),
.   send_en        (bram_out_vld),                   //发送使能信号
.   send_data      (bram_out)                  //待发送数据
);

wire bram_addr_vld;
//image_uart_decoder u_image_uart_decoder(
//.clk             (sys_clk        ),
//.rst_n           (rst_n          ),
//.recv_vld        (uart_recv_done ),
//.recv_data       (uart_recv_data ),
//.bram_addr_start (addr_start     ),
//.bram_addr_vld   (bram_addr_vld  )
//);

assign led2 = bram_addr_vld;

image_uart_ascii_decoder u_image_uart_ascii_decoder(
.clk              (sys_clk        ),
.rst_n            (rst_n          ),
.recv_asc_vld     (uart_recv_done ),
.recv_ascii_data  (uart_recv_data ),
.bram_addr_start  (addr_start     ),
.bram_addr_vld    (bram_addr_vld  )
);

    
endmodule