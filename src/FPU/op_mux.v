module op_mux
(
    input       [31:0]  IN_1,           // add_sub
                        IN_2,           // mul
                        IN_3,           // div 
                        IN_4,           // min_max
                        IN_5,           // sqrt
                        IN_6,           // comp
                        IN_7,           // classify or mv x to w
                        IN_8,           // mv w to x
                        IN_9,           // fp_sign
                        IN_10,          // fp_int_float
                        IN_11,          // fp_float_int

    input               IN_2_OFlow,
                        IN_3_OFlow,

    input       [04:0]  sel,
    output  reg [31:0]  Result,
    output  reg         OverFlow
);
    
always @(*) begin
    casez (sel)

        5'b00000, 
        5'b00001: begin

            Result = IN_1;
            OverFlow = 0;

        end
        

        5'b00010: begin
           
            Result = IN_2;
            OverFlow = IN_2_OFlow;

        end 

        5'b00011: begin
            
            Result = IN_3;
            OverFlow = IN_3_OFlow;

        end 

        5'b00101: begin
            
            Result = IN_4;
            OverFlow = 0;

        end 

        5'b01011: begin
           
            Result = IN_5;
            OverFlow = 0;

        end 

        5'b10100: begin
           
            Result = IN_6;
            OverFlow = 0;

        end 

        5'b11100: begin
           
            Result = IN_7;
            OverFlow = 0;

        end 

        5'b11110: begin
           
            Result = IN_8;
            OverFlow = 0;

        end 

        5'b00100: begin
           
            Result = IN_9;
            OverFlow = 0;

        end 

        5'b11000: begin
           
            Result = IN_10;
            OverFlow = 0;

        end 

        5'b11010: begin
           
            Result = IN_11;
            OverFlow = 0;

        end 

        default:  begin
            
            Result = IN_1;
            OverFlow = 0;

        end 

    endcase
end

endmodule //op_mux


