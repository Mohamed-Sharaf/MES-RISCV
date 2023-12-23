module round_div
(
    input               S_G,
    input       [50:0]  M_IN,
    input       [2:0]   R_M,        // rounding mode 
    // input           EA_sub, EB_sub,
    output reg  [23:0]  M_OUT
);
    
wire sticky =  |M_IN[2:0];

// wire [22:0] temp;

// assign temp = M_IN[26:3] + 1'b1 ;

// assign M_OUT = (M_IN[22])? temp
//              : M_IN[26:3] ;                   

// assign M_OUT = (EA_sub & EB_sub)? M_IN[26:3] : M_IN[26:3];

// assign M_OUT = M_IN[26:3];

always @(*) begin
    case (R_M)
        3'b000: begin                                   // Round to Nearest, ties to Even
            if (M_IN[2])    M_OUT = M_IN[26:3] + 1'b1;
            else            M_OUT = M_IN[26:3];
        end

        3'b001: begin                                   // Round towards Zero
            M_OUT = M_IN[26:3];
        end
        
        3'b010: begin                                   // Round Down (towards −Infinity)
            if (S_G & sticky)   M_OUT = M_IN[26:3] + 1'b1;
            else                M_OUT = M_IN[26:3];
        end

        3'b011: begin                                   // Round Up (towards +Infinity)
            if ((!S_G) & sticky)    M_OUT = M_IN[26:3] + 1'b1;
            else                    M_OUT = M_IN[26:3];
        end

        3'b100: begin                                   // Round to Nearest, ties to Max Magnitude
            if (sticky)             M_OUT = M_IN[26:3] + 1'b1;
            else                    M_OUT = M_IN[26:3];
        end

        default: begin
            if (M_IN[2])    M_OUT = M_IN[26:3] + 1'b1;  // Round to Nearest
            else            M_OUT = M_IN[26:3];
        end
    endcase
end

endmodule //round_div


