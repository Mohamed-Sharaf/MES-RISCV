module vector_mul
(
    input           S,              // --> sign
    input   [07:0]  E,              // --> Exponent
    input   [22:0]  M,              // --> Mantissa
    output  [31:0]  N               // --> out vector
);
    
assign N = {S,E,M};

endmodule //vector_mul
