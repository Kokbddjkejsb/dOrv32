`timescale 1ns / 1ps

// Create Date: 2024/12/05 14:15:28

module ex_mem(
    input clk,
    input rst,

    input wire[6:0] opcode_in,
    input wire[2:0] funct3_in,
    input wire[4:0] rd_addr_in,
    input wire[31:0] rd_data_in,
    input wire[31:0] rs2_data_in,
    input wire[31:0] ram_addr_in,

    output wire[6:0] opcode_out,
    output wire[2:0] funct3_out,
    output wire[4:0] rd_addr_out,
    output wire[31:0] rd_data_out,
    output wire[31:0] rs2_data_out,
    output wire[31:0] ram_addr_out
    );

dff_set_#(7)  dff0(clk, rst, opcode_in, opcode_out, `OPC_ALI);//nop
dff_set_#(3)  dff1(clk, rst, funct3_in, funct3_out, 3'h0);
dff_set_#(5)  dff2(clk, rst, rd_addr_in, rd_addr_out, 5'h0);
dff_set_#(32) dff3(clk, rst, rd_data_in, rd_data_out, 32'h00000000);
dff_set_#(32) dff4(clk, rst, rs2_data_in, rs2_data_out, 32'h0);
dff_set_#(32) dff5(clk, rst, ram_addr_in, ram_addr_out, 32'h00000000);

endmodule
