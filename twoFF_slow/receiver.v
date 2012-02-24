module receiverslow(/*AUTOARG*/
   // Outputs
   ack, vo, rdata,
   // Inputs
   req, clk, reset, data
   );
`include "def.v"
   
   output ack, vo;
   output [DATA_MSB:0] rdata;
   input 	       req, clk, reset;   
   input [DATA_MSB:0]  data;
   
   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg			ack;
   reg [DATA_MSB:0]	rdata;
   reg			vo;
   // End of automatics
   wire [DATA_MSB:0]   rdata1;
   wire 	       ack1;
   wire 	       vo1;
   wire 	       r1, r2, r3, r4;
   
   /*Instantiate the blocks to form complete receiver*/
   regdataen regr(.q(rdata1), .a(data), .en(r4), .reset(reset), .clk(clk));
   dffs f4(.q(r1), .d(req), .clk(clk), .reset(reset));
   dffs f5(.q(r2), .d(r1), .clk(clk), .reset(reset));
   dffs f6(.q(r3), .d(r2), .clk(clk), .reset(reset));
   dffs f7(.q(ack1), .d(r2), .clk(clk), .reset(reset));   
   dffs f8(.q(vo1), .d(r4), .clk(clk), .reset(reset));   
   and2 and3(.q(r4), .a(r2), .b(~r3));  
   
   always @* begin
         rdata = rdata1;
         ack = ack1;
         vo = vo1;
      end	 
endmodule // receiverslow
