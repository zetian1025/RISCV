module PC(
    input           clk_i,
    input           rst_i,
    input [31:0]    PC_i,
    output [31:0]   PC_o
);

    reg [31:0]  new_PC;

    always @(posedge clk_i or negedge rst_i) begin
        if (!rst_i) begin
            new_PC <= 32'hffff_fffc;
        end else begin
            new_PC <= PC_i;
        end
    end

    assign PC_o      = new_PC;

endmodule
