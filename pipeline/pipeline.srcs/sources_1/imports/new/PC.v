module PC(
    input           clk,
    input           rst_n,
    input [31:0]    PC_i,
    output [31:0]   PC_o
);

    reg [31:0]  new_PC;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            new_PC <= 32'h0;
        end else begin
            new_PC <= PC_i;
        end
    end

    assign PC_o      = new_PC;

endmodule
