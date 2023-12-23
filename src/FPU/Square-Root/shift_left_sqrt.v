module shift_left_sqrt
(
    input   [23:0]  data_in,  
    input   [4:0]   count,
    output  [23:0]  S
);
    
    assign S = data_in << count;

endmodule //shift_left_sqrt
