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

output [1:0]    fmc_out;

   wire   pass_1;
   wire   pass_2;
  
   Cascaded_bram Cascaded_bram(		
                 .clk         (ref_clk_in),
		 .rst         (reset),
		 .dut_start   (start_in & (!stop_in)),
		 .dut_enable  (clock_en_in),
		 .pass        (pass_1)       
		 );
		 
   Noncascade_bram Noncascade_bram(		
                 .clk         (ref_clk_in),
		 .rst         (reset),
		 .dut_start   (start_in & (!stop_in)),
		 .dut_enable  (clock_en_in),
		 .pass        (pass_2)
		 );		 

    assign pass_out = pass_1 & pass_2;
    assign fmc_out  = {pass_1, pass_2};

endmodule // dut
