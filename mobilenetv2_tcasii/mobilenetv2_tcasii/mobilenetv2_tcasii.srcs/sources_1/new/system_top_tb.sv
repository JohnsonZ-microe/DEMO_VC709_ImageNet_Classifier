`timescale 1ns / 100ps
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
  bit clk_in_p;  
  bit clk_in_n;
  logic rst;
  logic ena;
  logic [31:0] reg_config_data_in;
  logic [3:0] reg_config_addr;
  logic reg_config_valid;

  logic [7:0] conv_output0, conv_output1, conv_output2;
  // --------------   DEBUG -----------------//
  reg test_read_mode;  // 1'b1: tb control, 1'b0: normal control
  reg [14:0] bram0_read_addr_tb;  // tb control read address
  system_top system_top0(
               .clk_in_p(clk_in_p),
               .clk_in_n(clk_in_n),
               .rstp_sys(rst),
               .control_source(1'b1),  
               .rstn_accelerator(rst),
               .pcie_addr(),
               .pcie_data_in(),
               .pcie_write_ena(),
               .pcie_data_out()
              //  .test_read_mode(test_read_mode),  // 1'b1: tb control, 1'b0: normal control
              //  .bram0_read_addr_tb(bram0_read_addr_tb),  // tb control read address
               //        --------------   DEBUG
              //  .conv_output0(conv_output0), .conv_output1(conv_output1), .conv_output2(conv_output2)
               //  ------------------------------------------------
             );

  always #2.5 clk_in_p = ~clk_in_p;
  assign clk_in_n = ~clk_in_p;


  initial
  begin
    clk_in_p = 0;
    ena = 0;
    rst = 1;
    reg_config_data_in = 0;
    reg_config_valid=0;
    reg_config_addr =0;
    @(posedge system_top0.clk_gen.locked);
     rst = 0;
    #10;
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
  end

  initial begin
    integer idx, i;
    integer file;
    reg [71:0] bram_read_data; 
    reg[8*20 - 1 : 1] fname;
    
    test_read_mode  = 1'b0;  // 默认不使用测试模�?
    bram0_read_addr_tb = 18'd0;  // 默认读取地址�?0
    // #500000;
    // // #1505495;//layer1
    // // #501950; //layer2
    // // #1003710;//layer3
    // // #2759880;//layer4
    // // #345150; //layer5
    // // #1035070;//layer6
    // #19894655;//layer1-27sc
    // #20000000;
    // #8000000;
    // #40245375;//layer1 - 53
    // #5000000;
    // #40256900;
    // #100000;
    // #20130000;
    // // $display("Simulation timeout");
    // // $fclose(f0);
    // ena = 0;  // 停止仿真
    // test_read_mode = 1'b1;  // 切换到测试模�?
    
    // for (idx = 0; idx < 9; idx = idx + 1) begin
    //     bram0_read_addr_tb = 17'd0;  // 重置读取地址
        
    //     // 生成文件�?
    //     $sformat(fname, "bram%0d.txt", idx);
    //     file = $fopen(fname, "w");
        
    //     // 写入文件头部信息
    //     $fdisplay(file, "BRAM content exported from simulation");
    //     $fdisplay(file, "memory_initialization_radix=16;");
    //     $fdisplay(file, "memory_initialization_vector=");
        
    //     for (i = 0; i < 104100; i = i + 1) begin  // BRAM深度
    //         // 读BRAM的时序控�?
    //         @(posedge clk_in_p);
    //         @(posedge clk_in_p);
         
    //         #1;  // 等待输出稳定
            
    //         // 根据索引选择对应的BRAM数据
    //         case (idx)
    //             0: bram_read_data = system_top0.bram0_read_input;
    //             1: bram_read_data = system_top0.bram1_read_input;
    //             2: bram_read_data = system_top0.bram2_read_input;
    //             3: bram_read_data = system_top0.bram3_read_input;
    //             4: bram_read_data = system_top0.bram4_read_input;
    //             5: bram_read_data = system_top0.bram5_read_input;
    //             6: bram_read_data = system_top0.bram6_read_input;
    //             7: bram_read_data = system_top0.bram7_read_input;
    //             8: bram_read_data = system_top0.bram8_read_input;
    //         endcase
            
    //         // 写入数据到文�?
    //         $fdisplay(file, "Addr %d  %h", bram0_read_addr_tb, bram_read_data);
            
    //         // 更新地址
    //         bram0_read_addr_tb = bram0_read_addr_tb + 1;
    //     end
        
    //     $fclose(file);
    // end
    
    // bram0_read_addr_tb = 15'd0;
    // $finish;
end
// 修正敏感列表及时钟触发�?�辑，正确使用文件句柄并添加地址标识

integer addr_counter0, addr_counter1, addr_counter2;
integer addr_counter3, addr_counter4, addr_counter5;
integer addr_counter6, addr_counter7, addr_counter8;

integer layer_counter;  // 层计数器，记录当前层�?
reg complete_prev;      // 用于�?测complete信号的边�?
integer fd;  // 文件句柄变量
integer file_handle;
// 初始化所有计数器（仿真开始时执行�?次）
reg [14:0] complete_reg;
always @(posedge system_top0.clk) begin
    complete_reg <= {complete_reg[13:0], system_top0.complete};
end


initial begin
    complete_reg = 10'b0;

    
    // 层计数器初始化（�?1�?始）
    layer_counter = 1;
    complete_prev = 1'b0;  // 初始化为低电�?

    file_handle = $fopen("bram0.txt", "w");
    $fdisplay(file_handle, "layer 1");
    $fclose(file_handle);
    file_handle = $fopen("bram1.txt", "w");
    $fdisplay(file_handle, "layer 1");
    $fclose(file_handle);
    file_handle = $fopen("bram2.txt", "w");
    $fdisplay(file_handle, "layer 1");
    $fclose(file_handle);
    file_handle = $fopen("bram3.txt", "w");
    $fdisplay(file_handle, "layer 1");
    $fclose(file_handle);
    file_handle = $fopen("bram4.txt", "w");
    $fdisplay(file_handle, "layer 1");
    $fclose(file_handle);
    file_handle = $fopen("bram5.txt", "w");
    $fdisplay(file_handle, "layer 1");
    $fclose(file_handle);
    file_handle = $fopen("bram6.txt", "w");
    $fdisplay(file_handle, "layer 1");
    $fclose(file_handle);
    file_handle = $fopen("bram7.txt", "w");
    $fdisplay(file_handle, "layer 1");
    $fclose(file_handle);
    file_handle = $fopen("bram8.txt", "w");
    $fdisplay(file_handle, "layer 1");
    $fclose(file_handle);
    // #753000; //layer1
    // #350000;
    // #500000;
    // #5000000;
    // #2885813; //layer1-4

    // #5332463; //layer1-9
    // #100000;
    // #100000;//avgpool test
    #30000000;
    $finish;

end
// 初始化所有计数器（仿真开始时执行�?次）

always @(posedge system_top0.clk) begin  // 时钟沿触�?

    complete_prev = system_top0.complete;
    if(complete_reg[14])begin
        file_handle = $fopen("bram0.txt", "a");
        $fdisplay(file_handle, "layer %d", system_top0.central_control0.cnt_layer + 1);
        $fclose(file_handle);
        file_handle = $fopen("bram1.txt", "a");
        $fdisplay(file_handle, "layer %d", system_top0.central_control0.cnt_layer + 1);
        $fclose(file_handle);
        file_handle = $fopen("bram2.txt", "a");
        $fdisplay(file_handle, "layer %d", system_top0.central_control0.cnt_layer + 1);
        $fclose(file_handle);
        file_handle = $fopen("bram3.txt", "a");
        $fdisplay(file_handle, "layer %d", system_top0.central_control0.cnt_layer + 1);
        $fclose(file_handle);
        file_handle = $fopen("bram4.txt", "a");
        $fdisplay(file_handle, "layer %d", system_top0.central_control0.cnt_layer + 1);
        $fclose(file_handle);
        file_handle = $fopen("bram5.txt", "a");
        $fdisplay(file_handle, "layer %d", system_top0.central_control0.cnt_layer + 1);
        $fclose(file_handle);
        file_handle = $fopen("bram6.txt", "a");
        $fdisplay(file_handle, "layer %d", system_top0.central_control0.cnt_layer + 1);
        $fclose(file_handle);
        file_handle = $fopen("bram7.txt", "a");
        $fdisplay(file_handle, "layer %d", system_top0.central_control0.cnt_layer + 1);
        $fclose(file_handle);
        file_handle = $fopen("bram8.txt", "a");
        $fdisplay(file_handle, "layer %d", system_top0.central_control0.cnt_layer + 1);
        $fclose(file_handle);
    end

    if(system_top0.data_bram_we[0]) begin
        fd = $fopen("bram0.txt", "a");
        if (fd) begin
            $fdisplay(fd, "  Addr %0d %h", system_top0.bram_write_addr[0], system_top0.ofmap_write_0_reg_mux);
            $fclose(fd);

        end
    end
    
    if(system_top0.data_bram_we[1]) begin
        fd = $fopen("bram1.txt", "a");
        if (fd) begin
            $fdisplay(fd, " Addr %0d %h",  system_top0.bram_write_addr[1], system_top0.ofmap_write_1_mux);
            $fclose(fd);

        end
    end
    
    if(system_top0.data_bram_we[2]) begin
        fd = $fopen("bram2.txt", "a");
        if (fd) begin
            $fdisplay(fd, " Addr %0d %h", system_top0.bram_write_addr[2], system_top0.ofmap_write_2_mux);
            $fclose(fd);
        end
    end

    if(system_top0.data_bram_we[3]) begin
        fd = $fopen("bram3.txt", "a");
        if (fd) begin
            $fdisplay(fd, " Addr %0d %h", system_top0.bram_write_addr[3], system_top0.ofmap_write_3_mux);
            $fclose(fd);
        end
    end

    if(system_top0.data_bram_we[4]) begin
        fd = $fopen("bram4.txt", "a");
        if (fd) begin
            $fdisplay(fd, " Addr %0d %h", system_top0.bram_write_addr[4], system_top0.ofmap_write_4_mux);
            $fclose(fd);
        end
    end

    if(system_top0.data_bram_we[5]) begin
        fd = $fopen("bram5.txt", "a");
        if (fd) begin
            $fdisplay(fd, " Addr %0d %h", system_top0.bram_write_addr[5], system_top0.ofmap_write_5_mux);
            $fclose(fd);
        end
    end

    if(system_top0.data_bram_we[6]) begin
        fd = $fopen("bram6.txt", "a");
        if (fd) begin
            $fdisplay(fd, " Addr %0d %h", system_top0.bram_write_addr[6], system_top0.ofmap_write_6_mux);
            $fclose(fd);
        end
    end

    if(system_top0.data_bram_we[7]) begin
        fd = $fopen("bram7.txt", "a");
        if (fd) begin
            $fdisplay(fd, " Addr %0d %h", system_top0.bram_write_addr[7], system_top0.ofmap_write_7_mux);
            $fclose(fd);
        end
    end

    if(system_top0.data_bram_we[8]) begin
        fd = $fopen("bram8.txt", "a");
        if (fd) begin
            $fdisplay(fd, " Addr %0d %h", system_top0.bram_write_addr[8], system_top0.ofmap_write_8_mux);
            $fclose(fd);
        end
    end
end
    
    
endmodule
