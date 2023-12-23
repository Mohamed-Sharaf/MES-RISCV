module shift_right 
(
    input   [27:0]  data_in,  
    input   [4:0]   count,
    output  [27:0]  S
);
    
    assign S = data_in >> count;

endmodule //shift_right
