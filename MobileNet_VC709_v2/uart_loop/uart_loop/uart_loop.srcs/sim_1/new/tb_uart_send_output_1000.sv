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
.   send_en       (send_en),                   //发送使能信号
.   send_data     (send_data)             //待发送数据
);
wire tx_busy;
wire tx_vld;
wire [7:0] tx_data;
uart_loop u_uart_loop(
.  sys_clk    (clk) ,                   //系统时钟
.  sys_rst_n  (rst_n) ,                 //系统复位，低电平有效
.  recv_done  (send_en) ,                 //接收一帧数据完成标志
.  recv_data  (send_data) ,                 //接收的数据
.  tx_busy    (tx_busy) ,                   //发送忙状态标志      
.  send_en    (tx_vld) ,                   //发送使能信号
.  send_data  (tx_data)                //待发送数据
 );
 wire txd;
 uart_send u_uart_send2(
.   sys_clk      (clk),                  //系统时钟
.   sys_rst_n    (rst_n),                //系统复位，低电平有效
.   uart_en      (tx_vld),                  //发送使能信号
.   uart_din     (tx_data),                 //待发送数据
.   uart_tx_busy (tx_busy),             //发送忙状态标志      
.   uart_txd     (txd)             //UART发送端口
 );
 
 wire rx_done;
 wire [7:0]rx_data;
 uart_recv u_uart_r(
.	     sys_clk   (clk)  ,                  //系统时钟
.        sys_rst_n (rst_n)  ,                //系统复位，低电平有效
.        uart_rxd  (txd)  ,                 //UART接收端口
.        uart_done (rx_done)  ,                //接收一帧数据完成标志
.        uart_data (rx_data)               //接收的数据
    );

endmodule
