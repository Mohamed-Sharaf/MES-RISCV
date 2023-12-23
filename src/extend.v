module extend (
	input [1:0] immsrc, 
	input [31:7] instr, 
	output [31:0] immext);

reg [31:0] immtemp;

always @ (*) 
begin 

case (immsrc)
2'b00: immtemp = {{20{instr[31]}},instr[31:20]};
2'b01: immtemp = {{20{instr[31]}},instr[31:25],instr[11:7]};
2'b10: immtemp = {{20{instr[31]}},instr[7],instr[30:25],instr[11:8],1'b0};
default: immtemp = {32{1'bX}};
endcase 
end
assign immext= immtemp;
endmodule 