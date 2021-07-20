module ID2EX(
    input           clk,
    input           rst_n,

    input           ID_mem_write,
    input   [31:0]  ID_reg2_data,
    input   [31:0]  ID_Imm_U,
    input   [1:0]   ID_wb_sel,
    input   [31:0]  ID_pc,
    input           ID_wd_sel,
    input   [31:0]  ID_ALU_A,
    input   [31:0]  ID_ALU_B;
    input   [2:0]   ID_branch_sel,
    input   [2:0]   ID_alu_op,
    input   [31:0]  ID_Imm_J,
    input   [31:0]  ID_Imm_B,
    input   [31:0]  ID_Jalr,
    input   [1:0]   ID_pc_sel,
    input   [4:0]   ID_rd,
    input           ID_reg_write,
    
    output           EX_mem_write,
    output   [31:0]  EX_reg2_data,
    output   [31:0]  EX_Imm_U,
    output   [1:0]   EX_wb_sel,
    output   [31:0]  EX_pc,
    output           EX_wd_sel,
    output   [31:0]  EX_ALU_A,
    output   [31:0]  EX_ALU_B;
    output   [2:0]   EX_branch_sel,
    output   [2:0]   EX_alu_op,
    output   [31:0]  EX_Imm_J,
    output   [31:0]  EX_Imm_B,
    output   [31:0]  EX_Jalr,
    output   [1:0]   EX_pc_sel,
    output   [4:0]   EX_rd,
    output           EX_reg_write
);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        EX_mem_write <= 0;
    end else begin
        EX_mem_write <= ID_mem_write;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        EX_reg2_data <= 0;
    end else begin
        EX_reg2_data <= ID_reg2_data;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        EX_Imm_U <= 0;
    end else begin
        EX_Imm_U <= ID_Imm_U;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        EX_wb_sel <= 0;
    end else begin
        EX_wb_sel <= ID_wb_sel;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        EX_pc <= 0;
    end else begin
        EX_pc <= ID_pc;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        EX_wd_sel <= 0;
    end else begin
        EX_wd_sel <= ID_wd_sel;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        EX_ALU_A<= 0;
    end else begin
        EX_ALU_A<= ID_ALU_A;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        EX_ALU_B<= 0;
    end else begin
        EX_ALU_B<= ID_ALU_B;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        EX_branch_sel<= 0;
    end else begin
        EX_branch_sel<= ID_branch_sel;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        EX_alu_op <= 0;
    end else begin
        EX_alu_op <= ID_alu_op;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        EX_Imm_J <= 0;
    end else begin
        EX_Imm_J <= ID_Imm_J;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        EX_Imm_B <= 0;
    end else begin
        EX_Imm_B <= ID_Imm_B;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        EX_Jalr <= 0;
    end else begin
        EX_Jalr <= ID_Jalr;
    end
end


always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        EX_pc_sel <= 0;
    end else begin
        EX_pc_sel <= ID_pc_sel;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        EX_rd <= 0;
    end else begin
        EX_rd <= ID_rd;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        EX_reg_write <= 0;
    end else begin
        EX_reg_write <= ID_reg_write;
    end
end

endmodule