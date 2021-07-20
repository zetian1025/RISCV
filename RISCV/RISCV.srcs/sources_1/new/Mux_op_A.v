//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/06/2021 10:08:38 PM
// Design Name: 
// Module Name: Mux_op_B
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

module Mux_op_A(
    input [31:0]    reg1_data,
    input [31:0]    pc,
    input           op_A_sel,
    output[31:0]    ALU_A
);
    
    reg [31:0]  _ALU_A;    
    
    always @(*) begin
        case (op_A_sel)
            `choose_RF: _ALU_A = reg1_data;
            `choose_pc: _ALU_A = pc + 4;
        endcase
    end
    
    assign ALU_A = _ALU_A;
endmodule
