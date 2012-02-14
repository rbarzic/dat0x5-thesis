module sync_tb();
`include "def.v"

parameter  DATA_WIDTH = `DATA_WIDTHS,
           DATA_MSB = DATA_WIDTH-1,
           DATA = `DATAS;

   wire [DATA_MSB:0]  outs;
   wire f, d;
   reg [DATA_MSB:0] data_core;
   reg 		    clk, reset, v;
 
   sync_multi syncss1(.out_data(outs), .f(f), .d(d), .in_data(data_core), .v(v), .clk(clk), .reset(reset));
   
   initial        
     clk = 1'b0;
   always
     #1 clk = ~clk;

   initial
     begin
     $dumpvars;
	#1 reset = 1'b1;
	#1 data_core = DATA;
	#1 reset = 1'b0;
	
        #2 v = 1'b1;
        #10 v = 1'b0;
        #1 data_core = 8'b0011_0101;
        #1 v = 1'b1;
        #10 v = 1'b0;
        #100 $finish;
     end
   
endmodule // sync_tb
