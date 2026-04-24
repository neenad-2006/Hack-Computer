module DMux(a, b, in, sel);
    input in, sel;
    output a, b;
    
    assign a = in & ~sel;
    assign b = in & sel;
endmodule