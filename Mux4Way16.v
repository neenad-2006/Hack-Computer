module Mux4Way16(out, a, b, c, d, sel);
    input [15:0] a, b, c, d;
    input [1:0] sel;
    output reg [15:0] out;

    // wire [15:0] m1out, m2out;
    // Mux16 M1(m1out, a, b, sel[0]);
    // Mux16 M2(m2out, c, d, sel[0]);
    // Mux16 M3(out, m1out, m2out, sel[1]);

    always @(*)
        begin
            case(sel)
            2'b00: out = a;
            2'b01: out = b;
            2'b10: out = c;
            2'b11: out = d;
            endcase
        end
endmodule