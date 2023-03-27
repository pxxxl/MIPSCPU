`timescale 1ns / 1ps
module sim_ALUControl();
reg [1:0] ALUOp;
reg [5:0] Funct;
wire [3:0] ALUCtr;
ALUControl U0_ALUControl(ALUOp, Funct, ALUCtr);
integer i;
initial
begin
for (i=0;i<3;i=i+1)
begin
ALUOp=i;
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
end
$stop;
end
endmodule