/* This file contains all the basic elements required for this project. Each elements are defined in separate modules*/

/* D-Flip Flop*/
module dff(/*AUTOARG*/
   // Outputs
   q, q_bar,
   // Inputs
   d, clk, reset
   );

   parameter DELAY = 1;
   
   input d,clk,reset;
   output q, q_bar;

   reg 	  q_i;
 	  
   /*AUTOREG*/
  
   always @(posedge clk or posedge reset) begin
      if(reset) begin
	 q_i <= 1'b0; //using non blocking assignments for the sequential logic
      end else begin
	 q_i <= d;
      end
   end
  assign #DELAY q = q_i;
  assign #DELAY q_bar = ~q_i;   
endmodule // dff

/*NOT gate*/
module inv(/*AUTOARG*/
   // Outputs
   idash,
   // Inputs
   i
   );

   parameter DELAY = 1;

   output idash;
   input i;

   assign #DELAY idash = !i;   
endmodule // inv

/* 2 input AND gate*/
module and2(/*AUTOARG*/
   // Outputs
   q,
   // Inputs
   a, b
   );

   parameter DELAY = 1;

   output q;
   input  a, b;

   assign #DELAY q = a & b;
endmodule // and2

/* 3 input AND gate*/
module and3(/*AUTOARG*/
   // Outputs
   q,
   // Inputs
   a, b, c
   );

   parameter DELAY = 1;

   output q;
   input  a, b, c;

   assign #DELAY q = a & b & c;
endmodule // and3

/* 2 input OR gate*/
module or2 (/*AUTOARG*/
   // Outputs
   q,
   // Inputs
   a, b
   );

   parameter DELAY = 1;

   output q;
   input  a, b;

   assign #DELAY q = a | b;   
endmodule // or2

/* 2 input nor gate*/
module nor2(/*AUTOARG*/
   // Outputs
   q,
   // Inputs
   a, b
   );
   parameter DELAY = 1;

   output q;
   input  a, b;

   assign #DELAY q = ~ (a | b);
endmodule // nor2

/* 3 input OR gate*/
module or3( /*AUTOARG*/
   // Outputs
   q,
   // Inputs
   a, b, c
   );

   parameter DELAY = 1;

   output q;
   input  a, b, c;

   assign #DEALAY q = a | b | c;
endmodule // or3

/* 2 input EXOR gate*/ 
module xor2(/*AUTOARG*/
   // Outputs
   q,
   // Inputs
   a, b
   );
   
   parameter DELAY = 1;

   output q;
   input  a, b;

   assign #DELAY q = a ^ b;
endmodule // xor2

/* 3 input EXOR gate*/
module xor3(/*AUTOARG*/
   // Outputs
   q,
   // Inputs
   a, b, c
   );

   parameter DELAY = 1;

   output q;
   input  a, b, c;

   assign #DELAY q = a ^ b ^ c;   
endmodule // xor3

/* S-R latch built using NOR gates*/
module srlatch(/*AUTOARG*/
   // Outputs
   q, qbar,
   // Inputs
   s, r
   );

   parameter DELAY = 1;

   output q, qbar;
   input  s, r;

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg			q;
   reg			qbar;
   // End of automatics
   wire qbar_i, q_i;
   nor2 norx(qbar_i, s, q_i);
   nor2 nory(q_i, r, qbar_i);  
        always @* begin
                qbar = #DELAY qbar_i;
                q = #DELAY q_i; 
        end  
   //assign #DELAY qbar =  qbar_i;
   //assign #DELAY q = q_i;      
endmodule // srlatch

   
/* Delay element*/
module delay(/*AUTOARG*/
   // Outputs
   q,
   // Inputs
   i
   );

   parameter DELAY = 1;

   output q;
   input  i;

   assign #DELAY q = i;
endmodule // delay

/* Muller-c element*/
module celement(/*AUTOARG*/
   // Outputs
   q,
   // Inputs
   a, b, reset
   );
   
   parameter DELAY = 1;
   output q;
   input  a, b, reset;

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg			q;
   // End of automatics
   always @(*) begin
      if(reset) begin
	 q <= 0;	 
      end else if(a == b) begin
	 q <= #DELAY b;	 
      end            
   end
