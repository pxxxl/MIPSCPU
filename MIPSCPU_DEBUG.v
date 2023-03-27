module MIPSCPU_D(
    input Clk,
    input Reset,

    output [31:0]PCIn,
    output [31:0]PCOut,
    output [31:0]Instr,
    output [5:0]OpCode,
    output [5:0]Funct,
    output [4:0]RsAddr,
    output [4:0]RtAddr,
    output [4:0]RdAddr,
    output [25:0]Jump,
    output [15:0]Imm,
    output [4:0]WrAddr,
    output [31:0]ImmExtended,
    output [31:0]ImmExtendedShift,
    output J, B, RegDst, RegWr, ALUSrc, MemWr, Mem2Reg,
    output [3:0]ALUCtr,
    output [31:0]Rs,
    output [31:0]Rt,
    output [31:0]RegWrData,
    output [31:0]ALUOut,
    output Zero,
    output [31:0] ALUIn1,
    output [31:0] ALUIn2,
    output [4:0] MemAddr,
    output [31:0] WrMemData,
    output [31:0] RdMemData,
    output [31:0] Plus4PC,
    output [31:0] BranchPC,
    output [31:0] JumpPC,
    output [31:0] DecisionRes1
    );

    //PC and InstrROM part
    //wire [31:0] PCIn;
    //wire [31:0] PCOut;
    //wire [31:0] Instr;

    PC PC_inst(
        .D(PCIn),
        .Q(PCOut),
        .Reset(Reset), 
        .Clk(Clk));

    InstrROM InstrROM_inst(
        .Addr(PCOut[6:2]), 
        .Clk(~Clk), 
        .Instr(Instr));


    //Instruction partitioning
    assign OpCode = Instr[31:26];
    assign Funct = Instr[5:0];
    assign RsAddr = Instr[25:21];
    assign RtAddr = Instr[20:16];
    assign RdAddr = Instr[15:11];
    assign Jump = Instr[25:0];
    assign Imm = Instr[15:0];


    //Instruction processing
    assign WrAddr = RegDst ? RdAddr : RtAddr;
    //wire [31:0] ImmExtended;
    //wire [31:0] ImmExtendedShift;
    //wire J, B, RegDst, RegWr, ALUSrc, MemWr, Mem2Reg;
    //wire [3:0]ALUCtr;

    SignedExtended ImmExtend(
        .In(Imm),
        .Out(ImmExtended));

    LeftShift ImmExtendShift(
        .In(ImmExtended),
        .Out(ImmExtendedShift));

    Controller Controller_inst(
        .OpCode(OpCode),
        .Funct(Funct), 
        .J(J), 
        .B(B), 
        .RegDst(RegDst), 
        .RegWr(RegWr), 
        .ALUSrc(ALUSrc), 
        .MemWr(MemWr), 
        .Mem2Reg(Mem2Reg), 
        .ALUCtr(ALUCtr));


    //Register file part
    //wire [31:0] Rs;
    //wire [31:0] Rt;
    //wire [31:0] RegWrData;

    RegFile RegFile_inst(
        .RsAddr(RsAddr),
        .RtAddr(RtAddr),
        .WrAddr(WrAddr),
        .DataIn(RegWrData),
        .RegWr(RegWr),
        .Clk(Clk),
        .RsData(Rs),
        .RtData(Rt));
    

    //ALU part
    //wire [31:0] ALUOut;
    //wire Zero;
    assign ALUIn1 = Rs;
    //wire [31:0] ALUIn2;

    Mux2_1 ALUIn2_gen(
        .In1(Rt),
        .In2(ImmExtended),
        .sel(ALUSrc),
        .Out(ALUIn2));

    ALU ALU_inst(
        .In1(ALUIn1),
        .In2(ALUIn2),
        .Res(ALUOut),
        .ALUCtr(ALUCtr),
        .Zero(Zero));


    //Memory part
    assign MemAddr = ALUOut;
    assign WrMemData = Rt;
    //wire [31:0] RdMemData;

    DataRAM Mem_inst(
        .Addr(MemAddr),
        .DataIn(WrMemData),
        .MemWR(MemWr),
        .Clk(Clk),
        .DataOut(RdMemData));
    

    //Loop1: Generate register write data
    Mux2_1 RegWrData_gen(
        .In1(ALUOut),
        .In2(RdMemData),
        .sel(Mem2Reg),
        .Out(RegWrData));


    //Loop2: Generate next PC
    //wire [31:0] Plus4PC;
    //wire [31:0] BranchPC;
    //wire [31:0] JumpPC;
    //wire [31:0] DecisionRes1;

    Adder Plus4PC_gen(
        .In1(PCOut),
        .In2(4),
        .Out(Plus4PC));

    Concat JumpPC_gen(
        .In1(PCOut[31:28]),
        .In2({Jump, 2'b00}),
        .Out(JumpPC));

    Adder BranchPC_gen(
        .In1(Plus4PC),
        .In2(ImmExtendedShift),
        .Out(BranchPC));

    Mux2_1 Decision1(
        .In1(Plus4PC),
        .In2(BranchPC),
        .sel(B & Zero),
        .Out(DecisionRes1));
    
    Mux2_1 Decisioin2(
        .In1(DecisionRes1),
        .In2(JumpPC),
        .sel(J),
        .Out(PCIn));
endmodule