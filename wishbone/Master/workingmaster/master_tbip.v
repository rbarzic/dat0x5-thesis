module master_tbip();
`include "def.v"
   
   wire [ADR_MSB:0]  adr_int;
   wire [SEL_MSB:0]  sel_int;
   wire [DATA_MSB:0] dato_int; 
   // wire [TAG_MSB:0]  tga_o, tgd_o, tgc_o; /* TGA_O() --> ADR_O(), TGD_O() --> DAT_O(), TGC_O() --> Buss cycle */
   wire 	     we_int, stb_int, cyc_int;
   
   wire [DATA_MSB:0] dati_int;
   //reg [TAG_MSB:0]   tgd_i; /*TGD_I() --> DAT_I()*/
   reg 		     rst_int, clk_int;
   wire 	     ack_int, err_int, rty_int;
   reg [1:0] 	     func_i;
   
   wshb_s_if U_slave(/*AUTOINST*/
		     // Interfaced
		     .dat_i		(dati_int),
		     .dat_o		(dato_int),
		     .adr_i		(adr_int),
		     .cyc_i		(cyc_int),
		     .sel_i		(sel_int),
		     .stb_i		(stb_int),
		     .we_i		(we_int),
		     .ack_o		(ack_int),
		     .err_o		(err_int),
		     .rty_o		(rty_int),
		     // Inputs
		     .clk		(clk_int));
endmodule // master_tbip
