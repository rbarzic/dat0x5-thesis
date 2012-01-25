`include "def.v"
module wbmaster( ADR_O,
                DAT_O,
                WE_O,
                SEL_O,
                STB_O,
                CYC_O,
                RST_I,
                CLK_I,
                DAT_I,
                ACK_I,
                ERR_I, 
                INTR_I);

parameter aw = `address_width-1;
parameter dw = `data_width-1;
parameter sw = `select_width-1;
parameter data_address = 8'b1111_1111;
output [aw:0] ADR_O;

output [dw:0] DAT_O;
output WE_O, STB_O, CYC_O;
output [sw:0] SEL_O;

input RST_I, CLK_I, ACK_I, ERR_I, INTR_I;
input [dw:0] DAT_I;

reg [dw:0] data_reg;
reg[2:0] curr_state, next_state;

reg [aw:0] ADR_O;
reg [dw:0] DAT_O;
reg WE_O, STB_O, CYC_O;
reg [sw:0] SEL_O;

//parameter definitions for state machines.
parameter reset = 3'b000;
parameter state1 = 3'b001;
parameter state2 = 3'b010;
parameter state3 = 3'b011;
parameter state4 = 3'b100;

//state mach‌ine for read cycle
always @ (posedge CLK_I)
        begin
                if(RST_I == 1'b1 || ERR_I == 1'b1)
                        curr_state <= reset;
                else
                        curr_state <= next_state;
        end

always @ (curr_state or ACK_I or ERR_I) 
        begin 
                next_state = curr_state; 
                case (curr_state)
                 
                reset:  begin 
                        WE_O = 1'bz;
                        STB_O = 1'b0;
                        CYC_O = 1'b0;                       
                        SEL_O = 1'bz;                        
                        ADR_O = 8'bzzzz_zzzz;
                        DAT_O = 8'bzzzz_zzzz;                        
                        next_state = state1;
                        end

                state1: begin //clock edge-0
                        ADR_O = data_address;
                        WE_O = 1'b0;                        
                        SEL_O = 1'b1;
                        CYC_O = 1'b1;
                        STB_O = 1'b1;
                        next_state = state2;
                        end

                state2: begin //clock edge-1
                        if(ACK_I == 1'b1) @(posedge CLK_I) // prepare to latch the data on DATA_I() and TAGD_I()
                        next_state = state3;
                        else
                        next_state = state2; //wait till the data appears on the data bus
                        end

                state3: begin //clock edge-3
                        data_reg =  DAT_I;    // latch the data
                        next_state = state4;
                        end

                state4: begin                        
                        STB_O = 1'b0;           
                        CYC_O = 1'b0;
                        next_state = reset;
                        end
               endcase 
        end
endmodule
