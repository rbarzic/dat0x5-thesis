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
   
   wire   x1, x2;
   
   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg			g1;
   reg			g2;
   // End of automatics
   
   always begin
        g1 = 1'b0;
        g2 = 1'b0;
        wait(r1 || r2);
        #10;
        if (r1 && r2) begin
                #({$random}%100 +10);
                if ({$random}%2)
                        g1 = 1'b1;
                else
                        g2 = 1'b1;
        end
        else if (r1) begin
                g1 = 1'b1;
        end
        else if (r2) begin
                g2 = 1'b1;
        end
        else begin
                // error
        end
   end
   

endmodule // mutex
