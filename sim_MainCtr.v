`timescale 1ns / 1ps
module sim_MainCtr( );
reg [5:0] OpCode;
wire J, B, RegDst, RegWr, ALUSrc, MemWr, Mem2Reg;
wire [1:0] ALUOp;
MainCtr UO_MainCtr(OpCode,J, B, RegDst, RegWr, ALUSrc, MemWr, Mem2Reg, ALUOp);
initial
begin
OpCode =6'h00;
#10;
OpCode = 6'h23;
#10;
OpCode = 6'h2b;
#10;
OpCode =6'h04;
#10;
OpCode =6'h02;
#10;
$stop;
end
endmodule