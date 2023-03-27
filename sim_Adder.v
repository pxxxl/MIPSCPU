`timescale 1ns / 1ps
module Addersim( );
reg [31:0] In1,In2;
wire [31:0] Out;
Adder U0(In1,In2,Out);
initial
begin
In1=4;
In2=8;
#10;
In1=32'h44444444;
In2=32'h88888888;
#10;
$stop;
end
endmodule
