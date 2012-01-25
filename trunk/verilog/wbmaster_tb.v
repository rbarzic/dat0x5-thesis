`include "def.v"
module wbmaster_tb();

parameter aw = `address_width-1;
parameter dw = `data_width-1;
parameter sw = `select_width-1;

reg rst, clk, ack, err,intr;
reg [dw:0] data = 8'b1111_0000;

wire [sw:0] sel;
wire [aw:0] adr, dat;
wire we, stb, cyc;

initial
begin
        $dumpvars;
        rst = 1'b0;
        clk = 1'b0;
        ack = 1'b0;
        err = 1'b0;
        intr = 1'b0;

end

wbmaster master0(.ADR_O(adr), .DAT_O(dat), .WE_O(we), .SEL_O(sel), .STB_O(stb), .CYC_O(cyc), .RST_I(rst), .CLK_I(clk), .DAT_I(data), .ACK_I(ack), .ERR_I(err), .INTR_I(intr));

endmodule
