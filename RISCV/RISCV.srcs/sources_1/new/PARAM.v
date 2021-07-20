`define add 3'b000
`define sub 3'b001
`define and 3'b010
`define or  3'b011
`define xor 3'b100
`define sll 3'b101
`define sra 3'b110
`define srl 3'b111

`define above_zero  2'b10
`define below_zero  2'b01
`define definitly_zero  2'b00

    
`define PC_default  2'b00
`define PC_branch   2'b01
`define PC_J_inst   2'b10
`define PC_Jalr     2'b11

`define choose_RF       1'b0
`define choose_pc       1'b1
`define choose_im       1'b1

    
`define I   2'b00
`define S   2'b01
`define U   2'b10
`define B   2'b11

`define choose_ALU  2'b00
`define choose_DRAM 2'b01
`define choose_IMM  2'b10

`define choose_wb 1'b0

`define type_R 7'b0110011
`define type_I 7'b0010011
`define lw     7'b0000011
`define jalr   7'b1100111
`define sw     7'b0100011
`define type_B 7'b1100011
`define lui    7'b0110111
`define jal    7'b1101111

`define YES 1'b1
`define NO  1'b0

`define beq 3'b000
`define bne 3'b001
`define blt 3'b100
`define bge 3'b101