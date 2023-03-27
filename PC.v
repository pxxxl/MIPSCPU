module PC(input [31:0]D,
        input Clk,
        input Reset,
        output reg [31:0]Q);
    always@ (posedge Clk, posedge Reset)
        if(Reset)
            Q <= 0;
        else
            Q <= D;
endmodule