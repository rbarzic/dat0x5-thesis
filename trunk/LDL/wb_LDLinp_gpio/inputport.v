`include "timescale.v"
module inputport(/*AUTOARG*/
   // Outputs
   valid, ack, y1,
   // Inputs
   clk_inputport, reset, req
   );
`include "def.v"

   output valid, ack, y1;
   input  clk_inputport, reset, req;

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   wire   y1;
   // End of automatics
   wire   ask, ask_dash, latched1, valid;
   reg latched;

   always @* begin
        if (reset) begin
            latched = 1'b0;
        end else begin
            latched = latched1;
        end
   end        
   async async_u0(/*AUTOINST*/
		  // Outputs
		  .ack			(ack),
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
		      .q		(valid),
		      // Inputs
		      .s		(latched1),
		      .r		(y1|reset));
   
endmodule // inputport
