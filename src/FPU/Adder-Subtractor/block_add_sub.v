module block_add_sub
(
    input               S_A, S_B,               // sign A & sign B
    input   [27:0]      A_IN,                   // Greatest Mantissa 
    input   [27:0]      B_IN,
    input               Comp,                   // Determine the largest Number
    input               A_S,                    // 0 --> Add , 1 --> Sub 
    output              S_O,                    // sign ouput
    output  [27:0]      SUM,
    output              CARRY 
);
    
wire [27:0] MA_O, MB_O;
wire        AS, CARRY_wire;

sign_out block_sign
(
.S_A(S_A), 
.S_B(S_B),                    // sign A & sign B
 
.MA_IN(A_IN),                  // Greatest Mantissa 
.MB_IN(B_IN),

.Comp(Comp),                   // Determine the largest Number

.A_S(A_S),                    // 0 --> Add , 1 --> Sub 

.S_O(S_O),                    // sign ouput

.MA_O(MA_O),
.MB_O(MB_O),

.AS(AS)
);

adder    add_sub
(
.A(MA_O), 
.B(MB_O),
.AS(AS),
.SU(SUM),
.CA(CARRY_wire)
);

// --------------------------------------------------------------------

// assign SUM = ((AS & S_O) == 1'b1) ?  (SUM_wire ^ 28'hfffffff) + 1'b1
//             : SUM_wire;

assign CARRY = ((S_B ^ A_S) != S_A) ? 0 
             : CARRY_wire;

// --------------------------------------------------------------------

endmodule //block_add_sub


