`include "./Adder-Subtractor/fp_add_sub.v"
`include "./Divider/fp_div.v"
`include "./Multiplier/fp_mul.v"
`include "./Square-Root/fp_sqrt.v"


module FPU_UNIT
(
    input   [31:0]  Num_A, Num_B,           // Number A & B
    input   [4:0]   func5,                  // --> add, sub, mul, div, min, max
    input           rs_2_f1,
    input   [2:0]   R_M,                    // --> rounding mode 
    output  [31:0]  Result,
    output          OverFlow 
);

wire [31:0]     Result_IN_1, 
                Result_IN_2,    
                Result_IN_3, 
                Result_IN_4,
                Result_IN_5,
                Result_IN_6,
                Result_IN_7,
                Result_IN_8,
                Result_IN_9,
                Result_IN_10,
                Result_IN_11;

wire            IN_2_OFlow, 
                IN_3_OFlow;
    
///////////////////////////

fp_add_sub          IN_1
(
.Num_A(Num_A), 
.Num_B(Num_B),           // Number A & B
.A_S(func5[0]),                    // 0 --> add , 1 --> sub
.R_M(R_M),                    // --> rounding mode 
.Result(Result_IN_1) 
);

//////////////////////////

fp_mul              IN_2
(
.Num_A(Num_A), 
.Num_B(Num_B),           // Number A & B
.R_M(R_M),        // rounding mode 
.Result(Result_IN_2),
.OverFlow(IN_2_OFlow)
);

///////////////////////////

fp_div              IN_3
(
.Num_A(Num_A), 
.Num_B(Num_B),           // Number A & B
.R_M(R_M),                    // rounding mode
.Result(Result_IN_3),
.OverFlow(IN_3_OFlow)
);

/////////////////////////////

fp_min_max          IN_4
(
.Num_A(Num_A), 
.Num_B(Num_B),           // Number A & B
.O_P(R_M[0]),                    // 0 --> min , 1 --> max
.Result(Result_IN_4)
);

/////////////////////////////

fp_sqrt             IN_5
(
.Num_A(Num_A),      // Number A 
.R_M(R_M),        // rounding mode 
.Result(Result_IN_5)
);

/////////////////////////////

fp_comp             IN_6
(
.Num_A(Num_A), 
.Num_B(Num_B),     // Number A & B
.rm(R_M[1:0]),           //000 LTE , 001 LT , 010 EQ

.Result(Result_IN_6)
);

/////////////////////////////

fp_mv_class         IN_7
(
.A(Num_A),
.op(R_M[0]),          // rm[0] || 0 --> mv_x_w || 1 --> class
.S(Result_IN_7)
);

/////////////////////////////

fp_mv               IN_8
(
.input_w(Num_A),
.output_x(Result_IN_8)
);

/////////////////////////////

// 00100

fp_sign             IN_9            
(
.a(Num_A),       // Floating-point number A
.b(Num_B),       // Floating-point number B
.R_M(R_M[1:0]),      // 000 --> fsgnj.s  || 001  --> fsgnjn.s  || 010 --> fsgnjx.s
.result(Result_IN_9)
);

/////////////////////////////

// 11000

fp_float_int        IN_10
(
.input_int(Num_A),
.op(rs_2_f1),                  // 0 --> convert_int_fp_signed || 1 --> convert_int_fp_unsigned
.output_fp(Result_IN_10)
);

///////////////////////////

// 11010

fp_int_float        IN_11
(
.input_float(Num_A),
.op(rs_2_f1),                  // 0 --> convert_fp_int_signed || 1 --> convert_fp_int_unsigned
.output_integer(Result_IN_11)
);

///////////////////////////

op_mux              out_res
(
.IN_1(Result_IN_1), 
.IN_2(Result_IN_2), 
.IN_3(Result_IN_3), 
.IN_4(Result_IN_4),
.IN_5(Result_IN_5),
.IN_6(Result_IN_6),
.IN_7(Result_IN_7),
.IN_8(Result_IN_8),
.IN_9(Result_IN_9),
.IN_10(Result_IN_10),
.IN_11(Result_IN_11),

.IN_2_OFlow(IN_2_OFlow),
.IN_3_OFlow(IN_3_OFlow),
.sel(func5),
.Result(Result),
.OverFlow(OverFlow)
);

endmodule //FPU_UNIT
