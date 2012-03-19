`include "timescale.v"
module srlatch(/*AUTOARG*/
   // Outputs
   q,
   // Inputs
   s, r
   );
`include "def.v"

   output q;
   input  s, r;

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg			q;
   // End of automatics

   always @(s or r) begin
      if (s & r) begin
	 q = 1'b0;	 
      end else if (~s & r) begin
	 q = 1'b0;
      end else if(s & ~r) begin
	 q = 1'b1;
      end
   end   

endmodule // srlatch
