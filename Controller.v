module Controller(input[5:0] OpCode,
                input[5:0] Funct,
                output J,
                output B,
                output RegDst,
                output RegWr,
                output ALUSrc,
                output MemWr,
                output Mem2Reg,
                output [3:0]ALUCtr);
    // J: the instruction is a jump instruction
    // B: the instruction is a branch instruction
    // RegDst: address {1: Instr[5:11]($Rd); 0: Instr[16:20]($Rt)} is written
    // RegWr: 1 then a register is written
    // ALUSrc: the second oprand of ALU is {1: signed extend of Instr[15:0](Imm); 0: Rt}
    // MemWr: 1 then memory is written
    // Mem2Reg: {1: memory; 0: ALU result} is written to the register file
    // ALUCtr: the control signal of ALU
    
    wire [1:0] ALUOp;
    MainCtr ctr(.OpCode(OpCode), .J(J), .B(B), .RegDst(RegDst), .RegWr(RegWr), .ALUSrc(ALUSrc), .MemWr(MemWr), .Mem2Reg(Mem2Reg), .ALUOp(ALUOp));
    ALUControl alu(.ALUOp(ALUOp), .Funct(Funct), .ALUCtr(ALUCtr));
endmodule