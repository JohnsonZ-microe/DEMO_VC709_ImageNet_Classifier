`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/09 18:56:23
// Design Name: 
// Module Name: hv_counter
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


module hv_counter(

    );
    
    
//-- 1. Ifmap_hori_base_cnt(IHB)  --//
// Specify the central corner point at a 3*3 convolution in ifmap/ofmap
 
always @(posedge clk)
    begin
        if(!rst) begin
            Ifmap_hori_base_cnt <= 0;
        end
        else if (bram_st == BRAM_RD_IDLE)
        begin
             Ifmap_hori_base_cnt <= Ifmap_hori_base_cnt;
        end 
        else if(bram_st == BRAM_FIRST_WR || bram_st == BRAM_WR || bram_st == BRAM_LAST_WR)
        begin
            if (conv_point_calculation_finishing) begin
                if (Ifmap_hori_base_cnt == ofmap_size-1)
                    Ifmap_hori_base_cnt <= 0;
                else 
                begin
                     Ifmap_hori_base_cnt <= Ifmap_hori_base_cnt + 1;
                end 
            end
            else 
            begin 
                Ifmap_hori_base_cnt <= Ifmap_hori_base_cnt;
            end 
        end 
        else begin
            Ifmap_hori_base_cnt <= 0;
        end
    end 

// -- 2. Ifmap_vert_base_cnt(IVB):  --//
// specify the raw number of start corner point in ifmap
always @(posedge clk) begin
    if(!rst) begin
        Ifmap_vert_base_cnt <= 0;
    end
    else if (bram_st == BRAM_RD_IDLE) begin
         Ifmap_vert_base_cnt <= Ifmap_vert_base_cnt;
    end 
    else if(bram_st == BRAM_FIRST_WR || bram_st == BRAM_WR || bram_st == BRAM_LAST_WR )begin
        if (Ifmap_vert_base_cnt == ofmap_size-1 && row_end) Ifmap_vert_base_cnt <= 0;
        else if (row_end)  Ifmap_vert_base_cnt <= Ifmap_vert_base_cnt + 1;
        else Ifmap_vert_base_cnt <= Ifmap_vert_base_cnt;
    end 
    else Ifmap_vert_base_cnt<=0;
end 

endmodule
