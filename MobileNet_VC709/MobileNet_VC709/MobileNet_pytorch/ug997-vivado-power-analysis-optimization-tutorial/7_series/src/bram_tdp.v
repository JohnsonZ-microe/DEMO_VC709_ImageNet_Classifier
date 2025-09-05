(* DONT_TOUCH = "TRUE" *)
module bram_tdp #(
		  parameter DW=36,
		  parameter AW=10
		  ) (
		     input 	     clkA, clkB,rstA, rstB,
		     input [AW-1:0]  addrA, addrB,
		     input [DW-1:0]  dinA, dinB,
		     input 	     enA, enB, weA, weB,
		     output reg [DW-1:0] doutA, doutB
		     );
(* ram_style = "block" *)
   reg [DW-1:0] mem [0:(1<<AW)-1];


   always @(posedge clkA) begin
      if (rstA)
	doutA <= 0;
      else if (enA && weA)
	mem[addrA] <= dinA;
      doutA <= mem[addrA];
   end
   
   always @(posedge clkB) begin
      if (rstB)
	doutB <= 0;
      else if (enB && weB)
	mem[addrB] <= dinB;
      doutB <= mem[addrB];
   end

endmodule // bram_tdp
