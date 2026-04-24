module DMux8Way(a, b, c, d, e, f, g, h, in, sel);
    input  in;
    input  [2:0] sel;
    output reg a, b, c, d, e, f, g, h;

    always @(*) begin
        case(sel)
            3'b000: begin a=in; b=0; c=0; d=0; e=0; f=0; g=0; h=0; end
            3'b001: begin a=0; b=in; c=0; d=0; e=0; f=0; g=0; h=0; end
            3'b010: begin a=0; b=0; c=in; d=0; e=0; f=0; g=0; h=0; end
            3'b011: begin a=0; b=0; c=0; d=in; e=0; f=0; g=0; h=0; end
            3'b100: begin a=0; b=0; c=0; d=0; e=in; f=0; g=0; h=0; end
            3'b101: begin a=0; b=0; c=0; d=0; e=0; f=in; g=0; h=0; end
            3'b110: begin a=0; b=0; c=0; d=0; e=0; f=0; g=in; h=0; end
            3'b111: begin a=0; b=0; c=0; d=0; e=0; f=0; g=0; h=in; end
        endcase
    end
endmodule