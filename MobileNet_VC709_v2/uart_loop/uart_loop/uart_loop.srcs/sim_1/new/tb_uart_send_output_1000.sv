module tb_uart_send_output_1000;

logic clk;
logic rst_n;
logic [3:0] current_state;
assign current_state = 4'd1;
logic sw2;

initial begin
clk   = 1'b1;
rst_n = 1'b0;
sw2 = 1'b0;
#200 rst_n = 1'b1;
#200 sw2 = 1'b1;
#300 sw2 = 1'b0;

end
always#2.5 clk = ~clk;

logic send_en;
logic [7:0]send_data;


uart_send_output_1000_sv u_uart_send1(
.   clk           (clk),
.   rst_n         (rst_n),
.   current_state (current_state),
.   sw2           (sw2),
.   send_en       (send_en),                   //����ʹ���ź�
.   send_data     (send_data)             //����������
);
wire tx_busy;
wire tx_vld;
wire [7:0] tx_data;
uart_loop u_uart_loop(
.  sys_clk    (clk) ,                   //ϵͳʱ��
.  sys_rst_n  (rst_n) ,                 //ϵͳ��λ���͵�ƽ��Ч
.  recv_done  (send_en) ,                 //����һ֡������ɱ�־
.  recv_data  (send_data) ,                 //���յ�����
.  tx_busy    (tx_busy) ,                   //����æ״̬��־      
.  send_en    (tx_vld) ,                   //����ʹ���ź�
.  send_data  (tx_data)                //����������
 );
 wire txd;
 uart_send u_uart_send2(
.   sys_clk      (clk),                  //ϵͳʱ��
.   sys_rst_n    (rst_n),                //ϵͳ��λ���͵�ƽ��Ч
.   uart_en      (tx_vld),                  //����ʹ���ź�
.   uart_din     (tx_data),                 //����������
.   uart_tx_busy (tx_busy),             //����æ״̬��־      
.   uart_txd     (txd)             //UART���Ͷ˿�
 );
 
 wire rx_done;
 wire [7:0]rx_data;
 uart_recv u_uart_r(
.	     sys_clk   (clk)  ,                  //ϵͳʱ��
.        sys_rst_n (rst_n)  ,                //ϵͳ��λ���͵�ƽ��Ч
.        uart_rxd  (txd)  ,                 //UART���ն˿�
.        uart_done (rx_done)  ,                //����һ֡������ɱ�־
.        uart_data (rx_data)               //���յ�����
    );

endmodule
