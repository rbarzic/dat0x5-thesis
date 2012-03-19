`include "timescale.v"
module async(/*AUTOARG*/
   // Outputs
   ack, ask,
   // Inputs
   latched, req, reset
   );
`include "def.v"

   output ack, ask;
   input  latched, req, reset;

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   wire			ack;
   wire			ask;
   // End of automatics

   wire 		c;

   /*Instantiate C-Muller*/
   cmuller cmuller_U0(/*AUTOINST*/
		      // Outputs
		      .c		(c),
		      // Inputs
		      .a		(latched),
		      .b		(req),
		      .rstn		(reset));

   and and_async1(ack, ~latched, c);
   and and_async2(ask, ~c, req);
   
   
endmodule // async
