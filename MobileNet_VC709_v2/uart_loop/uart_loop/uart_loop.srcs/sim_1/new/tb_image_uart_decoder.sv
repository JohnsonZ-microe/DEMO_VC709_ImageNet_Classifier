`timescale 1ns/100ps
module tb_image_uart_decoder;

 logic         clk              ;
 logic         rst_n            ;
 logic [14:0]  bram_addr_start  ;
 logic         bram_addr_vld    ;
 
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
 
    
image_uart_decoder u_image_uart_decoder(
.clk             (clk            ),
.rst_n           (rst_n          ),
.recv_done       (send_en        ),
.recv_data       (send_data      ),
.bram_addr_start (bram_addr_start),
.bram_addr_vld   (bram_addr_vld  )
);
endmodule
