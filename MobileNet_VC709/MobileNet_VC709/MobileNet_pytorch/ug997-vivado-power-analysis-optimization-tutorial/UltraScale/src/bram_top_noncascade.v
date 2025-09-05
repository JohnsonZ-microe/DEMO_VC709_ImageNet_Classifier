(* DONT_TOUCH = "TRUE" *)
module bram_top_noncascade(input clk, rst, dut_start, dut_enable, output reg pass);
   parameter ID = 0;
   parameter A_WID = 12;
   parameter D_WID = 36;
   
   reg 	en_a, en_b;
   
   reg [A_WID-1:0] addr_a = 'h5A5 ;
   reg [D_WID-1:0] din_a = 'h000000000; 
   reg 		   we_a;
 		  
   reg [A_WID-1:0] addr_b = 'hA5A ;	
   reg [D_WID-1:0] din_b = 'hFFFFFFFFF; 
   reg 		   we_b;
   
   wire [D_WID-1:0] dout_a;
   wire [D_WID-1:0] dout_b;

   reg pass_a;
   reg pass_b;


   bram_tdp_noncas #(
	      .DW(D_WID),
	      .AW(A_WID)
	      ) 
   bram_noncas
     (
      .enA(en_a),
      .enB(en_b),
      .rstA(rst),
      .rstB(rst),
      .clkA(clk),
      .clkB(clk),
      .weA(we_a),
      .weB(we_b),
      .addrA(addr_a),
      .addrB(addr_b),
      .dinA(din_a),
      .dinB(din_b),
      .doutA(dout_a),
      .doutB(dout_b)
      );

   always @(negedge clk)
	if(rst) begin
	   addr_a <= 'h5A5;
	   addr_b <= 'hA5A;
	   din_a <= 'h000000000;
	   din_b <= 'hFFFFFFFFF;
	end
	else if (dut_start) begin
	   din_a  <= din_b;
	   din_b <= din_a;
	   addr_a <= ~addr_a;
	   addr_b <= ~addr_b;
	end
	     
   always @(negedge clk)
	if(rst) begin
	   {en_a, we_a, en_b, we_b} <= 0;
	end 
	else if (dut_start) begin
	   {en_a,en_b} <= 2'b11;
	   {we_a,we_b} <= 2'b11;	   
	end

   always @(posedge clk)
        if(rst) begin
           pass_a <= 0;
           pass_b <= 0;
        end
        else if (dut_start) begin
           if ( (addr_b === 'hA5A && dout_b == 'hFFFFFFFFF) ||
                      (addr_b === 'h5A5 && dout_b == 'h000000000) ) begin
              pass_b <= 1;
           end
           else begin
              $display("ID:%2d - PortB failed", ID); 
              $display("Time : %0d ns, addr_b = %h,  data_b = %h", $time, addr_b, dout_b); 
              pass_b <= 0;
           end  

           if ( (addr_a === 'hA5A && dout_a == 'hFFFFFFFFF) ||
                      (addr_a === 'h5A5 && dout_a == 'h000000000) ) begin
	         pass_a <= 1;
           end
           else begin
             $display("ID:%2d - PortA failed", ID);
             $display("Time = %0d ns, addr_a = %h,  data_a = %h", $time, addr_a, dout_a);
             pass_a <= 0;
           end                 
        end
     
   always @(posedge clk)
         pass <= pass_a & pass_b;

endmodule // bram_top
