//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/06/2021 02:04:49 PM
// Design Name: 
// Module Name: IF
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


module IF(
    input           clk_i,
    input   [31:0]  Imm_J,
    input   [31:0]  pc,
    input   [31:0]  Imm_B,
    input   [31:0]  Jalr,
    input   [1:0]   pc_sel,
    input           Branch_legal,
    
    output  [31:0]  npc
//    output  [31:0]  instruction
    );
    
    wire [31:0]  _Imm_B;
    assign _Imm_B = (Branch_legal == 1) ? Imm_B : (pc + 32'h4);
    
    NPC NPC(
        .clk_i      (clk_i),
        .pc         (pc),
        .Imm_J      (Imm_J),
        .Imm_B      (_Imm_B),
        .Jalr       (Jalr),
        .pc_sel     (pc_sel),
        .npc        (npc)
    );
    
//    PC PC(
//        .clk_i  (clk_i),
//        .rst_i  (rst_i),
//        .PC_i   (npc),
//        .PC_o   (pc)
//    );
    
//    IROM IROM(
//        .PC_i           (pc),
//        .instruction_o  (instruction)
//    );
    
endmodule
