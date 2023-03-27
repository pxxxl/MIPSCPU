module SignedExtended(input [15:0]In, 
                      output reg [31:0]Out);
    always@ (*)
        if(In[15])
            Out <= {16'b1111111111111111, In};
        else
            Out <= {16'b0, In};
endmodule


