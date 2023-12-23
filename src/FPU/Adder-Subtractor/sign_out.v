module sign_out
(
    input               S_A, S_B,               // sign A & sign B
    input   [27:0]      MA_IN,                  // Greatest Mantissa 
    input   [27:0]      MB_IN,
    input               Comp,                   // Determine the largest Number
    input               A_S,                    // 0 --> Add , 1 --> Sub 
    output              S_O,                    // sign ouput
    output  [27:0]      MA_O,
    output  [27:0]      MB_O,
    output              AS
);

wire            SB_wire;

assign  SB_wire = S_B ^ A_S;   

assign  S_O = (Comp == 1'b1) ? S_A : SB_wire;       // A > B --> Sign A


// assign  MA_O    = (Comp == 1'b1) ? MA_IN : MB_IN;

// assign  MB_O    = (Comp == 1'b1) ? MB_IN : MA_IN;

assign  MA_O    =  MA_IN ;

assign  MB_O    =  MB_IN ;

assign  AS  = (S_A ^ SB_wire) ? 1 : 0;             // S_A != SB_wire

endmodule //sign_out


