`include "timescale.v"
module inputport(/*AUTOARG*/
   // Outputs
   valid, ack_ip, y1,
   // Inputs
   clk_inputport, reset, req
   );
`include "def.v"

   output valid, ack_ip, y1;
   input  clk_inputport, reset, req ;
   event assigning;
   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   wire   y1;
   reg ack_ip;
   // End of automatics
   wire   ask, ask_dash, latched1, valid1, ack_l;
   reg latched;


   async async_u0(/*AUTOINST*/
		  // Outputs
		  .ack			(ack_l),
		  .ask			(ask),
		  // Inputs
		  .latched		(latched1),
		  .req			(req),
		  .reset		(reset));

   cmuller cmuller_U1(/*AUTOINST*/
		      // Outputs
		      .c		(ask_dash),
		      // Inputs
		      .a		(ask),
		      .b		(~valid),
		      .rstn		(reset));
   
   mutex mutex_U2(/*AUTOINST*/
		  // Outputs
		  .g1			(latched1),
		  .g2			(y1),
		  // Inputs
		  .r1			(ask_dash),
		  .r2			(clk_inputport),
                  .reset                (reset));
   
   srlatch srlatch_U3(/*AUTOINST*/
		      // Outputs
		      .q		(valid1),
		      // Inputs
		      .s		(latched1),
		      .r		(y1|reset));
assign valid = valid1;

endmodule // inputport
