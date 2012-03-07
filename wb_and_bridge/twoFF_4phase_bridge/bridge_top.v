module bridge_top(/*AUTOARG*/
   // Outputs
   rdata_m, rdata_s, snt_m, vo_m, snt_s, vo_s,
   // Inputs
   sdata_m, sdata_s, vi_m, vi_s, clk_m, clk_s, rst_m, rst_s
   );
`include "def.v"
   output [DATA_MSB:0] rdata_m, rdata_s;
   output 	       snt_m, vo_m, snt_s, vo_s;
   input [DATA_MSB:0]  sdata_m, sdata_s;
   input 	       vi_m, vi_s;
   input 	       clk_m, clk_s;
   input 	       rst_m, rst_s;
   
   
 
   // Beginning of automatic regs (for this module's undeclared outputs)
   wire [DATA_MSB:0]	rdata_m;
   wire [DATA_MSB:0]	rdata_s;
   wire			snt_m;
   wire			snt_s;
   wire			vo_m;
   wire			vo_s;
   // End of automatics

   /* Intermediate signals*/
   wire [DATA_MSB:0] 	data1, data2;
   wire 		snt1, req1;
   wire 		snt2, req2;
   

   /*Instanstiate to complete the bridge which has 2 tx and 2 rx*/
   tx tx_wbmaster(
		  // Outputs
		  .data			(data1[DATA_MSB:0]),
		  .snt			(snt_m),
		  .req			(req1),
		  // Inputs
		  .sdata		(sdata_m[DATA_MSB:0]),
		  .vi			(vi_m),
		  .ack			(ack1),
		  .clk			(clk_m),
		  .reset		(rst_m));
   
   rx rx_wbmaster(
		  // Outputs
		  .rdata		(rdata_m[DATA_MSB:0]),
		  .ack			(ack1),
		  .vo			(vo_s),
		  // Inputs
		  .data			(data1[DATA_MSB:0]),
		  .req			(req1),
		  .clk			(clk_s),
		  .reset		(rst_m));
   
   tx tx_wbslave(
		 // Outputs
		 .data			(data2[DATA_MSB:0]),
		 .snt			(snt_s),
		 .req			(req2),
		 // Inputs
		 .sdata			(sdata_s[DATA_MSB:0]),
		 .vi			(vi_s),
		 .ack			(ack2),
		 .clk			(clk_s),
		 .reset			(rst_s));
   
   rx rx_wbslave(
		 // Outputs
		 .rdata			(rdata_s[DATA_MSB:0]),
		 .ack			(ack2),
		 .vo			(vo_m),
		 // Inputs
		 .data			(data2[DATA_MSB:0]),
		 .req			(req2),
		 .clk			(clk_s),
		 .reset			(rst_s));
   
   
endmodule // bridge_top

   
