module fp_mul 
(
    input   [31:0]  Num_A, Num_B,           // Number A & B
    input   [2:0]   R_M,        // rounding mode 
    output  [31:0]  Result,
    output          OverFlow
);

wire            case_Enable;
wire [31:0]     case_out, vector_out;

wire [7:0]      sel_EA, sel_EB;
wire [23:0]     sel_MA, sel_MB;

wire [7:0]      E_Out, E_O;

wire [47:0]     mul_result, mul_out;

wire [22:0]     round_M;

wire [5:0]      count;

// ----------------------------------------------------------------------------

special_case_mul    block_case
(
.A(Num_A), 
.B(Num_B),

.Enable(case_Enable),
.S(case_out)
);

// ----------------------------------------------------------------------------

selector_mul selector_mul_u
(
.A(Num_A[30 : 0]), 
.B(Num_B[30 : 0]),
.Enable(case_Enable),      // If enable signal is high it means we do not have a special case
.E_A(sel_EA),
.E_B(sel_EB),
.M_A(sel_MA),
.M_B(sel_MB)
);

// ----------------------------------------------------------------------------

exponent_mul  exponent_mul_add
(
.EA_IN(sel_EA),
.EB_IN(sel_EB),
.E_Out(E_Out),
.overflow(OverFlow)
);

// ----------------------------------------------------------------------------

block_mul   multiplier
(
.MA_IN(sel_MA),
.MB_IN(sel_MB),
.mul_result(mul_result)
);

// ----------------------------------------------------------------------------

lzc_mul     count_mul
(
.data_in(mul_result),  
.count(count)
);

// ----------------------------------------------------------------------------

stanard_mul stanard_mul
(
.E_IN(E_Out),
.mul_in(mul_result),
.count(count),
.E_Out(E_O),
.mul_out(mul_out)
);

// ----------------------------------------------------------------------------

round_mul round_u
(
.S_G(case_out[31]), 
.M_IN(mul_out),
.R_M(R_M),        // rounding mode 
.M_OUT(round_M)
);

// ----------------------------------------------------------------------------

vector_mul vector_mul_u
(
.S(case_out[31]),              // --> sign
.E(E_O),              // --> Exponent
.M(round_M),              // --> Mantissa
.N(vector_out)               // --> out vector
);

// ----------------------------------------------------------------------------

mux_fp_mul          block_mux_fp
(
.Num_1(case_out), 
.Num_2(vector_out),
.Enable(case_Enable),

.Result(Result)
);

// ----------------------------------------------------------------------------


endmodule