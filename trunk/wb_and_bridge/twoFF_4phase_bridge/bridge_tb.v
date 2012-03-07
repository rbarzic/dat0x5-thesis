`include "timescale.v"
module bridge_tb();
`include "def.v"

   reg 		      clk_m, clk_s, rst_m, rst_s, vi_m, vi_s;
   reg [DATA_MSB:0]   sdata_m, sdata_s;
   
   wire [DATA_MSB:0]  rdata_m, rdata_s;
   wire 	      snt_m, snt_s, vo_m, vo_s;
   
   
   bridge_top bridge_top_U0(/*AUTOINST*/
			    // Outputs
			    .rdata_m		(rdata_m[DATA_MSB:0]),
			    .rdata_s		(rdata_s[DATA_MSB:0]),
			    .snt_m		(snt_m),
			    .vo_m		(vo_m),
			    .snt_s		(snt_s),
			    .vo_s		(vo_s),
			    // Inputs
			    .sdata_m		(sdata_m[DATA_MSB:0]),
			    .sdata_s		(sdata_s[DATA_MSB:0]),
			    .vi_m		(vi_m),
			    .vi_s		(vi_s),
			    .clk_m		(clk_m),
			    .clk_s		(clk_s),
			    .rst_m		(rst_m),
			    .rst_s		(rst_s));
   initial        
     clk_m = 1'b0;
   always
     #1 clk_m = ~clk_m; //m-clk
   
   initial        
     clk_s = 1'b0;
   always
     #1 clk_s = ~clk_s; //s-clk

   initial begin
      $dumpvars;
      vi_m = 1'b0;
      vi_s = 1'b0;
      rst_m = 1'b1;
      rst_s = 1'b1;

      #2 rst_m = 1'b0;
         rst_s = 1'b0;
      #1 sdata_m = 1'b1;
         sdata_s = 1'b1;
      #1 vi_m = 1'b1;
         vi_s = 1'b1;
      #2 vi_m = 1'b0;
         vi_s = 1'b0;
            #250 $finish;
      end

      
endmodule // bridge_tb
