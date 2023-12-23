module fp_mv_class
(
    input   [31 : 0]   A,
    input              op,          // rm[0] || 0 --> mv_x_w || 1 --> class
    output  [31 : 0]   S
);

wire    [31 : 0] temp_out;

fp_class        classify
(
.A(A),
.S(temp_out)
);
    
assign S = (op)? temp_out: A;

endmodule //fp_mv_class


