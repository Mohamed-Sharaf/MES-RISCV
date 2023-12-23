module sqrt
(
    input   [23:0] IN,
    output  [47:0] OUT
);
   
reg     [47:0]   X;
reg     [23:0]   Q;
reg     [47:0]   A, T, temp;


integer i;

always @(*)
begin
    A = 0;
    X = {IN,24'b0};
    temp = 0; 
    T = 0;
    Q = 0;
    for(i = 0; i < 24; i = i + 1)
    begin

        A = {temp[45:0],X[47:46]};
        
        X = {X[45:0],2'b00};

        T = A - {Q,2'b01};

        if (T[47]) begin
            temp = A;
            Q = {Q[22:0],1'b0}; 
        end 
        else begin
            temp = T;
            Q = {Q[22:0],1'b1}; 
        end
    end
end

assign OUT = {Q,T[23:0]};

endmodule //sqrt
