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
  // --------------   DEBUG -----------------//
  reg test_read_mode;  // 1'b1: tb control, 1'b0: normal control
  reg [16:0] bram0_read_addr_tb;  // tb control read address
  system_top system_top0(
               .clk(clk),
               .rst(rst),
               .enable(ena),
               .test_read_mode(test_read_mode),  // 1'b1: tb control, 1'b0: normal control
               .bram0_read_addr_tb(bram0_read_addr_tb),  // tb control read address
               //        --------------   DEBUG
               .conv_output0(conv_output0), .conv_output1(conv_output1), .conv_output2(conv_output2)
               //  ------------------------------------------------
             );

  always #5 clk = ~clk;

  initial
  begin
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

  initial
  begin

    $display("Simulation start");
    f0 = $fopen("conv_out.txt", "w");
    if(f0)
      $display("File conv_out.txt open successfully");
    else
      $display("ERROR File conv_out.txt NOT open successfully");
    //    f1 = $fopen("conv_out_1.txt", "w");
    //    if(f1) $display("File conv_out_1.txt open successfully");
    //    else $display("ERROR File conv_out_1.txt NOT open successfully");
    //    f2 = $fopen("conv_out_2.txt", "w");
    //    if(f2) $display("File conv_out_2.txt open successfully");
    //    else $display("ERROR File conv_out_2.txt NOT open successfully");
    forever
    begin
      @(posedge clk);

      // 在信号有效时记录数据
      if(ena)
      begin
        $fwrite(f0, "%d\n%d\n%d\n", conv_output0, conv_output1, conv_output2);
        $display("T = %t: ofmap_write_ena triggered, data written", $time);
      end
    end
  end

  initial begin
    integer idx, i;
    integer file;
    reg [71:0] bram_read_data; 
    string fname;
    
    test_read_mode  = 1'b0;  // 默认不使用测试模式
    bram0_read_addr_tb = 17'd0;  // 默认读取地址为0
    #1505495;//layer1
    #501950; //layer2
    #1003710;//layer3
    #2759880;//layer4
    #345150; //layer5
    #1035070;//layer6
    #5000000;
    #100000;
    $display("Simulation timeout");
    $fclose(f0);
    ena = 0;  // 停止仿真
    test_read_mode = 1'b1;  // 切换到测试模式
    
    for (idx = 0; idx < 9; idx = idx + 1) begin
        bram0_read_addr_tb = 17'd0;  // 重置读取地址
        
        // 生成文件名
        $sformat(fname, "bram%0d.txt", idx);
        file = $fopen(fname, "w");
        
        // 写入文件头部信息
        $fdisplay(file, "BRAM content exported from simulation");
        $fdisplay(file, "memory_initialization_radix=16;");
        $fdisplay(file, "memory_initialization_vector=");
        
        for (i = 0; i < 54000; i = i + 1) begin  // BRAM深度
            // 读BRAM的时序控制
            @(posedge clk);
            @(posedge clk);
         
            #1;  // 等待输出稳定
            
            // 根据索引选择对应的BRAM数据
            case (idx)
                0: bram_read_data = system_top0.bram0_read_input;
                1: bram_read_data = system_top0.bram1_read_input;
                2: bram_read_data = system_top0.bram2_read_input;
                3: bram_read_data = system_top0.bram3_read_input;
                4: bram_read_data = system_top0.bram4_read_input;
                5: bram_read_data = system_top0.bram5_read_input;
                6: bram_read_data = system_top0.bram6_read_input;
                7: bram_read_data = system_top0.bram7_read_input;
                8: bram_read_data = system_top0.bram8_read_input;
            endcase
            
            // 写入数据到文件
            $fdisplay(file, "Addr %d  %h", bram0_read_addr_tb, bram_read_data);
            
            // 更新地址
            bram0_read_addr_tb = bram0_read_addr_tb + 1;
        end
        
        $fclose(file);
    end
    
    bram0_read_addr_tb = 15'd0;
    $finish;
