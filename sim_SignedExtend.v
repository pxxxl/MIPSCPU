`timescale 1ns / 1ps
module SignExtendsim( );
reg [15:0] In;
wire [31:0] Out;
SignedExtend U0(In, Out);
defparam U0.n=16,U0.m=32;
initial
begin
In=16'h1234;
#10;
In=16'h8234;
#10;
$stop;
end
endmodule
