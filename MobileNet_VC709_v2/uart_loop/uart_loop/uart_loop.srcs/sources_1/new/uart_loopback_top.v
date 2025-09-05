//****************************************Copyright (c)***********************************//
//ԭ�Ӹ����߽�ѧƽ̨��www.yuanzige.com
//����֧�֣�www.openedv.com
//�Ա����̣�http://openedv.taobao.com 
//��ע΢�Ź���ƽ̨΢�źţ�"����ԭ��"����ѻ�ȡZYNQ & FPGA & STM32 & LINUX���ϡ�
//��Ȩ���У�����ؾ���
//Copyright(C) ����ԭ�� 2018-2028
//All rights reserved	                               
//----------------------------------------------------------------------------------------
// File name:           uart_loopback_top
// Last modified Date:  2019/10/9 9:56:36
// Last Version:        V1.0
// Descriptions:        ������ͨ�����ڽ���PC���͵��ַ���Ȼ���յ����ַ����͸�PC
//----------------------------------------------------------------------------------------
// Created by:          ����ԭ��
// Created date:        2019/10/9 9:56:36
// Version:             V1.0
// Descriptions:        The original version
//
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module uart_loopback_top(
    input           sys_clk,
    input           sys_rst_n,          //�ⲿ��λ�źţ�����Ч
    
    input            sw1,
    input            sw2,

    input           uart_rxd,           //UART���ն˿�
    output          uart_txd,           //UART���Ͷ˿�
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
parameter  CLK_FREQ = 200_000_000;         //����ϵͳʱ��Ƶ��
parameter  UART_BPS = 115200;              //���崮�ڲ�����
parameter  DEBOUNCE_CNT = CLK_FREQ/2;

assign led3 = 1'b0;
assign led4 = (rst_n)?1:0;
assign led5 = (rst_n)?1:0;
assign led6 = (rst_n)?1:0;
assign led7 = (rst_n)?1:0;

    
//wire define   
wire       uart_recv_done;              //UART�������
wire [7:0] uart_recv_data;              //UART��������
wire       uart_send_en;                //UART����ʹ��
wire [7:0] uart_send_data;              //UART��������
wire       uart_tx_busy;                //UART����æ״̬��־



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

//���ڽ���ģ��     
uart_recv #(                          
    .CLK_FREQ       (CLK_FREQ),         //����ϵͳʱ��Ƶ��
    .UART_BPS       (UART_BPS))         //���ô��ڽ��ղ�����
u_uart_recv(                 
    .sys_clk        (sys_clk), 
    .sys_rst_n      (rst_n),
    
    .uart_rxd       (uart_rxd),
    .uart_done      (uart_recv_done),
    .uart_data      (uart_recv_data)
    );

//���ڷ���ģ��    
uart_send #(                          
    .CLK_FREQ       (CLK_FREQ),         //����ϵͳʱ��Ƶ��
    .UART_BPS       (UART_BPS))         //���ô��ڷ��Ͳ�����
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
    
//���ڻ���ģ��    
uart_loop u_uart_loop(
    .sys_clk        (sys_clk),             
    .sys_rst_n      (rst_n),
               
    .recv_done      (send_en_buff ),   //����һ֡������ɱ�־�ź�
    .recv_data      (send_data_buff),   //���յ����� 
   
    .tx_busy        (uart_tx_busy),     //����æ״̬��־      
    .send_en        (uart_send_en),     //����ʹ���ź�
    .send_data      (uart_send_data)    //����������
);
wire [14:0] addr_start;

uart_send_output_1000#(                          
    .CLK_FREQ       (CLK_FREQ),         //����ϵͳʱ��Ƶ��
    .UART_BPS       (UART_BPS)         //���ô��ڷ��Ͳ�����
) u_uart_send_output_1000         
(
.   clk            (sys_clk),
.   rst_n          (rst_n),
.   current_state  (current_state),
.   sw2            (sw2),
.   addr_start     (addr_start),
.   send_en        (bram_out_vld),                   //����ʹ���ź�
.   send_data      (bram_out)                  //����������
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