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
    output logic        reg_config_valid      // user config register data valid, when asserted, reg_config_data_in was written in corresponding register
  );


  //            ---------------  FSM  ----------------------  //
  localparam IDLE      = 2'd0;
  localparam CONFIGURE = 2'd1;
  localparam LAYER_CNT = 2'd2;

  
  logic [1:0] current_state;
  logic [1:0] next_state;

  logic en_config;
  logic end_config;

  logic [31:0] config_data [0:70][0:`ADDR_LAST];


  always_ff@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      current_state <= IDLE;
    else
      current_state <= next_state;
  end

  always_comb
  begin
    next_state = IDLE;
    unique case(current_state)
             IDLE:
             begin
               if(ena || (~busy))
                 next_state = CONFIGURE;
               else
                 next_state = IDLE;
             end
             CONFIGURE:
             begin
               if(end_config)
                 next_state = LAYER_CNT;
               else
                 next_state = CONFIGURE;
             end
             LAYER_CNT:
             begin
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

  logic [6:0] cnt_layer;
  always_ff@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      reg_config_addr <= 'd0;
    else
    begin
      if(en_config)
      begin
        if(end_config)
          reg_config_addr <= 'd0;
        else
          reg_config_addr <= reg_config_addr + 1'b1;
      end
    end
  end

  assign reg_config_valid = en_config;// to be confirmed

  always_comb
  begin
    reg_config_data_in = (en_config)? config_data[cnt_layer][reg_config_addr] : 0;
  end

  always_ff@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
      cnt_layer <= 7'd0;
    else if(current_state == LAYER_CNT)
    begin
      if(cnt_layer == 7'd65)
        cnt_layer <= cnt_layer;
      else if(complete)
        cnt_layer <= cnt_layer + 1'b1;
      else
        cnt_layer <= cnt_layer;
    end
  end
  always_comb
  begin
    //------------------------average pooling test-----------------------//
    // config_data[0][0] =  32'd0;   // M0
    // config_data[0][1] =  32'd0;     // ifmp BRAM base addr
    // config_data[0][2] =  32'd5625;  // ofmp BRAM base addr
    // config_data[0][3] =  32'd0;     // weight BRAM base addr
    // config_data[0][4] =  32'd0;     // M1 BRAM base addr
    // config_data[0][5] =  32'd0;    // SC base addr
    // config_data[0][6] =  32'b0000000000000000_00000000_00000000;   // [15:8] output zero_point, [7:0] input zero_point
    // config_data[0][7] =  32'b0000000001_00000000001_0000111_0_101; 
    //general config [31:22]: ifmp, [21:11] ofmp_channel, [10:4]: ifmp_size,  [3]:stride: 0代表stride=1，1代表stride =2, [2:0]: 00 IDLE 01 CONV 02 DW 03 PW 04 SC 05 AP;
    //------------------------test end-----------------------//
    config_data[0][0] =  32'd235;   // M0
    config_data[0][1] =  32'd0;     // ifmp BRAM base addr
    config_data[0][2] =  32'd5625;  // ofmp BRAM base addr
    config_data[0][3] =  32'd0;     // weight BRAM base addr
    config_data[0][4] =  32'd0;     // M1 BRAM base addr
    config_data[0][5] =  32'd0;    // SC base addr
    config_data[0][6] =  32'b1000000000000000_00000000_01110010;   // [15:8] output zero_point, [7:0] input zero_point
    config_data[0][7] =  32'b0000000001_00000000100_0000000_1_001; //general config [31:22]: ifmp, [21:11] ofmp_channel, [10:4]: ifmp_size,  [3]:stride: 0代表stride=1，1代表stride =2, [2:0]: 00 IDLE 01 CONV 02 DW 03 PW 04 SC;
    //-----------------------shortcut test-----------------------//
    // config_data[1][0] =  32'd2;   // M0
    // config_data[1][1] =  32'd5625;     // ifmp BRAM base addr
    // config_data[1][2] =  32'd11401;  // ofmp BRAM base addr
    // config_data[1][3] =  32'd3;     // weight BRAM base addr // m1
    // config_data[1][4] =  32'd12;     // M1 BRAM base addr
    // config_data[1][5] =  32'd0;    // SC base addr
    // config_data[1][6] =  32'b1000000000000100_00000010_00000001;   // [15:8] output zero_point, [7:0] input zero_point
    // config_data[1][7] =  32'b0000000011_00000000011_0111000_0_100;
    // //----------------------test end-----------------------//
    config_data[1][0] =  32'd1518;   // M0
    config_data[1][1] =  32'd5625;     // ifmp BRAM base addr
    config_data[1][2] =  32'd11401;  // ofmp BRAM base addr
    config_data[1][3] =  32'd11;     // weight BRAM base addr
    config_data[1][4] =  32'd12;     // M1 BRAM base addr
    config_data[1][5] =  32'd0;    // SC base addr
    config_data[1][6] =  32'b1000000000000000_00000000_00000000;   // [15:8] output zero_point, [7:0] input zero_point
    config_data[1][7] =  32'b0000000100_00000000100_1110000_0_010;
    config_data[2][0] =  32'd420;   // M0
    config_data[2][1] =  32'd11401;     // ifmp BRAM base addr
    config_data[2][2] =  32'd17177;  // ofmp BRAM base addr
    config_data[2][3] =  32'd15;     // weight BRAM base addr
    config_data[2][4] =  32'd16;     // M1 BRAM base addr
    config_data[2][5] =  32'd0;    // SC base addr
    config_data[2][6] =  32'b0000000000000000_10000010_00000000;   // [15:8] output zero_point, [7:0] input zero_point
    config_data[2][7] =  32'b0000000100_00000000010_1110000_0_011;
    //layer4 input (16,112,112) output (96,112,112) weight(96,16,1,1)
    config_data[3][0] =  32'd617;   // M0
    config_data[3][1] =  32'd17177;     // ifmp BRAM base addr
    config_data[3][2] =  32'd20065;  // ofmp BRAM base addr
    config_data[3][3] =  32'd23;     // weight BRAM base addr
    config_data[3][4] =  32'd18;     // M1 BRAM base addr
    config_data[3][5] =  32'd0;    // SC base addr
    config_data[3][6] =  32'b1000000000000000_00000000_10000010;   // [15:8] output zero_point, [7:0] input zero_point
    config_data[3][7] =  32'b0000000010_00000001011_1110000_0_011;
    //layer5 input (96,112,112) output (96,56,56) weight(96,1,3,3)
    config_data[4][0] =  32'd2470;   // M0
    config_data[4][1] =  32'd20065;     // ifmp BRAM base addr
    config_data[4][2] =  32'd35949;  // ofmp BRAM base addr
    config_data[4][3] =  32'd45;     // weight BRAM base addr
    config_data[4][4] =  32'd29;     // M1 BRAM base addr
    config_data[4][5] =  32'd0;    // SC base addr
    config_data[4][6] =  32'b1000000000000000_00000000_00000000;   // [15:8] output zero_point, [7:0] input zero_point
    config_data[4][7] =  32'b0000001011_00000001011_1110000_1_010;
    //layer6 input (96,56,56) output (24,56,56) weight(24,96,1,1)
    config_data[5][0] =  32'd280;   // M0
    config_data[5][1] =  32'd35949;     // ifmp BRAM base addr
    config_data[5][2] =  32'd39920;  // ofmp BRAM base addr
    config_data[5][3] =  32'd56;     // weight BRAM base addr
    config_data[5][4] =  32'd40;	 // M1 BRAM base addr
    config_data[5][5] =  32'd0;    // SC base addr	  66
    config_data[5][6] =  32'b0000000000000000_01101111_00000000;   // [15:8] output zero_point, [7:0] input zero_point
    config_data[5][7] =  32'b0000001011_00000000011_0111000_0_011;
    //layer7 input (24,56,56) output (144,56,56) weight(144,24,1,1)
    config_data[6][0] =  32'd804;   // M0
    config_data[6][1] =  32'd39920;     // ifmp BRAM base addr
    config_data[6][2] =  32'd41003;  // ofmp BRAM base addr
    config_data[6][3] =  32'd89;     // weight BRAM base addr
    config_data[6][4] =  32'd43;	 // M1 BRAM base addr
    config_data[6][5] =  32'd0;    // SC base addr
    config_data[6][6] =  32'b1000000000000000_00000000_01101111;   // [15:8] output zero_point, [7:0] input zero_point
    config_data[6][7] =  32'b0000000011_00000010000_0111000_0_011;
    //layer8 input (144,56,56) output (144,56,56) weight(144,1,3,3)
    config_data[7][0] =  32'd1391;   // M0
    config_data[7][1] =  32'd41003;     // ifmp BRAM base addr
    config_data[7][2] =  32'd46779;  // ofmp BRAM base addr
    config_data[7][3] =  32'd137;     // weight BRAM base addr
    config_data[7][4] =  32'd59;	 // M1 BRAM base addr
    config_data[7][5] =  32'd0;    // SC base addr
    config_data[7][6] =  32'b1000000000000000_00000000_00000000;   // [15:8] output zero_point, [7:0] input zero_point
    config_data[7][7] =  32'b0000010000_00000010000_0111000_0_010;
    //layer9 input (144,56,56) output (24,56,56) weight(24,144,1,1)
    config_data[8][0] =  32'd232;   // M0
    config_data[8][1] =  32'd46779;     // ifmp BRAM base addr
    config_data[8][2] =  32'd52555;  // ofmp BRAM base addr
    config_data[8][3] =  32'd153;     // weight BRAM base addr
    config_data[8][4] =  32'd75;	 // M1 BRAM base addr
    config_data[8][5] =  32'd0;    // SC base addr
    config_data[8][6] =  32'b0000000000000000_01110110_00000000;   // [15:8] output zero_point, [7:0] input zero_point
    config_data[8][7] =  32'b0000010000_00000000011_0111000_0_011;
    //layer9 shortcut input (24,56,56) output (24,56,56)
    config_data[9][0] =  32'd48616;   // M0
    config_data[9][1] =  32'd52555;     // ifmp BRAM base addr
    config_data[9][2] =  32'd53638;  // ofmp BRAM base addr
    config_data[9][3] =  32'd50126;     // M1
    config_data[9][4] =  32'd0;
    config_data[9][5] =  32'd39920;    // SC base addr
    config_data[9][6] =  32'b0000000001110101_01110110_01101111;   // [23:16] Sc zero_point [15:8] Fx zero_point, [7:0] x zero_point
    config_data[9][7] =  32'b0000000011_00000000011_0111000_0_100;
    // 层 10（非 Shortcut，对应 document3 非 Shortcut 层 10）
    config_data [10][0] = 32'd754; // M0（document3 非 Shortcut 层 10 的 M0）
    config_data [10][1] = 32'd53638; //ifmp BRAM base addr（上一层 layer9_shortcut 的 start_addr）
    config_data [10][2] = 32'd54721; //ofmp BRAM base addr（当前层 layer10 的 start_addr）
    config_data [10][3] = 32'd201; //weight BRAM base addr（document1 layer10 Weights start）
    config_data [10][4] = 32'd78; // M1 BRAM base addr（document1 layer10 M1 start）
    config_data [10][5] = 32'd0; // SC base addr（非 Shortcut 层为 0）
    config_data [10][6] = 32'b1000000000000000_00000000_01110101; // [15:8] 输出零点 0 (00000000)，[7:0] 输入零点 117 (01110101)
    config_data [10][7] = 32'b0000000011_00000010000_0111000_0_011; // [31:22] ifmp=3 (24/9 向上取整)，[21:11] ofmp_channel=16 (144/9 向上取整)，[10:4] ifmp_size=56 (00111000)，[3] stride=1 (0)，[2:0] PW (011)

    // 层 11（非 Shortcut，对应 document3 非 Shortcut 层 11）
    config_data [11][0] = 32'd2646; // M0（document3 非 Shortcut 层 11 的 M0）
    config_data [11][1] = 32'd54721; //ifmp BRAM base addr（上一层 layer10 的 start_addr）
    config_data [11][2] = 32'd60497; //ofmp BRAM base addr（当前层 layer11 的 start_addr）
    config_data [11][3] = 32'd249; //weight BRAM base addr（document1 layer11 Weights start）
    config_data [11][4] = 32'd94; // M1 BRAM base addr（document1 layer11 M1 start）
    config_data [11][5] = 32'd0; // SC base addr（非 Shortcut 层为 0）
    config_data [11][6] = 32'b1000000000000000_00000000_00000000; // [15:8] 输出零点 0 (00000000)，[7:0] 输入零点 0 (00000000)
    config_data [11][7] = 32'b0000010000_00000010000_0111000_1_010; // [31:22] ifmp=16 (144/9 向上取整)，[21:11] ofmp_channel=16 (144/9 向上取整)，[10:4] ifmp_size=56 (00111000)，[3] stride=2 (1)，[2:0] CONV (010)

    // 层 12（非 Shortcut，对应 document3 非 Shortcut 层 12）
    config_data [12][0] = 32'd200; // M0（document3 非 Shortcut 层 12 的 M0）
    config_data [12][1] = 32'd60497; //ifmp BRAM base addr（上一层 layer11 的 start_addr）
    config_data [12][2] = 32'd62097; //ofmp BRAM base addr（当前层 layer12 的 start_addr）
    config_data [12][3] = 32'd265; //weight BRAM base addr（document1 layer12 Weights start）
    config_data [12][4] = 32'd110; // M1 BRAM base addr（document1 layer12 M1 start）
    config_data [12][5] = 32'd0; // SC base addr（非 Shortcut 层为 0）
    config_data [12][6] = 32'b0000000000000000_10000111_00000000; // [15:8] 输出零点 135 (10000111)，[7:0] 输入零点 0 (00000000)
    config_data [12][7] = 32'b0000010000_00000000100_0011100_0_011; // [31:22] ifmp=16 (144/9 向上取整)，[21:11] ofmp_channel=4 (32/9 向上取整)，[10:4] ifmp_size=28 (00011100)，[3] stride=1 (0)，[2:0] PW (011)

    // 层 13（非 Shortcut，对应 document3 非 Shortcut 层 13）
    config_data [13][0] = 32'd435; // M0（document3 非 Shortcut 层 13 的 M0）
    config_data [13][1] = 32'd62097; //ifmp BRAM base addr（上一层 layer12 的 start_addr）
    config_data [13][2] = 32'd62497; //ofmp BRAM base addr（当前层 layer13 的 start_addr）
    config_data [13][3] = 32'd329; //weight BRAM base addr（document1 layer13 Weights start）
    config_data [13][4] = 32'd114; // M1 BRAM base addr（document1 layer13 M1 start）
    config_data [13][5] = 32'd0; // SC base addr（非 Shortcut 层为 0）
    config_data [13][6] = 32'b1000000000000000_00000000_10000111; // [15:8] 输出零点 0 (00000000)，[7:0] 输入零点 135 (10000111)
    config_data [13][7] = 32'b0000000100_00000010110_0011100_0_011; // [31:22] ifmp=4 (32/9 向上取整)，[21:11] ofmp_channel=22 (192/9 向上取整)，[10:4] ifmp_size=28 (00011100)，[3] stride=1 (0)，[2:0] PW (011)

    // 层 14（非 Shortcut，对应 document3 非 Shortcut 层 14）
    config_data [14][0] = 32'd2525; // M0（document3 非 Shortcut 层 14 的 M0）
    config_data [14][1] = 32'd62497; //ifmp BRAM base addr（上一层 layer13 的 start_addr）
    config_data [14][2] = 32'd64697; //ofmp BRAM base addr（当前层 layer14 的 start_addr）
    config_data [14][3] = 32'd417; //weight BRAM base addr（document1 layer14 Weights start）
    config_data [14][4] = 32'd136; // M1 BRAM base addr（document1 layer14 M1 start）
    config_data [14][5] = 32'd0; // SC base addr（非 Shortcut 层为 0）
    config_data [14][6] = 32'b1000000000000000_00000000_00000000; // [15:8] 输出零点 0 (00000000)，[7:0] 输入零点 0 (00000000)
    config_data [14][7] = 32'b0000010110_00000010110_0011100_0_010; // [31:22] ifmp=22 (192/9 向上取整)，[21:11] ofmp_channel=22 (192/9 向上取整)，[10:4] ifmp_size=28 (00011100)，[3] stride=1 (0)，[2:0] CONV (010)

    // 层 15（非 Shortcut，对应 document3 非 Shortcut 层 15）
    config_data [15][0] = 32'd155; // M0（document3 非 Shortcut 层 15 的 M0）
    config_data [15][1] = 32'd64697; //ifmp BRAM base addr（上一层 layer14 的 start_addr）
    config_data [15][2] = 32'd66897; //ofmp BRAM base addr（当前层 layer15 的 start_addr）
    config_data [15][3] = 32'd439; //weight BRAM base addr（document1 layer15 Weights start）
    config_data [15][4] = 32'd158; // M1 BRAM base addr（document1 layer15 M1 start）
    config_data [15][5] = 32'd0; // SC base addr（非 Shortcut 层为 0）
    config_data [15][6] = 32'b0000000000000000_10000111_00000000; // [15:8] 输出零点 135 (10000111)，[7:0] 输入零点 0 (00000000)
    config_data [15][7] = 32'b0000010110_00000000100_0011100_0_011; // [31:22] ifmp=22 (192/9 向上取整)，[21:11] ofmp_channel=4 (32/9 向上取整)，[10:4] ifmp_size=28 (00011100)，[3] stride=1 (0)，[2:0] PW (011)

    // 层 15 shortcut（对应 document3 Shortcut 层 15）
    config_data [16][0] = 32'd54129; // M0（document3 Shortcut 层 15 的 M0）
    config_data [16][1] = 32'd66897; //ifmp BRAM base addr（上一层 layer15 的 start_addr）
    config_data [16][2] = 32'd67297; //ofmp BRAM base addr（当前层 layer15_shortcut 的 start_addr）
    config_data [16][3] = 32'd47002; // M1（document3 Shortcut 层 15 的 M1，Shortcut 层无 weight，填 M1）
    config_data [16][4] = 32'd0; // Shortcut 层无 M1 BRAM，填 0
    config_data [16][5] = 32'd62097; // SC base addr（前面第三层 13 的 start_addr）
    config_data [16][6] = 32'b0000000010000000_10000111_10000111; // [23:16] SC 零点 128 (10000000)，[15:8] FX 零点 135 (10000111)，[7:0] x 零点 135 (10000111)
    config_data [16][7] = 32'b0000000100_00000000100_0011100_0_100; // [31:22] ifmp=4 (32/9 向上取整)，[21:11] ofmp_channel=4 (32/9 向上取整)，[10:4] ifmp_size=28 (00011100)，[3] stride=1 (0)，[2:0] SC (100)

    // 层 16（非 Shortcut，对应 document3 非 Shortcut 层 16）
    config_data [17][0] = 32'd478; // M0（document3 非 Shortcut 层 16 的 M0）
    config_data [17][1] = 32'd67297; //ifmp BRAM base addr（上一层 layer15_shortcut 的 start_addr）
    config_data [17][2] = 32'd67697; //ofmp BRAM base addr（当前层 layer16 的 start_addr）
    config_data [17][3] = 32'd527; //weight BRAM base addr（document1 layer16 Weights start）
    config_data [17][4] = 32'd162; // M1 BRAM base addr（document1 layer16 M1 start）
    config_data [17][5] = 32'd0; // SC base addr（非 Shortcut 层为 0）
    config_data [17][6] = 32'b1000000000000000_00000000_10000000; // [15:8] 输出零点 0 (00000000)，[7:0] 输入零点 128 (10000000)
    config_data [17][7] = 32'b0000000100_00000010110_0011100_0_011; // [31:22] ifmp=4 (32/9 向上取整)，[21:11] ofmp_channel=22 (192/9 向上取整)，[10:4] ifmp_size=28 (00011100)，[3] stride=1 (0)，[2:0] PW (011)

    // 层 17（非 Shortcut，对应 document3 非 Shortcut 层 17）
    config_data [18][0] = 32'd1630; // M0（document3 非 Shortcut 层 17 的 M0）
    config_data [18][1] = 32'd67697; //ifmp BRAM base addr（上一层 layer16 的 start_addr）
    config_data [18][2] = 32'd69897; //ofmp BRAM base addr（当前层 layer17 的 start_addr）
    config_data [18][3] = 32'd615; //weight BRAM base addr（document1 layer17 Weights start）
    config_data [18][4] = 32'd184; // M1 BRAM base addr（document1 layer17 M1 start）
    config_data [18][5] = 32'd0; // SC base addr（非 Shortcut 层为 0）
    config_data [18][6] = 32'b1000000000000000_00000000_00000000; // [15:8] 输出零点 0 (00000000)，[7:0] 输入零点 0 (00000000)
    config_data [18][7] = 32'b0000010110_00000010110_0011100_0_010; // [31:22] ifmp=22 (192/9 向上取整)，[21:11] ofmp_channel=22 (192/9 向上取整)，[10:4] ifmp_size=28 (00011100)，[3] stride=1 (0)，[2:0] CONV (010)

    // 层 18（非 Shortcut，对应 document3 非 Shortcut 层 18）
    config_data [19][0] = 32'd198; // M0（document3 非 Shortcut 层 18 的 M0）
    config_data [19][1] = 32'd69897; //ifmp BRAM base addr（上一层 layer17 的 start_addr）
    config_data [19][2] = 32'd72097; //ofmp BRAM base addr（当前层 layer18 的 start_addr）
    config_data [19][3] = 32'd637; //weight BRAM base addr（document1 layer18 Weights start）
    config_data [19][4] = 32'd206; // M1 BRAM base addr（document1 layer18 M1 start）
    config_data [19][5] = 32'd0; // SC base addr（非 Shortcut 层为 0）
    config_data [19][6] = 32'b0000000000000000_10000011_00000000; // [15:8] 输出零点 131 (10000011)，[7:0] 输入零点 0 (00000000)
    config_data [19][7] = 32'b0000010110_00000000100_0011100_0_011; // [31:22] ifmp=22 (192/9 向上取整)，[21:11] ofmp_channel=4 (32/9 向上取整)，[10:4] ifmp_size=28 (00011100)，[3] stride=1 (0)，[2:0] PW (011)

    // 层 18 shortcut（对应 document3 Shortcut 层 18）
    config_data [20][0] = 32'd55355; // M0（document3 Shortcut 层 18 的 M0）
    config_data [20][1] = 32'd72097; //ifmp BRAM base addr（上一层 layer18 的 start_addr）
    config_data [20][2] = 32'd72497; //ofmp BRAM base addr（当前层 layer18_shortcut 的 start_addr）
    config_data [20][3] = 32'd36484; // M1（document3 Shortcut 层 18 的 M1，Shortcut 层无 weight，填 M1）
    config_data [20][4] = 32'd0; // Shortcut 层无 M1 BRAM，填 0
    config_data [20][5] = 32'd67297; // SC base addr
    config_data [20][6] = 32'b0000000010000100_10000011_10000000; // [23:16] SC 零点 132 (10000100)，[15:8] FX 零点 131 (10000011)，[7:0] x 零点 128 (10000000)
    config_data [20][7] = 32'b0000000100_00000000100_0011100_0_100; // [31:22] ifmp=4 (32/9 向上取整)，[21:11] ofmp_channel=4 (32/9 向上取整)，[10:4] ifmp_size=28 (00011100)，[3] stride=1 (0)，[2:0] SC (100)

    // 层 19（非 Shortcut，对应 document3 非 Shortcut 层 19）
    config_data [21][0] = 32'd550; // M0（document3 非 Shortcut 层 19 的 M0）
    config_data [21][1] = 32'd72497; //ifmp BRAM base addr（上一层 layer18_shortcut 的 start_addr）
    config_data [21][2] = 32'd72897; //ofmp BRAM base addr（当前层 layer19 的 start_addr）
    config_data [21][3] = 32'd725; //weight BRAM base addr（document1 layer19 Weights start）
    config_data [21][4] = 32'd210; // M1 BRAM base addr（document1 layer19 M1 start）
    config_data [21][5] = 32'd0; // SC base addr（非 Shortcut 层为 0）
    config_data [21][6] = 32'b1000000000000000_00000000_10000100; // [15:8] 输出零点 0 (00000000)，[7:0] 输入零点 132 (10000100)
    config_data [21][7] = 32'b0000000100_00000010110_0011100_0_011; // [31:22] ifmp=4 (32/9 向上取整)，[21:11] ofmp_channel=22 (192/9 向上取整)，[10:4] ifmp_size=28 (00011100)，[3] stride=1 (0)，[2:0] PW (011)

    // 层 20（非 Shortcut，对应 document3 非 Shortcut 层 20）
    config_data [22][0] = 32'd920; // M0（document3 非 Shortcut 层 20 的 M0）
    config_data [22][1] = 32'd72897; //ifmp BRAM base addr（上一层 layer19 的 start_addr）
    config_data [22][2] = 32'd75097; //ofmp BRAM base addr（当前层 layer20 的 start_addr）
    config_data [22][3] = 32'd813; //weight BRAM base addr（document1 layer20 Weights start）
    config_data [22][4] = 32'd232; // M1 BRAM base addr（document1 layer20 M1 start）
    config_data [22][5] = 32'd0; // SC base addr（非 Shortcut 层为 0）
    config_data [22][6] = 32'b1000000000000000_00000000_00000000; // [15:8] 输出零点 0 (00000000)，[7:0] 输入零点 0 (00000000) 0000)
    config_data [22][7] = 32'b0000010110_00000010110_0011100_1_010; // [31:22] ifmp=22 (192/9 向上取整)，[21:11] ofmp_channel=22 (192/9 向上取整)，[10:4] ifmp_size=28 (00011100)，[3] stride=2 (1)，[2:0] CONV (010)

    // 层 21（非 Shortcut，对应 document3 非 Shortcut 层 21）
    config_data [23][0] = 32'd184; // M0（document3 非 Shortcut 层 21 的 M0）
    config_data [23][1] = 32'd75097; //ifmp BRAM base addr（上一层 layer20 的 start_addr）
    config_data [23][2] = 32'd75647; //ofmp BRAM base addr（当前层 layer21 的 start_addr）
    config_data [23][3] = 32'd835; //weight BRAM base addr（document1 layer21 Weights start）
    config_data [23][4] = 32'd254; // M1 BRAM base addr（document1 layer21 M1 start）
    config_data [23][5] = 32'd0; // SC base addr（非 Shortcut 层为 0）
    config_data [23][6] = 32'b0000000000000000_10000110_00000000; // [15:8] 输出零点 134 (10000110)，[7:0] 输入零点 0 (00000000)
    config_data [23][7] = 32'b0000010110_00000001000_0001110_0_011; // [31:22] ifmp=22 (192/9 向上取整)，[21:11] ofmp_channel=8 (64/9 向上取整)，[10:4] ifmp_size=14 (00001110)，[3] stride=1 (0)，[2:0] PW (011)

    // 层 22（非 Shortcut，对应 document3 非 Shortcut 层 22）
    config_data [24][0] = 32'd437; // M0（document3 非 Shortcut 层 22 的 M0）
    config_data [24][1] = 32'd75647; //ifmp BRAM base addr（上一层 layer21 的 start_addr）
    config_data [24][2] = 32'd75847; //ofmp BRAM base addr（当前层 layer22 的 start_addr）
    config_data [24][3] = 32'd1011; //weight BRAM base addr（document1 layer22 Weights start）
    config_data [24][4] = 32'd262; // M1 BRAM base addr（document1 layer22 M1 start）
    config_data [24][5] = 32'd0; // SC base addr（非 Shortcut 层为 0）
    config_data [24][6] = 32'b1000000000000000_00000000_10000110; // [15:8] 输出零点 0 (00000000)，[7:0] 输入零点 134 (10000110)
    config_data [24][7] = 32'b0000001000_00000101011_0001110_0_011; // [31:22] ifmp=8 (64/9 向上取整)，[21:11] ofmp_channel=43 (384/9 向上取整)，[10:4] ifmp_size=14 (00001110)，[3] stride=1 (0)，[2:0] PW (011)

    // 层 23（非 Shortcut，对应 document3 非 Shortcut 层 23）
    config_data [25][0] = 32'd1786; // M0（document3 非 Shortcut 层 23 的 M0）
    config_data [25][1] = 32'd75847; //ifmp BRAM base addr（上一层 layer22 的 start_addr）
    config_data [25][2] = 32'd76922; //ofmp BRAM base addr（当前层 layer23 的 start_addr）
    config_data [25][3] = 32'd1355; //weight BRAM base addr（document1 layer23 Weights start）
    config_data [25][4] = 32'd305; // M1 BRAM base addr（document1 layer23 M1 start）
    config_data [25][5] = 32'd0; // SC base addr（非 Shortcut 层为 0）
    config_data [25][6] = 32'b1000000000000000_00000000_00000000; // [15:8] 输出零点 0 (00000000)，[7:0] 输入零点 0 (00000000)
    config_data [25][7] = 32'b0000101011_00000101011_0001110_0_010; // [31:22] ifmp=43 (384/9 向上取整)，[21:11] ofmp_channel=43 (384/9 向上取整)，[10:4] ifmp_size=14 (00001110)，[3] stride=1 (0)，[2:0] CONV (010)

    // 层 24（非 Shortcut，对应 document3 非 Shortcut 层 24）
    config_data [26][0] = 32'd141; // M0（document3 非 Shortcut 层 24 的 M0）
    config_data [26][1] = 32'd76922; //ifmp BRAM base addr（上一层 layer23 的 start_addr）
    config_data [26][2] = 32'd77997; //ofmp BRAM base addr（当前层 layer24 的 start_addr）
    config_data [26][3] = 32'd1398; //weight BRAM base addr（document1 layer24 Weights start）
    config_data [26][4] = 32'd348; // M1 BRAM base addr（document1 layer24 M1 start）
    config_data [26][5] = 32'd0; // SC base addr（非 Shortcut 层为 0）
    config_data [26][6] = 32'b0000000000000000_10000011_00000000; // [15:8] 输出零点 131 (10000011)，[7:0] 输入零点 0 (00000000)
    config_data [26][7] = 32'b0000101011_00000001000_0001110_0_011; // [31:22] ifmp=43 (384/9 向上取整)，[21:11] ofmp_channel=8 (64/9 向上取整)，[10:4] ifmp_size=14 (00001110)，[3] stride=1 (0)，[2:0] PW (011)

    // 层 24 shortcut（对应 document3 Shortcut 层 24）
    config_data [27][0] = 32'd61530; // M0（document3 Shortcut 层 24 的 M0）
    config_data [27][1] = 32'd77997; //ifmp BRAM base addr（上一层 layer24 的 start_addr）
    config_data [27][2] = 32'd78197; //ofmp BRAM base addr（当前层 layer24_shortcut 的 start_addr）
    config_data [27][3] = 32'd44497; // M1（document3 Shortcut 层 24 的 M1，Shortcut 层无 weight，填 M1）
    config_data [27][4] = 32'd0; // Shortcut 层无 M1 BRAM，填 0
    config_data [27][5] = 32'd75647; // SC base addr
    config_data [27][6] = 32'b0000000010000001_10000011_10000110; // [23:16] SC 零点 129 (10000001)，[15:8] FX 零点 131 (10000011)，[7:0] x 零点 134 (10000110)
    config_data [27][7] = 32'b0000001000_00000001000_0001110_0_100; // [31:22] ifmp=8 (64/9 向上取整)，[21:11] ofmp_channel=8 (64/9 向上取整)，[10:4] ifmp_size=14 (00001110)，[3] stride=1 (0)，[2:0] SC (100)

    // 层 25（非 Shortcut，对应 document3 非 Shortcut 层 25）
    config_data [28][0] = 32'd362; // M0（document3 非 Shortcut 层 25 的 M0）
    config_data [28][1] = 32'd78197; //ifmp BRAM base addr（上一层 layer24_shortcut 的 start_addr）
    config_data [28][2] = 32'd78397; //ofmp BRAM base addr（当前层 layer25 的 start_addr）
    config_data [28][3] = 32'd1742; //weight BRAM base addr（document1 layer25 Weights start）
    config_data [28][4] = 32'd356; // M1 BRAM base addr（document1 layer25 M1 start）
    config_data [28][5] = 32'd0; // SC base addr（非 Shortcut 层为 0）
    config_data [28][6] = 32'b1000000000000000_00000000_10000001; // [15:8] 输出零点 0 (00000000)，[7:0] 输入零点 129 (10000001)
    config_data [28][7] = 32'b0000001000_00000101011_0001110_0_011; // [31:22] ifmp=8 (64/9 向上取整)，[21:11] ofmp_channel=43 (384/9 向上取整)，[10:4] ifmp_size=14 (00001110)，[3] stride=1 (0)，[2:0] PW (011)

    // 层 26（非 Shortcut，对应 document3 非 Shortcut 层 26）
    config_data [29][0] = 32'd3662; // M0（document3 非 Shortcut 层 26 的 M0）
    config_data [29][1] = 32'd78397; //ifmp BRAM base addr（上一层 layer25 的 start_addr）
    config_data [29][2] = 32'd79472; //ofmp BRAM base addr（当前层 layer26 的 start_addr）
    config_data [29][3] = 32'd2086; //weight BRAM base addr（document1 layer26 Weights start）
    config_data [29][4] = 32'd399; // M1 BRAM base addr（document1 layer26 M1 start）
    config_data [29][5] = 32'd0; // SC base addr（非 Shortcut 层为 0）
    config_data [29][6] = 32'b1000000000000000_00000000_00000000; // [15:8] 输出零点 0 (00000000)，[7:0] 输入零点 0 (00000000)
    config_data [29][7] = 32'b0000101011_00000101011_0001110_0_010; // [31:22] ifmp=43 (384/9 向上取整)，[21:11] ofmp_channel=43 (384/9 向上取整)，[10:4] ifmp_size=14 (00001110)，[3] stride=1 (0)，[2:0] CONV (010)

    // 层 27（非 Shortcut，对应 document3 非 Shortcut 层 27）
    config_data [30][0] = 32'd162; // M0（document3 非 Shortcut 层 27 的 M0）
    config_data [30][1] = 32'd79472; //ifmp BRAM base addr（上一层 layer26 的 start_addr）
    config_data [30][2] = 32'd80547; //ofmp BRAM base addr（当前层 layer27 的 start_addr）
    config_data [30][3] = 32'd2129; //weight BRAM base addr（document1 layer27 Weights start）
    config_data [30][4] = 32'd442; // M1 BRAM base addr（document1 layer27 M1 start）
    config_data [30][5] = 32'd0; // SC base addr（非 Shortcut 层为 0）
    config_data [30][6] = 32'b0000000000000000_10001001_00000000; // [15:8] 输出零点 137 (10001001)，[7:0] 输入零点 0 (00000000)
    config_data [30][7] = 32'b0000101011_00000001000_0001110_0_011; // [31:22] ifmp=43 (384/9 向上取整)，[21:11] ofmp_channel=8 (64/9 向上取整)，[10:4] ifmp_size=14 (00001110)，[3] stride=1 (0)，[2:0] PW (011)

    // 层 27 shortcut（对应 document3 Shortcut 层 27）
    config_data [31][0] = 32'd62344; // M0（document3 Shortcut 层 27 的 M0）
    config_data [31][1] = 32'd80547; //ifmp BRAM base addr（上一层 layer27 的 start_addr）
    config_data [31][2] = 32'd80747; //ofmp BRAM base addr（当前层 layer27_shortcut 的 start_addr）
    config_data [31][3] = 32'd33175; // M1（document3 Shortcut 层 27 的 M1，Shortcut 层无 weight，填 M1）
    config_data [31][4] = 32'd0; // Shortcut 层无 M1 BRAM，填 0
    config_data [31][5] = 32'd78197; // SC base addr
    config_data [31][6] = 32'b0000000010000001_10001001_10000001; // [23:16] SC 零点 129 (10000001)，[15:8] FX 零点 137 (10001001)，[7:0] x 零点 129 (10000001)
    config_data [31][7] = 32'b0000001000_00000001000_0001110_0_100; // [31:22] ifmp=8 (64/9 向上取整)，[21:11] ofmp_channel=8 (64/9 向上取整)，[10:4] ifmp_size=14 (00001110)，[3] stride=1 (0)，[2:0] SC (100)

	// layer 28 input (64,14,14) output (384,14,14) 
	config_data[32][0] = 32'd347; // M0
	config_data[32][1] = 32'd80747; // ifmp BRAM base addr
	config_data[32][2] = 32'd80947; // ofmp BRAM base addr
	config_data[32][3] = 32'd2473; // weight BRAM base addr
	config_data[32][4] = 32'd450; // M1 BRAM base addr
	config_data[32][5] = 32'd0; // SC base addr
	config_data[32][6] = 32'b1000000000000000_00000000_10000001; // [15:8] output zero，[7:0] input zero
	config_data[32][7] = 32'b0000001000_00000101011_0001110_0_011; 
	//general config [31:22]: ifmp, [21:11] ofmp_channel, [10:4]: ifmp_size,  [3]:stride: 0代表stride=1，1代表stride =2, [2:0]: 00 IDLE 01 CONV 02 DW 03 PW 04 SC;

	//layer 29 input (384,14,14) output (384,14,14)
	config_data[33][0] = 32'd745; // M0
	config_data[33][1] = 32'd80947; // ifmp BRAM base addr
	config_data[33][2] = 32'd82022; // ofmp BRAM base addr
	config_data[33][3] = 32'd2817; // weight BRAM base
	config_data[33][4] = 32'd493; // M1 BRAM base addr
	config_data[33][5] = 32'd0; // SC base addr
	config_data[33][6] = 32'b1000000000000000_00000000_00000000; // [15:8] output zero，[7:0] input zero
	config_data[33][7] = 32'b0000101011_00000101011_0001110_0_010; 
	//general config [31:22]: ifmp, [21:11] ofmp_channel, [10:4]: ifmp_size,  [3]:stride: 0代表stride=1，1代表stride =2, [2:0]: 00 IDLE 01 CONV 02 DW 03 PW 04 SC;

	//layer 30 input (384,14,14) output (64,14,14)
	config_data[34][0] = 32'd256; // M0
	config_data[34][1] = 32'd82022; // ifmp BRAM base addr
	config_data[34][2] = 32'd83097; // ofmp BRAM
	config_data[34][3] = 32'd2860; // weight BRAM base
	config_data[34][4] = 32'd536; // M1 BRAM base addr
	config_data[34][5] = 32'd0; // SC base addr
	config_data[34][6] = 32'b0000000000000000_10011110_00000000; // [15:8] output zero，[7:0] input zero
	config_data[34][7] = 32'b0000101011_00000001000_0001110_0_011; 
	//general config [31:22]: ifmp, [21:11] ofmp_channel, [10:4]: ifmp_size,  [3]:stride: 0代表stride=1，1代表stride =2, [2:0]: 00 IDLE 01 CONV 02 DW 03 PW 04 SC;

	//layer 30 shortcut input (64,14,14) output (64,14,14)
	config_data[35][0] = 32'd62183; // M0
	config_data[35][1] = 32'd83097; // ifmp BRAM base addr
	config_data[35][2] = 32'd83297; // ofmp BRAM base addr
	config_data[35][3] = 32'd53492; // M1 
	config_data[35][4] = 32'd0; // 
	config_data[35][5] = 32'd80747; // SC base addr
	config_data[35][6] = 32'b0000000010000010_10011110_10000001; // [23:16] SC zero，[15:8] FX zero，[7:0] x zero
	config_data[35][7] = 32'b0000001000_00000001000_0001110_0_100; 
	//general config [31:22]: ifmp, [21:11] ofmp_channel, [10:4]: ifmp_size,  [3]:stride: 0代表stride=1，1代表stride =2, [2:0]: 00 IDLE 01 CONV 02 DW 03 PW 04 SC;

	//layer 31 input (64,14,14) output (384,14,14)
	config_data[36][0] = 32'd371; // M0
	config_data[36][1] = 32'd83297; // ifmp BRAM base addr
	config_data[36][2] = 32'd83497; // ofmp BRAM base addr
	config_data[36][3] = 32'd3204; // weight BRAM base addr
	config_data[36][4] = 32'd544; // M1 BRAM base addr
	config_data[36][5] = 32'd0; // SC base addr
	config_data[36][6] = 32'b1000000000000000_00000000_10000010; // [15:8] output zero，[7:0] input zero
	config_data[36][7] = 32'b0000001000_00000101011_0001110_0_011; 
	//general config [31:22]: ifmp, [21:11] ofmp_channel, [10:4]: ifmp_size,  [3]:stride: 0代表stride=1，1代表stride =2, [2:0]: 00 IDLE 01 CONV 02 DW 03

	//layer 32 input (384,14,14) output (384,14,14)
	config_data[37][0] = 32'd1781; // M0
	config_data[37][1] = 32'd83497; // ifmp BRAM base addr
	config_data[37][2] = 32'd84572; // ofmp BRAM base addr
	config_data[37][3] = 32'd3548; // weight BRAM base addr
	config_data[37][4] = 32'd587; // M1 BRAM base addr
	config_data[37][5] = 32'd0; // SC base addr
	config_data[37][6] = 32'b1000000000000000_00000000_00000000; // [15:8] output zero，[7:0] input zero
	config_data[37][7] = 32'b0000101011_00000101011_0001110_0_010; 
	//general config [31:22]: ifmp, [21:11] ofmp_channel, [10:4]: ifmp_size,  [3]:stride: 0代表stride=1，1代表stride =2, [2:0]: 00 IDLE 01 CONV 02 DW 03 PW 04 SC;

	//layer 33 input (384,14,14) output (96,14,14)
	config_data[38][0] = 32'd142; // M0
	config_data[38][1] = 32'd84572; // ifmp BRAM base addr
	config_data[38][2] = 32'd85647; // ofmp BRAM base addr
	config_data[38][3] = 32'd3591; // weight BRAM base addr
	config_data[38][4] = 32'd630; // M1 BRAM base addr
	config_data[38][5] = 32'd0; // SC base addr
	config_data[38][6] = 32'b0000000000000000_10000001_00000000; // [15:8] output zero，[7:0] input zero
	config_data[38][7] = 32'b0000101011_00000001011_0001110_0_011; 
	//general config [31:22]: ifmp, [21:11] ofmp_channel, [10:4]: ifmp_size,  [3]:stride: 0代表stride=1，1代表stride =2, [2:0]: 00 IDLE 01 CONV 02 DW 03 PW 04 SC;

	//layer 34 input (96,14,14) output (576,14,14)
	config_data[39][0] = 32'd348; // M0
	config_data[39][1] = 32'd85647; // ifmp BRAM base addr
	config_data[39][2] = 32'd85922; // ofmp BRAM base addr
	config_data[39][3] = 32'd4064; // weight BRAM base addr
	config_data[39][4] = 32'd641; // M1 BRAM base addr
	config_data[39][5] = 32'd0; // SC base addr
	config_data[39][6] = 32'b1000000000000000_00000000_10000001; // [15:8] output zero，[7:0] input zero
	config_data[39][7] = 32'b0000001011_00001000000_0001110_0_011; 
	//general config [31:22]: ifmp, [21:11] ofmp_channel, [10:4]: ifmp_size,  [3]:stride: 0代表stride=1，1代表stride =2, [2:0]: 00 IDLE 01 CONV 02 DW 03 PW 04 SC;

	//layer 35 input (576,14,14) output (576,14,14)
	config_data[40][0] = 32'd2390; // M0
	config_data[40][1] = 32'd85922; // ifmp BRAM base addr
	config_data[40][2] = 32'd87522; // ofmp BRAM base addr
	config_data[40][3] = 32'd4768; // weight BRAM base addr
	config_data[40][4] = 32'd705; // M1 BRAM base addr
	config_data[40][5] = 32'd0; // SC base addr
	config_data[40][6] = 32'b1000000000000000_00000000_00000000; // [15:8] output zero，[7:0] input zero
	config_data[40][7] = 32'b0001000000_00001000000_0001110_0_010; 
	//general config [31:22]: ifmp, [21:11] ofmp_channel, [10:4]: ifmp_size,  [3]:stride: 0代表stride=1，1代表stride =2, [2:0]: 00 IDLE 01 CONV 02 DW 03 PW 04 SC;

	//layer 36 input (576,14,14) output (96,14,14)
	config_data[41][0] = 32'd205; // M0
	config_data[41][1] = 32'd87522; // ifmp BRAM base addr
	config_data[41][2] = 32'd89122; // ofmp BRAM base addr
	config_data[41][3] = 32'd4832; // weight BRAM base addr
	config_data[41][4] = 32'd769; // M1 BRAM base addr
	config_data[41][5] = 32'd0; // SC base addr
	config_data[41][6] = 32'b0000000000000000_10000011_00000000; // [15:8] output zero，[7:0] input zero
	config_data[41][7] = 32'b0001000000_00000001011_0001110_0_011; 
	//general config [31:22]: ifmp, [21:11] ofmp_channel, [10:4]: ifmp_size,  [3]:stride: 0代表stride=1，1代表stride =2, [2:0]: 00 IDLE 01 CONV 02 DW 03 PW 04 SC;

	//layer 36 shortcut input (96,14,14) output (96,14,14)
	config_data[42][0] = 32'd56595; // M0
	config_data[42][1] = 32'd89122; // ifmp BRAM base addr
	config_data[42][2] = 32'd89397; // ofmp BRAM base addr
	config_data[42][3] = 32'd42082; // M1 
	config_data[42][4] = 32'd0; // 
	config_data[42][5] = 32'd85647; // SC base addr
	config_data[42][6] = 32'b0000000001111101_10000011_10000001; // [23:16] SC zero，[15:8] FX zero，[7:0] x zero
	config_data[42][7] = 32'b0000001011_00000001011_0001110_0_100;
	//general config [31:22]: ifmp, [21:11] ofmp_channel, [10:4]: ifmp_size,  [3]:stride: 0代表stride=1，1代表stride =2, [2:0]: 00 IDLE 01 CONV 02 DW 03 PW 04 SC;

	//layer 37 input (96,14,14) output (576,14,14)
	config_data[43][0] = 32'd302; // M0
	config_data[43][1] = 32'd89397; // ifmp BRAM base addr
	config_data[43][2] = 32'd89672; // ofmp BRAM base addr
	config_data[43][3] = 32'd5536; // weight BRAM base addr
	config_data[43][4] = 32'd780; // M1 BRAM base addr
	config_data[43][5] = 32'd0; // SC base addr
	config_data[43][6] = 32'b1000000000000000_00000000_01111101; // [15:8] output zero，[7:0] input zero
	config_data[43][7] = 32'b0000001011_00001000000_0001110_0_011; 
	//general config [31:22]: ifmp, [21:11] ofmp_channel, [10:4]: ifmp_size,  [3]:stride: 0代表stride=1，1代表stride =2, [2:0]: 00 IDLE 01 CONV 02 DW 03 PW 04 SC;

	//layer 38 input (576,14,14) output (576,14,14)
	config_data[44][0] = 32'd3143; // M0
	config_data[44][1] = 32'd89672; // ifmp BRAM base addr
	config_data[44][2] = 32'd91272; // ofmp BRAM base addr
	config_data[44][3] = 32'd6240; // weight BRAM base addr
	config_data[44][4] = 32'd844; // M1 BRAM base addr
	config_data[44][5] = 32'd0; // SC base addr
	config_data[44][6] = 32'b1000000000000000_00000000_00000000; // [15:8] output zero，[7:0] input zero
	config_data[44][7] = 32'b0001000000_00001000000_0001110_0_010; 
	//general config [31:22]: ifmp, [21:11] ofmp_channel, [10:4]: ifmp_size,  [3]:stride: 0代表stride=1，1代表stride =2, [2:0]: 00 IDLE 01 CONV 02 DW 03 PW 04 SC;

	//layer 39 input (576,14,14) output (96,14,14)
	config_data[45][0] = 32'd294; // M0
	config_data[45][1] = 32'd91272; // ifmp BRAM base addr
	config_data[45][2] = 32'd92872; // ofmp BRAM base addr
	config_data[45][3] = 32'd6304; // weight BRAM base addr
	config_data[45][4] = 32'd908; // M1 BRAM base addr
	config_data[45][5] = 32'd0; // SC base addr
	config_data[45][6] = 32'b0000000000000000_10001001_00000000; // [15:8] output zero，[7:0] input zero
	config_data[45][7] = 32'b0001000000_00000001011_0001110_0_011; 
	//general config [31:22]: ifmp, [21:11] ofmp_channel, [10:4]: ifmp_size,  [3]:stride: 0代表stride=1，1代表stride =2, [2:0]: 00 IDLE 01 CONV 02 DW 03 PW 04 SC;

	//layer 39 shortcut input (96,14,14) output (96,14,14)
	config_data[46][0] = 32'd47643; // M0
	config_data[46][1] = 32'd92872; // ifmp BRAM base addr
	config_data[46][2] = 32'd93147; // ofmp	 BRAM base addr
	config_data[46][3] = 32'd53372; // M1 
	config_data[46][4] = 32'd0; // 
	config_data[46][5] = 32'd89397; // SC base addr
	config_data[46][6] = 32'b0000000001110100_10001001_01111101; // [23:16] SC zero，[15:8] FX zero，[7:0] x zero
	config_data[46][7] = 32'b0000001011_00000001011_0001110_0_100;
	//general config [31:22]: ifmp, [21:11] ofmp_channel, [10:4]: ifmp_size,  [3]:stride: 0代表stride=1，1代表stride =2, [2:0]: 00 IDLE 01 CONV 02 DW 03 PW 04 SC;

	//layer 40 input (96,14,14) output (576,14,14)
	config_data[47][0] = 32'd412; // M0
	config_data[47][1] = 32'd93147; // ifmp BRAM base addr
	config_data[47][2] = 32'd93422; // ofmp BRAM base addr
	config_data[47][3] = 32'd7008; // weight BRAM base addr
	config_data[47][4] = 32'd919; // M1 BRAM base addr
	config_data[47][5] = 32'd0; // SC base addr
	config_data[47][6] = 32'b1000000000000000_00000000_01110100; // [15:8] output zero，[7:0] input zero
	config_data[47][7] = 32'b0000001011_00001000000_0001110_0_011; 
	//general config [31:22]: ifmp, [21:11] ofmp_channel, [10:4]: ifmp_size,  [3]:stride: 0代表stride=1，1代表stride =2, [2:0]: 00 IDLE 01 CONV 02 DW 03 PW 04 SC;

	//layer 41 input (576,14,14) output (576,7,7)
	config_data[48][0] = 32'd710; // M0
	config_data[48][1] = 32'd93422; // ifmp BRAM base addr
	config_data[48][2] = 32'd95022; // ofmp BRAM base addr
	config_data[48][3] = 32'd7712; // weight BRAM base addr
	config_data[48][4] = 32'd983; // M1 BRAM base addr
	config_data[48][5] = 32'd0; // SC base addr
	config_data[48][6] = 32'b1000000000000000_00000000_00000000; // [15:8] output zero，[7:0] input zero
	config_data[48][7] = 32'b0001000000_00001000000_0001110_1_010; 
	//general config [31:22]: ifmp, [21:11] ofmp_channel, [10:4]: ifmp_size,  [3]:stride: 0代表stride=1，1代表stride =2, [2:0]: 00 IDLE 01 CONV 02 DW 03 PW 04 SC;

	//layer 42 input (576,7,7) output (160,7,7)
	config_data[49][0] = 32'd75; // M0
	config_data[49][1] = 32'd95022; // ifmp BRAM base addr
	config_data[49][2] = 32'd95598; // ofmp BRAM base addr
	config_data[49][3] = 32'd7776; // weight BRAM base addr
	config_data[49][4] = 32'd1047; // M1 BRAM base addr
	config_data[49][5] = 32'd0; // SC base addr
	config_data[49][6] = 32'b0000000000000000_10001101_00000000; // [15:8] output zero，[7:0] input zero
	config_data[49][7] = 32'b0001000000_00000010010_0000111_0_011; 
	//general config [31:22]: ifmp, [21:11] ofmp_channel, [10:4]: ifmp_size,  [3]:stride: 0代表stride=1，1代表stride =2, [2:0]: 00 IDLE 01 CONV 02 DW 03 PW 04 SC;

	//layer 43 input (160,7,7) output (960,7,7)
	config_data[50][0] = 32'd663; // M0
	config_data[50][1] = 32'd95598; // ifmp BRAM base addr
	config_data[50][2] = 32'd95760; // ofmp BRAM base addr
	config_data[50][3] = 32'd8928; // weight BRAM base addr
	config_data[50][4] = 32'd1065; // M1 BRAM base addr
	config_data[50][5] = 32'd0; // SC base addr
	config_data[50][6] = 32'b1000000000000000_00000000_10001101; // [15:8] output zero，[7:0] input zero
	config_data[50][7] = 32'b0000010010_00001101011_0000111_0_011; 
	//general config [31:22]: ifmp, [21:11] ofmp_channel, [10:4]: ifmp_size,  [3]:stride: 0代表stride=1，1代表stride =2, [2:0]: 00 IDLE 01 CONV 02 DW 03 PW 04 SC;

	//layer 44 input (960,7,7) output (960,7,7)
	config_data[51][0] = 32'd2924; // M0
	config_data[51][1] = 32'd95760; // ifmp BRAM base addr
	config_data[51][2] = 32'd96723; // ofmp BRAM base addr
	config_data[51][3] = 32'd10854; // weight BRAM base addr
	config_data[51][4] = 32'd1172; // M1 BRAM base addr
	config_data[51][5] = 32'd0; // SC base addr
	config_data[51][6] = 32'b1000000000000000_00000000_00000000; // [15:8] output zero，[7:0] input zero
	config_data[51][7] = 32'b0001101011_00001101011_0000111_0_010; 
	//general config [31:22]: ifmp, [21:11] ofmp_channel, [10:4]: ifmp_size,  [3]:stride: 0代表stride=1，1代表stride =2, [2:0]: 00 IDLE 01 CONV 02 DW 03 PW 04 SC;

	//layer 45 input (960,7,7) output (160,7,7)
	config_data[52][0] = 32'd98; // M0
	config_data[52][1] = 32'd96723; // ifmp BRAM base addr
	config_data[52][2] = 32'd97686; // ofmp BRAM base addr
	config_data[52][3] = 32'd10961; // weight BRAM base addr
	config_data[52][4] = 32'd1279; // M1 BRAM base addr
	config_data[52][5] = 32'd0; // SC base addr
	config_data[52][6] = 32'b0000000000000000_01101111_00000000; // [15:8] output zero，[7:0] input zero
	config_data[52][7] = 32'b0001101011_00000010010_0000111_0_011; 
	//general config [31:22]: ifmp, [21:11] ofmp_channel, [10:4]: ifmp_size,  [3]:stride: 0代表stride=1，1代表stride =2, [2:0]: 00 IDLE 01 CONV 02 DW 03 PW 04 SC;

	//layer 45 shortcut input (160,7,7) output (160,7,7)
	config_data[53][0] = 32'd45939; // M0
	config_data[53][1] = 32'd97686; // ifmp BRAM base addr
	config_data[53][2] = 32'd97848; // ofmp BRAM base addr
	config_data[53][3] = 32'd35994; // M1 
	config_data[53][4] = 32'd0; // 
	config_data[53][5] = 32'd95598; // SC base addr
	config_data[53][6] = 32'b0000000001110111_01101111_10001101; // [23:16] SC zero，[15:8] FX zero，[7:0] x zero
	config_data[53][7] = 32'b0000010010_00000010010_0000111_0_100;
	//general config [31:22]: ifmp, [21:11] ofmp_channel, [10:4]: ifmp_size,  [3]:stride: 0代表stride=1，1代表stride =2, [2:0]: 00 IDLE 01 CONV 02 DW 03 PW 04 SC;

	//layer 46 input (160,7,7) output (960,7,7)
	config_data[54][0] = 32'd580; // M0
	config_data[54][1] = 32'd97848; // ifmp BRAM base addr
	config_data[54][2] = 32'd98010; // ofmp BRAM base addr
	config_data[54][3] = 32'd12887; // weight BRAM base addr
	config_data[54][4] = 32'd1297; // M1 BRAM base addr
	config_data[54][5] = 32'd0; // SC base addr
	config_data[54][6] = 32'b1000000000000000_00000000_01110111; // [15:8] output zero，[7:0] input zero
	config_data[54][7] = 32'b0000010010_00001101011_0000111_0_011; 
	//general config [31:22]: ifmp, [21:11] ofmp_channel, [10:4]: ifmp_size,  [3]:stride: 0代表stride=1，1代表stride =2, [2:0]: 00 IDLE 01 CONV 02 DW 03 PW 04 SC;

	//layer 47 input (960,7,7) output (960,7,7)
	config_data[55][0] = 32'd2008; // M0
	config_data[55][1] = 32'd98010; // ifmp BRAM base addr
	config_data[55][2] = 32'd98973; // ofmp BRAM base addr
	config_data[55][3] = 32'd14813; // weight BRAM base addr
	config_data[55][4] = 32'd1404; // M1 BRAM base addr
	config_data[55][5] = 32'd0; // SC base addr
	config_data[55][6] = 32'b1000000000000000_00000000_00000000; // [15:8] output zero，[7:0] input zero
	config_data[55][7] = 32'b0001101011_00001101011_0000111_0_010; 
	//general config [31:22]: ifmp, [21:11] ofmp_channel, [10:4]: ifmp_size,  [3]:stride: 0代表stride=1，1代表stride =2, [2:0]: 00 IDLE 01 CONV 02 DW 03 PW 04 SC;

	//layer 48 input (960,7,7) output (160,7,7)
	config_data[56][0] = 32'd80; // M0
	config_data[56][1] = 32'd98973; // ifmp BRAM base addr
	config_data[56][2] = 32'd99936; // ofmp BRAM base addr
	config_data[56][3] = 32'd14920; // weight BRAM base addr
	config_data[56][4] = 32'd1511; // M1 BRAM base addr
	config_data[56][5] = 32'd0; // SC base addr
	config_data[56][6] = 32'b0000000000000000_10000011_00000000; // [15:8] output zero，[7:0] input zero
	config_data[56][7] = 32'b0001101011_00000010010_0000111_0_011; 
	//general config [31:22]: ifmp, [21:11] ofmp_channel, [10:4]: ifmp_size,  [3]:stride: 0代表stride=1，1代表stride =2, [2:0]: 00 IDLE 01 CONV 02 DW 03 PW 04 SC;

	//layer 48 shortcut input (160,7,7) output (160,7,7)
	config_data[57][0] = 32'd34738; // M0
	config_data[57][1] = 32'd99936; // ifmp BRAM base addr
	config_data[57][2] = 32'd100098; // ofmp BRAM base addr
	config_data[57][3] = 32'd45129; // M1 
	config_data[57][4] = 32'd0; // 
	config_data[57][5] = 32'd97848; // SC base addr
	config_data[57][6] = 32'b0000000001110010_10000011_01110111; // [23:16] SC zero，[15:8] FX zero，[7:0] x zero
	config_data[57][7] = 32'b0000010010_00000010010_0000111_0_100;
	//general config [31:22]: ifmp, [21:11] ofmp_channel, [10:4]: ifmp_size,  [3]:stride: 0代表stride=1，1代表stride =2, [2:0]: 00 IDLE 01 CONV 02 DW 03 PW 04 SC;

	//layer 49 input (160,7,7) output (960,7,7)
	config_data[58][0] = 32'd878; // M0
	config_data[58][1] = 32'd100098; // ifmp BRAM base addr
	config_data[58][2] = 32'd100260; // ofmp BRAM base addr
	config_data[58][3] = 32'd16846; // weight BRAM base addr
	config_data[58][4] = 32'd1529; // M1 BRAM base addr
	config_data[58][5] = 32'd0; // SC base addr
	config_data[58][6] = 32'b1000000000000000_00000000_01110010; // [15:8] output zero，[7:0] input zero
	config_data[58][7] = 32'b0000010010_00001101011_0000111_0_011; 
	//general config [31:22]: ifmp, [21:11] ofmp_channel, [10:4]: ifmp_size,  [3]:stride: 0代表stride=1，1代表stride =2, [2:0]: 00 IDLE 01 CONV 02 DW 03 PW 04 SC;

	//layer 50 input (960,7,7) output (960,7,7)
	config_data[59][0] = 32'd3081; // M0
	config_data[59][1] = 32'd100260; // ifmp BRAM base addr
	config_data[59][2] = 32'd101223; // ofmp BRAM base addr
	config_data[59][3] = 32'd18772; // weight BRAM base addr
	config_data[59][4] = 32'd1636; // M1 BRAM base addr
	config_data[59][5] = 32'd0; // SC base addr
	config_data[59][6] = 32'b1000000000000000_00000000_00000000; // [15:8] output zero，[7:0] input zero
	config_data[59][7] = 32'b0001101011_00001101011_0000111_0_010; 
	//general config [31:22]: ifmp, [21:11] ofmp_channel, [10:4]: ifmp_size,  [3]:stride: 0代表stride=1，1代表stride =2, [2:0]: 00 IDLE 01 CONV 02 DW 03 PW 04 SC;

	//layer 51 input (960,7,7) output (320,7,7)
	config_data[60][0] = 32'd209; // M0
	config_data[60][1] = 32'd101223; // ifmp BRAM base addr
	config_data[60][2] = 32'd102186; // ofmp BRAM base addr
	config_data[60][3] = 32'd18879; // weight BRAM base addr
	config_data[60][4] = 32'd1743; // M1 BRAM base addr
	config_data[60][5] = 32'd0; // SC base addr
	config_data[60][6] = 32'b0000000000000000_10000000_00000000; // [15:8] output zero，[7:0] input zero
	config_data[60][7] = 32'b0001101011_00000100100_0000111_0_011; 
	//general config [31:22]: ifmp, [21:11] ofmp_channel, [10:4]: ifmp_size,  [3]:stride: 0代表stride=1，1代表stride =2, [2:0]: 00 IDLE 01 CONV 02 DW 03 PW 04 SC;

	//layer 52 input (320,7,7) output (1280,7,7)
	config_data[61][0] = 32'd223; // M0
	config_data[61][1] = 32'd102186; // ifmp BRAM base addr
	config_data[61][2] = 32'd102510; // ofmp BRAM base addr
	config_data[61][3] = 32'd22731; // weight BRAM base addr
	config_data[61][4] = 32'd1779; // M1 BRAM base addr
	config_data[61][5] = 32'd0; // SC base addr
	config_data[61][6] = 32'b1000000000000000_00000000_10000000; // [15:8] output zero ，[7:0] input zero
	config_data[61][7] = 32'b0000100100_00010001111_0000111_0_011; 
	//general config [31:22]: ifmp, [21:11] ofmp_channel, [10:4]: ifmp_size,  [3]:stride: 0代表stride=1，1代表stride =2, [2:0]: 00 IDLE 01 CONV 02 DW 03 PW 04 SC;

  //layer 52 pooling input (1280,7,7) output (1280,1,1) average pooling
  config_data[62][0] = 32'd0; // M0
  config_data[62][1] = 32'd102510; // ifmp BRAM base addr
  config_data[62][2] = 32'd103797; // ofmp BRAM base addr
  config_data[62][3] = 32'd0; // weight BRAM base addr
  config_data[62][4] = 32'd0; // M1 BRAM base addr
  config_data[62][5] = 32'd0; // SC base addr
  config_data[62][6] = 32'b0000000000000000_00000000_00000000; 
  config_data[62][7] = 32'b0010001111_00010001111_0000111_0_101; 
  //general config [31:22]: ifmp, [21:11] ofmp_channel, [10:4]: ifmp_size,  [3]:stride: 0代表stride=1，1代表stride =2, [2:0]: 00 IDLE 01 CONV 02 DW 03 PW 04 SC 05 AVGPOOL;

  //layer 53 input (1280,1,1) output (1000,1,1) fc
  config_data[63][0] = 32'd67; // M0
  config_data[63][1] = 32'd103797; // ifmp BRAM base addr
  config_data[63][2] = 32'd103940; // ofmp BRAM base addr
  config_data[63][3] = 32'd27879; // weight BRAM base addr
  config_data[63][4] = 32'd1922; // M1 BRAM base addr
  config_data[63][5] = 32'd0; // SC base addr
  config_data[63][6] = 32'b0000000000000000_01001011_00000000; // [15:8] output zero ，[7:0] input zero
  config_data[63][7] = 32'b0010001111_00001110000_0000001_0_011; 
  //general config [31:22]: ifmp, [21:11] ofmp_channel, [10:4]: ifmp_size,  [3]:stride: 0代表stride=1，1代表stride =2, [2:0]: 00 IDLE 01 CONV 02 DW 03 PW 04 SC 05 AVGPOOL;
  

  //layer 54 input (1000,1,1) output (1000,1,1) softmax
  config_data[64][0] = 32'd113; // M0
  config_data[64][1] = 32'd103940; // ifmp BRAM base addr
  config_data[64][2] = 32'd104052; // ofmp BRAM base addr
  config_data[64][3] = 32'd0; // weight BRAM base addr
  config_data[64][4] = 32'd0; // M1 BRAM base addr
  config_data[64][5] = 32'd0; // SC base addr
  config_data[64][6] = 32'b0000000000000000_01001011_00000000; 
  config_data[64][7] = 32'b0000000000_00000000000_0000001_0_110; //[2:0] 00 IDLE 01 CONV 02 DW 03 PW 04 SC 05 AVGPOOL 06 SOFTMAX;
end
endmodule
