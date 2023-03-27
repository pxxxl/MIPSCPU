`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/15 20:05:01
// Design Name: 
// Module Name: sim_MIPSCPU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`include "MIPSCPU.v"
`include "Adder.v"
`include "ALU.v"
`include "ALUControl.v"
`include "Concat.v"
`include "Controller.v"
`include "DataRAM.v"
`include "InstrROM.v"
`include "LeftShift.v"
`include "MainCtr.v"
`include "Mux2_1.v"
`include "Mux3_1.v"
`include "PC.v"
`include "RegFile.v"
`include "SignedExtended.v"

module sim_MIPSCPU;
  
    // Inputs
    reg Clk;
    reg Reset;

    // Instantiate the Unit Under Test (UUT)
    MIPSCPU uut (
      .Clk(Clk), 
      .Reset(Reset)
    );

    always #1 Clk = ~Clk;
    integer i;

    initial begin
        $dumpfile("sim_MIPSCPU.vcd");
        $dumpvars(0, sim_MIPSCPU);
        uut.InstrROM_inst.RAM[0]=32'h00432020;
        uut.InstrROM_inst.RAM[1]=32'h8c440004;
        uut.InstrROM_inst.RAM[2]=32'hac420008;
        uut.InstrROM_inst.RAM[3]=32'h00831022;
        uut.InstrROM_inst.RAM[4]=32'h00831025;
        uut.InstrROM_inst.RAM[5]=32'h00831024;
        uut.InstrROM_inst.RAM[6]=32'h0083102a;
        uut.InstrROM_inst.RAM[7]=32'h10830001;
        uut.InstrROM_inst.RAM[8]=32'h08000000;
        uut.InstrROM_inst.RAM[9]=32'h8c620000;
        uut.InstrROM_inst.RAM[10]=32'h08000000;
        
        for(i=0;i<32;i=i+1) begin
            uut.RegFile_inst.RAM[i]=i*4;
            uut.Mem_inst.RAM[i]=i*4;
        end
        Clk = 0;
        Reset = 1;
        #2
        Reset = 0;
        #20000
        $finish;
    end
endmodule
