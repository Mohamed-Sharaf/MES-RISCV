module block_div
(
    input  [50:0]     MA_IN,
    input  [50:0]     MB_IN,
    output [50:0]     div_result
);

wire  [50:0] quotient;
wire  [50:0] remainder;

reg [50:0] p, a, temp;
integer i;

///////////////////////////////////////////////////////////////////////////////////////////////////////

always @(*)
begin
    a = MA_IN;
    p = 0;

    for(i = 0; i < 50; i = i+1)
    begin
        //Shift Left carrying a's MSB into p's LSB
        p = (p << 1) | a[50];
        a = a << 1;

        //store value in case we have to restore
        temp = p;

        //Subtract
        p = p - MB_IN;

        if( p[50] ) // if p < 0
            p = temp; //restore value
        else
            a = a | 1;
    end	
end

///////////////////////////////////////////////////////////////////////////////////////////////////////

assign quotient = a;

assign remainder = p;

assign div_result = quotient;
    
endmodule // block_div
