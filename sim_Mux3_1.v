`timescale 1ns / 1ps
module sim_Mux3_1();
reg [31:0] In1, In2,In3;
reg [1:0] sel;
wire [31:0] Out;
Mux3_1 U0(In1, In2,In3, sel, Out);
integer i;
initial
begin
In1=32'h12345678;
In2=32'h87654321;
In3=32'h33333333;
for (i=0;i<4;i=i+1)
begin
sel=i;
#10;
end
$stop;
end
endmodule
