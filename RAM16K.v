module RAM16K(out, in, load, address, clk);
    input clk, load;
    input [15:0] in;
    input [13:0] address;   // 14 bits → 16K locations
    output reg [15:0] out;

    reg [15:0] memory [0:16383]; // 16K = 16384 locations

    always @(posedge clk)
    begin
        if (load)
            memory[address] <= in;   // write

        out <= memory[address];     // read
    end

endmodule