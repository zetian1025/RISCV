module IF2ID (
    input               clk,
    input               rst_n,
    input   [31:0]      IF_pc,
    input   [31:0]      IF_instruction,
    output  [31:0]      ID_pc,
    output  [31:0]      ID_instruction       
);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        ID_pc <= 0;
    end else begin
        ID_pc <= IF_pc;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        ID_instruction <= 0;
    end else begin
        ID_instructino <= IF_instruction;
    end
end

endmodule