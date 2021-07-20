//`timescale 1ns / 1ps

module IROM(
    input   [31:0]  pc_i,
    output  [31:0]  instruction_o
);

    wire [31:0] instruction;

    // 64KB IROM
    prgrom U0_irom (
        .a      (pc_i[15:2]),   // input wire [13:0] a
        .spo    (instruction)   // output wire [31:0] spo
    );

    assign instruction_o = instruction;

endmodule
