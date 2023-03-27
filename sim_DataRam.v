`timescale 1ns / 1ps
module DataRamsim( );
reg [4:0] Addr;
reg [31:0] DataIn;
wire [31:0] DataOut;
reg MemWR,Clk;
DataRAM U0_RAM(Addr,DataIn,MemWR,Clk,DataOut);
defparam U0_RAM. n=5,U0_RAM. m=32;
parameter PERIOD = 10;
always begin
Clk = 1'b0;
#(PERIOD/2) Clk = 1'b1;
#(PERIOD/2);
end
integer i;
initial
begin
MemWR = 1;
for(i=0;i<10;i=i+1)
begin
Addr=i;
DataIn=i*4;
#10;
end
MemWR=0;
for(i=0;i<10;i=i+1)
begin
Addr=i;
#10;
end
end
endmodule
