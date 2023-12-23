module vector_div
(
    input           S,              // --> sign
    input   [07:0]  E,              // --> Exponent
    input   [23:0]  M,              // --> Mantissa
    output  [32:0]  N               // --> out vector
);
    
assign N = {S,E,M};

endmodule //vector_div
