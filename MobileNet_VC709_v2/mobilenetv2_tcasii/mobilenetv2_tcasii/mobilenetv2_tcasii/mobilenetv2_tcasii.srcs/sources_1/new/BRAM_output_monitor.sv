`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/25 15:46:41
// Design Name: 
// Module Name: BRAM_output_monitor
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


(* dont_touch = "true"*)module BRAM_output_monitor
#(
    parameter SAMPLE_NUM = 15,
    parameter DATA_WIDTH = 8,
    parameter DATA_DISPLAY_IF = 0,
    parameter M1_WIDTH = 32
)
(
    input clk,
    input rst,
    Data_Bram_DEBUG_if.MONITOR Data_Bram_DEBUG_if0,
    Data_Bram_DEBUG_if.MONITOR Data_Bram_DEBUG_if1,
    Data_Bram_DEBUG_if.MONITOR Data_Bram_DEBUG_if2,
    Data_Bram_DEBUG_if.MONITOR Data_Bram_DEBUG_if3,
    Data_Bram_DEBUG_if.MONITOR Data_Bram_DEBUG_if4,
    Data_Bram_DEBUG_if.MONITOR Data_Bram_DEBUG_if5,
    Data_Bram_DEBUG_if.MONITOR Data_Bram_DEBUG_if6,
    Data_Bram_DEBUG_if.MONITOR Data_Bram_DEBUG_if7,
    Data_Bram_DEBUG_if.MONITOR Data_Bram_DEBUG_if8,
    Kernel_Bram_DEBUG_if.MONITOR Kernel_Bram_DEBUG_if0,
    Kernel_Bram_DEBUG_if.MONITOR Kernel_Bram_DEBUG_if1,
    Kernel_Bram_DEBUG_if.MONITOR Kernel_Bram_DEBUG_if2,
    Kernel_Bram_DEBUG_if.MONITOR Kernel_Bram_DEBUG_if3,
    Kernel_Bram_DEBUG_if.MONITOR Kernel_Bram_DEBUG_if4,
    Kernel_Bram_DEBUG_if.MONITOR Kernel_Bram_DEBUG_if5,
    Kernel_Bram_DEBUG_if.MONITOR Kernel_Bram_DEBUG_if6,
    Kernel_Bram_DEBUG_if.MONITOR Kernel_Bram_DEBUG_if7,
    Kernel_Bram_DEBUG_if.MONITOR Kernel_Bram_DEBUG_if8,
    M1_Bram_DEBUG_if.MONITOR M1_Bram_DEBUG_if0
    );
    
    reg [31:0] sample_cnt;
    always@(posedge clk)begin
    if(!rst) begin
        sample_cnt <= 0;
    end 
    else begin
        sample_cnt <= sample_cnt + 1;
    end
    end
    
    wire [4:0] DATA_Display_if;
    assign DATA_Display_if = DATA_DISPLAY_IF;
    always@(posedge clk) begin
    if(sample_cnt==SAMPLE_NUM) begin
        case(DATA_Display_if) 
        5'd0: begin
        $display("start sample %0t: sample: %0d Data_BRAM0 data", $time, sample_cnt);
        $display("DATA BRAM: %d is displayed, address is %0d", DATA_Display_if, $signed(Data_Bram_DEBUG_if0.addrb) );
        $display("%0t, MAC1 input data is %0d",$time, $signed(Data_Bram_DEBUG_if0.doutb[DATA_WIDTH*1-1:DATA_WIDTH*0]));
        $display("%0t, MAC2 input data is %0d",$time, $signed(Data_Bram_DEBUG_if0.doutb[DATA_WIDTH*2-1:DATA_WIDTH*1]));
        $display("%0t, MAC3 input data is %0d",$time, $signed(Data_Bram_DEBUG_if0.doutb[DATA_WIDTH*3-1:DATA_WIDTH*2]));
        $display("%0t, MAC4 input data is %0d",$time, $signed(Data_Bram_DEBUG_if0.doutb[DATA_WIDTH*4-1:DATA_WIDTH*3]));
        $display("%0t, MAC5 input data is %0d",$time, $signed(Data_Bram_DEBUG_if0.doutb[DATA_WIDTH*5-1:DATA_WIDTH*4]));
        $display("%0t, MAC6 input data is %0d",$time, $signed(Data_Bram_DEBUG_if0.doutb[DATA_WIDTH*6-1:DATA_WIDTH*5]));
        $display("%0t, MAC7 input data is %0d",$time, $signed(Data_Bram_DEBUG_if0.doutb[DATA_WIDTH*7-1:DATA_WIDTH*6]));
        $display("%0t, MAC8 input data is %0d",$time, $signed(Data_Bram_DEBUG_if0.doutb[DATA_WIDTH*8-1:DATA_WIDTH*7]));
        $display("%0t, MAC9 input data is %0d",$time, $signed(Data_Bram_DEBUG_if0.doutb[DATA_WIDTH*9-1:DATA_WIDTH*8]));
        end
        5'd1: begin
        $display("start sample %0t: sample: %0d Data_BRAM1 data", $time, sample_cnt);
        $display("DATA BRAM: %d is displayed, address is %0d", DATA_Display_if, $signed(Data_Bram_DEBUG_if1.addrb) );
        $display("%0t, MAC1 input data is %0d",$time, $signed(Data_Bram_DEBUG_if1.doutb[DATA_WIDTH*1-1:DATA_WIDTH*0]));
        $display("%0t, MAC2 input data is %0d",$time, $signed(Data_Bram_DEBUG_if1.doutb[DATA_WIDTH*2-1:DATA_WIDTH*1]));
        $display("%0t, MAC3 input data is %0d",$time, $signed(Data_Bram_DEBUG_if1.doutb[DATA_WIDTH*3-1:DATA_WIDTH*2]));
        $display("%0t, MAC4 input data is %0d",$time, $signed(Data_Bram_DEBUG_if1.doutb[DATA_WIDTH*4-1:DATA_WIDTH*3]));
        $display("%0t, MAC5 input data is %0d",$time, $signed(Data_Bram_DEBUG_if1.doutb[DATA_WIDTH*5-1:DATA_WIDTH*4]));
        $display("%0t, MAC6 input data is %0d",$time, $signed(Data_Bram_DEBUG_if1.doutb[DATA_WIDTH*6-1:DATA_WIDTH*5]));
        $display("%0t, MAC7 input data is %0d",$time, $signed(Data_Bram_DEBUG_if1.doutb[DATA_WIDTH*7-1:DATA_WIDTH*6]));
        $display("%0t, MAC8 input data is %0d",$time, $signed(Data_Bram_DEBUG_if1.doutb[DATA_WIDTH*8-1:DATA_WIDTH*7]));
        $display("%0t, MAC9 input data is %0d",$time, $signed(Data_Bram_DEBUG_if1.doutb[DATA_WIDTH*9-1:DATA_WIDTH*8]));
        end
        5'd2: begin
        $display("start sample %0t: sample: %0d Data_BRAM2 data", $time, sample_cnt);
        $display("DATA BRAM: %d is displayed, address is %0d", DATA_Display_if, $signed(Data_Bram_DEBUG_if2.addrb) );
        $display("%0t, MAC1 input data is %0d",$time, $signed(Data_Bram_DEBUG_if2.doutb[DATA_WIDTH*1-1:DATA_WIDTH*0]));
        $display("%0t, MAC2 input data is %0d",$time, $signed(Data_Bram_DEBUG_if2.doutb[DATA_WIDTH*2-1:DATA_WIDTH*1]));
        $display("%0t, MAC3 input data is %0d",$time, $signed(Data_Bram_DEBUG_if2.doutb[DATA_WIDTH*3-1:DATA_WIDTH*2]));
        $display("%0t, MAC4 input data is %0d",$time, $signed(Data_Bram_DEBUG_if2.doutb[DATA_WIDTH*4-1:DATA_WIDTH*3]));
        $display("%0t, MAC5 input data is %0d",$time, $signed(Data_Bram_DEBUG_if2.doutb[DATA_WIDTH*5-1:DATA_WIDTH*4]));
        $display("%0t, MAC6 input data is %0d",$time, $signed(Data_Bram_DEBUG_if2.doutb[DATA_WIDTH*6-1:DATA_WIDTH*5]));
        $display("%0t, MAC7 input data is %0d",$time, $signed(Data_Bram_DEBUG_if2.doutb[DATA_WIDTH*7-1:DATA_WIDTH*6]));
        $display("%0t, MAC8 input data is %0d",$time, $signed(Data_Bram_DEBUG_if2.doutb[DATA_WIDTH*8-1:DATA_WIDTH*7]));
        $display("%0t, MAC9 input data is %0d",$time, $signed(Data_Bram_DEBUG_if2.doutb[DATA_WIDTH*9-1:DATA_WIDTH*8]));
        end
        5'd3: begin
        $display("start sample %0t: sample: %0d Data_BRAM3 data", $time, sample_cnt);
        $display("DATA BRAM: %d is displayed, address is %0d", DATA_Display_if, $signed(Data_Bram_DEBUG_if3.addrb) );
        $display("%0t, MAC1 input data is %0d",$time, $signed(Data_Bram_DEBUG_if3.doutb[DATA_WIDTH*1-1:DATA_WIDTH*0]));
        $display("%0t, MAC2 input data is %0d",$time, $signed(Data_Bram_DEBUG_if3.doutb[DATA_WIDTH*2-1:DATA_WIDTH*1]));
        $display("%0t, MAC3 input data is %0d",$time, $signed(Data_Bram_DEBUG_if3.doutb[DATA_WIDTH*3-1:DATA_WIDTH*2]));
        $display("%0t, MAC4 input data is %0d",$time, $signed(Data_Bram_DEBUG_if3.doutb[DATA_WIDTH*4-1:DATA_WIDTH*3]));
        $display("%0t, MAC5 input data is %0d",$time, $signed(Data_Bram_DEBUG_if3.doutb[DATA_WIDTH*5-1:DATA_WIDTH*4]));
        $display("%0t, MAC6 input data is %0d",$time, $signed(Data_Bram_DEBUG_if3.doutb[DATA_WIDTH*6-1:DATA_WIDTH*5]));
        $display("%0t, MAC7 input data is %0d",$time, $signed(Data_Bram_DEBUG_if3.doutb[DATA_WIDTH*7-1:DATA_WIDTH*6]));
        $display("%0t, MAC8 input data is %0d",$time, $signed(Data_Bram_DEBUG_if3.doutb[DATA_WIDTH*8-1:DATA_WIDTH*7]));
        $display("%0t, MAC9 input data is %0d",$time, $signed(Data_Bram_DEBUG_if3.doutb[DATA_WIDTH*9-1:DATA_WIDTH*8]));
        end
        5'd4: begin
        $display("start sample %0t: sample: %0d Data_BRAM4 data", $time, sample_cnt);
        $display("DATA BRAM: %d is displayed, address is %0d", DATA_Display_if, $signed(Data_Bram_DEBUG_if4.addrb) );
        $display("%0t, MAC1 input data is %0d",$time, $signed(Data_Bram_DEBUG_if4.doutb[DATA_WIDTH*1-1:DATA_WIDTH*0]));
        $display("%0t, MAC2 input data is %0d",$time, $signed(Data_Bram_DEBUG_if4.doutb[DATA_WIDTH*2-1:DATA_WIDTH*1]));
        $display("%0t, MAC3 input data is %0d",$time, $signed(Data_Bram_DEBUG_if4.doutb[DATA_WIDTH*3-1:DATA_WIDTH*2]));
        $display("%0t, MAC4 input data is %0d",$time, $signed(Data_Bram_DEBUG_if4.doutb[DATA_WIDTH*4-1:DATA_WIDTH*3]));
        $display("%0t, MAC5 input data is %0d",$time, $signed(Data_Bram_DEBUG_if4.doutb[DATA_WIDTH*5-1:DATA_WIDTH*4]));
        $display("%0t, MAC6 input data is %0d",$time, $signed(Data_Bram_DEBUG_if4.doutb[DATA_WIDTH*6-1:DATA_WIDTH*5]));
        $display("%0t, MAC7 input data is %0d",$time, $signed(Data_Bram_DEBUG_if4.doutb[DATA_WIDTH*7-1:DATA_WIDTH*6]));
        $display("%0t, MAC8 input data is %0d",$time, $signed(Data_Bram_DEBUG_if4.doutb[DATA_WIDTH*8-1:DATA_WIDTH*7]));
        $display("%0t, MAC9 input data is %0d",$time, $signed(Data_Bram_DEBUG_if4.doutb[DATA_WIDTH*9-1:DATA_WIDTH*8]));
        end
        5'd5: begin
        $display("start sample %0t: sample: %0d Data_BRAM5 data", $time, sample_cnt);
        $display("DATA BRAM: %d is displayed, address is %0d", DATA_Display_if, $signed(Data_Bram_DEBUG_if5.addrb) );
        $display("%0t, MAC1 input data is %0d",$time, $signed(Data_Bram_DEBUG_if5.doutb[DATA_WIDTH*1-1:DATA_WIDTH*0]));
        $display("%0t, MAC2 input data is %0d",$time, $signed(Data_Bram_DEBUG_if5.doutb[DATA_WIDTH*2-1:DATA_WIDTH*1]));
        $display("%0t, MAC3 input data is %0d",$time, $signed(Data_Bram_DEBUG_if5.doutb[DATA_WIDTH*3-1:DATA_WIDTH*2]));
        $display("%0t, MAC4 input data is %0d",$time, $signed(Data_Bram_DEBUG_if5.doutb[DATA_WIDTH*4-1:DATA_WIDTH*3]));
        $display("%0t, MAC5 input data is %0d",$time, $signed(Data_Bram_DEBUG_if5.doutb[DATA_WIDTH*5-1:DATA_WIDTH*4]));
        $display("%0t, MAC6 input data is %0d",$time, $signed(Data_Bram_DEBUG_if5.doutb[DATA_WIDTH*6-1:DATA_WIDTH*5]));
        $display("%0t, MAC7 input data is %0d",$time, $signed(Data_Bram_DEBUG_if5.doutb[DATA_WIDTH*7-1:DATA_WIDTH*6]));
        $display("%0t, MAC8 input data is %0d",$time, $signed(Data_Bram_DEBUG_if5.doutb[DATA_WIDTH*8-1:DATA_WIDTH*7]));
        $display("%0t, MAC9 input data is %0d",$time, $signed(Data_Bram_DEBUG_if5.doutb[DATA_WIDTH*9-1:DATA_WIDTH*8]));
        end
        5'd6: begin
        $display("start sample %0t: sample: %0d Data_BRAM6 data", $time, sample_cnt);
        $display("DATA BRAM: %d is displayed, address is %0d", DATA_Display_if, $signed(Data_Bram_DEBUG_if6.addrb) );
        $display("%0t, MAC1 input data is %0d",$time, $signed(Data_Bram_DEBUG_if6.doutb[DATA_WIDTH*1-1:DATA_WIDTH*0]));
        $display("%0t, MAC2 input data is %0d",$time, $signed(Data_Bram_DEBUG_if6.doutb[DATA_WIDTH*2-1:DATA_WIDTH*1]));
        $display("%0t, MAC3 input data is %0d",$time, $signed(Data_Bram_DEBUG_if6.doutb[DATA_WIDTH*3-1:DATA_WIDTH*2]));
        $display("%0t, MAC4 input data is %0d",$time, $signed(Data_Bram_DEBUG_if6.doutb[DATA_WIDTH*4-1:DATA_WIDTH*3]));
        $display("%0t, MAC5 input data is %0d",$time, $signed(Data_Bram_DEBUG_if6.doutb[DATA_WIDTH*5-1:DATA_WIDTH*4]));
        $display("%0t, MAC6 input data is %0d",$time, $signed(Data_Bram_DEBUG_if6.doutb[DATA_WIDTH*6-1:DATA_WIDTH*5]));
        $display("%0t, MAC7 input data is %0d",$time, $signed(Data_Bram_DEBUG_if6.doutb[DATA_WIDTH*7-1:DATA_WIDTH*6]));
        $display("%0t, MAC8 input data is %0d",$time, $signed(Data_Bram_DEBUG_if6.doutb[DATA_WIDTH*8-1:DATA_WIDTH*7]));
        $display("%0t, MAC9 input data is %0d",$time, $signed(Data_Bram_DEBUG_if6.doutb[DATA_WIDTH*9-1:DATA_WIDTH*8]));
        end
        5'd7: begin
        $display("start sample %0t: sample: %0d Data_BRAM7 data", $time, sample_cnt);
        $display("DATA BRAM: %d is displayed, address is %0d", DATA_Display_if, $signed(Data_Bram_DEBUG_if7.addrb) );
        $display("%0t, MAC1 input data is %0d",$time, $signed(Data_Bram_DEBUG_if7.doutb[DATA_WIDTH*1-1:DATA_WIDTH*0]));
        $display("%0t, MAC2 input data is %0d",$time, $signed(Data_Bram_DEBUG_if7.doutb[DATA_WIDTH*2-1:DATA_WIDTH*1]));
        $display("%0t, MAC3 input data is %0d",$time, $signed(Data_Bram_DEBUG_if7.doutb[DATA_WIDTH*3-1:DATA_WIDTH*2]));
        $display("%0t, MAC4 input data is %0d",$time, $signed(Data_Bram_DEBUG_if7.doutb[DATA_WIDTH*4-1:DATA_WIDTH*3]));
        $display("%0t, MAC5 input data is %0d",$time, $signed(Data_Bram_DEBUG_if7.doutb[DATA_WIDTH*5-1:DATA_WIDTH*4]));
        $display("%0t, MAC6 input data is %0d",$time, $signed(Data_Bram_DEBUG_if7.doutb[DATA_WIDTH*6-1:DATA_WIDTH*5]));
        $display("%0t, MAC7 input data is %0d",$time, $signed(Data_Bram_DEBUG_if7.doutb[DATA_WIDTH*7-1:DATA_WIDTH*6]));
        $display("%0t, MAC8 input data is %0d",$time, $signed(Data_Bram_DEBUG_if7.doutb[DATA_WIDTH*8-1:DATA_WIDTH*7]));
        $display("%0t, MAC9 input data is %0d",$time, $signed(Data_Bram_DEBUG_if7.doutb[DATA_WIDTH*9-1:DATA_WIDTH*8]));
        end
        5'd8: begin
        $display("start sample %0t: sample: %0d Data_BRAM8 data", $time, sample_cnt);
        $display("DATA BRAM: %d is displayed, address is %0d", DATA_Display_if, $signed(Data_Bram_DEBUG_if8.addrb) );
        $display("%0t, MAC1 input data is %0d",$time, $signed(Data_Bram_DEBUG_if8.doutb[DATA_WIDTH*1-1:DATA_WIDTH*0]));
        $display("%0t, MAC2 input data is %0d",$time, $signed(Data_Bram_DEBUG_if8.doutb[DATA_WIDTH*2-1:DATA_WIDTH*1]));
        $display("%0t, MAC3 input data is %0d",$time, $signed(Data_Bram_DEBUG_if8.doutb[DATA_WIDTH*3-1:DATA_WIDTH*2]));
        $display("%0t, MAC4 input data is %0d",$time, $signed(Data_Bram_DEBUG_if8.doutb[DATA_WIDTH*4-1:DATA_WIDTH*3]));
        $display("%0t, MAC5 input data is %0d",$time, $signed(Data_Bram_DEBUG_if8.doutb[DATA_WIDTH*5-1:DATA_WIDTH*4]));
        $display("%0t, MAC6 input data is %0d",$time, $signed(Data_Bram_DEBUG_if8.doutb[DATA_WIDTH*6-1:DATA_WIDTH*5]));
        $display("%0t, MAC7 input data is %0d",$time, $signed(Data_Bram_DEBUG_if8.doutb[DATA_WIDTH*7-1:DATA_WIDTH*6]));
        $display("%0t, MAC8 input data is %0d",$time, $signed(Data_Bram_DEBUG_if8.doutb[DATA_WIDTH*8-1:DATA_WIDTH*7]));
        $display("%0t, MAC9 input data is %0d",$time, $signed(Data_Bram_DEBUG_if8.doutb[DATA_WIDTH*9-1:DATA_WIDTH*8]));
        end
        default: begin
        $display("");
        end
        endcase
    end
    else begin
    $display("");
    end
    end
    wire M1_display;
    assign M1_display = 1;
    always@(posedge clk) begin
    if(M1_display) 
        if (sample_cnt == SAMPLE_NUM) begin
        $display("%0t, M1 array0 input data is %0d",$time, $signed(M1_Bram_DEBUG_if0.douta[M1_WIDTH*1-1:M1_WIDTH*0]));
        $display("%0t, M1 array1 input data is %0d",$time, $signed(M1_Bram_DEBUG_if0.douta[M1_WIDTH*2-1:M1_WIDTH*1]));
        $display("%0t, M1 array2 input data is %0d",$time, $signed(M1_Bram_DEBUG_if0.douta[M1_WIDTH*3-1:M1_WIDTH*2]));
        $display("%0t, M1 array3 input data is %0d",$time, $signed(M1_Bram_DEBUG_if0.douta[M1_WIDTH*4-1:M1_WIDTH*3]));
        $display("%0t, M1 array4 input data is %0d",$time, $signed(M1_Bram_DEBUG_if0.douta[M1_WIDTH*5-1:M1_WIDTH*4]));
        $display("%0t, M1 array5 input data is %0d",$time, $signed(M1_Bram_DEBUG_if0.douta[M1_WIDTH*6-1:M1_WIDTH*5]));
        $display("%0t, M1 array6 input data is %0d",$time, $signed(M1_Bram_DEBUG_if0.douta[M1_WIDTH*7-1:M1_WIDTH*6]));
        $display("%0t, M1 array7 input data is %0d",$time, $signed(M1_Bram_DEBUG_if0.douta[M1_WIDTH*8-1:M1_WIDTH*7]));
        $display("%0t, M1 array8 input data is %0d",$time, $signed(M1_Bram_DEBUG_if0.douta[M1_WIDTH*9-1:M1_WIDTH*8]));
        end
        else 
        ;
    else if(sample_cnt == SAMPLE_NUM) begin
        case(DATA_Display_if) 
        0: begin
        $display("start sample %0t: sample: %0d Kernel_BRAM0 weight", $time, sample_cnt);
        $display("Kernel BRAM: %d is displayed, address is %0d", DATA_Display_if, $signed(Kernel_Bram_DEBUG_if0.addra));
        $display("%0t, MAC2 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if0.douta[DATA_WIDTH*2-1:DATA_WIDTH*1]));
        $display("%0t, MAC3 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if0.douta[DATA_WIDTH*3-1:DATA_WIDTH*2]));
        $display("%0t, MAC4 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if0.douta[DATA_WIDTH*4-1:DATA_WIDTH*3]));
        $display("%0t, MAC5 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if0.douta[DATA_WIDTH*5-1:DATA_WIDTH*4]));
        $display("%0t, MAC6 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if0.douta[DATA_WIDTH*6-1:DATA_WIDTH*5]));
        $display("%0t, MAC7 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if0.douta[DATA_WIDTH*7-1:DATA_WIDTH*6]));
        $display("%0t, MAC8 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if0.douta[DATA_WIDTH*8-1:DATA_WIDTH*7]));
        $display("%0t, MAC9 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if0.douta[DATA_WIDTH*9-1:DATA_WIDTH*8]));
        $display("%0t, M1 input data is %0d",$time, $signed(M1_Bram_DEBUG_if0.douta[M1_WIDTH*1-1:M1_WIDTH*0]));
        end
        1: begin
        $display("start sample %0t: sample: %0d Kernel_BRAM1 weight", $time, sample_cnt);
        $display("Kernel BRAM: %d is displayed, address is %0d", DATA_Display_if, $signed(Kernel_Bram_DEBUG_if1.addra));
        $display("%0t, MAC1 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if1.douta[DATA_WIDTH*1-1:DATA_WIDTH*0]));
        $display("%0t, MAC2 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if1.douta[DATA_WIDTH*2-1:DATA_WIDTH*1]));
        $display("%0t, MAC3 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if1.douta[DATA_WIDTH*3-1:DATA_WIDTH*2]));
        $display("%0t, MAC4 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if1.douta[DATA_WIDTH*4-1:DATA_WIDTH*3]));
        $display("%0t, MAC5 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if1.douta[DATA_WIDTH*5-1:DATA_WIDTH*4]));
        $display("%0t, MAC6 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if1.douta[DATA_WIDTH*6-1:DATA_WIDTH*5]));
        $display("%0t, MAC7 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if1.douta[DATA_WIDTH*7-1:DATA_WIDTH*6]));
        $display("%0t, MAC8 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if1.douta[DATA_WIDTH*8-1:DATA_WIDTH*7]));
        $display("%0t, MAC9 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if1.douta[DATA_WIDTH*9-1:DATA_WIDTH*8]));
        $display("%0t, M1 input data is %0d",$time, $signed(M1_Bram_DEBUG_if0.douta[M1_WIDTH*2-1:M1_WIDTH*1]));
        end
        2: begin
        $display("start sample %0t: sample: %0d Kernel_BRAM2 weight", $time, sample_cnt);
        $display("Kernel BRAM: %d is displayed, address is %0d", DATA_Display_if, $signed(Kernel_Bram_DEBUG_if2.addra));
        $display("%0t, MAC1 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if2.douta[DATA_WIDTH*1-1:DATA_WIDTH*0]));
        $display("%0t, MAC2 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if2.douta[DATA_WIDTH*2-1:DATA_WIDTH*1]));
        $display("%0t, MAC3 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if2.douta[DATA_WIDTH*3-1:DATA_WIDTH*2]));
        $display("%0t, MAC4 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if2.douta[DATA_WIDTH*4-1:DATA_WIDTH*3]));
        $display("%0t, MAC5 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if2.douta[DATA_WIDTH*5-1:DATA_WIDTH*4]));
        $display("%0t, MAC6 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if2.douta[DATA_WIDTH*6-1:DATA_WIDTH*5]));
        $display("%0t, MAC7 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if2.douta[DATA_WIDTH*7-1:DATA_WIDTH*6]));
        $display("%0t, MAC8 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if2.douta[DATA_WIDTH*8-1:DATA_WIDTH*7]));
        $display("%0t, MAC9 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if2.douta[DATA_WIDTH*9-1:DATA_WIDTH*8]));
        $display("%0t, M1 input data is %0d",$time, $signed(M1_Bram_DEBUG_if0.douta[M1_WIDTH*3-1:M1_WIDTH*2]));
        end
        3: begin
        $display("start sample %0t: sample: %0d Kernel_BRAM3 weight", $time, sample_cnt);
        $display("Kernel BRAM: %d is displayed, address is %0d", DATA_Display_if, $signed(Kernel_Bram_DEBUG_if3.addra));
        $display("%0t, MAC1 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if3.douta[DATA_WIDTH*1-1:DATA_WIDTH*0]));
        $display("%0t, MAC2 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if3.douta[DATA_WIDTH*2-1:DATA_WIDTH*1]));
        $display("%0t, MAC3 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if3.douta[DATA_WIDTH*3-1:DATA_WIDTH*2]));
        $display("%0t, MAC4 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if3.douta[DATA_WIDTH*4-1:DATA_WIDTH*3]));
        $display("%0t, MAC5 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if3.douta[DATA_WIDTH*5-1:DATA_WIDTH*4]));
        $display("%0t, MAC6 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if3.douta[DATA_WIDTH*6-1:DATA_WIDTH*5]));
        $display("%0t, MAC7 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if3.douta[DATA_WIDTH*7-1:DATA_WIDTH*6]));
        $display("%0t, MAC8 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if3.douta[DATA_WIDTH*8-1:DATA_WIDTH*7]));
        $display("%0t, MAC9 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if3.douta[DATA_WIDTH*9-1:DATA_WIDTH*8]));
        $display("%0t, M1 input data is %0d",$time, $signed(M1_Bram_DEBUG_if0.douta[M1_WIDTH*4-1:M1_WIDTH*3]));
        end
        4: begin
        $display("start sample %0t: sample: %0d Kernel_BRAM4 weight", $time, sample_cnt);
        $display("Kernel BRAM: %d is displayed, address is %0d", DATA_Display_if, $signed(Kernel_Bram_DEBUG_if4.addra));
        $display("%0t, MAC1 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if4.douta[DATA_WIDTH*1-1:DATA_WIDTH*0]));
        $display("%0t, MAC2 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if4.douta[DATA_WIDTH*2-1:DATA_WIDTH*1]));
        $display("%0t, MAC3 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if4.douta[DATA_WIDTH*3-1:DATA_WIDTH*2]));
        $display("%0t, MAC4 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if4.douta[DATA_WIDTH*4-1:DATA_WIDTH*3]));
        $display("%0t, MAC5 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if4.douta[DATA_WIDTH*5-1:DATA_WIDTH*4]));
        $display("%0t, MAC6 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if4.douta[DATA_WIDTH*6-1:DATA_WIDTH*5]));
        $display("%0t, MAC7 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if4.douta[DATA_WIDTH*7-1:DATA_WIDTH*6]));
        $display("%0t, MAC8 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if4.douta[DATA_WIDTH*8-1:DATA_WIDTH*7]));
        $display("%0t, MAC9 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if4.douta[DATA_WIDTH*9-1:DATA_WIDTH*8]));
        $display("%0t, M1 input data is %0d",$time, $signed(M1_Bram_DEBUG_if0.douta[M1_WIDTH*5-1:M1_WIDTH*4]));
        end
        5: begin
        $display("start sample %0t: sample: %0d Kernel_BRAM5 weight", $time, sample_cnt);
        $display("Kernel BRAM: %d is displayed, address is %0d", DATA_Display_if, $signed(Kernel_Bram_DEBUG_if5.addra));
        $display("%0t, MAC1 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if5.douta[DATA_WIDTH*1-1:DATA_WIDTH*0]));
        $display("%0t, MAC2 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if5.douta[DATA_WIDTH*2-1:DATA_WIDTH*1]));
        $display("%0t, MAC3 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if5.douta[DATA_WIDTH*3-1:DATA_WIDTH*2]));
        $display("%0t, MAC4 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if5.douta[DATA_WIDTH*4-1:DATA_WIDTH*3]));
        $display("%0t, MAC5 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if5.douta[DATA_WIDTH*5-1:DATA_WIDTH*4]));
        $display("%0t, MAC6 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if5.douta[DATA_WIDTH*6-1:DATA_WIDTH*5]));
        $display("%0t, MAC7 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if5.douta[DATA_WIDTH*7-1:DATA_WIDTH*6]));
        $display("%0t, MAC8 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if5.douta[DATA_WIDTH*8-1:DATA_WIDTH*7]));
        $display("%0t, MAC9 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if5.douta[DATA_WIDTH*9-1:DATA_WIDTH*8]));
        $display("%0t, M1 input data is %0d",$time, $signed(M1_Bram_DEBUG_if0.douta[M1_WIDTH*6-1:M1_WIDTH*5]));
        end
        6: begin
        $display("start sample %0t: sample: %0d Kernel_BRAM6 weight", $time, sample_cnt);
        $display("Kernel BRAM: %d is displayed, address is %0d", DATA_Display_if, $signed(Kernel_Bram_DEBUG_if6.addra));
        $display("%0t, MAC1 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if6.douta[DATA_WIDTH*1-1:DATA_WIDTH*0]));
        $display("%0t, MAC2 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if6.douta[DATA_WIDTH*2-1:DATA_WIDTH*1]));
        $display("%0t, MAC3 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if6.douta[DATA_WIDTH*3-1:DATA_WIDTH*2]));
        $display("%0t, MAC4 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if6.douta[DATA_WIDTH*4-1:DATA_WIDTH*3]));
        $display("%0t, MAC5 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if6.douta[DATA_WIDTH*5-1:DATA_WIDTH*4]));
        $display("%0t, MAC6 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if6.douta[DATA_WIDTH*6-1:DATA_WIDTH*5]));
        $display("%0t, MAC7 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if6.douta[DATA_WIDTH*7-1:DATA_WIDTH*6]));
        $display("%0t, MAC8 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if6.douta[DATA_WIDTH*8-1:DATA_WIDTH*7]));
        $display("%0t, MAC9 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if6.douta[DATA_WIDTH*9-1:DATA_WIDTH*8]));
        $display("%0t, M1 input data is %0d",$time, $signed(M1_Bram_DEBUG_if0.douta[M1_WIDTH*7-1:M1_WIDTH*6]));
        end
        7: begin
        $display("start sample %0t: sample: %0d Kernel_BRAM7 weight", $time, sample_cnt);
        $display("Kernel BRAM: %d is displayed, address is %0d", DATA_Display_if, $signed(Kernel_Bram_DEBUG_if7.addra));
        $display("%0t, MAC1 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if7.douta[DATA_WIDTH*1-1:DATA_WIDTH*0]));
        $display("%0t, MAC2 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if7.douta[DATA_WIDTH*2-1:DATA_WIDTH*1]));
        $display("%0t, MAC3 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if7.douta[DATA_WIDTH*3-1:DATA_WIDTH*2]));
        $display("%0t, MAC4 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if7.douta[DATA_WIDTH*4-1:DATA_WIDTH*3]));
        $display("%0t, MAC5 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if7.douta[DATA_WIDTH*5-1:DATA_WIDTH*4]));
        $display("%0t, MAC6 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if7.douta[DATA_WIDTH*6-1:DATA_WIDTH*5]));
        $display("%0t, MAC7 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if7.douta[DATA_WIDTH*7-1:DATA_WIDTH*6]));
        $display("%0t, MAC8 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if7.douta[DATA_WIDTH*8-1:DATA_WIDTH*7]));
        $display("%0t, MAC9 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if7.douta[DATA_WIDTH*9-1:DATA_WIDTH*8]));
        $display("%0t, M1 input data is %0d",$time, $signed(M1_Bram_DEBUG_if0.douta[M1_WIDTH*8-1:M1_WIDTH*7]));
        end
        8: begin
        $display("start sample %0t: sample: %0d Kernel_BRAM8 weight", $time, sample_cnt);
        $display("Kernel BRAM: %d is displayed, address is %0d", DATA_Display_if, $signed(Kernel_Bram_DEBUG_if8.addra));
        $display("%0t, MAC1 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if8.douta[DATA_WIDTH*1-1:DATA_WIDTH*0]));
        $display("%0t, MAC2 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if8.douta[DATA_WIDTH*2-1:DATA_WIDTH*1]));
        $display("%0t, MAC3 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if8.douta[DATA_WIDTH*3-1:DATA_WIDTH*2]));
        $display("%0t, MAC4 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if8.douta[DATA_WIDTH*4-1:DATA_WIDTH*3]));
        $display("%0t, MAC5 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if8.douta[DATA_WIDTH*5-1:DATA_WIDTH*4]));
        $display("%0t, MAC6 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if8.douta[DATA_WIDTH*6-1:DATA_WIDTH*5]));
        $display("%0t, MAC7 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if8.douta[DATA_WIDTH*7-1:DATA_WIDTH*6]));
        $display("%0t, MAC8 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if8.douta[DATA_WIDTH*8-1:DATA_WIDTH*7]));
        $display("%0t, MAC9 input kernel is %0d",$time, $signed(Kernel_Bram_DEBUG_if8.douta[DATA_WIDTH*9-1:DATA_WIDTH*8]));
        $display("%0t, M1 input data is %0d",$time, $signed(M1_Bram_DEBUG_if0.douta[M1_WIDTH*9-1:M1_WIDTH*8]));
        end
        default: begin
        ;
        end
    endcase
    end
    else begin
    ;
    end
    end
endmodule
