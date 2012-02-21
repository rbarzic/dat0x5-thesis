/* This module consist of complete fast 4 phase synchronizer*/
module sync(/*AUTOARG*/
   // Outputs
   snt, vo, rdata,
   // Inputs
   vi, clk_tx, clk_rx, reset, indata
   );
`include "def.v"

   output snt, vo;
   output [DATA_MSB:0] rdata;
   input 	       vi, clk_tx, clk_rx, reset;
   input [DATA_MSB:0]  indata;

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [DATA_MSB:0]	rdata;
   reg			snt;
   reg			vo;
   // End of automatics

   wire [DATA_MSB:0] 	data;
   wire 		req, ack;
   wire                 snt1;
   wire [DATA_MSB:0] 	rdata1;
   wire                 vo1;
   /*Instantiate the transmitter*/

   transmitter tx(.data(data), .req(req), .snt(snt1), .vi(vi), .ack(ack), .clk_tx(clk_tx), .reset(reset), .sdata(indata));
   receiver rx(.rdata(rdata1), .vo(vo1), .ack(ack), .req(req), .clk_rx(clk_rx), .reset(reset), .data(data)); 
		       
   always @* begin
        snt = snt1;
        vo = vo1;
        rdata = rdata1;
   end
endmodule // sync

   
