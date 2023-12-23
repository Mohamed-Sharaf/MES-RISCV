//convert single persion floating point to unsigned number
module fcvt_s_w (
    input [31:0] in_num,
    output reg [31:0] out_num
);
//internal signals
    reg [7:0] exponent;
    reg [22:0] mantissa;
    reg [31:0] input_adj;
    reg [31:0] out_temp,mantissa_temp;

    wire [4:0] count;

    always @(*)
     begin
	///initialization
	out_temp = 32'b0;
	mantissa_temp ='d0;
    exponent = 0;
	
    // Check for special cases
    if (in_num == 32'hFF800000)  // Negative infinity
        out_temp = 32'hFF800000;
    else if (in_num == 32'h7F800000)  // Positive infinity
        out_temp = 32'h7F800000;
    else if (in_num == 32'h7FC00000)  // NaN
        out_temp = 32'h7FC00000;
    else if (in_num == 32'h00000000)  // Zero
        out_temp = 32'h00000000;
	//convertaiong any case
    else
	begin

    if (in_num[31]) begin
        input_adj = (~in_num) + 1'b1;
    end 
    else begin
        input_adj = in_num;
    end
    mantissa_temp = input_adj << count;

	//rounding
	if (mantissa_temp[8] == 1)
	mantissa = mantissa_temp[31:9]+1'b1;
	else
	mantissa = mantissa_temp[31:9];

        exponent = 159 - count; // Bias for single precision   // 158 = 127 + 32  || 32 --> number of input bits with sign bit(32)
        // Combine the components to form the IEEE 754 representation
        out_temp = {in_num[31], exponent, mantissa};
	end
	out_num = out_temp;
	exponent = out_num[30:23];
	mantissa =out_num[22:0];
    end

    integer j;
    reg [4:0] leading_zeros;
    reg       first_bit;
    
    always @(*) begin
        leading_zeros = 5'b11111; // Initialize to all ones (no leading zeros)
        first_bit = input_adj[31];
    
        for (j = 31; j >= 0; j = j - 1) begin
            if ((input_adj[j] == 1'b1) & (first_bit == 1'b0)) begin
                leading_zeros = 5'b11111 - j; // Count leading zeros
                first_bit = 1'b1;
            end
        end
    end
    
    assign count = (input_adj[31]) ? 1'b1 : leading_zeros + 1'b1;

endmodule

