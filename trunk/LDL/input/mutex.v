`include "timescale.v"
module mutex(/*AUTOARG*/
   // Outputs
   g1, g2,
   // Inputs
   r1, r2
   );
`include "def.v"
   
   output g1, g2;
   input  r1, r2;
   
   wire   x1, x2;
   
   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg			g1;
   reg			g2;
   // End of automatics
   
   nand nand1(x1, r1, x2);
   nand nand2(x2, r2, x1);
   
   always @* begin
      if(x1 & x2) begin
	 g1 <= 1'b0;
	 g2 <= 1'b0;	 
      end else if(x1 == 1'b0 & x2 == 1'b0) begin
	 g1 <= 1'b0;
	 g2 <= 1'b0;
      end else begin
	 g1 <= x1;
	 g2 <= x2;	 
      end
   end

endmodule // mutex
