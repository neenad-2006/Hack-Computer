module RAM4K(out, in, load, address, clk);
    input clk, load;
    input [15:0] in;
    input [11:0] address;
    output reg [15:0] out;

    reg [15:0] memory [0:4095]; // 4K = 4096 locations

    always @(posedge clk)
    begin
        if (load)
            memory[address] <= in;   // write

        out <= memory[address];     // read
    end

endmodule