end

//   initial
//   begin
//     // for (idx = 0; idx < 9; idx = idx + 1) begin
//     //     bram0_read_addr_tb = 15'd0;  // 重置读取地址
//     //     $sformat(fname, "bram%0d.txt", idx);
//     //     file = $fopen(fname, "w");  // 也可以用 .coe
//     //     $fdisplay(file, "BRAM content exported from simulation");
//     //     $fdisplay(file, "memory_initialization_radix=16;");
//     //     $fdisplay(file, "memory_initialization_vector=");
//     //     $sformat(output_name, "system_top0.bram%d_read_input", idx);
//     //     for (i = 0; i < 11406; i = i + 1) begin  // 修改为你BRAM深度
//     //         // 读 BRAM 的过程：
//     //         @(posedge clk);
//     //         @(posedge clk);
//     //         @(posedge clk);
//     //         #1; // 等待输出稳定
//     //         case (idx)
//     //             0: bram_read_data = system_top0.bram0_read_input;
//     //             1: bram_read_data = system_top0.bram1_read_input;
//     //             2: bram_read_data = system_top0.bram2_read_input;
//     //             3: bram_read_data = system_top0.bram3_read_input;
//     //             4: bram_read_data = system_top0.bram4_read_input;
//     //             5: bram_read_data = system_top0.bram5_read_input;
//     //             6: bram_read_data = system_top0.bram6_read_input;
//     //             7: bram_read_data = system_top0.bram7_read_input;
//     //             8: bram_read_data = system_top0.bram8_read_input;
//     //         endcase
//     //         if (i != 11405)
//     //             $fdisplay(file, "Addr %d  %h",bram0_read_addr_tb, bram_read_data);  // 写入数据
//     //         else
//     //             $fdisplay(file, "Addr %d  %h",bram0_read_addr_tb, bram_read_data);  // 最后一项用分号
//     //         bram0_read_addr_tb = bram0_read_addr_tb + 1;  // 更新地址
//     //     end
//     // end
//     test_read_mode  = 1'b0;  // 默认不使用测试模式
//     bram0_read_addr_tb = 15'd0;  // 默认读取地址为
//     #1505495;
//     $display("Simulation timeout");
//     $fclose(f0);
//     ena = 0;  // 停止仿真
//     test_read_mode = 1'b1;  // 切换到测试模式
//     file = $fopen("bram0.txt", "w");  // 也可以用 .coe
//     $fdisplay(file, "BRAM content exported from simulation");
//     $fdisplay(file, "memory_initialization_radix=16;");
//     $fdisplay(file, "memory_initialization_vector=");
//     for (i = 0; i < 11406; i = i + 1)
//     begin  // 修改为你BRAM深度
//       // 读 BRAM 的过程：
//       @(posedge clk);
//       @(posedge clk);
//       @(posedge clk);
//       #1; // 等待输出稳定
//       if (i != 11405)
//         $fdisplay(file, "Addr %d  %h",bram0_read_addr_tb, system_top0.bram0_read_input);  // 写入数据
//       else
//         $fdisplay(file, "Addr %d  %h",bram0_read_addr_tb, system_top0.bram0_read_input);  // 最后一项用分号
//       bram0_read_addr_tb = bram0_read_addr_tb + 1;  // 更新地址
//     end
//     $fclose(file);
//     bram0_read_addr_tb = 15'd0;
//     file = $fopen("bram1.txt", "w");  // 也可以用 .coe
//     $fdisplay(file, "BRAM content exported from simulation");
//     $fdisplay(file, "memory_initialization_radix=16;");
//     $fdisplay(file, "memory_initialization_vector=");
//     for (i = 0; i < 11406; i = i + 1)
//     begin  // 修改为你BRAM深度
//       // 读 BRAM 的过程：
//       @(posedge clk);
//       @(posedge clk);
//       @(posedge clk);
//       #1; // 等待输出稳定
//       if (i != 11405)
//         $fdisplay(file, "Addr %d  %h",bram0_read_addr_tb, system_top0.bram1_read_input);  // 写入数据
//       else
//         $fdisplay(file, "Addr %d  %h",bram0_read_addr_tb, system_top0.bram1_read_input);  // 最后一项用分号
//       bram0_read_addr_tb = bram0_read_addr_tb + 1;  // 更新地址
//     end
//     $fclose(file);
//     bram0_read_addr_tb = 15'd0;
//         file = $fopen("bram2.txt", "w");  // 也可以用 .coe
//     $fdisplay(file, "BRAM content exported from simulation");
//     $fdisplay(file, "memory_initialization_radix=16;");
//     $fdisplay(file, "memory_initialization_vector=");
//     for (i = 0; i < 11406; i = i + 1)
//     begin  // 修改为你BRAM深度
//       // 读 BRAM 的过程：
//       @(posedge clk);
//       @(posedge clk);
//       @(posedge clk);
//       #1; // 等待输出稳定
//       if (i != 11405)
//         $fdisplay(file, "Addr %d  %h",bram0_read_addr_tb, system_top0.bram2_read_input);  // 写入数据
//       else
//         $fdisplay(file, "Addr %d  %h",bram0_read_addr_tb, system_top0.bram2_read_input);  // 最后一项用分号
//       bram0_read_addr_tb = bram0_read_addr_tb + 1;  // 更新地址
//     end
//     $fclose(file);
//     bram0_read_addr_tb = 15'd0;
//         file = $fopen("bram3.txt", "w");  // 也可以用 .coe
//     $fdisplay(file, "BRAM content exported from simulation");
//     $fdisplay(file, "memory_initialization_radix=16;");
//     $fdisplay(file, "memory_initialization_vector=");
//     for (i = 0; i < 11406; i = i + 1)
//     begin  // 修改为你BRAM深度
//       // 读 BRAM 的过程：
//       @(posedge clk);
//       @(posedge clk);
//       @(posedge clk);
//       #1; // 等待输出稳定
//       if (i != 11405)
//         $fdisplay(file, "Addr %d  %h",bram0_read_addr_tb, system_top0.bram3_read_input);  // 写入数据
//       else
//         $fdisplay(file, "Addr %d  %h",bram0_read_addr_tb, system_top0.bram3_read_input);  // 最后一项用分号
//       bram0_read_addr_tb = bram0_read_addr_tb + 1;  // 更新地址
//     end
//     $fclose(file);
//     bram0_read_addr_tb = 15'd0;
//         file = $fopen("bram4.txt", "w");  // 也可以用 .coe
//     $fdisplay(file, "BRAM content exported from simulation");
//     $fdisplay(file, "memory_initialization_radix=16;");
//     $fdisplay(file, "memory_initialization_vector=");
//     for (i = 0; i < 11406; i = i + 1)
//     begin  // 修改为你BRAM深度
//       // 读 BRAM 的过程：
//       @(posedge clk);
//       @(posedge clk);
//       @(posedge clk);
//       #1; // 等待输出稳定
//       if (i != 11405)
//         $fdisplay(file, "Addr %d  %h",bram0_read_addr_tb, system_top0.bram4_read_input);  // 写入数据
//       else
//         $fdisplay(file, "Addr %d  %h",bram0_read_addr_tb, system_top0.bram4_read_input);  // 最后一项用分号
//       bram0_read_addr_tb = bram0_read_addr_tb + 1;  // 更新地址
//     end
//     $fclose(file);
//     bram0_read_addr_tb = 15'd0;
//         file = $fopen("bram5.txt", "w");  // 也可以用 .coe
//     $fdisplay(file, "BRAM content exported from simulation");
//     $fdisplay(file, "memory_initialization_radix=16;");
//     $fdisplay(file, "memory_initialization_vector=");
//     for (i = 0; i < 11406; i = i + 1)
//     begin  // 修改为你BRAM深度
//       // 读 BRAM 的过程：
//       @(posedge clk);
//       @(posedge clk);
//       @(posedge clk);
//       #1; // 等待输出稳定
//       if (i != 11405)
//         $fdisplay(file, "Addr %d  %h",bram0_read_addr_tb, system_top0.bram5_read_input);  // 写入数据
//       else
//         $fdisplay(file, "Addr %d  %h",bram0_read_addr_tb, system_top0.bram5_read_input);  // 最后一项用分号
//       bram0_read_addr_tb = bram0_read_addr_tb + 1;  // 更新地址
//     end
//     $fclose(file);
//     bram0_read_addr_tb = 15'd0;
//         file = $fopen("bram6.txt", "w");  // 也可以用 .coe
//     $fdisplay(file, "BRAM content exported from simulation");
//     $fdisplay(file, "memory_initialization_radix=16;");
//     $fdisplay(file, "memory_initialization_vector=");
//     for (i = 0; i < 11406; i = i + 1)
//     begin  // 修改为你BRAM深度
//       // 读 BRAM 的过程：
//       @(posedge clk);
//       @(posedge clk);
//       @(posedge clk);
//       #1; // 等待输出稳定
//       if (i != 11405)
//         $fdisplay(file, "Addr %d  %h",bram0_read_addr_tb, system_top0.bram6_read_input);  // 写入数据
//       else
//         $fdisplay(file, "Addr %d  %h",bram0_read_addr_tb, system_top0.bram6_read_input);  // 最后一项用分号
//       bram0_read_addr_tb = bram0_read_addr_tb + 1;  // 更新地址
//     end
//     $fclose(file);
//     bram0_read_addr_tb = 15'd0;
//         file = $fopen("bram7.txt", "w");  // 也可以用 .coe
//     $fdisplay(file, "BRAM content exported from simulation");
//     $fdisplay(file, "memory_initialization_radix=16;");
//     $fdisplay(file, "memory_initialization_vector=");
//     for (i = 0; i < 11406; i = i + 1)
//     begin  // 修改为你BRAM深度
//       // 读 BRAM 的过程：
//       @(posedge clk);
//       @(posedge clk);
//       @(posedge clk);
//       #1; // 等待输出稳定
//       if (i != 11405)
//         $fdisplay(file, "Addr %d  %h",bram0_read_addr_tb, system_top0.bram7_read_input);  // 写入数据
//       else
//         $fdisplay(file, "Addr %d  %h",bram0_read_addr_tb, system_top0.bram7_read_input);  // 最后一项用分号
//       bram0_read_addr_tb = bram0_read_addr_tb + 1;  // 更新地址
//     end
//     $fclose(file);
//     bram0_read_addr_tb = 15'd0;
//         file = $fopen("bram8.txt", "w");  // 也可以用 .coe
//     $fdisplay(file, "BRAM content exported from simulation");
//     $fdisplay(file, "memory_initialization_radix=16;");
//     $fdisplay(file, "memory_initialization_vector=");
//     for (i = 0; i < 11406; i = i + 1)
//     begin  // 修改为你BRAM深度
//       // 读 BRAM 的过程：
//       @(posedge clk);
//       @(posedge clk);
//       @(posedge clk);
//       #1; // 等待输出稳定
//       if (i != 11405)
//         $fdisplay(file, "Addr %d  %h",bram0_read_addr_tb, system_top0.bram8_read_input);  // 写入数据
//       else
//         $fdisplay(file, "Addr %d  %h",bram0_read_addr_tb, system_top0.bram8_read_input);  // 最后一项用分号
//       bram0_read_addr_tb = bram0_read_addr_tb + 1;  // 更新地址
//     end
//     $fclose(file);
//     bram0_read_addr_tb = 15'd0;
//     $finish;
//   end

endmodule
