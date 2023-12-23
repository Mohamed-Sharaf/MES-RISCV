module comp 
(
    input       [36:0] A, B,
    output  reg        sw,
    output  reg [36:0] N_A, N_B         // N_A --> Normal number, N_B --> SubNormal number
);

wire [7:0] E_A = A[35:28] ;         // E_A --> exponent of input A
wire [7:0] E_B = B[35:28] ;         // E_B --> exponent of input B

always @(A, B, E_A, E_B) begin

    if (E_A == 8'h00) begin
        N_A = B;
        N_B = A;
        sw  = 1'b1;
    end
    else if (E_B == 8'h00) begin
        N_A = A;
        N_B = B;
        sw  = 1'b0;
    end
    else begin
        N_A = A;
        N_B = B;
        sw  = 1'b0;
    end
    
end
    
endmodule //comp
