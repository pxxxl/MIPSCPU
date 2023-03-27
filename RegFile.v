module RegFile(input [4:0]RsAddr,
               input [4:0]RtAddr,
               input [4:0]WrAddr,
               input [31:0]DataIn,
               input RegWr,
               input Clk,
               output reg [31:0]RsData,
               output reg [31:0]RtData);
    reg [31:0]RAM[0:31];
    always@ (*) begin
        if (RsAddr == 0)
            RsData <= 0;
        else
            RsData <= RAM[RsAddr];
        if (RtAddr == 0)
            RtData <= 0;
        else
            RtData <= RAM[RtAddr];
    end
    always@ (posedge Clk)
        if(RegWr)
            RAM[WrAddr] <= DataIn;
endmodule

