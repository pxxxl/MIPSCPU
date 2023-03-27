module Mux3_1(input [31:0]In1,
            input [31:0]In2,
            input [31:0]In3,
            input [2:0]sel,
            output [31:0]Out);
    assign Out = sel[2] ? In3 : (sel[1] ? In2 : In1);
endmodule