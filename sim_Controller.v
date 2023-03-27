`timescale 1ns/1ps
module sim_Controller;
    reg [5:0]OpCode, Funct;
    wire J, B, RegDst, RegWr, ALUSrc, MemWr, Mem2Reg;
    wire [3:0]ALUCtr;

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
        .ALUCtr(ALUCtr)
        );
    initial begin
OpCode=6'h00;
begin
Funct=6'h20;
#10;
Funct=6'h22;
#10;
Funct=6'h24;
#10;
Funct=6'h25;
#10;
Funct=6'h2a;
#10;
end
OpCode=6'h23;
begin
Funct=6'h20;
#10;
Funct=6'h22;
#10;
Funct=6'h24;
#10;
Funct=6'h25;
#10;
Funct=6'h2a;
#10;
end
OpCode=6'h2b;
begin
Funct=6'h20;
#10;
Funct=6'h22;
#10;
Funct=6'h24;
#10;
Funct=6'h25;
#10;
Funct=6'h2a;
#10;
end
OpCode=6'h04;
begin
Funct=6'h20;
#10;
Funct=6'h22;
#10;
Funct=6'h24;
#10;
Funct=6'h25;
#10;
Funct=6'h2a;
#10;
end
OpCode=6'h02;
begin
Funct=6'h20;
#10;
Funct=6'h22;
#10;
Funct=6'h24;
#10;
Funct=6'h25;
#10;
Funct=6'h2a;
#10;
end
$stop;
end
endmodule
