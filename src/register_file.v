module register_file (
	input [4:0] A1, A2, A3,
	input [31:0] WD3,
	input WE3, clk, arst,
	output [31:0] RD1, RD2);

reg [31:0] reg_file [0:31];
integer i;

always @ (posedge clk or negedge arst)
begin
if (arst==0) begin 
for (i=0; i<32; i=i+1)
reg_file[i]<=0;
end

else if (WE3)
reg_file[A3] <= WD3;

end

assign RD1 = reg_file [A1];
assign RD2 = reg_file [A2];

endmodule
