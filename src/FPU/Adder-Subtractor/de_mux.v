module de_mux
(
    input           [36 : 0]    A, B,           
    input           [01 : 0]    E_Data,         // Enable type data
    output  reg     [36 : 0]    N_A0, N_B0,
                                N_A1, N_B1,
                                N_A2, N_B2
);
    
always @(*) begin
    case (E_Data)

    // --------------------------------- SubNormals ---------------------------------
        2'b00: begin                            
            N_A0 = A; 
            N_B0 = B;
            N_A1 = N_A1;
            N_B1 = N_B1;
            N_A2 = N_A2;
            N_B2 = N_B2;
        end 

    // --------------------------------- Normals ---------------------------------
        2'b01: begin
            N_A0 = N_A0; 
            N_B0 = N_B0;
            N_A1 = A;
            N_B1 = B;
            N_A2 = N_A2;
            N_B2 = N_B2;
        end 

    // --------------------------------- mix ---------------------------------
        2'b10: begin
            N_A0 = N_A0; 
            N_B0 = N_B0;
            N_A1 = N_A1;
            N_B1 = N_B1;
            N_A2 = A;
            N_B2 = B;
        end 


        default: begin
            N_A0 = N_A0; 
            N_B0 = N_B0;
            N_A1 = N_A1;
            N_B1 = N_B1;
            N_A2 = N_A2;
            N_B2 = N_B2;
        end 
    endcase
end

endmodule //de_mux


