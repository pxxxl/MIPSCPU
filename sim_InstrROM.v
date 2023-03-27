`timescale 1ns/1ps
module sim_InstrRom;
    // Inputs
    reg [31:0] Addr;
    reg Clk;
    // Outputs
    wire [31:0] Instr;
    // Instantiate the Unit Under Test (UUT)
    InstrROM uut (
        .Addr(Addr), 
        .Instr(Instr), 
        .Clk(Clk)
    );
    integer i;
    always #1 Clk = ~Clk;
    initial begin
    Clk = 0;
        for(i = 0; i < 32; i = i + 1)
            uut.RAM[i] = i * 4;
        for (i = 0; i < 32; i = i + 1) begin
            Addr = i;
            # 4;
        end
        #2000
        $finish;
    end
endmodule