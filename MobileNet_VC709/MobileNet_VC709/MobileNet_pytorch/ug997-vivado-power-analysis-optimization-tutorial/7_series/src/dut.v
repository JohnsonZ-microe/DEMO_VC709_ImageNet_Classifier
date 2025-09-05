//----------------------------------------------------------------
// Top level DUT
//----------------------------------------------------------------
module dut( ref_clk_in,
            reset,
            clock_en_in,
            start_in,
            stop_in,
            pass_out,
            fmc_out
           );

input           ref_clk_in;
input           reset;
input           clock_en_in;
input           start_in;
input           stop_in;

output          pass_out;

output [9:0]    fmc_out;


   parameter NUM = 10;

   wire [NUM-1:0] pass_i;
     
   reg start_d;
   
   always @ (posedge ref_clk_in)
    start_d <=  start_in & (!stop_in);
      
   genvar i;
   generate
      for (i = 0; i < NUM; i= i+1) begin:gen_dut
	 bram_top #(.ID(i)) bram_top_inst(
		 .clk         (ref_clk_in),
		 .rst         (reset),
		 .dut_start   (start_d),
		 .dut_enable  (clock_en_in),
		 .pass        (pass_i[i])
		 );
      end
   endgenerate

   
   assign pass_out = &pass_i;
   
   assign fmc_out = pass_i;

endmodule // dut
