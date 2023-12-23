module exponent_div
(
    input  [7:0]      EA_IN,
    input  [7:0]      EB_IN,
    input             EA_sub, EB_sub,
    input  [4:0]      count_A, count_B,
    output [7:0]      E_Out,
    output [4:0]      diff,
    output            overflow
);
    
wire [7:0] EA, EB;

wire       positive, negative;

wire [7:0] sub;

wire [8:0] sho;

assign sub = EA_IN - EB_IN;

assign sho = EA_IN + 8'b01111111;

assign negative = EB_IN > (sho);

assign positive = ((sub) > 8'b01111111) & (EA_IN > EB_IN);

assign EA = (EA_sub)? EA_IN : (EA_IN - count_A + 1'b1);

assign EB = (EB_sub)? EB_IN : (EB_IN - count_B + 1'b1);

assign overflow = (positive | negative)? 1 : 0;

assign diff     = EB_IN - EA_IN - 8'b01111111;

assign E_Out    = EA - EB + 8'b01111111;

endmodule //exponent_div


