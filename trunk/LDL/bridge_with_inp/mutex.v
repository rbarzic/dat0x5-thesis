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
   
   always @* begin
        if(reset) begin
            g1 = 1'b0;
            g2 = 1'b0;
        end
   end
   always @(posedge r1) begin
        if(!r2)
              g1 = r1;
   end

   always @(posedge r2) begin
        if(!r1)
              g2 = r2;
   end

   always @(negedge r1) begin
        g1 = 1'b0;
        g2 = r2;
   end

   always @(negedge r2) begin
        g2 = 1'b0;
        g1 = r1;
   end


endmodule // mutex
