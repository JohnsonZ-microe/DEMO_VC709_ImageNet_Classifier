module counter_dw#
  (
    parameter IFMAP_CHANNEL_WIDTH  = 10,
    parameter OFMAP_CHANNEL_WIDTH  = 11,
    parameter HORIZENTAL_VERTICAL_COUNTER_WIDTH = 8,
    parameter FM_SIZE_WIDTH  =  8,
    parameter CHANNEL_PARA   =  9,
    parameter BIAS_WIDTH = 32,
    parameter DATA_BRAM_ADDR_WIDTH = 15,
    parameter KERNEL_BRAM_ADDR_WIDTH = 16
  )
  (
    input 								clk     	    ,
    input 								rst_n   	    ,
    input								enable		    ,

    /** User Config Register Signal Declaration **/
    input [31:0] reg_config_data_in,   // user config register data input
    input [3:0] reg_config_addr,       // user config register mapped address
    input reg_config_valid,            // user config register data valid, when asserted, reg_config_data_in was written in corresponding register
    input softmax_finish,
    output busy,
    output reg complete,

    output [HORIZENTAL_VERTICAL_COUNTER_WIDTH-1:0] ifmap_size_out,
    output [HORIZENTAL_VERTICAL_COUNTER_WIDTH-1:0] ofmap_size_out,
    output [IFMAP_CHANNEL_WIDTH-1:0] ifmap_channel_out,
    output [OFMAP_CHANNEL_WIDTH-1:0] ofmap_channel_out,

    output [DATA_BRAM_ADDR_WIDTH-1:0]   ifmap_base_addr_out  ,
    output [DATA_BRAM_ADDR_WIDTH-1:0]   ofmap_base_addr_out  ,
    output [DATA_BRAM_ADDR_WIDTH-1:0]   SC_base_addr_out,
    output [KERNEL_BRAM_ADDR_WIDTH-1:0] kernel_base_addr_out ,
    output [KERNEL_BRAM_ADDR_WIDTH-1:0] M1_base_addr_out     ,

    output    [FM_SIZE_WIDTH-1:0]       pos_x           ,
    output    [FM_SIZE_WIDTH-1:0]       pos_y           ,
    output    [IFMAP_CHANNEL_WIDTH-1:0]       pos_z           ,

    output    [FM_SIZE_WIDTH-1:0]       write_pos_x           ,
    output    [FM_SIZE_WIDTH-1:0]       write_pos_y           ,
    output    [OFMAP_CHANNEL_WIDTH-1:0]       write_pos_z           ,

    output   [OFMAP_CHANNEL_WIDTH-1:0] kernel_p,
    output   [IFMAP_CHANNEL_WIDTH-1:0] kernel_n,

    input [CHANNEL_PARA*FM_SIZE_WIDTH-1:0] Window00_in, Window01_in, Window02_in,
    input [CHANNEL_PARA*FM_SIZE_WIDTH-1:0] Window10_in, Window11_in, Window12_in,
    input [CHANNEL_PARA*FM_SIZE_WIDTH-1:0] Window20_in, Window21_in, Window22_in,

    input [CHANNEL_PARA*FM_SIZE_WIDTH-1:0] Weight00_in, Weight01_in, Weight02_in,
    input [CHANNEL_PARA*FM_SIZE_WIDTH-1:0] Weight10_in, Weight11_in, Weight12_in,
    input [CHANNEL_PARA*FM_SIZE_WIDTH-1:0] Weight20_in, Weight21_in, Weight22_in,
    output [1:0] bram_st_out,

    input [32*9-1 : 0] Bias_in,

    output   [CHANNEL_PARA*FM_SIZE_WIDTH-1:0]  data1_to99       ,
    output   [CHANNEL_PARA*FM_SIZE_WIDTH-1:0]  data2_to99       ,
    output   [CHANNEL_PARA*FM_SIZE_WIDTH-1:0]  data3_to99       ,
    output   [CHANNEL_PARA*FM_SIZE_WIDTH-1:0]  data4_to99       ,
    output   [CHANNEL_PARA*FM_SIZE_WIDTH-1:0]  data5_to99       ,
    output   [CHANNEL_PARA*FM_SIZE_WIDTH-1:0]  data6_to99       ,
    output   [CHANNEL_PARA*FM_SIZE_WIDTH-1:0]  data7_to99       ,
    output   [CHANNEL_PARA*FM_SIZE_WIDTH-1:0]  data8_to99       ,
    output   [CHANNEL_PARA*FM_SIZE_WIDTH-1:0]  data9_to99       ,

    output   [CHANNEL_PARA*FM_SIZE_WIDTH-1:0]  weight1_to99       ,
    output   [CHANNEL_PARA*FM_SIZE_WIDTH-1:0]  weight2_to99       ,
    output   [CHANNEL_PARA*FM_SIZE_WIDTH-1:0]  weight3_to99       ,
    output   [CHANNEL_PARA*FM_SIZE_WIDTH-1:0]  weight4_to99       ,
    output   [CHANNEL_PARA*FM_SIZE_WIDTH-1:0]  weight5_to99       ,
    output   [CHANNEL_PARA*FM_SIZE_WIDTH-1:0]  weight6_to99       ,
    output   [CHANNEL_PARA*FM_SIZE_WIDTH-1:0]  weight7_to99       ,
    output   [CHANNEL_PARA*FM_SIZE_WIDTH-1:0]  weight8_to99       ,
    output   [CHANNEL_PARA*FM_SIZE_WIDTH-1:0]  weight9_to99       ,

    //output reg tlast,
    (* max_fanout = 64 *)
    output reg tlast,
    output reg tlast_no_sync,
    output reg tlast_pw,
    output [31:0] M0_to_arrays,
    output [7:0] Input_zero_point,
    output [7:0] Output_zero_point,
    output [7:0] sc_zero_point,
    output ReLU_enable,
    output [2:0] Mode,
    output reg [31:0] Array_Mac0_M1, Array_Mac1_M1, Array_Mac2_M1, Array_Mac3_M1, Array_Mac4_M1, Array_Mac5_M1, Array_Mac6_M1, Array_Mac7_M1, Array_Mac8_M1,

    input write_valid,
    input pw_valid,
    output ofmap_wea,
    //------------------------Shortcut test-------------------//
    input [HORIZENTAL_VERTICAL_COUNTER_WIDTH-1:0] read_h_block_idx,
    input [HORIZENTAL_VERTICAL_COUNTER_WIDTH-1:0] read_v_block_idx,
    input [HORIZENTAL_VERTICAL_COUNTER_WIDTH-1:0] write_h_block_idx,
    input [HORIZENTAL_VERTICAL_COUNTER_WIDTH-1:0] write_v_block_idx,
    input [7:0] row_block_num,
    output  shortcut_sel,//用于选择bram此时读出的是x的地址还是fx的地址

    //-----------------------Average Pooling test------------------//
    output reg avgpool_chan_start,
    output reg avgpool_chan_done,
    output softmax_en

  );

  assign ofmap_wea = write_valid;



  /** User Config Register Declaration **/
  //--  1. General Config register  --//
  //--  coding scheme:
  //--  [31:22] ifmap_channel  [21:11] ofmap_channel  [10:4] ifmap_size [3]: stride  [2:0] Mode
  (* max_fanout = 32 *) reg [31:0] General_config;

  wire [7:0] ifmap_channel;
  assign ifmap_channel = General_config[31:22];
  assign ifmap_channel_out = ifmap_channel;
  wire [10:0] ofmap_channel;
  assign ofmap_channel = General_config[21:11];
  assign ofmap_channel_out = ofmap_channel;
  wire [6:0] ifmap_size_no_first_layer;
  assign ifmap_size_no_first_layer = General_config[10:4];
  //    wire has_SC;
  //    assign has_SC = General_config[3];
  wire stride;                  // stride = 0 : stride is 1   ||   stride = 1 : stride is 2
  assign stride = General_config[3];
  assign Mode = General_config[2:0];
  assign softmax_en = (Mode == 3'b110) ? 1'b1 : 1'b0;
  wire [7:0] ifmap_size;
  assign ifmap_size = (ifmap_size_no_first_layer== 0)? 8'd224: ifmap_size_no_first_layer;
  assign ifmap_size_out = ifmap_size;
  //--  2. Input data and weight base address register --//
  //--  coding scheme:
  //--  [18:0] ifmap_base_addr   [19] ifmap_group_sel
  reg [31:0] Ifmap_base_addr;
  assign ifmap_base_addr_out = Ifmap_base_addr[DATA_BRAM_ADDR_WIDTH-1:0];

  //--  3. Kernel base address register --//
  //--  coding scheme:
  //--  [15:0] Weight_base_addr  [17:16] Weight_output_bram_index
  reg [31:0] Ofmap_base_addr;
  assign ofmap_base_addr_out = Ofmap_base_addr[DATA_BRAM_ADDR_WIDTH-1:0];
  //--  4. output data and bias base address register --//
  //--  coding scheme:
  //--  [18:0] Ofmap_base_addr  [30:19] Bias_base_addr
  reg [31:0] Weight_base_addr;
  assign kernel_base_addr_out = Weight_base_addr[KERNEL_BRAM_ADDR_WIDTH-1:0];
  //--  5. output data and bias base address register --//
  //--  coding scheme:
  //--  [18:0] Ofmap_base_addr  [30:19] Bias_base_addr
  reg [31:0] M1_base_addr;
  assign M1_base_addr_out = M1_base_addr[KERNEL_BRAM_ADDR_WIDTH-1:0];
  //--  6. output data and bias base address register --//
  //--  coding scheme:
  //--  [18:0] Ofmap_base_addr  [30:19] Bias_base_addr
  reg [31:0] M0;
  assign M0_to_arrays = M0;
  //--  7. output data and bias base address register --//
  //--  coding scheme:
  //--  [18:0] Ofmap_base_addr  [30:19] Bias_base_addr
  reg [31:0] SC_base_addr;
  assign SC_base_addr_out = SC_base_addr[DATA_BRAM_ADDR_WIDTH-1:0];
  //--  8. output data and bias base address register --//
  //--  coding scheme:
  //--  [18:0] Ofmap_base_addr  [30:19] Bias_base_addr
  reg [31:0] Zero_points;
  assign Input_zero_point = Zero_points[7:0];
  assign Output_zero_point = Zero_points[15:8];
  assign sc_zero_point = Zero_points[23:16];
  assign ReLU_enable = Zero_points[31];
  /////////////////------------------------------------------------/////////////////////
  /////////////////////////////  [2]. User Defined Register ////////////////////////////
  /////////////////------------------------------------------------////////////////////

  always@(posedge clk)
  begin
    if((!rst_n)||complete)
    begin
      General_config    <= 0;
      Ifmap_base_addr   <= 0;
      Ofmap_base_addr   <= 0;
      Weight_base_addr  <= 0;
      M1_base_addr      <= 0;
      M0                <= 0;
      SC_base_addr      <= 0;
      Zero_points <= 0;
    end
    else if(reg_config_valid)
    begin
      case(reg_config_addr)
        4'd0:
          M0                <= reg_config_data_in;
        4'd1:
          Ifmap_base_addr   <= reg_config_data_in;
        4'd2:
          Ofmap_base_addr   <= reg_config_data_in;
        4'd3:
          Weight_base_addr  <= reg_config_data_in;
        4'd4:
          M1_base_addr      <= reg_config_data_in;
        4'd5:
          SC_base_addr      <= reg_config_data_in;
        4'd6:
          Zero_points <= reg_config_data_in;
        4'd7:
          General_config    <= reg_config_data_in;
        default:
        begin
          General_config <= General_config;
          Ifmap_base_addr <= Ifmap_base_addr;
          Ofmap_base_addr <= Ofmap_base_addr;
          Weight_base_addr <= Weight_base_addr;
          M1_base_addr      <= M1_base_addr;
          M0                <= M0;
          Zero_points <= Zero_points;
          General_config    <= General_config;
        end
      endcase
    end
    else
    begin
      General_config <= General_config;
      Ifmap_base_addr <= Ifmap_base_addr;
      Ofmap_base_addr <= Ofmap_base_addr;
      Weight_base_addr <= Weight_base_addr;
      M1_base_addr      <= M1_base_addr;
      M0                <= M0;
      Zero_points <= Zero_points;
      General_config    <= General_config;
    end
  end

  wire [7:0] ofmap_size;
  // 1. ofmap_size
  // when stride==1(stride is 2), size of ofmap is that of ifmap devide by 2
  assign ofmap_size = (stride==0)? ifmap_size:ifmap_size>>1;
  assign ofmap_size_out = ofmap_size;

  /////////////////------------------------------------------------/////////////////////
  ////////////////////               [3]. FSM                   ////////////////////////
  /////////////////------------------------------------------------////////////////////
  localparam IDLE        = 0;
  localparam CALCULATE   = 1;


  reg bram_st;
  reg bram_next_st;
  assign bram_st_out = bram_st;

 always @(posedge clk or negedge rst_n)
  begin
    if (!rst_n)
    begin
      bram_st <= IDLE;
    end
    else if (enable)
    begin
      bram_st <= bram_next_st;
    end
    else
    begin
      bram_st <= bram_st;
    end
  end

  always @(*)
  begin
    bram_next_st = bram_st;
    case (bram_st)
      IDLE:
      begin
        if (Mode != 0)
          bram_next_st = CALCULATE;
        else
          bram_next_st = IDLE;
      end

      CALCULATE:
      begin
        if (complete)
        begin
          bram_next_st = IDLE;
        end
        else
        begin
          bram_next_st = CALCULATE;
        end
      end
      default:
        bram_next_st = IDLE;
    endcase
  end


  /////////////////------------------------------------------------/////////////////////
  /////////////////////////////  [4]. Counters ////////////////////////////
  /////////////////------------------------------------------------////////////////////
  reg [FM_SIZE_WIDTH-1:0] Ifmap_hori_base_cnt;
  reg [FM_SIZE_WIDTH-1:0] Ifmap_vert_base_cnt;
  reg [IFMAP_CHANNEL_WIDTH-1:0] Channel_cnt;
  reg [OFMAP_CHANNEL_WIDTH-1:0] Kernel_cnt;
  reg shortcut_addr_sel;
  reg [30:0] shortcut_valid;
  //reg [8*12-1:0] Ifmap_hori_base_cnt_conv_delay_FIFO;
  //reg [8*9-1:0] Ifmap_hori_base_cnt_DWPW_delay_FIFO;
  //reg [8*12-1:0] Ifmap_vert_base_cnt_conv_delay_FIFO;
  //reg [8*9-1:0] Ifmap_vert_base_cnt_DWPW_delay_FIFO;

  reg [OFMAP_CHANNEL_WIDTH-1:0] Write_Channel_cnt;

  reg [FM_SIZE_WIDTH-1:0] Ofmap_hori_base_cnt;
  reg [FM_SIZE_WIDTH-1:0] Ofmap_vert_base_cnt;

  wire [OFMAP_CHANNEL_WIDTH-1:0] kernel_num;
  assign kernel_num = (Mode==3'd1)? 12: ofmap_channel;
  (* max_fanout = 64 *)
  reg [1:0] last_block_signal;
  reg [1:0] last_block_signal_reg[0:7];
  //-- 1. Ifmap_hori_base_cnt(IHB)  --//
  // Specify the central corner point at a 3*3 convolution in ifmap/ofmap
  always @(posedge clk)
  begin
    if(!rst_n)
    begin
      Ifmap_hori_base_cnt <= 0;
    end
    else if(bram_st == CALCULATE)
      if ((Ifmap_hori_base_cnt == ofmap_size-1) && (Kernel_cnt == kernel_num-1)&&(Mode != 3'd3)&&(Mode != 3'd4)&&(Mode != 3'd5))
        Ifmap_hori_base_cnt <= 0;
      else if(Mode == 3'd3)
      begin
        if((Ifmap_hori_base_cnt == ofmap_size-1) && (Kernel_cnt == kernel_num-1)&&(Channel_cnt == ifmap_channel - 1))
          Ifmap_hori_base_cnt <= 0;
        else if ((Kernel_cnt == kernel_num-1)&&(Channel_cnt == ifmap_channel - 1))
          Ifmap_hori_base_cnt <= Ifmap_hori_base_cnt + 1;
        else
          Ifmap_hori_base_cnt <= Ifmap_hori_base_cnt;
      end
      else if(Mode == 3'd4)
      begin
        if((Ifmap_hori_base_cnt == 0)&&(Ifmap_vert_base_cnt == 0))
          Ifmap_hori_base_cnt <= 1;
        else if ((read_h_block_idx == row_block_num -1) && (shortcut_addr_sel == 1) && (Channel_cnt == ifmap_channel - 1))
          Ifmap_hori_base_cnt <= 1;
        else if ((shortcut_addr_sel == 1) &&(Channel_cnt == ifmap_channel - 1))
          Ifmap_hori_base_cnt <= Ifmap_hori_base_cnt + 3;
        else
          Ifmap_hori_base_cnt <= Ifmap_hori_base_cnt;
      end
      else if(Mode == 3'd5)
      begin
        if((Ifmap_hori_base_cnt == 0)&&(Ifmap_vert_base_cnt == 0))
          Ifmap_hori_base_cnt <= 1;
        else if (last_block_signal[0])
          Ifmap_hori_base_cnt <= 1;
        else
          Ifmap_hori_base_cnt <= Ifmap_hori_base_cnt + 3;
      end
      else if(Kernel_cnt == kernel_num-1)
        Ifmap_hori_base_cnt <= Ifmap_hori_base_cnt + 1;
      else
      begin
        Ifmap_hori_base_cnt <= Ifmap_hori_base_cnt;
      end
    else
    begin
      Ifmap_hori_base_cnt <= 0;
    end
  end

  wire h0;
  assign h0 = (Ifmap_hori_base_cnt==0);
  wire hl;
  assign hl = (Ifmap_hori_base_cnt==ofmap_size-1);

  // -- 2. Ifmap_vert_base_cnt(IVB):  --//
  // specify the raw number of start corner point in ifmap
  always @(posedge clk)
  begin
    if(!rst_n)
    begin
      Ifmap_vert_base_cnt <= 0;
    end
    else if(bram_st == CALCULATE)
      if ((Ifmap_vert_base_cnt == ofmap_size-1)&&(Ifmap_hori_base_cnt == ofmap_size-1) && (Kernel_cnt==kernel_num-1)&&(Mode != 3'd3)&&(Mode != 3'd4)&&(Mode != 3'd5))
        Ifmap_vert_base_cnt <= 0;
      else if(Mode == 3'd3)
      begin
        if((Ifmap_vert_base_cnt == ofmap_size-1)&&(Ifmap_hori_base_cnt == ofmap_size-1) && (Kernel_cnt==kernel_num-1)&&(Channel_cnt == ifmap_channel - 1))
          Ifmap_vert_base_cnt <= 0;
        else if ((Ifmap_hori_base_cnt == ofmap_size-1) && (Kernel_cnt==kernel_num-1)&&(Channel_cnt == ifmap_channel - 1))
          Ifmap_vert_base_cnt <= Ifmap_vert_base_cnt + 1;
        else
          Ifmap_vert_base_cnt <= Ifmap_vert_base_cnt;
      end
      else if(Mode == 3'd4)
      begin
        if((Ifmap_hori_base_cnt == 0)&&(Ifmap_vert_base_cnt == 0))
          Ifmap_vert_base_cnt <= 1;
        else if ((read_v_block_idx == row_block_num -1)&&(read_h_block_idx == row_block_num -1) && (shortcut_addr_sel == 1) && (Channel_cnt == ifmap_channel - 1))
          Ifmap_vert_base_cnt <= 1;
        else if ((read_h_block_idx == row_block_num -1) &&(shortcut_addr_sel == 1) &&(Channel_cnt == ifmap_channel - 1))
          Ifmap_vert_base_cnt <= Ifmap_vert_base_cnt + 3;
        else
          Ifmap_vert_base_cnt <= Ifmap_vert_base_cnt;
      end
      else if(Mode == 3'd5)
      begin
        if((Ifmap_hori_base_cnt == 0)&&(Ifmap_vert_base_cnt == 0))
          Ifmap_vert_base_cnt <= 1;
        else if (&last_block_signal)
          Ifmap_vert_base_cnt <= 1;
        else if (last_block_signal[0])
          Ifmap_vert_base_cnt <= Ifmap_vert_base_cnt + 3;
        else
          Ifmap_vert_base_cnt <= Ifmap_vert_base_cnt;
      end
      else if((Ifmap_hori_base_cnt == ofmap_size-1) && (Kernel_cnt==kernel_num-1))
        Ifmap_vert_base_cnt <= Ifmap_vert_base_cnt + 1;
      else
      begin
        Ifmap_vert_base_cnt <= Ifmap_vert_base_cnt;
      end
    else
    begin
      Ifmap_vert_base_cnt <= 0;
    end
  end

  wire v0;
  assign v0 = (Ifmap_vert_base_cnt==0);
  wire vl;
  assign vl = (Ifmap_vert_base_cnt==ofmap_size-1);
  // 3. Channel_cnt (CC)
  // specifies the current calculating channel of a point
  always @(posedge clk)
  begin
    if(!rst_n)
    begin
      Channel_cnt <= 0;
    end
    else if(bram_st == CALCULATE)
    begin
      if (Mode==3'd1)   //Normal conv
        Channel_cnt <= 0;
      else if (Mode == 3'd4)
      begin
        if((shortcut_addr_sel == 1)&&(Channel_cnt==ifmap_channel -1))
        begin
          Channel_cnt <= 0;
        end
        else if (shortcut_addr_sel == 1)
        begin
          Channel_cnt <= Channel_cnt + 1;
        end
        else
        begin
          Channel_cnt <= Channel_cnt;
        end
      end
      else if (Mode == 3'd5)
      begin
        if(&last_block_signal)
          Channel_cnt <= Channel_cnt + 1;
        else
          Channel_cnt <= Channel_cnt;
      end
      // else if ((Channel_cnt==ifmap_channel-1) && (Ifmap_hori_base_cnt==ofmap_size-1) && (Ifmap_vert_base_cnt==ofmap_size-1))
      //   Channel_cnt <= Channel_cnt;
      else if (Channel_cnt==ifmap_channel-1)
        Channel_cnt <= 0;
      else
        Channel_cnt <= Channel_cnt+1;
    end
    else
      Channel_cnt <=0;
  end


  // 4. Kernel_cnt (KC)
  // specifies the current calculating Kernel index
  always @(posedge clk)
  begin
    if(!rst_n)
    begin
      Kernel_cnt <= 0;
    end
    else if(bram_st == CALCULATE)
    begin
      if ((Kernel_cnt == kernel_num-1)&&(Mode != 3'd3))
        Kernel_cnt <= 0;
      else if(Mode == 3'd3)
      begin
        if((Channel_cnt == ifmap_channel - 1)&&(Kernel_cnt == kernel_num - 1))
          Kernel_cnt <= 0;
        else if(Channel_cnt == ifmap_channel - 1)
          Kernel_cnt <= Kernel_cnt + 1;
        else
          Kernel_cnt <= Kernel_cnt; //保持当前kernel不变
      end
      else if ((Channel_cnt==ifmap_channel-1)&&(Mode != 3'd2))
        Kernel_cnt <= Kernel_cnt + 1;
      else if (Mode == 3'd2) //Depthwise conv
        Kernel_cnt <= Kernel_cnt + 1;
      else
        Kernel_cnt <= Kernel_cnt;
    end
    else
      Kernel_cnt <=0;
  end

  // shortcut address select
  always @(posedge clk)
  begin
    if(!rst_n)
    begin
      shortcut_addr_sel <= 0;
    end
    else if((Ifmap_hori_base_cnt==0)&&(Ifmap_vert_base_cnt==0))
      shortcut_addr_sel <= 0;
    else
      shortcut_addr_sel <= ~shortcut_addr_sel;
  end


  always @(posedge clk)
  begin
    if(!rst_n)
      shortcut_valid <= 0;
    else
      shortcut_valid <= {shortcut_valid[29:0], shortcut_addr_sel};
  end
  assign shortcut_sel = shortcut_addr_sel;
  wire avgpool_chan_done_no_sync;
  wire avgpool_chan_start_no_sync;
  reg[10:0] avgpool_chan_done_reg;
  reg[5:0] avgpool_chan_start_reg;
  assign avgpool_chan_done_no_sync = (Mode == 3'd5 && read_h_block_idx == row_block_num -1 && read_v_block_idx == row_block_num -1);
  assign avgpool_chan_start_no_sync = (Mode == 3'd5 && read_h_block_idx == 1 && read_v_block_idx == 1 && Channel_cnt == 0);

  integer x;
  always @(posedge clk)
  begin
    if(!rst_n || complete)
    begin
      for(x=0;x<6;x=x+1)
      begin
        avgpool_chan_start_reg[x] <= 0;
      end
      for (x=0;x<11;x=x+1)
      begin
        avgpool_chan_done_reg[x] <= 0;
      end
    end
    else
    begin
      avgpool_chan_start_reg[0] <= avgpool_chan_start_no_sync;
      for(x=1;x<6;x=x+1)
      begin
        avgpool_chan_start_reg[x] <= avgpool_chan_start_reg[x-1];
      end
      avgpool_chan_done_reg[0] <= avgpool_chan_done_no_sync;
      for (x=1;x<11;x=x+1)
      begin
        avgpool_chan_done_reg[x] <= avgpool_chan_done_reg[x-1];
      end
    end
  end
  always @(posedge clk)
  begin
    if(!rst_n)
    begin
      avgpool_chan_done <= 0;
      avgpool_chan_start <= 0;
    end
    else
    begin
      avgpool_chan_done <= avgpool_chan_done_reg[10];
      avgpool_chan_start <= avgpool_chan_start_reg[5];
    end
  end

  always @( *)
  begin
    last_block_signal = {(ifmap_size - Ifmap_vert_base_cnt) <3, (ifmap_size - Ifmap_hori_base_cnt) <3};
  end
  integer k;
  always @(posedge clk)
  begin
    if(!rst_n)
    begin
      for (k=0; k<8; k=k+1)
      begin
        last_block_signal_reg[k] <= 0;
      end
    end
    else
    begin
      last_block_signal_reg[0] <= last_block_signal;
      for (k=1; k<8; k=k+1)
      begin
        last_block_signal_reg[k] <= last_block_signal_reg[k-1];
      end
    end
  end
  reg [OFMAP_CHANNEL_WIDTH-1:0] kernel_p_nosync;
  always @(posedge clk)
  begin
    if(!rst_n)
      kernel_p_nosync <= 0;
    else
      kernel_p_nosync <= Kernel_cnt;
  end
  assign kernel_p = kernel_p_nosync;
  assign kernel_n = Channel_cnt;
  //different mode delay for different clks
  // 1. CONV mode:   12clk:    2clk(address evaluation) + 2clk(bram read delay) + 4clk(adder tree) + 1clk(m0xsigma_plus) + 1clk(conv3add) + 2clk(result concatenate)
  // 2. DW mode:     9clk : 2clk(address evaluation) + 2clk(bram read delay) + 4clk(adder tree) + 1clk(m0xsigma_plus)
  // 3. PW mode:     9clk : 2clk(address evaluation) + 2clk(bram read delay) + 4clk(adder tree) + 1clk(m0xsigma_plus)

  assign pos_z = Channel_cnt;
  assign pos_x = (stride==0)?Ifmap_hori_base_cnt : Ifmap_hori_base_cnt<<1;
  assign pos_y = (stride==0)?Ifmap_vert_base_cnt : Ifmap_vert_base_cnt<<1;


  //always@(posedge clk) begin
  //    if(!rst_n) begin
  //        Ifmap_hori_base_cnt_conv_delay_FIFO <= 0;
  //        Ifmap_hori_base_cnt_DWPW_delay_FIFO <= 0;
  //        Ifmap_vert_base_cnt_conv_delay_FIFO <= 0;
  //        Ifmap_vert_base_cnt_DWPW_delay_FIFO <= 0;
  //    end
  //    else if(Mode==2'd1) begin
  //        Ifmap_hori_base_cnt_conv_delay_FIFO[12*FM_SIZE_WIDTH-1: 11*FM_SIZE_WIDTH] <= Ifmap_hori_base_cnt_conv_delay_FIFO[11*FM_SIZE_WIDTH-1: 10*FM_SIZE_WIDTH];
  //        Ifmap_hori_base_cnt_conv_delay_FIFO[11*FM_SIZE_WIDTH-1: 10*FM_SIZE_WIDTH] <= Ifmap_hori_base_cnt_conv_delay_FIFO[10*FM_SIZE_WIDTH-1: 9*FM_SIZE_WIDTH];
  //        Ifmap_hori_base_cnt_conv_delay_FIFO[10*FM_SIZE_WIDTH-1: 9*FM_SIZE_WIDTH] <= Ifmap_hori_base_cnt_conv_delay_FIFO[9*FM_SIZE_WIDTH-1: 8*FM_SIZE_WIDTH];
  //        Ifmap_hori_base_cnt_conv_delay_FIFO[9*FM_SIZE_WIDTH-1: 8*FM_SIZE_WIDTH] <= Ifmap_hori_base_cnt_conv_delay_FIFO[8*FM_SIZE_WIDTH-1: 7*FM_SIZE_WIDTH];
  //        Ifmap_hori_base_cnt_conv_delay_FIFO[8*FM_SIZE_WIDTH-1: 7*FM_SIZE_WIDTH] <= Ifmap_hori_base_cnt_conv_delay_FIFO[7*FM_SIZE_WIDTH-1: 6*FM_SIZE_WIDTH];
  //        Ifmap_hori_base_cnt_conv_delay_FIFO[7*FM_SIZE_WIDTH-1: 6*FM_SIZE_WIDTH] <= Ifmap_hori_base_cnt_conv_delay_FIFO[6*FM_SIZE_WIDTH-1: 5*FM_SIZE_WIDTH];
  //        Ifmap_hori_base_cnt_conv_delay_FIFO[6*FM_SIZE_WIDTH-1: 5*FM_SIZE_WIDTH] <= Ifmap_hori_base_cnt_conv_delay_FIFO[5*FM_SIZE_WIDTH-1: 4*FM_SIZE_WIDTH];
  //        Ifmap_hori_base_cnt_conv_delay_FIFO[5*FM_SIZE_WIDTH-1: 4*FM_SIZE_WIDTH] <= Ifmap_hori_base_cnt_conv_delay_FIFO[4*FM_SIZE_WIDTH-1: 3*FM_SIZE_WIDTH];
  //        Ifmap_hori_base_cnt_conv_delay_FIFO[4*FM_SIZE_WIDTH-1: 3*FM_SIZE_WIDTH] <= Ifmap_hori_base_cnt_conv_delay_FIFO[3*FM_SIZE_WIDTH-1: 2*FM_SIZE_WIDTH];
  //        Ifmap_hori_base_cnt_conv_delay_FIFO[3*FM_SIZE_WIDTH-1: 2*FM_SIZE_WIDTH] <= Ifmap_hori_base_cnt_conv_delay_FIFO[2*FM_SIZE_WIDTH-1: 1*FM_SIZE_WIDTH];
  //        Ifmap_hori_base_cnt_conv_delay_FIFO[2*FM_SIZE_WIDTH-1: 1*FM_SIZE_WIDTH] <= Ifmap_hori_base_cnt_conv_delay_FIFO[1*FM_SIZE_WIDTH-1: 0*FM_SIZE_WIDTH];
  //        Ifmap_hori_base_cnt_conv_delay_FIFO[1*FM_SIZE_WIDTH-1: 0*FM_SIZE_WIDTH] <= Ifmap_hori_base_cnt;

  //        Ifmap_vert_base_cnt_conv_delay_FIFO[12*FM_SIZE_WIDTH-1: 11*FM_SIZE_WIDTH] <= Ifmap_vert_base_cnt_conv_delay_FIFO[11*FM_SIZE_WIDTH-1: 10*FM_SIZE_WIDTH];
  //        Ifmap_vert_base_cnt_conv_delay_FIFO[11*FM_SIZE_WIDTH-1: 10*FM_SIZE_WIDTH] <= Ifmap_vert_base_cnt_conv_delay_FIFO[10*FM_SIZE_WIDTH-1: 9*FM_SIZE_WIDTH];
  //        Ifmap_vert_base_cnt_conv_delay_FIFO[10*FM_SIZE_WIDTH-1: 9*FM_SIZE_WIDTH]  <= Ifmap_vert_base_cnt_conv_delay_FIFO[9*FM_SIZE_WIDTH-1: 8*FM_SIZE_WIDTH];
  //        Ifmap_vert_base_cnt_conv_delay_FIFO[9*FM_SIZE_WIDTH-1: 8*FM_SIZE_WIDTH] <= Ifmap_vert_base_cnt_conv_delay_FIFO[8*FM_SIZE_WIDTH-1: 7*FM_SIZE_WIDTH];
  //        Ifmap_vert_base_cnt_conv_delay_FIFO[8*FM_SIZE_WIDTH-1: 7*FM_SIZE_WIDTH] <= Ifmap_vert_base_cnt_conv_delay_FIFO[7*FM_SIZE_WIDTH-1: 6*FM_SIZE_WIDTH];
  //        Ifmap_vert_base_cnt_conv_delay_FIFO[7*FM_SIZE_WIDTH-1: 6*FM_SIZE_WIDTH] <= Ifmap_vert_base_cnt_conv_delay_FIFO[6*FM_SIZE_WIDTH-1: 5*FM_SIZE_WIDTH];
  //        Ifmap_vert_base_cnt_conv_delay_FIFO[6*FM_SIZE_WIDTH-1: 5*FM_SIZE_WIDTH] <= Ifmap_vert_base_cnt_conv_delay_FIFO[5*FM_SIZE_WIDTH-1: 4*FM_SIZE_WIDTH];
  //        Ifmap_vert_base_cnt_conv_delay_FIFO[5*FM_SIZE_WIDTH-1: 4*FM_SIZE_WIDTH] <= Ifmap_vert_base_cnt_conv_delay_FIFO[4*FM_SIZE_WIDTH-1: 3*FM_SIZE_WIDTH];
  //        Ifmap_vert_base_cnt_conv_delay_FIFO[4*FM_SIZE_WIDTH-1: 3*FM_SIZE_WIDTH] <= Ifmap_vert_base_cnt_conv_delay_FIFO[3*FM_SIZE_WIDTH-1: 2*FM_SIZE_WIDTH];
  //        Ifmap_vert_base_cnt_conv_delay_FIFO[3*FM_SIZE_WIDTH-1: 2*FM_SIZE_WIDTH] <= Ifmap_vert_base_cnt_conv_delay_FIFO[2*FM_SIZE_WIDTH-1: 1*FM_SIZE_WIDTH];
  //        Ifmap_vert_base_cnt_conv_delay_FIFO[2*FM_SIZE_WIDTH-1: 1*FM_SIZE_WIDTH] <= Ifmap_vert_base_cnt_conv_delay_FIFO[1*FM_SIZE_WIDTH-1: 0*FM_SIZE_WIDTH];
  //        Ifmap_vert_base_cnt_conv_delay_FIFO[1*FM_SIZE_WIDTH-1: 0*FM_SIZE_WIDTH] <= Ifmap_vert_base_cnt;
  //    end
  //    else if(Mode==2'd2 || Mode==2'd3) begin
  //        Ifmap_hori_base_cnt_DWPW_delay_FIFO[9*FM_SIZE_WIDTH-1: 8*FM_SIZE_WIDTH] <= Ifmap_hori_base_cnt_DWPW_delay_FIFO[8*FM_SIZE_WIDTH-1: 7*FM_SIZE_WIDTH];
  //        Ifmap_hori_base_cnt_DWPW_delay_FIFO[8*FM_SIZE_WIDTH-1: 7*FM_SIZE_WIDTH] <= Ifmap_hori_base_cnt_DWPW_delay_FIFO[7*FM_SIZE_WIDTH-1: 6*FM_SIZE_WIDTH];
  //        Ifmap_hori_base_cnt_DWPW_delay_FIFO[7*FM_SIZE_WIDTH-1: 6*FM_SIZE_WIDTH] <= Ifmap_hori_base_cnt_DWPW_delay_FIFO[6*FM_SIZE_WIDTH-1: 5*FM_SIZE_WIDTH];
  //        Ifmap_hori_base_cnt_DWPW_delay_FIFO[6*FM_SIZE_WIDTH-1: 5*FM_SIZE_WIDTH] <= Ifmap_hori_base_cnt_DWPW_delay_FIFO[5*FM_SIZE_WIDTH-1: 4*FM_SIZE_WIDTH];
  //        Ifmap_hori_base_cnt_DWPW_delay_FIFO[5*FM_SIZE_WIDTH-1: 4*FM_SIZE_WIDTH] <= Ifmap_hori_base_cnt_DWPW_delay_FIFO[4*FM_SIZE_WIDTH-1: 3*FM_SIZE_WIDTH];
  //        Ifmap_hori_base_cnt_DWPW_delay_FIFO[4*FM_SIZE_WIDTH-1: 3*FM_SIZE_WIDTH] <= Ifmap_hori_base_cnt_DWPW_delay_FIFO[3*FM_SIZE_WIDTH-1: 2*FM_SIZE_WIDTH];
  //        Ifmap_hori_base_cnt_DWPW_delay_FIFO[3*FM_SIZE_WIDTH-1: 2*FM_SIZE_WIDTH] <= Ifmap_hori_base_cnt_DWPW_delay_FIFO[2*FM_SIZE_WIDTH-1: 1*FM_SIZE_WIDTH];
  //        Ifmap_hori_base_cnt_DWPW_delay_FIFO[2*FM_SIZE_WIDTH-1: 1*FM_SIZE_WIDTH] <= Ifmap_hori_base_cnt_DWPW_delay_FIFO[1*FM_SIZE_WIDTH-1: 0*FM_SIZE_WIDTH];
  //        Ifmap_hori_base_cnt_DWPW_delay_FIFO[1*FM_SIZE_WIDTH-1: 0*FM_SIZE_WIDTH] <= Ifmap_hori_base_cnt;

  //        Ifmap_vert_base_cnt_DWPW_delay_FIFO[9*FM_SIZE_WIDTH-1: 8*FM_SIZE_WIDTH] <= Ifmap_vert_base_cnt_DWPW_delay_FIFO[8*FM_SIZE_WIDTH-1: 7*FM_SIZE_WIDTH];
  //        Ifmap_vert_base_cnt_DWPW_delay_FIFO[8*FM_SIZE_WIDTH-1: 7*FM_SIZE_WIDTH] <= Ifmap_vert_base_cnt_DWPW_delay_FIFO[7*FM_SIZE_WIDTH-1: 6*FM_SIZE_WIDTH];
  //        Ifmap_vert_base_cnt_DWPW_delay_FIFO[7*FM_SIZE_WIDTH-1: 6*FM_SIZE_WIDTH] <= Ifmap_vert_base_cnt_DWPW_delay_FIFO[6*FM_SIZE_WIDTH-1: 5*FM_SIZE_WIDTH];
  //        Ifmap_vert_base_cnt_DWPW_delay_FIFO[6*FM_SIZE_WIDTH-1: 5*FM_SIZE_WIDTH] <= Ifmap_vert_base_cnt_DWPW_delay_FIFO[5*FM_SIZE_WIDTH-1: 4*FM_SIZE_WIDTH];
  //        Ifmap_vert_base_cnt_DWPW_delay_FIFO[5*FM_SIZE_WIDTH-1: 4*FM_SIZE_WIDTH] <= Ifmap_vert_base_cnt_DWPW_delay_FIFO[4*FM_SIZE_WIDTH-1: 3*FM_SIZE_WIDTH];
  //        Ifmap_vert_base_cnt_DWPW_delay_FIFO[4*FM_SIZE_WIDTH-1: 3*FM_SIZE_WIDTH] <= Ifmap_vert_base_cnt_DWPW_delay_FIFO[3*FM_SIZE_WIDTH-1: 2*FM_SIZE_WIDTH];
  //        Ifmap_vert_base_cnt_DWPW_delay_FIFO[3*FM_SIZE_WIDTH-1: 2*FM_SIZE_WIDTH] <= Ifmap_vert_base_cnt_DWPW_delay_FIFO[2*FM_SIZE_WIDTH-1: 1*FM_SIZE_WIDTH];
  //        Ifmap_vert_base_cnt_DWPW_delay_FIFO[2*FM_SIZE_WIDTH-1: 1*FM_SIZE_WIDTH] <= Ifmap_vert_base_cnt_DWPW_delay_FIFO[1*FM_SIZE_WIDTH-1: 0*FM_SIZE_WIDTH];
  //        Ifmap_vert_base_cnt_DWPW_delay_FIFO[1*FM_SIZE_WIDTH-1: 0*FM_SIZE_WIDTH] <= Ifmap_vert_base_cnt;
  //    end
  //    else begin
  //        Ifmap_hori_base_cnt_conv_delay_FIFO <= 0;
  //        Ifmap_hori_base_cnt_DWPW_delay_FIFO <= 0;
  //        Ifmap_vert_base_cnt_conv_delay_FIFO <= 0;
  //        Ifmap_vert_base_cnt_DWPW_delay_FIFO <= 0;
  //    end
  //end

  //assign Ofmap_hori_base_cnt = (Mode==1)? Ifmap_hori_base_cnt_conv_delay_FIFO[12*FM_SIZE_WIDTH-1: 11*FM_SIZE_WIDTH] : Ifmap_hori_base_cnt_DWPW_delay_FIFO[9*FM_SIZE_WIDTH-1: 8*FM_SIZE_WIDTH];
  //assign Ofmap_vert_base_cnt = (Mode==1)? Ifmap_vert_base_cnt_conv_delay_FIFO[12*FM_SIZE_WIDTH-1: 11*FM_SIZE_WIDTH] : Ifmap_vert_base_cnt_DWPW_delay_FIFO[9*FM_SIZE_WIDTH-1: 8*FM_SIZE_WIDTH];
  reg write_valid_mux;
  reg [2:0] Mode_reg[0:5];
  integer i;
  always @(posedge clk)
  begin
    if(!rst_n)
    begin
      for (i=0; i<6; i=i+1)
      begin
        Mode_reg[i] <= 3'd0;
      end
    end
    else
    begin
      Mode_reg[0] <= Mode;
      for (i=1; i<6; i=i+1)
      begin
        Mode_reg[i] <= Mode_reg[i-1];
      end
    end
  end
  reg[1:0] bram_st_reg[0:5];
  integer j;
  always @(posedge clk)
  begin
    if(!rst_n)
    begin
      for (j=0; j<6; j=j+1)
      begin
        bram_st_reg[j] <= 2'd0;
      end
    end
    else
    begin
      bram_st_reg[0] <= bram_st;
      for (j=1; j<6; j=j+1)
      begin
        bram_st_reg[j] <= bram_st_reg[j-1];
      end
    end
  end
  always @( *)
  begin
    case(Mode_reg[5])
      3'd3:
        write_valid_mux = pw_valid;
      3'd4:
        write_valid_mux = shortcut_valid[6];
      default:
        write_valid_mux = write_valid;
    endcase
  end
  // assign write_valid_mux = (Mode_reg[5]==3'd3)? pw_valid : write_valid;
  always@(posedge clk)
  begin
    if(!rst_n)
    begin
      Write_Channel_cnt <= 0;
    end
    else if(bram_st_reg[5] == CALCULATE)
    begin
      if(Write_Channel_cnt == ofmap_channel - 1 && write_valid_mux)
        Write_Channel_cnt<=0;
      else if(write_valid_mux)
        Write_Channel_cnt<=Write_Channel_cnt+1;
      else
        Write_Channel_cnt<=Write_Channel_cnt;
    end
    else
      Write_Channel_cnt <= 0;
  end
  // if(Mode == 3'd4)begin
  //         if((Ifmap_hori_base_cnt == 0)&&(Ifmap_vert_base_cnt == 0)) Ifmap_vert_base_cnt <= 1;
  //         else if ((read_v_block_idx == row_block_num -1)&&(read_h_block_idx == row_block_num -1) && (shortcut_addr_sel == 1) && (Channel_cnt == ifmap_channel - 1))
  //           Ifmap_vert_base_cnt <= 1;
  //         else if ((read_h_block_idx == row_block_num -1) &&(shortcut_addr_sel == 1) &&(Channel_cnt == ifmap_channel - 1))
  //           Ifmap_vert_base_cnt <= Ifmap_vert_base_cnt + 3;
  //         else Ifmap_vert_base_cnt <= Ifmap_vert_base_cnt;
  //       end
  always@(posedge clk)
  begin
    if(!rst_n)
    begin
      Ofmap_hori_base_cnt <= 0;
    end
    else if(bram_st_reg[5] == CALCULATE)
      if(Mode == 3'd4)
      begin
        if((Ofmap_hori_base_cnt == 0)&&(Ofmap_vert_base_cnt == 0))
          Ofmap_hori_base_cnt <= 1;
        else if ((write_h_block_idx == row_block_num - 1)  && (Write_Channel_cnt == ofmap_channel - 1) && write_valid_mux)
          Ofmap_hori_base_cnt<=1;
        else if((Write_Channel_cnt == ofmap_channel - 1) && write_valid_mux)
          Ofmap_hori_base_cnt<=Ofmap_hori_base_cnt+3;
        else
          Ofmap_hori_base_cnt<=Ofmap_hori_base_cnt;
      end
      else if (Mode == 3'd5)
      begin
        Ofmap_hori_base_cnt <= 0;
      end

      else
      begin
        if(Ofmap_hori_base_cnt == ofmap_size - 1 && Write_Channel_cnt == ofmap_channel - 1 && write_valid_mux)
          Ofmap_hori_base_cnt<=0;
        else if(Write_Channel_cnt == ofmap_channel - 1 && write_valid_mux)
          Ofmap_hori_base_cnt<=Ofmap_hori_base_cnt+1;
        else
          Ofmap_hori_base_cnt<=Ofmap_hori_base_cnt;
      end
    else
      Ofmap_hori_base_cnt <= 0;
  end

  always@(posedge clk)
  begin
    if(!rst_n)
    begin
      Ofmap_vert_base_cnt <= 0;
    end
    else if(bram_st_reg[5] == CALCULATE)
      if(Mode == 3'd4)
      begin
        if((Ofmap_hori_base_cnt == 0)&&(Ofmap_vert_base_cnt == 0))
          Ofmap_vert_base_cnt <= 1;
        else if ((write_h_block_idx == row_block_num - 1)  && (write_v_block_idx == row_block_num -1)&& (Write_Channel_cnt == ofmap_channel - 1) && write_valid_mux)
          Ofmap_vert_base_cnt<=1;
        else if((write_h_block_idx == row_block_num -1 ) && (Write_Channel_cnt == ofmap_channel - 1) && write_valid_mux)
          Ofmap_vert_base_cnt<=Ofmap_vert_base_cnt+3;
        else
          Ofmap_vert_base_cnt<=Ofmap_vert_base_cnt;
      end
      else if (Mode == 3'd5)
      begin
        Ofmap_vert_base_cnt <= 0;
      end
      else
      begin
        if(Ofmap_vert_base_cnt == ofmap_size - 1 && Ofmap_hori_base_cnt == ofmap_size - 1 && Write_Channel_cnt == ofmap_channel - 1 && write_valid_mux)
          Ofmap_vert_base_cnt<=0;
        else if(Ofmap_hori_base_cnt == ofmap_size - 1 && Write_Channel_cnt == ofmap_channel - 1 && write_valid_mux)
          Ofmap_vert_base_cnt<=Ofmap_vert_base_cnt+1;
        else
          Ofmap_vert_base_cnt<=Ofmap_vert_base_cnt;
      end
    else
      Ofmap_vert_base_cnt <= 0;
  end

  assign write_pos_z = Write_Channel_cnt;
  assign write_pos_x = Ofmap_hori_base_cnt;
  assign write_pos_y = Ofmap_vert_base_cnt;

  /////////////////------------------------------------------------/////////////////////
  /////////////////////////////  [4]. data arbiter ////////////////////////////
  /////////////////------------------------------------------------////////////////////

  reg [FM_SIZE_WIDTH-1:0] Array_Mac0_ifmap0, Array_Mac0_ifmap1, Array_Mac0_ifmap2, Array_Mac0_ifmap3, Array_Mac0_ifmap4, Array_Mac0_ifmap5, Array_Mac0_ifmap6, Array_Mac0_ifmap7, Array_Mac0_ifmap8;
  reg [FM_SIZE_WIDTH-1:0] Array_Mac1_ifmap0, Array_Mac1_ifmap1, Array_Mac1_ifmap2, Array_Mac1_ifmap3, Array_Mac1_ifmap4, Array_Mac1_ifmap5, Array_Mac1_ifmap6, Array_Mac1_ifmap7, Array_Mac1_ifmap8;
  reg [FM_SIZE_WIDTH-1:0] Array_Mac2_ifmap0, Array_Mac2_ifmap1, Array_Mac2_ifmap2, Array_Mac2_ifmap3, Array_Mac2_ifmap4, Array_Mac2_ifmap5, Array_Mac2_ifmap6, Array_Mac2_ifmap7, Array_Mac2_ifmap8;
  reg [FM_SIZE_WIDTH-1:0] Array_Mac3_ifmap0, Array_Mac3_ifmap1, Array_Mac3_ifmap2, Array_Mac3_ifmap3, Array_Mac3_ifmap4, Array_Mac3_ifmap5, Array_Mac3_ifmap6, Array_Mac3_ifmap7, Array_Mac3_ifmap8;
  reg [FM_SIZE_WIDTH-1:0] Array_Mac4_ifmap0, Array_Mac4_ifmap1, Array_Mac4_ifmap2, Array_Mac4_ifmap3, Array_Mac4_ifmap4, Array_Mac4_ifmap5, Array_Mac4_ifmap6, Array_Mac4_ifmap7, Array_Mac4_ifmap8;
  reg [FM_SIZE_WIDTH-1:0] Array_Mac5_ifmap0, Array_Mac5_ifmap1, Array_Mac5_ifmap2, Array_Mac5_ifmap3, Array_Mac5_ifmap4, Array_Mac5_ifmap5, Array_Mac5_ifmap6, Array_Mac5_ifmap7, Array_Mac5_ifmap8;
  reg [FM_SIZE_WIDTH-1:0] Array_Mac6_ifmap0, Array_Mac6_ifmap1, Array_Mac6_ifmap2, Array_Mac6_ifmap3, Array_Mac6_ifmap4, Array_Mac6_ifmap5, Array_Mac6_ifmap6, Array_Mac6_ifmap7, Array_Mac6_ifmap8;
  reg [FM_SIZE_WIDTH-1:0] Array_Mac7_ifmap0, Array_Mac7_ifmap1, Array_Mac7_ifmap2, Array_Mac7_ifmap3, Array_Mac7_ifmap4, Array_Mac7_ifmap5, Array_Mac7_ifmap6, Array_Mac7_ifmap7, Array_Mac7_ifmap8;
  reg [FM_SIZE_WIDTH-1:0] Array_Mac8_ifmap0, Array_Mac8_ifmap1, Array_Mac8_ifmap2, Array_Mac8_ifmap3, Array_Mac8_ifmap4, Array_Mac8_ifmap5, Array_Mac8_ifmap6, Array_Mac8_ifmap7, Array_Mac8_ifmap8;


  reg [FM_SIZE_WIDTH-1:0] Array_Mac0_weight0, Array_Mac0_weight1, Array_Mac0_weight2, Array_Mac0_weight3, Array_Mac0_weight4, Array_Mac0_weight5, Array_Mac0_weight6, Array_Mac0_weight7, Array_Mac0_weight8;
  reg [FM_SIZE_WIDTH-1:0] Array_Mac1_weight0, Array_Mac1_weight1, Array_Mac1_weight2, Array_Mac1_weight3, Array_Mac1_weight4, Array_Mac1_weight5, Array_Mac1_weight6, Array_Mac1_weight7, Array_Mac1_weight8;
  reg [FM_SIZE_WIDTH-1:0] Array_Mac2_weight0, Array_Mac2_weight1, Array_Mac2_weight2, Array_Mac2_weight3, Array_Mac2_weight4, Array_Mac2_weight5, Array_Mac2_weight6, Array_Mac2_weight7, Array_Mac2_weight8;
  reg [FM_SIZE_WIDTH-1:0] Array_Mac3_weight0, Array_Mac3_weight1, Array_Mac3_weight2, Array_Mac3_weight3, Array_Mac3_weight4, Array_Mac3_weight5, Array_Mac3_weight6, Array_Mac3_weight7, Array_Mac3_weight8;
  reg [FM_SIZE_WIDTH-1:0] Array_Mac4_weight0, Array_Mac4_weight1, Array_Mac4_weight2, Array_Mac4_weight3, Array_Mac4_weight4, Array_Mac4_weight5, Array_Mac4_weight6, Array_Mac4_weight7, Array_Mac4_weight8;
  reg [FM_SIZE_WIDTH-1:0] Array_Mac5_weight0, Array_Mac5_weight1, Array_Mac5_weight2, Array_Mac5_weight3, Array_Mac5_weight4, Array_Mac5_weight5, Array_Mac5_weight6, Array_Mac5_weight7, Array_Mac5_weight8;
  reg [FM_SIZE_WIDTH-1:0] Array_Mac6_weight0, Array_Mac6_weight1, Array_Mac6_weight2, Array_Mac6_weight3, Array_Mac6_weight4, Array_Mac6_weight5, Array_Mac6_weight6, Array_Mac6_weight7, Array_Mac6_weight8;
  reg [FM_SIZE_WIDTH-1:0] Array_Mac7_weight0, Array_Mac7_weight1, Array_Mac7_weight2, Array_Mac7_weight3, Array_Mac7_weight4, Array_Mac7_weight5, Array_Mac7_weight6, Array_Mac7_weight7, Array_Mac7_weight8;
  reg [FM_SIZE_WIDTH-1:0] Array_Mac8_weight0, Array_Mac8_weight1, Array_Mac8_weight2, Array_Mac8_weight3, Array_Mac8_weight4, Array_Mac8_weight5, Array_Mac8_weight6, Array_Mac8_weight7, Array_Mac8_weight8;

  reg [4:0] padding_delay_1, padding_delay_2, padding_delay_3, padding_delay_4, padding_delay_5, padding_delay_6, padding_delay_7;
  reg [4:0] padding_arbiter;
  always@(posedge clk)
  begin
    if(!rst_n)
    begin
      padding_arbiter <= 0;
      padding_delay_1 <= 0;
      padding_delay_2 <= 0;
      padding_delay_3 <= 0;
      padding_delay_4 <= 0;
      padding_delay_5 <= 0;
      padding_delay_6 <= 0;
      padding_delay_7 <= 0;
    end
    else
    begin
      padding_delay_1 <= {v0, vl, h0, hl, stride};
      padding_delay_2 <= padding_delay_1;
      padding_delay_3 <= padding_delay_2;
      padding_delay_4 <= padding_delay_3;
      padding_delay_5 <= padding_delay_4;
      padding_delay_6 <= padding_delay_5;
      padding_delay_7 <= padding_delay_6;
      padding_arbiter <= padding_delay_7;
    end
  end

  reg [3:0] padding_scenario_decoder;

  always@(*)
  begin
    if(!rst_n)
    begin
      padding_scenario_decoder = 4'd0;
    end
    else
    case(padding_arbiter)
      5'b10100:
      begin
        padding_scenario_decoder = 4'd1;
      end
      5'b10010:
      begin
        padding_scenario_decoder = 4'd2;
      end
      5'b10000:
      begin
        padding_scenario_decoder = 4'd3;
      end
      5'b01100:
      begin
        padding_scenario_decoder = 4'd4;
      end
      5'b01010:
      begin
        padding_scenario_decoder = 4'd5;
      end
      5'b01000:
      begin
        padding_scenario_decoder = 4'd6;
      end
      5'b00100:
      begin
        padding_scenario_decoder = 4'd7;
      end
      5'b00010:
      begin
        padding_scenario_decoder = 4'd8;
      end
      5'b00000:
      begin
        padding_scenario_decoder = 4'd9;
      end
      5'b10101:
      begin
        padding_scenario_decoder = 4'd1;
      end
      5'b10011:
      begin
        padding_scenario_decoder = 4'd3;
      end
      5'b10001:
      begin
        padding_scenario_decoder = 4'd3;
      end
      5'b01101:
      begin
        padding_scenario_decoder = 4'd7;
      end
      5'b01011:
      begin
        padding_scenario_decoder = 4'd9;
      end
      5'b01001:
      begin
        padding_scenario_decoder = 4'd9;
      end
      5'b00101:
      begin
        padding_scenario_decoder = 4'd7;
      end
      5'b00011:
      begin
        padding_scenario_decoder = 4'd9;
      end
      5'b00001:
      begin
        padding_scenario_decoder = 4'd9;
      end
      default :
        padding_scenario_decoder = 4'd0;
    endcase
  end

  always@(posedge clk)
  begin
    case(Mode_reg[0])
      3'd1:
      begin//normal conv
        case(padding_scenario_decoder)
          4'd0:
          begin
            Array_Mac0_ifmap0 <= 0;
            Array_Mac0_ifmap1 <= 0;
            Array_Mac0_ifmap2 <= 0;
            Array_Mac0_ifmap3 <= 0;
            Array_Mac0_ifmap4 <= 0;
            Array_Mac0_ifmap5 <= 0;
            Array_Mac0_ifmap6 <= 0;
            Array_Mac0_ifmap7 <= 0;
            Array_Mac0_ifmap8 <= 0;

            Array_Mac1_ifmap0 <= 0;
            Array_Mac1_ifmap1 <= 0;
            Array_Mac1_ifmap2 <= 0;
            Array_Mac1_ifmap3 <= 0;
            Array_Mac1_ifmap4 <= 0;
            Array_Mac1_ifmap5 <= 0;
            Array_Mac1_ifmap6 <= 0;
            Array_Mac1_ifmap7 <= 0;
            Array_Mac1_ifmap8 <= 0;

            Array_Mac2_ifmap0 <= 0;
            Array_Mac2_ifmap1 <= 0;
            Array_Mac2_ifmap2 <= 0;
            Array_Mac2_ifmap3 <= 0;
            Array_Mac2_ifmap4 <= 0;
            Array_Mac2_ifmap5 <= 0;
            Array_Mac2_ifmap6 <= 0;
            Array_Mac2_ifmap7 <= 0;
            Array_Mac2_ifmap8 <= 0;

            //-------------                    >>> group 1 /////////////////
            Array_Mac3_ifmap0 <= 0;
            Array_Mac3_ifmap1 <= 0;
            Array_Mac3_ifmap2 <= 0;
            Array_Mac3_ifmap3 <= 0;
            Array_Mac3_ifmap4 <= 0;
            Array_Mac3_ifmap5 <= 0;
            Array_Mac3_ifmap6 <= 0;
            Array_Mac3_ifmap7 <= 0;
            Array_Mac3_ifmap8 <= 0;

            Array_Mac4_ifmap0 <= 0;
            Array_Mac4_ifmap1 <= 0;
            Array_Mac4_ifmap2 <= 0;
            Array_Mac4_ifmap3 <= 0;
            Array_Mac4_ifmap4 <= 0;
            Array_Mac4_ifmap5 <= 0;
            Array_Mac4_ifmap6 <= 0;
            Array_Mac4_ifmap7 <= 0;
            Array_Mac4_ifmap8 <= 0;

            Array_Mac5_ifmap0 <= 0;
            Array_Mac5_ifmap1 <= 0;
            Array_Mac5_ifmap2 <= 0;
            Array_Mac5_ifmap3 <= 0;
            Array_Mac5_ifmap4 <= 0;
            Array_Mac5_ifmap5 <= 0;
            Array_Mac5_ifmap6 <= 0;
            Array_Mac5_ifmap7 <= 0;
            Array_Mac5_ifmap8 <= 0;

            //-------------                    >>> group 2 /////////////////
            Array_Mac6_ifmap0 <= 0;
            Array_Mac6_ifmap1 <= 0;
            Array_Mac6_ifmap2 <= 0;
            Array_Mac6_ifmap3 <= 0;
            Array_Mac6_ifmap4 <= 0;
            Array_Mac6_ifmap5 <= 0;
            Array_Mac6_ifmap6 <= 0;
            Array_Mac6_ifmap7 <= 0;
            Array_Mac6_ifmap8 <= 0;

            Array_Mac7_ifmap0 <= 0;
            Array_Mac7_ifmap1 <= 0;
            Array_Mac7_ifmap2 <= 0;
            Array_Mac7_ifmap3 <= 0;
            Array_Mac7_ifmap4 <= 0;
            Array_Mac7_ifmap5 <= 0;
            Array_Mac7_ifmap6 <= 0;
            Array_Mac7_ifmap7 <= 0;
            Array_Mac7_ifmap8 <= 0;

            Array_Mac8_ifmap0 <= 0;
            Array_Mac8_ifmap1 <= 0;
            Array_Mac8_ifmap2 <= 0;
            Array_Mac8_ifmap3 <= 0;
            Array_Mac8_ifmap4 <= 0;
            Array_Mac8_ifmap5 <= 0;
            Array_Mac8_ifmap6 <= 0;
            Array_Mac8_ifmap7 <= 0;
            Array_Mac8_ifmap8 <= 0;
          end
          4'd1:
          begin
            //-------------                    >>> group 0 /////////////////
            Array_Mac0_ifmap0 <= Input_zero_point;
            Array_Mac0_ifmap1 <= Input_zero_point;
            Array_Mac0_ifmap2 <= Input_zero_point;
            Array_Mac0_ifmap3 <= Input_zero_point;
            Array_Mac0_ifmap4 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap5 <= Window12_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap6 <= Input_zero_point;
            Array_Mac0_ifmap7 <= Window21_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap8 <= Window22_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];

            Array_Mac1_ifmap0 <= Input_zero_point;
            Array_Mac1_ifmap1 <= Input_zero_point;
            Array_Mac1_ifmap2 <= Input_zero_point;
            Array_Mac1_ifmap3 <= Input_zero_point;
            Array_Mac1_ifmap4 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap5 <= Window12_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap6 <= Input_zero_point;
            Array_Mac1_ifmap7 <= Window21_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap8 <= Window22_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];

            Array_Mac2_ifmap0 <= Input_zero_point;
            Array_Mac2_ifmap1 <= Input_zero_point;
            Array_Mac2_ifmap2 <= Input_zero_point;
            Array_Mac2_ifmap3 <= Input_zero_point;
            Array_Mac2_ifmap4 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap5 <= Window12_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap6 <= Input_zero_point;
            Array_Mac2_ifmap7 <= Window21_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap8 <= Window22_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];

            //-------------                    >>> group 1 /////////////////
            Array_Mac3_ifmap0 <= Input_zero_point;
            Array_Mac3_ifmap1 <= Input_zero_point;
            Array_Mac3_ifmap2 <= Input_zero_point;
            Array_Mac3_ifmap3 <= Input_zero_point;
            Array_Mac3_ifmap4 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap5 <= Window12_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap6 <= Input_zero_point;
            Array_Mac3_ifmap7 <= Window21_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap8 <= Window22_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];

            Array_Mac4_ifmap0 <= Input_zero_point;
            Array_Mac4_ifmap1 <= Input_zero_point;
            Array_Mac4_ifmap2 <= Input_zero_point;
            Array_Mac4_ifmap3 <= Input_zero_point;
            Array_Mac4_ifmap4 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap5 <= Window12_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap6 <= Input_zero_point;
            Array_Mac4_ifmap7 <= Window21_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap8 <= Window22_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];

            Array_Mac5_ifmap0 <= Input_zero_point;
            Array_Mac5_ifmap1 <= Input_zero_point;
            Array_Mac5_ifmap2 <= Input_zero_point;
            Array_Mac5_ifmap3 <= Input_zero_point;
            Array_Mac5_ifmap4 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap5 <= Window12_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap6 <= Input_zero_point;
            Array_Mac5_ifmap7 <= Window21_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap8 <= Window22_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];

            //-------------                    >>> group 2 /////////////////
            Array_Mac6_ifmap0 <= Input_zero_point;
            Array_Mac6_ifmap1 <= Input_zero_point;
            Array_Mac6_ifmap2 <= Input_zero_point;
            Array_Mac6_ifmap3 <= Input_zero_point;
            Array_Mac6_ifmap4 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap5 <= Window12_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap6 <= Input_zero_point;
            Array_Mac6_ifmap7 <= Window21_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap8 <= Window22_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];

            Array_Mac7_ifmap0 <= Input_zero_point;
            Array_Mac7_ifmap1 <= Input_zero_point;
            Array_Mac7_ifmap2 <= Input_zero_point;
            Array_Mac7_ifmap3 <= Input_zero_point;
            Array_Mac7_ifmap4 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap5 <= Window12_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap6 <= Input_zero_point;
            Array_Mac7_ifmap7 <= Window21_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap8 <= Window22_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];

            Array_Mac8_ifmap0 <= Input_zero_point;
            Array_Mac8_ifmap1 <= Input_zero_point;
            Array_Mac8_ifmap2 <= Input_zero_point;
            Array_Mac8_ifmap3 <= Input_zero_point;
            Array_Mac8_ifmap4 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap5 <= Window12_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap6 <= Input_zero_point;
            Array_Mac8_ifmap7 <= Window21_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap8 <= Window22_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          end
          4'd2:
          begin
            //-------------                    >>> group 0 /////////////////
            Array_Mac0_ifmap0 <= Input_zero_point;
            Array_Mac0_ifmap1 <= Input_zero_point;
            Array_Mac0_ifmap2 <= Input_zero_point;
            Array_Mac0_ifmap3 <= Window10_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap4 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap5 <= Input_zero_point;
            Array_Mac0_ifmap6 <= Window20_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap7 <= Window21_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap8 <= Input_zero_point;

            Array_Mac1_ifmap0 <= Input_zero_point;
            Array_Mac1_ifmap1 <= Input_zero_point;
            Array_Mac1_ifmap2 <= Input_zero_point;
            Array_Mac1_ifmap3 <= Window10_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap4 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap5 <= Input_zero_point;
            Array_Mac1_ifmap6 <= Window20_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap7 <= Window21_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap8 <= Input_zero_point;

            Array_Mac2_ifmap0 <= Input_zero_point;
            Array_Mac2_ifmap1 <= Input_zero_point;
            Array_Mac2_ifmap2 <= Input_zero_point;
            Array_Mac2_ifmap3 <= Window10_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap4 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap5 <= Input_zero_point;
            Array_Mac2_ifmap6 <= Window20_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap7 <= Window21_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap8 <= Input_zero_point;

            //-------------                    >>> group 1 /////////////////
            Array_Mac3_ifmap0 <= Input_zero_point;
            Array_Mac3_ifmap1 <= Input_zero_point;
            Array_Mac3_ifmap2 <= Input_zero_point;
            Array_Mac3_ifmap3 <= Window10_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap4 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap5 <= Input_zero_point;
            Array_Mac3_ifmap6 <= Window20_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap7 <= Window21_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap8 <= Input_zero_point;

            Array_Mac4_ifmap0 <= Input_zero_point;
            Array_Mac4_ifmap1 <= Input_zero_point;
            Array_Mac4_ifmap2 <= Input_zero_point;
            Array_Mac4_ifmap3 <= Window10_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap4 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap5 <= Input_zero_point;
            Array_Mac4_ifmap6 <= Window20_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap7 <= Window21_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap8 <= Input_zero_point;

            Array_Mac5_ifmap0 <= Input_zero_point;
            Array_Mac5_ifmap1 <= Input_zero_point;
            Array_Mac5_ifmap2 <= Input_zero_point;
            Array_Mac5_ifmap3 <= Window10_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap4 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap5 <= Input_zero_point;
            Array_Mac5_ifmap6 <= Window20_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap7 <= Window21_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap8 <= Input_zero_point;

            //-------------                    >>> group 2 /////////////////
            Array_Mac6_ifmap0 <= Input_zero_point;
            Array_Mac6_ifmap1 <= Input_zero_point;
            Array_Mac6_ifmap2 <= Input_zero_point;
            Array_Mac6_ifmap3 <= Window10_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap4 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap5 <= Input_zero_point;
            Array_Mac6_ifmap6 <= Window20_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap7 <= Window21_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap8 <= Input_zero_point;

            Array_Mac7_ifmap0 <= Input_zero_point;
            Array_Mac7_ifmap1 <= Input_zero_point;
            Array_Mac7_ifmap2 <= Input_zero_point;
            Array_Mac7_ifmap3 <= Window10_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap4 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap5 <= Input_zero_point;
            Array_Mac7_ifmap6 <= Window20_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap7 <= Window21_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap8 <= Input_zero_point;

            Array_Mac8_ifmap0 <= Input_zero_point;
            Array_Mac8_ifmap1 <= Input_zero_point;
            Array_Mac8_ifmap2 <= Input_zero_point;
            Array_Mac8_ifmap3 <= Window10_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap4 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap5 <= Input_zero_point;
            Array_Mac8_ifmap6 <= Window20_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap7 <= Window21_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap8 <= Input_zero_point;
          end
          4'd3:
          begin
            //-------------                    >>> group 0 /////////////////
            Array_Mac0_ifmap0 <= Input_zero_point;
            Array_Mac0_ifmap1 <= Input_zero_point;
            Array_Mac0_ifmap2 <= Input_zero_point;
            Array_Mac0_ifmap3 <= Window10_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap4 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap5 <= Window12_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap6 <= Window20_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap7 <= Window21_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap8 <= Window22_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];

            Array_Mac1_ifmap0 <= Input_zero_point;
            Array_Mac1_ifmap1 <= Input_zero_point;
            Array_Mac1_ifmap2 <= Input_zero_point;
            Array_Mac1_ifmap3 <= Window10_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap4 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap5 <= Window12_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap6 <= Window20_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap7 <= Window21_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap8 <= Window22_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];

            Array_Mac2_ifmap0 <= Input_zero_point;
            Array_Mac2_ifmap1 <= Input_zero_point;
            Array_Mac2_ifmap2 <= Input_zero_point;
            Array_Mac2_ifmap3 <= Window10_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap4 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap5 <= Window12_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap6 <= Window20_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap7 <= Window21_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap8 <= Window22_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];

            //-------------                    >>> group 1 /////////////////
            Array_Mac3_ifmap0 <= Input_zero_point;
            Array_Mac3_ifmap1 <= Input_zero_point;
            Array_Mac3_ifmap2 <= Input_zero_point;
            Array_Mac3_ifmap3 <= Window10_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap4 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap5 <= Window12_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap6 <= Window20_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap7 <= Window21_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap8 <= Window22_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];

            Array_Mac4_ifmap0 <= Input_zero_point;
            Array_Mac4_ifmap1 <= Input_zero_point;
            Array_Mac4_ifmap2 <= Input_zero_point;
            Array_Mac4_ifmap3 <= Window10_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap4 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap5 <= Window12_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap6 <= Window20_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap7 <= Window21_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap8 <= Window22_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];

            Array_Mac5_ifmap0 <= Input_zero_point;
            Array_Mac5_ifmap1 <= Input_zero_point;
            Array_Mac5_ifmap2 <= Input_zero_point;
            Array_Mac5_ifmap3 <= Window10_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap4 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap5 <= Window12_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap6 <= Window20_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap7 <= Window21_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap8 <= Window22_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];

            //-------------                    >>> group 2 /////////////////
            Array_Mac6_ifmap0 <= Input_zero_point;
            Array_Mac6_ifmap1 <= Input_zero_point;
            Array_Mac6_ifmap2 <= Input_zero_point;
            Array_Mac6_ifmap3 <= Window10_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap4 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap5 <= Window12_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap6 <= Window20_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap7 <= Window21_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap8 <= Window22_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];

            Array_Mac7_ifmap0 <= Input_zero_point;
            Array_Mac7_ifmap1 <= Input_zero_point;
            Array_Mac7_ifmap2 <= Input_zero_point;
            Array_Mac7_ifmap3 <= Window10_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap4 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap5 <= Window12_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap6 <= Window20_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap7 <= Window21_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap8 <= Window22_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];

            Array_Mac8_ifmap0 <= Input_zero_point;
            Array_Mac8_ifmap1 <= Input_zero_point;
            Array_Mac8_ifmap2 <= Input_zero_point;
            Array_Mac8_ifmap3 <= Window10_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap4 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap5 <= Window12_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap6 <= Window20_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap7 <= Window21_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap8 <= Window22_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          end
          4'd4:
          begin
            //-------------                    >>> group 0 /////////////////
            Array_Mac0_ifmap0 <= Input_zero_point;
            Array_Mac0_ifmap1 <= Window01_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap2 <= Window02_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap3 <= Input_zero_point;
            Array_Mac0_ifmap4 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap5 <= Window12_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap6 <= Input_zero_point;
            Array_Mac0_ifmap7 <= Input_zero_point;
            Array_Mac0_ifmap8 <= Input_zero_point;

            Array_Mac1_ifmap0 <= Input_zero_point;
            Array_Mac1_ifmap1 <= Window01_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap2 <= Window02_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap3 <= Input_zero_point;
            Array_Mac1_ifmap4 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap5 <= Window12_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap6 <= Input_zero_point;
            Array_Mac1_ifmap7 <= Input_zero_point;
            Array_Mac1_ifmap8 <= Input_zero_point;

            Array_Mac2_ifmap0 <= Input_zero_point;
            Array_Mac2_ifmap1 <= Window01_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap2 <= Window02_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap3 <= Input_zero_point;
            Array_Mac2_ifmap4 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap5 <= Window12_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap6 <= Input_zero_point;
            Array_Mac2_ifmap7 <= Input_zero_point;
            Array_Mac2_ifmap8 <= Input_zero_point;

            //-------------                    >>> group 1 /////////////////
            Array_Mac3_ifmap0 <= Input_zero_point;
            Array_Mac3_ifmap1 <= Window01_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap2 <= Window02_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap3 <= Input_zero_point;
            Array_Mac3_ifmap4 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap5 <= Window12_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap6 <= Input_zero_point;
            Array_Mac3_ifmap7 <= Input_zero_point;
            Array_Mac3_ifmap8 <= Input_zero_point;

            Array_Mac4_ifmap0 <= Input_zero_point;
            Array_Mac4_ifmap1 <= Window01_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap2 <= Window02_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap3 <= Input_zero_point;
            Array_Mac4_ifmap4 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap5 <= Window12_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap6 <= Input_zero_point;
            Array_Mac4_ifmap7 <= Input_zero_point;
            Array_Mac4_ifmap8 <= Input_zero_point;

            Array_Mac5_ifmap0 <= Input_zero_point;
            Array_Mac5_ifmap1 <= Window01_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap2 <= Window02_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap3 <= Input_zero_point;
            Array_Mac5_ifmap4 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap5 <= Window12_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap6 <= Input_zero_point;
            Array_Mac5_ifmap7 <= Input_zero_point;
            Array_Mac5_ifmap8 <= Input_zero_point;

            //-------------                    >>> group 2 /////////////////
            Array_Mac6_ifmap0 <= Input_zero_point;
            Array_Mac6_ifmap1 <= Window01_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap2 <= Window02_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap3 <= Input_zero_point;
            Array_Mac6_ifmap4 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap5 <= Window12_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap6 <= Input_zero_point;
            Array_Mac6_ifmap7 <= Input_zero_point;
            Array_Mac6_ifmap8 <= Input_zero_point;

            Array_Mac7_ifmap0 <= Input_zero_point;
            Array_Mac7_ifmap1 <= Window01_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap2 <= Window02_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap3 <= Input_zero_point;
            Array_Mac7_ifmap4 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap5 <= Window12_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap6 <= Input_zero_point;
            Array_Mac7_ifmap7 <= Input_zero_point;
            Array_Mac7_ifmap8 <= Input_zero_point;

            Array_Mac8_ifmap0 <= Input_zero_point;
            Array_Mac8_ifmap1 <= Window01_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap2 <= Window02_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap3 <= Input_zero_point;
            Array_Mac8_ifmap4 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap5 <= Window12_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap6 <= Input_zero_point;
            Array_Mac8_ifmap7 <= Input_zero_point;
            Array_Mac8_ifmap8 <= Input_zero_point;
          end
          4'd5:
          begin
            //-------------                    >>> group 0 /////////////////
            Array_Mac0_ifmap0 <= Window00_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap1 <= Window01_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap2 <= Input_zero_point;
            Array_Mac0_ifmap3 <= Window10_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap4 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap5 <= Input_zero_point;
            Array_Mac0_ifmap6 <= Input_zero_point;
            Array_Mac0_ifmap7 <= Input_zero_point;
            Array_Mac0_ifmap8 <= Input_zero_point;

            Array_Mac1_ifmap0 <= Window00_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap1 <= Window01_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap2 <= Input_zero_point;
            Array_Mac1_ifmap3 <= Window10_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap4 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap5 <= Input_zero_point;
            Array_Mac1_ifmap6 <= Input_zero_point;
            Array_Mac1_ifmap7 <= Input_zero_point;
            Array_Mac1_ifmap8 <= Input_zero_point;

            Array_Mac2_ifmap0 <= Window00_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap1 <= Window01_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap2 <= Input_zero_point;
            Array_Mac2_ifmap3 <= Window10_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap4 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap5 <= Input_zero_point;
            Array_Mac2_ifmap6 <= Input_zero_point;
            Array_Mac2_ifmap7 <= Input_zero_point;
            Array_Mac2_ifmap8 <= Input_zero_point;

            //-------------                    >>> group 1 /////////////////
            Array_Mac3_ifmap0 <= Window00_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap1 <= Window01_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap2 <= Input_zero_point;
            Array_Mac3_ifmap3 <= Window10_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap4 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap5 <= Input_zero_point;
            Array_Mac3_ifmap6 <= Input_zero_point;
            Array_Mac3_ifmap7 <= Input_zero_point;
            Array_Mac3_ifmap8 <= Input_zero_point;

            Array_Mac4_ifmap0 <= Window00_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap1 <= Window01_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap2 <= Input_zero_point;
            Array_Mac4_ifmap3 <= Window10_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap4 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap5 <= Input_zero_point;
            Array_Mac4_ifmap6 <= Input_zero_point;
            Array_Mac4_ifmap7 <= Input_zero_point;
            Array_Mac4_ifmap8 <= Input_zero_point;

            Array_Mac5_ifmap0 <= Window00_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap1 <= Window01_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap2 <= Input_zero_point;
            Array_Mac5_ifmap3 <= Window10_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap4 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap5 <= Input_zero_point;
            Array_Mac5_ifmap6 <= Input_zero_point;
            Array_Mac5_ifmap7 <= Input_zero_point;
            Array_Mac5_ifmap8 <= Input_zero_point;

            //-------------                    >>> group 2 /////////////////
            Array_Mac6_ifmap0 <= Window00_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap1 <= Window01_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap2 <= Input_zero_point;
            Array_Mac6_ifmap3 <= Window10_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap4 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap5 <= Input_zero_point;
            Array_Mac6_ifmap6 <= Input_zero_point;
            Array_Mac6_ifmap7 <= Input_zero_point;
            Array_Mac6_ifmap8 <= Input_zero_point;

            Array_Mac7_ifmap0 <= Window00_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap1 <= Window01_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap2 <= Input_zero_point;
            Array_Mac7_ifmap3 <= Window10_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap4 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap5 <= Input_zero_point;
            Array_Mac7_ifmap6 <= Input_zero_point;
            Array_Mac7_ifmap7 <= Input_zero_point;
            Array_Mac7_ifmap8 <= Input_zero_point;

            Array_Mac8_ifmap0 <= Window00_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap1 <= Window01_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap2 <= Input_zero_point;
            Array_Mac8_ifmap3 <= Window10_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap4 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap5 <= Input_zero_point;
            Array_Mac8_ifmap6 <= Input_zero_point;
            Array_Mac8_ifmap7 <= Input_zero_point;
            Array_Mac8_ifmap8 <= Input_zero_point;
          end
          4'd6:
          begin
            //-------------                    >>> group 0 /////////////////
            Array_Mac0_ifmap0 <= Window00_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap1 <= Window01_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap2 <= Window02_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap3 <= Window10_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap4 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap5 <= Window12_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap6 <= Input_zero_point;
            Array_Mac0_ifmap7 <= Input_zero_point;
            Array_Mac0_ifmap8 <= Input_zero_point;

            Array_Mac1_ifmap0 <= Window00_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap1 <= Window01_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap2 <= Window02_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap3 <= Window10_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap4 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap5 <= Window12_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap6 <= Input_zero_point;
            Array_Mac1_ifmap7 <= Input_zero_point;
            Array_Mac1_ifmap8 <= Input_zero_point;

            Array_Mac2_ifmap0 <= Window00_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap1 <= Window01_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap2 <= Window02_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap3 <= Window10_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap4 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap5 <= Window12_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap6 <= Input_zero_point;
            Array_Mac2_ifmap7 <= Input_zero_point;
            Array_Mac2_ifmap8 <= Input_zero_point;

            //-------------                    >>> group 1 /////////////////
            Array_Mac3_ifmap0 <= Window00_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap1 <= Window01_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap2 <= Window02_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap3 <= Window10_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap4 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap5 <= Window12_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap6 <= Input_zero_point;
            Array_Mac3_ifmap7 <= Input_zero_point;
            Array_Mac3_ifmap8 <= Input_zero_point;

            Array_Mac4_ifmap0 <= Window00_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap1 <= Window01_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap2 <= Window02_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap3 <= Window10_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap4 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap5 <= Window12_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap6 <= Input_zero_point;
            Array_Mac4_ifmap7 <= Input_zero_point;
            Array_Mac4_ifmap8 <= Input_zero_point;

            Array_Mac5_ifmap0 <= Window00_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap1 <= Window01_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap2 <= Window02_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap3 <= Window10_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap4 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap5 <= Window12_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap6 <= Input_zero_point;
            Array_Mac5_ifmap7 <= Input_zero_point;
            Array_Mac5_ifmap8 <= Input_zero_point;

            //-------------                    >>> group 2 /////////////////
            Array_Mac6_ifmap0 <= Window00_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap1 <= Window01_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap2 <= Window02_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap3 <= Window10_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap4 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap5 <= Window12_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap6 <= Input_zero_point;
            Array_Mac6_ifmap7 <= Input_zero_point;
            Array_Mac6_ifmap8 <= Input_zero_point;

            Array_Mac7_ifmap0 <= Window00_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap1 <= Window01_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap2 <= Window02_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap3 <= Window10_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap4 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap5 <= Window12_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap6 <= Input_zero_point;
            Array_Mac7_ifmap7 <= Input_zero_point;
            Array_Mac7_ifmap8 <= Input_zero_point;

            Array_Mac8_ifmap0 <= Window00_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap1 <= Window01_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap2 <= Window02_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap3 <= Window10_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap4 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap5 <= Window12_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap6 <= Input_zero_point;
            Array_Mac8_ifmap7 <= Input_zero_point;
            Array_Mac8_ifmap8 <= Input_zero_point;
          end
          4'd7:
          begin
            //-------------                    >>> group 0 /////////////////
            Array_Mac0_ifmap0 <= Input_zero_point;
            Array_Mac0_ifmap1 <= Window01_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap2 <= Window02_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap3 <= Input_zero_point;
            Array_Mac0_ifmap4 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap5 <= Window12_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap6 <= Input_zero_point;
            Array_Mac0_ifmap7 <= Window21_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap8 <= Window22_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];

            Array_Mac1_ifmap0 <= Input_zero_point;
            Array_Mac1_ifmap1 <= Window01_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap2 <= Window02_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap3 <= Input_zero_point;
            Array_Mac1_ifmap4 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap5 <= Window12_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap6 <= Input_zero_point;
            Array_Mac1_ifmap7 <= Window21_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap8 <= Window22_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];

            Array_Mac2_ifmap0 <= Input_zero_point;
            Array_Mac2_ifmap1 <= Window01_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap2 <= Window02_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap3 <= Input_zero_point;
            Array_Mac2_ifmap4 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap5 <= Window12_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap6 <= Input_zero_point;
            Array_Mac2_ifmap7 <= Window21_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap8 <= Window22_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];

            //-------------                    >>> group 1 /////////////////
            Array_Mac3_ifmap0 <= Input_zero_point;
            Array_Mac3_ifmap1 <= Window01_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap2 <= Window02_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap3 <= Input_zero_point;
            Array_Mac3_ifmap4 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap5 <= Window12_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap6 <= Input_zero_point;
            Array_Mac3_ifmap7 <= Window21_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap8 <= Window22_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];

            Array_Mac4_ifmap0 <= Input_zero_point;
            Array_Mac4_ifmap1 <= Window01_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap2 <= Window02_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap3 <= Input_zero_point;
            Array_Mac4_ifmap4 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap5 <= Window12_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap6 <= Input_zero_point;
            Array_Mac4_ifmap7 <= Window21_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap8 <= Window22_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];

            Array_Mac5_ifmap0 <= Input_zero_point;
            Array_Mac5_ifmap1 <= Window01_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap2 <= Window02_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap3 <= Input_zero_point;
            Array_Mac5_ifmap4 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap5 <= Window12_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap6 <= Input_zero_point;
            Array_Mac5_ifmap7 <= Window21_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap8 <= Window22_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];

            //-------------                    >>> group 2 /////////////////
            Array_Mac6_ifmap0 <= Input_zero_point;
            Array_Mac6_ifmap1 <= Window01_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap2 <= Window02_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap3 <= Input_zero_point;
            Array_Mac6_ifmap4 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap5 <= Window12_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap6 <= Input_zero_point;
            Array_Mac6_ifmap7 <= Window21_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap8 <= Window22_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];

            Array_Mac7_ifmap0 <= Input_zero_point;
            Array_Mac7_ifmap1 <= Window01_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap2 <= Window02_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap3 <= Input_zero_point;
            Array_Mac7_ifmap4 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap5 <= Window12_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap6 <= Input_zero_point;
            Array_Mac7_ifmap7 <= Window21_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap8 <= Window22_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];

            Array_Mac8_ifmap0 <= Input_zero_point;
            Array_Mac8_ifmap1 <= Window01_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap2 <= Window02_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap3 <= Input_zero_point;
            Array_Mac8_ifmap4 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap5 <= Window12_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap6 <= Input_zero_point;
            Array_Mac8_ifmap7 <= Window21_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap8 <= Window22_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          end
          4'd8:
          begin
            //-------------                    >>> group 0 /////////////////
            Array_Mac0_ifmap0 <= Window00_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap1 <= Window01_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap2 <= Input_zero_point;
            Array_Mac0_ifmap3 <= Window10_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap4 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap5 <= Input_zero_point;
            Array_Mac0_ifmap6 <= Window20_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap7 <= Window21_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap8 <= Input_zero_point;

            Array_Mac1_ifmap0 <= Window00_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap1 <= Window01_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap2 <= Input_zero_point;
            Array_Mac1_ifmap3 <= Window10_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap4 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap5 <= Input_zero_point;
            Array_Mac1_ifmap6 <= Window20_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap7 <= Window21_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap8 <= Input_zero_point;

            Array_Mac2_ifmap0 <= Window00_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap1 <= Window01_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap2 <= Input_zero_point;
            Array_Mac2_ifmap3 <= Window10_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap4 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap5 <= Input_zero_point;
            Array_Mac2_ifmap6 <= Window20_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap7 <= Window21_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap8 <= Input_zero_point;

            //-------------                    >>> group 1 /////////////////
            Array_Mac3_ifmap0 <= Window00_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap1 <= Window01_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap2 <= Input_zero_point;
            Array_Mac3_ifmap3 <= Window10_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap4 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap5 <= Input_zero_point;
            Array_Mac3_ifmap6 <= Window20_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap7 <= Window21_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap8 <= Input_zero_point;

            Array_Mac4_ifmap0 <= Window00_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap1 <= Window01_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap2 <= Input_zero_point;
            Array_Mac4_ifmap3 <= Window10_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap4 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap5 <= Input_zero_point;
            Array_Mac4_ifmap6 <= Window20_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap7 <= Window21_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap8 <= Window22_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];

            Array_Mac5_ifmap0 <= Window00_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap1 <= Window01_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap2 <= Input_zero_point;
            Array_Mac5_ifmap3 <= Window10_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap4 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap5 <= Input_zero_point;
            Array_Mac5_ifmap6 <= Window20_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap7 <= Window21_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap8 <= Input_zero_point;

            //-------------                    >>> group 2 /////////////////
            Array_Mac6_ifmap0 <= Window00_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap1 <= Window01_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap2 <= Input_zero_point;
            Array_Mac6_ifmap3 <= Window10_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap4 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap5 <= Input_zero_point;
            Array_Mac6_ifmap6 <= Window20_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap7 <= Window21_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap8 <= Input_zero_point;

            Array_Mac7_ifmap0 <= Window00_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap1 <= Window01_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap2 <= Input_zero_point;
            Array_Mac7_ifmap3 <= Window10_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap4 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap5 <= Input_zero_point;
            Array_Mac7_ifmap6 <= Window20_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap7 <= Window21_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap8 <= Input_zero_point;

            Array_Mac8_ifmap0 <= Window00_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap1 <= Window01_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap2 <= Input_zero_point;
            Array_Mac8_ifmap3 <= Window10_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap4 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap5 <= Input_zero_point;
            Array_Mac8_ifmap6 <= Window20_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap7 <= Window21_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap8 <= Input_zero_point;
          end
          4'd9:
          begin
            //-------------                    >>> group 0 /////////////////
            Array_Mac0_ifmap0 <= Window00_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap1 <= Window01_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap2 <= Window02_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap3 <= Window10_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap4 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap5 <= Window12_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap6 <= Window20_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap7 <= Window21_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac0_ifmap8 <= Window22_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];

            Array_Mac1_ifmap0 <= Window00_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap1 <= Window01_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap2 <= Window02_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap3 <= Window10_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap4 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap5 <= Window12_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap6 <= Window20_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap7 <= Window21_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac1_ifmap8 <= Window22_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];

            Array_Mac2_ifmap0 <= Window00_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap1 <= Window01_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap2 <= Window02_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap3 <= Window10_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap4 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap5 <= Window12_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap6 <= Window20_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap7 <= Window21_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac2_ifmap8 <= Window22_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];

            //-------------                    >>> group 1 /////////////////
            Array_Mac3_ifmap0 <= Window00_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap1 <= Window01_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap2 <= Window02_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap3 <= Window10_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap4 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap5 <= Window12_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap6 <= Window20_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap7 <= Window21_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac3_ifmap8 <= Window22_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];

            Array_Mac4_ifmap0 <= Window00_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap1 <= Window01_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap2 <= Window02_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap3 <= Window10_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap4 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap5 <= Window12_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap6 <= Window20_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap7 <= Window21_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac4_ifmap8 <= Window22_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];

            Array_Mac5_ifmap0 <= Window00_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap1 <= Window01_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap2 <= Window02_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap3 <= Window10_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap4 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap5 <= Window12_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap6 <= Window20_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap7 <= Window21_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac5_ifmap8 <= Window22_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];

            //-------------                    >>> group 2 /////////////////
            Array_Mac6_ifmap0 <= Window00_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap1 <= Window01_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap2 <= Window02_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap3 <= Window10_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap4 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap5 <= Window12_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap6 <= Window20_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap7 <= Window21_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
            Array_Mac6_ifmap8 <= Window22_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];

            Array_Mac7_ifmap0 <= Window00_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap1 <= Window01_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap2 <= Window02_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap3 <= Window10_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap4 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap5 <= Window12_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap6 <= Window20_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap7 <= Window21_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
            Array_Mac7_ifmap8 <= Window22_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];

            Array_Mac8_ifmap0 <= Window00_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap1 <= Window01_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap2 <= Window02_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap3 <= Window10_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap4 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap5 <= Window12_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap6 <= Window20_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap7 <= Window21_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
            Array_Mac8_ifmap8 <= Window22_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          end
          default:
          begin
            Array_Mac0_ifmap0 <= 0;
            Array_Mac0_ifmap1 <= 0;
            Array_Mac0_ifmap2 <= 0;
            Array_Mac0_ifmap3 <= 0;
            Array_Mac0_ifmap4 <= 0;
            Array_Mac0_ifmap5 <= 0;
            Array_Mac0_ifmap6 <= 0;
            Array_Mac0_ifmap7 <= 0;
            Array_Mac0_ifmap8 <= 0;

            Array_Mac1_ifmap0 <= 0;
            Array_Mac1_ifmap1 <= 0;
            Array_Mac1_ifmap2 <= 0;
            Array_Mac1_ifmap3 <= 0;
            Array_Mac1_ifmap4 <= 0;
            Array_Mac1_ifmap5 <= 0;
            Array_Mac1_ifmap6 <= 0;
            Array_Mac1_ifmap7 <= 0;
            Array_Mac1_ifmap8 <= 0;

            Array_Mac2_ifmap0 <= 0;
            Array_Mac2_ifmap1 <= 0;
            Array_Mac2_ifmap2 <= 0;
            Array_Mac2_ifmap3 <= 0;
            Array_Mac2_ifmap4 <= 0;
            Array_Mac2_ifmap5 <= 0;
            Array_Mac2_ifmap6 <= 0;
            Array_Mac2_ifmap7 <= 0;
            Array_Mac2_ifmap8 <= 0;

            Array_Mac3_ifmap0 <= 0;
            Array_Mac3_ifmap1 <= 0;
            Array_Mac3_ifmap2 <= 0;
            Array_Mac3_ifmap3 <= 0;
            Array_Mac3_ifmap4 <= 0;
            Array_Mac3_ifmap5 <= 0;
            Array_Mac3_ifmap6 <= 0;
            Array_Mac3_ifmap7 <= 0;
            Array_Mac3_ifmap8 <= 0;

            Array_Mac4_ifmap0 <= 0;
            Array_Mac4_ifmap1 <= 0;
            Array_Mac4_ifmap2 <= 0;
            Array_Mac4_ifmap3 <= 0;
            Array_Mac4_ifmap4 <= 0;
            Array_Mac4_ifmap5 <= 0;
            Array_Mac4_ifmap6 <= 0;
            Array_Mac4_ifmap7 <= 0;
            Array_Mac4_ifmap8 <= 0;

            Array_Mac5_ifmap0 <= 0;
            Array_Mac5_ifmap1 <= 0;
            Array_Mac5_ifmap2 <= 0;
            Array_Mac5_ifmap3 <= 0;
            Array_Mac5_ifmap4 <= 0;
            Array_Mac5_ifmap5 <= 0;
            Array_Mac5_ifmap6 <= 0;
            Array_Mac5_ifmap7 <= 0;
            Array_Mac5_ifmap8 <= 0;

            Array_Mac6_ifmap0 <= 0;
            Array_Mac6_ifmap1 <= 0;
            Array_Mac6_ifmap2 <= 0;
            Array_Mac6_ifmap3 <= 0;
            Array_Mac6_ifmap4 <= 0;
            Array_Mac6_ifmap5 <= 0;
            Array_Mac6_ifmap6 <= 0;
            Array_Mac6_ifmap7 <= 0;
            Array_Mac6_ifmap8 <= 0;

            Array_Mac7_ifmap0 <= 0;
            Array_Mac7_ifmap1 <= 0;
            Array_Mac7_ifmap2 <= 0;
            Array_Mac7_ifmap3 <= 0;
            Array_Mac7_ifmap4 <= 0;
            Array_Mac7_ifmap5 <= 0;
            Array_Mac7_ifmap6 <= 0;
            Array_Mac7_ifmap7 <= 0;
            Array_Mac7_ifmap8 <= 0;

            Array_Mac8_ifmap0 <= 0;
            Array_Mac8_ifmap1 <= 0;
            Array_Mac8_ifmap2 <= 0;
            Array_Mac8_ifmap3 <= 0;
            Array_Mac8_ifmap4 <= 0;
            Array_Mac8_ifmap5 <= 0;
            Array_Mac8_ifmap6 <= 0;
            Array_Mac8_ifmap7 <= 0;
            Array_Mac8_ifmap8 <= 0;
          end
        endcase
      end
      3'd2:   //DW
      case(padding_scenario_decoder)
        4'd0:
        begin
          Array_Mac0_ifmap0 <= 0;
          Array_Mac0_ifmap1 <= 0;
          Array_Mac0_ifmap2 <= 0;
          Array_Mac0_ifmap3 <= 0;
          Array_Mac0_ifmap4 <= 0;
          Array_Mac0_ifmap5 <= 0;
          Array_Mac0_ifmap6 <= 0;
          Array_Mac0_ifmap7 <= 0;
          Array_Mac0_ifmap8 <= 0;

          Array_Mac1_ifmap0 <= 0;
          Array_Mac1_ifmap1 <= 0;
          Array_Mac1_ifmap2 <= 0;
          Array_Mac1_ifmap3 <= 0;
          Array_Mac1_ifmap4 <= 0;
          Array_Mac1_ifmap5 <= 0;
          Array_Mac1_ifmap6 <= 0;
          Array_Mac1_ifmap7 <= 0;
          Array_Mac1_ifmap8 <= 0;

          Array_Mac2_ifmap0 <= 0;
          Array_Mac2_ifmap1 <= 0;
          Array_Mac2_ifmap2 <= 0;
          Array_Mac2_ifmap3 <= 0;
          Array_Mac2_ifmap4 <= 0;
          Array_Mac2_ifmap5 <= 0;
          Array_Mac2_ifmap6 <= 0;
          Array_Mac2_ifmap7 <= 0;
          Array_Mac2_ifmap8 <= 0;

          Array_Mac3_ifmap0 <= 0;
          Array_Mac3_ifmap1 <= 0;
          Array_Mac3_ifmap2 <= 0;
          Array_Mac3_ifmap3 <= 0;
          Array_Mac3_ifmap4 <= 0;
          Array_Mac3_ifmap5 <= 0;
          Array_Mac3_ifmap6 <= 0;
          Array_Mac3_ifmap7 <= 0;
          Array_Mac3_ifmap8 <= 0;

          Array_Mac4_ifmap0 <= 0;
          Array_Mac4_ifmap1 <= 0;
          Array_Mac4_ifmap2 <= 0;
          Array_Mac4_ifmap3 <= 0;
          Array_Mac4_ifmap4 <= 0;
          Array_Mac4_ifmap5 <= 0;
          Array_Mac4_ifmap6 <= 0;
          Array_Mac4_ifmap7 <= 0;
          Array_Mac4_ifmap8 <= 0;

          Array_Mac5_ifmap0 <= 0;
          Array_Mac5_ifmap1 <= 0;
          Array_Mac5_ifmap2 <= 0;
          Array_Mac5_ifmap3 <= 0;
          Array_Mac5_ifmap4 <= 0;
          Array_Mac5_ifmap5 <= 0;
          Array_Mac5_ifmap6 <= 0;
          Array_Mac5_ifmap7 <= 0;
          Array_Mac5_ifmap8 <= 0;

          Array_Mac6_ifmap0 <= 0;
          Array_Mac6_ifmap1 <= 0;
          Array_Mac6_ifmap2 <= 0;
          Array_Mac6_ifmap3 <= 0;
          Array_Mac6_ifmap4 <= 0;
          Array_Mac6_ifmap5 <= 0;
          Array_Mac6_ifmap6 <= 0;
          Array_Mac6_ifmap7 <= 0;
          Array_Mac6_ifmap8 <= 0;

          Array_Mac7_ifmap0 <= 0;
          Array_Mac7_ifmap1 <= 0;
          Array_Mac7_ifmap2 <= 0;
          Array_Mac7_ifmap3 <= 0;
          Array_Mac7_ifmap4 <= 0;
          Array_Mac7_ifmap5 <= 0;
          Array_Mac7_ifmap6 <= 0;
          Array_Mac7_ifmap7 <= 0;
          Array_Mac7_ifmap8 <= 0;

          Array_Mac8_ifmap0 <= 0;
          Array_Mac8_ifmap1 <= 0;
          Array_Mac8_ifmap2 <= 0;
          Array_Mac8_ifmap3 <= 0;
          Array_Mac8_ifmap4 <= 0;
          Array_Mac8_ifmap5 <= 0;
          Array_Mac8_ifmap6 <= 0;
          Array_Mac8_ifmap7 <= 0;
          Array_Mac8_ifmap8 <= 0;
        end
        4'd1:
        begin
          Array_Mac0_ifmap0 <= Input_zero_point;
          Array_Mac0_ifmap1 <= Input_zero_point;
          Array_Mac0_ifmap2 <= Input_zero_point;
          Array_Mac0_ifmap3 <= Input_zero_point;
          Array_Mac0_ifmap4 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap5 <= Window12_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap6 <= Input_zero_point;
          Array_Mac0_ifmap7 <= Window21_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap8 <= Window22_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];

          Array_Mac1_ifmap0 <= Input_zero_point;
          Array_Mac1_ifmap1 <= Input_zero_point;
          Array_Mac1_ifmap2 <= Input_zero_point;
          Array_Mac1_ifmap3 <= Input_zero_point;
          Array_Mac1_ifmap4 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap5 <= Window12_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap6 <= Input_zero_point;
          Array_Mac1_ifmap7 <= Window21_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap8 <= Window22_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];

          Array_Mac2_ifmap0 <= Input_zero_point;
          Array_Mac2_ifmap1 <= Input_zero_point;
          Array_Mac2_ifmap2 <= Input_zero_point;
          Array_Mac2_ifmap3 <= Input_zero_point;
          Array_Mac2_ifmap4 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap5 <= Window12_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap6 <= Input_zero_point;
          Array_Mac2_ifmap7 <= Window21_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap8 <= Window22_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];

          Array_Mac3_ifmap0 <= Input_zero_point;
          Array_Mac3_ifmap1 <= Input_zero_point;
          Array_Mac3_ifmap2 <= Input_zero_point;
          Array_Mac3_ifmap3 <= Input_zero_point;
          Array_Mac3_ifmap4 <= Window11_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap5 <= Window12_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap6 <= Input_zero_point;
          Array_Mac3_ifmap7 <= Window21_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap8 <= Window22_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];

          Array_Mac4_ifmap0 <= Input_zero_point;
          Array_Mac4_ifmap1 <= Input_zero_point;
          Array_Mac4_ifmap2 <= Input_zero_point;
          Array_Mac4_ifmap3 <= Input_zero_point;
          Array_Mac4_ifmap4 <= Window11_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap5 <= Window12_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap6 <= Input_zero_point;
          Array_Mac4_ifmap7 <= Window21_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap8 <= Window22_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];

          Array_Mac5_ifmap0 <= Input_zero_point;
          Array_Mac5_ifmap1 <= Input_zero_point;
          Array_Mac5_ifmap2 <= Input_zero_point;
          Array_Mac5_ifmap3 <= Input_zero_point;
          Array_Mac5_ifmap4 <= Window11_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap5 <= Window12_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap6 <= Input_zero_point;
          Array_Mac5_ifmap7 <= Window21_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap8 <= Window22_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];

          Array_Mac6_ifmap0 <= Input_zero_point;
          Array_Mac6_ifmap1 <= Input_zero_point;
          Array_Mac6_ifmap2 <= Input_zero_point;
          Array_Mac6_ifmap3 <= Input_zero_point;
          Array_Mac6_ifmap4 <= Window11_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap5 <= Window12_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap6 <= Input_zero_point;
          Array_Mac6_ifmap7 <= Window21_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap8 <= Window22_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];

          Array_Mac7_ifmap0 <= Input_zero_point;
          Array_Mac7_ifmap1 <= Input_zero_point;
          Array_Mac7_ifmap2 <= Input_zero_point;
          Array_Mac7_ifmap3 <= Input_zero_point;
          Array_Mac7_ifmap4 <= Window11_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap5 <= Window12_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap6 <= Input_zero_point;
          Array_Mac7_ifmap7 <= Window21_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap8 <= Window22_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];

          Array_Mac8_ifmap0 <= Input_zero_point;
          Array_Mac8_ifmap1 <= Input_zero_point;
          Array_Mac8_ifmap2 <= Input_zero_point;
          Array_Mac8_ifmap3 <= Input_zero_point;
          Array_Mac8_ifmap4 <= Window11_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap5 <= Window12_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap6 <= Input_zero_point;
          Array_Mac8_ifmap7 <= Window21_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap8 <= Window22_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
        end
        4'd2:
        begin
          Array_Mac0_ifmap0 <= Input_zero_point;
          Array_Mac0_ifmap1 <= Input_zero_point;
          Array_Mac0_ifmap2 <= Input_zero_point;
          Array_Mac0_ifmap3 <= Window10_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap4 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap5 <= Input_zero_point;
          Array_Mac0_ifmap6 <= Window20_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap7 <= Window21_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap8 <= Input_zero_point;

          Array_Mac1_ifmap0 <= Input_zero_point;
          Array_Mac1_ifmap1 <= Input_zero_point;
          Array_Mac1_ifmap2 <= Input_zero_point;
          Array_Mac1_ifmap3 <= Window10_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap4 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap5 <= Input_zero_point;
          Array_Mac1_ifmap6 <= Window20_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap7 <= Window21_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap8 <= Input_zero_point;

          Array_Mac2_ifmap0 <= Input_zero_point;
          Array_Mac2_ifmap1 <= Input_zero_point;
          Array_Mac2_ifmap2 <= Input_zero_point;
          Array_Mac2_ifmap3 <= Window10_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap4 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap5 <= Input_zero_point;
          Array_Mac2_ifmap6 <= Window20_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap7 <= Window21_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap8 <= Input_zero_point;

          Array_Mac3_ifmap0 <= Input_zero_point;
          Array_Mac3_ifmap1 <= Input_zero_point;
          Array_Mac3_ifmap2 <= Input_zero_point;
          Array_Mac3_ifmap3 <= Window10_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap4 <= Window11_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap5 <= Input_zero_point;
          Array_Mac3_ifmap6 <= Window20_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap7 <= Window21_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap8 <= Input_zero_point;

          Array_Mac4_ifmap0 <= Input_zero_point;
          Array_Mac4_ifmap1 <= Input_zero_point;
          Array_Mac4_ifmap2 <= Input_zero_point;
          Array_Mac4_ifmap3 <= Window10_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap4 <= Window11_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap5 <= Input_zero_point;
          Array_Mac4_ifmap6 <= Window20_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap7 <= Window21_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap8 <= Input_zero_point;

          Array_Mac5_ifmap0 <= Input_zero_point;
          Array_Mac5_ifmap1 <= Input_zero_point;
          Array_Mac5_ifmap2 <= Input_zero_point;
          Array_Mac5_ifmap3 <= Window10_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap4 <= Window11_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap5 <= Input_zero_point;
          Array_Mac5_ifmap6 <= Window20_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap7 <= Window21_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap8 <= Input_zero_point;

          Array_Mac6_ifmap0 <= Input_zero_point;
          Array_Mac6_ifmap1 <= Input_zero_point;
          Array_Mac6_ifmap2 <= Input_zero_point;
          Array_Mac6_ifmap3 <= Window10_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap4 <= Window11_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap5 <= Input_zero_point;
          Array_Mac6_ifmap6 <= Window20_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap7 <= Window21_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap8 <= Input_zero_point;

          Array_Mac7_ifmap0 <= Input_zero_point;
          Array_Mac7_ifmap1 <= Input_zero_point;
          Array_Mac7_ifmap2 <= Input_zero_point;
          Array_Mac7_ifmap3 <= Window10_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap4 <= Window11_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap5 <= Input_zero_point;
          Array_Mac7_ifmap6 <= Window20_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap7 <= Window21_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap8 <= Input_zero_point;

          Array_Mac8_ifmap0 <= Input_zero_point;
          Array_Mac8_ifmap1 <= Input_zero_point;
          Array_Mac8_ifmap2 <= Input_zero_point;
          Array_Mac8_ifmap3 <= Window10_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap4 <= Window11_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap5 <= Input_zero_point;
          Array_Mac8_ifmap6 <= Window20_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap7 <= Window21_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap8 <= Input_zero_point;
        end
        4'd3:
        begin
          Array_Mac0_ifmap0 <= Input_zero_point;
          Array_Mac0_ifmap1 <= Input_zero_point;
          Array_Mac0_ifmap2 <= Input_zero_point;
          Array_Mac0_ifmap3 <= Window10_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap4 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap5 <= Window12_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap6 <= Window20_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap7 <= Window21_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap8 <= Window22_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];

          Array_Mac1_ifmap0 <= Input_zero_point;
          Array_Mac1_ifmap1 <= Input_zero_point;
          Array_Mac1_ifmap2 <= Input_zero_point;
          Array_Mac1_ifmap3 <= Window10_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap4 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap5 <= Window12_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap6 <= Window20_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap7 <= Window21_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap8 <= Window22_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];

          Array_Mac2_ifmap0 <= Input_zero_point;
          Array_Mac2_ifmap1 <= Input_zero_point;
          Array_Mac2_ifmap2 <= Input_zero_point;
          Array_Mac2_ifmap3 <= Window10_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap4 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap5 <= Window12_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap6 <= Window20_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap7 <= Window21_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap8 <= Window22_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];

          Array_Mac3_ifmap0 <= Input_zero_point;
          Array_Mac3_ifmap1 <= Input_zero_point;
          Array_Mac3_ifmap2 <= Input_zero_point;
          Array_Mac3_ifmap3 <= Window10_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap4 <= Window11_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap5 <= Window12_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap6 <= Window20_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap7 <= Window21_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap8 <= Window22_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];

          Array_Mac4_ifmap0 <= Input_zero_point;
          Array_Mac4_ifmap1 <= Input_zero_point;
          Array_Mac4_ifmap2 <= Input_zero_point;
          Array_Mac4_ifmap3 <= Window10_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap4 <= Window11_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap5 <= Window12_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap6 <= Window20_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap7 <= Window21_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap8 <= Window22_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];

          Array_Mac5_ifmap0 <= Input_zero_point;
          Array_Mac5_ifmap1 <= Input_zero_point;
          Array_Mac5_ifmap2 <= Input_zero_point;
          Array_Mac5_ifmap3 <= Window10_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap4 <= Window11_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap5 <= Window12_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap6 <= Window20_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap7 <= Window21_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap8 <= Window22_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];

          Array_Mac6_ifmap0 <= Input_zero_point;
          Array_Mac6_ifmap1 <= Input_zero_point;
          Array_Mac6_ifmap2 <= Input_zero_point;
          Array_Mac6_ifmap3 <= Window10_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap4 <= Window11_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap5 <= Window12_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap6 <= Window20_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap7 <= Window21_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap8 <= Window22_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];

          Array_Mac7_ifmap0 <= Input_zero_point;
          Array_Mac7_ifmap1 <= Input_zero_point;
          Array_Mac7_ifmap2 <= Input_zero_point;
          Array_Mac7_ifmap3 <= Window10_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap4 <= Window11_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap5 <= Window12_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap6 <= Window20_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap7 <= Window21_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap8 <= Window22_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];

          Array_Mac8_ifmap0 <= Input_zero_point;
          Array_Mac8_ifmap1 <= Input_zero_point;
          Array_Mac8_ifmap2 <= Input_zero_point;
          Array_Mac8_ifmap3 <= Window10_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap4 <= Window11_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap5 <= Window12_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap6 <= Window20_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap7 <= Window21_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap8 <= Window22_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
        end
        4'd4:
        begin
          Array_Mac0_ifmap0 <= Input_zero_point;
          Array_Mac0_ifmap1 <= Window01_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap2 <= Window02_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap3 <= Input_zero_point;
          Array_Mac0_ifmap4 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap5 <= Window12_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap6 <= Input_zero_point;
          Array_Mac0_ifmap7 <= Input_zero_point;
          Array_Mac0_ifmap8 <= Input_zero_point;

          Array_Mac1_ifmap0 <= Input_zero_point;
          Array_Mac1_ifmap1 <= Window01_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap2 <= Window02_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap3 <= Input_zero_point;
          Array_Mac1_ifmap4 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap5 <= Window12_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap6 <= Input_zero_point;
          Array_Mac1_ifmap7 <= Input_zero_point;
          Array_Mac1_ifmap8 <= Input_zero_point;

          Array_Mac2_ifmap0 <= Input_zero_point;
          Array_Mac2_ifmap1 <= Window01_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap2 <= Window02_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap3 <= Input_zero_point;
          Array_Mac2_ifmap4 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap5 <= Window12_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap6 <= Input_zero_point;
          Array_Mac2_ifmap7 <= Input_zero_point;
          Array_Mac2_ifmap8 <= Input_zero_point;

          Array_Mac3_ifmap0 <= Input_zero_point;
          Array_Mac3_ifmap1 <= Window01_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap2 <= Window02_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap3 <= Input_zero_point;
          Array_Mac3_ifmap4 <= Window11_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap5 <= Window12_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap6 <= Input_zero_point;
          Array_Mac3_ifmap7 <= Input_zero_point;
          Array_Mac3_ifmap8 <= Input_zero_point;

          Array_Mac4_ifmap0 <= Input_zero_point;
          Array_Mac4_ifmap1 <= Window01_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap2 <= Window02_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap3 <= Input_zero_point;
          Array_Mac4_ifmap4 <= Window11_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap5 <= Window12_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap6 <= Input_zero_point;
          Array_Mac4_ifmap7 <= Input_zero_point;
          Array_Mac4_ifmap8 <= Input_zero_point;

          Array_Mac5_ifmap0 <= Input_zero_point;
          Array_Mac5_ifmap1 <= Window01_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap2 <= Window02_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap3 <= Input_zero_point;
          Array_Mac5_ifmap4 <= Window11_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap5 <= Window12_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap6 <= Input_zero_point;
          Array_Mac5_ifmap7 <= Input_zero_point;
          Array_Mac5_ifmap8 <= Input_zero_point;

          Array_Mac6_ifmap0 <= Input_zero_point;
          Array_Mac6_ifmap1 <= Window01_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap2 <= Window02_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap3 <= Input_zero_point;
          Array_Mac6_ifmap4 <= Window11_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap5 <= Window12_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap6 <= Input_zero_point;
          Array_Mac6_ifmap7 <= Input_zero_point;
          Array_Mac6_ifmap8 <= Input_zero_point;

          Array_Mac7_ifmap0 <= Input_zero_point;
          Array_Mac7_ifmap1 <= Window01_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap2 <= Window02_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap3 <= Input_zero_point;
          Array_Mac7_ifmap4 <= Window11_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap5 <= Window12_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap6 <= Input_zero_point;
          Array_Mac7_ifmap7 <= Input_zero_point;
          Array_Mac7_ifmap8 <= Input_zero_point;

          Array_Mac8_ifmap0 <= Input_zero_point;
          Array_Mac8_ifmap1 <= Window01_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap2 <= Window02_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap3 <= Input_zero_point;
          Array_Mac8_ifmap4 <= Window11_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap5 <= Window12_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap6 <= Input_zero_point;
          Array_Mac8_ifmap7 <= Input_zero_point;
          Array_Mac8_ifmap8 <= Input_zero_point;
        end
        4'd5:
        begin
          Array_Mac0_ifmap0 <= Window00_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap1 <= Window01_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap2 <= Input_zero_point;
          Array_Mac0_ifmap3 <= Window10_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap4 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap5 <= Input_zero_point;
          Array_Mac0_ifmap6 <= Input_zero_point;
          Array_Mac0_ifmap7 <= Input_zero_point;
          Array_Mac0_ifmap8 <= Input_zero_point;

          Array_Mac1_ifmap0 <= Window00_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap1 <= Window01_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap2 <= Input_zero_point;
          Array_Mac1_ifmap3 <= Window10_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap4 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap5 <= Input_zero_point;
          Array_Mac1_ifmap6 <= Input_zero_point;
          Array_Mac1_ifmap7 <= Input_zero_point;
          Array_Mac1_ifmap8 <= Input_zero_point;

          Array_Mac2_ifmap0 <= Window00_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap1 <= Window01_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap2 <= Input_zero_point;
          Array_Mac2_ifmap3 <= Window10_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap4 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap5 <= Input_zero_point;
          Array_Mac2_ifmap6 <= Input_zero_point;
          Array_Mac2_ifmap7 <= Input_zero_point;
          Array_Mac2_ifmap8 <= Input_zero_point;

          Array_Mac3_ifmap0 <= Window00_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap1 <= Window01_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap2 <= Input_zero_point;
          Array_Mac3_ifmap3 <= Window10_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap4 <= Window11_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap5 <= Input_zero_point;
          Array_Mac3_ifmap6 <= Input_zero_point;
          Array_Mac3_ifmap7 <= Input_zero_point;
          Array_Mac3_ifmap8 <= Input_zero_point;

          Array_Mac4_ifmap0 <= Window00_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap1 <= Window01_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap2 <= Input_zero_point;
          Array_Mac4_ifmap3 <= Window10_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap4 <= Window11_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap5 <= Input_zero_point;
          Array_Mac4_ifmap6 <= Input_zero_point;
          Array_Mac4_ifmap7 <= Input_zero_point;
          Array_Mac4_ifmap8 <= Input_zero_point;

          Array_Mac5_ifmap0 <= Window00_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap1 <= Window01_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap2 <= Input_zero_point;
          Array_Mac5_ifmap3 <= Window10_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap4 <= Window11_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap5 <= Input_zero_point;
          Array_Mac5_ifmap6 <= Input_zero_point;
          Array_Mac5_ifmap7 <= Input_zero_point;
          Array_Mac5_ifmap8 <= Input_zero_point;

          Array_Mac6_ifmap0 <= Window00_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap1 <= Window01_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap2 <= Input_zero_point;
          Array_Mac6_ifmap3 <= Window10_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap4 <= Window11_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap5 <= Input_zero_point;
          Array_Mac6_ifmap6 <= Input_zero_point;
          Array_Mac6_ifmap7 <= Input_zero_point;
          Array_Mac6_ifmap8 <= Input_zero_point;

          Array_Mac7_ifmap0 <= Window00_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap1 <= Window01_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap2 <= Input_zero_point;
          Array_Mac7_ifmap3 <= Window10_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap4 <= Window11_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap5 <= Input_zero_point;
          Array_Mac7_ifmap6 <= Input_zero_point;
          Array_Mac7_ifmap7 <= Input_zero_point;
          Array_Mac7_ifmap8 <= Input_zero_point;

          Array_Mac8_ifmap0 <= Window00_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap1 <= Window01_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap2 <= Input_zero_point;
          Array_Mac8_ifmap3 <= Window10_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap4 <= Window11_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap5 <= Input_zero_point;
          Array_Mac8_ifmap6 <= Input_zero_point;
          Array_Mac8_ifmap7 <= Input_zero_point;
          Array_Mac8_ifmap8 <= Input_zero_point;
        end
        4'd6:
        begin
          Array_Mac0_ifmap0 <= Window00_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap1 <= Window01_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap2 <= Window02_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap3 <= Window10_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap4 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap5 <= Window12_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap6 <= Input_zero_point;
          Array_Mac0_ifmap7 <= Input_zero_point;
          Array_Mac0_ifmap8 <= Input_zero_point;

          Array_Mac1_ifmap0 <= Window00_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap1 <= Window01_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap2 <= Window02_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap3 <= Window10_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap4 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap5 <= Window12_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap6 <= Input_zero_point;
          Array_Mac1_ifmap7 <= Input_zero_point;
          Array_Mac1_ifmap8 <= Input_zero_point;

          Array_Mac2_ifmap0 <= Window00_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap1 <= Window01_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap2 <= Window02_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap3 <= Window10_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap4 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap5 <= Window12_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap6 <= Input_zero_point;
          Array_Mac2_ifmap7 <= Input_zero_point;
          Array_Mac2_ifmap8 <= Input_zero_point;

          Array_Mac3_ifmap0 <= Window00_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap1 <= Window01_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap2 <= Window02_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap3 <= Window10_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap4 <= Window11_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap5 <= Window12_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap6 <= Input_zero_point;
          Array_Mac3_ifmap7 <= Input_zero_point;
          Array_Mac3_ifmap8 <= Input_zero_point;

          Array_Mac4_ifmap0 <= Window00_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap1 <= Window01_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap2 <= Window02_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap3 <= Window10_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap4 <= Window11_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap5 <= Window12_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap6 <= Input_zero_point;
          Array_Mac4_ifmap7 <= Input_zero_point;
          Array_Mac4_ifmap8 <= Input_zero_point;

          Array_Mac5_ifmap0 <= Window00_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap1 <= Window01_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap2 <= Window02_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap3 <= Window10_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap4 <= Window11_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap5 <= Window12_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap6 <= Input_zero_point;
          Array_Mac5_ifmap7 <= Input_zero_point;
          Array_Mac5_ifmap8 <= Input_zero_point;

          Array_Mac6_ifmap0 <= Window00_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap1 <= Window01_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap2 <= Window02_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap3 <= Window10_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap4 <= Window11_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap5 <= Window12_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap6 <= Input_zero_point;
          Array_Mac6_ifmap7 <= Input_zero_point;
          Array_Mac6_ifmap8 <= Input_zero_point;

          Array_Mac7_ifmap0 <= Window00_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap1 <= Window01_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap2 <= Window02_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap3 <= Window10_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap4 <= Window11_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap5 <= Window12_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap6 <= Input_zero_point;
          Array_Mac7_ifmap7 <= Input_zero_point;
          Array_Mac7_ifmap8 <= Input_zero_point;

          Array_Mac8_ifmap0 <= Window00_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap1 <= Window01_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap2 <= Window02_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap3 <= Window10_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap4 <= Window11_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap5 <= Window12_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap6 <= Input_zero_point;
          Array_Mac8_ifmap7 <= Input_zero_point;
          Array_Mac8_ifmap8 <= Input_zero_point;
        end
        4'd7:
        begin
          Array_Mac0_ifmap0 <= Input_zero_point;
          Array_Mac0_ifmap1 <= Window01_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap2 <= Window02_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap3 <= Input_zero_point;
          Array_Mac0_ifmap4 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap5 <= Window12_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap6 <= Input_zero_point;
          Array_Mac0_ifmap7 <= Window21_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap8 <= Window22_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];

          Array_Mac1_ifmap0 <= Input_zero_point;
          Array_Mac1_ifmap1 <= Window01_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap2 <= Window02_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap3 <= Input_zero_point;
          Array_Mac1_ifmap4 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap5 <= Window12_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap6 <= Input_zero_point;
          Array_Mac1_ifmap7 <= Window21_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap8 <= Window22_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];

          Array_Mac2_ifmap0 <= Input_zero_point;
          Array_Mac2_ifmap1 <= Window01_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap2 <= Window02_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap3 <= Input_zero_point;
          Array_Mac2_ifmap4 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap5 <= Window12_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap6 <= Input_zero_point;
          Array_Mac2_ifmap7 <= Window21_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap8 <= Window22_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];

          Array_Mac3_ifmap0 <= Input_zero_point;
          Array_Mac3_ifmap1 <= Window01_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap2 <= Window02_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap3 <= Input_zero_point;
          Array_Mac3_ifmap4 <= Window11_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap5 <= Window12_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap6 <= Input_zero_point;
          Array_Mac3_ifmap7 <= Window21_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap8 <= Window22_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];

          Array_Mac4_ifmap0 <= Input_zero_point;
          Array_Mac4_ifmap1 <= Window01_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap2 <= Window02_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap3 <= Input_zero_point;
          Array_Mac4_ifmap4 <= Window11_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap5 <= Window12_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap6 <= Input_zero_point;
          Array_Mac4_ifmap7 <= Window21_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap8 <= Window22_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];

          Array_Mac5_ifmap0 <= Input_zero_point;
          Array_Mac5_ifmap1 <= Window01_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap2 <= Window02_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap3 <= Input_zero_point;
          Array_Mac5_ifmap4 <= Window11_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap5 <= Window12_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap6 <= Input_zero_point;
          Array_Mac5_ifmap7 <= Window21_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap8 <= Window22_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];

          Array_Mac6_ifmap0 <= Input_zero_point;
          Array_Mac6_ifmap1 <= Window01_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap2 <= Window02_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap3 <= Input_zero_point;
          Array_Mac6_ifmap4 <= Window11_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap5 <= Window12_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap6 <= Input_zero_point;
          Array_Mac6_ifmap7 <= Window21_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap8 <= Window22_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];

          Array_Mac7_ifmap0 <= Input_zero_point;
          Array_Mac7_ifmap1 <= Window01_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap2 <= Window02_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap3 <= Input_zero_point;
          Array_Mac7_ifmap4 <= Window11_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap5 <= Window12_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap6 <= Input_zero_point;
          Array_Mac7_ifmap7 <= Window21_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap8 <= Window22_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];

          Array_Mac8_ifmap0 <= Input_zero_point;
          Array_Mac8_ifmap1 <= Window01_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap2 <= Window02_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap3 <= Input_zero_point;
          Array_Mac8_ifmap4 <= Window11_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap5 <= Window12_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap6 <= Input_zero_point;
          Array_Mac8_ifmap7 <= Window21_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap8 <= Window22_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
        end
        4'd8:
        begin
          Array_Mac0_ifmap0 <= Window00_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap1 <= Window01_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap2 <= Input_zero_point;
          Array_Mac0_ifmap3 <= Window10_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap4 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap5 <= Input_zero_point;
          Array_Mac0_ifmap6 <= Window20_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap7 <= Window21_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap8 <= Input_zero_point;

          Array_Mac1_ifmap0 <= Window00_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap1 <= Window01_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap2 <= Input_zero_point;
          Array_Mac1_ifmap3 <= Window10_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap4 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap5 <= Input_zero_point;
          Array_Mac1_ifmap6 <= Window20_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap7 <= Window21_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap8 <= Input_zero_point;

          Array_Mac2_ifmap0 <= Window00_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap1 <= Window01_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap2 <= Input_zero_point;
          Array_Mac2_ifmap3 <= Window10_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap4 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap5 <= Input_zero_point;
          Array_Mac2_ifmap6 <= Window20_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap7 <= Window21_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap8 <= Input_zero_point;

          Array_Mac3_ifmap0 <= Window00_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap1 <= Window01_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap2 <= Input_zero_point;
          Array_Mac3_ifmap3 <= Window10_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap4 <= Window11_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap5 <= Input_zero_point;
          Array_Mac3_ifmap6 <= Window20_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap7 <= Window21_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap8 <= Input_zero_point;

          Array_Mac4_ifmap0 <= Window00_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap1 <= Window01_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap2 <= Input_zero_point;
          Array_Mac4_ifmap3 <= Window10_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap4 <= Window11_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap5 <= Input_zero_point;
          Array_Mac4_ifmap6 <= Window20_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap7 <= Window21_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap8 <= Input_zero_point;

          Array_Mac5_ifmap0 <= Window00_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap1 <= Window01_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap2 <= Input_zero_point;
          Array_Mac5_ifmap3 <= Window10_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap4 <= Window11_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap5 <= Input_zero_point;
          Array_Mac5_ifmap6 <= Window20_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap7 <= Window21_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap8 <= Input_zero_point;

          Array_Mac6_ifmap0 <= Window00_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap1 <= Window01_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap2 <= Input_zero_point;
          Array_Mac6_ifmap3 <= Window10_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap4 <= Window11_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap5 <= Input_zero_point;
          Array_Mac6_ifmap6 <= Window20_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap7 <= Window21_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap8 <= Input_zero_point;

          Array_Mac7_ifmap0 <= Window00_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap1 <= Window01_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap2 <= Input_zero_point;
          Array_Mac7_ifmap3 <= Window10_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap4 <= Window11_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap5 <= Input_zero_point;
          Array_Mac7_ifmap6 <= Window20_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap7 <= Window21_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap8 <= Input_zero_point;

          Array_Mac8_ifmap0 <= Window00_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap1 <= Window01_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap2 <= Input_zero_point;
          Array_Mac8_ifmap3 <= Window10_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap4 <= Window11_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap5 <= Input_zero_point;
          Array_Mac8_ifmap6 <= Window20_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap7 <= Window21_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap8 <= Input_zero_point;
        end
        4'd9:
        begin
          Array_Mac0_ifmap0 <= Window00_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap1 <= Window01_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap2 <= Window02_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap3 <= Window10_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap4 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap5 <= Window12_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap6 <= Window20_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap7 <= Window21_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap8 <= Window22_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];

          Array_Mac1_ifmap0 <= Window00_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap1 <= Window01_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap2 <= Window02_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap3 <= Window10_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap4 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap5 <= Window12_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap6 <= Window20_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap7 <= Window21_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap8 <= Window22_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];

          Array_Mac2_ifmap0 <= Window00_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap1 <= Window01_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap2 <= Window02_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap3 <= Window10_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap4 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap5 <= Window12_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap6 <= Window20_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap7 <= Window21_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap8 <= Window22_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];

          Array_Mac3_ifmap0 <= Window00_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap1 <= Window01_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap2 <= Window02_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap3 <= Window10_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap4 <= Window11_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap5 <= Window12_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap6 <= Window20_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap7 <= Window21_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap8 <= Window22_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];

          Array_Mac4_ifmap0 <= Window00_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap1 <= Window01_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap2 <= Window02_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap3 <= Window10_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap4 <= Window11_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap5 <= Window12_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap6 <= Window20_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap7 <= Window21_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap8 <= Window22_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];

          Array_Mac5_ifmap0 <= Window00_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap1 <= Window01_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap2 <= Window02_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap3 <= Window10_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap4 <= Window11_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap5 <= Window12_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap6 <= Window20_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap7 <= Window21_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap8 <= Window22_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];

          Array_Mac6_ifmap0 <= Window00_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap1 <= Window01_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap2 <= Window02_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap3 <= Window10_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap4 <= Window11_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap5 <= Window12_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap6 <= Window20_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap7 <= Window21_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap8 <= Window22_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];

          Array_Mac7_ifmap0 <= Window00_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap1 <= Window01_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap2 <= Window02_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap3 <= Window10_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap4 <= Window11_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap5 <= Window12_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap6 <= Window20_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap7 <= Window21_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap8 <= Window22_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];

          Array_Mac8_ifmap0 <= Window00_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap1 <= Window01_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap2 <= Window02_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap3 <= Window10_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap4 <= Window11_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap5 <= Window12_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap6 <= Window20_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap7 <= Window21_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap8 <= Window22_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
        end
        default:
        begin
          Array_Mac0_ifmap0 <= 0;
          Array_Mac0_ifmap1 <= 0;
          Array_Mac0_ifmap2 <= 0;
          Array_Mac0_ifmap3 <= 0;
          Array_Mac0_ifmap4 <= 0;
          Array_Mac0_ifmap5 <= 0;
          Array_Mac0_ifmap6 <= 0;
          Array_Mac0_ifmap7 <= 0;
          Array_Mac0_ifmap8 <= 0;

          Array_Mac1_ifmap0 <= 0;
          Array_Mac1_ifmap1 <= 0;
          Array_Mac1_ifmap2 <= 0;
          Array_Mac1_ifmap3 <= 0;
          Array_Mac1_ifmap4 <= 0;
          Array_Mac1_ifmap5 <= 0;
          Array_Mac1_ifmap6 <= 0;
          Array_Mac1_ifmap7 <= 0;
          Array_Mac1_ifmap8 <= 0;

          Array_Mac2_ifmap0 <= 0;
          Array_Mac2_ifmap1 <= 0;
          Array_Mac2_ifmap2 <= 0;
          Array_Mac2_ifmap3 <= 0;
          Array_Mac2_ifmap4 <= 0;
          Array_Mac2_ifmap5 <= 0;
          Array_Mac2_ifmap6 <= 0;
          Array_Mac2_ifmap7 <= 0;
          Array_Mac2_ifmap8 <= 0;

          Array_Mac3_ifmap0 <= 0;
          Array_Mac3_ifmap1 <= 0;
          Array_Mac3_ifmap2 <= 0;
          Array_Mac3_ifmap3 <= 0;
          Array_Mac3_ifmap4 <= 0;
          Array_Mac3_ifmap5 <= 0;
          Array_Mac3_ifmap6 <= 0;
          Array_Mac3_ifmap7 <= 0;
          Array_Mac3_ifmap8 <= 0;

          Array_Mac4_ifmap0 <= 0;
          Array_Mac4_ifmap1 <= 0;
          Array_Mac4_ifmap2 <= 0;
          Array_Mac4_ifmap3 <= 0;
          Array_Mac4_ifmap4 <= 0;
          Array_Mac4_ifmap5 <= 0;
          Array_Mac4_ifmap6 <= 0;
          Array_Mac4_ifmap7 <= 0;
          Array_Mac4_ifmap8 <= 0;

          Array_Mac5_ifmap0 <= 0;
          Array_Mac5_ifmap1 <= 0;
          Array_Mac5_ifmap2 <= 0;
          Array_Mac5_ifmap3 <= 0;
          Array_Mac5_ifmap4 <= 0;
          Array_Mac5_ifmap5 <= 0;
          Array_Mac5_ifmap6 <= 0;
          Array_Mac5_ifmap7 <= 0;
          Array_Mac5_ifmap8 <= 0;

          Array_Mac6_ifmap0 <= 0;
          Array_Mac6_ifmap1 <= 0;
          Array_Mac6_ifmap2 <= 0;
          Array_Mac6_ifmap3 <= 0;
          Array_Mac6_ifmap4 <= 0;
          Array_Mac6_ifmap5 <= 0;
          Array_Mac6_ifmap6 <= 0;
          Array_Mac6_ifmap7 <= 0;
          Array_Mac6_ifmap8 <= 0;

          Array_Mac7_ifmap0 <= 0;
          Array_Mac7_ifmap1 <= 0;
          Array_Mac7_ifmap2 <= 0;
          Array_Mac7_ifmap3 <= 0;
          Array_Mac7_ifmap4 <= 0;
          Array_Mac7_ifmap5 <= 0;
          Array_Mac7_ifmap6 <= 0;
          Array_Mac7_ifmap7 <= 0;
          Array_Mac7_ifmap8 <= 0;

          Array_Mac8_ifmap0 <= 0;
          Array_Mac8_ifmap1 <= 0;
          Array_Mac8_ifmap2 <= 0;
          Array_Mac8_ifmap3 <= 0;
          Array_Mac8_ifmap4 <= 0;
          Array_Mac8_ifmap5 <= 0;
          Array_Mac8_ifmap6 <= 0;
          Array_Mac8_ifmap7 <= 0;
          Array_Mac8_ifmap8 <= 0;
        end
      endcase
      3'd3:    //PW
      begin
        Array_Mac0_ifmap0 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
        Array_Mac0_ifmap1 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
        Array_Mac0_ifmap2 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
        Array_Mac0_ifmap3 <= Window11_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
        Array_Mac0_ifmap4 <= Window11_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
        Array_Mac0_ifmap5 <= Window11_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
        Array_Mac0_ifmap6 <= Window11_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
        Array_Mac0_ifmap7 <= Window11_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
        Array_Mac0_ifmap8 <= Window11_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];

        Array_Mac1_ifmap0 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
        Array_Mac1_ifmap1 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
        Array_Mac1_ifmap2 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
        Array_Mac1_ifmap3 <= Window11_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
        Array_Mac1_ifmap4 <= Window11_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
        Array_Mac1_ifmap5 <= Window11_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
        Array_Mac1_ifmap6 <= Window11_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
        Array_Mac1_ifmap7 <= Window11_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
        Array_Mac1_ifmap8 <= Window11_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];

        Array_Mac2_ifmap0 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
        Array_Mac2_ifmap1 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
        Array_Mac2_ifmap2 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
        Array_Mac2_ifmap3 <= Window11_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
        Array_Mac2_ifmap4 <= Window11_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
        Array_Mac2_ifmap5 <= Window11_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
        Array_Mac2_ifmap6 <= Window11_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
        Array_Mac2_ifmap7 <= Window11_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
        Array_Mac2_ifmap8 <= Window11_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];

        Array_Mac3_ifmap0 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
        Array_Mac3_ifmap1 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
        Array_Mac3_ifmap2 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
        Array_Mac3_ifmap3 <= Window11_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
        Array_Mac3_ifmap4 <= Window11_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
        Array_Mac3_ifmap5 <= Window11_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
        Array_Mac3_ifmap6 <= Window11_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
        Array_Mac3_ifmap7 <= Window11_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
        Array_Mac3_ifmap8 <= Window11_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];

        Array_Mac4_ifmap0 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
        Array_Mac4_ifmap1 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
        Array_Mac4_ifmap2 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
        Array_Mac4_ifmap3 <= Window11_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
        Array_Mac4_ifmap4 <= Window11_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
        Array_Mac4_ifmap5 <= Window11_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
        Array_Mac4_ifmap6 <= Window11_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
        Array_Mac4_ifmap7 <= Window11_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
        Array_Mac4_ifmap8 <= Window11_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];

        Array_Mac5_ifmap0 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
        Array_Mac5_ifmap1 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
        Array_Mac5_ifmap2 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
        Array_Mac5_ifmap3 <= Window11_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
        Array_Mac5_ifmap4 <= Window11_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
        Array_Mac5_ifmap5 <= Window11_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
        Array_Mac5_ifmap6 <= Window11_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
        Array_Mac5_ifmap7 <= Window11_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
        Array_Mac5_ifmap8 <= Window11_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];

        Array_Mac6_ifmap0 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
        Array_Mac6_ifmap1 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
        Array_Mac6_ifmap2 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
        Array_Mac6_ifmap3 <= Window11_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
        Array_Mac6_ifmap4 <= Window11_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
        Array_Mac6_ifmap5 <= Window11_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
        Array_Mac6_ifmap6 <= Window11_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
        Array_Mac6_ifmap7 <= Window11_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
        Array_Mac6_ifmap8 <= Window11_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];

        Array_Mac7_ifmap0 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
        Array_Mac7_ifmap1 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
        Array_Mac7_ifmap2 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
        Array_Mac7_ifmap3 <= Window11_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
        Array_Mac7_ifmap4 <= Window11_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
        Array_Mac7_ifmap5 <= Window11_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
        Array_Mac7_ifmap6 <= Window11_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
        Array_Mac7_ifmap7 <= Window11_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
        Array_Mac7_ifmap8 <= Window11_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];

        Array_Mac8_ifmap0 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
        Array_Mac8_ifmap1 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
        Array_Mac8_ifmap2 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
        Array_Mac8_ifmap3 <= Window11_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
        Array_Mac8_ifmap4 <= Window11_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
        Array_Mac8_ifmap5 <= Window11_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
        Array_Mac8_ifmap6 <= Window11_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
        Array_Mac8_ifmap7 <= Window11_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
        Array_Mac8_ifmap8 <= Window11_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
      end
      3'd4://shortcut
      begin
        Array_Mac0_ifmap0 <= Window00_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
        Array_Mac0_ifmap1 <= Window00_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
        Array_Mac0_ifmap2 <= Window00_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
        Array_Mac0_ifmap3 <= Window00_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
        Array_Mac0_ifmap4 <= Window00_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
        Array_Mac0_ifmap5 <= Window00_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
        Array_Mac0_ifmap6 <= Window00_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
        Array_Mac0_ifmap7 <= Window00_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
        Array_Mac0_ifmap8 <= Window00_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];

        Array_Mac1_ifmap0 <= Window01_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
        Array_Mac1_ifmap1 <= Window01_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
        Array_Mac1_ifmap2 <= Window01_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
        Array_Mac1_ifmap3 <= Window01_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
        Array_Mac1_ifmap4 <= Window01_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
        Array_Mac1_ifmap5 <= Window01_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
        Array_Mac1_ifmap6 <= Window01_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
        Array_Mac1_ifmap7 <= Window01_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
        Array_Mac1_ifmap8 <= Window01_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];

        Array_Mac2_ifmap0 <= Window02_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
        Array_Mac2_ifmap1 <= Window02_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
        Array_Mac2_ifmap2 <= Window02_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
        Array_Mac2_ifmap3 <= Window02_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
        Array_Mac2_ifmap4 <= Window02_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
        Array_Mac2_ifmap5 <= Window02_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
        Array_Mac2_ifmap6 <= Window02_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
        Array_Mac2_ifmap7 <= Window02_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
        Array_Mac2_ifmap8 <= Window02_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];

        Array_Mac3_ifmap0 <= Window10_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
        Array_Mac3_ifmap1 <= Window10_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
        Array_Mac3_ifmap2 <= Window10_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
        Array_Mac3_ifmap3 <= Window10_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
        Array_Mac3_ifmap4 <= Window10_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
        Array_Mac3_ifmap5 <= Window10_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
        Array_Mac3_ifmap6 <= Window10_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
        Array_Mac3_ifmap7 <= Window10_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
        Array_Mac3_ifmap8 <= Window10_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];

        Array_Mac4_ifmap0 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
        Array_Mac4_ifmap1 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
        Array_Mac4_ifmap2 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
        Array_Mac4_ifmap3 <= Window11_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
        Array_Mac4_ifmap4 <= Window11_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
        Array_Mac4_ifmap5 <= Window11_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
        Array_Mac4_ifmap6 <= Window11_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
        Array_Mac4_ifmap7 <= Window11_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
        Array_Mac4_ifmap8 <= Window11_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];

        Array_Mac5_ifmap0 <= Window12_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
        Array_Mac5_ifmap1 <= Window12_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
        Array_Mac5_ifmap2 <= Window12_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
        Array_Mac5_ifmap3 <= Window12_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
        Array_Mac5_ifmap4 <= Window12_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
        Array_Mac5_ifmap5 <= Window12_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
        Array_Mac5_ifmap6 <= Window12_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
        Array_Mac5_ifmap7 <= Window12_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
        Array_Mac5_ifmap8 <= Window12_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];

        Array_Mac6_ifmap0 <= Window20_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
        Array_Mac6_ifmap1 <= Window20_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
        Array_Mac6_ifmap2 <= Window20_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
        Array_Mac6_ifmap3 <= Window20_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
        Array_Mac6_ifmap4 <= Window20_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
        Array_Mac6_ifmap5 <= Window20_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
        Array_Mac6_ifmap6 <= Window20_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
        Array_Mac6_ifmap7 <= Window20_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
        Array_Mac6_ifmap8 <= Window20_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];

        Array_Mac7_ifmap0 <= Window21_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
        Array_Mac7_ifmap1 <= Window21_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
        Array_Mac7_ifmap2 <= Window21_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
        Array_Mac7_ifmap3 <= Window21_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
        Array_Mac7_ifmap4 <= Window21_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
        Array_Mac7_ifmap5 <= Window21_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
        Array_Mac7_ifmap6 <= Window21_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
        Array_Mac7_ifmap7 <= Window21_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
        Array_Mac7_ifmap8 <= Window21_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];

        Array_Mac8_ifmap0 <= Window22_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
        Array_Mac8_ifmap1 <= Window22_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
        Array_Mac8_ifmap2 <= Window22_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
        Array_Mac8_ifmap3 <= Window22_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
        Array_Mac8_ifmap4 <= Window22_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
        Array_Mac8_ifmap5 <= Window22_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
        Array_Mac8_ifmap6 <= Window22_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
        Array_Mac8_ifmap7 <= Window22_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
        Array_Mac8_ifmap8 <= Window22_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
      end
      3'd5: //avgpool
        if(last_block_signal_reg[7] == 2'b11)
        begin
          Array_Mac0_ifmap0 <= Window00_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap1 <= 0;
          Array_Mac0_ifmap2 <= 0;
          Array_Mac0_ifmap3 <= 0;
          Array_Mac0_ifmap4 <= 0;
          Array_Mac0_ifmap5 <= 0;
          Array_Mac0_ifmap6 <= 0;
          Array_Mac0_ifmap7 <= 0;
          Array_Mac0_ifmap8 <= 0;

          Array_Mac1_ifmap0 <= Window00_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap1 <= 0;
          Array_Mac1_ifmap2 <= 0;
          Array_Mac1_ifmap3 <= 0;
          Array_Mac1_ifmap4 <= 0;
          Array_Mac1_ifmap5 <= 0;
          Array_Mac1_ifmap6 <= 0;
          Array_Mac1_ifmap7 <= 0;
          Array_Mac1_ifmap8 <= 0;

          Array_Mac2_ifmap0 <= Window00_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap1 <= 0;
          Array_Mac2_ifmap2 <= 0;
          Array_Mac2_ifmap3 <= 0;
          Array_Mac2_ifmap4 <= 0;
          Array_Mac2_ifmap5 <= 0;
          Array_Mac2_ifmap6 <= 0;
          Array_Mac2_ifmap7 <= 0;
          Array_Mac2_ifmap8 <= 0;

          Array_Mac3_ifmap0 <= Window00_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap1 <= 0;
          Array_Mac3_ifmap2 <= 0;
          Array_Mac3_ifmap3 <= 0;
          Array_Mac3_ifmap4 <= 0;
          Array_Mac3_ifmap5 <= 0;
          Array_Mac3_ifmap6 <= 0;
          Array_Mac3_ifmap7 <= 0;
          Array_Mac3_ifmap8 <= 0;

          Array_Mac4_ifmap0 <= Window00_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap1 <= 0;
          Array_Mac4_ifmap2 <= 0;
          Array_Mac4_ifmap3 <= 0;
          Array_Mac4_ifmap4 <= 0;
          Array_Mac4_ifmap5 <= 0;
          Array_Mac4_ifmap6 <= 0;
          Array_Mac4_ifmap7 <= 0;
          Array_Mac4_ifmap8 <= 0;

          Array_Mac5_ifmap0 <= Window00_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap1 <= 0;
          Array_Mac5_ifmap2 <= 0;
          Array_Mac5_ifmap3 <= 0;
          Array_Mac5_ifmap4 <= 0;
          Array_Mac5_ifmap5 <= 0;
          Array_Mac5_ifmap6 <= 0;
          Array_Mac5_ifmap7 <= 0;
          Array_Mac5_ifmap8 <= 0;

          Array_Mac6_ifmap0 <= Window00_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap1 <= 0;
          Array_Mac6_ifmap2 <= 0;
          Array_Mac6_ifmap3 <= 0;
          Array_Mac6_ifmap4 <= 0;
          Array_Mac6_ifmap5 <= 0;
          Array_Mac6_ifmap6 <= 0;
          Array_Mac6_ifmap7 <= 0;
          Array_Mac6_ifmap8 <= 0;

          Array_Mac7_ifmap0 <= Window00_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap1 <= 0;
          Array_Mac7_ifmap2 <= 0;
          Array_Mac7_ifmap3 <= 0;
          Array_Mac7_ifmap4 <= 0;
          Array_Mac7_ifmap5 <= 0;
          Array_Mac7_ifmap6 <= 0;
          Array_Mac7_ifmap7 <= 0;
          Array_Mac7_ifmap8 <= 0;

          Array_Mac8_ifmap0 <= Window00_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap1 <= 0;
          Array_Mac8_ifmap2 <= 0;
          Array_Mac8_ifmap3 <= 0;
          Array_Mac8_ifmap4 <= 0;
          Array_Mac8_ifmap5 <= 0;
          Array_Mac8_ifmap6 <= 0;
          Array_Mac8_ifmap7 <= 0;
          Array_Mac8_ifmap8 <= 0;
        end
        else if (last_block_signal_reg[7] == 2'b01)
        begin
          Array_Mac0_ifmap0 <= Window00_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap1 <= 0;
          Array_Mac0_ifmap2 <= 0;
          Array_Mac0_ifmap3 <= Window10_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap4 <= 0;
          Array_Mac0_ifmap5 <= 0;
          Array_Mac0_ifmap6 <= Window20_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap7 <= 0;
          Array_Mac0_ifmap8 <= 0;

          Array_Mac1_ifmap0 <= Window00_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap1 <= 0;
          Array_Mac1_ifmap2 <= 0;
          Array_Mac1_ifmap3 <= Window10_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap4 <= 0;
          Array_Mac1_ifmap5 <= 0;
          Array_Mac1_ifmap6 <= Window20_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap7 <= 0;
          Array_Mac1_ifmap8 <= 0;

          Array_Mac2_ifmap0 <= Window00_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap1 <= 0;
          Array_Mac2_ifmap2 <= 0;
          Array_Mac2_ifmap3 <= Window10_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap4 <= 0;
          Array_Mac2_ifmap5 <= 0;
          Array_Mac2_ifmap6 <= Window20_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap7 <= 0;
          Array_Mac2_ifmap8 <= 0;

          Array_Mac3_ifmap0 <= Window00_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap1 <= 0;
          Array_Mac3_ifmap2 <= 0;
          Array_Mac3_ifmap3 <= Window10_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap4 <= 0;
          Array_Mac3_ifmap5 <= 0;
          Array_Mac3_ifmap6 <= Window20_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap7 <= 0;
          Array_Mac3_ifmap8 <= 0;

          Array_Mac4_ifmap0 <= Window00_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap1 <= 0;
          Array_Mac4_ifmap2 <= 0;
          Array_Mac4_ifmap3 <= Window10_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap4 <= 0;
          Array_Mac4_ifmap5 <= 0;
          Array_Mac4_ifmap6 <= Window20_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap7 <= 0;
          Array_Mac4_ifmap8 <= 0;

          Array_Mac5_ifmap0 <= Window00_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap1 <= 0;
          Array_Mac5_ifmap2 <= 0;
          Array_Mac5_ifmap3 <= Window10_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap4 <= 0;
          Array_Mac5_ifmap5 <= 0;
          Array_Mac5_ifmap6 <= Window20_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap7 <= 0;
          Array_Mac5_ifmap8 <= 0;

          Array_Mac6_ifmap0 <= Window00_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap1 <= 0;
          Array_Mac6_ifmap2 <= 0;
          Array_Mac6_ifmap3 <= Window10_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap4 <= 0;
          Array_Mac6_ifmap5 <= 0;
          Array_Mac6_ifmap6 <= Window20_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap7 <= 0;
          Array_Mac6_ifmap8 <= 0;

          Array_Mac7_ifmap0 <= Window00_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap1 <= 0;
          Array_Mac7_ifmap2 <= 0;
          Array_Mac7_ifmap3 <= Window10_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap4 <= 0;
          Array_Mac7_ifmap5 <= 0;
          Array_Mac7_ifmap6 <= Window20_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap7 <= 0;
          Array_Mac7_ifmap8 <= 0;

          Array_Mac8_ifmap0 <= Window00_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap1 <= 0;
          Array_Mac8_ifmap2 <= 0;
          Array_Mac8_ifmap3 <= Window10_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap4 <= 0;
          Array_Mac8_ifmap5 <= 0;
          Array_Mac8_ifmap6 <= Window20_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap7 <= 0;
          Array_Mac8_ifmap8 <= 0;
        end
        else if (last_block_signal_reg[7] == 2'b10)
        begin
          Array_Mac0_ifmap0 <= Window00_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap1 <= Window01_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap2 <= Window02_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap3 <= 0;
          Array_Mac0_ifmap4 <= 0;
          Array_Mac0_ifmap5 <= 0;
          Array_Mac0_ifmap6 <= 0;
          Array_Mac0_ifmap7 <= 0;
          Array_Mac0_ifmap8 <= 0;

          Array_Mac1_ifmap0 <= Window00_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap1 <= Window01_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap2 <= Window02_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap3 <= 0;
          Array_Mac1_ifmap4 <= 0;
          Array_Mac1_ifmap5 <= 0;
          Array_Mac1_ifmap6 <= 0;
          Array_Mac1_ifmap7 <= 0;
          Array_Mac1_ifmap8 <= 0;

          Array_Mac2_ifmap0 <= Window00_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap1 <= Window01_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap2 <= Window02_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap3 <= 0;
          Array_Mac2_ifmap4 <= 0;
          Array_Mac2_ifmap5 <= 0;
          Array_Mac2_ifmap6 <= 0;
          Array_Mac2_ifmap7 <= 0;
          Array_Mac2_ifmap8 <= 0;

          Array_Mac3_ifmap0 <= Window00_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap1 <= Window01_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap2 <= Window02_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap3 <= 0;
          Array_Mac3_ifmap4 <= 0;
          Array_Mac3_ifmap5 <= 0;
          Array_Mac3_ifmap6 <= 0;
          Array_Mac3_ifmap7 <= 0;
          Array_Mac3_ifmap8 <= 0;

          Array_Mac4_ifmap0 <= Window00_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap1 <= Window01_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap2 <= Window02_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap3 <= 0;
          Array_Mac4_ifmap4 <= 0;
          Array_Mac4_ifmap5 <= 0;
          Array_Mac4_ifmap6 <= 0;
          Array_Mac4_ifmap7 <= 0;
          Array_Mac4_ifmap8 <= 0;

          Array_Mac5_ifmap0 <= Window00_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap1 <= Window01_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap2 <= Window02_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap3 <= 0;
          Array_Mac5_ifmap4 <= 0;
          Array_Mac5_ifmap5 <= 0;
          Array_Mac5_ifmap6 <= 0;
          Array_Mac5_ifmap7 <= 0;
          Array_Mac5_ifmap8 <= 0;

          Array_Mac6_ifmap0 <= Window00_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap1 <= Window01_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap2 <= Window02_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap3 <= 0;
          Array_Mac6_ifmap4 <= 0;
          Array_Mac6_ifmap5 <= 0;
          Array_Mac6_ifmap6 <= 0;
          Array_Mac6_ifmap7 <= 0;
          Array_Mac6_ifmap8 <= 0;

          Array_Mac7_ifmap0 <= Window00_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap1 <= Window01_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap2 <= Window02_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap3 <= 0;
          Array_Mac7_ifmap4 <= 0;
          Array_Mac7_ifmap5 <= 0;
          Array_Mac7_ifmap6 <= 0;
          Array_Mac7_ifmap7 <= 0;
          Array_Mac7_ifmap8 <= 0;

          Array_Mac8_ifmap0 <= Window00_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap1 <= Window01_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap2 <= Window02_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap3 <= 0;
          Array_Mac8_ifmap4 <= 0;
          Array_Mac8_ifmap5 <= 0;
          Array_Mac8_ifmap6 <= 0;
          Array_Mac8_ifmap7 <= 0;
          Array_Mac8_ifmap8 <= 0;
        end
        else
        begin
          Array_Mac0_ifmap0 <= Window00_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap1 <= Window01_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap2 <= Window02_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap3 <= Window10_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap4 <= Window11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap5 <= Window12_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap6 <= Window20_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap7 <= Window21_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
          Array_Mac0_ifmap8 <= Window22_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];

          Array_Mac1_ifmap0 <= Window00_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap1 <= Window01_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap2 <= Window02_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap3 <= Window10_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap4 <= Window11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap5 <= Window12_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap6 <= Window20_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap7 <= Window21_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
          Array_Mac1_ifmap8 <= Window22_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];

          Array_Mac2_ifmap0 <= Window00_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap1 <= Window01_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap2 <= Window02_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap3 <= Window10_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap4 <= Window11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap5 <= Window12_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap6 <= Window20_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap7 <= Window21_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
          Array_Mac2_ifmap8 <= Window22_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];

          Array_Mac3_ifmap0 <= Window00_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap1 <= Window01_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap2 <= Window02_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap3 <= Window10_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap4 <= Window11_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap5 <= Window12_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap6 <= Window20_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap7 <= Window21_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
          Array_Mac3_ifmap8 <= Window22_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];

          Array_Mac4_ifmap0 <= Window00_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap1 <= Window01_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap2 <= Window02_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap3 <= Window10_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap4 <= Window11_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap5 <= Window12_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap6 <= Window20_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap7 <= Window21_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
          Array_Mac4_ifmap8 <= Window22_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];

          Array_Mac5_ifmap0 <= Window00_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap1 <= Window01_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap2 <= Window02_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap3 <= Window10_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap4 <= Window11_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap5 <= Window12_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap6 <= Window20_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap7 <= Window21_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
          Array_Mac5_ifmap8 <= Window22_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];

          Array_Mac6_ifmap0 <= Window00_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap1 <= Window01_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap2 <= Window02_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap3 <= Window10_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap4 <= Window11_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap5 <= Window12_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap6 <= Window20_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap7 <= Window21_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
          Array_Mac6_ifmap8 <= Window22_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];

          Array_Mac7_ifmap0 <= Window00_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap1 <= Window01_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap2 <= Window02_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap3 <= Window10_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap4 <= Window11_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap5 <= Window12_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap6 <= Window20_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap7 <= Window21_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
          Array_Mac7_ifmap8 <= Window22_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];

          Array_Mac8_ifmap0 <= Window00_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap1 <= Window01_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap2 <= Window02_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap3 <= Window10_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap4 <= Window11_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap5 <= Window12_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap6 <= Window20_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap7 <= Window21_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
          Array_Mac8_ifmap8 <= Window22_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
        end
      default:
      begin
        Array_Mac0_ifmap0 <= 0;
        Array_Mac0_ifmap1 <= 0;
        Array_Mac0_ifmap2 <= 0;
        Array_Mac0_ifmap3 <= 0;
        Array_Mac0_ifmap4 <= 0;
        Array_Mac0_ifmap5 <= 0;
        Array_Mac0_ifmap6 <= 0;
        Array_Mac0_ifmap7 <= 0;
        Array_Mac0_ifmap8 <= 0;

        Array_Mac1_ifmap0 <= 0;
        Array_Mac1_ifmap1 <= 0;
        Array_Mac1_ifmap2 <= 0;
        Array_Mac1_ifmap3 <= 0;
        Array_Mac1_ifmap4 <= 0;
        Array_Mac1_ifmap5 <= 0;
        Array_Mac1_ifmap6 <= 0;
        Array_Mac1_ifmap7 <= 0;
        Array_Mac1_ifmap8 <= 0;

        Array_Mac2_ifmap0 <= 0;
        Array_Mac2_ifmap1 <= 0;
        Array_Mac2_ifmap2 <= 0;
        Array_Mac2_ifmap3 <= 0;
        Array_Mac2_ifmap4 <= 0;
        Array_Mac2_ifmap5 <= 0;
        Array_Mac2_ifmap6 <= 0;
        Array_Mac2_ifmap7 <= 0;
        Array_Mac2_ifmap8 <= 0;

        Array_Mac3_ifmap0 <= 0;
        Array_Mac3_ifmap1 <= 0;
        Array_Mac3_ifmap2 <= 0;
        Array_Mac3_ifmap3 <= 0;
        Array_Mac3_ifmap4 <= 0;
        Array_Mac3_ifmap5 <= 0;
        Array_Mac3_ifmap6 <= 0;
        Array_Mac3_ifmap7 <= 0;
        Array_Mac3_ifmap8 <= 0;

        Array_Mac4_ifmap0 <= 0;
        Array_Mac4_ifmap1 <= 0;
        Array_Mac4_ifmap2 <= 0;
        Array_Mac4_ifmap3 <= 0;
        Array_Mac4_ifmap4 <= 0;
        Array_Mac4_ifmap5 <= 0;
        Array_Mac4_ifmap6 <= 0;
        Array_Mac4_ifmap7 <= 0;
        Array_Mac4_ifmap8 <= 0;

        Array_Mac5_ifmap0 <= 0;
        Array_Mac5_ifmap1 <= 0;
        Array_Mac5_ifmap2 <= 0;
        Array_Mac5_ifmap3 <= 0;
        Array_Mac5_ifmap4 <= 0;
        Array_Mac5_ifmap5 <= 0;
        Array_Mac5_ifmap6 <= 0;
        Array_Mac5_ifmap7 <= 0;
        Array_Mac5_ifmap8 <= 0;

        Array_Mac6_ifmap0 <= 0;
        Array_Mac6_ifmap1 <= 0;
        Array_Mac6_ifmap2 <= 0;
        Array_Mac6_ifmap3 <= 0;
        Array_Mac6_ifmap4 <= 0;
        Array_Mac6_ifmap5 <= 0;
        Array_Mac6_ifmap6 <= 0;
        Array_Mac6_ifmap7 <= 0;
        Array_Mac6_ifmap8 <= 0;

        Array_Mac7_ifmap0 <= 0;
        Array_Mac7_ifmap1 <= 0;
        Array_Mac7_ifmap2 <= 0;
        Array_Mac7_ifmap3 <= 0;
        Array_Mac7_ifmap4 <= 0;
        Array_Mac7_ifmap5 <= 0;
        Array_Mac7_ifmap6 <= 0;
        Array_Mac7_ifmap7 <= 0;
        Array_Mac7_ifmap8 <= 0;

        Array_Mac8_ifmap0 <= 0;
        Array_Mac8_ifmap1 <= 0;
        Array_Mac8_ifmap2 <= 0;
        Array_Mac8_ifmap3 <= 0;
        Array_Mac8_ifmap4 <= 0;
        Array_Mac8_ifmap5 <= 0;
        Array_Mac8_ifmap6 <= 0;
        Array_Mac8_ifmap7 <= 0;
        Array_Mac8_ifmap8 <= 0;
      end
    endcase
  end

  assign data1_to99 = {Array_Mac0_ifmap8, Array_Mac0_ifmap7, Array_Mac0_ifmap6, Array_Mac0_ifmap5, Array_Mac0_ifmap4, Array_Mac0_ifmap3, Array_Mac0_ifmap2, Array_Mac0_ifmap1, Array_Mac0_ifmap0};
  assign data2_to99 = {Array_Mac1_ifmap8, Array_Mac1_ifmap7, Array_Mac1_ifmap6, Array_Mac1_ifmap5, Array_Mac1_ifmap4, Array_Mac1_ifmap3, Array_Mac1_ifmap2, Array_Mac1_ifmap1, Array_Mac1_ifmap0};
  assign data3_to99 = {Array_Mac2_ifmap8, Array_Mac2_ifmap7, Array_Mac2_ifmap6, Array_Mac2_ifmap5, Array_Mac2_ifmap4, Array_Mac2_ifmap3, Array_Mac2_ifmap2, Array_Mac2_ifmap1, Array_Mac2_ifmap0};
  assign data4_to99 = {Array_Mac3_ifmap8, Array_Mac3_ifmap7, Array_Mac3_ifmap6, Array_Mac3_ifmap5, Array_Mac3_ifmap4, Array_Mac3_ifmap3, Array_Mac3_ifmap2, Array_Mac3_ifmap1, Array_Mac3_ifmap0};
  assign data5_to99 = {Array_Mac4_ifmap8, Array_Mac4_ifmap7, Array_Mac4_ifmap6, Array_Mac4_ifmap5, Array_Mac4_ifmap4, Array_Mac4_ifmap3, Array_Mac4_ifmap2, Array_Mac4_ifmap1, Array_Mac4_ifmap0};
  assign data6_to99 = {Array_Mac5_ifmap8, Array_Mac5_ifmap7, Array_Mac5_ifmap6, Array_Mac5_ifmap5, Array_Mac5_ifmap4, Array_Mac5_ifmap3, Array_Mac5_ifmap2, Array_Mac5_ifmap1, Array_Mac5_ifmap0};
  assign data7_to99 = {Array_Mac6_ifmap8, Array_Mac6_ifmap7, Array_Mac6_ifmap6, Array_Mac6_ifmap5, Array_Mac6_ifmap4, Array_Mac6_ifmap3, Array_Mac6_ifmap2, Array_Mac6_ifmap1, Array_Mac6_ifmap0};
  assign data8_to99 = {Array_Mac7_ifmap8, Array_Mac7_ifmap7, Array_Mac7_ifmap6, Array_Mac7_ifmap5, Array_Mac7_ifmap4, Array_Mac7_ifmap3, Array_Mac7_ifmap2, Array_Mac7_ifmap1, Array_Mac7_ifmap0};
  assign data9_to99 = {Array_Mac8_ifmap8, Array_Mac8_ifmap7, Array_Mac8_ifmap6, Array_Mac8_ifmap5, Array_Mac8_ifmap4, Array_Mac8_ifmap3, Array_Mac8_ifmap2, Array_Mac8_ifmap1, Array_Mac8_ifmap0};

  assign weight1_to99 = {Array_Mac0_weight8, Array_Mac0_weight7, Array_Mac0_weight6, Array_Mac0_weight5, Array_Mac0_weight4, Array_Mac0_weight3, Array_Mac0_weight2, Array_Mac0_weight1, Array_Mac0_weight0};
  assign weight2_to99 = {Array_Mac1_weight8, Array_Mac1_weight7, Array_Mac1_weight6, Array_Mac1_weight5, Array_Mac1_weight4, Array_Mac1_weight3, Array_Mac1_weight2, Array_Mac1_weight1, Array_Mac1_weight0};
  assign weight3_to99 = {Array_Mac2_weight8, Array_Mac2_weight7, Array_Mac2_weight6, Array_Mac2_weight5, Array_Mac2_weight4, Array_Mac2_weight3, Array_Mac2_weight2, Array_Mac2_weight1, Array_Mac2_weight0};
  assign weight4_to99 = {Array_Mac3_weight8, Array_Mac3_weight7, Array_Mac3_weight6, Array_Mac3_weight5, Array_Mac3_weight4, Array_Mac3_weight3, Array_Mac3_weight2, Array_Mac3_weight1, Array_Mac3_weight0};
  assign weight5_to99 = {Array_Mac4_weight8, Array_Mac4_weight7, Array_Mac4_weight6, Array_Mac4_weight5, Array_Mac4_weight4, Array_Mac4_weight3, Array_Mac4_weight2, Array_Mac4_weight1, Array_Mac4_weight0};
  assign weight6_to99 = {Array_Mac5_weight8, Array_Mac5_weight7, Array_Mac5_weight6, Array_Mac5_weight5, Array_Mac5_weight4, Array_Mac5_weight3, Array_Mac5_weight2, Array_Mac5_weight1, Array_Mac5_weight0};
  assign weight7_to99 = {Array_Mac6_weight8, Array_Mac6_weight7, Array_Mac6_weight6, Array_Mac6_weight5, Array_Mac6_weight4, Array_Mac6_weight3, Array_Mac6_weight2, Array_Mac6_weight1, Array_Mac6_weight0};
  assign weight8_to99 = {Array_Mac7_weight8, Array_Mac7_weight7, Array_Mac7_weight6, Array_Mac7_weight5, Array_Mac7_weight4, Array_Mac7_weight3, Array_Mac7_weight2, Array_Mac7_weight1, Array_Mac7_weight0};
  assign weight9_to99 = {Array_Mac8_weight8, Array_Mac8_weight7, Array_Mac8_weight6, Array_Mac8_weight5, Array_Mac8_weight4, Array_Mac8_weight3, Array_Mac8_weight2, Array_Mac8_weight1, Array_Mac8_weight0};


  /////////////////------------------------------------------------/////////////////////
  /////////////////////////////  [5]. weight arbiter ////////////////////////////
  /////////////////------------------------------------------------////////////////////
  always@(posedge clk)
  begin
    case(Mode_reg[0])
      3'd1:
      begin//normal conv
        //-------------     >>> group 0 /////////////////
        Array_Mac0_weight0 <= Weight00_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
        Array_Mac0_weight1 <= Weight01_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
        Array_Mac0_weight2 <= Weight02_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
        Array_Mac0_weight3 <= Weight10_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
        Array_Mac0_weight4 <= Weight11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
        Array_Mac0_weight5 <= Weight12_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
        Array_Mac0_weight6 <= Weight20_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
        Array_Mac0_weight7 <= Weight21_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
        Array_Mac0_weight8 <= Weight22_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];

        Array_Mac1_weight0 <= Weight00_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
        Array_Mac1_weight1 <= Weight01_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
        Array_Mac1_weight2 <= Weight02_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
        Array_Mac1_weight3 <= Weight10_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
        Array_Mac1_weight4 <= Weight11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
        Array_Mac1_weight5 <= Weight12_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
        Array_Mac1_weight6 <= Weight20_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
        Array_Mac1_weight7 <= Weight21_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
        Array_Mac1_weight8 <= Weight22_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];

        Array_Mac2_weight0 <= Weight00_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
        Array_Mac2_weight1 <= Weight01_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
        Array_Mac2_weight2 <= Weight02_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
        Array_Mac2_weight3 <= Weight10_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
        Array_Mac2_weight4 <= Weight11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
        Array_Mac2_weight5 <= Weight12_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
        Array_Mac2_weight6 <= Weight20_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
        Array_Mac2_weight7 <= Weight21_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
        Array_Mac2_weight8 <= Weight22_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];

        //-------------                    >>> group 1 /////////////////
        Array_Mac3_weight0 <= Weight00_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
        Array_Mac3_weight1 <= Weight01_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
        Array_Mac3_weight2 <= Weight02_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
        Array_Mac3_weight3 <= Weight10_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
        Array_Mac3_weight4 <= Weight11_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
        Array_Mac3_weight5 <= Weight12_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
        Array_Mac3_weight6 <= Weight20_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
        Array_Mac3_weight7 <= Weight21_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
        Array_Mac3_weight8 <= Weight22_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];

        Array_Mac4_weight0 <= Weight00_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
        Array_Mac4_weight1 <= Weight01_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
        Array_Mac4_weight2 <= Weight02_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
        Array_Mac4_weight3 <= Weight10_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
        Array_Mac4_weight4 <= Weight11_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
        Array_Mac4_weight5 <= Weight12_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
        Array_Mac4_weight6 <= Weight20_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
        Array_Mac4_weight7 <= Weight21_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
        Array_Mac4_weight8 <= Weight22_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];

        Array_Mac5_weight0 <= Weight00_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
        Array_Mac5_weight1 <= Weight01_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
        Array_Mac5_weight2 <= Weight02_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
        Array_Mac5_weight3 <= Weight10_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
        Array_Mac5_weight4 <= Weight11_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
        Array_Mac5_weight5 <= Weight12_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
        Array_Mac5_weight6 <= Weight20_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
        Array_Mac5_weight7 <= Weight21_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
        Array_Mac5_weight8 <= Weight22_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];

        //-------------                    >>> group 2 /////////////////
        Array_Mac6_weight0 <= Weight00_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
        Array_Mac6_weight1 <= Weight01_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
        Array_Mac6_weight2 <= Weight02_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
        Array_Mac6_weight3 <= Weight10_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
        Array_Mac6_weight4 <= Weight11_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
        Array_Mac6_weight5 <= Weight12_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
        Array_Mac6_weight6 <= Weight20_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
        Array_Mac6_weight7 <= Weight21_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
        Array_Mac6_weight8 <= Weight22_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];

        Array_Mac7_weight0 <= Weight00_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
        Array_Mac7_weight1 <= Weight01_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
        Array_Mac7_weight2 <= Weight02_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
        Array_Mac7_weight3 <= Weight10_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
        Array_Mac7_weight4 <= Weight11_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
        Array_Mac7_weight5 <= Weight12_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
        Array_Mac7_weight6 <= Weight20_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
        Array_Mac7_weight7 <= Weight21_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
        Array_Mac7_weight8 <= Weight22_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];

        Array_Mac8_weight0 <= Weight00_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
        Array_Mac8_weight1 <= Weight01_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
        Array_Mac8_weight2 <= Weight02_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
        Array_Mac8_weight3 <= Weight10_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
        Array_Mac8_weight4 <= Weight11_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
        Array_Mac8_weight5 <= Weight12_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
        Array_Mac8_weight6 <= Weight20_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
        Array_Mac8_weight7 <= Weight21_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
        Array_Mac8_weight8 <= Weight22_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
      end
      3'd2:   //DW
      begin
        Array_Mac0_weight0 <= Weight00_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
        Array_Mac0_weight1 <= Weight01_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
        Array_Mac0_weight2 <= Weight02_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
        Array_Mac0_weight3 <= Weight10_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
        Array_Mac0_weight4 <= Weight11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
        Array_Mac0_weight5 <= Weight12_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
        Array_Mac0_weight6 <= Weight20_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
        Array_Mac0_weight7 <= Weight21_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
        Array_Mac0_weight8 <= Weight22_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];

        Array_Mac1_weight0 <= Weight00_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
        Array_Mac1_weight1 <= Weight01_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
        Array_Mac1_weight2 <= Weight02_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
        Array_Mac1_weight3 <= Weight10_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
        Array_Mac1_weight4 <= Weight11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
        Array_Mac1_weight5 <= Weight12_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
        Array_Mac1_weight6 <= Weight20_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
        Array_Mac1_weight7 <= Weight21_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
        Array_Mac1_weight8 <= Weight22_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];

        Array_Mac2_weight0 <= Weight00_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
        Array_Mac2_weight1 <= Weight01_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
        Array_Mac2_weight2 <= Weight02_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
        Array_Mac2_weight3 <= Weight10_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
        Array_Mac2_weight4 <= Weight11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
        Array_Mac2_weight5 <= Weight12_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
        Array_Mac2_weight6 <= Weight20_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
        Array_Mac2_weight7 <= Weight21_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
        Array_Mac2_weight8 <= Weight22_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];

        Array_Mac3_weight0 <= Weight00_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
        Array_Mac3_weight1 <= Weight01_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
        Array_Mac3_weight2 <= Weight02_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
        Array_Mac3_weight3 <= Weight10_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
        Array_Mac3_weight4 <= Weight11_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
        Array_Mac3_weight5 <= Weight12_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
        Array_Mac3_weight6 <= Weight20_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
        Array_Mac3_weight7 <= Weight21_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
        Array_Mac3_weight8 <= Weight22_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];

        Array_Mac4_weight0 <= Weight00_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
        Array_Mac4_weight1 <= Weight01_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
        Array_Mac4_weight2 <= Weight02_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
        Array_Mac4_weight3 <= Weight10_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
        Array_Mac4_weight4 <= Weight11_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
        Array_Mac4_weight5 <= Weight12_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
        Array_Mac4_weight6 <= Weight20_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
        Array_Mac4_weight7 <= Weight21_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
        Array_Mac4_weight8 <= Weight22_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];

        Array_Mac5_weight0 <= Weight00_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
        Array_Mac5_weight1 <= Weight01_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
        Array_Mac5_weight2 <= Weight02_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
        Array_Mac5_weight3 <= Weight10_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
        Array_Mac5_weight4 <= Weight11_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
        Array_Mac5_weight5 <= Weight12_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
        Array_Mac5_weight6 <= Weight20_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
        Array_Mac5_weight7 <= Weight21_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
        Array_Mac5_weight8 <= Weight22_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];

        Array_Mac6_weight0 <= Weight00_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
        Array_Mac6_weight1 <= Weight01_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
        Array_Mac6_weight2 <= Weight02_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
        Array_Mac6_weight3 <= Weight10_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
        Array_Mac6_weight4 <= Weight11_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
        Array_Mac6_weight5 <= Weight12_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
        Array_Mac6_weight6 <= Weight20_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
        Array_Mac6_weight7 <= Weight21_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
        Array_Mac6_weight8 <= Weight22_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];

        Array_Mac7_weight0 <= Weight00_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
        Array_Mac7_weight1 <= Weight01_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
        Array_Mac7_weight2 <= Weight02_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
        Array_Mac7_weight3 <= Weight10_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
        Array_Mac7_weight4 <= Weight11_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
        Array_Mac7_weight5 <= Weight12_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
        Array_Mac7_weight6 <= Weight20_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
        Array_Mac7_weight7 <= Weight21_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
        Array_Mac7_weight8 <= Weight22_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];

        Array_Mac8_weight0 <= Weight00_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
        Array_Mac8_weight1 <= Weight01_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
        Array_Mac8_weight2 <= Weight02_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
        Array_Mac8_weight3 <= Weight10_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
        Array_Mac8_weight4 <= Weight11_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
        Array_Mac8_weight5 <= Weight12_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
        Array_Mac8_weight6 <= Weight20_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
        Array_Mac8_weight7 <= Weight21_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
        Array_Mac8_weight8 <= Weight22_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
      end
      3'd3:    //PW
      begin
        Array_Mac0_weight0 <= Weight00_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
        Array_Mac0_weight1 <= Weight00_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
        Array_Mac0_weight2 <= Weight00_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
        Array_Mac0_weight3 <= Weight00_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
        Array_Mac0_weight4 <= Weight00_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
        Array_Mac0_weight5 <= Weight00_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
        Array_Mac0_weight6 <= Weight00_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
        Array_Mac0_weight7 <= Weight00_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
        Array_Mac0_weight8 <= Weight00_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];

        Array_Mac1_weight0 <= Weight01_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
        Array_Mac1_weight1 <= Weight01_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
        Array_Mac1_weight2 <= Weight01_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
        Array_Mac1_weight3 <= Weight01_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
        Array_Mac1_weight4 <= Weight01_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
        Array_Mac1_weight5 <= Weight01_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
        Array_Mac1_weight6 <= Weight01_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
        Array_Mac1_weight7 <= Weight01_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
        Array_Mac1_weight8 <= Weight01_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];

        Array_Mac2_weight0 <= Weight02_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
        Array_Mac2_weight1 <= Weight02_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
        Array_Mac2_weight2 <= Weight02_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
        Array_Mac2_weight3 <= Weight02_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
        Array_Mac2_weight4 <= Weight02_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
        Array_Mac2_weight5 <= Weight02_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
        Array_Mac2_weight6 <= Weight02_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
        Array_Mac2_weight7 <= Weight02_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
        Array_Mac2_weight8 <= Weight02_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];

        Array_Mac3_weight0 <= Weight10_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
        Array_Mac3_weight1 <= Weight10_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
        Array_Mac3_weight2 <= Weight10_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
        Array_Mac3_weight3 <= Weight10_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
        Array_Mac3_weight4 <= Weight10_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
        Array_Mac3_weight5 <= Weight10_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
        Array_Mac3_weight6 <= Weight10_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
        Array_Mac3_weight7 <= Weight10_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
        Array_Mac3_weight8 <= Weight10_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];

        Array_Mac4_weight0 <= Weight11_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
        Array_Mac4_weight1 <= Weight11_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
        Array_Mac4_weight2 <= Weight11_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
        Array_Mac4_weight3 <= Weight11_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
        Array_Mac4_weight4 <= Weight11_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
        Array_Mac4_weight5 <= Weight11_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
        Array_Mac4_weight6 <= Weight11_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
        Array_Mac4_weight7 <= Weight11_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
        Array_Mac4_weight8 <= Weight11_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];

        Array_Mac5_weight0 <= Weight12_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
        Array_Mac5_weight1 <= Weight12_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
        Array_Mac5_weight2 <= Weight12_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
        Array_Mac5_weight3 <= Weight12_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
        Array_Mac5_weight4 <= Weight12_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
        Array_Mac5_weight5 <= Weight12_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
        Array_Mac5_weight6 <= Weight12_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
        Array_Mac5_weight7 <= Weight12_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
        Array_Mac5_weight8 <= Weight12_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];

        Array_Mac6_weight0 <= Weight20_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
        Array_Mac6_weight1 <= Weight20_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
        Array_Mac6_weight2 <= Weight20_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
        Array_Mac6_weight3 <= Weight20_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
        Array_Mac6_weight4 <= Weight20_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
        Array_Mac6_weight5 <= Weight20_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
        Array_Mac6_weight6 <= Weight20_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
        Array_Mac6_weight7 <= Weight20_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
        Array_Mac6_weight8 <= Weight20_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];

        Array_Mac7_weight0 <= Weight21_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
        Array_Mac7_weight1 <= Weight21_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
        Array_Mac7_weight2 <= Weight21_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
        Array_Mac7_weight3 <= Weight21_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
        Array_Mac7_weight4 <= Weight21_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
        Array_Mac7_weight5 <= Weight21_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
        Array_Mac7_weight6 <= Weight21_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
        Array_Mac7_weight7 <= Weight21_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
        Array_Mac7_weight8 <= Weight21_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];

        Array_Mac8_weight0 <= Weight22_in[ 1 * FM_SIZE_WIDTH -1 : 0 * FM_SIZE_WIDTH];
        Array_Mac8_weight1 <= Weight22_in[ 2 * FM_SIZE_WIDTH -1 : 1 * FM_SIZE_WIDTH];
        Array_Mac8_weight2 <= Weight22_in[ 3 * FM_SIZE_WIDTH -1 : 2 * FM_SIZE_WIDTH];
        Array_Mac8_weight3 <= Weight22_in[ 4 * FM_SIZE_WIDTH -1 : 3 * FM_SIZE_WIDTH];
        Array_Mac8_weight4 <= Weight22_in[ 5 * FM_SIZE_WIDTH -1 : 4 * FM_SIZE_WIDTH];
        Array_Mac8_weight5 <= Weight22_in[ 6 * FM_SIZE_WIDTH -1 : 5 * FM_SIZE_WIDTH];
        Array_Mac8_weight6 <= Weight22_in[ 7 * FM_SIZE_WIDTH -1 : 6 * FM_SIZE_WIDTH];
        Array_Mac8_weight7 <= Weight22_in[ 8 * FM_SIZE_WIDTH -1 : 7 * FM_SIZE_WIDTH];
        Array_Mac8_weight8 <= Weight22_in[ 9 * FM_SIZE_WIDTH -1 : 8 * FM_SIZE_WIDTH];
      end
      default:
      begin
        Array_Mac0_weight0 <= 0;
        Array_Mac0_weight1 <= 0;
        Array_Mac0_weight2 <= 0;
        Array_Mac0_weight3 <= 0;
        Array_Mac0_weight4 <= 0;
        Array_Mac0_weight5 <= 0;
        Array_Mac0_weight6 <= 0;
        Array_Mac0_weight7 <= 0;
        Array_Mac0_weight8 <= 0;

        Array_Mac1_weight0 <= 0;
        Array_Mac1_weight1 <= 0;
        Array_Mac1_weight2 <= 0;
        Array_Mac1_weight3 <= 0;
        Array_Mac1_weight4 <= 0;
        Array_Mac1_weight5 <= 0;
        Array_Mac1_weight6 <= 0;
        Array_Mac1_weight7 <= 0;
        Array_Mac1_weight8 <= 0;

        Array_Mac2_weight0 <= 0;
        Array_Mac2_weight1 <= 0;
        Array_Mac2_weight2 <= 0;
        Array_Mac2_weight3 <= 0;
        Array_Mac2_weight4 <= 0;
        Array_Mac2_weight5 <= 0;
        Array_Mac2_weight6 <= 0;
        Array_Mac2_weight7 <= 0;
        Array_Mac2_weight8 <= 0;

        Array_Mac3_weight0 <= 0;
        Array_Mac3_weight1 <= 0;
        Array_Mac3_weight2 <= 0;
        Array_Mac3_weight3 <= 0;
        Array_Mac3_weight4 <= 0;
        Array_Mac3_weight5 <= 0;
        Array_Mac3_weight6 <= 0;
        Array_Mac3_weight7 <= 0;
        Array_Mac3_weight8 <= 0;

        Array_Mac4_weight0 <= 0;
        Array_Mac4_weight1 <= 0;
        Array_Mac4_weight2 <= 0;
        Array_Mac4_weight3 <= 0;
        Array_Mac4_weight4 <= 0;
        Array_Mac4_weight5 <= 0;
        Array_Mac4_weight6 <= 0;
        Array_Mac4_weight7 <= 0;
        Array_Mac4_weight8 <= 0;

        Array_Mac5_weight0 <= 0;
        Array_Mac5_weight1 <= 0;
        Array_Mac5_weight2 <= 0;
        Array_Mac5_weight3 <= 0;
        Array_Mac5_weight4 <= 0;
        Array_Mac5_weight5 <= 0;
        Array_Mac5_weight6 <= 0;
        Array_Mac5_weight7 <= 0;
        Array_Mac5_weight8 <= 0;

        Array_Mac6_weight0 <= 0;
        Array_Mac6_weight1 <= 0;
        Array_Mac6_weight2 <= 0;
        Array_Mac6_weight3 <= 0;
        Array_Mac6_weight4 <= 0;
        Array_Mac6_weight5 <= 0;
        Array_Mac6_weight6 <= 0;
        Array_Mac6_weight7 <= 0;
        Array_Mac6_weight8 <= 0;

        Array_Mac7_weight0 <= 0;
        Array_Mac7_weight1 <= 0;
        Array_Mac7_weight2 <= 0;
        Array_Mac7_weight3 <= 0;
        Array_Mac7_weight4 <= 0;
        Array_Mac7_weight5 <= 0;
        Array_Mac7_weight6 <= 0;
        Array_Mac7_weight7 <= 0;
        Array_Mac7_weight8 <= 0;

        Array_Mac8_weight0 <= 0;
        Array_Mac8_weight1 <= 0;
        Array_Mac8_weight2 <= 0;
        Array_Mac8_weight3 <= 0;
        Array_Mac8_weight4 <= 0;
        Array_Mac8_weight5 <= 0;
        Array_Mac8_weight6 <= 0;
        Array_Mac8_weight7 <= 0;
        Array_Mac8_weight8 <= 0;
      end
    endcase
  end

  /////////////////------------------------------------------------/////////////////////
  /////////////////////////////  [6]. M1 arbiter ////////////////////////////
  /////////////////------------------------------------------------////////////////////
  always@(posedge clk)
  begin
    case(Mode_reg[0])
      3'd1:
      begin
        Array_Mac0_M1 <= Bias_in[ 1 * BIAS_WIDTH -1 : 0 * BIAS_WIDTH];
        Array_Mac1_M1 <= 0;
        Array_Mac2_M1 <= 0;
        Array_Mac3_M1 <= Bias_in[ 4 * BIAS_WIDTH -1 : 3 * BIAS_WIDTH];
        Array_Mac4_M1 <= 0;
        Array_Mac5_M1 <= 0;
        Array_Mac6_M1 <= Bias_in[ 7 * BIAS_WIDTH -1 : 6 * BIAS_WIDTH];
        Array_Mac7_M1 <= 0;
        Array_Mac8_M1 <= 0;
      end
      3'd2:
      begin
        Array_Mac0_M1 <= Bias_in[ 1 * BIAS_WIDTH -1 : 0 * BIAS_WIDTH];
        Array_Mac1_M1 <= Bias_in[ 2 * BIAS_WIDTH -1 : 1 * BIAS_WIDTH];
        Array_Mac2_M1 <= Bias_in[ 3 * BIAS_WIDTH -1 : 2 * BIAS_WIDTH];
        Array_Mac3_M1 <= Bias_in[ 4 * BIAS_WIDTH -1 : 3 * BIAS_WIDTH];
        Array_Mac4_M1 <= Bias_in[ 5 * BIAS_WIDTH -1 : 4 * BIAS_WIDTH];
        Array_Mac5_M1 <= Bias_in[ 6 * BIAS_WIDTH -1 : 5 * BIAS_WIDTH];
        Array_Mac6_M1 <= Bias_in[ 7 * BIAS_WIDTH -1 : 6 * BIAS_WIDTH];
        Array_Mac7_M1 <= Bias_in[ 8 * BIAS_WIDTH -1 : 7 * BIAS_WIDTH];
        Array_Mac8_M1 <= Bias_in[ 9 * BIAS_WIDTH -1 : 8 * BIAS_WIDTH];
      end
      3'd3:
      begin
        Array_Mac0_M1 <= Bias_in[ 1 * BIAS_WIDTH -1 : 0 * BIAS_WIDTH];
        Array_Mac1_M1 <= Bias_in[ 2 * BIAS_WIDTH -1 : 1 * BIAS_WIDTH];
        Array_Mac2_M1 <= Bias_in[ 3 * BIAS_WIDTH -1 : 2 * BIAS_WIDTH];
        Array_Mac3_M1 <= Bias_in[ 4 * BIAS_WIDTH -1 : 3 * BIAS_WIDTH];
        Array_Mac4_M1 <= Bias_in[ 5 * BIAS_WIDTH -1 : 4 * BIAS_WIDTH];
        Array_Mac5_M1 <= Bias_in[ 6 * BIAS_WIDTH -1 : 5 * BIAS_WIDTH];
        Array_Mac6_M1 <= Bias_in[ 7 * BIAS_WIDTH -1 : 6 * BIAS_WIDTH];
        Array_Mac7_M1 <= Bias_in[ 8 * BIAS_WIDTH -1 : 7 * BIAS_WIDTH];
        Array_Mac8_M1 <= Bias_in[ 9 * BIAS_WIDTH -1 : 8 * BIAS_WIDTH];
      end
      3'd4:
      begin
        Array_Mac0_M1 <= Weight_base_addr;
        Array_Mac1_M1 <= Weight_base_addr;
        Array_Mac2_M1 <= Weight_base_addr;
        Array_Mac3_M1 <= Weight_base_addr;
        Array_Mac4_M1 <= Weight_base_addr;
        Array_Mac5_M1 <= Weight_base_addr;
        Array_Mac6_M1 <= Weight_base_addr;
        Array_Mac7_M1 <= Weight_base_addr;
        Array_Mac8_M1 <= Weight_base_addr;
      end
      default:
      begin
        Array_Mac0_M1 <=  0;
        Array_Mac1_M1 <=  0;
        Array_Mac2_M1 <=  0;
        Array_Mac3_M1 <=  0;
        Array_Mac4_M1 <=  0;
        Array_Mac5_M1 <=  0;
        Array_Mac6_M1 <=  0;
        Array_Mac7_M1 <=  0;
        Array_Mac8_M1 <=  0;
      end
    endcase
  end

  // 5. complete
  // Frame complete signal
  reg [19:0] pw_complete;
  wire sc_complete;
  assign sc_complete = (Mode == 3'd4)&&(write_h_block_idx == row_block_num -1)&&(write_v_block_idx == row_block_num -1)&&(Write_Channel_cnt == ofmap_channel - 1)&&(write_valid == 1'b1);
  reg [6:0] sc_complete_reg;
  always @(posedge clk)
  begin
    if(!rst_n)
    begin
      sc_complete_reg <= 0;
    end
    else
    begin
      sc_complete_reg <= {sc_complete_reg[5:0], sc_complete};
    end
  end

  always@(*)
  begin
    if((Ofmap_vert_base_cnt == ofmap_size - 1 && Ofmap_hori_base_cnt == ofmap_size - 1 && Write_Channel_cnt == ofmap_channel - 1 && write_valid)&&(Mode != 3'd3)&&(Mode != 3'd4)&&(Mode != 3'd5))
      complete = 1'b1;
    else if ((Mode == 3'd3)&&(pw_complete[19]))
      complete = 1'b1;
    else if ((Mode == 3'd4)&&(sc_complete_reg[6]))
      complete = 1'b1;
    else if ((Mode == 3'd5)&&(Write_Channel_cnt == ofmap_channel - 1)&&(write_valid == 1'b1))
      complete = 1'b1;
    else if ((Mode == 3'd6)&&(softmax_finish) )
      complete = 1'b1;
    else
      complete = 1'b0;
  end
  reg [7:0] tlast_sync;
  reg tlast_pw_no_sync;
  reg [8:0] tlast_pw_reg;

  // read last signal
  reg read_last;
  always @(posedge clk)
  begin
    if(!rst_n)
    begin
      read_last <= 0;
    end
    else
    begin
      if ((Mode_reg[0] == 3'd0)&&(Mode == 3'd3))
      begin
        read_last <= 0;
      end
      else if((Mode==3'd3)&& (Channel_cnt==ifmap_channel-1) &&(Kernel_cnt == kernel_num-1) && (Ifmap_hori_base_cnt == ofmap_size-1) && (Ifmap_vert_base_cnt == ofmap_size -1))
      begin
        read_last <= 1;
      end
      else
      begin
        read_last <= read_last;
      end
    end
  end
  reg stop_tlast_pw;
  always @(posedge clk)
  begin
    if(!rst_n)
    begin
      stop_tlast_pw <= 0;
    end
    else
    begin
      if (read_last == 0)
      begin
        stop_tlast_pw <= 0;
      end
      else if (read_last && tlast_pw_no_sync)
      begin
        stop_tlast_pw <= 1;
      end
      else
      begin
        stop_tlast_pw <= stop_tlast_pw;
      end
    end
  end

  always @(*)
  begin
    case(Mode)
      3'd1:
        tlast_no_sync = (bram_st == CALCULATE);
      3'd2:
        tlast_no_sync = (bram_st == CALCULATE);
      3'd3:
        tlast_no_sync = (Channel_cnt==ifmap_channel-1);
      default:
        tlast_no_sync = 0;
    endcase
  end
  // assign tlast_no_sync = (Mode==3'd3)?(Channel_cnt==ifmap_channel-1):(bram_st == CALCULATE);

  always @( *)
  begin
    case(Mode)
      3'd3:
        tlast_pw_no_sync = stop_tlast_pw ? 1'b0:(Channel_cnt == 1);
      default:
        tlast_pw_no_sync = 1'b0;
    endcase
  end
  // assign tlast_pw_no_sync = stop_tlast_pw ? 1'b0:(Channel_cnt == 1);
  always @(posedge clk)
  begin
    if(!rst_n)
    begin
      tlast_pw_reg <= 0;
      tlast_pw <= 0;
    end
    else
    begin
      tlast_pw_reg <= {tlast_pw_reg[7:0], tlast_pw_no_sync && bram_next_st};
      tlast_pw <= tlast_pw_reg[7];
    end
  end

  always @(posedge clk)
  begin
    if(!rst_n)
    begin
      pw_complete <= 0;
    end
    else
    begin
      pw_complete <= {pw_complete[18:0], read_last && tlast_pw_no_sync};
    end
  end
  always@(posedge clk)
  begin
    if(!rst_n)
    begin
      tlast_sync <= 0;
    end
    else
    begin
      tlast_sync <= {tlast_sync[6:0], tlast_no_sync && bram_next_st};
    end
  end
  always @( *)
  begin
    case(Mode)
      3'd1:
        tlast = tlast_sync[4];
      3'd2:
        tlast = tlast_sync[4];
      3'd3:
        tlast = tlast_sync[7];
      default:
        tlast = tlast_sync[4];
    endcase
  end
  assign busy = (bram_st == CALCULATE);

endmodule
