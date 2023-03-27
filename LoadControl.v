module LoadControl(
    input [2:0]LoadSignal,
    input [31:0]In,

    output reg [31:0]Out 
);
// LoadSignal:
// 000: Out = 0 (Unable)
// 001: Out = In (lw)
// 010: Out = {24'b0, In[7:0]} (lbu)
// 011: Out = {16'b0, In[15:0]} (lhu)
// 100: Out = {{24{In[7]}}, In[7:0]} (lb)
// 101: Out = {{16{In[15]}}, In[15:0]} (lh)
    always@(*) begin
        case(LoadSignal)
            3'b000: Out = 32'b0;
            3'b001: Out = In;
            3'b010: Out = {24'b0, In[7:0]};
            3'b011: Out = {16'b0, In[15:0]};
            3'b100: Out = {{24{In[7]}}, In[7:0]};
            3'b101: Out = {{16{In[15]}}, In[15:0]};
            default: Out = 32'b0;
        endcase
    end
endmodule