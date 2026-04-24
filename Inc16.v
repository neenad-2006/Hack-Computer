module Inc16(out, a);
    input [15:0] a;
    output [15:0] out;

    // Add16 Add161(out, a, 16'b1);
    assign out = a + 16'b1;
endmodule