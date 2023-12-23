module main_decoder (
	input [6:0] op,
	input   [4:0]   func5,  
	output reg RegWrite, RegWrite_f, ALUSrc, MemWrite, ResultSrc, Branch, fpu_en, fp_in_sel, en_rs2_rd2,
	output reg [1:0] ImmSrc, ALUOp);

always @ (*) begin
	case (op) 
	7'b000_0011: begin     //loadWord
		RegWrite=1'b1;
		RegWrite_f =1'b0;
		en_rs2_rd2 = 1'b0;
		ImmSrc=2'b00;
		ALUSrc=1'b1;
		MemWrite=1'b0;
		ResultSrc=1'b1;
		Branch=1'b0;
		ALUOp=2'b00;
		fpu_en = 1'b0;
		fp_in_sel = 1'b0;
	end

	7'b010_0011: begin     //storeword
		RegWrite=0;
		RegWrite_f =1'b0;
		en_rs2_rd2 = 1'b0;
		ImmSrc=2'b01;
		ALUSrc=1'b1;
		MemWrite=1;
		ResultSrc=1'bX;
		Branch=0;
		ALUOp=2'b00;
		fpu_en = 1'b0;
		fp_in_sel = 1'b0;
	end

	7'b011_0011: begin    //Rtype
		RegWrite=1'b1;
		RegWrite_f =1'b0;
		en_rs2_rd2 = 1'b0;
		ImmSrc=2'bXX;
		ALUSrc=1'b0;
		MemWrite=1'b0;
		ResultSrc=1'b0;
		Branch=1'b0;
		ALUOp=2'b10;
		fpu_en = 1'b0;
		fp_in_sel = 1'b0;
	end

	7'b001_0011: begin  //Itype
		RegWrite=1'b1;
		RegWrite_f =1'b0;
		en_rs2_rd2 = 1'b0;
		ImmSrc=2'b00;
		ALUSrc=1'b1;
		MemWrite=1'b0;
		ResultSrc=1'b0;
		Branch=1'b0;
		ALUOp=2'b10;
		fpu_en = 1'b0;
		fp_in_sel = 1'b0;
	end

	7'b1100011: begin    //branch instructions
		RegWrite=1'b0;
		RegWrite_f =1'b0;
		en_rs2_rd2 = 1'b0;
		ImmSrc=2'b10;
		ALUSrc=1'b0;
		MemWrite=1'b0;
		ResultSrc=1'bX;
		Branch=1'b1;
		ALUOp=2'b01;
		fpu_en = 1'b0;
		fp_in_sel = 1'b0;
	end
////////////////////////

	7'b000_0111: begin     //loadWord fp
 		RegWrite=1'b0;
 		RegWrite_f =1'b1;
 		en_rs2_rd2 = 1'b0;
		ImmSrc=2'b00;
		ALUSrc=1'b1;
		MemWrite=1'b0;
		ResultSrc=1'b1;
		Branch=1'b0;
		ALUOp=2'b00;
		fpu_en = 1'b0;
		fp_in_sel = 1'b0;
	end

	7'b010_0111: begin     //storeword fp
		RegWrite=0;
		RegWrite_f =1'b0;
		en_rs2_rd2 = 1'b1;
		ImmSrc=2'b01;
		ALUSrc=1'b1;
		MemWrite=1;
		ResultSrc=1'bX;
		Branch=0;
		ALUOp=2'b00;
		fpu_en = 1'b0;
		fp_in_sel = 1'b0;
	end





	7'b1010011: begin    //floating point instructions
		
		en_rs2_rd2 = 1'b0;
		ImmSrc=2'bXX;
		ALUSrc=1'b0;
		MemWrite=1'b0;
		ResultSrc=1'b0;
		Branch=1'b0;
		ALUOp=2'b00;
		fpu_en = 1'b1;
		
		if ((func5 == 5'b11100) ||  (func5 == 5'b11000) || (func5 == 5'b10100))  begin   //classify, fcvtws writes into integer reg
			RegWrite=1'b1;
			RegWrite_f =1'b0;
		end
		else begin
			RegWrite=1'b0;
			RegWrite_f =1'b1;
		end


		if((func5 == 5'b11010) || (func5 == 5'b11110))   // fcvt.s.  & fmv.x.w    
			fp_in_sel = 1'b0;
		else 
			fp_in_sel = 1'b1;	
	end	



	default: begin
		RegWrite=0;
		RegWrite_f =1'b0;
		en_rs2_rd2 = 1'b0;
		ImmSrc=2'b00;
		ALUSrc=0;
		MemWrite=0;
		ResultSrc=1'b0;
		Branch=1;
		ALUOp=2'b00;
		fpu_en = 1'b0;
		fp_in_sel = 1'b0;
	end
endcase 

end

endmodule 


