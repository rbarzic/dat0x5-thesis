`include "timescale.v"
module twoFF(/*AUTOARG*/
   // Outputs
   stb_o, ack_o,
   // Inputs
   stb_in, ack_in, clk_m, clk_s, reset_m, reset_s
   );
`include "def.v"
   
   output stb_o, ack_o;
   input  stb_in, ack_in, clk_m, clk_s, reset_m, reset_s;

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg			ack_o;
   reg			stb_o;
   // End of automatics
   reg 			a1, a2, a3;
   reg 			b1, b2, b3;
			
   
   always @(posedge clk_m or posedge reset_m) begin
      if(reset_m) begin
	 ack_o <= 1'b0;
	 b1 <= 1'b0;
	 b2 <= 1'b0;
	 b3 <= 1'b0;
	 
      end else begin
	 b1 <= ack_in;
	 b2 <= b1;
	 ack_o <= b2;
	 
	 //b3 <= b2;
	 //ack_o <= (~b3) & b2;	 
      end        
   end // always @ (posedge clk_m or posedge reset_m)
   
   always @(posedge clk_s or posedge reset_s) begin
	 if(reset_s) begin
	    stb_o <= 1'b0;
	    a1 <= 1'b0;
	    a2 <= 1'b0;
	    a3 <= 1'b0;
	    
	 end else begin
	    a1 <= stb_in;
	    a2 <= a1;
	    //a3 <= a2;
	    stb_o <= a2;
	    
	    //stb_o <= (~a3) & a2;	    
      end        
   end // always @ (posedge clk_s or posedge reset_s)

   
/*  always @* begin
      if(ack_o) begin
	 if(stb_o) begin
	    stb_o <= 1'b0;	    
	 end	 
      end      
   end   */
endmodule // twoFF

