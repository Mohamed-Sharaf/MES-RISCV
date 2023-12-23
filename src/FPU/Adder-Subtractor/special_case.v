module special_case
(
    input   [31 : 0]   A, B,
    output             Enable,
    output  [31 : 0]   S
);
    
wire       S_A = A[31] ;            // S_A --> sign of input A
wire       S_B = B[31] ;            // S_A --> sign of input B
reg        S_S;                     // S_S --> sign of output S

wire [7:0] E_A = A[30:23] ;         // E_A --> exponent of input A
wire [7:0] E_B = B[30:23] ;         // E_B --> exponent of input B
reg  [7:0] E_S;                     // E_S --> exponent of output S

wire [22:0] M_A = A[22:0] ;         // M_A --> mantissa of input A
wire [22:0] M_B = B[22:0] ;         // M_B --> mantissa of input B
reg  [22:0] M_S;                    // M_S --> mantissa of output S

reg  [2:0]  temp_A, temp_B;

assign Enable = temp_A[0] & temp_B[0];

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
    
    case (E_B)

        8'h00:  if (M_B == 0)
                    temp_B = 000;
                else 
                    temp_B = 001;
        
        8'hff:  if (M_B == 0)
                    temp_B = 100;
                else 
                    temp_B = 110;

        default:    if (M_B == 0)
                        temp_B = 000;
                    else 
                        temp_B = 011;

    endcase
    
end

always @(S_A, S_B, temp_A, temp_B) begin
    
    casez ({temp_A, temp_B})

        6'b000zzz : begin                       // Zero +/- Number B
                S_S = S_B;
                E_S = E_B;
                M_S = M_B; 
            end
        
        6'bzzz000 : begin                       // Number A +/- Zero
                S_S = S_A;
                E_S = E_A;
                M_S = M_A; 
            end

        6'bzz1100 : begin                       // Normal or Subnormal +/- Infinity
                S_S = S_B;
                E_S = E_B;
                M_S = M_B; 
            end

        6'b100zz1 : begin                       // Infinity +/- Normal or Subnormal
                S_S = S_A;
                E_S = E_A;
                M_S = M_A; 
            end

        6'b100100 : begin                       
                if (S_A == S_B) begin           // Infinity +/- Infinity
                            S_S = S_A;
                            E_S = E_A;
                            M_S = M_A;
                        end 
                else    begin                   // +Infinity - Infinity
                            S_S = 'h1;
                            E_S = 'hff;
                            M_S = 'h1;
                        end
            end

        6'b110zzz : begin                       // +Infinity - Infinity
                S_S = 'h1;
                E_S = 'hff;
                M_S = 'h1; 
            end

        6'bzzz110 : begin                       // +Infinity - Infinity
                S_S = 'h1;
                E_S = 'hff;
                M_S = 'h1; 
            end

        default: begin
                S_S = S_S;
                E_S = E_S;
                M_S = M_S; 
            end
    endcase

end

endmodule // special_case