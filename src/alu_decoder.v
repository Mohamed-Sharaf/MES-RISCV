module alu_decoder (
	input [1:0] alu_op,
	input [2:0] funct3,
	input op5, funct7,
	output [2:0] alu_control);

reg[2:0] alu_temp;

always @ (*) begin
case (alu_op) 

2'b00: alu_temp=3'b000;           //LW, SW
2'b01: alu_temp=3'b010;           //beq, bnq, blt
2'b10: begin 
	if (funct3==3'b001)           //SHL
		alu_temp= 3'b001;

 	else if (funct3==3'b100)      //XOR
 		alu_temp=3'b100;

 	else if (funct3==3'b101)      //SHR
 		alu_temp=3'b101;

 	else if (funct3==3'b110)      //OR
 		alu_temp=3'b110;

 	else if (funct3==3'b111)      //AND
 		alu_temp=3'b111;

 	else if (funct3==3'b000) begin 
 		if ((op5==1'b1)&&(funct7==1'b1))  //subtract
 			alu_temp=3'b010;

 		//else if ((op5==1'b0) ||(op5==1'b1 && funct7==1'b0))    //add
 		//	alu_temp=3'b000;
 		else 
 			alu_temp=3'b000;	
 	end
 	else 
 	alu_temp=3'b000;
 	end 

default: alu_temp=3'b000;
endcase

end
assign alu_control=alu_temp;
endmodule