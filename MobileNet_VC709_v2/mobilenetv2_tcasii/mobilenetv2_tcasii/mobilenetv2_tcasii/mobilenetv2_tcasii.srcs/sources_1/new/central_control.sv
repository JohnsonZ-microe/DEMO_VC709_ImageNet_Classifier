 `define ADDR_LAST 8
(* dont_touch = "true"*)(* keep_hierarchy = "yes" *)module central_control(
/** User Config Register Signal Declaration **/
    input         clk,
    input         rst_n,
    input         ena,
    input         busy,
    input         complete,
    output logic [31:0] reg_config_data_in,    // user config register data input  
    output logic [3:0]  reg_config_addr,       // user config register mapped address                
    output logic        reg_config_valid       // user config register data valid, when asserted, reg_config_data_in was written in corresponding register
 );
 
 
 //            ---------------  FSM  ----------------------  //
 localparam IDLE      = 2'd0;
 localparam CONFIGURE = 2'd1;
 localparam LAYER_CNT = 2'd2;
  

 logic [1:0] current_state;
 logic [1:0] next_state;
 
 logic en_config;
 logic end_config;
 
 logic [31:0] config_data [0:8][0:`ADDR_LAST];
  
 
 always_ff@(posedge clk or negedge rst_n)begin
 	if(!rst_n)
 		current_state <= IDLE;
 	else
 		current_state <= next_state;
 end
 
 always_comb begin
 	next_state = IDLE;
 	unique case(current_state)
 		IDLE:begin
 			if(ena || (~busy))
 				next_state = CONFIGURE;
            else 
                next_state = IDLE;
 		end
 		CONFIGURE:begin
 			if(end_config)
 				next_state = LAYER_CNT;
 			else
 				next_state = CONFIGURE;
 		end
 		LAYER_CNT:begin
            if(complete)
 				next_state = IDLE;
 			else
 				next_state = LAYER_CNT;
 		end
 		default:
 			next_state = IDLE;
 	endcase
 end 
 
 assign end_config = (reg_config_addr == `ADDR_LAST);
 assign en_config  = (current_state == CONFIGURE);
 
 logic [5:0] cnt_layer;
 always_ff@(posedge clk or negedge rst_n)begin
 	if(!rst_n)
 		reg_config_addr <= 'd0;
 	else begin
 		if(en_config)begin
 			if(end_config)
 				reg_config_addr <= 'd0;
 			else
 				reg_config_addr <= reg_config_addr + 1'b1;
 		end
 	end
 end
 
 assign reg_config_valid = en_config;// to be confirmed
 
 always_comb begin
 	reg_config_data_in = (en_config)? config_data[cnt_layer][reg_config_addr] : 0;
 end
 
 always_ff@(posedge clk or negedge rst_n)begin
 	if(!rst_n)
 		cnt_layer <= 'd0;
 	else if(current_state == LAYER_CNT)begin
 		if(cnt_layer == 'd52)
 			cnt_layer <= 'd0;
 		else if(complete)
 			cnt_layer <= cnt_layer + 1'b1;
        else 
            cnt_layer <= cnt_layer;
 	end
 end
 
always_comb begin
 	config_data[0][0] =  32'b1_0000000_00000000_00000000_01100101;    //Zero_points  [31] : ReLU_enable  [23:16] SC_zero_point  [15:8] Output_zero_point [7:0] Input_zero_point
 	config_data[0][1] =  32'd0;      //SC_base_addr                   // [DATA_BRAM_ADDR_WIDTH:1] SC_base_addr   [0]: has_SC
 	config_data[0][2] =  32'd0;      //SC_M2
 	config_data[0][3] =  32'd208;    //M0
 	config_data[0][4] =  32'd0;      //M1 base address register
 	config_data[0][5] =  32'd0;      //Weight base address register
 	config_data[0][6] =  32'd5625;   // Ofmap base address register
 	config_data[0][7] =  32'b0;      //[DATA_BRAM_ADDR_WIDTH-1:0] ifmap_base_addr  
 	config_data[0][8] =  32'b0000000001_00000000100_0000000_1_001;        //General Config  [31:22] ifmap_channel  [21:11] ofmap_channel  [10:4] ifmap_size [3]: stride  [2:0] Mode
 	
 	config_data[1][0] =  32'b1_0000000_00000000_00000000_00000000;    //Zero_points  [31] : ReLU_enable  [23:16] SC_zero_point  [15:8] Output_zero_point [7:0] Input_zero_point
 	config_data[1][1] =  32'd0;      //SC_base_addr                   // [DATA_BRAM_ADDR_WIDTH:1] SC_base_addr   [0]: has_SC
 	config_data[1][2] =  32'd0;      //SC_M2
 	config_data[1][3] =  32'd1518;    //M0
 	config_data[1][4] =  32'd12;      //M1 base address register
 	config_data[1][5] =  32'd12;      //Weight base address register
 	config_data[1][6] =  32'd0;   // Ofmap base address register
 	config_data[1][7] =  32'd5625;      //[DATA_BRAM_ADDR_WIDTH-1:0] ifmap_base_addr  
 	config_data[1][8] =  32'b0000000100_00000000100_1110000_0_010;        //General Config  [31:22] ifmap_channel  [21:11] ofmap_channel  [10:4] ifmap_size [3]: stride  [2:0] Mode
 
 	config_data[2][0] =  32'b0_0000000_00000000_10000010_00000000;    //Zero_points  [31] : ReLU_enable  [23:16] SC_zero_point  [15:8] Output_zero_point [7:0] Input_zero_point
 	config_data[2][1] =  32'd0;      //SC_base_addr                   // [DATA_BRAM_ADDR_WIDTH:1] SC_base_addr   [0]: has_SC
 	config_data[2][2] =  32'd0;      //SC_M2
 	config_data[2][3] =  32'd420;    //M0
 	config_data[2][4] =  32'd16;      //M1 base address register
 	config_data[2][5] =  32'd16;      //Weight base address register
 	config_data[2][6] =  32'd5625;   // Ofmap base address register
 	config_data[2][7] =  32'd0;      //[DATA_BRAM_ADDR_WIDTH-1:0] ifmap_base_addr  
 	config_data[2][8] =  32'b0000000100_00000000010_1110000_0_011;        //General Config  [31:22] ifmap_channel  [21:11] ofmap_channel  [10:4] ifmap_size [3]: stride  [2:0] Mode
 	
 	config_data[3][0] =  32'b1_0000000_00000000_00000000_10000010;    //Zero_points  [31] : ReLU_enable  [23:16] SC_zero_point  [15:8] Output_zero_point [7:0] Input_zero_point
 	config_data[3][1] =  32'd0;      //SC_base_addr                   // [DATA_BRAM_ADDR_WIDTH:1] SC_base_addr   [0]: has_SC
 	config_data[3][2] =  32'd0;      //SC_M2
 	config_data[3][3] =  32'd617;    //M0
 	config_data[3][4] =  32'd18;      //M1 base address register
 	config_data[3][5] =  32'd24;      //Weight base address register
 	config_data[3][6] =  32'd0;   // Ofmap base address register
 	config_data[3][7] =  32'd5625;      //[DATA_BRAM_ADDR_WIDTH-1:0] ifmap_base_addr  
 	config_data[3][8] =  32'b0000000010_00000001011_1110000_0_011;        //General Config  [31:22] ifmap_channel  [21:11] ofmap_channel  [10:4] ifmap_size [3]: stride  [2:0] Mode
 	
    config_data[4][0] =  32'b1_0000000_00000000_00000000_00000000;    //Zero_points  [31] : ReLU_enable  [23:16] SC_zero_point  [15:8] Output_zero_point [7:0] Input_zero_point
    config_data[4][1] =  32'd0;      //SC_base_addr                   // [DATA_BRAM_ADDR_WIDTH:1] SC_base_addr   [0]: has_SC
    config_data[4][2] =  32'd0;      //SC_M2
    config_data[4][3] =  32'd2470;    //M0
    config_data[4][4] =  32'd18+32'd11;      //M1 base address register
    config_data[4][5] =  32'd24+32'd22;      //Weight base address register
    config_data[4][6] =  32'd5625;   // Ofmap base address register
    config_data[4][7] =  32'd0;      //[DATA_BRAM_ADDR_WIDTH-1:0] ifmap_base_addr  
    config_data[4][8] =  32'b0000001011_00000001011_1110000_1_010;        //General Config  [31:22] ifmap_channel  [21:11] ofmap_channel  [10:4] ifmap_size [3]: stride  [2:0] Mode
    
    config_data[5][0] =  32'b0_0000000_00000000_01101111_00000000;    //Zero_points  [31] : ReLU_enable  [23:16] SC_zero_point  [15:8] Output_zero_point [7:0] Input_zero_point
    config_data[5][1] =  32'd0;      //SC_base_addr                   // [DATA_BRAM_ADDR_WIDTH:1] SC_base_addr   [0]: has_SC
    config_data[5][2] =  32'd0;      //SC_M2
    config_data[5][3] =  32'd280;    //M0
    config_data[5][4] =  32'd18+32'd11+32'd11;      //M1 base address register
    config_data[5][5] =  32'd24+32'd22+32'd11;      //Weight base address register
    config_data[5][6] =  32'd4200;   // Ofmap base address register
    config_data[5][7] =  32'd0;      //[DATA_BRAM_ADDR_WIDTH-1:0] ifmap_base_addr  
    config_data[5][8] =  32'b0000001011_00000000011_0111000_0_011;        //General Config  [31:22] ifmap_channel  [21:11] ofmap_channel  [10:4] ifmap_size [3]: stride  [2:0] Mode
  
    config_data[6][0] =  32'b1_0000000_00000000_00000000_01101111;    //Zero_points  [31] : ReLU_enable  [23:16] SC_zero_point  [15:8] Output_zero_point [7:0] Input_zero_point
 	config_data[6][1] =  32'd0;      //SC_base_addr                   // [DATA_BRAM_ADDR_WIDTH:1] SC_base_addr   [0]: has_SC
 	config_data[6][2] =  32'd0;      //SC_M2
 	config_data[6][3] =  32'd804;    //M0
 	config_data[6][4] =  16+2+11+11+3;      //M1 base address register
 	config_data[6][5] =  16+8+22+11+33;      //Weight base address register
 	config_data[6][6] =  32'd5600;   // Ofmap base address register
 	config_data[6][7] =  32'd4200;      //[DATA_BRAM_ADDR_WIDTH-1:0] ifmap_base_addr  
 	config_data[6][8] =  32'b0000000011_00000010000_0111000_0_011;        //General Config  [31:22] ifmap_channel  [21:11] ofmap_channel  [10:4] ifmap_size [3]: stride  [2:0] Mode

    config_data[7][0] =  32'b1_0000000_00000000_00000000_00000000;    //Zero_points  [31] : ReLU_enable  [23:16] SC_zero_point  [15:8] Output_zero_point [7:0] Input_zero_point
 	config_data[7][1] =  32'd0;      //SC_base_addr                   // [DATA_BRAM_ADDR_WIDTH:1] SC_base_addr   [0]: has_SC
 	config_data[7][2] =  32'd0;      //SC_M2
 	config_data[7][3] =  32'd1391;    //M0
 	config_data[7][4] =  16+2+11+11+3+16;      //M1 base address register
 	config_data[7][5] =  16+8+22+11+33+48;      //Weight base address register
 	config_data[7][6] =  32'd0;   // Ofmap base address register
 	config_data[7][7] =  32'd5600;     //[DATA_BRAM_ADDR_WIDTH-1:0] ifmap_base_addr  
 	config_data[7][8] =  32'b0000010000_00000010000_0111000_0_010;        //General Config  [31:22] ifmap_channel  [21:11] ofmap_channel  [10:4] ifmap_size [3]: stride  [2:0] Mode

    config_data[8][0] =  32'b0_0000000_01110101_01110110_00000000;    //Zero_points  [31] : ReLU_enable  [23:16] SC_zero_point  [15:8] Output_zero_point [7:0] Input_zero_point
 	config_data[8][1] =  {31'd0,1'B1};      //SC_base_addr                   // [DATA_BRAM_ADDR_WIDTH:1] SC_base_addr   [0]: has_SC
 	config_data[8][2] =  32'd50126;      //SC_M2
 	config_data[8][3] =  32'd232;    //M0
 	config_data[8][4] =  16+2+11+11+3+16+16;      //M1 base address register
 	config_data[8][5] =  16+8+22+11+33+48+16;      //Weight base address register
 	config_data[8][6] =  32'd4000;   // Ofmap base address register
 	config_data[8][7] =  32'd0;      //[DATA_BRAM_ADDR_WIDTH-1:0] ifmap_base_addr  
 	config_data[8][8] =  32'b0000010001_00000000011_0111000_0_011;        //General Config  [31:22] ifmap_channel  [21:11] ofmap_channel  [10:4] ifmap_size [3]: stride  [2:0] Mode

end
 
 
endmodule
