module comp_exp
(
    input       [36:0]  A, B,
    input               A_S,                    // 0 --> Add , 1 --> Sub 
    input               sw,                     // switched or not 
    output              S_A, S_B,               // --> sign A & sign B
    output      [07:0]  E_Max,                  // output exponent
    output      [27:0]  M_Max,                  // Largest Mantissa
    output      [27:0]  M_Shft,                 // Mantissa to shift 
    output      [04:0]  D_Exp,                  // Subtraction of exponents
    output              Comp,
    output              eq                   // Determine largest number    
);

wire C;
wire [7:0] dif; 

assign S_A = (B[0] & A_S & sw)? !A[36] : A[36];                  // --> sign A
assign S_B = B[36];                                         //     sign B

wire [7:0] E_A = A[35:28] ;         // E_A --> exponent of input A
wire [7:0] E_B = B[35:28] ;         // E_B --> exponent of input B

wire [27:0] M_A = A[27:0] ;         // M_A --> Mantissa of input A
wire [27:0] M_B = B[27:0] ;         // M_B --> Mantissa of input B

// -------------------------------- Exponent Comparison ----------------------------------

assign C = ((E_A > E_B) | (M_B[0] == 1'b1)) ? 1     // Exponent A > Exponent B
         : (E_A < E_B) ? 0                          // Exponent B > Exponent A
         : (M_A < M_B) ? 0                          // Exponent A = Exponent B --> Mantissa B > Mantissa A
         : 1;                                       // Exponent A = Exponent B --> Mantissa A >= Mantissa B

assign Comp = C;

// ---------------------------------------------------------------------------------------

// -------------------------------- Largest Exponent -------------------------------------

assign E_Max = (C) ? E_A : E_B;

// ---------------------------------------------------------------------------------------

// determining the difference between both exponents. Once more time
// comp signal fixes the largest exponent and determines the subtraction order
// If B’s LSB is high a negative exponent is had. In this case EA and EB are added.

// -------------------------------- Difference between Exponents -------------------------------------

assign dif  = ((C == 1'b1) & (M_B[0] == 0)) ? (E_A - E_B) 
            : ((C == 1'b1) & (M_B[0] == 1'b1)) ? (E_A + E_B) 
            : (E_B - E_A);


assign D_Exp = (dif > 8'h1b) ? 5'b11100         // If the difference is greater than 27 --> The difference is 28
             : dif[4:0];                        // If the difference is less than or equal to 27 
                                                // --> Use directely the subtraction between the components 

// ---------------------------------------------------------------------------------------

// -------------------------------- Mantissa -------------------------------------
assign M_Shft = (C) ? M_B : M_A;

assign M_Max  = (C) ? M_A : M_B;
    
// The mantissa to shift corresponds with the smallest number (using comp again).
// a maximum value is set if the difference between exponents is greater
// than 28 which is the maximum number of bits that the mantissa has.


assign eq = ((dif==0) & (A_S));

endmodule //comp_exp


