module Computer(
    input clk,
    input reset
);

    reg [15:0] RAM [0:16383];
    reg [15:0] SCREEN [0:8191];
    reg [15:0] KEYBOARD;
    reg [15:0] ROM [0:32767];

    reg [15:0] A, D;
    reg [14:0] pc;

    reg [15:0] instruction;
    reg [15:0] inM, outM;
    reg writeM;
    reg [14:0] addressM;

    reg [15:0] aluOut;
    reg zr, ng;

    always @(*) begin
        instruction = ROM[pc];
    end

    always @(*) begin
        if (A[14] == 0)
            inM = RAM[A[13:0]];
        else if (A[14] == 1 && A[13] == 0)
            inM = SCREEN[A[12:0]];
        else
            inM = KEYBOARD;
    end

    reg [15:0] x, y;

    always @(*) begin
        x = D;
        y = instruction[12] ? inM : A;

        if (instruction[11]) x = 0;
        if (instruction[10]) x = ~x;

        if (instruction[9]) y = 0;
        if (instruction[8]) y = ~y;

        if (instruction[7])
            aluOut = x + y;
        else
            aluOut = x & y;

        if (instruction[6])
            aluOut = ~aluOut;

        zr = (aluOut == 0);
        ng = aluOut[15];
    end

    always @(posedge clk) begin
        if (reset) begin
            pc <= 0;
        end else begin

            if (!instruction[15])
                A <= instruction;
            else if (instruction[5])
                A <= aluOut;

            if (instruction[15] && instruction[4])
                D <= aluOut;

            writeM = instruction[15] & instruction[3];
            outM = aluOut;
            addressM = A[14:0];

            if (writeM) begin
                if (A[14] == 0)
                    RAM[A[13:0]] <= outM;
                else if (A[14] == 1 && A[13] == 0)
                    SCREEN[A[12:0]] <= outM;
            end

            if (instruction[15]) begin
                if (
                    (instruction[2] & (~zr & ~ng)) |
                    (instruction[1] & zr) |
                    (instruction[0] & ng)
                )
                    pc <= A[14:0];
                else
                    pc <= pc + 1;
            end else begin
                pc <= pc + 1;
            end
        end
    end

endmodule