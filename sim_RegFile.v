`timescale 1ns / 1ps
module RegFileSim();
reg [4:0] RsAddr,RtAddr, WrAddr;
reg [31:0] DataIn;
reg RegWr,Clk;
wire [31:0] RsData, RtData;
RegFile U0_RegFile(RsAddr, RtAddr, WrAddr, DataIn, RegWr,Clk, RsData, RtData);
parameter PERIOD = 10;
always begin
Clk = 1'b0;
#(PERIOD/2) Clk = 1'b1;
#(PERIOD/2);
end
integer i;
initial
begin
for(i=0;i<32;i=i+1)
U0_RegFile.regs[i]=0;
RegWr=1;
for(i=0;i<10;i=i+1)
begin
WrAddr=i;
DataIn=i*4;
#10;
end
RegWr=0;
for(i=0;i<10;i=i+1)
begin
RsAddr=i;
RtAddr=9-i;
#10;
end
$stop;
end
endmodule
