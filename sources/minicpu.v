`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/04 23:54:44
// Design Name: 
// Module Name: Processor
// Project Name: minimal_cpu
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

`define ZERO  8'b00000000
`define LOAD  2'b01
`define ADD   2'b11
`define STORE 2'b10
module Processor(
    input wire clk,
    input wire rst,
    
    input  wire[7:0] ram_data_read,
    output wire[3:0] ram_addr_read,
    output wire ram_read_e,

    output wire[7:0] ram_data_write,
    output wire[3:0] ram_addr_write,
    output wire ram_write_e
    );

    reg[7:0] regs[1:0];

    reg[3:0] if_addr;
    reg[7:0] ex_data;

    reg[1:0] opcode;
    reg[3:0] ram_addr;
    reg       rs1_addr;
    reg       rs2_addr;

    reg ex_re;

    always @(posedge clk) begin
        if (!rst) begin
            if_addr <= 0;
            regs[0] <= `ZERO;
            regs[1] <= `ZERO;
            {ram_addr, rs1_addr, rs2_addr, opcode} <= `ZERO;
            ex_data <= `ZERO;
            ex_re <= 0;
        end else begin
            if_addr <= if_addr + 1;
            
            ex_data = (opcode == `LOAD)?ram_data_read:`ZERO;

            regs[rs1_addr] = (opcode == `LOAD)?ex_data:regs[rs1_addr];            
            regs[0] = (opcode == `ADD)?regs[rs1_addr]+regs[rs2_addr]:regs[0];

            ex_re <= 0;
        end
    end

    always @(negedge clk) begin
        ram_addr <= ram_data_read[7:4];
        rs1_addr <= ram_data_read[2];
        rs2_addr <= ram_data_read[4];
        opcode   <= ram_data_read[1:0];

        ex_re <= 1;
    end

    assign ram_read_e     = 1;
    assign ram_addr_read  = (ex_re)?ram_addr:if_addr;
    assign ram_data_write = (opcode == `STORE)?regs[rs1_addr]:`ZERO;
    assign ram_addr_write = (opcode == `STORE)?ram_addr:4'b0000;
    assign ram_write_e    = (opcode == `STORE)?1:0;

endmodule
