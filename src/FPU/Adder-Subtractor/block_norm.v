module block_norm
(
    input           S_G, 
    input           Co,
    input           eq,
    input   [07:0]  E_S,
    input   [27:0]  M_S,
    input   [2:0]   R_M,        // rounding mode 
    output  [07:0]  E,
    output  [22:0]  M
);
    
wire    [4:0]   lzc_cnt, Shift;
wire    [27:0]  shift_out;
wire    [27:0]  carry_shift;
wire    zero_check; 


lzc leading_zeros
(
.data_in(M_S),  
.count(lzc_cnt)
);


shift_left  shifter
(
.data_in(M_S),  
.count(Shift),
.S(shift_out)
);


round   round_unit
(
.S_G(S_G),
.M_IN(carry_shift),
.R_M(R_M),        // rounding mode 
.M_OUT(M)
);

//----------------------------------------------------------------------

assign Shift = (Co)? 0
             : (E_S > lzc_cnt)? lzc_cnt 
             : (E_S < lzc_cnt)? E_S[4:0]
             : lzc_cnt;

assign carry_shift = shift_out >> Co;

assign zero_check = (M_S == 0);

assign E    = (zero_check & eq) ? 8'h00
            : (E_S > lzc_cnt)? (E_S - Shift + Co) 
            : (E_S < lzc_cnt)? 8'h00
            : 8'h01;
//----------------------------------------------------------------------




endmodule //block_norm


