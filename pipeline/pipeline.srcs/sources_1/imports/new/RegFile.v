module RegFile(
    input           clk,
    input           rst_n,
    input [4:0]     rR1,
    input [4:0]     rR2,
    input [4:0]     wR,
    input           WE,
    input [31:0]    wD,
    output [31:0]   rD1,
    output [31:0]   rD2
);

reg [31:0] RegFile [0:31];
integer i;

initial
    for (i=0; i<32; i=i+1) RegFile[i] = 0;
always @(negedge clk or negedge rst_n) begin
    if (!rst_n) begin
        for (i=0;i<32;i=i+1) RegFile[i] <= 0;
    end else if (WE) begin
        RegFile[wR] <= (wR == 0) ? 32'b0 : wD;
    end else begin
    end
end

assign rD1 = RegFile[rR1];
assign rD2 = RegFile[rR2];
endmodule
