module program_counter (
	input [31:0] PCnext,
	input clk, arst, load,
	output reg [31:0] PC);

always @(posedge clk or negedge arst) begin
	if (arst==0) begin
	PC<=0;
	end
	else if (load) begin
		PC<= PCnext;
	end
end

endmodule