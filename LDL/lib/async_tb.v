`include "timescale.v"
module async_tb();
`include "def.v"

   reg latched, req, reset;
   wire ack, ask;

   async aync_u0(/*AUTOINST*/
		 // Outputs
		 .ack			(ack),
		 .ask			(ask),

		 // Inputs
		 .latched		(latched),
		 .reset			(reset),
		 .req			(req));

      initial
     begin
	$dumpvars;
	reset = 1'b1;
	req = 1'b0;
 	latched = 1'b0;

	#1 reset = 1'b0;
	
	#1 req = 1'b1;
	#2 latched = 1'b1;
 	#2 latched = 1'b0;
	
	#100 $finish;
     end
endmodule // async_tb
