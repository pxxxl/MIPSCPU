module Mux2_1(input [31:0]In1,
            input [31:0]In2,
            input sel,
            output [31:0]Out);
    assign Out = sel ? In2 : In1;
endmodule