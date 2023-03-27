module Adder(input [31:0]In1,
            input [31:0]In2,
            output [31:0]Out);
    assign Out = In1 + In2;
endmodule