module EX2MEM (
    input           clk,
    input           rst_n,

    input   [31:0]  EX_ALU_C,
    input           EX_mem_write,
    input   [31:0]  EX_reg2_data,
    input   [31:0]  EX_Imm_U,
    input   [1:0]   EX_wb_sel,
    input   [31:0]  EX_pc,
    input           EX_wd_sel,
    input   [4:0]   EX_rd,
    input           EX_reg_write,

    output  [31:0]  MEM_ALU_C,
    output          MEM_mem_write,
    output  [31:0]  MEM_reg2_data,
    output  [31:0]  MEM_Imm_U,
    output  [1:0]   MEM_wb_sel,
    output  [31:0]  MEM_pc,
    output          MEM_wd_sel,
    output  [4:0]   MEM_rd,
    output          EX_reg_write
);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        MEM_ALU_C <= 0;
    end else begin
        MEM_ALU_C <= EX_ALU_C;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        MEM_mem_write <= 0;
    end else begin
        MEM_mem_write <= EX_mem_write;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        MEM_reg2_data <= 0;
    end else begin
        MEM_reg2_data <= EX_reg2_data;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        MEM_Imm_U <= 0;
    end else begin
        MEM_Imm_U <= EX_Imm_U;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        MEM_wb_sel <= 0;
    end else begin
        MEM_wb_sel <= EX_wb_sel;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        MEM_pc <= 0;
    end else begin
        MEM_pc <= EX_pc;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        MEM_wd_sel <= 0;
    end else begin
        MEM_wd_sel <= EX_wd_sel;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        MEM_rd  <= 0;
    end else begin
        MEM_rd  <= EX_rd;
    end 
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        MEM_reg_write <= 0;
    end else begin
        MEM_reg_write <= EX_reg_write;
    end
end

endmodule