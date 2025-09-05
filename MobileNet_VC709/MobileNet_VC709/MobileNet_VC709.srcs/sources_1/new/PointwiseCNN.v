`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/30 13:53:51
// Design Name: 
// Module Name: PointwiseCNN
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
// -- [4].Counters Definition
//      ------ 1. Ifmap_hori_base_cnt(IHB)
//      ------ 2. Ifmap_vert_base_cnt(IVB)
//      ------ 3. Channel_cnt (CC)
//      ------ 4. Conv33_local_vert_cnt(CVLOC)
//      ------ 5. Weight_load_cnt£¨WL£©
//      ------ 6. Channel_Buffer_cnt£¨CB£©
//      ------ 7. Ofmap_channel_round_cnt£¨OCR£©
// -- [5].signal Definition
//      ------ 1. ofmap_size
//      ------ 2. raw_end 
//      ------ 3. conv_point_calculation_finishing   (CPCF)
//      ------ 4. conv_channel_calculation_finishing   (CCCF)
//      ------ 5. complete 
//      ------ 6. intr_in_pulse (spare)
//      ------ 7. window_loaded 
// -- [6].DATA Bram ifmap RAW Input Order
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
// -- [8].DATA Bram ofmap RAW Output Order
// -- [9].DATA Bram read address generation
//      ------ 1. bram_base_raw_addr subaddress generation
//      ------ 2. bram_point_addr subaddress generation
//      ------ 3. bram_point_channel_addr subaddress generation
//      ------ 4. bram_ifmap_addr final address generation
// --[10].Kernel Bram read address generation
//      ------ 1. kernel_channel_base_addr subaddress generation 
//      ------ 2. kernel_local_point_addr subaddress generation
//      ------ 3. kernel_addr final address generation
// --[11].Window Calculator Implementation

module PointwiseCNN
#(
    parameter KERNEL_ADDR_WIDTH = 16
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
    
    input channel_cnt,
    input CPCF,
    //DLM input
    input conv_res_valid,
    input [7:0] conv_res_input,
    
    // Bram input values
    input [7:0] Bram0_data_input,
    input [7:0] Bram1_data_input,
    input [7:0] Bram2_data_input,
    input [7:0] Bram_weight_input,
    input [31:0] Bram_bias_input,
    
    //Bram read control
    output [18:0] Bram0_data_addr,
    output [18:0] Bram1_data_addr,
    output [18:0] Bram2_data_addr,
    output Bram_data_en,
    
    output [15:0] kernel_addr,
    output [14:0] bias_addr,
    
    /** M0 input **/
    input signed [31:0] M0_input,
    input signed [7:0] input_zero_point,
    
/** External dataflow control signal Declaration **/
    output weight_reloading,
    output CCCF,                      //Convolution Channel calculation finished 
    output PWOC,                       //Pointwise Output Valid
    output reg complete,
    output [7:0] PW_out
    );

/** User Config Register Declaration **/
//--  1. Pointwise config register  --//
//--  coding scheme:
//--  [7:0] Ifmap_size  [18:8] Ifmap_channel  [29:19] Ofmap_channel  [31:30]: Mode
    reg [31:0] PW_config;
    
    wire [7:0] ifmap_size;
    assign ifmap_size = PW_config[7:0];
    wire [10:0] ifmap_channel;
    assign ifmap_channel = PW_config[18:8];
    wire [10:0] ofmap_channel;
    assign ofmap_channel = PW_config[29:19] ;
    wire [1:0] Mode;
    assign Mode = PW_config[31:30];

//--  2. Input data and weight base address register --//
//--  coding scheme:
//--  [18:0] ifmap_base_addr   [19] ifmap_group_sel
    reg [31:0] Input_base_addr;
    
    wire [18:0] ifmap_base_addr;
    assign ifmap_base_addr = Input_base_addr[18:0];
    
    wire ifmap_group_sel;
    assign ifmap_group_sel = Input_base_addr[19];
    
//--  3. Kernel base address register --//
//--  coding scheme:
//--  [15:0] Weight_base_addr  [17:16] Weight_output_bram_index
    reg [31:0] Kernel_base_addr;

    wire [11:0] Weight_base_addr;
    assign Weight_base_addr = Kernel_base_addr[KERNEL_ADDR_WIDTH-1:0];  
    wire [1:0] Weight_output_bram_index;
    assign Weight_output_bram_index = Kernel_base_addr[KERNEL_ADDR_WIDTH+1:KERNEL_ADDR_WIDTH];

//--  4. output data and bias base address register --//
//--  coding scheme:
//--  [18:0] Ofmap_base_addr  [30:19] Bias_base_addr
    reg [31:0] Output_base_addr;
    
    wire [18:0] Ofmap_base_addr;
    assign Ofmap_base_addr = Output_base_addr[18:0];
    
    wire [11:0] Bias_base_addr;
    assign Bias_base_addr = Output_base_addr[30:19];
  
/** Counter Register Declaration **/
reg [7:0] Ifmap_hori_base_cnt;
reg [7:0] Ifmap_vert_base_cnt; 
reg [10:0] Channel_cnt;
reg [2:0] Conv33_local_vert_cnt;  
reg [8:0] Weight_load_cnt;
reg [10:0] Ofmap_channel_cnt;
reg [3:0] Ofmap_channel_round_cnt;



/** Internel dataflow control signal Declaration **/
    reg weight_loaded;
    wire channel_load;
    wire channel_disboarding;
    reg [10:0] ofmap_round_channel;
    wire data_flow_stall;
    wire frame_end;
    assign frame_end = (Ifmap_vert_base_cnt == ifmap_size-1) && (Ifmap_hori_base_cnt == ifmap_size-1) && (Channel_cnt == ifmap_channel-1);

/////////////////------------------------------------------------/////////////////////
/////////////////////////////  [2]. User Defined Register ////////////////////////////
/////////////////------------------------------------------------////////////////////
always@(posedge clk) begin
    if((!rst)||complete) begin
        PW_config <= 0;
        Input_base_addr <= 0;
        Kernel_base_addr <= 0;
        Output_base_addr <= 0;
    end
    else if(reg_config_valid) begin
        case(reg_config_addr)
            4'd0: PW_config <= reg_config_data_in; 
            4'd1: Input_base_addr <= reg_config_data_in;
            4'd2: Kernel_base_addr <= reg_config_data_in;
            4'd3: Output_base_addr <= reg_config_data_in;
            default:  
            begin
                PW_config <= PW_config;
                Input_base_addr <= Input_base_addr;
                Kernel_base_addr <= Kernel_base_addr;
                Output_base_addr <= Output_base_addr;
            end
        endcase
    end
    else begin
        PW_config <= PW_config;
        Input_base_addr <= Input_base_addr;
        Kernel_base_addr <= Kernel_base_addr;
        Output_base_addr <= Output_base_addr;
    end
end

/////////////////------------------------------------------------/////////////////////
////////////////////               [3]. FSM                   ////////////////////////
/////////////////------------------------------------------------////////////////////
localparam IDLE        = 0;  
localparam WEIGHT_LOADING    = 1;
localparam BROADCAST     = 2;

reg [2:0]bram_st;
reg [2:0]bram_next_st;

always @(posedge clk or negedge rst)
begin
    if ((!rst)||complete)
    begin
        bram_st <= IDLE; 
    end 
    else if (Mode != 2'd0)
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
            if (Mode != 2'd0) bram_next_st <= WEIGHT_LOADING;
            else bram_next_st <= IDLE;
        end 
        WEIGHT_LOADING:
        begin
            if (weight_loaded) bram_next_st <= BROADCAST;
            else bram_next_st <= WEIGHT_LOADING;
        end
        BROADCAST:
        begin
            if (CPCF||Channel_cnt==ifmap_channel) bram_next_st <= WEIGHT_LOADING;               //reserve 2clk for BRAM delay
            else if(Ofmap_channel_round_cnt==ofmap_channel/320 -1 && frame_end) bram_next_st <= IDLE;
            else bram_next_st <= BROADCAST;
        end
        default:  bram_next_st <= IDLE;
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
        else if(Mode==1 && bram_st==BROADCAST)
            if (Ifmap_hori_base_cnt == ifmap_size-1 && Channel_cnt == ifmap_channel-1)
                Ifmap_hori_base_cnt <= 0;
            else if(Channel_cnt == ifmap_channel-1)
                Ifmap_hori_base_cnt <= Ifmap_hori_base_cnt + 1;
            else 
                Ifmap_hori_base_cnt <= Ifmap_hori_base_cnt;
        else begin
            Ifmap_hori_base_cnt <= Ifmap_hori_base_cnt;
        end
    end 
    
// -- 2. Ifmap_vert_base_cnt(IVB):  --//
// specify the row number of start corner point in ifmap
always @(posedge clk) begin
    if(!rst) begin
        Ifmap_vert_base_cnt <= 0;
    end
    else if (Mode==1 && bram_st==BROADCAST) begin
        if (frame_end)
            Ifmap_vert_base_cnt <= 0;
        else if(Ifmap_hori_base_cnt == ifmap_size-1 && Channel_cnt == ifmap_channel-1)
            Ifmap_vert_base_cnt <= Ifmap_vert_base_cnt + 1;
        else 
            Ifmap_vert_base_cnt <= Ifmap_vert_base_cnt;
    end
    else Ifmap_vert_base_cnt <= Ifmap_vert_base_cnt;
end 

// -- 3. Channel_cnt(CC)
always@(posedge clk) begin
    if(!rst) begin
        Channel_cnt <= 0;
    end
    else if((Mode==1||Mode==3)&& bram_st == BROADCAST) begin
        Channel_cnt <= Channel_cnt+1;
    end
    else Channel_cnt<= 0;
end

// 4. Conv33_local_vert_cnt(CVLOC) : specify the location of continuous 3 vertical raws in a 3*3 convolution for the purpose of generating different BRAM output order
always @(posedge clk) begin
    if(!rst) begin
        Conv33_local_vert_cnt <= 0;
    end
    else if(Mode == 1 && bram_st == BROADCAST)
    begin 
        if (Ifmap_hori_base_cnt == ifmap_size-1 && Channel_cnt == ifmap_channel-1 && (Conv33_local_vert_cnt == 2))
            Conv33_local_vert_cnt <= 0;
        else if(frame_end)
            Conv33_local_vert_cnt <= 0;
        else if (Ifmap_hori_base_cnt == ifmap_size-1 && Channel_cnt == ifmap_channel-1)
            Conv33_local_vert_cnt <= Conv33_local_vert_cnt + 1;
        else 
            Conv33_local_vert_cnt <= Conv33_local_vert_cnt; 
     end
     else
        Conv33_local_vert_cnt <= Conv33_local_vert_cnt;
end

// 5. Weight_load_cnt(WL)  
always @(posedge clk) begin
    if(!rst) begin
        Weight_load_cnt <= 0;
    end
    else if(bram_st == WEIGHT_LOADING)
        if(Ofmap_channel_cnt==ofmap_channel-1) begin
            Weight_load_cnt <= 0;
        end
        else if(Weight_load_cnt==320-1) begin
            Weight_load_cnt <= 0;
        end
        else begin 
            Weight_load_cnt <= Weight_load_cnt+1;
        end
    else begin
        Weight_load_cnt <= 0;
    end
end

always@(*) begin
    if(bram_st == WEIGHT_LOADING)
        if(Ofmap_channel_cnt==ofmap_channel-1) weight_loaded <= 1;
        else if(Weight_load_cnt==320-1) weight_loaded <= 1;
        else weight_loaded <= 0;
    else weight_loaded <= 0;
end

assign channel_load = (bram_st == WEIGHT_LOADING && Weight_load_cnt==0);
assign channel_disboarding = (bram_st == WEIGHT_LOADING && ~channel_load);

// 6. Ofmap_channel_cnt(OC)
always @(posedge clk) begin
    if(!rst) 
        Ofmap_channel_cnt <= 0;
    else if(bram_st == WEIGHT_LOADING)
        if(Ofmap_channel_cnt==ofmap_channel-1)
            Ofmap_channel_cnt <= 0;
        else Ofmap_channel_cnt <= Ofmap_channel_cnt+1;
    else Ofmap_channel_cnt <= Ofmap_channel_cnt;
end


// 7. Ofmap_channel_round_cnt(OCR)
always @(posedge clk) begin
    if(!rst) 
        Ofmap_channel_round_cnt <= 0;
    else if(Mode==1 || Mode==3)
        if(Ofmap_channel_round_cnt==ofmap_channel/320 -1 && frame_end)
            Ofmap_channel_round_cnt <= 0;
        else if(frame_end)
            Ofmap_channel_round_cnt <= Ofmap_channel_round_cnt+1;
        else
            Ofmap_channel_round_cnt <= Ofmap_channel_round_cnt;
    else Ofmap_channel_round_cnt <= 0;
end

wire [8*320-1:0] weight_out;
wire [32*320-1:0] DSP_res;
Weight_loaded_buffer Weight_loaded_buffer0(
    .clk(clk),
    .rst(rst),
    .weight_in(Bram_weight_input),            //input [7:0] weight to load
    .weight_loading(bram_st == WEIGHT_LOADING),       //input indicates the weight is loading
    
    .weight_out(weight_out)            //output [8*320-1:0] weight output
    );

wire [7:0] data_input;
reg [7:0] Bram_data_input;


always@(*)
    if(bram_st == BROADCAST)
        case(Conv33_local_vert_cnt)
            0:
            begin
                Bram_data_input <= Bram0_data_input;
            end
            1:
            begin
                Bram_data_input <= Bram1_data_input;
            end
            2:
            begin
                Bram_data_input <= Bram2_data_input;                  
            end
            default
            begin
                Bram_data_input <= 0; 
            end 
        endcase
    else begin
        Bram_data_input <= 0;
    end
    
assign data_input = (Mode==2)? conv_res_input:Bram_data_input;

genvar i;
generate
    for(i=0; i<320-1; i=i+1) begin
        ACC ACC_ins(
        .clk(clk),
        .rst(rst),
        .ena(bram_st == BROADCAST),
        .x(data_input),
        .w(weight_out[((i+1)*8)+:8]),
        .x_z(input_zero_point),
        .acc_res(DSP_res[((i+1)*32)+:32])
    );
    end
endgenerate

wire ReLU_ena;
assign ReLU_ena = (Mode!=2)? 1'b1: 1'b0;


Channel_buffer Channel_buffer0(
    .clk(clk),
    .rst(rst),
    .channel_load(channel_load),
    .channel_disboarding(channel_disboarding),
    .result_in(DSP_res),
    .M0(M0_input),
    .bias_in(Bram_bias_input),
    .ReLU_ena(ReLU_ena),
    .ReLU_output(PW_out)
    );
  

reg [18:0] point_base_addr0;
reg [18:0] point_base_addr1;
reg [18:0] point_base_addr2;

//------------data address generation----------------------//
always@(posedge clk) begin
    if((!rst)||frame_end) begin
        point_base_addr0 <= 0;
        point_base_addr1 <= 0;
        point_base_addr2 <= 0;
    end
    else if(Channel_cnt == ifmap_channel-1) begin
        case(Conv33_local_vert_cnt)
            0:
            begin
                point_base_addr0 <= point_base_addr0  + ifmap_channel;
                point_base_addr1 <= point_base_addr1;
                point_base_addr2 <= point_base_addr2;
            end
            1:
            begin
                point_base_addr0 <= point_base_addr0;
                point_base_addr1 <= point_base_addr1 + ifmap_channel;               
                point_base_addr2 <= point_base_addr2;               
            end
            2:
            begin
                point_base_addr0 <= point_base_addr0;
                point_base_addr1 <= point_base_addr1;               
                point_base_addr2 <= point_base_addr2 + ifmap_channel;    
            end
            default:
            begin
                point_base_addr0 <= point_base_addr0;
                point_base_addr1 <= point_base_addr1;               
                point_base_addr2 <= point_base_addr2;    
            end
            endcase
    end
end

//--------- bram write address generation -----------//
assign Bram0_data_addr = ifmap_base_addr + point_base_addr0 + Channel_cnt;
assign Bram1_data_addr = ifmap_base_addr + point_base_addr1 + Channel_cnt;
assign Bram2_data_addr = ifmap_base_addr + point_base_addr2 + Channel_cnt;

//--------- kernel address generation -----------//
assign kernel_addr = Weight_base_addr + Ofmap_channel_cnt;

//--------- bias address generation -------------//

// complete
    
endmodule
