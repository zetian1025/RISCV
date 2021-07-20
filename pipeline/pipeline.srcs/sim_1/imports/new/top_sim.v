`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/08 11:55:35
// Design Name: 
// Module Name: top_sim
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


`timescale 1ns / 1ps
module top_sim();
    // input
    reg fpga_clk = 0;
    // output
    wire clk_lock;
    wire pll_clk;
    wire cpu_clk;

    always #5 fpga_clk = ~fpga_clk;

    cpuclk UCLK (
        .clk_in1    (fpga_clk),
        .locked     (clk_lock),
        .clk_out1   (pll_clk)
    );

    assign cpu_clk = pll_clk & clk_lock;
    
    reg         rst_i;
    wire [31:0] debug_wb_pc, debug_wb_value;
    wire        debug_wb_ena, debug_wb_have_inst;
    wire [4:0]  debug_wb_reg;    
    miniRv miniRv(
        .clk                (cpu_clk),
        .rst_n              (rst_i),
        .debug_wb_pc        (debug_wb_pc),          // WB阶段的PC (若wb_have_inst=0，此项可为任意值)
        .debug_wb_value     (debug_wb_value),
        .debug_wb_ena       (debug_wb_ena),
        .debug_wb_have_inst (debug_wb_have_inst),
        .debug_wb_reg       (debug_wb_reg)
    );
    
    initial begin
        rst_i = 0;
        #4300 rst_i = 1;
    end

endmodule
