//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/06 13:28:34
// Design Name: 
// Module Name: Imm
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


module Mux_Imm(
    input   [31:0]      Imm_I,
    input   [31:0]      Imm_S,
    input   [31:0]      Imm_U,
    input   [31:0]      Imm_B,
    input   [1:0]       Imm_sel,
    output  [31:0]      Imm_O
    );
    
    reg [31:0]  Imm;
    always @(*) begin
        case (Imm_sel)
            `I: begin Imm = Imm_I; end
            `S: begin Imm = Imm_S; end
            `B: begin Imm = Imm_B; end
            `U: begin Imm = Imm_U; end
            default:;
        endcase
    end
    
    assign Imm_O = Imm;
    
endmodule
