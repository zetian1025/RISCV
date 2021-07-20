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

module Mux_wd(
    input [31:0]    pc,
    input [31:0]    wb_data,
    input           wd_sel,
    output[31:0]    wd
);
    
    reg [31:0] _wd;
    
    always @(*) begin
        case(wd_sel)
            `choose_pc: _wd = pc + 32'h4;
            `choose_wb: _wd = wb_data;
        endcase
    end
    
    assign wd = _wd;
endmodule
