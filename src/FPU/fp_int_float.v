module fp_int_float
(
    input       [31:0] input_float,
    input              op,                  // 0 --> convert_fp_int_signed || 1 --> convert_fp_int_unsigned
    output      [31:0] output_integer
);
    
wire [31:0] temp_out1, temp_out2;

fcvt_s_w        convert_fp_int_signed
(
.in_num(input_float),
.out_num(temp_out1)
);

/////////////////////////////////////////////

fcvt_s_wu       convert_fp_int_unsigned

(
.in_num(input_float),
.out_num(temp_out2)
);

////////////////////////////////////////////

assign output_integer = (op)? temp_out2: temp_out1;

endmodule //fp_int_float


