module fp_add_sub 
(
    input   [31:0]  Num_A, Num_B,           // Number A & B
    input           A_S,                    // 0 --> add , 1 --> sub
    input   [2:0]   R_M,                    // --> rounding mode 
    output  [31:0]  Result 
);

wire            case_Enable, eq;
wire [31:0]     case_out, vector_out; 

wire            pre_S_A, pre_S_B, pre_Comp;
wire [27:0]     pre_MA, pre_MB;
wire [07:0]     pre_E;

wire            adder_S_O;                    // sign ouput from adder subtractor block
wire  [27:0]    adder_SUM;
wire            adder_CARRY;
// ----------------------------------------------------------------------------

special_case    block_case
(
.A(Num_A), 
.B(Num_B),

.Enable(case_Enable),
.S(case_out)
);

// ----------------------------------------------------------------------------

pre_adder       block_pre_adder
(
.A(Num_A), 
.B(Num_B),
.A_S(A_S),

.Enable(case_Enable),

.S_A(pre_S_A), 
.S_B(pre_S_B),               // sign A & sign B

.C(pre_Comp),                      // Comparison
.E_Out(pre_E),                  // Output Exponent
.MA_Out(pre_MA),                 // Greatest Mantissa 
.MB_Out(pre_MB),                  // Shifted Mantissa 
.eq(eq));

// ----------------------------------------------------------------------------

block_add_sub   block_adder
(
.S_A(pre_S_A), 
.S_B(pre_S_B),               // sign A & sign B

.A_IN(pre_MA),                   // Greatest Mantissa 
.B_IN(pre_MB),

.Comp(pre_Comp),                   // Determine the largest Number
.A_S(A_S),                    // 0 --> Add , 1 --> Sub 
   
.S_O(adder_S_O),                    // sign ouput
.SUM(adder_SUM),
.CARRY(adder_CARRY) 
);
    
// ----------------------------------------------------------------------------

norm_vector     block_norm_vector
(
.N_S(adder_S_O),            // --> sign
.N_E(pre_E),            // --> Exponent
.N_M(adder_SUM),            // --> Mantissa
.Co(adder_CARRY),             // --> Carry in
.R_M(R_M),            // --> rounding mode 
.eq(eq),
.N(vector_out)               // --> out vector
);

// ----------------------------------------------------------------------------

mux_fp          block_mux_fp
(
.Num_1(case_out), 
.Num_2(vector_out),
.Enable(case_Enable),

.Result(Result)
);

// ----------------------------------------------------------------------------


endmodule