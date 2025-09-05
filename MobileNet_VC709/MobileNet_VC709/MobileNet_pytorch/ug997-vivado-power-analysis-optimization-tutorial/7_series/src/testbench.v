`timescale 1ns/1ps

module testbench ;
   
   parameter WATCHDOG = 100000;
   
   reg sys_clk_p;
   wire sys_clk_n;
   wire led;
   wire       pass;
   
   initial begin
      sys_clk_p = 1'b0;
      forever sys_clk_p = #2.5 ~sys_clk_p;
   end
   
   assign sys_clk_n = ~sys_clk_p;
   
`ifdef VCD
   initial begin
      $dumpvars;
   end
`endif
   
   initial begin
      repeat (WATCHDOG) @ (posedge sys_clk_p);
      $display ($time, " Watch dog timer expired...exiting simulation\n");
      $stop;
   end
   
   always @(pass)
     $strobe("Time = %0d ns, PASS = %b" , $time, pass);
   
   dut_fpga dut_fpga(
		// Inputs
		.sys_clk_in_p(sys_clk_p), 
		.sys_clk_in_n(sys_clk_n),
		// Outputs
		.gpio_out_pass(pass), 
		.led(led),
		.fmc_out()
		);
   
endmodule // testbench

