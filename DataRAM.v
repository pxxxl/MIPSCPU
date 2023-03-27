module DataRAM(input [4:0]Addr, 
               input [31:0]DataIn, 
               input MemWR,
               input Clk, 
               output [31:0]DataOut);
    reg [31:0]RAM[0:31];
    always@ (posedge Clk)
        if(MemWR)
            RAM[Addr] <= DataIn;
    assign DataOut = RAM[Addr];
endmodule