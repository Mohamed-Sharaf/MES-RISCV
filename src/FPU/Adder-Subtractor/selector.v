module selector
(
    input   [31 : 0]   A, B,
    input              Enable,      // If enable signal is high it means we do not have a special case
    output  [36 : 0]   N_A, N_B,
    output  [01 : 0]   E_Data
);
    
wire       S_A = A[31] ;            // S_A --> sign of input A
wire       S_B = B[31] ;            // S_A --> sign of input B

wire [7:0] E_A = A[30:23] ;         // E_A --> exponent of input A
wire [7:0] E_B = B[30:23] ;         // E_B --> exponent of input B

wire [22:0] M_A = A[22:0] ;         // M_A --> mantissa of input A
wire [22:0] M_B = B[22:0] ;         // M_B --> mantissa of input B

// *******************************&&%&%&&******************************

assign N_A[36] = (Enable)? S_A : 0;

assign N_A[35:28] = (Enable)? E_A : 0;

assign N_B[36] = (Enable)? S_B : 0;

assign N_B[35:28] = (Enable)? E_B : 0;

//

assign N_A[27] = (Enable)? ((E_A == 0)? 1'b0 : 1'b1 ) : 0;

assign N_A[26:4] = (Enable)? M_A : 0;

assign N_A[3:0] = 0;

// 

assign N_B[27] = (Enable)? ((E_B == 0)? 1'b0 : 1'b1 ) : 0;

assign N_B[26:4] = (Enable)? M_B : 0;

assign N_B[3:0] = 0;

//

assign E_Data = ((Enable == 1'b1) & (E_A == 0) & (E_B == 0))? 2'b00 : 
                ((Enable == 1'b1) & (E_A > 0)  & (E_B > 0) )? 2'b01 : 
                ((Enable == 1'b1) & ((E_A == 0) | (E_B == 0)))? 2'b10 : 2'b00;

endmodule //selector


   