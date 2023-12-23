module fp_min_max
(
    input   [31:0]  Num_A, Num_B,           // Number A & B
    input           O_P,                    // 0 --> min , 1 --> max
    output  [31:0]  Result
);
    
wire C, comp;

wire       S_A = Num_A[31];             // --> sign A
wire       S_B = Num_B[31];             // --> sign B

wire [7:0] E_A = Num_A[30:23] ;         // E_A --> exponent of input A
wire [7:0] E_B = Num_B[30:23] ;         // E_B --> exponent of input B

wire [22:0] M_A = Num_A[22:0] ;         // M_A --> Mantissa of input A
wire [22:0] M_B = Num_B[22:0] ;         // M_B --> Mantissa of input B

assign C = (S_A < S_B) ? 1                         
        : (S_A > S_B) ? 0                          
        : (E_A > E_B) ? 1                          // Exponent A > Exponent B
        : (E_A < E_B) ? 0                          // Exponent B > Exponent A
        : (M_A < M_B) ? 0                          // Exponent A = Exponent B --> Mantissa B > Mantissa A
        : 1;                                       // Exponent A = Exponent B --> Mantissa A >= Mantissa B

assign comp = (S_A & S_B)? !C: C;

assign Result = (comp ^ O_P)? Num_B: Num_A;

endmodule //fp_min_max
