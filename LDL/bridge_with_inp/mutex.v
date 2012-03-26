`include "timescale.v"
module mutex(/*AUTOARG*/
   // Outputs
   g1, g2,
   // Inputs
   r1, r2, reset
   );
`include "def.v"
   
   output g1, g2;
   input  r1, r2, reset;
   
   wire   x1, x2, g11, g21;
   
   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg			g1;
   reg			g2;
   // End of automatics
   
   always @* begin
        if(reset) begin
            g1 = 1'b0;
            g2 = 1'b0;
        end else begin
            g1 = g11;
            g2 = g21;
        end
   end
   
   nand nand_1(x1, r1, x2);
   nand nand_2(x2, r2, x1);
   nand nand_3(g11, x1, x1, x1);
   nand nand_4(g21, x2, x2, x2); 


endmodule // mutex
