module MEM2WB (
    input           clk,
    input           rst_n,
    input   [31:0]  MEM_pc,
    input   [31:0]  MEM_wb_data,
    input           MEM_wd_sel,
    input   [4:0]   MEM_rd,
    input           MEM_reg_write,
    input           MEM_have_inst,

    output  reg  [31:0]  WB_pc,
    output  reg  [31:0]  WB_wb_data,
    output  reg          WB_wd_sel,
    output  reg  [4:0]   WB_rd,
    output  reg          WB_reg_write,
    output  reg          WB_have_inst
);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        WB_pc <= 0;
    end else begin
        WB_pc <= MEM_pc;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        WB_wb_data <= 0;
    end else begin
        WB_wb_data <= MEM_wb_data;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        WB_wd_sel <= 0;
    end else begin
        WB_wd_sel <= MEM_wd_sel;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        WB_rd <= 0;
    end else begin
        WB_rd <= MEM_rd;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        WB_reg_write <= 0;
    end else begin
        WB_reg_write <= MEM_reg_write;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        WB_have_inst <= 0;
    end else begin
        WB_have_inst <= MEM_have_inst;
    end
end


endmodule
