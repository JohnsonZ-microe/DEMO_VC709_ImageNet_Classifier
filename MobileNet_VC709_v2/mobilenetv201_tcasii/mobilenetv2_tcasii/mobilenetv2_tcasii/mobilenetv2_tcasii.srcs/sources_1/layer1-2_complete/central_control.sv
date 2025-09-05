`define ADDR_LAST 7
module central_control(
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
 
 logic [31:0] config_data [0:52][0:`ADDR_LAST];
  
 
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
 	config_data[0][0] =  32'd235;   // M0
 	config_data[0][1] =  32'd0;     // ifmp BRAM base addr
 	config_data[0][2] =  32'd5625;  // ofmp BRAM base addr
 	config_data[0][3] =  32'd0;     // weight BRAM base addr
 	config_data[0][4] =  32'd0;     // M1 BRAM base addr
 	config_data[0][5] =  32'd0;    // SC base addr      
 	config_data[0][6] =  32'b1000000000000000_00000000_01110010;   // [15:8] output zero_point, [7:0] input zero_point
 	config_data[0][7] =  32'b0000000001_00000000100_0000000_1_001; //general config [31:22]: ifmp, [21:11] ofmp_channel, [10:4]: ifmp_size, [3]:has SC, [2]:stride, [1:0]: 00 IDLE 01 CONV 02 DW 03 PW;
	config_data[1][0] =  32'd1518;   // M0
 	config_data[1][1] =  32'd5625;     // ifmp BRAM base addr
 	config_data[1][2] =  32'd11401;  // ofmp BRAM base addr
 	config_data[1][3] =  32'd11;     // weight BRAM base addr
 	config_data[1][4] =  32'd12;     // M1 BRAM base addr
 	config_data[1][5] =  32'd0;    // SC base addr      
 	config_data[1][6] =  32'b1000000000000000_00000000_00000000;   // [15:8] output zero_point, [7:0] input zero_point
 	config_data[1][7] =  32'b0000000100_00000000100_1110000_0_010; //general config [31:22]: ifmp, [21:11] ofmp_channel, [10:4]: ifmp_size, [3]:has SC, [2]:stride, [1:0]: 00 IDLE 01 CONV 02 DW 03 PW;
	config_data[2][0] =  32'd420;   // M0
 	config_data[2][1] =  32'd11401;     // ifmp BRAM base addr
 	config_data[2][2] =  32'd17177;  // ofmp BRAM base addr
 	config_data[2][3] =  32'd15;     // weight BRAM base addr
 	config_data[2][4] =  32'd16;     // M1 BRAM base addr
 	config_data[2][5] =  32'd0;    // SC base addr      
 	config_data[2][6] = 32'b1000000000000000_10000010_00000000;   // [15:8] output zero_point, [7:0] input zero_point
 	config_data[2][7] = 32'b0000000100_00000000010_1110000_0_011; //general config [31:22]: ifmp, [21:11] ofmp_channel, [10:4]: ifmp_size, [3]:has SC, [2]:stride, [1:0]: 00 IDLE 01 CONV 02 DW 03 PW;
	// Add more configurations as needed for cnt_layer from 2 to 52
end
 
 
endmodule
