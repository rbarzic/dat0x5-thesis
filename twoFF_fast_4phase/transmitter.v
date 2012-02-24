module transmitter(/*AUTOARG*/
   // Outputs
   data, req, snt,
   // Inputs
   vi, ack, clk_tx, reset, sdata
   );
`include "def.v"
   
   output [DATA_MSB:0] data;
   output 	       req, snt;
   input 	       vi, ack, clk_tx, reset;
   input [DATA_MSB:0]  sdata;
   wire 	       en2, a2, a2d, a2p, f7in, en, nota2d, a2not;   
   wire  snt1, req1;   
   wire  [DATA_MSB:0]	data1;
   wire               a3, a4;
   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [DATA_MSB:0]	data;
   reg			req;
   reg			snt;
   // End of automatics

   /*instaniate the intermediate the fsm, wires and modules to form complete transmitter*/
   txfsm tfsm(.snt(snt1), .en(en), .vi(vi), .clk(clk_tx), .reset(reset), .a2p(a2p), .a2d(a2d));

   inv inv1(.idash(a2not), .i(a2)); 
   
   regdataenstar regd(.q(data1), .a(sdata), .en(en2), .reset(reset), .enstar(a2not), .clk(clk_tx));

   or2 ora(.q(en2), .a(en), .b(a2p));  
   
   regenstar regv(.q(req1), .a(vi), .en(en2), .enstar(a2not), .reset(a2), .clk(clk_tx));

  // dffs fyy(.q(a4), .d(ack), .clk(clk_tx), .reset(reset)); 

   dffs f5(.q(a2), .d(ack), .clk(clk_tx), .reset(reset));

   //dffs fxx(.q(a3), .d(ack), .clk(clk_tx), .reset(reset));

   dffs f6(.q(a2d), .d(a2), .clk(clk_tx), .reset(reset));

   inv not1(.idash(nota2d), .i(a2d));

   and2 and1(.q(f7in), .a(nota2d), .b(a2));
   
   dffs f7(.q(a2p), .d(f7in), .clk(clk_tx), .reset(reset));   
   
   always @* begin
        data = data1;
        snt = snt1;
        req = req1;
   end
endmodule // transmitter


   
