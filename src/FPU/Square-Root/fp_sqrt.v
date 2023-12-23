module fp_sqrt
(
    input   [31:0]  Num_A,      // Number A 
    input   [2:0]   R_M,        // rounding mode 
    output  [31:0]  Result
);
    
wire            case_Enable;
wire [31:0]     case_out, vector_out;

wire [7:0]      sel_EA;
wire [23:0]     sel_MA;

wire [4:0]      lzc_A;

wire [23:0]     shift_A;

wire [23:0]     mux_sqrt_M;

wire [7:0]      pre_EA;
wire [23:0]     pre_MA;

wire [7:0]      E_Out;

wire [47:0]     sqrt_result;

wire [22:0]     round_M;

wire            EA_sub;  

// ----------------------------------------------------------------------------

special_case_sqrt   sqrt_case
(
.A(Num_A),
.Enable(case_Enable),
.S(case_out)
);

// ----------------------------------------------------------------------------

selector_sqrt    sqrt_selector
(
.A(Num_A[30:0]),
.Enable(case_Enable),      // If enable signal is high it means we do not have a special case
.E_A(sel_EA),
.M_A(sel_MA),
.EA_sub(EA_sub)
);

// ----------------------------------------------------------------------------

lzc_sqrt lzc_sqrt
(
.data_in(sel_MA),  
.count(lzc_A)
);

// ----------------------------------------------------------------------------

shift_left_sqrt shift_left_sqrtm
(
.data_in(sel_MA),  
.count(lzc_A),
.S(shift_A)
);

// ----------------------------------------------------------------------------

mux_sqrt    norm_or_sub_A
(
.IN_1(sel_MA), 
.IN_2(shift_A),
.Enable(EA_sub),
.out_r(mux_sqrt_M)
);

// ----------------------------------------------------------------------------

pre_sqrt        pre_sqrt
(
.E_IN(sel_EA),
.M_IN(mux_sqrt_M),
.E_OUT(pre_EA),
.M_OUT(pre_MA)
);

// ----------------------------------------------------------------------------

exponent_sqrt   sqrt_exponent
(
.EA_IN(pre_EA),
.EA_sub(EA_sub),
.count_A(lzc_A),
.E_Out(E_Out)
);

// ----------------------------------------------------------------------------

sqrt        sqrt
(
.IN(pre_MA),
.OUT(sqrt_result)
);

// ----------------------------------------------------------------------------

round_sqrt      sqrt_round
(
.S_G(case_out[31]),
.M_IN(sqrt_result),
.R_M(R_M),        // rounding mode 
.M_OUT(round_M)
);

// ----------------------------------------------------------------------------

vector_sqrt     sqrt_vector
(
.S(case_out[31]),              // --> sign
.E(E_Out),              // --> Exponent
.M(round_M),              // --> Mantissa
.N(vector_out)               // --> out vector
);

// ----------------------------------------------------------------------------

mux_fp_sqrt             sqrt_final_mux
(
.Num_1(case_out), 
.Num_2(vector_out),
.Enable(case_Enable),
.Result(Result)
);

// ----------------------------------------------------------------------------


endmodule //fp_sqrt


