module lzc_mul
(
    input   [47:0]  data_in,  
    output  [5:0]   count
);
    
integer i;
reg [5:0] leading_zeros;
reg       first_bit;

always @(*) begin
    leading_zeros = 6'b101111; // Initialize to all ones (no leading zeros)
    first_bit = data_in[47];

    for (i = 47; i >= 0; i = i - 1) begin
        if ((data_in[i] == 1'b1) & (first_bit == 1'b0)) begin
            leading_zeros = 6'b101111 - i; // Count leading zeros
            first_bit = 1'b1;
        end
    end
end

assign count = (data_in[47]) ? 0 : leading_zeros;

endmodule