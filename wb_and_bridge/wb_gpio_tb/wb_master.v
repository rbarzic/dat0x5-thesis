`include "timescale.v"
module wb_master( /*AUTOARG*/
   // Outputs
   ADR_O, SEL_O, DAT_O, TAG_O, WE_O, STB_O, CYC_O,
   // Inputs
   DAT_I, TAG_I, RST_I, CLK_I, ACK_I, RTY_I, ERR_I
   );
`include "def.v"
   
   output [ADR_MSB:0]  ADR_O;
   output [SEL_MSB:0]  SEL_O;
   output [DATA_MSB:0] DAT_O; 
   output [TAG_MSB:0]  TAG_O; /* TGA_O() --> ADR_O(), TGD_O() --> DAT_O(), TGC_O() --> Buss cycle */
   output 	        WE_O, STB_O, CYC_O;
   
   input [DATA_MSB:0] 	DAT_I;
   input [TAG_MSB:0] 	TAG_I; /*TGD_I() --> DAT_I()*/
   input 		RST_I, CLK_I;
   input 		ACK_I;
   //input [1:0] 		func_i;
   input 		RTY_I, ERR_I;
   
   /*Below I/Os are used for test bench and interfacing to the cores*/
   //  output [DATA_MSB:0]  data_o;
   //  input [DATA_MSB:0]   data_i;
   //  input [ADR_MSB:0]   addr_i;
   
   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [ADR_MSB:0]	ADR_O;
   reg			CYC_O;
   reg [DATA_MSB:0]	DAT_O;
   reg [SEL_MSB:0]	SEL_O;
   reg			STB_O;
   reg [TAG_MSB:0]	TAG_O;
   reg			WE_O;
   // End of automatics
   
   reg [DATA_MSB:0] 	data_rx;
   reg 			ready;
   reg [TAG_MSB:0] 	tagd_rx;
   
   always @(posedge CLK_I or posedge RST_I) begin
      if(RST_I) begin
	 ADR_O <= {(1+(ADR_MSB)){1'b0}};
	 SEL_O <= {(1+(SEL_MSB)){1'b0}};
	 DAT_O <= {(1+(DATA_MSB)){1'b0}};
	 // tga_o <= {(1+(TAG_MSB)){1'b0}};
	 // tgd_o <= {(1+(TAG_MSB)){1'b0}};
	 // tgc_o <= {(1+(TAG_MSB)){1'b0}};
	 WE_O <= 1'b0;
	 STB_O <= 1'b0;
	 CYC_O <= 1'b0;
	 data_rx <= {(1+(DATA_MSB)){1'b0}};
	 ready <= 1'b0;
	 //tagd_rx <= {(1+(TAG_MSB)){1'b0}}; 		    
      end      
   end
   
   /*Classic Standard Single Write*/  
   task wr;
      input [ADR_MSB:0] addr_i;
      input [DATA_MSB:0] DAT_O;
      input [3:0] sel;      
      begin
	 
	 @(posedge CLK_I);	 
	 ADR_O <= addr_i;
	 //tga_o <= 4'b1010;
	 DAT_O <= DATA;
	 //tgd_o <= 4'b0111;
	 WE_O <= 1'b1;
	 SEL_O <= sel;
	 CYC_O <= 1'b1;
	 //tgc_o <= 1'b1;
	 STB_O <= 1'b1;
	 
         /* Delay the cycles untill the ACK_I is enabled*/	 
         while(ACK_I==1'b0) begin
	    @(posedge CLK_I);
	 end
	 
	 //@(posedge CLK_I);
         CYC_O <= 1'b0;
	 STB_O <= 1'b0;	 
      end 
   endtask // wait
   
   
   /*Classic Standard Single Read*/   
   task rd;
      input [ADR_MSB:0] addr_i;
      output [DATA_MSB:0] DAT_O;      
      begin
	 
	 @(posedge CLK_I);	 
	 ADR_O <= addr_i;
	 SEL_O <= 3'b111;
	 // tga_o <= 4'b1010;
	 // tgc_o <= 4'b1011;
	 WE_O <= 1'b0;
	 STB_O <= 1'b1;
	 CYC_O <= 1'b1;
	 
         /* Delay the cycles untill the ACK_I is enabled*/	 
         while(ACK_I==1'b0) begin
	    @(posedge CLK_I);
	 end	 
	 
	// @(posedge CLK_I);	 
          DAT_O <= DAT_I; //Latch the data and place on the local variable DAT_O
         //data_rx <= DATA; //for test purpose only
	 // tagd_rx <= tgd_i;
 	 STB_O <= 1'b0;	
	 CYC_O <= 1'b0;	 
      end
   endtask // wait
   
   
   task blkwr;
      input [ADR_MSB:0] addr_i;
      input [DATA_MSB:0] DAT_O; 
      input [3:0] sel;
      input end_flag;     
      begin
	 
	 @(posedge CLK_I);	 
	 ADR_O <= addr_i;
	 // tga_o <= 4'b1010;
	 DAT_O <= DATA;
	 // tgd_o <= 4'b0111;
	 WE_O <= 1'b1;
	 SEL_O <=sel;
	 CYC_O <= 1'b1;
	 // tgc_o <= 1'b1;
	 STB_O <= 1'b1;
	 
	 @(posedge CLK_I);
	 
         /* Delay the cycles untill the ACK_I is enabled*/	 
         while(ACK_I == 1'b0) begin
	    @(posedge CLK_I);
	 end
	 STB_O <= 1'b0;

	// @(posedge CLK_I);
	 ADR_O <= addr_i;
	 // tga_o <= 4'b1010;
	 DAT_O <= DATA;
	 // tgd_o <= 4'b0111;
	 WE_O <= 1'b1;
	 SEL_O <= sel;
	 CYC_O <= 1'b1;
	 // tgc_o <= 1'b1;
	 STB_O <= 1'b1;

	 @(posedge CLK_I);
	 ADR_O <= addr_i;
	 // tga_o <= 4'b1010;
	 WE_O <= 1'b0;
	 SEL_O <= sel;
	 // tgc_o <= 1'b1;
	 STB_O <= 1'b1;
	 
	 @(posedge CLK_I);
	 
	 while(ACK_I == 1'b0) begin
	    @(posedge CLK_I);	    
	 end
	 STB_O <= 1'b0;
	 CYC_O <= 1'b0;

	 
      end 
   endtask // wait


      /*Classic Standard Block Read*/   
   task blkrd;
      input [ADR_MSB:0] addr_i;
      output [DATA_MSB:0] DAT_O;    
      input end_flag;  
      begin
	 
	 @(posedge CLK_I);	 
	 ADR_O <= addr_i;
	 SEL_O <= 4'b1111;
	// tga_o <= 4'b1010;
	// tgc_o <= 4'b1011;
	 WE_O <= 1'b0;
	 STB_O <= 1'b1;
	 CYC_O <= 1'b1;
	 
        /* Delay the cycles untill the ACK_I is enabled*/	 
         while(ACK_I==1'b0) begin
	    @(posedge CLK_I);
	 end
	 
	 //@(posedge CLK_I);	 
         DAT_O <= DAT_I; //Latch the data and place on the local variable DAT_O
         //data_rx <= DATA; //for test purpose only
	 // tagd_rx <= tgd_i;
	 STB_O <= 1'b0;	

	 @(posedge CLK_I);
	 ADR_O <= addr_i;
	 SEL_O <= 4'b1111;
	 // tga_o <= 4'b1010;
	 WE_O <= 1'b0;
	 STB_O <= 1'b1;

	 @(posedge CLK_I);

	 @(posedge CLK_I);
	 DAT_O <= DAT_I; //Latch the data and place on the local variable DAT_O
         //data_rx <= DATA; //for test purpose only
	 // tagd_rx <= tgd_i;
	 STB_O <= 1'b0;
	 CYC_O <= 1'b0; 
	 
      end
   endtask // wait

   
   /*always @* begin
      case(func_i)
        2'b00: sread(ADDRESS, data_rx);
        2'b01: swrite(ADDRESS, DATA);
        2'b10: blkread(ADDRESS, data_rx);
        2'b11: blkwrite(ADDRESS, DATA);        
      endcase
   end   */
   
   
endmodule // wbmaster
