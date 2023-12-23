module adder
(
    input       [27:0]      A, B,
    input                   AS,
    output  reg [27:0]      SU,
    output  reg             CA
);

always @(*) begin

    if (AS == 1'b1) begin
        {CA ,SU} = A - B;
    end
    else begin
        {CA ,SU} = A + B;
    end 

end
    
endmodule //adder

 