//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/06/2021 02:04:37 PM
// Design Name: 
// Module Name: NPC
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


module NPC(
    input           clk,
    input           rst_n,
    input           pipeline_stop,
    inpu    [31:0]  ID_pc,
    input   [31:0]  pc,
    input   [31:0]  Imm_J,
    input   [31:0]  Imm_B,
    input   [31:0]  Jalr,
    input   [1:0]   pc_sel,
    output  [31:0]  npc
    );


    reg [31:0] _npc;

    always @(negedge clk or negedge rst_n) begin
        if (!rst_n) begin
            _npc <= 0;
        end else if (pipeline_stop) begin
            _npc <= ID_pc;
        end else begin
            case(pc_sel)
                `PC_default: _npc <= pc + 32'h4;
                `PC_branch:  _npc <= Imm_B;
                `PC_J_inst:  _npc <= Imm_J;
                `PC_Jalr:    _npc <= Jalr;
            endcase
        end
    end

    assign npc = _npc;

endmodule
