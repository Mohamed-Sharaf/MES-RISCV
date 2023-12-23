module round
(
    input               S_G,
    input       [27:0]  M_IN,
    input       [2:0]   R_M,        // rounding mode 
    output reg  [22:0]  M_OUT
);
    
wire sticky =  |M_IN[3:1];

always @(*) begin
    case (R_M)
        3'b000: begin                                   // Round to Nearest, ties to Even
            if (M_IN[3])     M_OUT = M_IN[26:4] + 1'b1;
            else             M_OUT = M_IN[26:4];
        end

        3'b001: begin                                   // Round towards Zero
            M_OUT = M_IN[26:4];
        end
        
        3'b010: begin                                   // Round Down (towards −Infinity)
            if (S_G & sticky)   M_OUT = M_IN[26:4] + 1'b1;
            else                M_OUT = M_IN[26:4];
        end

        3'b011: begin                                   // Round Up (towards +Infinity)
            if ((!S_G) & sticky)    M_OUT = M_IN[26:4] + 1'b1;
            else                    M_OUT = M_IN[26:4];
        end

        3'b100: begin                                   // Round to Nearest, ties to Max Magnitude
            if (sticky)             M_OUT = M_IN[26:4] + 1'b1;
            else                    M_OUT = M_IN[26:4];
        end

        default: begin
            if (M_IN[3])     M_OUT = M_IN[26:4] + 1'b1;
            else             M_OUT = M_IN[26:4];
        end
    endcase
end

// assign M_OUT = (M_IN[3:0] < 4'b1000)? M_IN[26:4] 
//              : (M_IN[26:4] + 1'b1 ) ;                   // round if >= 8

endmodule //round


