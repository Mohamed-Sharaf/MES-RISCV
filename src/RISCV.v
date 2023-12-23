`include "./FPU/FPU_UNIT.v"


module RISCV (
	input clk, reset);

wire [31:0] PC,
 			INSTR,
  			IMEXT,
  			PCnxt, 
  			Result_int, 
  			Result_f,
  			SrcA, 
  			SrcB, 
  			AluResult, 
  			ReadData, 
  			PCplus4, 
  			PCtarget, 
  			WriteData, 
  			fpu_result,
  			ex_result,
  			fp_in1,
  			fp_out1,
  			fp_out2,
  			WriteData_final,
  			Result;        //execution result (output of ALU or FPU)


wire 		Sign,
 			ALUsrc,
 			WE,
 			PCSrc,
 			Zero, 
 			ResultSrc, 
 			RegWrite,
 			RegWrite_f,
 			OverFlow,
 			fp_in_sel,
 			fpu_en,
 			d_sel,
 			en_rs2_rd2 ;

wire [2:0] AluControl;

wire [1:0] IMMSRC;



instruction_memory IM (
	.pcIM(PC),
	.instr(INSTR));



program_counter pc (
	.PCnext(PCnxt),
	.clk(clk),
	.arst(reset),
	.load(1'b1),
	.PC(PC));



extend ex (
	.immsrc(IMMSRC),
	.instr(INSTR[31:7]),
	.immext(IMEXT));


register_file regfile (
	.A1(INSTR[19:15]),
	.A2(INSTR[24:20]),
	.A3(INSTR[11:7]), 
	.WD3(Result), 
	.WE3(RegWrite), 
	.clk(clk), 
	.arst(reset), 
	.RD1(SrcA), 
	.RD2(WriteData));


register_file fp_regfile (
	.A1(INSTR[19:15]),
	.A2(INSTR[24:20]),
	.A3(INSTR[11:7]), 
	.WD3(Result), 
	.WE3(RegWrite_f), 
	.clk(clk), 
	.arst(reset), 
	.RD1(fp_out1), 
	.RD2(fp_out2));



////

mux2 pcmux (
	.a(PCplus4), 
	.b(PCtarget), 
	.sel(PCSrc), 
	.f(PCnxt));

adder_r pc4 (
	.a(PC), 
	.b(32'd4), 
	.c(PCplus4));


adder_r pct (
	.a(PC), 
	.b(IMEXT), 
	.c(PCtarget));


ALU alu (
	.srcA(SrcA),
	.srcB(SrcB), 
	.ALUcontrol(AluControl), 
	.Zero(Zero), 
	.sign(Sign), 
	.ALUResult(AluResult));


mux2 alu_srcb (
	.a(WriteData),
	.b(IMEXT), 
	.sel(ALUsrc), 
	.f(SrcB));

//////////////////FPU integration edits

FPU_UNIT fpu
(
    .Num_A(fp_in1),
    .Num_B(fp_out2),           				// Number A & B
    .func5(INSTR[31:27]), 
    .rs_2_f1(INSTR[20]),                  // --> add, sub, mul, div, min, max
    .R_M(INSTR[14:12]),                     // --> rounding mode 
    .Result(fpu_result),
    .OverFlow(OverFlow) 
);



mux2 FPU_in (
	.a(SrcA),       			//integer reg file
	.b(fp_out1),        		//fp reg file
	.sel(fp_in_sel),          //0 for integer, 1 for fpu
	.f(fp_in1));


//////////



mux2 ALU_FPU (
	.a(AluResult),       //alu output
	.b(fpu_result),        //fpu output
	.sel(fpu_en),          //0 for alu, 1 for fpu
	.f(ex_result));




///////////
mux2  mux_rs2_rd2
	(
	.a(WriteData),       			//integer reg file
	.b(fp_out2),        		//fp reg file
	.sel(en_rs2_rd2),          //0 for integer, 1 for fpu
	.f(WriteData_final));
///////////



data_memory DM (
	.A(ex_result), 
	.WD(WriteData_final), 
	.clk(clk), 
	.WE(WE), 
	.RD(ReadData));

mux2 WD3 (
	.a(ex_result), 
	.b(ReadData), 
	.sel(ResultSrc), 
	.f(Result));
/////////////////////////////////////

/*demux_f dmux_rd_rs (
	.in1(Result),
	.d_sel(d_sel),
	.rd(Result_int),
	.rs(Result_f));
*/

/////////////////////////////
control_unit cu (
	.op(INSTR[6:0]), 
	.func5(INSTR[31:27]),
	.funct3(INSTR[14:12]), 
	.funct7(INSTR[30]), 
	.Zero(Zero), 
	.sign(Sign), 
	.PCSrc(PCSrc), 
	.ResultSrc(ResultSrc), 
	.MemWrite(WE), 
	.ALUSrc(ALUsrc), 
	.RegWrite(RegWrite),
	.RegWrite_f(RegWrite_f),
	.fpu_en(fpu_en),
	.fp_in_sel(fp_in_sel), 
	.d_sel(d_sel),
	.en_rs2_rd2(en_rs2_rd2),
	.ALUcontrol(AluControl), 
	.ImmSrc(IMMSRC) );


endmodule 