module MIPSCPU(
    input Clk,
    input Reset
    );

    //PC and InstrROM part
    wire [31:0] PCIn;
    wire [31:0] PCOut;
    wire [31:0] Instr;

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
    wire [5:0] OpCode = Instr[31:26];
    wire [5:0] Funct = Instr[5:0];
    wire [4:0] RsAddr = Instr[25:21];
    wire [4:0] RtAddr = Instr[20:16];
    wire [4:0] RdAddr = Instr[15:11];
    wire [25:0] Jump = Instr[25:0];
    wire [15:0] Imm = Instr[15:0];


    //Instruction processing
    wire [4:0] WrAddr = RegDst ? RdAddr : RtAddr;
    wire [31:0] ImmExtended;
    wire [31:0] ImmExtendedShift;
    wire J, B, RegDst, RegWr, ALUSrc, MemWr, Mem2Reg;
    wire [3:0]ALUCtr;
    //wire [2:0]LoadSignal;

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
    wire [31:0] Rs;
    wire [31:0] Rt;
    wire [31:0] RegWrData;

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
    wire [31:0] ALUOut;
    wire Zero;
    wire [31:0] ALUIn1 = Rs;
    wire [31:0] ALUIn2;

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
    wire [4:0] MemAddr = ALUOut[6:2];
    wire [31:0] WrMemData = Rt;
    wire [31:0] RdMemData;
    wire [31:0] LoadData;

    DataRAM Mem_inst(
        .Addr(MemAddr),
        .DataIn(WrMemData),
        .MemWR(MemWr),
        .Clk(Clk),
        .DataOut(RdMemData));

    assign LoadData = RdMemData;
    //LoadControl load_inst(
    //    .LoadSignal(LoadSignal),
    //    .In(RdMemData),
    //    .Out(LoadData)
    //);
    
    //Loop1: Generate register write data
    Mux2_1 RegWrData_gen(
        .In1(ALUOut),
        .In2(LoadData),
        .sel(Mem2Reg),
        .Out(RegWrData));


    //Loop2: Generate next PC
    wire [31:0] Plus4PC;
    wire [31:0] BranchPC;
    wire [31:0] JumpPC;
    wire [31:0] DecisionRes1;

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
    
    Mux2_1 Decision2(
        .In1(DecisionRes1),
        .In2(JumpPC),
        .sel(J),
        .Out(PCIn));
endmodule