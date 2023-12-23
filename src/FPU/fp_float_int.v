module fp_float_int
(
    input       [31:0] input_int,
    input              op,                  // 0 --> convert_int_fp_signed || 1 --> convert_int_fp_unsigned
    output      [31:0] output_fp
);
    
wire [31:0] temp_out1, temp_out2;


FCVT_W_S        convert_int_fp_signed
(
.in_num(input_int),
.out_num(temp_out1)
);

/////////////////////////////////////////////

FCVT_UW_S       convert_int_fp_unsigned
(
.in_num(input_int),
.out_num(temp_out2)
);
////////////////////////////////////////////

assign output_fp = (op)? temp_out2: temp_out1;

endmodule //fp_float_int


