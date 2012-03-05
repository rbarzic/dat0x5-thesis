`include "timescale.v"
module txrxsync(/*AUTOARG*/
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
   wire [DATA_MSB:0]   rdata;
   // End of automatics
   
   wire [DATA_MSB:0]   data;
   wire 	       req, ack;   
   
   /*Instantiation of tx and rx modules*/
   tx tx_U0(/*AUTOINST*/
	    // Outputs
	    .snt			(snt),
	    .req			(req),
	    .data			(data[DATA_MSB:0]),
	    // Inputs
	    .vi				(vi),
	    .ack			(ack),
	    .clk			(clk_tx),
	    .reset			(reset),
	    .sdata			(sdata[DATA_MSB:0]));
   rx rx_U1(/*AUTOINST*/
	    // Outputs
	    .ack			(ack),
	    .vo				(vo),
	    .rdata			(rdata[DATA_MSB:0]),
	    // Inputs
	    .req			(req),
	    .clk			(clk_rx),
	    .reset			(reset),
	    .data			(data[DATA_MSB:0]));   
   
endmodule // txrxsync
