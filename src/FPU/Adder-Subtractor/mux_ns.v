module mux_ns
(
    input       [36:0]  Nor_A, Nor_B,       // Normal A & B
                        Mix_A, Mix_B,       // Mixed A & B  
    input       [01:0]  E_Data,             // Enable type data
    output      [36:0]  N_A, N_B
);
    
assign N_A  = (E_Data == 2'b01) ? Nor_A     // Normal Numbers 
            : (E_Data == 2'b10) ? Mix_A     // Mixed Numbers 
            : N_A;

assign N_B  = (E_Data == 2'b01) ? Nor_B     // Normal Numbers
            : (E_Data == 2'b10) ? Mix_B     // Mixed Numbers
            : N_B;

endmodule //mux_ns


