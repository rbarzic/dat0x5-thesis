`include "timescale.v"
module sync_tb();
`include "def.v"
   
   wire [DATA_MSB:0]  outs;
   wire 	      vo;
   reg [DATA_MSB:0]   data_core;
   reg 		      clk1, clk2, reset, vi;
   
   
   txrxsync txrxsync_U0(.snt(snt), .vo(vo), .rdata(outs), .vi(vi), .clk_tx(clk1), .clk_rx(clk2), .reset(reset), .sdata(data_core));
   
   
   initial        
     clk1 = 1'b0;
   always
     #1 clk1 = ~clk1; //tx-clk
   
   initial        
     clk2 = 1'b0;
   always
     #1 clk2 = ~clk2; //rx-clk
   
   initial
     begin
	$dumpvars;
        #1 vi = 1'b0;
	#1 reset = 1'b1;
        #3 reset = 1'b0;
        repeat(1) begin
           
	   #1 data_core = 8'b1111_1111; 	        	
           #1 vi = 1'b1;
           #2 vi = 1'b0;
	   
        end
	
        #250 $finish;
     end
   
endmodule // sync_tb
