module pre_adder
(
    input   [31 : 0]    A, B,
    input               A_S,
    input               Enable,
    output              S_A, S_B,               // sign A & sign B
    output              C,                      // Comparison
    output  [07:0]      E_Out,                  // Output Exponent
    output  [27:0]      MA_Out,                 // Greatest Mantissa 
    output  [27:0]      MB_Out,                  // Shifted Mantissa 
    output              eq
);


wire [36 : 0]   sel_NA, sel_NB;
wire [01 : 0]   sel_EData;

wire [36 : 0]   N_A0, N_B0,
                N_A1, N_B1,
                N_A2, N_B2;

wire [36 : 0]   Fmux_NA, Fmux_NB, Mix_NA, Mix_NB;   // first mux (mux_ns) 


wire           Nor_SA, Nor_SB;         // Normal sign A & sign B
wire           Sub_SA, Sub_SB;         // SubNormal sign A & sign B
wire           Comp_Nor, Comp_Sub;     // Comp_Nor --> Comparison normal numbers , Comp_Sub --> Comparison subnormal numbers
wire   [07:0]  Nor_E, Sub_E;           // Nor_E --> Normal Exponent , Sub_E --> SubNormal Exponent 
wire   [27:0]  Nor_MA, Nor_MB;         // Normal Mantissa A & Mantissa B
wire   [27:0]  Sub_MA, Sub_MB;         // SubNormal Mantissa A & Mantissa B
 
wire           sw;

// ---------------------------------------- Selector ----------------------------------------------

selector pre_1
(
.A(A), 
.B(B),
.Enable(Enable),      // If enable signal is high it means we do not have a special case
.N_A(sel_NA), 
.N_B(sel_NB),
.E_Data(sel_EData)
);

// ------------------------------------------------------------------------------------------------

// ---------------------------------- Mux & De_Mux ----------------------------------

de_mux pre_2
(
.A(sel_NA), 
.B(sel_NB),           
.E_Data(sel_EData),         // Enable type data

// --------------------------------- SubNormals ---------------------------------
.N_A0(N_A0), 
.N_B0(N_B0),

// --------------------------------- Normals ---------------------------------
.N_A1(N_A1), 
.N_B1(N_B1),

// --------------------------------- mix ---------------------------------
.N_A2(N_A2), 
.N_B2(N_B2)
);


mux_ns pre_3
(
.Nor_A(N_A1), 
.Nor_B(N_B1),                   // Normal A & B

.Mix_A(Mix_NA), 
.Mix_B(Mix_NB),                 // Mixed A & B  

.E_Data(sel_EData),             // Enable type data
.N_A(Fmux_NA), 
.N_B(Fmux_NB)
);


mux_adder pre_4
(
.Nor_SA(Nor_SA), 
.Nor_SB(Nor_SB),                // Normal sign A & sign B

.Sub_SA(Sub_SA), 
.Sub_SB(Sub_SB),                // SubNormal sign A & sign B

.Comp_Nor(Comp_Nor), 
.Comp_Sub(Comp_Sub),            // Comp_Nor --> Comparison normal numbers , Comp_Sub --> Comparison subnormal numbers

.Nor_E(Nor_E), 
.Sub_E(Sub_E),                  // Nor_E --> Normal Exponent , Sub_E --> SubNormal Exponent 

.Nor_MA(Nor_MA), 
.Nor_MB(Nor_MB),                // Normal Mantissa A & Mantissa B

.Sub_MA(Sub_MA), 
.Sub_MB(Sub_MB),                // SubNormal Mantissa A & Mantissa B

.E_Data(sel_EData),             // Enable type data

.S_A(S_A), 
.S_B(S_B),                      // sign A & sign B

.C(C),                          // Comparison

.E(E_Out),                      // Output Exponent

.M_A(MA_Out), 
.M_B(MB_Out)                    // Mantissa A & Mantissa B
);
   
// ------------------------------------------------------------------------------------------------

// ---------------------------------- Normal Numbers ----------------------------------

n_normal pre_5
(
.A(Fmux_NA), 
.B(Fmux_NB),
.A_S(A_S),
.sw(sw),
.S_A(Nor_SA), 
.S_B(Nor_SB),                           // --> sign A & sign B
.E_O(Nor_E),                            // output exponent
.M_A(Nor_MA),                           // Largest Mantissa
.M_B(Nor_MB),                           // Shifted Mantissa
.Comp(Comp_Nor),
.eq(eq)                         // A & B comparison
);

// ------------------------------------------------------------------------------------

// -------------------------------------- Mixed Numbers -------------------------------------------

norm  pre_6
(
.A(N_A2), 
.B(N_B2),
.sw(sw),
.M_A(Mix_NA), 
.M_B(Mix_NB)         // M_A --> Normalized number A, M_B --> Normalized number B
);
    
// ------------------------------------------------------------------------------------------------

// -------------------------------------- SubNormal Numbers ---------------------------------------

n_subn  pre_7
(
.A(N_A0), 
.B(N_B0),
.S_A(Sub_SA), 
.S_B(Sub_SB),                   // --> sign A & sign B
.E_O(Sub_E),                    // output exponent
.M_A(Sub_MA),                   // Mantissa A
.M_B(Sub_MB),                   // Mantissa B 
.Comp(Comp_Sub)                 // comparison
);

// ------------------------------------------------------------------------------------------------


endmodule //pre_adder


