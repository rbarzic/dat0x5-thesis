module sync_multi(/*AUTOARG*/
   // Outputs
   out_data, f, d,
   // Inputs
   in_data, v, clk, reset
   );

`include "def.v"

   parameter  DATA_WIDTH = `DATA_WIDTHS,
     DATA_MSB = DATA_WIDTH-1,
     DATA = `DATAS;

   output [DATA_MSB:0] out_data;
   output 	       f, d;
   input [DATA_MSB:0]  in_data;
   input 	       v, clk, reset;

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg			d;
   reg			f;
   wire [DATA_MSB:0]	out_data;
   // End of automatics
   wire [DATA_MSB:0]   data, out_data1;
   reg 	       ack, req;
   reg [DATA_MSB:0] data_temp;
   wire ack1, req1, f1, d1;
 
   transmitter tx1(.output_tx(data), .req(req1), .f(f1), .clk(clk), .v(v), .reset(reset), .ack(ack1), .input_tx(in_data));
   receiver rx1(.output_rx(out_data), .ack(ack1), .d(d1), .clk(clk), .reset(reset), .req(req1), .input_rx(data));
        always @* begin
                f =f1;
                d =d1;
        end        

   
endmodule // sync_multi
