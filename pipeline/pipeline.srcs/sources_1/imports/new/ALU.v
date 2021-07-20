//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/05 20:45:00
// Design Name: 
// Module Name: ALU
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
`include "PARAM.v"

module ALU(
    input  wire [31:0]  A,
    input  wire [31:0]  B,
    input       [2:0]   ALUCtrl,
    input       [2:0]   branch_sel,
    
    output reg  [31:0]  C,
    output reg          branch_legal
    );

    always @(A, B, ALUCtrl) begin
        case (ALUCtrl)
            `add: begin C = A + B;  end
            `sub: begin C = A - B;  end
            `and: begin C = A & B;  end
            `or:  begin C = A | B;  end
            `xor: begin C = A ^ B;  end
            `sll: begin C = A << B[4:0]; end
            `sra: begin C = ($signed(A) >>> B[4:0]); end
            `srl: begin C = A >> B[4:0]; end
        endcase
    end
    
    always @(C, branch_sel) begin
        case (branch_sel)
            `beq:   branch_legal = (C == 0) ? 1 : 0;
            `bne:   branch_legal = (C == 0) ? 0 : 1;
            `blt:   branch_legal = (C[31] == 1) ? 1 : 0;
            `bge:   branch_legal = (C[31] == 0) ? 1 : 0;
        endcase
    end
    
endmodule
