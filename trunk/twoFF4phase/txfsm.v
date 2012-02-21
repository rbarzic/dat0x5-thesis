module transmitter(/*AUTOARG*/
   // Outputs
   output_tx, req, f,
   // Inputs
   clk, v, reset, ack, input_tx
   );
`include "def.v"

   input                clk,v,reset,ack;
   input [DATA_MSB:0]   input_tx; // Plug-in the data that has to be transmitted to other core
   output [DATA_MSB:0]  output_tx; // Tx-buffer
   output               req,f;

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg			f;
   reg [DATA_MSB:0]	output_tx;
   reg			req;
   // End of automatics

   reg 	     a3;   
   wire      a1, a2;

   parameter  rst = 2'b00;  // Asynchronous reset state
   parameter  idle = 2'b01;  // Wait for the input 'v'
   parameter  request = 2'b10; // Data is on the bus, send the request to receiver (this is push synchronizer)
   parameter  waiting = 2'b11; // Waiting for the deassertion of ack
   
   reg[1:0]  current_state, next_state;   
   reg statemachine;

   /* Instantiate the two(can be extended depending on MTBF requirment) flip flops for the ack input- this avoids metastability till MTBF */
   dff  dff1(.q(a1), .d(ack), .clk(clk), .reset(reset));
   dff  dff2(.q(a2), .d(a1), .clk(clk), .reset(reset));
   
   always @(posedge clk or posedge reset) begin
      a3 <= a2;
      f <= (! a3) & a2;
      if(reset) begin
	 output_tx <= 0;
         statemachine <= 1'b0;	 
      end else begin
	 if (v == 1'b1) begin
	    output_tx <= input_tx; // Put the data into transmit data buffer	   
	    statemachine <= 1'b1;
	 end	 
      end
   end   

   
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
      if(statemachine) begin
      case(current_state) 
	 rst: begin
	    next_state = idle;
	    req = 1'b0;
	 end

	 idle: begin
	    if(v == 1'b1) begin 
	       next_state = request;
	       req = 1'b1;	       
	    end
	 end

	 request: begin
	    if(a2 == 1'b1) begin
	       next_state = waiting;
	       req = 1'b0;	       
	    end	    
	 end

	 waiting: begin
	    if(a2 == 1'b0) begin
	       next_state = idle;
	    end   
	 end
	
	 default: begin
	    next_state = idle;
	    req = 1'b0;	    
	 end	
      endcase // case (current_state)
      end  
   end // always @ (*)


endmodule // transmitter

   


   
