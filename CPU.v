module CPU(
    input clk,
    input reset,
    input [15:0] inM,
    input [15:0] instruction,

    output reg [15:0] outM,
    output reg writeM,
    output reg [14:0] addressM,
    output reg [14:0] pc
);

    reg [15:0] A, D;
    wire [15:0] aluY, aluOut;
    wire zr, ng;

    wire isC = instruction[15];

    assign aluY = instruction[12] ? inM : A;

    reg [15:0] x, y;
    reg [15:0] alu_result;

    always @(*) begin
        x = D;
        y = aluY;

        if (instruction[11]) x = 0;
        if (instruction[10]) x = ~x;

        if (instruction[9]) y = 0;
        if (instruction[8]) y = ~y;

        if (instruction[7])
            alu_result = x + y;
        else
            alu_result = x & y;

        if (instruction[6])
            alu_result = ~alu_result;
    end

    assign aluOut = alu_result;
    assign zr = (aluOut == 16'b0);
    assign ng = aluOut[15];

    wire jgt = instruction[2] & (~zr & ~ng);
    wire jeq = instruction[1] & zr;
    wire jlt = instruction[0] & ng;

    wire jump = jgt | jeq | jlt;

    always @(posedge clk) begin
        if (reset) begin
            pc <= 0;
        end else begin
            if (!isC)
                A <= instruction;
            else if (instruction[5])
                A <= aluOut;

            if (isC && instruction[4])
                D <= aluOut;

            writeM <= isC & instruction[3];
            outM <= aluOut;

            addressM <= A[14:0];

            if (isC && jump)
                pc <= A[14:0];
            else
                pc <= pc + 1;
        end
    end

endmodule