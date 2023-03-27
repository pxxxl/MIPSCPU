`timescale 1ns/10ps
`include "MIPSCPU_DEBUG.v"
`include "PC.v"
`include "InstrROM.v"
`include "RegFile.v"
`include "Controller.v"
`include "SignedExtended.v"
`include "LeftShift.v"
`include "ALU.v"
`include "DataRAM.v"
`include "Mux2_1.v"
`include "Mux3_1.v"
`include "ALUControl.v"
`include "Adder.v"
`include "MainCtr.v"
`include "Concat.v"



module sim_MIPSCPU_D;
  
  // Inputs
  reg Clk;
  reg Reset;

  // Outputs
  wire [31:0] PCIn;
  wire [31:0] PCOut;
  wire [31:0] Instr;
  wire [5:0] OpCode;
  wire [5:0] Funct;
  wire [4:0] RsAddr;
  wire [4:0] RtAddr;
  wire [4:0] RdAddr;
  wire [25:0] Jump;
  wire [15:0] Imm;
  wire [4:0] WrAddr;
  wire [31:0] ImmExtended;
  wire [31:0] ImmExtendedShift;
  wire J;
  wire B;
  wire RegDst;
  wire RegWr;
  wire ALUSrc;
  wire MemWr;
  wire Mem2Reg;
  wire [3:0] ALUCtr;
  wire [31:0] Rs;
  wire [31:0] Rt;
  wire [31:0] RegWrData;
  wire [31:0] ALUOut;
  wire [31:0] MemOut;
  wire Zero;
  wire [4:0] MemAddr;
  wire [31:0] WrMemData;
  wire [31:0] RdMemData;
  wire [31:0] Plus4PC;
  wire [31:0] BranchPC;
  wire [31:0] JumpPC;
  wire [31:0] DecisionRes1;

  // Instantiate the Unit Under Test (UUT)
  MIPSCPU_D uut (
    .Clk(Clk), 
    .Reset(Reset), 
    .PCIn(PCIn), 
    .PCOut(PCOut), 
    .Instr(Instr), 
    .OpCode(OpCode), 
    .Funct(Funct), 
    .RsAddr(RsAddr), 
    .RtAddr(RtAddr), 
    .RdAddr(RdAddr), 
    .Jump(Jump), 
    .Imm(Imm), 
    .WrAddr(WrAddr), 
    .ImmExtended(ImmExtended), 
    .ImmExtendedShift(ImmExtendedShift), 
    .J(J), 
    .B(B), 
    .RegDst(RegDst), 
    .RegWr(RegWr), 
    .ALUSrc(ALUSrc), 
    .MemWr(MemWr), 
    .Mem2Reg(Mem2Reg), 
    .ALUCtr(ALUCtr), 
    .Rs(Rs), 
    .Rt(Rt), 
    .RegWrData(RegWrData), 
    .ALUOut(ALUOut), 
    .Zero(Zero), 
    .MemAddr(MemAddr), 
    .WrMemData(WrMemData), 
    .RdMemData(RdMemData), 
    .Plus4PC(Plus4PC), 
    .BranchPC(BranchPC), 
    .JumpPC(JumpPC), 
    .DecisionRes1(DecisionRes1)
  );

    always #5 Clk = ~Clk;

    initial begin
        Clk = 0;
        Reset = 1;
        #5
        Reset = 0;
        #1000
        $finish;
    end

    initial begin
        $dumpfile("sim_MIPSCPU_D.vcd");
        $dumpvars(0, sim_MIPSCPU_D);
    end
endmodule