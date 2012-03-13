`include "timescale.v"
module mutex_tb();
`include "def.v"

   wire g1, g2;
   reg 	r1, r2;
   
   mutex mut1(/*AUTOINST*/
	      // Outputs
	      .g1			(g1),
	      .g2			(g2),
	      // Inputs
	      .r1			(r1),
	      .r2			(r2));
   
   
   initial
     begin
	$dumpvars;
	#1 r1 = 1'b0;
 	r2 = 1'b0;

	#1 r1 = 1'b1;
	r2 = 1'b1;

	#1 r1 = 1'b1;
	r2 = 1'b0;

	#1 r1 = 1'b0;
	r2 = 1'b1;
	  #100 $finish;
     end
   
 
endmodule // mutex_tb

     
