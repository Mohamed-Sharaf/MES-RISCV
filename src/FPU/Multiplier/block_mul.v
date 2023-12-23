module block_mul
(
    input  [23:0]     MA_IN,
    input  [23:0]     MB_IN,
    output [47:0]     mul_result
);

assign mul_result = MA_IN * MB_IN;
    
endmodule //block_mul


