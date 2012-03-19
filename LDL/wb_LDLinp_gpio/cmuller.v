//   Project     : async
//   File        : cmuller.v
//   Description : Verilog model of a C-Muller element
//   Copyright 2009 Ronan BARZIC

`timescale 1ns/1ns

module cmuller(/*AUTOARG*/
  // Outputs
  c,
  // Inputs
  a, b, rstn
  );
  input  a;
  input  b;
  input  rstn;
  output c;

  /*AUTOREG*/
  // Beginning of automatic regs (for this module's undeclared outputs)
  reg                   c;
  // End of automatics
  
  always @* begin
    if(rstn == 1'b1) begin
      c <= 0;
    end
    else begin
      if(a == b)
        c <= #1 a;
    end
    
  end
  
endmodule // cmuller

