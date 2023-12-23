module mux_adder
(
    input           Nor_SA, Nor_SB,         // Normal sign A & sign B
    input           Sub_SA, Sub_SB,         // SubNormal sign A & sign B
    input           Comp_Nor, Comp_Sub,     // Comp_Nor --> Comparison normal numbers , Comp_Sub --> Comparison subnormal numbers
    input   [07:0]  Nor_E, Sub_E,           // Nor_E --> Normal Exponent , Sub_E --> SubNormal Exponent 
    input   [27:0]  Nor_MA, Nor_MB,         // Normal Mantissa A & Mantissa B
    input   [27:0]  Sub_MA, Sub_MB,         // SubNormal Mantissa A & Mantissa B
    input   [01:0]  E_Data,                 // Enable type data
    output          S_A, S_B,               // sign A & sign B
    output          C,                      // Comparison
    output  [07:0]  E,                      // Output Exponent
    output  [27:0]  M_A, M_B                // Mantissa A & Mantissa B
);
    
assign S_A  = ((E_Data == 2'b01) | (E_Data == 2'b10)) ? Nor_SA      // Normal / Mix Numbers  
            : (E_Data == 2'b00) ? Sub_SA                            // SubNormal Numbers
            : S_A;

assign S_B  = ((E_Data == 2'b01) | (E_Data == 2'b10)) ? Nor_SB      // Normal / Mix Numbers
            : (E_Data == 2'b00) ? Sub_SB                            // SubNormal Numbers
            : S_B;
   
assign C    = ((E_Data == 2'b01) | (E_Data == 2'b10)) ? Comp_Nor    // Normal / Mix Numbers
            : (E_Data == 2'b00) ? Comp_Sub                          // SubNormal Numbers
            : C;
 
assign E    = ((E_Data == 2'b01) | (E_Data == 2'b10)) ? Nor_E       // Normal / Mix Numbers
            : (E_Data == 2'b00) ? Sub_E                             // SubNormal Numbers
            : E;
 
assign M_A  = ((E_Data == 2'b01) | (E_Data == 2'b10)) ? Nor_MA      // Normal / Mix Numbers
            : (E_Data == 2'b00) ? Sub_MA                            // SubNormal Numbers
            : M_A;
 
assign M_B  = ((E_Data == 2'b01) | (E_Data == 2'b10)) ? Nor_MB      // Normal / Mix Numbers
            : (E_Data == 2'b00) ? Sub_MB                            // SubNormal Numbers
            : M_B;


endmodule //mux_adder


