module MainCtr (input [5:0]OpCode,
                output J,
                output B,
                output RegDst,
                output RegWr,
                output ALUSrc,
                output MemWr,
                output Mem2Reg,
                output [1:0]ALUOp);
    assign J = (OpCode == 6'b000010);
    assign B = (OpCode == 6'b000100);
    assign RegDst = (OpCode == 6'b0);
    assign RegWr = (OpCode == 6'b0) | (OpCode == 6'b100011);
    assign ALUSrc = (OpCode == 6'b100011) | (OpCode == 6'b101011);
    assign MemWr = (OpCode == 6'b101011);
    assign Mem2Reg = (OpCode == 6'b100011);
    assign ALUOp = (OpCode == 6'b0) ? 2'b10 :
                    (OpCode == 6'b100011) ? 2'b00 :
                    (OpCode == 6'b101011) ? 2'b00 :
                    (OpCode == 6'b000100) ? 2'b01 :
                    2'b11;
    
endmodule