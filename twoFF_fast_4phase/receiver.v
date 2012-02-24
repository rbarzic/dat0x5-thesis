module receiver(/*AUTOARG*/
   // Outputs
   rdata, vo, ack,
   // Inputs
   req, clk_rx, reset, data
   );
`include "def.v"

   output vo, ack;
   output [DATA_MSB:0] rdata;   
   input  req, clk_rx, reset;
   input [DATA_MSB:0] data;

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg			ack;
   reg			rdata;
   reg			vo;
   // End of automatics

   wire 	      r2, r2d, f3in, r2dnot, arnot;
   wire [DATA_MSB:0]  rdata1;
   wire               vo1, ack1; 
   //wire               r3, r4;

   /*instantiate the intermediate the fsm, wires and modules to form complete receiver*/
   regdataen regr(.q(rdata1), .a(data), .en(r2), .clk(clk_rx), .reset(reset));
		  
   dffs f1(.q(r2), .d(req), .clk(clk_rx), .reset(reset));

   //dffs fxx(.q(r3), .d(req), .clk(clk_rx), .reset(reset));

   //dffs fyy(.q(r4), .d(req), .clk(clk_rx), .reset(reset));

   //dffs fzz(.q(r5), .d(req), .clk(clk_rx), .reset(reset));

   dffs f2(.q(r2d), .d(r2), .clk(clk_rx), .reset(~r2));

        //dffs f2(.q(r2d), .d(r4), .clk(clk_rx), .reset(reset));

   inv inv1(.idash(r2dnot), .i(r2d));
   
   and2 and1(.q(f3in), .a(r2), .b(r2dnot));

   dffs f3(.q(vo1), .d(f3in), .clk(clk_rx), .reset(reset));

   inv inv2(.idash(arnot), .i(r2));
   
   dffs f4(.q(ack1), .d(r2), .clk(clk_rx), .reset(arnot));  	
        
   always @* begin
        rdata = rdata1;
        ack = ack1;
        vo = vo1;
   end	  

 endmodule // receiver

		  
		  
		  
		  
		  
		  
		  

		  
