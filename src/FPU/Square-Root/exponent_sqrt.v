module exponent_sqrt
(
    input  [7:0]      EA_IN,
    input             EA_sub,
    input  [4:0]      count_A,
    output [7:0]      E_Out
);

wire [8:0] temp;

assign temp     = (EA_sub)? (EA_IN + 8'd127) : (8'd127 - count_A);
    
assign E_Out    = temp >> 1'b1;

endmodule //exponent_mul


