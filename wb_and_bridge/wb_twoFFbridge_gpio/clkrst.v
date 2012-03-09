//////////////////////////////////////////////////////////////////////
////                                                              ////
////  Clock and Reset Generator                                   ////
////                                                              ////
////  This file is part of the GPIO project                       ////
////  http://www.opencores.org/cores/gpio/                        ////
////                                                              ////
////  Description                                                 ////
////  Clock and reset generator.                                  ////
////                                                              ////
////  To Do:                                                      ////
////   Nothing                                                    ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// CVS Revision History
//
// $Log: not supported by cvs2svn $
// Revision 1.1  2001/06/05 07:45:21  lampret
// Added initial RTL and test benches. There are still some issues with these files.
//
//

`include "timescale.v"

module clkrst(clk_o1, clk_o2, rst_o1, rst_o2);

//
// I/O ports
//
output	clk_o1, clk_o2;	// Clock
output	rst_o1, rst_o2;	// Reset

//
// Internal regs
//
reg	clk_o1, clk_o2;	// Clock
reg	rst_o1, rst_o2;	// Reset

initial begin
	clk_o1 = 0;
	clk_o2 = 0;
	rst_o1 = 1;
        rst_o2 = 1;
	#20;
	rst_o1 = 0; //gpio reset
        #500;
        rst_o2 = 0; //wbmaster reset
end

//
// Clock
//
always #4 clk_o1 = ~clk_o1; //gpio clk
always #400 clk_o2 = ~clk_o2; //wbmaster clk
endmodule
