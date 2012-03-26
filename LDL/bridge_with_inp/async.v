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
   reg			ack;
   reg			ask;
   // End of automatics
   wire ack_l, ask_l;
   wire 		c;

    always @* begin
        if(reset) begin        
                ack = 1'b0;
                ask = 1'b0;
        end else begin
                ack = ack_l;
                ask = ask_l;        
        end
    end

   /*Instantiate C-Muller*/
   cmuller cmuller_U0(/*AUTOINST*/
		      // Outputs
		      .c		(c),
		      // Inputs
		      .a		(latched),
		      .b		(req),
		      .rstn		(reset));

   and and_async1(ack_l, ~latched, c);
   and and_async2(ask_l, ~c, req);
   
   
endmodule // async
