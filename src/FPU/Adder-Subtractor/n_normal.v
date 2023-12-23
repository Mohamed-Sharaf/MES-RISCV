module n_normal
(
    input       [36:0]  A, B,
    input               A_S,
    input               sw,
    output              S_A, S_B,               // --> sign A & sign B
    output      [07:0]  E_O,                    // output exponent
    output      [27:0]  M_A,                    // Largest Mantissa
    output      [27:0]  M_B,                    // Shifted Mantissa
    output              Comp,                    // A & B comparison
    output              eq
);

wire [27:0]  M_Shft;
wire [04:0]  D_Exp;

comp_exp n_1
(
.A(A), 
.B(B),
.A_S(A_S),
.sw(sw),
.S_A(S_A), 
.S_B(S_B),               
.E_Max(E_O),                  
.M_Max(M_A),                  
.M_Shft(M_Shft),                 
.D_Exp(D_Exp),                 
.Comp(Comp),
.eq    (eq)

);
    
shift_right n_2
(
.data_in(M_Shft),  
.count(D_Exp),
.S(M_B)
);

endmodule //n_normal
