`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/30 10:17:05
// Design Name: 
// Module Name: Control_Unit
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


module Control_Unit(
    input clk,
    input rst,
    input ena,
    input restart_inference,
    
    // inter_module handshake signal
    input DW_complete,
    input PW_complete,
    input AVGPOOL_complete,
    output busy,
    
    // module configuration
    output [31:0] module_config,
    output module_config_valid,
    output [5:0] module_config_addr
    );
    
    
reg [4:0] IRB_cnt;
wire IRB_complete;
/////////////////------------------------------------------------/////////////////////
////////////////////               [3]. FSM                   ////////////////////////
/////////////////------------------------------------------------////////////////////
localparam IDLE    = 0;  
localparam CONV    = 1;
localparam LAYERS  = 2;
localparam AVGPOOL = 3;
localparam FC = 4;

reg [2:0]bram_st;
reg [2:0]bram_next_st;

always @(posedge clk or negedge rst)
begin
    if (!rst)
    begin
        bram_st <= IDLE; 
    end 
    else if (ena)
    begin 
        bram_st <= bram_next_st;
    end 
    else 
    begin
        bram_st <= IDLE; 
    end  
end 
    

    
always @(*)
    begin
    case (bram_st)
        IDLE:
        begin 
            if (ena&&restart_inference) bram_next_st <= CONV;
            else bram_next_st <= IDLE;
        end 
        
        CONV:
        begin
            if (DW_complete)
            begin 
                bram_next_st <= LAYERS;
            end 
            else 
            begin
                bram_next_st <= CONV;
            end 
        end 
        
        LAYERS:
        begin
            if (IRB_complete && (IRB_cnt == 17))
            begin
                bram_next_st <= AVGPOOL;
            end 
            else begin
                bram_next_st <= LAYERS;
            end 
        end 
        
        AVGPOOL:
        begin
            if (AVGPOOL_complete)   begin        //ifmap + 2*PADDING -2
                bram_next_st <= FC; 
            end 
            else begin
                bram_next_st <= AVGPOOL; 
            end 
        end
        
        FC:
        begin
            if (PW_complete)
            begin
                bram_next_st <= IDLE; 
            end 
            else 
            begin
                bram_next_st <=  FC;
            end 
        end 
        default:
        begin
        bram_next_st <= IDLE; 
        end 
    endcase
end 

/////////////////------------------------------------------------/////////////////////
////////////////////               [4]. IRB_FSM                   ////////////////////////
/////////////////------------------------------------------------////////////////////
localparam IRB_IDLE    = 0;  
localparam PW1    = 1;
localparam DLM  = 2;


reg [2:0]IRB_bram_st;
reg [2:0]IRB_bram_next_st;

always @(posedge clk or negedge rst)
begin
    if (!rst)
    begin
        IRB_bram_st <= IRB_IDLE; 
    end 
    else if (bram_st==LAYERS)
    begin 
        IRB_bram_st <= IRB_bram_next_st;
    end 
    else 
    begin
        IRB_bram_st <= IRB_IDLE; 
    end  
end 
    

always @(*)
    begin
    case (bram_st)
        IRB_IDLE:
        begin 
            if (bram_st==LAYERS) bram_next_st <= PW1;
            else bram_next_st <= IRB_IDLE;
        end 
        
        PW1:
        begin
            if (DW_complete)
            begin 
                bram_next_st <= DLM;
            end 
            else 
            begin
                bram_next_st <= PW1;
            end 
        end 
        
        DLM:
        begin
            if (PW_complete)
            begin
                bram_next_st <= AVGPOOL;
            end 
            else begin
                bram_next_st <= LAYERS;
            end 
        end 
        
        default:
        begin
        bram_next_st <= IDLE; 
        end 
    endcase
end 

//Counter IRB_cnt

always@(posedge clk) begin
    if(!rst)  IRB_cnt<=0;
    else if(bram_st==LAYERS) 
        if(IRB_complete && (IRB_cnt == 17)) IRB_cnt<=0;
        else if(IRB_complete) IRB_cnt<=IRB_cnt+1;
        else IRB_cnt<=IRB_cnt;
    else  IRB_cnt <= 0;
end

endmodule
