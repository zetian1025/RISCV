module IF2ID (
    input               clk,
    input               rst_n,
    input               pipeline_stop,

    input   [31:0]      IF_pc,
    input   [31:0]      IF_instruction,

    output reg  [31:0]      ID_pc,
    output reg  [31:0]      ID_instruction
);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        ID_pc <= 0;
    end else if (pipeline_stop) begin
        ID_pc <= ID_pc;
    end else begin
        ID_pc <= IF_pc;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        ID_instruction <= 0;
    end else if (pipeline_stop) begin
        ID_instruction <= ID_instruction;
    end else begin
        ID_instruction <= IF_instruction;
    end
end

endmodule
