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
.sys_clk    (clk) ,            //�ⲿ50Mʱ��
.sys_rst_n  (rst_n) ,          //�ⲿ��λ�źţ�����Ч
.uart_rxd   (tx_data) ,           //UART���ն˿�
.uart_txd   (uart_txd),         //UART���Ͷ˿�
.sw1(sw1),
.sw2(sw2)
);

always#10 clk = ~clk; 
    
parameter  CLK_FREQ = 50000000;              //ϵͳʱ��Ƶ��
parameter  UART_BPS = 115200;                //���ڲ�����
localparam  BPS_CNT  = CLK_FREQ/UART_BPS;     //Ϊ�õ�ָ�������ʣ���ϵͳʱ�Ӽ���BPS_CNT��

reg [15:0] clk_cnt;                         //ϵͳʱ�Ӽ�����


//*****************************************************
//**                    main code
//*****************************************************

//���뷢�͹��̺�����ϵͳʱ�Ӽ�����
always @(posedge clk or negedge rst_n) begin         
    if (!rst_n)                             
        clk_cnt <= 16'd0;                                  
    else if (start) begin                 //���ڷ��͹���
        if (clk_cnt < BPS_CNT - 1)
            clk_cnt <= clk_cnt + 1'b1;
        else
            clk_cnt <= 16'd0;               //��ϵͳʱ�Ӽ�����һ�����������ں�����
    end
    else                             
        clk_cnt <= 16'd0; 				    //���͹��̽���
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
