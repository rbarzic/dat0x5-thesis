`include "timescale.v"
module txfsmslow(/*AUTOARG*/
		 // Outputs
		 txe, req,
		 // Inputs
		 vi, clk, a2, reset
		 );
`include "def.v"

   output txe, req;
   input  vi, clk, a2, reset;
   
   parameter  rst = 2'b00;  // Asynchronous reset state
   parameter  wdata = 2'b01;  // Wait for the input 'v'
   parameter  wack = 2'b10; // Data is on the bus, send the request to receiver (this is push synchronizer)
   //parameter  waiting = 2'b11; // Waiting for the deassertion of ack
   
   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg 	  req;
   reg 	  txe;
   // End of automatics
   reg [1:0] current_state, next_state;   
   
   /*This task handles the transmitter state machine*/
   
   always @(posedge clk or posedge reset) begin        
      if(reset) begin
	 current_state <= rst;
      end else begin
	 current_state <= next_state;
      end
   end
   
   always @(*) begin
      next_state = current_state;
      case(current_state) 
	rst: begin
	   txe = 1'b0;
	   req = 1'b0;	      
	   next_state = wdata;	    
	end
	
	wdata: begin
	   req = 1'b0;
	   txe = 1'b1;	      
	   if(vi == 1'b1 && a2 == 1'b0) begin 		      
	      next_state = wack;
	   end else if (vi == 1'b0 || a2 == 1'b1) begin
	      next_state = wdata;
	   end
	end
	
	wack: begin
	   req = 1'b1;
	   txe = 1'b1;
	   if(a2 == 1'b1) begin		    
	      next_state = wdata;   
	      end else if (a2 == 1'b0) begin
		 next_state = wack;		 
	      end	    
	end
	
	default: begin	 
	   req = 1'b0;
	   txe = 1'b0;
	   next_state = wdata;	    
	end	
      endcase // case (current_state)        
   end // always @ (*)
   
endmodule // txfsm_slow


