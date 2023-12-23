module selector_div
(
    input   [30 : 0]   A, B,
    input              Enable,      // If enable signal is high it means we do not have a special case
    output  [7:0]      E_A,
    output  [7:0]      E_B,
    output  [23:0]     M_A,
    output  [23:0]     M_B,
    output             EA_sub, EB_sub
);
    

// *******************************&&%&%&&******************************


assign E_A = (Enable)? A[30:23] : E_A;  // E_A --> exponent of input A


assign E_B = (Enable)? B[30:23] : E_B;  // E_B --> exponent of input B

//

assign EA_sub = (Enable)? ((E_A == 0)? 1'b0 : 1'b1 ) :  EA_sub;

assign M_A[23] = (Enable)? ((E_A == 0)? 1'b0 : 1'b1 ) : M_A[23];

assign M_A[22:0] = (Enable)? A[22:0] : M_A[22:0];       // M_A --> mantissa of input A



assign EB_sub = (Enable)? ((E_B == 0)? 1'b0 : 1'b1 ) :  EB_sub;

assign M_B[23] = (Enable)? ((E_B == 0)? 1'b0 : 1'b1 ) : M_B[23];

assign M_B[22:0] = (Enable)? B[22:0] : M_B[22:0];       // M_B --> mantissa of input B         


endmodule //selector_div


   