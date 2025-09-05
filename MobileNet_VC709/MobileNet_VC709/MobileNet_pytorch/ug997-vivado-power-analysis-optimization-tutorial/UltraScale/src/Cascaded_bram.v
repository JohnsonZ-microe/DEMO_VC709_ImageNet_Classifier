(* DONT_TOUCH = "TRUE" *)
module Cascaded_bram(input clk, rst, dut_start, dut_enable, output  pass);

parameter NUM = 40;

wire [NUM-1:0] pass_i;

   genvar i;
   generate
      for (i = 0; i < NUM; i= i+1) begin:gen_dut
           bram_top_cascade #(.ID(i)) bram_top_cascade(
   		 .clk         (clk),
   		 .rst         (rst),
   		 .dut_start   (dut_start),
   		 .dut_enable  (dut_enable),
   		 .pass        (pass_i[i])
   		 );
      end
   endgenerate
   
   assign pass = &pass_i;

endmodule
