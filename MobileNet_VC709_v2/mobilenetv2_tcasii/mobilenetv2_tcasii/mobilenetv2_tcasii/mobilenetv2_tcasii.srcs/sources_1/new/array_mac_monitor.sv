`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/23 10:39:42
// Design Name: 
// Module Name: array_mac_monitor
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
(* dont_touch = "true"*)module array_mac_monitor
#(
    parameter SAMPLE_NUM = 150565
)
(
    input clk,
    input rst,
    mac_array_debug_if.MONITOR DEBUG_IF1,
    mac_array_debug_if.MONITOR DEBUG_IF2,
    mac_array_debug_if.MONITOR DEBUG_IF3,
    adder_tree_debug_if.MONITOR adder_tree_DEBUG_IF1,
    adder_tree_debug_if.MONITOR adder_tree_DEBUG_IF2,
    adder_tree_debug_if.MONITOR adder_tree_DEBUG_IF3,
    M_s_debug_if.MONITOR M_s_DEBUG_IF1, 
    M_s_debug_if.MONITOR M_s_DEBUG_IF2, 
    M_s_debug_if.MONITOR M_s_DEBUG_IF3 
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
    
    
    always@(posedge clk) begin
    if(sample_cnt == SAMPLE_NUM) begin
        $display("start sample %0t: sample: %0d mac_array1 data", $time, sample_cnt);
        $display("%0t, MAC_data1 is %0d",$time, $signed(DEBUG_IF1.MAC_data_offset1));
        $display("%0t, MAC_data2 is %0d",$time, $signed(DEBUG_IF1.MAC_data_offset2));
        $display("%0t, MAC_data3 is %0d",$time, $signed(DEBUG_IF1.MAC_data_offset3));
        $display("%0t, MAC_data4 is %0d",$time, $signed(DEBUG_IF1.MAC_data_offset4));
        $display("%0t, MAC_data5 is %0d",$time, $signed(DEBUG_IF1.MAC_data_offset5));
        $display("%0t, MAC_data6 is %0d",$time, $signed(DEBUG_IF1.MAC_data_offset6));
        $display("%0t, MAC_data7 is %0d",$time, $signed(DEBUG_IF1.MAC_data_offset7));
        $display("%0t, MAC_data8 is %0d",$time, $signed(DEBUG_IF1.MAC_data_offset8));
        $display("%0t, MAC_data9 is %0d",$time, $signed(DEBUG_IF1.MAC_data_offset9));
        
        $display("%0t, MAC_weight_in1 is %0d",$time, $signed(DEBUG_IF1.MAC_weight_in1));
        $display("%0t, MAC_weight_in2 is %0d",$time, $signed(DEBUG_IF1.MAC_weight_in2));
        $display("%0t, MAC_weight_in3 is %0d",$time, $signed(DEBUG_IF1.MAC_weight_in3));
        $display("%0t, MAC_weight_in4 is %0d",$time, $signed(DEBUG_IF1.MAC_weight_in4));
        $display("%0t, MAC_weight_in5 is %0d",$time, $signed(DEBUG_IF1.MAC_weight_in5));
        $display("%0t, MAC_weight_in6 is %0d",$time, $signed(DEBUG_IF1.MAC_weight_in6));
        $display("%0t, MAC_weight_in7 is %0d",$time, $signed(DEBUG_IF1.MAC_weight_in7));
        $display("%0t, MAC_weight_in8 is %0d",$time, $signed(DEBUG_IF1.MAC_weight_in8));
        $display("%0t, MAC_weight_in9 is %0d",$time, $signed(DEBUG_IF1.MAC_weight_in9));
        
        $display("%0t, psum1 is %0d",$time, $signed(DEBUG_IF1.a1));
        $display("%0t, psum2 is %0d",$time, $signed(DEBUG_IF1.a2));
        $display("%0t, psum3 is %0d",$time, $signed(DEBUG_IF1.a3));
        $display("%0t, psum4 is %0d",$time, $signed(DEBUG_IF1.a4));
        $display("%0t, psum5 is %0d",$time, $signed(DEBUG_IF1.a5));
        $display("%0t, psum6 is %0d",$time, $signed(DEBUG_IF1.a6));
        $display("%0t, psum7 is %0d",$time, $signed(DEBUG_IF1.a7));
        $display("%0t, psum8 is %0d",$time, $signed(DEBUG_IF1.a8));
        $display("%0t, psum9 is %0d",$time, $signed(DEBUG_IF1.a9));
        
        $display("start sample %0t: sample: %0d mac_array2 data", $time, sample_cnt);
        $display("%0t, MAC_data1 is %0d",$time, $signed(DEBUG_IF2.MAC_data_offset1));
        $display("%0t, MAC_data2 is %0d",$time, $signed(DEBUG_IF2.MAC_data_offset2));
        $display("%0t, MAC_data3 is %0d",$time, $signed(DEBUG_IF2.MAC_data_offset3));
        $display("%0t, MAC_data4 is %0d",$time, $signed(DEBUG_IF2.MAC_data_offset4));
        $display("%0t, MAC_data5 is %0d",$time, $signed(DEBUG_IF2.MAC_data_offset5));
        $display("%0t, MAC_data6 is %0d",$time, $signed(DEBUG_IF2.MAC_data_offset6));
        $display("%0t, MAC_data7 is %0d",$time, $signed(DEBUG_IF2.MAC_data_offset7));
        $display("%0t, MAC_data8 is %0d",$time, $signed(DEBUG_IF2.MAC_data_offset8));
        $display("%0t, MAC_data9 is %0d",$time, $signed(DEBUG_IF2.MAC_data_offset9));
        
        $display("%0t, MAC_weight_in1 is %0d",$time, $signed(DEBUG_IF2.MAC_weight_in1));
        $display("%0t, MAC_weight_in2 is %0d",$time, $signed(DEBUG_IF2.MAC_weight_in2));
        $display("%0t, MAC_weight_in3 is %0d",$time, $signed(DEBUG_IF2.MAC_weight_in3));
        $display("%0t, MAC_weight_in4 is %0d",$time, $signed(DEBUG_IF2.MAC_weight_in4));
        $display("%0t, MAC_weight_in5 is %0d",$time, $signed(DEBUG_IF2.MAC_weight_in5));
        $display("%0t, MAC_weight_in6 is %0d",$time, $signed(DEBUG_IF2.MAC_weight_in6));
        $display("%0t, MAC_weight_in7 is %0d",$time, $signed(DEBUG_IF2.MAC_weight_in7));
        $display("%0t, MAC_weight_in8 is %0d",$time, $signed(DEBUG_IF2.MAC_weight_in8));
        $display("%0t, MAC_weight_in9 is %0d",$time, $signed(DEBUG_IF2.MAC_weight_in9));
        
        $display("%0t, psum1 is %0d",$time, $signed(DEBUG_IF2.a1));
        $display("%0t, psum2 is %0d",$time, $signed(DEBUG_IF2.a2));
        $display("%0t, psum3 is %0d",$time, $signed(DEBUG_IF2.a3));
        $display("%0t, psum4 is %0d",$time, $signed(DEBUG_IF2.a4));
        $display("%0t, psum5 is %0d",$time, $signed(DEBUG_IF2.a5));
        $display("%0t, psum6 is %0d",$time, $signed(DEBUG_IF2.a6));
        $display("%0t, psum7 is %0d",$time, $signed(DEBUG_IF2.a7));
        $display("%0t, psum8 is %0d",$time, $signed(DEBUG_IF2.a8));
        $display("%0t, psum9 is %0d",$time, $signed(DEBUG_IF2.a9));
    
        $display("start sample %0t: sample: %0d mac_array3 data", $time, sample_cnt);
        $display("%0t, MAC_data1 is %0d",$time, $signed(DEBUG_IF3.MAC_data_offset1));
        $display("%0t, MAC_data2 is %0d",$time, $signed(DEBUG_IF3.MAC_data_offset2));
        $display("%0t, MAC_data3 is %0d",$time, $signed(DEBUG_IF3.MAC_data_offset3));
        $display("%0t, MAC_data4 is %0d",$time, $signed(DEBUG_IF3.MAC_data_offset4));
        $display("%0t, MAC_data5 is %0d",$time, $signed(DEBUG_IF3.MAC_data_offset5));
        $display("%0t, MAC_data6 is %0d",$time, $signed(DEBUG_IF3.MAC_data_offset6));
        $display("%0t, MAC_data7 is %0d",$time, $signed(DEBUG_IF3.MAC_data_offset7));
        $display("%0t, MAC_data8 is %0d",$time, $signed(DEBUG_IF3.MAC_data_offset8));
        $display("%0t, MAC_data9 is %0d",$time, $signed(DEBUG_IF3.MAC_data_offset9));
        
        $display("%0t, MAC_weight_in1 is %0d",$time, $signed(DEBUG_IF3.MAC_weight_in1));
        $display("%0t, MAC_weight_in2 is %0d",$time, $signed(DEBUG_IF3.MAC_weight_in2));
        $display("%0t, MAC_weight_in3 is %0d",$time, $signed(DEBUG_IF3.MAC_weight_in3));
        $display("%0t, MAC_weight_in4 is %0d",$time, $signed(DEBUG_IF3.MAC_weight_in4));
        $display("%0t, MAC_weight_in5 is %0d",$time, $signed(DEBUG_IF3.MAC_weight_in5));
        $display("%0t, MAC_weight_in6 is %0d",$time, $signed(DEBUG_IF3.MAC_weight_in6));
        $display("%0t, MAC_weight_in7 is %0d",$time, $signed(DEBUG_IF3.MAC_weight_in7));
        $display("%0t, MAC_weight_in8 is %0d",$time, $signed(DEBUG_IF3.MAC_weight_in8));
        $display("%0t, MAC_weight_in9 is %0d",$time, $signed(DEBUG_IF3.MAC_weight_in9));
        
        $display("%0t, psum1 is %0d",$time, $signed(DEBUG_IF3.a1));
        $display("%0t, psum2 is %0d",$time, $signed(DEBUG_IF3.a2));
        $display("%0t, psum3 is %0d",$time, $signed(DEBUG_IF3.a3));
        $display("%0t, psum4 is %0d",$time, $signed(DEBUG_IF3.a4));
        $display("%0t, psum5 is %0d",$time, $signed(DEBUG_IF3.a5));
        $display("%0t, psum6 is %0d",$time, $signed(DEBUG_IF3.a6));
        $display("%0t, psum7 is %0d",$time, $signed(DEBUG_IF3.a7));
        $display("%0t, psum8 is %0d",$time, $signed(DEBUG_IF3.a8));
        $display("%0t, psum9 is %0d",$time, $signed(DEBUG_IF3.a9));

        end
        else begin
        ;
        end
    end
    
    always@(posedge clk) begin
        if(sample_cnt == SAMPLE_NUM+1) begin
        $display("start sample %0t mac_array1 adder_tree data", $time);
        $display("%0t, b1 is %0d",$time, $signed(adder_tree_DEBUG_IF1.b1));
        $display("%0t, b2 is %0d",$time, $signed(adder_tree_DEBUG_IF1.b2));
        $display("%0t, b3 is %0d",$time, $signed(adder_tree_DEBUG_IF1.b3));
        $display("%0t, b4 is %0d",$time, $signed(adder_tree_DEBUG_IF1.b4));
        
        $display("start sample %0t mac_array2 adder_tree data", $time);
        $display("%0t, b1 is %0d",$time, $signed(adder_tree_DEBUG_IF2.b1));
        $display("%0t, b2 is %0d",$time, $signed(adder_tree_DEBUG_IF2.b2));
        $display("%0t, b3 is %0d",$time, $signed(adder_tree_DEBUG_IF2.b3));
        $display("%0t, b4 is %0d",$time, $signed(adder_tree_DEBUG_IF2.b4));
        
        $display("start sample %0t mac_array3 adder_tree data", $time);
        $display("%0t, b1 is %0d",$time, $signed(adder_tree_DEBUG_IF3.b1));
        $display("%0t, b2 is %0d",$time, $signed(adder_tree_DEBUG_IF3.b2));
        $display("%0t, b3 is %0d",$time, $signed(adder_tree_DEBUG_IF3.b3));
        $display("%0t, b4 is %0d",$time, $signed(adder_tree_DEBUG_IF3.b4));
        end
        else begin
        ;
        end
    end
    
    always@(posedge clk) begin
    if(sample_cnt == SAMPLE_NUM+2) begin
    $display("start sample %0t mac_array1 adder_tree data", $time);
    $display("%0t, c1 is %0d",$time, $signed(adder_tree_DEBUG_IF1.c1));
    $display("%0t, c2 is %0d",$time, $signed(adder_tree_DEBUG_IF1.c2));
    $display("start sample %0t mac_array2 adder_tree data", $time);
    $display("%0t, c1 is %0d",$time, $signed(adder_tree_DEBUG_IF2.c1));
    $display("%0t, c2 is %0d",$time, $signed(adder_tree_DEBUG_IF2.c2));
    $display("start sample %0t mac_array3 adder_tree data", $time);
    $display("%0t, c1 is %0d",$time, $signed(adder_tree_DEBUG_IF3.c1));
    $display("%0t, c2 is %0d",$time, $signed(adder_tree_DEBUG_IF3.c2));
    end
    else begin
    ;
    end
    end
    
    always@(posedge clk) begin
    if(sample_cnt == SAMPLE_NUM+3) begin
    $display("%0t, array_mac1 d1 is %0d",$time, $signed(adder_tree_DEBUG_IF1.d1));  
    $display("%0t, array_mac2 d1 is %0d",$time, $signed(adder_tree_DEBUG_IF2.d1));
    $display("%0t, array_mac3 d1 is %0d",$time, $signed(adder_tree_DEBUG_IF3.d1));
    end
    else begin
    ;
    end
    end
    
    always@(posedge clk) begin
    if(sample_cnt == SAMPLE_NUM+4) begin
    $display("%0t, m0 is %0d",$time, $signed(M_s_DEBUG_IF1.m0));  
    $display("%0t, array_mac1 m1 is %0d",$time, $signed(M_s_DEBUG_IF1.m1));  
    $display("%0t, array_mac2 m1 is %0d",$time, $signed(M_s_DEBUG_IF2.m1));
    $display("%0t, array_mac3 m1 is %0d",$time, $signed(M_s_DEBUG_IF3.m1));
    $display("%0t, array_mac1 mac_array_out is %0d",$time, $signed(M_s_DEBUG_IF1.mac_array_out));  
    $display("%0t, array_mac2 mac_array_out is %0d",$time, $signed(M_s_DEBUG_IF2.mac_array_out));
    $display("%0t, array_mac3 mac_array_out is %0d",$time, $signed(M_s_DEBUG_IF3.mac_array_out));
    end
    else begin
    ;
    end
    end
    
    always@(posedge clk) begin
    if(sample_cnt == SAMPLE_NUM+5) begin
        $display("%0t, array_mac1 merge_out is %0d",$time, $signed(M_s_DEBUG_IF1.merge_out));  
        $display("%0t, array_mac2 merge_out is %0d",$time, $signed(M_s_DEBUG_IF2.merge_out));
        $display("%0t, array_mac3 merge_out is %0d",$time, $signed(M_s_DEBUG_IF3.merge_out));
    end
    else begin
    ;
    end
    end
    
endmodule