endmodule // celement
   
/* Data register with multiple buswidth*/
module regdata(/*AUTOARG*/
   // Outputs
   q,
   // Inputs
   a, clk, reset
   );
   `include "def.v"

   parameter DELAY = 1;

   output [DATA_MSB:0] q;
   input [DATA_MSB:0]  a;
   input 	       clk, reset;
   
   reg [DATA_MSB:0]    q_i;    
   
   always @(posedge clk or posedge reset) begin
      if(reset) begin
	 q_i <= 0;
      end else begin
	 q_i <= a;	 
      end      
   end
   assign #DELAY q = q_i;   
endmodule // regdata

/*T-flip flop */
module tff(/*AUTOARG*/
   // Outputs
   q, qbar,
   // Inputs
   t, clk, reset
   );

   parameter DELAY = 1;

   output q, qbar;
   input  t, clk, reset;

   reg 	  q_i;
   
   always@(posedge clk or posedge reset) begin
      if(reset) begin
	 q_i <= 1'b0;	
      end else if(t) begin
	 q_i <= ~q_i;	 
      end      
   end

   assign #DELAY q = q_i;
   assign #DELAY qbar = ~q_i;
endmodule // tff

/* MUX 2:1*/
module mux(/*AUTOARG*/
   // Outputs
   q,
   // Inputs
   a, s
   );

   parameter DELAY = 1;

   output q;
   input [1:0] a;
   input       s;

   assign #DELAY q = s ? a[1] : a[0];
endmodule // mux

/* Data register with multiple buswidth and enable input*/
module regdataen(/*AUTOARG*/
   // Outputs
   q,
   // Inputs
   a, en, reset, clk
   );
   `include "def.v"

   parameter DELAY = 1;

   output [DATA_MSB:0] q;
   input [DATA_MSB:0]  a;
   input 	       en, reset, clk;
   
   reg [DATA_MSB:0]    q_i;    
   
   always @(posedge en or posedge clk or posedge reset) begin
      if(reset) begin
	 q_i <= 0;
      end else if(en) begin
	 q_i <= a;	 
      end      
   end
   assign #DELAY q = q_i;   
endmodule // regdataen

/* Data register with multiple buswidth and enable + enable* input*/
module regdataenstar(/*AUTOARG*/
   // Outputs
   q,
   // Inputs
   a, en, reset, enstar, clk
   );
   `include "def.v"

   parameter DELAY = 1;

   output [DATA_MSB:0] q;
   input [DATA_MSB:0]  a;
   input 	       en, reset, enstar,clk;
   
   reg [DATA_MSB:0]    q_i;    
   
   always @(posedge en or posedge enstar or posedge clk or posedge reset ) begin
      if(reset) begin
	 q_i <= 0;
      end else if(en && enstar) begin
	 q_i <= a;	 
      end      
   end
   assign #DELAY q = q_i;   
endmodule // regdataenstar

/* Register with enable, enable star and async reset */
module regenstar(/*AUTOARG*/
   // Outputs
   q,
   // Inputs
   a, en, reset, enstar, clk
   );
 
   parameter DELAY = 1;

   output q;
   input  a;
   input  en, reset, enstar, clk;
   
   reg q_i;    
   
   always @(posedge en or posedge enstar or posedge clk or posedge reset) begin
      if(reset) begin
	 q_i <= 0;
      end else if(en && enstar) begin
	 q_i <= a;	 
      end      
   end
   assign #DELAY q = q_i;   
endmodule // regenstar

/* data flip flop without qbar */
module dffs(/*AUTOARG*/
   // Outputs
   q,
   // Inputs
   d, clk, reset
   );

   parameter DELAY = 1;
   
   input d,clk,reset;
   output q;

   reg 	  q_i;
 	  
   /*AUTOREG*/
  
   always @(posedge clk or posedge reset) begin
      if(reset) begin
	 q_i <= 1'b0; //using non blocking assignments for the sequential logic
      end else begin
	 q_i <= d;
      end
   end
  assign #DELAY q = q_i;
 
endmodule // dffs


/* Yet to be done :-) */
/* MUTEX element*/
/* D-Flip flop with Async reset and EN* */
/* Asynchronous Controllers for LDL*/

