module mux(out, a, b, sel);
    input a, b, sel;
    output out;

    assign out = (~sel & a) | (sel & b);
endmodule