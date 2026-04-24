module PC(out, in, inc, load, reset, clk);
    input clk, inc, load, reset;
    input [15:0] in;
    output reg [15:0] out;

    always @(posedge clk)
    begin
        if (reset)
            out <= 16'b0;          // highest priority
        else if (load)
            out <= in;
        else if (inc)
            out <= out + 1;
        else
            out <= out;            // hold (optional, can omit)
    end

endmodule