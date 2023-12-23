module ALU (
	input [31:0] srcA, srcB,
	input [2:0] ALUcontrol,
	output Zero, sign,
	output [31:0] ALUResult);

reg [31:0] result;

always @ (*) begin
	case (ALUcontrol) 
	3'b000: result = srcA + srcB;
	3'b001: result = srcA << srcB;
	3'b010: result = srcA - srcB;
	3'b100: result = srcA ^ srcB;
	3'b101: result = srcA >> srcB;
	3'b110: result = srcA | srcB;
	3'b111: result = srcA & srcB;
	default: result= 0;
	endcase 

end

assign ALUResult=result;
assign Zero = (result==0)?1:0;
assign sign= result[31];
endmodule