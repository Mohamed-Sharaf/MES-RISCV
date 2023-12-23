module fp_class
(
    input   [31 : 0]   A,
    output reg [31 : 0]   S
);
    
wire       S_A = A[31] ;            // S_A --> sign of input A

wire [7:0] E_A = A[30:23] ;         // E_A --> exponent of input A

wire [22:0] M_A = A[22:0] ;         // M_A --> mantissa of input A

reg  [2:0]  temp_A;




always @(*) begin

    case (E_A)

        8'h00:  if (M_A == 0)
                    temp_A = 000;                   // zero
                else 
                    temp_A = 001;                   // sub_normal
        
        8'hff:  if (M_A == 0)
                    temp_A = 100;                   // Inf
                else 
                    temp_A = 110;                   // NaN

        default:    if (M_A == 0)
                        temp_A = 011;               // Normal
                    else 
                        temp_A = 011;               // Normal

    endcase
    
end

always @(S_A, temp_A) begin
    
    casez ({S_A, temp_A})

        4'b0000: begin                      // Number A  = +Zero
                S = 32'b0100;
            end

        4'b1000: begin                      // Number A  = -Zero
                S = 32'b0011;
            end

        4'b0100: begin                       // +Infinity 
                S = 32'b0111;
            end

        4'b1100: begin                       // -Infinity 
                S = 32'b0000;    
            end

        4'b0001: begin                       // +sub_normal 
                S = 32'b0101;
            end

        4'b1001: begin                       // -sub_normal
                S = 32'b0010;
            end

        4'b0011: begin                       // +normal 
                S = 32'b0110;
            end

        4'b1011: begin                       // -normal
                S = 32'b0001;
            end

        4'b0110: begin                       // quiet NaN 
                S = 32'b1001;
            end

        4'b1110: begin                       // signaling NaN
                S = 32'b1000;
            end

        default: begin
                S = 32'b0100;
            end
    endcase

end

endmodule // fp_class