/* This module is the implementation of the Tx-FSM for the fast two flop-4 phase sync(literature : zerolatency.pdf page-4) */
module txfsm(/*AUTOARG*/
   // Outputs
   snt, en,
   // Inputs
   vi, clk, reset, a2p, a2d
   );


   parameter  rst = 2'b00;  
   parameter  wdata = 2'b01;
   parameter  done = 2'b10; 
   parameter  wack = 2'b11; 
   
   reg[1:0]   current_state, next_state;   
   
   output  snt, en;
   input   vi, clk, reset, a2p, a2d;

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg			en;
   reg			snt;
   // End of automatics

/*transmitter state machine*/   
     /* Sequential block*/
    always @(posedge clk or posedge reset) begin        
       if(reset) begin
	  current_state <= rst;
       end else begin
	  current_state <= next_state;
       end
    end

   /* Combinational block*/
   always @(*) begin
      next_state = current_state;
      case(current_state) 
	 rst: begin //00	    
	    en = 1'b0;
	    snt = 1'b0;	  
            next_state = wdata;  
	 end

	 wdata: begin //01	  	       
	       en = 1'b1;
	       snt = 1'b0;
            if(vi == 1'b1 && a2d == 1'b0) begin 	
               next_state = done;	       
	    end else if(vi == 1'b0 || a2d == 1'b1) begin	      
               next_state = wdata;
	    end
        end

	 done: begin //10              
	       en = 1'b0;
	       snt = 1'b1;
               next_state = wack;	    	    
	 end

	 wack: begin //11
               en = 1'b0;
	       snt = 1'b0;
	    if(a2p == 1'b1) begin  	
               next_state = wdata;
	    end else if(a2p == 1'b0) begin	       
               next_state = wack;
	    end	    
	 end
	
	 default: begin	    
	    en = 1'b0;
	    snt = 1'b0;	  
            next_state = wdata;  
	 end	
      endcase // case (current_state)
   end // always @ (*)

endmodule // txfsm
