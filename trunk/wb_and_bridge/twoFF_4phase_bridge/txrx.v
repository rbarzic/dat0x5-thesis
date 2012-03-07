`include "timescale.v"
module tx(/*AUTOARG*/
   // Outputs
   data, snt, req,
   // Inputs
   sdata, vi, ack, clk, reset
   );
`include "def.v"

   /* Wishbone interfaces*/
   /* Inputs to the Synchronizer from wishbone master*/
   input [DATA_MSB:0]	      sdata;
   
   /* Output from the Syncronizer tx to syncronizer rx*/ 
   output [DATA_MSB:0]	      data;
    
   /*Synchronizer interfaces*/
   output 	       snt, req;
   input 	       vi, ack, clk, reset;

   
   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [DATA_MSB:0]	data;
   wire			req;
   // End of automatics
   
   reg 		       a2, a1, a2d;
   wire 	       vi, txe;
   
   txfsmslow txfsm(.txe(txe), .req(req), .vi(vi), .a2(a2), .clk(clk), .reset(reset));
   
   always @(posedge clk or posedge reset) begin
      if(reset) begin
   	 data <=  {(1+(DATA_MSB)){1'b0}};	 
	 
	 a1 <= 1'b0;
	 a2 <= 1'b0;
	 a2d <= 1'b0;
      end else begin
	 if(txe) begin
   	    data <= sdata;	 
	 end
	 a1 <= ack;
	 a2 <= a1;
	 a2d <= a2;	
      end     
   end // always @ (posedge clk or posedge reset)
   
   assign snt = a2 & (~a2d);  
   
endmodule // tx

module rx(/*AUTOARG*/
   // Outputs
   rdata, ack, vo,
   // Inputs
   data, req, clk, reset
   );
`include "def.v"

   /*Wishbone interfaces*/   
   /* Inputs to the Synchronizer from wishbone master*/
   input [DATA_MSB:0]   data;
      
   /* Output from the Syncronizer tx to syncronizer rx*/ 
   output [DATA_MSB:0]  rdata;

   /*Syncronizer interfaces*/
   output ack, vo; 
   input  req, clk, reset;   

   
   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg			ack;
   reg [DATA_MSB:0]	rdata;
   reg			vo;
   // End of automatics
   //wire [DATA_MSB:0]	rdata;
   reg 		       r1, r2, r2d;
   
   always @(posedge clk or posedge reset) begin
      if(reset) begin
   	 rdata <= {(1+(DATA_MSB)){1'b0}};
	 
	 r1 <= 1'b0;
	 r2 <= 1'b0;
	 r2d <= 1'b0;
	 ack <= 1'b0;
	 vo <= 1'b0;	 
      end else begin
	 if(rxe) begin
   	    rdata <= data;	
	 end
	 r1 <= req;
	 r2 <= r1;
	 r2d <= r2;	
	 ack <= r2;
	 vo <= rxe;	 
      end
   end // rx
   
   assign rxe = r2 & (~r2d);     
endmodule // rx

