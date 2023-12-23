module pre_sqrt
(
    input   [7:0]       E_IN,
    input   [23:0]      M_IN,
    output  [7:0]       E_OUT,
    output  [23:0]      M_OUT
);

assign E_OUT = (E_IN[0])? (E_IN + 1'b1) : E_IN;

// assign S_out[30:23] = IN[30:23];

assign M_OUT = (E_IN[0])? (M_IN >> 1'b1) : M_IN ;

// assign S_out[22:0]  = IN[22:0];

endmodule //pre_sqrt


