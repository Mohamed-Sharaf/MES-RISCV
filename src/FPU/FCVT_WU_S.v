// convert unsigned integer to single persion floating point
module FCVT_UW_S(
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
	integer i;

always @(*)
begin
	// Extract exponent and fraction fields
        i = 'd0;
	exponent = in_num[30:23];
	mantissa = in_num[22:0];
	shifted_mantissa = 'd0;
	adjusted_exponent = 'd0;
	//special cases
    if (exponent == 'd 126) // if input >=-0.5 and input >=0.5 fractions only
	out_temp = 'd1;
    else if (in_num == 32'hFF800000)  // Negative infinity
        out_temp = 32'hFF800000;
    else if (in_num == 32'h7F800000)  // Positive infinity
        out_temp = 32'h7F800000;
    else if (in_num[30:23] == 8'hFF)  // NaN
        out_temp = 32'hFFC00000;
    else if ( exponent <='d 125)  // Zero and 0.4 to zero and -0.4 and negative fraction numbers <-0.5 and zero
        out_temp = 32'h00000000;

//converting other cases

	else
	begin
        // Adjusted exponent
        adjusted_exponent = exponent - BIAS;
	if (adjusted_exponent > 'd22 ) 
	begin
	out_temp=32'h7F800000; // for numbers that represents in more than 32 bits(overflow) represnt it with positive infinty
	
	end
	else
	begin
	out_temp={31'b0,1'b1};
	
	//mantisssa
        for (i =22; i > (22-adjusted_exponent); i = i - 1) 
         begin
          	out_temp = {out_temp,mantissa[i]};
         end
	shifted_mantissa = mantissa << adjusted_exponent;
	if (shifted_mantissa[22]==1)	
	out_temp = out_temp+1'b1;
	else
	out_temp = out_temp+1'b0;
	end
	end
	out_num=out_temp;
end

endmodule


