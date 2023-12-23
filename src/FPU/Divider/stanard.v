module stanard
(
    input   [32:0]      IN_VEC,
    input   [04:0]      diff, 
    input               overflow,
    output  [31:0]      out_vec
);

wire    [23:0]  data_in = IN_VEC[23:0];

wire    [23:0]  shft_LM, shft_RM;

wire    [4:0] count;

wire    [7:0] shft_l;
    
assign out_vec[31] = IN_VEC[32];

assign shft_l =  IN_VEC[31:24] - count;

assign shft_LM = IN_VEC[23:0] << count;

assign shft_RM = IN_VEC[23:0] >> (diff + 1'b1);

assign out_vec[30:23]   = (overflow)? 0 : shft_l;

assign out_vec[22:0]    = (overflow)? shft_RM[22:0] : shft_LM[22:0];

integer i;
reg [4:0] leading_zeros;
reg       first_bit;

always @(*) begin
    leading_zeros = 5'b10111; // Initialize to all ones (no leading zeros)
    first_bit = data_in[23];

    for (i = 23; i >= 0; i = i - 1) begin
        if ((data_in[i] == 1'b1) & (first_bit == 1'b0)) begin
            leading_zeros = 5'b10111 - i; // Count leading zeros
            first_bit = 1'b1;
        end
    end
end

assign count = (data_in[23]) ? 0 : leading_zeros;

endmodule //stanard


