`timescale 1ns / 1ps
module sim_ALU();
reg signed [31:0] In1;
reg signed [31:0] In2;
reg [3:0] ALUCtr;
wire [31:0] ALURes;
wire Zero ;
ALU U0_ALU(In1,In2,ALUCtr, ALURes,Zero);
initial
begin
In1 = 4;
In2 = 8;
ALUCtr = 0;
#10;
ALUCtr = 1;
#10;
ALUCtr = 2;
#10;
ALUCtr = 6;
#10;
ALUCtr = 7;
#10;
In1 = 32'h44444444;
In2 = 32'h88888888;
ALUCtr = 0;
#10;
ALUCtr = 1;
#10;
ALUCtr = 2;
#10;
ALUCtr = 6;
#10;
ALUCtr = 7;
#10;
In1 = 32'h99999999;
In2 = 32'h88888888;
ALUCtr = 0;
#10;
ALUCtr = 1;
#10;
ALUCtr = 2;
#10;
ALUCtr = 6;
#10;
ALUCtr = 7;
#10;
$stop;
end
endmodule