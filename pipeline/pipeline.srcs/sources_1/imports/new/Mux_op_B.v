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


module Mux_op_B(
    input [31:0]    reg2_data,
    input [31:0]    Imm32,
    input           op_B_sel,
    output [31:0]   ALU_B
    );
    
    reg [31:0]  _ALU_B;
    
    always @(*) begin
        case(op_B_sel)
            `choose_RF: _ALU_B = reg2_data;
            `choose_im: _ALU_B = Imm32;
        endcase
    end
    
    assign ALU_B = _ALU_B;
endmodule
