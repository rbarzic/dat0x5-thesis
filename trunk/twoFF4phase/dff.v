module dff(/*AUTOARG*/
   // Outputs
   q,
   // Inputs
   d, clk, reset
   );

   input d,clk,reset;
   output q;
   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg			q;
   // End of automatics

   /*AUTOWIRE*/
   always @(posedge clk or posedge reset) begin
      if(reset) begin
	 q <= 1'b0; //using non blocking assignments for the sequential logic
      end else begin
	q <= d;
      end
   end

endmodule // DFF
