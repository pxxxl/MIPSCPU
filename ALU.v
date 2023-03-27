module ALU(input [31:0]In1,
        input [31:0]In2,
        input [3:0]ALUCtr,
        output reg [31:0]Res,
        output reg Zero);


    always@(*) begin
            case (ALUCtr)
                4'b0010: Res <= In1 + In2;
                4'b0110: Res <= In1 - In2;
                4'b0111: Res <= In1 < In2;
                4'b0000: Res <= In1 & In2;
                4'b0101: Res <= In1 | In2;
            endcase

            if (Res == 0)
                Zero = 1'b1;
            else
                Zero = 1'b0;
    end

    
endmodule

