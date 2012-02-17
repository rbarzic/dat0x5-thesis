`include "def.v"
module wbmaster_tb();

parameter aw = `address_width-1;
parameter dw = `data_width-1;
parameter sw = `select_width-1;

reg rst, clk, ack, err,intr;
reg [dw:0] data = 8'bzzzz_zzzz;

wire [sw:0] sel;
wire [aw:0] adr, dat;
wire we, stb, cyc;

wbmaster master0(.ADR_O(adr), .DAT_O(dat), .WE_O(we), .SEL_O(sel), .STB_O(stb), .CYC_O(cyc), .RST_I(rst), .CLK_I(clk), .DAT_I(data), .ACK_I(ack), .ERR_I(err), .INTR_I(intr));

        initial        
                clk = 1'b0;
        always
                #5 clk = ~clk;


initial
begin
        $dumpvars;
        rst = 1'b1;
        ack = 1'b0;
        err = 1'b0;
        intr = 1'b0;
        
        #15 rst = 1'b0;
        #35 ack = 1'b1;
        data = 8'b1111_0000;
        #70 err = 1'b1;
        #200 $finish;

end





endmodule
