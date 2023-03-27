`timescale 1ns / 1ps
module Concatsim( );
reg [31:0] In1;
reg [31:0] In2;
wire [31:0] Out0;
wire [1:0] Out1;
Concat U0(In1[3:0], In2[27:0], Out0);
defparam U0.n=4,U0.m=28;
Concat U1(In1[0], In2[0], Out1);
defparam U1.n=1,U1.m=1;
initial
begin
In1=32'h12345679;
In2=32'h87654321;
#10;
$stop;
end
endmodule