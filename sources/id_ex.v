`timescale 1ns / 1ps

// Create Date: 2024/12/01 19:44:34

module id_ex(
    input wire clk,
    input wire rst,
    input wire jump_hold,
    input wire bubble_hold,

    input wire[31:0] pc_in,
    input wire[6:0]  opcode_in,
    input wire[2:0]  funct3_in,
    input wire[6:0]  funct7_in,
    input wire[31:0] rs1_data_in,
    input wire[31:0] rs2_data_in,
    input wire[4:0]  rd_addr_in,
    input wire[31:0] imm_in,
    input wire[4:0] rs1_addr_in,
    input wire[4:0] rs2_addr_in,

    output wire[31:0] pc_out,
    output wire[6:0]  opcode_out,
    output wire[2:0]  funct3_out,
    output wire[6:0]  funct7_out,
    output wire[31:0] rs1_data_out,
    output wire[31:0] rs2_data_out,
    output wire[4:0]  rd_addr_out,
    output wire[31:0] imm_out,
    output wire[4:0] rs1_addr_out,
    output wire[4:0] rs2_addr_out
    );
wire hold;

assign hold = jump_hold | bubble_hold;
    
dff_set_h#(32) dff0(clk, rst, hold, pc_in, pc_out,32'b0);
dff_set_h#(7)  dff1(clk, rst, hold, opcode_in, opcode_out,`OPC_ALI);//nop
dff_set_h#(3)  dff2(clk, rst, hold, funct3_in, funct3_out,3'b0);
dff_set_h#(7)  dff3(clk, rst, hold, funct7_in, funct7_out,7'b0);
dff_set_h#(32) dff4(clk, rst, hold, rs1_data_in, rs1_data_out,32'b0);
dff_set_h#(32) dff5(clk, rst, hold, rs2_data_in, rs2_data_out,32'b0);
dff_set_h#(5)  dff6(clk, rst, hold, rd_addr_in, rd_addr_out,5'b0);
dff_set_h#(32) dff7(clk, rst, hold, imm_in, imm_out,32'b0);
dff_set_h#(5)  dff8(clk, rst, hold, rs1_addr_in, rs1_addr_out,5'b0);
dff_set_h#(5)  dff9(clk, rst, hold, rs2_addr_in, rs2_addr_out,5'b0);

endmodule
