module norm 
(
    input       [36:0] A, B,
    output             sw,
    output      [36:0] M_A, M_B         // M_A --> Normalized number A, M_B --> Normalized number B
);

wire [36:0] N_B;
wire [4:0]  count;
wire [27:0] MB;

comp g3
(
.A(A), 
.B(B),
.sw(sw),
.N_A(M_A), 
.N_B(N_B)     
);

lzc g1
( 
.data_in(N_B[27:0]),  
.count(count)
);

shift_left g2
(
.data_in(N_B[27:0]),  
.count(count),
.S(MB)
);

assign M_B[27:0] = (count == 5'b11011)? MB : {MB[27:1], 1'b1};  // Bit 0 -> Mark

assign M_B[35:28] = (count == 5'b11011)? N_B[35:28] : count;

assign M_B[36] = N_B[36];


endmodule