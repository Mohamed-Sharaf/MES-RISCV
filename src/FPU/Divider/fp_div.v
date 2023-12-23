module fp_div 
(
    input   [31:0]  Num_A, Num_B,           // Number A & B
    input   [2:0]   R_M,                    // rounding mode
    output  [31:0]  Result,
    output          OverFlow
);

wire            case_Enable;
wire [31:0]     case_out; 
wire [32:0]     vector_out;

wire [7:0]      sel_EA, sel_EB;
wire [23:0]     sel_MA, sel_MB;
wire            EA_sub, EB_sub; 

//////

wire [4:0]  diff;

wire [31:0] out_vec;

//////

wire [7:0]      E_Out;

wire [50:0]     div_result;

wire [23:0]     round_M;

/////

wire [4:0]      lzc_A, lzc_B;

wire [23:0]     shift_A, shift_B;

wire [23:0]     mux_div_MA, mux_div_MB;

// ----------------------------------------------------------------------------

special_case_div    block_case
(
.A(Num_A), 
.B(Num_B),

.Enable(case_Enable),
.S(case_out)
);

// ----------------------------------------------------------------------------

lzc_div_m lzc_div_m_A
(
.data_in(sel_MA),  
.count(lzc_A)
);

lzc_div_m lzc_div_m_B
(
.data_in(sel_MB),  
.count(lzc_B)
);

// ----------------------------------------------------------------------------

shift_left_div shift_left_div_A
(
.data_in(sel_MA),  
.count(lzc_A),
.S(shift_A)
);

shift_left_div shift_left_div_B
(
.data_in(sel_MB),  
.count(lzc_B),
.S(shift_B)
);

// ----------------------------------------------------------------------------

mux_div sel_nor_sub_A
(
.IN_1(sel_MA), 
.IN_2(shift_A),
.Enable(EA_sub),
.out_r(mux_div_MA)
);

mux_div sel_nor_sub_B
(
.IN_1(sel_MB), 
.IN_2(shift_B),
.Enable(EB_sub),
.out_r(mux_div_MB)
);

// ----------------------------------------------------------------------------

selector_div selector_div_u
(
.A(Num_A[30 : 0]), 
.B(Num_B[30 : 0]),
.Enable(case_Enable),      // If enable signal is high it means we do not have a special case
.E_A(sel_EA),
.E_B(sel_EB),
.M_A(sel_MA),
.M_B(sel_MB),
.EA_sub(EA_sub), 
.EB_sub(EB_sub)
);

// ----------------------------------------------------------------------------

exponent_div  exponent_subtraction
(
.EA_IN(sel_EA),
.EB_IN(sel_EB),
.EA_sub(EA_sub), 
.EB_sub(EB_sub),
.count_A(lzc_A), 
.count_B(lzc_B),
.E_Out(E_Out),
.diff(diff),
.overflow(OverFlow)
);

// ----------------------------------------------------------------------------

block_div   divider
(
.MA_IN({mux_div_MA,27'b0}),
.MB_IN({27'b0,mux_div_MB}),

.div_result(div_result)
);

// ----------------------------------------------------------------------------

round_div round_u
(
.S_G(case_out[31]),
.M_IN(div_result),
.R_M(R_M),
// .EA_sub(EA_sub), 
// .EB_sub(EB_sub),
.M_OUT(round_M)
);

// ----------------------------------------------------------------------------

vector_div vector_div_u
(
.S(case_out[31]),              // --> sign
.E(E_Out),              // --> Exponent
.M(round_M),              // --> Mantissa
.N(vector_out)               // --> out vector
);

// ----------------------------------------------------------------------------

stanard     normalization
(
.IN_VEC(vector_out),
.diff(diff), 
.overflow(OverFlow),
.out_vec(out_vec)
);

// ----------------------------------------------------------------------------

mux_fp_div          block_mux_fp
(
.Num_1(case_out), 
.Num_2(out_vec),
.Enable(case_Enable),

.Result(Result)
);

// ----------------------------------------------------------------------------


endmodule