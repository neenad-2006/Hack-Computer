module RAM64(out, in, load, address, clk);
    input clk, load;
    input [15:0] in;
    input [5:0] address;
    output reg [15:0] out;

    reg [15:0] memory [0:63]; // 64 registers

    always @(posedge clk)
    begin
        if (load)
            memory[address] <= in;   // write

        out <= memory[address];     // read
    end

endmodule