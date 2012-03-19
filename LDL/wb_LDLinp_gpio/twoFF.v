`include "timescale.v"
module twoFF(/*AUTOARG*/
   // Outputs
   ack_o,
   // Inputs
   ack_in, clk_m, reset_m
   );
`include "def.v"
   
   output ack_o;
   input  ack_in, clk_m, reset_m;

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg			ack_o;
   // End of automatics
   reg 			a1, a2, a3;
   reg 			b1, b2, b3;
			
   
   always @(posedge clk_m or posedge reset_m) begin
      if(reset_m) begin
	 ack_o <= 1'b0;
	 b1 <= 1'b0;
	 b2 <= 1'b0;	 
      end else begin
	 b1 <= ack_in;
	 b2 <= b1;
	 ack_o <= b2;
     end        
   end // always @ (posedge clk_m or posedge reset_m)

endmodule // twoFF

