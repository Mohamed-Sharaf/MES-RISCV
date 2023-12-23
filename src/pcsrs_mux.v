module pcsrs_mux (
	input [2:0] funct3, 
	input branch, zero, sign,
	output reg pcsrc);

always @ (*)
case (funct3)
3'b000: pcsrc=branch & zero;            //beq instruction
3'b001: pcsrc=branch & (~zero);         //bnq instruction
3'b100: pcsrc=branch & sign;            //blt instruction
default: pcsrc=0;
endcase

endmodule