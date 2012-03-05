module master_tb();
`include "def.v"

   
   wire [ADR_MSB:0]  adr_o;
   wire [SEL_MSB:0]  sel_o;
   wire [DATA_MSB:0] dat_o; 
   wire [TAG_MSB:0]  tga_o, tgd_o, tgc_o; /* TGA_O() --> ADR_O(), TGD_O() --> DAT_O(), TGC_O() --> Buss cycle */
   wire 	     we_o, stb_o, cyc_o;
   
   reg [DATA_MSB:0]  dat_i;
   reg [TAG_MSB:0]   tgd_i; /*TGD_I() --> DAT_I()*/
   reg 		     rst_i, clk_i;
   reg 		     ack_i;
   reg [1:0] 	     func_i;

   master UB_1(/*AUTOINST*/
	       // Outputs
	       .adr_o			(adr_o[ADR_MSB:0]),
	       .sel_o			(sel_o[SEL_MSB:0]),
	       .dat_o			(dat_o[DATA_MSB:0]),
	       .tga_o			(tga_o[TAG_MSB:0]),
	       .tgd_o			(tgd_o[TAG_MSB:0]),
	       .tgc_o			(tgc_o[TAG_MSB:0]),
	       .we_o			(we_o),
	       .stb_o			(stb_o),
	       .cyc_o			(cyc_o),
	       // Inputs
	       .dat_i			(dat_i[DATA_MSB:0]),
	       .tgd_i			(tgd_i[TAG_MSB:0]),
	       .rst_i			(rst_i),
	       .clk_i			(clk_i),
	       .ack_i			(ack_i),
	       .func_i			(func_i[1:0]));
   
   initial        
      clk_i = 1'b0;
   always
     #1 clk_i = ~clk_i; //tx-clk

   initial
     begin
	rst_i = 1'b1;
        ack_i = 1'b0;
	func_i = 2'b00;
	
	$dumpvars;
        #1 rst_i = 1'b0;	
        repeat(1) begin
	   #50 ack_i = 1'b1;

     	   //#1 func_i = 2'b00;	   
 	  
        end
	
        #250 $finish;
     end
   
endmodule // master_tb
