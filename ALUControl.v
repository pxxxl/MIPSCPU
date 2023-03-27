module ALUControl(
    input [1:0]ALUOp,
    input [5:0] Funct,
    output reg [3:0]ALUCtr
    );
    always@ (*) begin
        case(ALUOp) 
            2'b00: ALUCtr = 4'b0010;
            2'b01: ALUCtr = 4'b0110;
            2'b10: begin
                case(Funct)
                    6'b100000: ALUCtr = 4'b0010;
                    6'b100010: ALUCtr = 4'b0110;
                    6'b100100: ALUCtr = 4'b0000;
                    6'b100101: ALUCtr = 4'b0001;
                    6'b101010: ALUCtr = 4'b0111;
                    default: ALUCtr = 4'b0010;
                endcase
            end
        endcase
    end
endmodule