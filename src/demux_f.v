module demux_f (
	input [31:0]  in1,
	input d_sel,
	output [31:0] rd, rs);


assign rd = (d_sel == 1'b0)? in1: 32'bx;
assign rs = (d_sel == 1'b1)? in1: 32'bx;

endmodule