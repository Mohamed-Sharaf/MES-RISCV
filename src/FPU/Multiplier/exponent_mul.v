module exponent_mul
(
    input  [7:0]      EA_IN,
    input  [7:0]      EB_IN,
    output [7:0]      E_Out,
    output            overflow
);
    
assign {overflow, E_Out} = EA_IN + EB_IN - 8'd126;

endmodule //exponent_mul


