module norm_vector
(
    input           N_S,            // --> sign
    input   [07:0]  N_E,            // --> Exponent
    input   [27:0]  N_M,            // --> Mantissa
    input           Co,             // --> Carry in
    input   [2:0]   R_M,            // --> rounding mode 
    input           eq,
    output  [31:0]  N               // --> out vector
);
    
wire  [07:0]  Norm_E;
wire  [22:0]  Norm_M;

block_norm standardize
(
.S_G(N_S),
.Co(Co),
.eq(eq),
.E_S(N_E),
.M_S(N_M),
.R_M(R_M),        // rounding mode 
.E(Norm_E),
.M(Norm_M)
);

vector      regroup
(
.S(N_S),              // --> sign
.E(Norm_E),              // --> Exponent
.M(Norm_M),              // --> Mantissa
.N(N)               // --> out vector
);

endmodule //norm_vector


