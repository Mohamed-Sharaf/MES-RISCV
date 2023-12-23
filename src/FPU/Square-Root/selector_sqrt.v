module selector_sqrt
(
    input   [30 : 0]   A,
    input              Enable,      // If enable signal is high it means we do not have a special case
    output  [7:0]      E_A,
    output  [23:0]     M_A,
    output             EA_sub
);
    


// *******************************&&%&%&&******************************


assign E_A = (Enable)? A[30:23] : E_A;  // E_A --> exponent of input A

assign EA_sub = (Enable)? ((E_A == 0)? 1'b0 : 1'b1 ) :  EA_sub;

assign M_A[23] = (Enable)? ((E_A == 0)? 1'b0 : 1'b1 ) : M_A[23];

assign M_A[22:0] = (Enable)? A[22:0] : M_A[22:0];   // M_A --> mantissa of input A


endmodule //selector_sqrt


   