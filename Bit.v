module Bit(out, load, in, clk);
    input in, load, clk;
    output reg out;

    always @(posedge clk)
    begin
        if (load)
            out <= in;
    end
endmodule