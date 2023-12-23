module control_unit (
	input [6:0] op,
	input [2:0] funct3,
	input   [4:0]   func5,
	input funct7, Zero, sign,
	output reg PCSrc,
	output ResultSrc, MemWrite, ALUSrc, RegWrite, RegWrite_f, fpu_en, fp_in_sel, d_sel, en_rs2_rd2,
	output [2:0] ALUcontrol, 
	output [1:0] ImmSrc);

wire Branch;
wire [1:0] ALUOp;

main_decoder MD (op, func5, RegWrite, RegWrite_f, ALUSrc, MemWrite, ResultSrc, Branch, fpu_en, fp_in_sel, en_rs2_rd2, ImmSrc, ALUOp);
alu_decoder ALUD (ALUOp, funct3, op[5], funct7, ALUcontrol);




always @ (*)
case (funct3)
3'b000: PCSrc=Branch & Zero;            //beq instruction
3'b001: PCSrc=Branch & (~Zero);         //bnq instruction
3'b100: PCSrc=Branch & sign;            //blt instruction
default: PCSrc=0;
endcase

endmodule