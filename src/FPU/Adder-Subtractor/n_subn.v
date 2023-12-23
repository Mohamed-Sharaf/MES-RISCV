module n_subn 
(
    input       [36:0]  A, B,
    output              S_A, S_B,               // --> sign A & sign B
    output      [07:0]  E_O,                    // output exponent
    output reg     [27:0]  M_A,                    // Mantissa A
    output reg  [27:0]  M_B,                    // Mantissa B 
    output reg          Comp                    // comparison
);
    
assign S_A = A[36];                 // --> sign A
assign S_B = B[36];                 //     sign B

assign E_O = A[35:28] ; 

// assign M_A = A[27:0] ;              // M_A --> Mantissa of input A
// assign M_B = B[27:0] ;              // M_B --> Mantissa of input B

// assign Comp = (B[27:0] > A[27:0]) ? 1'b0    // B > A
//             : 1'b1;                         // A >= B


always @ (*) begin

    if (B[27:0] > A[27:0]) begin
        Comp = 1'b0;
        M_A = B[27:0];
        M_B = A[27:0];
    end

    else begin
        Comp = 1'b1;
        M_A = A[27:0];
        M_B = B[27:0]; 
    end

end


endmodule