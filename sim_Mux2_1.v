`timescale 1ns / 1ps
module sim_Mux2_1( );
reg [31:0] In1, In2;
reg sel;
wire [31:0] Out;
Mux2_1 U0(In1, In2, sel, Out);
initial
begin
In1=32'h12345678;
In2=32'h87654321;
sel=0;
#10;
sel=1;
#10;
$stop;
end
endmodule