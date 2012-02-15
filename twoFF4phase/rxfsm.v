module receiver(/*AUTOARG*/
   // Outputs
   output_rx, ack, d,
   // Inputs
   clk, reset, req, input_rx
   );
`include "def.v"

        parameter  DATA_WIDTH = `DATA_WIDTHS,
           DATA_MSB = DATA_WIDTH-1,
           DATA = `DATAS;

   input                clk, reset, req;   
   input [DATA_MSB:0]   input_rx; //Data input from other core
   output [DATA_MSB:0]  output_rx; //Data received
   output               ack, d;

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg			ack;
   reg			d;
   reg [DATA_MSB:0]	output_rx;
   // End of automatics

   reg 			r3;   
   wire 		r1, r2;
   reg statemachine;
     
   parameter  rst = 2'b00;  // Asynchronous reset state
   parameter  idle = 2'b01;  // Wait for the input 'v'
   parameter  acknowledge = 2'b10; // Data is on the bus, send the request to receiver (this is push synchronizer)
   parameter  waiting = 2'b11; // Waiting for the deassertion of ack
   
   reg[1:0]  current_state, next_state;
   /* Instantiate the two(can be extended depending on MTBF requirment) flip flops for the req input- this avoids metastability till MTBF*/
   dff  dff1(.q(r1), .d(req), .clk(clk), .reset(reset));
   dff  dff2(.q(r2), .d(r1), .clk(clk), .reset(reset));
   
   always @(posedge clk or posedge reset) begin
      r3 <= r2;
      d <= (!r3) & r2;
      if(reset) begin
	 output_rx <= 0;
         statemachine <= 1'b0;	 
      end else begin
	 if(r2 == 1'b1) begin
	    output_rx <= input_rx; /* Latch the data into Rx-buffer*/	  
	    statemachine <= 1'b1;    
	 end 
      end
   end 
   
    always@(posedge clk) begin
      
       if(reset) begin
	  current_state <= rst;
       end else begin
	  current_state <= next_state;
       end
    end
   
   always @(*) begin
      next_state = current_state;
      if(statemachine) begin        
      case(current_state)
	 rst: begin
	    next_state = idle;
	    ack = 1'b0;
	 end

	 idle: begin
	    if(r2 == 1'b1) begin 
	       next_state = acknowledge;
	       ack = 1'b1;	       
	    end
	 end

	  acknowledge: begin
	    if(r2 == 1'b0) begin
	       next_state = idle;
	       ack = 1'b0;	       
	    end	    
	 end

	 default: begin
	    next_state = idle;
	    ack = 1'b0;	    
	 end	
      endcase // case (current_state)
      end
   end // always @ (*)

endmodule // receiver
   
