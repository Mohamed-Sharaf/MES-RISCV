module data_memory (
	input [31:0] A, WD,
	input clk, WE, 
	output [31:0] RD);

reg [31:0] data_mem [0: 63];

always @(posedge clk) 
	if (WE) 
	data_mem[A] <= WD;

assign RD =  data_mem [A]; 	

endmodule