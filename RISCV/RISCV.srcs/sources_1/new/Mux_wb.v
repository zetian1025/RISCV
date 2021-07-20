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

module Mux_wb(
    input [31:0]    ALU_C,
    input [31:0]    DRAM_RD,
    input [31:0]    Imm_U,
    input [1:0]     wb_sel,
    
    output[31:0]    wb_data
);
    reg [31:0] _wb_data;

    always @(*) begin
        case(wb_sel)
            `choose_ALU: _wb_data = ALU_C;
            `choose_DRAM:  _wb_data = DRAM_RD;
            `choose_IMM: _wb_data = Imm_U;
            default:;
        endcase
    end
    
    assign wb_data = _wb_data;
endmodule
