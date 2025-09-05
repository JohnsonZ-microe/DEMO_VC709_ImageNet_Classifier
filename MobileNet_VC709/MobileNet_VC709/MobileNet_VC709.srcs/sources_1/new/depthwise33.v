`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/16 00:00:11
// Design Name: 
// Module Name: depthwise33
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

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Catalogue:

// -- [1].Signal Declaration
//      ------ User Config Register Signal Declaration
//      ------ User Config Register Declaration
//      ------ Data Flow Control Signal Declaration
//      ------ Counter Register Declaration
//      ------ Subaddress Declaration
//      ------ Address Shift Declaration
// -- [2].User Defined Register
// -- [3].FSM
// -- [4]. Counters Definition
//      ------ 1. Ifmap_hori_base_cnt(IHB)
//      ------ 2. Ifmap_vert_base_cnt(IVB)
//      ------ 3. Conv33_local_hori_cnt(CHLOC)
//      ------ 4. Conv33_local_vert_cnt(CVLOC)
//      ------ 5. Channel_cnt (CC)
//      ------ 6. Conv_round_cnt (CR)
// -- [5].Data Flow Control Signal Define
//      ------ 1. ofmap_size
//      ------ 2. row_end 
//      ------ 3. conv_point_calculation_finishing   (CPCF)
//      ------ 4. conv_channel_calculation_finishing   (CCCF)
//      ------ 5. complete 
//      ------ 6. intr_in_pulse (spare)
//      ------ 7. window_loaded 
// -- [6].DATA Bram ifmap ROW Input Order
//      ------ case(1) state is BRAM_WR ---- scenario(1) stride is 1    |||padding the last colume|||
//      ------ case(1) state is BRAM_WR ---- scenario(1) stride is 1    |||padding the first colume|||  
//      ------ case(1) state is BRAM_WR ---- scenario(2) stride is 2    |||padding the first colume|||
//      ------ case(1) state is BRAM_WR ---- scenario(2) stride is 2    |||padding the last colume|||  
//      ------ case(2) state is BRAM_FIRST_WR   |||padding the last colume||| 
//      ------ case(2) state is BRAM_FIRST_WR   |||padding the first colume|||
//      ------ case(3) state is BRAM_LAST_WR   ---- scenario(1) stride is 1    |||padding the last colume|||  
//      ------ case(3) state is BRAM_LAST_WR   ---- scenario(1) stride is 1    |||padding the first colume||| 
//      ------ case(3) state is BRAM_LAST_WR   ---- scenario(2) stride is 2    |||padding the first colume||| 
//      ------ case(3) state is BRAM_LAST_WR   ---- scenario(2) stride is 2    |||padding the last colume||| 
// -- [7].Kernel Bram RAW Input Order
//      ------ (k) case(1) state is BRAM_WR   ---- scenario(1) stride is 1 
//      ------ (k) case(1) state is BRAM_WR   ---- scenario(2) stride is 2 
//      ------ (k) case(2) state is BRAM_FIRST_WR  
//      ------ (k) case(3) state is BRAM_LAST_WR  ---- scenario(1) stride is 1
//      ------ (k) case(3) state is BRAM_LAST_WR  ---- scenario(2) stride is 2 
// -- [8].DATA Bram ofmap ROW Output Order
// -- [9].DATA Bram read address generation
//      ------ 1. bram_base_raw_addr subaddress generation
//      ------ 2. bram_point_addr subaddress generation
//      ------ 3. bram_point_channel_addr subaddress generation
//      ------ 4. bram_conv_channel_round_addr subaddress generation
//      ------ 5. bram_ifmap_addr final address generation
// -- [10].DATA Bram write address generation
//      ------ 1. bram_base_raw_addr subaddress generation
//      ------ 2. bram_point_addr subaddress generation
//      ------ 3. bram_point_channel_addr subaddress generation
//      ------ 4. bram_conv_channel_round_addr subaddress generation
//      ------ 5. bram_ifmap_addr final address generation
// --[11].Kernel Bram read address generation
//      ------ 1. kernel_channel_base_addr subaddress generation 
//      ------ 2. kernel_local_point_addr subaddress generation
//      ------ 3. kernel_addr final address generation
// --[12].Window Calculator Implementation


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module depthwise33
#(
parameter DATA_WIDTH = 8,                    
parameter FILTER_SIZE = 3,
parameter PADDING = 1,
parameter DATA_BRAM_ADDR_WIDTH = 19,                 //the address line width of DATA BRAM
parameter KERNEL_BRAM_ADDR_WIDTH = 12,               //the address line width of Kernel BRAM
parameter BIAS_BRAM_ADDR_WIDTH = 15
)
(

/////////////////------------------------------------------------/////////////////////
/////////////////////////////  [1]. Signal Declaration //////////////////////////////
/////////////////------------------------------------------------////////////////////

input clk,
input rst,
/** User Config Register Signal Declaration **/
input [31:0] reg_config_data_in,   // user config register data input  
input [3:0] reg_config_addr,       // user config register mapped address                
input reg_config_valid,            // user config register data valid, when asserted, reg_config_data_in was written in corresponding register

/** M0 input **/
input signed [31:0] M0_input,
input signed [7:0] input_zero_point,
/** DATA_BRAM read signals **/
input  [DATA_WIDTH - 1: 0]bram_ifmap_in_1,bram_ifmap_in_2,bram_ifmap_in_3,  //DATA BRAM ifmap data input (read data)
output bram_ifmap_in_ena,                                                  //DATA BRAM enable signal
output [DATA_BRAM_ADDR_WIDTH-1:0]bram_ifmap_addr_1,bram_ifmap_addr_2,bram_ifmap_addr_3,     //DATA BRAM ifmap read address
output ifmap_group_sel,

/** DATA_BRAM write signals **/
output reg [31: 0]bram_ofmap_out_1,bram_ofmap_out_2,bram_ofmap_out_3,         //DATA BRAM ofmap data ouput (write data)                             
output reg bram_wr_ena_reg_1,bram_wr_ena_reg_2,bram_wr_ena_reg_3,              //DATA BRAM write enable signal
output [DATA_BRAM_ADDR_WIDTH-1:0]bram_ofmap_addr_1,bram_ofmap_addr_2,bram_ofmap_addr_3,    //DATA BRAM ofmap wirte address

/** Kernel_BRAM signals **/
//(Kernel BRAM enable signals are the reuse of the DATA BRAM enable signal)
input  [DATA_WIDTH - 1:0] bram_weight_in_1,bram_weight_in_2,bram_weight_in_3,              //Kernel BRAM weight input
output [KERNEL_BRAM_ADDR_WIDTH-1:0] kernel_addr,                                           //Kernel BRAM weight ready address

/** Bias_BRAM signals **/
input [31:0] bias_in,
output [14:0] bias_addr,

/** interupt and busy signals (spare) **/
//output intr_out,
//output bram_rd_busy_out,
input bram_rd_busy_in,   //bram rd busy signal input 
input intr_in,           //interupt signal input

output reg complete   //(used for simulation)
);


/** User Config Register Declaration **/
//--  1. Depthwise config register  --//
//--  coding scheme:
//--  [7:0] Ifmap_size  [17:8] Ifmap_channel  [28:18] Ofmap_channel  [29]:stride [30]: enable [31]: conv
reg [31:0] DW_config;
     
wire [7:0] ifmap_size;
assign ifmap_size = DW_config[7:0];
wire [9:0] ifmap_channel;
assign ifmap_channel = DW_config[17:8];
wire [10:0] ofmap_channel;
assign ofmap_channel = DW_config[28:18] ;
wire stride;
assign stride = DW_config[29];
wire ena;
assign ena = DW_config[30];
wire conv;
assign conv = DW_config[31];

//--  2. Input data and weight base address register --//
//--  coding scheme:
//--  [18:0] ifmap_base_addr  [30:19] Weight_base_addr  [31] ifmap_group_sel
reg [31:0] Input_base_addr;

wire [18:0] ifmap_base_addr;
assign ifmap_base_addr = Input_base_addr[18:0];

wire [11:0] Weight_base_addr;
assign Weight_base_addr = Input_base_addr[30:19];

assign ifmap_group_sel = Input_base_addr[31];

//--  3. output data and bias base address register --//
//--  coding scheme:
//--  [18:0] Ofmap_base_addr  [30:19] Bias_base_addr
reg [31:0] Output_base_addr;

wire [18:0] Ofmap_base_addr;
assign Ofmap_base_addr = Output_base_addr[18:0];

wire [11:0] Bias_base_addr;
assign Bias_base_addr = Output_base_addr[30:19];
// DATA BRAM enable signal define //
assign bram_ifmap_in_ena = ena;


/** Data Flow Control Signal Declaration **/
/////////////////////////////////////////

//--  1. ofmap size  --//
wire [7:0] ofmap_size;
//--  2.row end  --//
reg row_end;
// 3. CPCF : conv_point_calculation_finished
reg conv_point_calculation_finishing;
// 4. CCCF : conv_channel_calculation_finished
wire conv_res_valid;              //convolution result valid signal produced by adder tree
reg conv_channel_calculation_finishing;
// 5. Complete
//reg complete;
// 6. intr_in_pulse(spare)
wire intr_in_pulse;
// 7. window_loaded
wire window_loaded;

reg [31:0] conv_acc;
reg conv_acc_valid;

/** Counter Register Declaration **/
////////////////////////////////////
reg [7:0] Ifmap_hori_base_cnt;
reg [7:0] Ifmap_vert_base_cnt; 
reg [2:0] Conv33_local_hori_cnt;
reg [2:0] Conv33_local_vert_cnt;  

reg [10:0] Channel_cnt;
reg [4:0] Conv_round_cnt;
wire [1:0] filter_cnt;

/** Subaddress Declaration **/
/////////////////////////////
reg [DATA_BRAM_ADDR_WIDTH-1:0] bram_base_raw_addr_1,bram_base_raw_addr_2, bram_base_raw_addr_3;
wire [DATA_BRAM_ADDR_WIDTH-1:0] bram_conv_channel_round_addr;
wire [DATA_BRAM_ADDR_WIDTH-1:0] bram_point_channel_addr;
reg [DATA_BRAM_ADDR_WIDTH-1:0] bram_point_addr;

reg [KERNEL_BRAM_ADDR_WIDTH-1:0] kernel_channel_base_addr;
wire [KERNEL_BRAM_ADDR_WIDTH-1:0] kernel_local_point_addr;

reg [BIAS_BRAM_ADDR_WIDTH-1:0] bias_channel_base_addr;
/** Address Shift Declaration **/
/////////////////////////////
wire [DATA_BRAM_ADDR_WIDTH-1:0] address_point_shift;
assign address_point_shift = ifmap_channel;
wire [DATA_BRAM_ADDR_WIDTH-1:0] address_raw_shift;
assign address_raw_shift = address_point_shift*ifmap_size;

//conv33_window_calculator output result
wire [31:0] conv_data_out;

wire [31:0] conv_res;
wire [7:0] Relu_out;

/////////////////------------------------------------------------/////////////////////
/////////////////////////////  [2]. User Defined Register ////////////////////////////
/////////////////------------------------------------------------////////////////////
always@(posedge clk) begin
    if((!rst)||complete) begin
        DW_config <= 0;
        Input_base_addr <= 0;
        Output_base_addr <= 0;
    end
    else if(reg_config_valid) begin
        case(reg_config_addr)
            4'd0: DW_config <= reg_config_data_in; 
            4'd1: Input_base_addr <= reg_config_data_in;
            4'd2: Output_base_addr <= reg_config_data_in;
            default:  
            begin
                DW_config <= DW_config;
                Input_base_addr <= Input_base_addr;
                Output_base_addr <= Output_base_addr;
            end
        endcase
    end
    else begin
        DW_config <= DW_config;
        Input_base_addr <= Input_base_addr;
        Output_base_addr <= Output_base_addr;
    end
end

/////////////////------------------------------------------------/////////////////////
////////////////////               [3]. FSM                   ////////////////////////
/////////////////------------------------------------------------////////////////////
localparam BRAM_IDLE        = 0;  
localparam BRAM_FIRST_WR    = 1;
localparam BRAM_LAST_WR     = 2;
localparam BRAM_WR          = 3;
localparam BRAM_ITR         = 4;
localparam BRAM_RD_IDLE     = 5;

reg [2:0]bram_st;
reg [2:0]bram_next_st;
reg [2:0]bram_tmp_st;

always @(posedge clk or negedge rst)
begin
    if ((!rst)||complete)
    begin
        bram_st <= BRAM_IDLE; 
    end 
    else if (ena)
    begin 
        bram_st <= bram_next_st;
    end 
    else 
    begin
        bram_st <= BRAM_IDLE; 
    end  
end 
    
always @(posedge clk)
begin
    if (bram_st != BRAM_ITR)
    begin 
        if (intr_in_pulse || bram_rd_busy_in)
        begin
            bram_tmp_st <= bram_st; 
        end 
        else 
        begin
            bram_tmp_st <= bram_tmp_st; 
        end 
    end 
    else 
    begin
        bram_tmp_st <= bram_tmp_st;
    end 
end 
    
always @(*)
    begin
    case (bram_st)
        BRAM_IDLE:
        begin 
            if (ena && (Ifmap_vert_base_cnt == 0)) bram_next_st <= BRAM_FIRST_WR;
            else bram_next_st <= BRAM_IDLE;
        end 
        
        BRAM_FIRST_WR:
        begin
            if (row_end)
            begin 
                bram_next_st <= BRAM_WR;
            end 
            else 
            begin
                bram_next_st <= BRAM_FIRST_WR;
            end 
        end 
        
        BRAM_LAST_WR:
        begin
            if (intr_in)
            begin
                bram_next_st <= BRAM_ITR; 
            end 
            else if (row_end)
            begin
                bram_next_st <= BRAM_IDLE;
            end 
            else begin
                bram_next_st <= BRAM_LAST_WR;
            end 
        end 
        
        BRAM_WR:
        begin
            if (bram_rd_busy_in)  begin
                bram_next_st <= BRAM_RD_IDLE; 
            end 
            else if (row_end && (Ifmap_vert_base_cnt == ofmap_size-2))   begin        //ifmap + 2*PADDING -2
                bram_next_st <= BRAM_LAST_WR; 
            end 
            else begin
                bram_next_st <= BRAM_WR; 
            end 
        end
        
        BRAM_ITR:
        begin
            if (!intr_in)
            begin
                bram_next_st <= bram_tmp_st; 
            end 
            else 
            begin
                bram_next_st <=  BRAM_ITR;
            end 
        end 
        BRAM_RD_IDLE:
        begin
            if (bram_rd_busy_in)
            begin
                bram_next_st <=  BRAM_RD_IDLE;
            end  
            else 
            begin
               bram_next_st <= BRAM_WR;
            end 
        end
        default:
        begin
        bram_next_st <= BRAM_IDLE; 
        end 
    endcase
end 



/////////////////------------------------------------------------/////////////////////
////////////////////        [4]. Counters Definition             ////////////////////////
/////////////////------------------------------------------------////////////////////

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


// 3. Conv33_local_hori_cnt(CHLOC) : specified the location of continuous 3 horizental pixel in a 3*3 convolution
always @(posedge clk) begin
    if(!rst) begin
        Conv33_local_hori_cnt <= 0;
    end
    else if (bram_st == BRAM_RD_IDLE) begin
        Conv33_local_hori_cnt <= Conv33_local_hori_cnt;
    end 
    else if(bram_st == BRAM_FIRST_WR || bram_st == BRAM_WR || bram_st == BRAM_LAST_WR)
    begin
        if (Conv33_local_hori_cnt == 2 && (conv_channel_calculation_finishing))
            Conv33_local_hori_cnt  <= 0;
        else if (Conv33_local_hori_cnt == 2) Conv33_local_hori_cnt <= Conv33_local_hori_cnt;
        else  Conv33_local_hori_cnt <= Conv33_local_hori_cnt + 1;
    end  
    else begin
        Conv33_local_hori_cnt <= 0;
    end
end 



// 4. Conv33_local_vert_cnt(CVLOC) : specify the location of continuous 3 vertical raws in a 3*3 convolution for the purpose of generating different BRAM output order
always @(posedge clk) begin
    if(!rst) begin
        Conv33_local_vert_cnt <= 0;
    end
    else if (bram_st == BRAM_ITR ) begin
         Conv33_local_vert_cnt <= Conv33_local_vert_cnt;
    end
    else if(bram_st == BRAM_FIRST_WR || bram_st == BRAM_WR || bram_st == BRAM_LAST_WR)
    begin 
        if (row_end && (Conv33_local_vert_cnt == 2))
        begin
             Conv33_local_vert_cnt <= 0;
        end 
        else if (row_end)
        begin
            Conv33_local_vert_cnt <= Conv33_local_vert_cnt + 1;
        end 
        else 
        begin
            Conv33_local_vert_cnt <= Conv33_local_vert_cnt; 
        end 
     end
     else begin
        Conv33_local_vert_cnt <= 0;
     end
end

// 5. Channel_cnt (CC)
// specifies the current calculating channel of a point
always @(posedge clk)
    begin
        if(!rst) begin
            Channel_cnt <= 0;
        end
        else if (bram_st == BRAM_RD_IDLE)
        begin
             Channel_cnt <= Channel_cnt;
        end 
        else if(bram_st == BRAM_FIRST_WR || bram_st == BRAM_WR || bram_st == BRAM_LAST_WR) begin
            if ((Channel_cnt == ifmap_channel - 1) && conv_channel_calculation_finishing)
            begin
                Channel_cnt <= 0;
            end  
            else if (conv_channel_calculation_finishing)
            begin
                Channel_cnt <= Channel_cnt + 1; 
            end 
            else 
            begin
                Channel_cnt <= Channel_cnt; 
            end 
        end  
        else Channel_cnt <=0;
    end 
    
    
// 6. Conv_round_cnt (CR)
always @(posedge clk)
    begin
        if(!rst) begin
            Conv_round_cnt <= 0;
        end
        else if (bram_st == BRAM_RD_IDLE)
        begin
            Conv_round_cnt <= Conv_round_cnt;
        end 
        else if(conv)
            if(conv_channel_calculation_finishing)
                if((Conv_round_cnt == 32 - 1) && (Channel_cnt == ifmap_channel - 1))
                    Conv_round_cnt <= 0;
                else if((Channel_cnt == ifmap_channel - 1))
                    Conv_round_cnt <= Conv_round_cnt +1;
                else
                    Conv_round_cnt <= Conv_round_cnt;
            else    
                Conv_round_cnt <= Conv_round_cnt;
        else
            Conv_round_cnt <= 0;
    end
    
/////////////////------------------------------------------------/////////////////////
/////////////        [5]. Data Flow Control Signal Define             ///////////////////
/////////////////------------------------------------------------////////////////////

// 1. ofmap_size
// when stride==1(stride is 2), size of ofmap is that of ifmap devide by 2
assign ofmap_size = (stride==0)? ifmap_size:ifmap_size>>1;

// 2. row_end  
// indicate a raw of ofmap gained successfully.
always@(*) begin
    if((Ifmap_hori_base_cnt == ofmap_size - 1) && conv_point_calculation_finishing)  begin
        row_end <= 1'b1;
    end
    else begin 
        row_end <= 1'b0;
    end
end

// 3. conv_point_calculation_finishing   (CPCF)
// indicates that all channels of one point in ofmap has been derived
always@(posedge clk) begin
    if(conv)
        if((Conv_round_cnt == 32 - 1) &&(Channel_cnt == ifmap_channel - 1) && conv_res_valid)
            conv_point_calculation_finishing <= 1'b1;
        else 
            conv_point_calculation_finishing <= 1'b0;
    else 
        if((Channel_cnt == ifmap_channel - 1) && conv_res_valid) 
            conv_point_calculation_finishing <= 1'b1;
        else 
            conv_point_calculation_finishing <= 1'b0;
end
// 4. conv_channel_calculation_finishing   (CCCF)
// conv_res_valid delay for n clk used for further calculation and BRAM writing
// indicates that one channel of one point in ofmap has been derived and finally written into the BRAM
always@(posedge clk) begin
    conv_channel_calculation_finishing <= conv_res_valid;
end 

// 5. complete  
// Frame complete signal
always@(*) begin
    if(Ifmap_vert_base_cnt == ofmap_size-1 && row_end) complete <= 1'b1;
    else complete <= 1'b0;
end

// 6. intr_in_pulse (spare)
reg intr_in_reg_1;
always @(posedge clk or negedge rst) begin
    if (!rst) begin
      intr_in_reg_1 <= 0;
    end  
    else begin
        intr_in_reg_1 <= intr_in;
    end 
end 
assign intr_in_pulse = intr_in & (~intr_in_reg_1);

// 7. window_loaded  
// indicates that a 3*3 window buffer is successful loaded and ready to produce result
assign window_loaded = (Conv33_local_hori_cnt==2)? 1'b1:1'b0;



/////////////////------------------------------------------------/////////////////////
/////////////        [6].DATA Bram ifmap ROW Input Order         ///////////////////
/////////////////------------------------------------------------////////////////////

/////////////////////////////////////////////////////////
reg signed [7: 0]conv_data_in_1 = 0;
reg signed [7: 0]conv_data_in_2 = 0;
reg signed [7: 0]conv_data_in_3 = 0;

always @(*)  begin
    if (bram_st == BRAM_WR)  begin
        if(stride==0)  begin                 
// ------ case(1) state is BRAM_WR ---- scenario(1) stride is 1    |||padding the last colume|||
            if(Ifmap_hori_base_cnt== ofmap_size-1) begin     
                if(filter_cnt==2) begin
                    conv_data_in_1 <= 0;
                    conv_data_in_2 <= 0;
                    conv_data_in_3 <= 0;
                end
                else begin
                    case(Conv33_local_vert_cnt)
                        0:
                        begin
                            conv_data_in_1 <= bram_ifmap_in_3 - input_zero_point;
                            conv_data_in_2 <= bram_ifmap_in_1 - input_zero_point;
                            conv_data_in_3 <= bram_ifmap_in_2 - input_zero_point;
                        end
                        1:
                        begin
                            conv_data_in_1 <= bram_ifmap_in_1 - input_zero_point;
                            conv_data_in_2 <= bram_ifmap_in_2 - input_zero_point;
                            conv_data_in_3 <= bram_ifmap_in_3 - input_zero_point;
                        end
                        2:
                        begin
                            conv_data_in_1 <= bram_ifmap_in_2 - input_zero_point;
                            conv_data_in_2 <= bram_ifmap_in_3 - input_zero_point;
                            conv_data_in_3 <= bram_ifmap_in_1 - input_zero_point;                     
                        end
                        default
                        begin
                            conv_data_in_1 <= 0;
                            conv_data_in_2 <= 0;
                            conv_data_in_3 <= 0; 
                        end 
                    endcase
                end
            end
// ----- case(1) state is BRAM_WR ---- scenario(1) stride is 1    |||padding the first colume|||  
            else if(Ifmap_hori_base_cnt==0) begin            
                if(filter_cnt==0) begin
                    conv_data_in_1 <= 0;
                    conv_data_in_2 <= 0;
                    conv_data_in_3 <= 0;
                end
                else begin
                    case(Conv33_local_vert_cnt)
                        0:
                        begin
                            conv_data_in_1 <= bram_ifmap_in_3 - input_zero_point;
                            conv_data_in_2 <= bram_ifmap_in_1 - input_zero_point;
                            conv_data_in_3 <= bram_ifmap_in_2 - input_zero_point;
                        end
                        1:
                        begin
                            conv_data_in_1 <= bram_ifmap_in_1 - input_zero_point;
                            conv_data_in_2 <= bram_ifmap_in_2 - input_zero_point;
                            conv_data_in_3 <= bram_ifmap_in_3 - input_zero_point;
                        end
                        2:
                        begin
                            conv_data_in_1 <= bram_ifmap_in_2 - input_zero_point;
                            conv_data_in_2 <= bram_ifmap_in_3 - input_zero_point;
                            conv_data_in_3 <= bram_ifmap_in_1 - input_zero_point;                     
                        end
                        default
                        begin
                            conv_data_in_1 <= 0;
                            conv_data_in_2 <= 0;
                            conv_data_in_3 <= 0; 
                        end 
                    endcase
                end
            end
            else begin
                case(Conv33_local_vert_cnt)
                    0:
                    begin
                        conv_data_in_1 <= bram_ifmap_in_3 - input_zero_point;
                        conv_data_in_2 <= bram_ifmap_in_1 - input_zero_point;
                        conv_data_in_3 <= bram_ifmap_in_2 - input_zero_point;
                    end
                    1:
                    begin
                        conv_data_in_1 <= bram_ifmap_in_1 - input_zero_point;
                        conv_data_in_2 <= bram_ifmap_in_2 - input_zero_point;
                        conv_data_in_3 <= bram_ifmap_in_3 - input_zero_point;
                    end
                    2:
                    begin
                        conv_data_in_1 <= bram_ifmap_in_2 - input_zero_point;
                        conv_data_in_2 <= bram_ifmap_in_3 - input_zero_point;
                        conv_data_in_3 <= bram_ifmap_in_1 - input_zero_point;                     
                    end
                    default
                    begin
                        conv_data_in_1 <= 0;
                        conv_data_in_2 <= 0;
                        conv_data_in_3 <= 0; 
                    end 
                endcase
            end
        end
// --- case(1) state is BRAM_WR ---- scenario(2) stride is 2    |||padding the first colume|||  
        else begin           
            if(Ifmap_hori_base_cnt==0) begin            
                if(filter_cnt==0) begin
                    conv_data_in_1 <= 0;
                    conv_data_in_2 <= 0;
                    conv_data_in_3 <= 0;
                end
                else begin
                    case(Conv33_local_vert_cnt)
                    0:
                    begin
                        conv_data_in_1 <= bram_ifmap_in_3 - input_zero_point;
                        conv_data_in_2 <= bram_ifmap_in_1 - input_zero_point;
                        conv_data_in_3 <= bram_ifmap_in_2 - input_zero_point;
                    end
                    1:
                    begin
                        conv_data_in_1 <= bram_ifmap_in_2 - input_zero_point;
                        conv_data_in_2 <= bram_ifmap_in_3 - input_zero_point;
                        conv_data_in_3 <= bram_ifmap_in_1 - input_zero_point;
                    end
                    2:
                    begin
                        conv_data_in_1 <= bram_ifmap_in_1 - input_zero_point;
                        conv_data_in_2 <= bram_ifmap_in_2 - input_zero_point;
                        conv_data_in_3 <= bram_ifmap_in_3 - input_zero_point;                     
                    end
                    default
                    begin
                        conv_data_in_1 <= 0;
                        conv_data_in_2 <= 0;
                        conv_data_in_3 <= 0; 
                    end 
                endcase
                end
            end

            else begin
                case(Conv33_local_vert_cnt)
                    0:
                    begin
                        conv_data_in_1 <= bram_ifmap_in_3 - input_zero_point;
                        conv_data_in_2 <= bram_ifmap_in_1 - input_zero_point;
                        conv_data_in_3 <= bram_ifmap_in_2 - input_zero_point;
                    end
                    1:
                    begin
                        conv_data_in_1 <= bram_ifmap_in_2 - input_zero_point;
                        conv_data_in_2 <= bram_ifmap_in_3 - input_zero_point;
                        conv_data_in_3 <= bram_ifmap_in_1 - input_zero_point;
                    end
                    2:
                    begin
                        conv_data_in_1 <= bram_ifmap_in_1 - input_zero_point;
                        conv_data_in_2 <= bram_ifmap_in_2 - input_zero_point;
                        conv_data_in_3 <= bram_ifmap_in_3 - input_zero_point;                     
                    end
                    default
                    begin
                        conv_data_in_1 <= 0;
                        conv_data_in_2 <= 0;
                        conv_data_in_3 <= 0; 
                    end 
                endcase
            end    
        end
    end
// --- case(2) state is BRAM_FIRST_WR   |||padding the last colume|||  
    else if (bram_st == BRAM_FIRST_WR)begin
        if(Ifmap_hori_base_cnt== ofmap_size-1) 
        begin     
            if(filter_cnt==2) begin
                if(stride==0) begin
                    conv_data_in_1 <= 0;
                    conv_data_in_2 <= 0;
                    conv_data_in_3 <= 0;
                end
                else begin
                     conv_data_in_1 <= 0;
                     conv_data_in_2 <= bram_ifmap_in_1 - input_zero_point;
                     conv_data_in_3 <= bram_ifmap_in_2 - input_zero_point;
                end
            end
            else begin
            conv_data_in_1 <= 0;
            conv_data_in_2 <= bram_ifmap_in_1 - input_zero_point;
            conv_data_in_3 <= bram_ifmap_in_2 - input_zero_point; 
            end
        end
// --- case(2) state is BRAM_FIRST_WR   |||padding the first colume|||  
        else if(Ifmap_hori_base_cnt== 0) 
        begin     
            if(filter_cnt==0) begin
                conv_data_in_1 <= 0;
                conv_data_in_2 <= 0;
                conv_data_in_3 <= 0;
            end
            else begin
            conv_data_in_1 <= 0;
            conv_data_in_2 <= bram_ifmap_in_1 - input_zero_point;
            conv_data_in_3 <= bram_ifmap_in_2 - input_zero_point; 
            end
        end
        else begin
            conv_data_in_1 <= 0;
            conv_data_in_2 <= bram_ifmap_in_1 - input_zero_point;
            conv_data_in_3 <= bram_ifmap_in_2 - input_zero_point;
        end
    end
// --- case(3) state is BRAM_LAST_WR   ---- scenario(1) stride is 1    |||padding the last colume|||  
    else if(bram_st == BRAM_LAST_WR) begin
    if(stride==0) 
    begin             
        if(Ifmap_hori_base_cnt== ofmap_size-1) 
        begin     
            if(filter_cnt==2) begin
                conv_data_in_1 <= 0;
                conv_data_in_2 <= 0;
                conv_data_in_3 <= 0;
            end
            else begin                                  
                case(Conv33_local_vert_cnt)
                    0:
                    begin
                        conv_data_in_1 <= bram_ifmap_in_3 - input_zero_point;
                        conv_data_in_2 <= bram_ifmap_in_1 - input_zero_point;
                        conv_data_in_3 <= 0;
                    end
                    1:
                    begin
                        conv_data_in_1 <= bram_ifmap_in_1 - input_zero_point;
                        conv_data_in_2 <= bram_ifmap_in_2 - input_zero_point;
                        conv_data_in_3 <= 0;
                    end
                    2:
                    begin
                        conv_data_in_1 <= bram_ifmap_in_2 - input_zero_point;
                        conv_data_in_2 <= bram_ifmap_in_3 - input_zero_point;
                        conv_data_in_3 <= 0;                     
                    end
                    default
                    begin
                        conv_data_in_1 <= 0;
                        conv_data_in_2 <= 0;
                        conv_data_in_3 <= 0; 
                    end 
                endcase
            end
        end
// --- case(3) state is BRAM_LAST_WR   ---- scenario(1) stride is 1    |||padding the first colume|||  
        else if(Ifmap_hori_base_cnt==0)     
        begin           
            if(filter_cnt==0) begin
                conv_data_in_1 <= 0;
                conv_data_in_2 <= 0;
                conv_data_in_3 <= 0;
            end
            else begin
                case(Conv33_local_vert_cnt)
                    0:
                    begin
                        conv_data_in_1 <= bram_ifmap_in_3- input_zero_point;
                        conv_data_in_2 <= bram_ifmap_in_1- input_zero_point;
                        conv_data_in_3 <= 0;
                    end
                    1:
                    begin
                        conv_data_in_1 <= bram_ifmap_in_1 - input_zero_point;
                        conv_data_in_2 <= bram_ifmap_in_2 - input_zero_point;
                        conv_data_in_3 <= 0;
                    end
                    2:
                    begin
                        conv_data_in_1 <= bram_ifmap_in_2 - input_zero_point;
                        conv_data_in_2 <= bram_ifmap_in_3 - input_zero_point;
                        conv_data_in_3 <= 0;                     
                    end
                    default
                    begin
                        conv_data_in_1 <= 0;
                        conv_data_in_2 <= 0;
                        conv_data_in_3 <= 0; 
                    end 
                endcase
            end
        end
        else begin
            case(Conv33_local_vert_cnt)
                    0:
                    begin
                        conv_data_in_1 <= bram_ifmap_in_3 - input_zero_point;
                        conv_data_in_2 <= bram_ifmap_in_1 - input_zero_point;
                        conv_data_in_3 <= 0;
                    end
                    1:
                    begin
                        conv_data_in_1 <= bram_ifmap_in_1 - input_zero_point;
                        conv_data_in_2 <= bram_ifmap_in_2 - input_zero_point;
                        conv_data_in_3 <= 0;
                    end
                    2:
                    begin
                        conv_data_in_1 <= bram_ifmap_in_2 - input_zero_point;
                        conv_data_in_2 <= bram_ifmap_in_3 - input_zero_point;
                        conv_data_in_3 <= 0;                     
                    end
                    default
                    begin
                        conv_data_in_1 <= 0;
                        conv_data_in_2 <= 0;
                        conv_data_in_3 <= 0; 
                    end 
                endcase
            end
        end
    else 
// --- case(3) state is BRAM_LAST_WR   ---- scenario(2) stride is 2    |||padding the first colume||| 
    begin            
            if(Ifmap_hori_base_cnt==0) begin           
                if(filter_cnt==0) begin
                    conv_data_in_1 <= 0;
                    conv_data_in_2 <= 0;
                    conv_data_in_3 <= 0;
                end
                else begin
                    case(Conv33_local_vert_cnt)
                    0:
                    begin
                       conv_data_in_1 <= bram_ifmap_in_3 - input_zero_point;
                       conv_data_in_2 <= bram_ifmap_in_1 - input_zero_point;
                       conv_data_in_3 <= bram_ifmap_in_2 - input_zero_point;
                    end
                    1:
                    begin
                        conv_data_in_1 <= bram_ifmap_in_2 - input_zero_point;
                        conv_data_in_2 <= bram_ifmap_in_3 - input_zero_point;
                        conv_data_in_3 <= bram_ifmap_in_1 - input_zero_point;
                    end
                    2:
                    begin
                        conv_data_in_1 <= bram_ifmap_in_1 - input_zero_point;
                        conv_data_in_2 <= bram_ifmap_in_2 - input_zero_point;
                        conv_data_in_3 <= bram_ifmap_in_3 - input_zero_point;                     
                    end
                    default
                    begin
                        conv_data_in_1 <= 0;
                        conv_data_in_2 <= 0;
                        conv_data_in_3 <= 0; 
                    end 
                endcase
                end
            end

            else begin
                case(Conv33_local_vert_cnt)
                    0:
                    begin
                        conv_data_in_1 <= bram_ifmap_in_3 - input_zero_point;
                        conv_data_in_2 <= bram_ifmap_in_1 - input_zero_point;
                        conv_data_in_3 <= bram_ifmap_in_2 - input_zero_point;
                    end
                    1:
                    begin
                        conv_data_in_1 <= bram_ifmap_in_2 - input_zero_point;
                        conv_data_in_2 <= bram_ifmap_in_3 - input_zero_point;
                        conv_data_in_3 <= bram_ifmap_in_1 - input_zero_point;
                    end
                    2:
                    begin
                        conv_data_in_1 <= bram_ifmap_in_1 - input_zero_point;
                        conv_data_in_2 <= bram_ifmap_in_2 - input_zero_point;
                        conv_data_in_3 <= bram_ifmap_in_3 - input_zero_point;                     
                    end
                    default
                    begin
                        conv_data_in_1 <= 0;
                        conv_data_in_2 <= 0;
                        conv_data_in_3 <= 0; 
                    end 
                endcase
            end       
        end
    end
    else begin
            conv_data_in_1 <= 0;
            conv_data_in_2 <= 0;
            conv_data_in_3 <= 0;
    end
end

/////////////////------------------------------------------------/////////////////////
/////////////        [7].Kernel Bram ROW Input Order         ///////////////////
/////////////////------------------------------------------------////////////////////
wire [DATA_WIDTH  - 1: 0]conv_weight_in_1;
wire [DATA_WIDTH  - 1: 0]conv_weight_in_2;
wire [DATA_WIDTH  - 1: 0]conv_weight_in_3;
assign conv_weight_in_1 = bram_weight_in_1;
assign conv_weight_in_2 = bram_weight_in_2;
assign conv_weight_in_3 = bram_weight_in_3;



/**
always @(*)  begin
    if (bram_st == BRAM_WR)  
    begin
        if(stride==0) 
// ------ (k) case(1) state is BRAM_WR   ---- scenario(1) stride is 1 
        begin              
            case(Conv33_local_vert_cnt)
                0:
                begin
                    conv_weight_in_1 <= bram_weight_in_1;
                    conv_weight_in_2 <= bram_weight_in_2;
                    conv_weight_in_3 <= bram_weight_in_3;
                end
                1:
                begin
                    conv_weight_in_1 <= bram_weight_in_3;
                    conv_weight_in_2 <= bram_weight_in_1;
                    conv_weight_in_3 <= bram_weight_in_2;
                end
                2:
                begin
                    conv_weight_in_1 <= bram_weight_in_2;
                    conv_weight_in_2 <= bram_weight_in_3;
                    conv_weight_in_3 <= bram_weight_in_1;                     
                end
                default
                begin
                    conv_weight_in_1 <= bram_weight_in_1;
                    conv_weight_in_2 <= bram_weight_in_2;
                    conv_weight_in_3 <= bram_weight_in_3; 
                end 
            endcase
        end
        else 
// ------ (k) case(1) state is BRAM_WR   ---- scenario(2) stride is 2 
        begin              
            case(Conv33_local_vert_cnt)
                0:
                begin
                    conv_weight_in_1 <= bram_weight_in_1;
                    conv_weight_in_2 <= bram_weight_in_2;
                    conv_weight_in_3 <= bram_weight_in_3;
                end
                1:
                begin
                    conv_weight_in_1 <= bram_weight_in_2;
                    conv_weight_in_2 <= bram_weight_in_3;
                    conv_weight_in_3 <= bram_weight_in_1;
                end
                2:
                begin
                    conv_weight_in_1 <= bram_weight_in_3;
                    conv_weight_in_2 <= bram_weight_in_1;
                    conv_weight_in_3 <= bram_weight_in_2;                     
                end
                default
                begin
                    conv_weight_in_1 <= bram_weight_in_1;
                    conv_weight_in_2 <= bram_weight_in_2;
                    conv_weight_in_3 <= bram_weight_in_3; 
                end 
            endcase
        end
    end
// ------ (k) case(2) state is BRAM_FIRST_WR  
    else if (bram_st == BRAM_FIRST_WR)
    begin
        conv_weight_in_1 <= 0;
        conv_weight_in_2 <= bram_weight_in_1;
        conv_weight_in_3 <= bram_weight_in_2; 
    end
    else if(bram_st == BRAM_LAST_WR) 
    begin
        if(stride==0) 
        begin         
// ------ (k) case(3) state is BRAM_LAST_WR  ---- scenario(1) stride is 1 
            case(Conv33_local_vert_cnt)
                0:
                begin
                    conv_weight_in_1 <= bram_weight_in_1;
                    conv_weight_in_2 <= bram_weight_in_2;
                    conv_weight_in_3 <= 0;
                end
                1:
                begin
                    conv_weight_in_1 <= bram_weight_in_3;
                    conv_weight_in_2 <= bram_weight_in_1;
                    conv_weight_in_3 <= 0;
                end
                2:
                begin
                    conv_weight_in_1 <= bram_weight_in_2;
                    conv_weight_in_2 <= bram_weight_in_3;
                    conv_weight_in_3 <= 0;                     
                end
                default
                begin
                    conv_weight_in_1 <= bram_weight_in_1;
                    conv_weight_in_2 <= bram_weight_in_2;
                    conv_weight_in_3 <= 0; 
                end 
            endcase
        end
        else 
// ------ (k) case(3) state is BRAM_LAST_WR  ---- scenario(2) stride is 2 
        begin              
            case(Conv33_local_vert_cnt)
                0:
                begin
                    conv_weight_in_1 <= bram_weight_in_1;
                    conv_weight_in_2 <= bram_weight_in_2;
                    conv_weight_in_3 <= 0;
                end
                1:
                begin
                    conv_weight_in_1 <= bram_weight_in_2;
                    conv_weight_in_2 <= bram_weight_in_3;
                    conv_weight_in_3 <= 0;
                end
                2:
                begin
                    conv_weight_in_1 <= bram_weight_in_3;
                    conv_weight_in_2 <= bram_weight_in_1;
                    conv_weight_in_3 <= 0;                     
                end
                default
                begin
                    conv_weight_in_1 <= bram_weight_in_1;
                    conv_weight_in_2 <= bram_weight_in_2;
                    conv_weight_in_3 <= 0; 
                end 
            endcase
        end
    end
//// state is not BRAM_WR nor BRAM_LAST_WR nor BRAM_FIRST_WR
    else begin
        conv_weight_in_1 <= 0;
        conv_weight_in_2 <= 0;
        conv_weight_in_3 <= 0; 
    end
end
**/
/////////////////------------------------------------------------/////////////////////
/////////////        [8].DATA Bram ofmap ROW Output Order        ///////////////////
/////////////////------------------------------------------------////////////////////
always@(*) begin
    if(bram_st == BRAM_FIRST_WR)   //first line
    begin
        if(conv)
            if(conv_acc_valid) begin
                bram_ofmap_out_1 <= Relu_out;
                bram_ofmap_out_2 <= 0;
                bram_ofmap_out_3 <= 0;
            end
            else begin
                bram_ofmap_out_1 <= 0;
                bram_ofmap_out_2 <= 0;
                bram_ofmap_out_3 <= 0;
            end
        else begin
            if(conv_res_valid) begin
                bram_ofmap_out_1 <= Relu_out;
                bram_ofmap_out_2 <= 0;
                bram_ofmap_out_3 <= 0;
            end
            else begin
                bram_ofmap_out_1 <= 0;
                bram_ofmap_out_2 <= 0;
                bram_ofmap_out_3 <= 0;
            end
        end
    end
    else if (bram_st == BRAM_LAST_WR || bram_st == BRAM_WR)   //first line
    begin
        if(conv)
            if(conv_acc_valid) begin
                case(Conv33_local_vert_cnt)
                    0:
                    begin
                        bram_ofmap_out_1 <= Relu_out;
                        bram_ofmap_out_2 <= 0;
                        bram_ofmap_out_3 <= 0;
                    end
                    1:
                    begin
                        bram_ofmap_out_1 <= 0;
                        bram_ofmap_out_2 <= Relu_out;
                        bram_ofmap_out_3 <= 0;
                    end
                    2:
                    begin
                        bram_ofmap_out_1 <= 0;
                        bram_ofmap_out_2 <= 0;
                        bram_ofmap_out_3 <= Relu_out;                     
                    end
                    default
                    begin
                        bram_ofmap_out_1 <= 0;
                        bram_ofmap_out_2 <= 0;
                        bram_ofmap_out_3 <= 0; 
                    end 
                endcase
            end
            else begin
                bram_ofmap_out_1 <= 0;
                bram_ofmap_out_2 <= 0;
                bram_ofmap_out_3 <= 0; 
            end
        else begin
            if(conv_res_valid) begin
                case(Conv33_local_vert_cnt)
                    0:
                    begin
                        bram_ofmap_out_1 <= Relu_out;
                        bram_ofmap_out_2 <= 0;
                        bram_ofmap_out_3 <= 0;
                    end
                    1:
                    begin
                        bram_ofmap_out_1 <= 0;
                        bram_ofmap_out_2 <= Relu_out;
                        bram_ofmap_out_3 <= 0;
                    end
                    2:
                    begin
                        bram_ofmap_out_1 <= 0;
                        bram_ofmap_out_2 <= 0;
                        bram_ofmap_out_3 <= Relu_out;                     
                    end
                    default
                    begin
                        bram_ofmap_out_1 <= 0;
                        bram_ofmap_out_2 <= 0;
                        bram_ofmap_out_3 <= 0; 
                    end 
                endcase
            end
            else begin
                bram_ofmap_out_1 <= 0;
                bram_ofmap_out_2 <= 0;
                bram_ofmap_out_3 <= 0; 
            end
        end
    end
    else begin
        bram_ofmap_out_1 <= 0;
        bram_ofmap_out_2 <= 0;
        bram_ofmap_out_3 <= 0;
    end
end

/////////////////------------------------------------------------/////////////////////
/////////////        [9].DATA Bram read address generation        ///////////////////
/////////////////------------------------------------------------////////////////////

//----------- 1. bram_base_raw_addr subaddress generation ---------------- //////////
always@(posedge clk) begin
if((!rst)||complete) begin
    bram_base_raw_addr_1 <= 0;
    bram_base_raw_addr_2 <= 0;
    bram_base_raw_addr_3 <= 0;
end
else if(row_end) begin
    if(bram_st == BRAM_WR || bram_st == BRAM_LAST_WR) begin
    //stride is 1
        if(stride==0)  begin      
            case(Conv33_local_vert_cnt)
            0:
            begin
                bram_base_raw_addr_1 <= bram_base_raw_addr_1  + address_raw_shift ;
                bram_base_raw_addr_2 <= bram_base_raw_addr_2;
                bram_base_raw_addr_3 <= bram_base_raw_addr_3;
            end
            1:
            begin
                bram_base_raw_addr_1 <= bram_base_raw_addr_1;
                bram_base_raw_addr_2 <= bram_base_raw_addr_2 + address_raw_shift ;
                bram_base_raw_addr_3 <= bram_base_raw_addr_3;
            end
            2:
            begin
                bram_base_raw_addr_1 <= bram_base_raw_addr_1;
                bram_base_raw_addr_2 <= bram_base_raw_addr_2;
                bram_base_raw_addr_3 <= bram_base_raw_addr_3 + address_raw_shift ;
            end
            default:
            begin
                bram_base_raw_addr_1 <= bram_base_raw_addr_1;
                bram_base_raw_addr_2 <= bram_base_raw_addr_2;
                bram_base_raw_addr_3 <= bram_base_raw_addr_3;
            end
            endcase
        end
     //stride is 2
        else begin         
            case(Conv33_local_vert_cnt)
            0:
            begin
                bram_base_raw_addr_1 <= bram_base_raw_addr_1  + address_raw_shift ;
                bram_base_raw_addr_2 <= bram_base_raw_addr_2;
                bram_base_raw_addr_3 <= bram_base_raw_addr_3  + address_raw_shift;
            end
            1:
            begin
                bram_base_raw_addr_1 <= bram_base_raw_addr_1  ;
                bram_base_raw_addr_2 <= bram_base_raw_addr_2 + address_raw_shift;
                bram_base_raw_addr_3 <= bram_base_raw_addr_3 + address_raw_shift;
            end
            2:
            begin
                bram_base_raw_addr_1 <= bram_base_raw_addr_1 + address_raw_shift;
                bram_base_raw_addr_2 <= bram_base_raw_addr_2 + address_raw_shift;
                bram_base_raw_addr_3 <= bram_base_raw_addr_3;
            end
            default:
            begin
                bram_base_raw_addr_1 <= bram_base_raw_addr_1;
                bram_base_raw_addr_2 <= bram_base_raw_addr_2;
                bram_base_raw_addr_3 <= bram_base_raw_addr_3;
            end
            endcase
        end         //stride=0 end
    end      //bram_st end
    else if(bram_st == BRAM_FIRST_WR)begin
        if(stride==0) begin
            bram_base_raw_addr_1 <= bram_base_raw_addr_1;
            bram_base_raw_addr_2 <= bram_base_raw_addr_1;
            bram_base_raw_addr_3 <= bram_base_raw_addr_1;
        end
        begin
            bram_base_raw_addr_1 <= bram_base_raw_addr_1 + address_raw_shift;
            bram_base_raw_addr_2 <= bram_base_raw_addr_1;
            bram_base_raw_addr_3 <= bram_base_raw_addr_1;
        end
    end
    else begin
        bram_base_raw_addr_1 <= ifmap_base_addr;
        bram_base_raw_addr_2 <= ifmap_base_addr;
        bram_base_raw_addr_3 <= ifmap_base_addr;
    end
end //row_end end
else begin
    bram_base_raw_addr_1 <= bram_base_raw_addr_1;
    bram_base_raw_addr_2 <= bram_base_raw_addr_2;
    bram_base_raw_addr_3 <= bram_base_raw_addr_3;
end
end

//----------- 2. bram_point_addr subaddress generation ---------------- //////////
wire [DATA_BRAM_ADDR_WIDTH-1:0] bram_base_point_addr;
wire [DATA_BRAM_ADDR_WIDTH-1:0] bram_ofmap_base_point_addr;
assign bram_base_point_addr = (stride==0)? Ifmap_hori_base_cnt*address_point_shift: (Ifmap_hori_base_cnt*2)*address_point_shift;
assign bram_ofmap_base_point_addr = Ifmap_hori_base_cnt*ofmap_channel;
//always@(*) begin
//    if(conv) 
//        bram_base_point_addr <= 
//    else begin
//        if(stride==0)
//            bram_base_point_addr <= Ifmap_hori_base_cnt*address_point_shift;
//        else
//            bram_base_point_addr <= (Ifmap_hori_base_cnt*2)*address_point_shift;
//    end
//end


always@(*) begin
if(!rst) begin
    bram_point_addr <= 0;
end
else begin
    case(Conv33_local_hori_cnt)
    0: bram_point_addr<=bram_base_point_addr-address_point_shift;
    1: bram_point_addr<=bram_base_point_addr;
    2: bram_point_addr<=bram_base_point_addr+address_point_shift;
    default: bram_point_addr<=bram_base_point_addr;
    endcase
end
end

//----------- 3. bram_point_channel_addr subaddress generation ---------------- //////////
assign bram_point_channel_addr = Channel_cnt;

//----------- 4. bram_conv_channel_round_addr subaddress generation ---------------- //////////
assign bram_conv_channel_round_addr = Conv_round_cnt;
//----------- 5. bram_ifmap_addr final address generation ---------------- //////////
assign bram_ifmap_addr_1 = bram_base_raw_addr_1 + bram_point_addr + bram_point_channel_addr;
assign bram_ifmap_addr_2 = bram_base_raw_addr_2 + bram_point_addr + bram_point_channel_addr;
assign bram_ifmap_addr_3 = bram_base_raw_addr_3 + bram_point_addr + bram_point_channel_addr;




/////////////////------------------------------------------------/////////////////////
/////////////        [10].DATA Bram write address generation        ///////////////////
/////////////////------------------------------------------------////////////////////
//----------- 1. bram_ofmap_addr address generation ---------------- /////////
assign bram_ofmap_addr_1 = (conv)? bram_base_raw_addr_1 + bram_ofmap_base_point_addr + bram_conv_channel_round_addr: bram_base_raw_addr_1 + bram_ofmap_base_point_addr + bram_point_channel_addr;
assign bram_ofmap_addr_2 = (conv)? bram_base_raw_addr_2 + bram_ofmap_base_point_addr + bram_conv_channel_round_addr: bram_base_raw_addr_2 + bram_ofmap_base_point_addr + bram_point_channel_addr;
assign bram_ofmap_addr_3 = (conv)? bram_base_raw_addr_3 + bram_ofmap_base_point_addr + bram_conv_channel_round_addr: bram_base_raw_addr_3 + bram_ofmap_base_point_addr + bram_point_channel_addr;

/////////////////------------------------------------------------/////////////////////
/////////////        [11].Kernel Bram read address generation        ///////////////////
/////////////////------------------------------------------------////////////////////


//----------- 1. kernel_channel_base_addr subaddress generation ---------------- //////////
always@(posedge clk) begin
    if(!rst) kernel_channel_base_addr <= 0;
    else if(conv_point_calculation_finishing) kernel_channel_base_addr <= 0;
    else if(conv_channel_calculation_finishing) kernel_channel_base_addr = kernel_channel_base_addr + 3;
end
//----------- 2. kernel_local_point_addr subaddress generation ---------------- //////////
assign kernel_local_point_addr = Conv33_local_hori_cnt;

//----------- 3. kernel_addr final address generation ---------------- //////////
assign kernel_addr = Weight_base_addr + kernel_channel_base_addr + kernel_local_point_addr;



/////////////////------------------------------------------------/////////////////////
/////////////        [12].Bias Bram read address generation        ///////////////////
/////////////////------------------------------------------------////////////////////

//----------- 1. bias_channel_base_addr subaddress generation ---------------- //////////
always@(posedge clk) begin
    if(!rst) bias_channel_base_addr <= 0;
    else if(conv)
        if(conv_point_calculation_finishing) bias_channel_base_addr <= 0;
        else if(conv_channel_calculation_finishing&&(Channel_cnt == ifmap_channel - 1)) bias_channel_base_addr <= bias_channel_base_addr + 1;
        else bias_channel_base_addr <= bias_channel_base_addr;
    else 
        if(conv_point_calculation_finishing) bias_channel_base_addr <= 0;
        else if(conv_channel_calculation_finishing) bias_channel_base_addr <= bias_channel_base_addr + 1;
        else bias_channel_base_addr <= bias_channel_base_addr;
end

//----------- 2. bias_addr final address generation ---------------- //////////
assign bias_addr = Bias_base_addr + bias_channel_base_addr;

/////////////////------------------------------------------------/////////////////////
/////////////        [13].Window Calculator Implementation       ///////////////////
/////////////////------------------------------------------------////////////////////

conv33_window_calculator conv33_window_calculator_0(
    .clk(clk), 
    .ena (window_loaded),
    .data_in_1      (conv_data_in_1),
    .data_in_2      (conv_data_in_2),
    .data_in_3      (conv_data_in_3),
    .weight_in_1    (conv_weight_in_1),
    .weight_in_2    (conv_weight_in_2),
    .weight_in_3    (conv_weight_in_3),
    
    .M0_input(M0_input),
    .filter_cnt(filter_cnt),
    .conv_channel_calculation_finishing(conv_channel_calculation_finishing),
    .data_out        (conv_data_out),
    .valid_channel   (conv_res_valid)
    );

// first layer ordinary convolution result accumulation

always@(posedge clk) begin
    if(!rst) begin
        conv_acc <= 0;
    end
    else if(conv)
        if((Channel_cnt == ifmap_channel - 1) && conv_channel_calculation_finishing)
            conv_acc<=0;
        else if(conv_res_valid) begin
            conv_acc <= conv_acc + conv_data_out;
        end
        else begin
            conv_acc <= conv_acc;
        end
    else begin
        conv_acc <= 0;
    end
end

always@(posedge clk) begin
    if(~clk) conv_acc_valid <= 0;
    else if((Channel_cnt == ifmap_channel - 1) && conv_res_valid) 
        conv_acc_valid <= 1;
    else conv_acc_valid <= 0;
end


assign conv_res = (conv)?conv_acc: conv_data_out;

ReLU_shift_and_concat ReLU_shift_and_concat0(
    .enable(1'b1),
    .conv_res(conv_res),
    .bias(bias_in),
    .Relu_out(Relu_out)
);

endmodule
