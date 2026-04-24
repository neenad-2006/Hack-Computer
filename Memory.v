module Memory(out, in, load, address, clk);
    input clk, load;
    input [15:0] in;
    input [14:0] address;
    output reg [15:0] out;

    reg [15:0] RAM [0:16383];      
    reg [15:0] SCREEN [0:8191];   
    reg [15:0] KEYBOARD;        

    always @(posedge clk)
    begin
        if (load) begin
            if (address[14] == 0) begin
                RAM[address[13:0]] <= in;
            end
            else if (address[14] == 1 && address[13] == 0) begin
                SCREEN[address[12:0]] <= in;
            end
        end

        if (address[14] == 0) begin
            out <= RAM[address[13:0]];
        end
        else if (address[14] == 1 && address[13] == 0) begin
            out <= SCREEN[address[12:0]];
        end
        else begin
            out <= KEYBOARD; 
        end
    end

endmodule