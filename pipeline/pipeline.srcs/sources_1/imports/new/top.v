module top(
    input clk,
    input rst_n,
    
    output             debug_wb_have_inst,
    output     [31:0]  debug_wb_pc,
    output             debug_wb_ena,
    output     [4:0]   debug_wb_reg,
    output reg [31:0]  debug_wb_value
    );
    
    // IF
    wire [31:0] IF_pc;
    wire [31:0] IF_npc;
    wire [31:0] IF_instruction;
    
    // ID
    reg [31:0]  ID_instruction;
    reg [31:0]  ID_pc;
    wire [6:0]  ID_opcode;
    wire [6:0]  ID_funct7;
    wire [2:0]  ID_funct3;
    
    // Decode registers
    wire [4:0]  ID_rs1, ID_rs2;
    wire [4:0]  ID_rd;
    
    // Decode different kinds of Immediate number
    wire [31:0] ID_Imm32;
    wire [31:0] ID_Imm_I;
    wire [31:0] ID_Imm_S;
    wire [31:0] ID_Imm_U;
    wire [31:0] ID_Imm_J;
    wire [31:0] ID_Imm_B;
    
    // Register file
    wire [31:0] ID_reg1_data;
    wire [31:0] ID_reg2_data;
    wire [31:0] ID_write_data;
    wire [31:0] ID_Jalr;
    wire [31:0] ID_ALU_B;
    wire [31:0] ID_ALU_A;
    
    assign ID_Jalr  = (ID_Imm32 & -1) + ID_reg1_data;

    // EX
    wire [31:0]     EX_ALU_C;
    reg             EX_mem_write;
    reg  [31:0]     EX_reg2_data;
    reg  [31:0]     EX_Imm_U;
    reg  [1:0]      EX_wb_sel;
    reg  [31:0]     EX_pc;
    reg             EX_wd_sel;

    reg  [31:0]     EX_ALU_A;
    reg  [31:0]     EX_ALU_B;
    reg  [2:0]      EX_branch_sel;
    reg  [2:0]      EX_alu_op;
    wire            EX_Branch_legal;

    reg  [31:0]     EX_Imm_J;
    reg  [31:0]     EX_Imm_B;
    reg  [31:0]     EX_Jalr;
    reg  [1:0]      EX_pc_sel;
    wire [31:0]     EX_npc;

    reg  [4:0]      EX_rd;
    reg             EX_reg_write;

    // DRAM
    reg  [31:0]  MEM_ALU_C;
    wire [31:0]  MEM_DRAM_RD;
    reg          MEM_mem_write;
    reg  [31:0]  MEM_reg2_data;
    reg  [31:0]  MEM_Imm_U;
    reg  [1:0]   MEM_wb_sel;
    wire [31:0]  MEM_wb_data;
    reg  [31:0]  MEM_pc;
    reg          MEM_wd_sel;
    reg  [4:0]   MEM_rd;
    reg          MEM_reg_write;
    wire [31:0]  MEM_DRAM_RD;

    // WB
    reg  [31:0]      WB_pc;
    reg  [31:0]      WB_wb_data;
    reg              WB_wd_sel;
    reg  [4:0]       WB_rd;
    reg              WB_reg_write;
    wire [31:0]      WB_write_data;
    
    //Control signals
    wire [2:0]  ID_alu_op;
    wire        ID_reg_write;
    wire        ID_alu_A_sel;
    wire        ID_alu_B_sel;
    wire        ID_mem_write;
    wire [1:0]  ID_Imm_sel;
    wire [2:0]  ID_branch_sel;
    wire [1:0]  ID_pc_sel;
    wire        ID_wd_sel;
    wire [1:0]  ID_wb_sel;

    //debug
    reg ID_have_inst;
    reg EX_have_inst;
    reg MEM_have_inst;
    reg WB_have_inst;
    
    // IF
    inst_mem imem(
        .a      (EX_pc[15:2]),
        .spo    (IF_instruction)
    );

    PC PC(
        .clk    (clk),
        .rst_n  (rst_n),
        .PC_i   (EX_npc),
        .PC_o   (IF_pc)
    );

    // IF2ID

    IF2ID IF2ID(
    	.clk            (clk            ),
        .rst_n          (rst_n          ),
        .IF_pc          (IF_pc          ),
        .IF_instruction (IF_instruction ),
        .ID_pc          (ID_pc          ),
        .ID_instruction (ID_instruction )
    );

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            ID_have_inst <= 0;
        end else if (IF_instruction != ID_instruction) begin
            ID_have_inst <= 1;
        end else begin
            ID_have_inst <= 0;
        end
    end

    // ID
    // Assign decode instruction to variables
    assign ID_opcode = ID_instruction[6:0];
    assign ID_funct3 = ID_instruction[14:12];
    assign ID_funct7 = ID_instruction[31:25];
    
    assign ID_rs1 = ID_instruction[19:15];
    assign ID_rs2 = ID_instruction[24:20];
    assign ID_rd  = ID_instruction[11:7];
    
    assign ID_Imm_I = {(ID_instruction[31] == 1 ? 20'hfffff : 20'h0), ID_instruction[31:20]};
    assign ID_Imm_S = {(ID_instruction[31] == 1 ? 20'hfffff : 20'h0), ID_instruction[31:25], ID_instruction[11:7]};
    assign ID_Imm_B = {(ID_instruction[31] == 1 ? 19'h7ffff : 19'h0), ID_instruction[31], ID_instruction[7], ID_instruction[30:25], ID_instruction[11:8], 1'b0} + ID_pc;
    assign ID_Imm_U = ID_instruction[31:12]<<12;
    assign ID_Imm_J = {(ID_instruction[31] == 1 ? 11'h7ff : 11'h0), ID_instruction[31], ID_instruction[19:12], ID_instruction[20], ID_instruction[30:21], 1'b0} + ID_pc;

    Mux_Imm Mux_Imm(
        .Imm_I      (ID_Imm_I),
        .Imm_S      (ID_Imm_S),
        .Imm_U      (ID_Imm_U),
        .Imm_B      (ID_Imm_B),
        .Imm_sel    (ID_Imm_sel),
        .Imm_O      (ID_Imm32)
    );
    
    RegFile Regfile(
        .clk    (clk),
        .rst_n  (rst_n),
        .rR1    (ID_rs1),
        .rR2    (ID_rs2),
        .wR     (WB_rd),
        .WE     (WB_reg_write),
        .wD     (WB_write_data),
        .rD1    (ID_reg1_data),
        .rD2    (ID_reg2_data)
    );
    
    Control Control(
        .rst_n      (rst_n),
        .opcode     (ID_opcode),
        .funct3     (ID_funct3),
        .funct7     (ID_funct7),
        .Imm_sel    (ID_Imm_sel),
        .wd_sel     (ID_wd_sel),
        .wb_sel     (ID_wb_sel),
        .pc_sel     (ID_pc_sel),
        .branch_sel (ID_branch_sel),
        .alu_op     (ID_alu_op),
        .alu_A_sel  (ID_alu_A_sel),
        .alu_B_sel  (ID_alu_B_sel),
        .reg_write  (ID_reg_write),
        .mem_write  (ID_mem_write)
    );
    
    assign ID_ALU_A    = ID_reg1_data;
    Mux_op_B Mux_op_B(
        .reg2_data      (ID_reg2_data),
        .Imm32          (ID_Imm32),
        .op_B_sel       (ID_alu_B_sel),
        .ALU_B          (ID_ALU_B)
    );
    
    // ID2EX
    ID2EX ID2EX(
    	.clk           (clk           ),
        .rst_n         (rst_n         ),
        .ID_mem_write  (ID_mem_write  ),
        .ID_reg2_data  (ID_reg2_data  ),
        .ID_Imm_U      (ID_Imm_U      ),
        .ID_wb_sel     (ID_wb_sel     ),
        .ID_pc         (ID_pc         ),
        .ID_wd_sel     (ID_wd_sel     ),
        .ID_ALU_A      (ID_ALU_A      ),
        .ID_ALU_B      (ID_ALU_B      ),
        .ID_branch_sel (ID_branch_sel ),
        .ID_alu_op     (ID_alu_op     ),
        .ID_Imm_J      (ID_Imm_J      ),
        .ID_Imm_B      (ID_Imm_B      ),
        .ID_Jalr       (ID_Jalr       ),
        .ID_pc_sel     (ID_pc_sel     ),
        .ID_rd         (ID_rd         ),
        .ID_reg_write  (ID_reg_write  ),
        .ID_have_inst  (ID_have_inst  ),
        .EX_mem_write  (EX_mem_write  ),
        .EX_reg2_data  (EX_reg2_data  ),
        .EX_Imm_U      (EX_Imm_U      ),
        .EX_wb_sel     (EX_wb_sel     ),
        .EX_pc         (EX_pc         ),
        .EX_wd_sel     (EX_wd_sel     ),
        .EX_ALU_A      (EX_ALU_A      ),
        .EX_ALU_B      (EX_ALU_B      ),
        .EX_branch_sel (EX_branch_sel ),
        .EX_alu_op     (EX_alu_op     ),
        .EX_Imm_J      (EX_Imm_J      ),
        .EX_Imm_B      (EX_Imm_B      ),
        .EX_Jalr       (EX_Jalr       ),
        .EX_pc_sel     (EX_pc_sel     ),
        .EX_rd         (EX_rd         ),
        .EX_reg_write  (EX_reg_write  ),
        .EX_have_inst  (EX_have_inst  )
    );
    

    // EX
    ALU ALU(
        .A                  (EX_ALU_A),
        .B                  (EX_ALU_B),
        .branch_sel         (EX_branch_sel),
        .ALUCtrl            (EX_alu_op),
        .C                  (EX_ALU_C),
        .branch_legal       (EX_Branch_legal)
    );
    
    NPC NPC(
        .clk            (clk),
        .rst_n          (rst_n),
        .pc             (EX_pc),
        .Imm_J          (EX_Imm_J),
        .Imm_B          ((EX_Branch_legal == 1) ? EX_Imm_B : (EX_pc + 32'h4)),
        .Jalr           (EX_Jalr),
        .pc_sel         (EX_pc_sel),
        .npc            (EX_npc)
    );

    // EX2MEM
    EX2MEM EX2MEM(
        .clk           (clk           ),
        .rst_n         (rst_n         ),
        .EX_ALU_C      (EX_ALU_C      ),
        .EX_mem_write  (EX_mem_write  ),
        .EX_reg2_data  (EX_reg2_data  ),
        .EX_Imm_U      (EX_Imm_U      ),
        .EX_wb_sel     (EX_wb_sel     ),
        .EX_pc         (EX_pc         ),
        .EX_wd_sel     (EX_wd_sel     ),
        .EX_rd         (EX_rd         ),
        .EX_reg_write  (EX_reg_write  ),
        .EX_have_inst  (EX_have_inst  ),
        .MEM_ALU_C     (MEM_ALU_C     ),
        .MEM_mem_write (MEM_mem_write ),
        .MEM_reg2_data (MEM_reg2_data ),
        .MEM_Imm_U     (MEM_Imm_U     ),
        .MEM_wb_sel    (MEM_wb_sel    ),
        .MEM_pc        (MEM_pc        ),
        .MEM_wd_sel    (MEM_wd_sel    ),
        .MEM_rd        (MEM_rd        ),
        .MEM_reg_write (MEM_reg_write ),
        .MEM_have_inst (MEM_have_inst )
    );

    // MEM
    data_mem U_dram (
        .clk    (clk),                  // input wire clka
        .a      (MEM_ALU_C[15:2]),      // input wire [13:0] addra
        .spo    (MEM_DRAM_RD),          // output wire [31:0] douta
        .we     (MEM_mem_write),        // input wire [0:0] wea
        .d      (MEM_reg2_data)         // input wire [31:0] dina
    );

    Mux_wb Mux_wb(
        .ALU_C      (MEM_ALU_C),
        .DRAM_RD    (MEM_DRAM_RD),
        .Imm_U      (MEM_Imm_U),
        .wb_sel     (MEM_wb_sel),
        .wb_data    (MEM_wb_data)
    );

    // MEM2WB
    MEM2WB MEM2WB(
        .clk            (clk),
        .rst_n          (rst_n),
        .MEM_pc         (MEM_pc),
        .MEM_wb_data    (MEM_wb_data),
        .MEM_wd_sel     (MEM_wd_sel),
        .MEM_rd         (MEM_rd    ),
        .MEM_reg_write  (MEM_reg_write),
        .MEM_have_inst  (MEM_have_inst),
        
        .WB_pc          (WB_pc),
        .WB_wb_data     (WB_wb_data),
        .WB_wd_sel      (WB_wd_sel),
        .WB_rd          (WB_rd),
        .WB_reg_write   (WB_reg_write),
        .WB_have_inst   (WB_have_inst)
    );

    // WB
    Mux_wd Mux_wd(
        .pc         (WB_pc),
        .wb_data    (WB_wb_data),
        .wd_sel     (WB_wd_sel),
        .wd         (WB_write_data)
    );
    
    // debug
    assign debug_wb_have_inst   = WB_have_inst;
    assign debug_wb_pc          = WB_pc;
    assign debug_wb_ena         = WB_reg_write;
    assign debug_wb_reg         = WB_rd;
    //always @(negedge clk) begin
        //debug_wb_value          <= WB_write_data;
    //end
    assign debug_wb_value       = WB_write_data;

endmodule
