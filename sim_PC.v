`timescale 1ns/1ps
module sim_PC;
    // Inputs
    reg [31:0] D;
    reg Reset;
    reg Clk;
    // Outputs
    wire [31:0] Q;
    // Instantiate the Unit Under Test (UUT)
    PC uut (
        .D(D), 
        .Q(Q), 
        .Reset(Reset), 
        .Clk(Clk)
    );
    always #1 Clk = ~Clk;
    initial begin
        D = 0;
        Reset = 1;
        Clk = 0;
        #20
        Reset = 0;
        D = 32'h12345678;
        #20
        D = 32'h87654321;
        #1000;
        Reset = 1;
    end
endmodule