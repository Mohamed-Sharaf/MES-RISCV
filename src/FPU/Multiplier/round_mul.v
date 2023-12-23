module round_mul
(
    input               S_G,
    input       [47:0]  M_IN,
    input       [2:0]   R_M,        // rounding mode 
    output reg  [22:0]  M_OUT
);
    
// wire [22:0] temp;

wire sticky =  |M_IN[23:21];

always @(*) begin
    case (R_M)
        3'b000: begin                                   // Round to Nearest, ties to Even
            if (M_IN[23])    M_OUT = M_IN[46:24] + 1'b1;
            else            M_OUT = M_IN[46:24];
        end

        3'b001: begin                                   // Round towards Zero
            M_OUT = M_IN[46:24];
        end
        
        3'b010: begin                                   // Round Down (towards −Infinity)
            if (S_G & sticky)   M_OUT = M_IN[46:24] + 1'b1;
            else                M_OUT = M_IN[46:24];
        end

        3'b011: begin                                   // Round Up (towards +Infinity)
            if ((!S_G) & sticky)    M_OUT = M_IN[46:24] + 1'b1;
            else                    M_OUT = M_IN[46:24];
        end

        3'b100: begin                                   // Round to Nearest, ties to Max Magnitude
            if (sticky)             M_OUT = M_IN[46:24] + 1'b1;
            else                    M_OUT = M_IN[46:24];
        end

        default: begin
            if (M_IN[23])    M_OUT = M_IN[46:24] + 1'b1;
            else            M_OUT = M_IN[46:24];
        end
    endcase
end

endmodule //round_mul


