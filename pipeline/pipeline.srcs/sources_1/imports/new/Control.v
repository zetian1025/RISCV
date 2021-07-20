//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/06/2021 03:46:05 PM
// Design Name: 
// Module Name: Control
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Control(
    input           rst_n,
    input   [6:0]   opcode,
    input   [2:0]   funct3,
    input   [6:0]   funct7,
    output reg  [1:0]   Imm_sel,
    output reg          wd_sel,
    output reg  [1:0]   wb_sel,
    output reg  [1:0]   pc_sel,
    output reg  [2:0]   branch_sel,
    output reg  [2:0]   alu_op,
    output reg          alu_A_sel,
    output reg          alu_B_sel,
    output reg          reg_write,
    output reg          mem_write
    );
    
    always @(opcode, funct3, funct7) begin
        if (!rst_n) begin
            pc_sel = `PC_default;
        end else begin
            case(opcode)
                `type_R: begin
                    wd_sel = `choose_wb; wb_sel = `choose_ALU; pc_sel = `PC_default;
                    alu_A_sel = `choose_RF; alu_B_sel = `choose_RF;
                    reg_write = `YES; mem_write = `NO;

                    case(funct3)
                        3'b000: alu_op = (funct7[5] == 0) ? `add : `sub;
                        3'b111: alu_op = `and;
                        3'b110: alu_op = `or;
                        3'b100: alu_op = `xor;
                        3'b001: alu_op = `sll;
                        3'b101: alu_op = (funct7[5] == 0) ? `srl : `sra;
                    endcase
                end

                `type_I: begin
                    Imm_sel = `I; wd_sel = `choose_wb; wb_sel = `choose_ALU; pc_sel = `PC_default;
                    alu_A_sel = `choose_RF; alu_B_sel = `choose_im;
                    reg_write = `YES; mem_write = `NO;

                    case(funct3)
                        3'b000: alu_op = `add;
                        3'b111: alu_op = `and;
                        3'b110: alu_op = `or;
                        3'b100: alu_op = `xor;
                        3'b001: alu_op = `sll;
                        3'b101: alu_op = (funct7[5] == 0) ? `srl : `sra;
                    endcase
                end

                `lw: begin
                    Imm_sel = `I; wd_sel = `choose_wb; wb_sel = `choose_DRAM; pc_sel = `PC_default;
                    alu_A_sel = `choose_RF; alu_B_sel = `choose_im; alu_op = `add;
                    reg_write = `YES; mem_write = `NO;
                end

                `jalr: begin
                    Imm_sel = `I; wd_sel = `choose_pc; pc_sel = `PC_Jalr;
                    reg_write = `YES; mem_write = `NO;
                end

                `sw: begin
                    Imm_sel = `S; pc_sel = `PC_default;
                    alu_A_sel = `choose_RF; alu_B_sel = `choose_im; alu_op = `add;
                    reg_write = `NO; mem_write = `YES;
                end

                `type_B: begin
                    Imm_sel = `B; pc_sel = `PC_branch;
                    alu_A_sel = `choose_RF; alu_B_sel = `choose_RF; alu_op = `sub;
                    reg_write = `NO; mem_write = `NO;
                    branch_sel = funct3;
                end

                `lui:   begin
                    Imm_sel = `U; wd_sel = `choose_wb; wb_sel = `choose_IMM; pc_sel = `PC_default;
                    reg_write = `YES; mem_write = `NO;
                end

                `jal:   begin
                    wd_sel = `choose_pc; pc_sel = `PC_J_inst;
                    reg_write = `YES; mem_write = `NO;
                end
            endcase
        end
    end 
endmodule
