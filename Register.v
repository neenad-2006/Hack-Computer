module Register(out, in, load, clk);
    input load, clk;
    input [15:0] in;
    output reg [15:0] out;

    always @(posedge clk)
    begin
        if (load)
            out <= in;
    end
endmodule