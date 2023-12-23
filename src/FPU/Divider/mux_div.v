module mux_div
(
    input  [23:0]   IN_1, IN_2,
    input           Enable,
    output [23:0]   out_r
);
    
assign out_r   = (Enable)? IN_1 : IN_2;

endmodule //mux_div


