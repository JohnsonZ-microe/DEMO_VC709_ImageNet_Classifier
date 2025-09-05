(* DONT_TOUCH = "TRUE" *)
module bram_tdp_cas #(
		  parameter DW=36,
		  parameter AW=12
		  ) (
		     input 	     clkA, clkB,rstA, rstB,
		     input [AW-1:0]  addrA, addrB,
		     input [DW-1:0]  dinA, dinB,
		     input  	     enA, enB, weA, weB,
		     output reg [DW-1:0] doutA, doutB
		     );
(* ram_style = "block" *)
   reg [DW-1:0] mem [0:(1<<AW)-1];

reg [DW-1:0] doutA_1;
reg [DW-1:0] doutB_1;

   always @(posedge clkA) begin
     if (rstA)
	doutA <= 0;
     else if(enA && weA)
     begin
        mem[addrA] <= dinA;
        doutA_1 <= mem[addrA];
        doutA <= doutA_1;
     end
   end

   always @(posedge clkB) begin
     if (rstB)
	doutB <= 0;
     else if(enB && weB)
     begin
        mem[addrB] <= dinB;
        doutB_1 <= mem[addrB];
        doutB <= doutB_1;
     end
   end


endmodule // bram_tdp
