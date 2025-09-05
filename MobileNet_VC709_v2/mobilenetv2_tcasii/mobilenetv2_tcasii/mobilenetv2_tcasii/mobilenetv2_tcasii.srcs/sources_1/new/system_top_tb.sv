`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/12 17:03:29
// Design Name: 
// Module Name: system_top_tb
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


module system_top_tb();
bit clk;
logic rst;
logic ena;
logic [31:0] reg_config_data_in;
logic [3:0] reg_config_addr;
logic reg_config_valid;

logic [7:0] conv_output0, conv_output1, conv_output2;

system_top system_top0(
    .clk(clk),
    .rst(rst),
    .enable(ena),

//        --------------   DEBUG
    .conv_output0(conv_output0), .conv_output1(conv_output1), .conv_output2(conv_output2)
//  ------------------------------------------------
    );

always #5 clk = ~clk;

initial begin
clk = 0;
ena = 0;
rst = 1;
reg_config_data_in = 0;
reg_config_valid=0;
reg_config_addr =0;
#10
rst = 0;
#10
rst = 1;
ena = 1;
//reg_config_addr = 0;
//reg_config_data_in = 32'd208; 
//reg_config_valid = 1;
//#10
//reg_config_addr = 1;
//reg_config_data_in = 32'd0;
//#10
//reg_config_addr = 2;
//reg_config_data_in = 32'd5625;
//#10
//reg_config_addr = 3;
//reg_config_data_in = 32'd0;
//#10
//reg_config_addr = 4;
//reg_config_data_in = 32'd0;
//#10
//reg_config_addr = 5;
//reg_config_data_in = 32'd0;
//#10
//reg_config_addr = 6;
//reg_config_data_in = 32'b1000000000000000_00000000_01100101;
//#10
//reg_config_addr = 7; 
//reg_config_data_in = 32'b0000000001_00000000100_0000000_0_1_01; 
//#10
//reg_config_valid = 0;
end

integer f0, f1, f2;

initial begin
    $display("Simulation start");
    f0 = $fopen("conv_out.txt", "w");
    if(f0) $display("File conv_out.txt open successfully");
    else $display("ERROR File conv_out.txt NOT open successfully");
//    f1 = $fopen("conv_out_1.txt", "w");
//    if(f1) $display("File conv_out_1.txt open successfully");
//    else $display("ERROR File conv_out_1.txt NOT open successfully");
//    f2 = $fopen("conv_out_2.txt", "w");
//    if(f2) $display("File conv_out_2.txt open successfully");
//    else $display("ERROR File conv_out_2.txt NOT open successfully");
    repeat(380000)  begin @(posedge clk) 
        if(ena)
        $fwrite(f0,"%d\n",conv_output0);
        $fwrite(f0,"%d\n",conv_output1);
        $fwrite(f0,"%d\n",conv_output2);
        $display("T = %t clock out", $time);
    end
    $fclose(f0);
    $fclose(f1);
    $fclose(f2);
    $finish;    
end


endmodule
