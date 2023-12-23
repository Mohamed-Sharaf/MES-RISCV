module stanard_mul
(
    input   [7:0]       E_IN,
    input   [47:0]      mul_in,
    input   [5:0]       count,
    output   [7:0]       E_Out,
    output   [47:0]      mul_out
);

assign E_Out = E_IN - count;

assign mul_out = mul_in << count;

endmodule //stanard


