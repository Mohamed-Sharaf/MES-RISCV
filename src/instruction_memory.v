module instruction_memory (
	input [31:0] pcIM,
	output[31:0] instr);

reg [31:0] inst_mem [0:63];

initial begin
//$readmemh("Fibonacci_program.txt",inst_mem) ;
// $readmemh("Factorial_Machine_Code.txt", inst_mem);
// $readmemh("GCD.txt",inst_mem) ;
$readmemh("float_inst.txt",inst_mem) ;
end

assign instr=inst_mem [pcIM[31:2]];     //word aligned
endmodule