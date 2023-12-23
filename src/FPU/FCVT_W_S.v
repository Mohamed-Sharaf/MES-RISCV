// convert signed integer to single persion floating point
module FCVT_W_S (
    input wire [31:0] in_num,
    output reg [31:0] out_num
);
//parameters and internal signals
	localparam BIAS = 127;
	reg [7:0] exponent;
	reg [22:0] mantissa;
	reg [7:0] adjusted_exponent;
	reg [22:0] shifted_mantissa;
	reg [31:0] out_temp;
	reg sign;
	integer i;

always @(*)
begin
	// Extract exponent and fraction fields
	sign = in_num [31];
	exponent = in_num[30:23];
	mantissa = in_num[22:0];
	shifted_mantissa = 'd0;
	i = 'd0;
        // Adjusted exponent
        adjusted_exponent = exponent - BIAS;
		 // Check for special cases
 if (in_num == 32'hFF800000)  // Negative infinity
        out_temp = 32'hFF800000;
    else if (in_num == 32'h7F800000)  // Positive infinity
        out_temp = 32'h7F800000;
    else if (in_num[30:23] == 8'hFF)  // NaN
        out_temp = 32'hFFC00000;
    else if (in_num == 32'h00000000)  // Zero
        out_temp = 32'h00000000;
    else if ( exponent <='d 125)  // Zero and 0.4 to zero and -0.4 and negative fraction numbers <-0.5 and zero
        out_temp = 32'h00000000;
    else if (exponent == 'd 126 ) // if input >=-0.5 and input >=0.5 fractions only
	begin
	out_temp = 'd1;
		if (sign)
		out_temp=~out_temp+1'b1;
		else
		out_temp=out_temp+1'b0;
	end

    else
	begin
	if (adjusted_exponent > 'd22 ) // for numbers that represents in more than 32 bits(overflow)
	begin
		
	if (sign)// Negative infinity
        out_temp = 32'hFF800000;
	else// Positive infinity
        out_temp = 32'h7F800000;
	end
	else
	begin
	out_temp={31'b0,1'b1};
	
//mantissa
        for (i =22; i > (22-adjusted_exponent); i = i - 1) 
         begin
           out_temp = {out_temp,mantissa[i]};
          end
	shifted_mantissa = mantissa << adjusted_exponent;
//rounding
	if (shifted_mantissa[22]==1)	
	out_temp = out_temp+1'b1;
	else
	out_temp = out_temp+1'b0;
//adjusting the number if negative or positive
	if (sign)
	out_temp=~out_temp+1'b1;
	else
	out_temp=out_temp+1'b0;
end
end
out_num=out_temp;
end

endmodule

