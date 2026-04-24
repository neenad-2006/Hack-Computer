module RAM8(out, in, load, address, clk);
    input load, clk;
    input [15:0] in;
    input [2:0] address;
    output reg [15:0] out;

    reg [15:0] memory [0:7]; // 8 registers

    always @(posedge clk)
    begin
        if (load)
            memory[address] <= in;   // write operation

        out <= memory[address];     // read operation
    end

endmodule