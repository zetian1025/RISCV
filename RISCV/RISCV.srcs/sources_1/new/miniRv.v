//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/06/2021 07:46:40 PM
// Design Name: 
// Module Name: miniRv
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


module miniRv(
    input clk_i,
    input rst_i,
    
    output          debug_wb_have_inst,
    output  [31:0]  debug_wb_pc,
    output          debug_wb_ena,
    output  [4:0]   debug_wb_reg,
    output reg [31:0]  debug_wb_value,
    
    output [31:0] _pc_i,
    input  [31:0] instruction,
    output [31:0] _ALU_C,
    input  [31:0] DRAM_RD,
    output        _mem_write,
    output [31:0] _reg2_data
    );
    
    // IF
    wire [31:0] pc;
    wire [31:0] npc;
//    wire [31:0] instruction;
    
    // ID
    wire [6:0]  opcode;
    wire [6:0]  funct7;
    wire [2:0]  funct3;
    
    // Decode registers
    wire [4:0]  rs1, rs2;
    wire [4:0]  rd;
    
    // Decode different kinds of Immediate number
    wire [31:0] Imm32;
    wire [31:0] Imm_I;
    wire [31:0] Imm_S;
    wire [31:0] Imm_U;
    wire [31:0] Imm_J;
    wire [31:0] Imm_B;
    
    // Assign decode instruction to variables
    assign opcode = instruction[6:0];
    assign funct3 = instruction[14:12];
    assign funct7 = instruction[31:25];
    
    assign rs1 = instruction[19:15];
    assign rs2 = instruction[24:20];
    assign rd  = instruction[11:7];
    
    assign Imm_I = {(instruction[31] == 1 ? 20'hfffff : 20'h0), instruction[31:20]};
    assign Imm_S = {(instruction[31] == 1 ? 20'hfffff : 20'h0), instruction[31:25], instruction[11:7]};
    assign Imm_B = {(instruction[31] == 1 ? 19'h7ffff : 19'h0), instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0} + pc;
    assign Imm_U = instruction[31:12]<<12;
    assign Imm_J = {(instruction[31] == 1 ? 11'h7ff : 11'h0), instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0} + pc;
    
    // Register file
    wire [31:0] reg1_data;
    wire [31:0] reg2_data;
    wire [31:0] write_data;
    wire [31:0] Jalr;
    
    assign Jalr  = (Imm32 & -1) + reg1_data;

    // ALU
    wire [31:0] ALU_A;
    wire [31:0] ALU_B;
    wire [31:0] ALU_C;
    wire        Branch_legal;
    
    // DRAM
//    wire [31:0] DRAM_RD;
    wire [31:0] wb_data;
    
    //Control signals
    wire [2:0]  alu_op;
    wire        reg_write;
    wire        alu_A_sel;
    wire        alu_B_sel;
    wire        mem_write;
    wire [1:0]  Imm_sel;
    wire [2:0]  branch_sel;
    wire [1:0]  pc_sel;
    wire        wd_sel;
    wire [1:0]  wb_sel;
    
    // IF
    IF instruction_fetch(
        .clk_i      (clk_i),
//        .rst_i      (rst_i),
        .pc         (pc),
        .Imm_B      (Imm_B),
        .Imm_J      (Imm_J),
        .Jalr       (Jalr),
        .pc_sel     (pc_sel),
        .Branch_legal(Branch_legal),
        .npc        (npc)
//        .instruction(instruction)
    );

    PC PC(
        .clk_i  (clk_i),
        .rst_i  (rst_i),
        .PC_i   (npc),
        .PC_o   (pc)
    );
    
    Mux_Imm Mux_Imm(
        .Imm_I      (Imm_I),
        .Imm_S      (Imm_S),
        .Imm_U      (Imm_U),
        .Imm_B      (Imm_B),
        .Imm_sel    (Imm_sel),
        .Imm_O      (Imm32)
    );
    
    // ID
    Mux_wd Mux_wd(
        .pc         (pc),
        .wb_data    (wb_data),
        .wd_sel     (wd_sel),
        .wd         (write_data)
    );
    
    RegFile Regfile(
        .clk_i  (clk_i),
        .rst_i  (rst_i),
        .rR1    (rs1),
        .rR2    (rs2),
        .wR     (rd),
        .WE     (reg_write),
        .wD     (write_data),
        .rD1    (reg1_data),
        .rD2    (reg2_data)
    );
    
    Control Control(
        .rst_i      (rst_i),
        .opcode     (opcode),
        .funct3     (funct3),
        .funct7     (funct7),
        .Imm_sel    (Imm_sel),
        .wd_sel     (wd_sel),
        .wb_sel     (wb_sel),
        .pc_sel     (pc_sel),
        .branch_sel (branch_sel),
        .alu_op     (alu_op),
        .alu_A_sel  (alu_A_sel),
        .alu_B_sel  (alu_B_sel),
        .reg_write  (reg_write),
        .mem_write  (mem_write)
    );
    
    // EX
//    Mux_op_A Mux_op_A(
//        .reg1_data      (reg1_data),
//        .pc             (pc),
//        .op_A_sel       (alu_A_sel),
//        .ALU_A          (ALU_A)
//    );
    assign ALU_A    = reg1_data;
    
    Mux_op_B Mux_op_B(
        .reg2_data      (reg2_data),
        .Imm32          (Imm32),
        .op_B_sel       (alu_B_sel),
        .ALU_B          (ALU_B)
    );
    
    ALU ALU(
        .A          (ALU_A),
        .B          (ALU_B),
        .branch_sel (branch_sel),
        .ALUCtrl    (alu_op),
        .C          (ALU_C),
        .branch_legal       (Branch_legal)
    );
    
    // MEM
//    dram U_dram (
//        .clk    (clk_i),            // input wire clka
//        .a      (ALU_C[15:2]),     // input wire [13:0] addra
//        .qspo   (DRAM_RD),        // output wire [31:0] douta
//        .we     (mem_write),          // input wire [0:0] wea
//        .d      (reg2_data)         // input wire [31:0] dina
//    );
    
    // WB
    Mux_wb Mux_wb(
        .ALU_C      (ALU_C),
        .DRAM_RD    (DRAM_RD),
        .Imm_U      (Imm_U),
        .wb_sel     (wb_sel),
        .wb_data    (wb_data)
    );
    
    // debug
    assign debug_wb_have_inst   = 1;
    assign debug_wb_pc          = pc;
    assign debug_wb_ena         = reg_write;
    assign debug_wb_reg         = rd;
    always @(negedge clk_i) begin
        debug_wb_value          <= write_data;
    end
    
    assign _pc_i                = pc;
//    assign _instruction         = instruction;
    assign _ALU_C               = ALU_C;
//    assign _DRAM_RD             = DRAM_RD;
    assign _mem_write           = mem_write;
    assign _reg2_data           = reg2_data;
    
endmodule
