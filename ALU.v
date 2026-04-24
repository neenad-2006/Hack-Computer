module ALU(out, zr, ng, zx, nx, zy, ny, f, no, x1, y1);
    input zx, nx, zy, ny, f, no;
    input [15:0] x1, y1;
    output reg zr, ng;
    output reg [15:0] out;

    reg [15:0] x, y, fout;


    always @(*)
    begin

        x = x1;
        y = y1;

        case (zx)
            1'b1: x = 0;
            1'b0: x = x;
        endcase
        case (nx)
            1'b1: x = ~x;
            1'b0: x = x;
        endcase

        case (zy)
            1'b1: y = 0;
            1'b0: y = y;
        endcase
        case (ny)
            1'b1: y = ~y;
            1'b0: y = y;
        endcase

        case (f)
            1'b0: fout = x & y; 
            1'b1: fout = x + y;
        endcase

        case (no)
            1'b1: out = ~fout;   
            1'b0: out = fout;   
        endcase

        case (out[15])
            1'b0: ng = 0;
            1'b1: ng = 1;
        endcase

        case (out)
            16'b0: zr = 1;
            default: zr = 0;
        endcase
    end
endmodule