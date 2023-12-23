module fp_sign (
    input wire [31:0] a,       // Floating-point number A
    input wire [31:0] b,       // Floating-point number B
    input wire [1:0]  R_M,      // 000 --> fsgnj.s  || 001  --> fsgnjn.s  || 010 --> fsgnjx.s
    output reg [31:0] result
);

    reg sign_a, sign_b;

    // Extracting sign bits of A and B
    always @(*)
    begin
        sign_a = a[31];
        sign_b = b[31];
    end

    always@ (*)
    begin
        case(R_M)

            2'b00: result = {b[31], a[30:0]};   // fsgnj.s: Result has the sign of B and the magnitudes of A
            2'b01: result = {~b[31], a[30:0]};  // fsgnjn.s: Result has the opposite sign of B and the magnitudes of A
            2'b10: result = {sign_a ^ sign_b, a[30:0]}; // fsgnjx.s: Result has the XOR of signs of A and B and the magnitudes of A

            default: result = {b[31], a[30:0]};
        endcase
    end

endmodule // fp_sign

