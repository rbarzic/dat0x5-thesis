module sync_tb();
`include "def.v"

parameter  DATA_WIDTH = `DATA_WIDTHS,
           DATA_MSB = DATA_WIDTH-1,
           DATA = `DATAS;

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
     #2 clk2 = ~clk2; //rx-clk

   initial
     begin
     $dumpvars;
	#1 reset = 1'b1;
	#1 data_core = DATA;
	#1 reset = 1'b0;
	
        #2 v = 1'b1;
        #10 v = 1'b0;
        #5 data_core = 8'b0011_0101;
        #1 v = 1'b1;
        #10 v = 1'b0;
        #20 data_core = 8'b1111_1111;
        #21 v = 1'b1;
        #25 v = 1'b0;
        #5 reset = 1'b1;

        #250 $finish;
     end
   
endmodule // sync_tb
