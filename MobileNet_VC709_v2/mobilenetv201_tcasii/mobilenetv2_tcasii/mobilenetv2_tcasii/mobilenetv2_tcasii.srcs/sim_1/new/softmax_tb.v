`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/09/10 17:13:37
// Design Name: 
// Module Name: softmax_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module softmax_tb(

    );
    reg clk;
    reg rst_n;
    reg softmax_en;
    always #5 clk = ~clk;
    wire [71:0]data_in;
    wire [7:0]data0,data1,data2,data3,data4,data5,data6,data7,data8;
    reg [7:0]counter;
    assign data_in = {data8,data7,data6,data5,data4,data3,data2,data1,data0};
    assign data0 = counter;
    assign data1 = counter+1;
    assign data2 = counter+2;
    assign data3 = counter+3;
    assign data4 = counter+4;
    assign data5 = counter+5;
    assign data6 = counter+6;
    assign data7 = counter+7;
    assign data8 = counter+8;
    always @(posedge clk) begin
        if(!rst_n)
            counter <= 8'd0;
        else 
            counter <= counter + 2;
    end

  initial
  begin
    clk = 0;
    rst_n = 1;
    #10
     rst_n = 0;
    #10
     rst_n = 1;
    #12000;
    $finish;
    end

    softmax u_softmax(
        .clk(clk),
        .rst_n(rst_n),
        .softmax_en(1'b1),
        .data_in(data_in),
        .bram_read_base_addr(),
        .bram_write_base_addr(18'd0),
        .softmax_read_addr(),
        .softmax_write_addr(),
        .softmax_out(),
        .softmax_finish()
    );

endmodule
