module syncslow(/*AUTOARG*/
   // Outputs
   vo, snt, rdata,
   // Inputs
   vi, clk_tx, clk_rx, reset, sdata
   );
`include "def.v"

   output vo, snt;
   output [DATA_MSB:0] rdata;
   input 	       vi, clk_tx, clk_rx, reset;
   input [DATA_MSB:0]  sdata;
   
   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [DATA_MSB:0]	rdata;
   reg			snt;
   reg			vo;
   // End of automatics
   wire [DATA_MSB:0] 	rdata1,data1;   
   wire 		req1, ack1, vo1, snt1;
   
   receiverslow rx(.ack(ack1), .vo(vo1), .rdata(rdata1), .req(req1), .reset(reset), .clk(clk_rx), .data(sdata));
   transmitterslow tx(.snt(snt1), .req(req1), .data(data1), .vi(vi), .ack(ack1), .sdata(sdata), .clk(clk_tx), .reset(reset));
   
   always @* begin
         snt = snt1;
         vo = vo1;
         rdata = rdata1;
   end
endmodule // syncslow

     
