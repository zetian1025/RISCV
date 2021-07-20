//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/07 13:42:19
// Design Name: 
// Module Name: top
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


module display_top(  
    input clk_i,
    input rst_n,
    input rst,
    
    output wire        led0_en,
    output wire        led1_en,
    output wire        led2_en,
    output wire        led3_en,
    output wire        led4_en,
    output wire        led5_en,
    output wire        led6_en,
    output wire        led7_en,
    output wire        led_ca ,
    output wire        led_cb ,
    output wire        led_cc ,
    output wire        led_cd ,
    output wire        led_ce ,
    output wire        led_cf ,
    output wire        led_cg ,
    output wire        led_dp
);
    wire [31:0] pc_i, instruction;
    wire [31:0] ALU_C, DRAM_RD;
    wire        mem_write;
    wire [31:0] reg2_data;
    wire [31:0] debug_wb_pc, debug_wb_value;
    wire        debug_wb_ena, debug_wb_have_inst;
    wire [4:0]  debug_wb_reg;
    
//    reg clk;
//    reg [22:0] cnt;
//    always @(posedge clk_i or negedge rst) begin
//        if (!rst) begin
//            cnt <= 0;
//            clk <= 0;
//        end else if (cnt == 0) begin
//            clk <= ~clk;
//            cnt <= cnt + 1;
//        end else begin
//            cnt <= cnt + 1;
//        end
//    end

    wire clk_lock, pll_clk, clk;
    cpuclk UCLK(
        .clk_in1        (clk_i),
        .locked         (clk_lock),
        .clk_out1       (pll_clk)
    );
    
    assign clk = pll_clk & clk_lock;
    
    reg clk_v;
    reg [11:0] cnt_v;
    always @(posedge clk_i or negedge rst) begin
        if (!rst) begin
            cnt_v <= 0;
            clk_v <= 0;
        end else if (cnt_v == 0) begin
            clk_v <= ~clk_v;
            cnt_v <= cnt_v + 1;
        end else begin
            cnt_v <= cnt_v + 1;
        end
    end

    miniRv mini_rv_u (
        .clk_i  (clk),
        .rst_i  (rst_n),
        
        .debug_wb_have_inst (debug_wb_have_inst),
        .debug_wb_pc        (debug_wb_pc),
        .debug_wb_ena       (debug_wb_ena),
        .debug_wb_reg       (debug_wb_reg),
        .debug_wb_value     (debug_wb_value),
        
        ._pc_i               (pc_i),
        .instruction         (instruction),
        
        ._ALU_C              (ALU_C),
        .DRAM_RD             (DRAM_RD),
        ._mem_write          (mem_write),
        ._reg2_data          (reg2_data)
    );
    
    prgrom imem(
        .a      (pc_i[15:2]),
        .spo    (instruction)
    );
    
    dram dmem (
        .clk    (clk),            // input wire clka
        .a      (ALU_C[15:2]),     // input wire [13:0] addra
        .spo    (DRAM_RD),        // output wire [31:0] douta
        .we     (mem_write),          // input wire [0:0] wea
        .d      (reg2_data)         // input wire [31:0] dina
    );
    
    display display(
        .clk        (clk_v),
        .rst_n      (rst),
        .busy       (1'b0),
        .pc         (debug_wb_pc),
        .led0_en    (led0_en),
        .led1_en    (led1_en),
        .led2_en    (led2_en),
        .led3_en    (led3_en),
        .led4_en    (led4_en),
        .led5_en    (led5_en),
        .led6_en    (led6_en),
        .led7_en    (led7_en),
        .led_ca     (led_ca),
        .led_cb     (led_cb),
        .led_cc     (led_cc),
        .led_cd     (led_cd),
        .led_ce     (led_ce),
        .led_cf     (led_cf),
        .led_cg     (led_cg),
        .led_dp     (led_dp)
    );
endmodule
