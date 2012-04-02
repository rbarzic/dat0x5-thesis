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
   real v1, v2, diff, conf = 0;   
   integer delay, setg1 = 0;

   always @* begin
        if(reset) begin
            g1 = 1'b0;
            g2 = 1'b0;
        end
   end
   always @(posedge r1) begin
        #1;        
        if(!r2 && conf == 0) begin
              g1 = r1;
        end else if (conf == 1 && setg1) begin
              #delay g1 = r1;
        end 
   end

   always @(posedge r2) begin
        #1;
         if(!r1 && conf == 0) begin
              g2 = r2;
        end else if (conf == 1 && setg1 == 0) begin
              #delay g2 = r2;
        end
   end

   always @(negedge r1) begin
        g1 = 1'b0;
        g2 = r2;
   end

   always @(negedge r2) begin
        g2 = 1'b0;
        g1 = r1;
   end
   
   always @(posedge r1)
        v1 = $realtime;

   always @(posedge r2)
        v2 = $realtime;

   always @* begin
        diff = v2 - v1;
        if(diff <= 3 && diff >= -3) begin
                conf = 1;
                delay = $random % 5;
                if(delay % 2 == 0)
                        setg1 = 1;
                else
                        setg1 = 0;
        end else begin
                conf = 0;
        end            
   end

endmodule // mutex
