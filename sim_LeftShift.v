`timescale 1ns / 1ps
module Leftshiftsim( );
reg [31:0] In;
wire [31:0] Out0;
wire [27:0] Out1;
wire [28:0] Out2;
LeftShift U0(In, Out0);
defparam U0.n=32,U0.m=32,U0.x=2;
LeftShift U1(In[25:0], Out1);
defparam U1.n=26,U1.m=28,U1.x=2;
LeftShift U2(In[25:0], Out2);
defparam U2.n=26,U2.m=29,U2.x=3;
initial
begin
In=32'h22222222;
#10;
$stop;
end
endmodule