module special_case_sqrt
(
    input   [31 : 0]   A,
    output             Enable,
    output  [31 : 0]   S
);
    
wire       S_A = A[31] ;            // S_A --> sign of input A

wire       S_S;                     // S_S --> sign of output S

wire [7:0] E_A = A[30:23] ;         // E_A --> exponent of input A

reg  [7:0] E_S;                     // E_S --> exponent of output S

wire [22:0] M_A = A[22:0] ;         // M_A --> mantissa of input A

reg  [22:0] M_S;                    // M_S --> mantissa of output S

reg  [2:0]  temp_A;

assign Enable = temp_A[0];

assign S_S = S_A;

assign S = {S_S, E_S, M_S};

always @(*) begin

    case (E_A)

        8'h00:  if (M_A == 0)
                    temp_A = 000;
                else 
                    temp_A = 001;
        
        8'hff:  if (M_A == 0)
                    temp_A = 100;
                else 
                    temp_A = 110;

        default:    if (M_A == 0)
                        temp_A = 000;
                    else 
                        temp_A = 011;

    endcase
    
end

always @(S_A, temp_A) begin
    
    casez ({S_A, temp_A})

        4'b0000: begin            // Number A  or Number B = Zero
                E_S = 0;
                M_S = 0; 
            end

        4'b0100: begin                       // Infinity +/- Normal or Subnormal
                E_S = E_A;
                M_S = M_A; 
            end

        4'b0110: begin                       // NaN
                E_S = 'hff;
                M_S = 'h1; 
            end

        4'b1zzz: begin                       // NaN
                E_S = 'hff;
                M_S = 'h1; 
            end

        default: begin
                E_S = E_S;
                M_S = M_S; 
            end
    endcase

end

endmodule // special_case_mul