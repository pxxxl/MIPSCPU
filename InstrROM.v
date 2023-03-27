module InstrROM(input [4:0]Addr,
                input Clk,
                output reg [31:0]Instr);
    parameter n = 5;
    reg [31:0]RAM[31:0];
    always@ (posedge Clk)
        Instr <= RAM[Addr];
endmodule

