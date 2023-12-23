module lzc_div_m 
(
    input   [23:0]  data_in,  
    output  [4:0]   count
);
    
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

endmodule