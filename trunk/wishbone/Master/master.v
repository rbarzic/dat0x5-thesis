`include "timescale.v"
module master( /*AUTOARG*/
   // Outputs
   adr_o, sel_o, dat_o, tga_o, tgd_o, tgc_o, we_o, stb_o, cyc_o,
   // Inputs
   dat_i, tgd_i, rst_i, clk_i, ack_i, func_i, rty_i, err_i
   );
`include "def.v"
   
   output [ADR_MSB:0]  adr_o;
   output [SEL_MSB:0]  sel_o;
   output [DATA_MSB:0] dat_o; 
   output [TAG_MSB:0] 	tga_o, tgd_o, tgc_o; /* TGA_O() --> ADR_O(), TGD_O() --> DAT_O(), TGC_O() --> Buss cycle */
   output 	        we_o, stb_o, cyc_o;
   
   input [DATA_MSB:0] 	dat_i;
   input [TAG_MSB:0] 	tgd_i; /*TGD_I() --> DAT_I()*/
   input 		rst_i, clk_i;
   input 		ack_i;
   input [1:0] 		func_i;
   input 		rty_i, err_i;
   
   /*Below I/Os are used for test bench and interfacing to the cores*/
   //  output [DATA_MSB:0]  data_o;
   //  input [DATA_MSB:0]   data_i;
   //  input [ADR_MSB:0]   addr_i;
   
   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [ADR_MSB:0]	adr_o;
   reg			cyc_o;
   reg [DATA_MSB:0]	dat_o;
   reg [SEL_MSB:0]	sel_o;
   reg			stb_o;
   reg [TAG_MSB:0]	tga_o;
   reg [TAG_MSB:0]	tgc_o;
   reg [TAG_MSB:0]	tgd_o;
   reg			we_o;
   // End of automatics
   
   reg [DATA_MSB:0] 	data_rx;
   reg 			ready;
   reg [TAG_MSB:0] 	tagd_rx;
    
   always @(posedge clk_i or posedge rst_i) begin
      if(rst_i) begin
	 adr_o <= {(1+(ADR_MSB)){1'b0}};
	 sel_o <= {(1+(SEL_MSB)){1'b0}};
	 dat_o <= {(1+(DATA_MSB)){1'b0}};
	// tga_o <= {(1+(TAG_MSB)){1'b0}};
	// tgd_o <= {(1+(TAG_MSB)){1'b0}};
	// tgc_o <= {(1+(TAG_MSB)){1'b0}};
	 we_o <= 1'b0;
	 stb_o <= 1'b0;
	 cyc_o <= 1'b0;
	 data_rx <= {(1+(DATA_MSB)){1'b0}};
	 ready <= 1'b0;
	 //tagd_rx <= {(1+(TAG_MSB)){1'b0}}; 		    
      end      
   end
   
   /*Classic Standard Single Write*/  
   task swrite;
      input [ADR_MSB:0] addr_i;
      input [DATA_MSB:0] dat_o;      
      begin
	 
	 @(posedge clk_i);	 
	 adr_o <= ADDRESS;
	 //tga_o <= 4'b1010;
	 dat_o <= DATA;
	 //tgd_o <= 4'b0111;
	 we_o <= 1'b1;
	 sel_o <= 3'b111;
	 cyc_o <= 1'b1;
	 //tgc_o <= 1'b1;
	 stb_o <= 1'b1;
	 
        /* Delay the cycles untill the ack_i is enabled*/	 
         while(ack_i==1'b0) begin
	    @(posedge clk_i);
	 end
	 
	 @(posedge clk_i);
         cyc_o <= 1'b0;
	 stb_o <= 1'b0;	 
      end 
   endtask // wait
   

   /*Classic Standard Single Read*/   
   task sread;
      input [ADR_MSB:0] addr_i;
      output [DATA_MSB:0] dat_o;      
      begin
	 
	 @(posedge clk_i);	 
	 adr_o <= ADDRESS;
	 sel_o <= 3'b111;
	// tga_o <= 4'b1010;
	// tgc_o <= 4'b1011;
	 we_o <= 1'b0;
	 stb_o <= 1'b1;
	 cyc_o <= 1'b1;
	 
	 @(posedge clk_i);
	 cyc_o <= 1'b1;
	 stb_o <= 1'b1;
	 
         /* Delay the cycles untill the ack_i is enabled*/	 
         while(ack_i==1'b0) begin
	    @(posedge clk_i);
	 end	 

	 @(posedge clk_i);	 
         // dat_o <= dat_i; //Latch the data and place on the local variable dat_o
         data_rx <= DATA; //for test purpose only
	 // tagd_rx <= tgd_i;
 	 stb_o <= 1'b0;	
	 cyc_o <= 1'b0;	 
      end
   endtask // wait
   
   
   
   task blkwrite;
      input [ADR_MSB:0] addr_i;
      input [DATA_MSB:0] dat_o;      
      begin

	 @(posedge clk_i);	 
	 adr_o <= ADDRESS;
	// tga_o <= 4'b1010;
	 dat_o <= DATA;
	// tgd_o <= 4'b0111;
	 we_o <= 1'b1;
	 sel_o <= 3'b111;
	 cyc_o <= 1'b1;
	// tgc_o <= 1'b1;
	 stb_o <= 1'b1;
	 
        /* Delay the cycles untill the ack_i is enabled*/	 
         while(ack_i==1'b0) begin
	    @(posedge clk_i);
	 end
	 
	 @(posedge clk_i);
         cyc_o <= 1'b0;
	 stb_o <= 1'b0;	 
      end 
   endtask // wait


      /*Classic Standard Single Read*/   
   task blkread;
      input [ADR_MSB:0] addr_i;
      output [DATA_MSB:0] dat_o;      
      begin
	 
	 @(posedge clk_i);	 
	 adr_o <= ADDRESS;
	 sel_o <= 3'b111;
	// tga_o <= 4'b1010;
	// tgc_o <= 4'b1011;
	 we_o <= 1'b0;
	 stb_o <= 1'b1;
	 cyc_o <= 1'b1;
	 
	 @(posedge clk_i);
	 cyc_o <= 1'b1;
	 stb_o <= 1'b1;

        /* Delay the cycles untill the ack_i is enabled*/	 
         while(ack_i==1'b0) begin
	    @(posedge clk_i);
	 end
	 
	 @(posedge clk_i);	 
	 if(ack_i) begin
            dat_o <= dat_i; //Latch the data and place on the local variable dat_o
            //data_rx <= DATA; //for test purpose only
	   // tagd_rx <= tgd_i;
         end	 
	 stb_o <= 1'b0;	 
      end
   endtask // wait

   
   always @* begin
      case(func_i)
        2'b00: sread(ADDRESS, data_rx);
        2'b01: swrite(ADDRESS, DATA);
        //10: blkread();
        //11: blkwrite();        
      endcase
   end   
   
   
endmodule // wbmaster
