`timescale 1ns / 100ps
module tb_uso_1000;
logic clk;
logic rst_n;
logic sw2;

initial begin
clk = 1'b1;
rst_n = 1'b0;
#200 rst_n = 1'b1;
end

always# 2.5 clk = ~clk;
assign sw2 = 1'b1;


uart_send_output_1000 u_uso1000(
	.clk          (clk),
	.rst_n        (rst_n),
	.current_state(4'd1),
	.sw2          (sw2),
	.addr_start   ('d0),
    .send_en      (),                   //发送使能信号
    .send_data    ()         //待发送数据
);

endmodule
