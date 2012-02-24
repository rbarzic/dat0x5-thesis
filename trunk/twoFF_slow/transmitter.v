module transmitterslow(/*AUTOARG*/
   // Outputs
   snt, req, data,
   // Inputs
   vi, ack, sdata, clk, reset
   );
`include "def.v"

   output snt, req;
   output [DATA_MSB:0] data;
   input 	       vi, ack, clk, reset;
   input [DATA_MSB:0]  sdata;

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [DATA_MSB:0]	data;
   reg			req;
   reg			snt;
   // End of automatics
   wire [DATA_MSB:0]   data1;
   wire 	       snt1;
   wire 	       req1;
   wire 	       txe;
   wire 	       a2;      
   wire 	       a1;
   
   /*Instantiate the individual blocks to form complete transmitter */

   regdataen regt (.q(data1), .a(sdata), .en(txe), .reset(reset), .clk(clk));
   txfsmslow txfsm(.txe(txe), .req(req1), .vi(vi), .a2(a2), .clk(clk), .reset(reset));
   dffs f1(.q(a1), .d(ack), .clk(clk), .reset(reset));
   dffs f2(.q(a2), .d(a1), .clk(clk), .reset(reset));
   dffs f3(.q(a3), .d(a2), .clk(clk), .reset(reset));
   and2 and1(.q(snt1), .a(~a3), .b(a2));   
   
   always @* begin
      data = data1;
      snt = snt1;
      req = req1;
   end
endmodule // transmitter

       
