//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/07 13:42:19
// Design Name: 
// Module Name: top
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


module top(
    input clk,
    input rst_n,
    output        debug_wb_have_inst,   // WB�׶��Ƿ���ָ�� (�Ե�����CPU����flag��Ϊ1)
    output [31:0] debug_wb_pc,          // WB�׶ε�PC (��wb_have_inst=0�������Ϊ����ֵ)
    output        debug_wb_ena,         // WB�׶εļĴ���дʹ�� (��wb_have_inst=0�������Ϊ����ֵ)
    output [4:0]  debug_wb_reg,         // WB�׶�д��ļĴ����� (��wb_ena��wb_have_inst=0�������Ϊ����ֵ)
    output [31:0] debug_wb_value        // WB�׶�д��Ĵ�����ֵ (��wb_ena��wb_have_inst=0�������Ϊ����ֵ)
);
    wire [31:0] pc_i, instruction;
    wire [31:0] ALU_C, DRAM_RD;
    wire        mem_write;
    wire [31:0] reg2_data;
    

    miniRv mini_rv_u (
        .clk_i  (clk),
        .rst_i  (rst_n),
        
        .debug_wb_have_inst (debug_wb_have_inst),
        .debug_wb_pc        (debug_wb_pc),
        .debug_wb_ena       (debug_wb_ena),
        .debug_wb_reg       (debug_wb_reg),
        .debug_wb_value     (debug_wb_value),
        
        ._pc_i               (pc_i),
        .instruction         (instruction),
        
        ._ALU_C              (ALU_C),
        .DRAM_RD             (DRAM_RD),
        ._mem_write          (mem_write),
        ._reg2_data          (reg2_data)
    );
    
    prgrom imem(
        .a      (pc_i[15:2]),
        .spo    (instruction)
    );
    
    dram dmem (
        .clk    (clk),            // input wire clka
        .a      (ALU_C[15:2]),     // input wire [13:0] addra
        .spo    (DRAM_RD),        // output wire [31:0] douta
        .we     (mem_write),          // input wire [0:0] wea
        .d      (reg2_data)         // input wire [31:0] dina
    );
endmodule
