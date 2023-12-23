module mux_fp_div
(
    input  [31:0]   Num_1, Num_2,
    input           Enable,
    output [31:0]   Result
);

assign Result = (Enable)? Num_2 : Num_1;
    
endmodule //mux_fp_div


