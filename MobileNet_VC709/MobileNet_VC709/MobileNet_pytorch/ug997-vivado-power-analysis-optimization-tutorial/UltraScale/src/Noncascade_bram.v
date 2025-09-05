(* DONT_TOUCH = "TRUE" *)
module Noncascade_bram(input clk, rst, dut_start, dut_enable, output pass);

parameter NUM = 40;

wire [NUM-1:0] pass_j;

   genvar k;
   generate
      for (k = 0; k < NUM; k= k+1) begin:gen_dut1
           bram_top_noncascade #(.ID(k)) bram_top_noncascade(
   		 .clk         (clk),
   		 .rst         (rst),
   		 .dut_start   (dut_start),
   		 .dut_enable  (dut_enable),
   		 .pass        (pass_j[k])
   		 );
      end
   endgenerate

   assign pass = &pass_j;

endmodule 
