// LFSR based design TOP
//

module dut_fpga(
	   // Inputs
	   input 	sys_clk_in_p, 
	   input 	sys_clk_in_n,
	   // Outputs
	   output 	gpio_out_pass, 
	   output   led,
       output [9:0] fmc_out
	   );

   (* KEEP="TRUE" *)
   wire 		clkout0, dut_clk;
   wire 		dut_reset, mmcm_lock_o;
   wire 		clk_0, clk_0_bufg;
   wire 		pass;
   
   dut dut(
	   .ref_clk_in    (dut_clk),
           .reset         (dut_reset),
           .clock_en_in   (mmcm_lock_o),
           .start_in      (mmcm_lock_o),
           .stop_in       (~mmcm_lock_o),
           .pass_out      (pass),
           .fmc_out       (fmc_out)
           );

   
   assign led = mmcm_lock_o;
   assign gpio_out_pass = pass;
   
   assign dut_reset = ~mmcm_lock_o;


   BUFG bufg_i ( .O(dut_clk), .I(clkout0) );
   
   IBUFGDS in_diff_bufg (
			 .O(sys_clk),
			 .I(sys_clk_in_p),
			 .IB(sys_clk_in_n)
			 );
   
   MMCM_ADV #(
              .DIVCLK_DIVIDE(1),
              .CLKFBOUT_MULT_F(6.0),
              .CLKOUT0_DIVIDE_F(12.0),
              .CLKIN1_PERIOD(5.0)    // 200 MHz (input clock)
              ) mmcm_i 
     (
      .CLKFBOUT     (clk_0),
      .CLKOUT0      (clkout0), // 100MHz clock
      .LOCKED       (mmcm_lock_o),
      .CLKFBIN      (clk_0_bufg),
      .CLKIN1       (sys_clk),
      .CLKIN2       (1'b0),
      .CLKINSEL     (1'b1),
      .DADDR        (7'b0),
      .DCLK         (1'b0),
      .DEN          (1'b0),
      .DI           (16'b0),
      .DWE          (1'b0),
      .PSCLK        (1'b0),
      .PSEN         (1'b0),
      .PSINCDEC     (1'b0),
      .PWRDWN       (1'b0),
      .RST          (1'b0)
      );
   
   BUFG bufg_0 (
		.O(clk_0_bufg),
		.I(clk_0)
		);        
endmodule // dut_fpga

