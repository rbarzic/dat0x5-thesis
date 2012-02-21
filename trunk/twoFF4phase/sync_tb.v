module sync_tb();
`include "def.v"

   wire [DATA_MSB:0]  outs;
   wire f, d;
   reg [DATA_MSB:0] data_core;
   reg 		    clk1, clk2, reset, v;
 
   sync_multi syncss1(.out_data(outs), .f(f), .d(d), .in_data(data_core), .v(v), .clk_tx(clk1), .clk_rx(clk2), .reset(reset));
   
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
	#1 reset = 1'b1;
	#1 data_core = DATA;
	#1 reset = 1'b0;	
        #2 v = 1'b1;
        #5 v = 1'b0;
        
        #250 $finish;
     end
   
endmodule // sync_tb
