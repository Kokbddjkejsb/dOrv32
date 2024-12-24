`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/05 14:15:28
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

`include "DEFINE.vh"
module ALU(
    input wire[31:0] pc_in,
    input wire[6:0] opcode_in,
    input wire[2:0] funct3_in,
    input wire[6:0] funct7_in,
    
    input wire[31:0] rs1_data_in,
    input wire[31:0] rs2_data_in,
    input wire[31:0] imm_in,

    output wire[31:0] jaddr_out,
    output wire       jflag_out,
    output wire[31:0] ram_addr_out,
    output wire[31:0] rd_data_out
    );
wire[31:0] op2;
wire[31:0] npc;

assign op2 = 
opcode_in == `OPC_ALI ? imm_in : rs2_data_in;
assign npc = $signed(pc_in) + $signed(imm_in);

assign ram_addr_out = 
opcode_in == `OPC_STORE | opcode_in == `OPC_LOAD ? 
$signed(rs1_data_in) + $signed(imm_in) : 0;

assign rd_data_out = 
opcode_in == `OPC_JAL | opcode_in == `OPC_JALR ? pc_in + 32'h4:
(opcode_in == `OPC_AUIPC ? npc :
(opcode_in == `OPC_LUI ? imm_in :
(opcode_in == `OPC_AL | opcode_in == `OPC_ALI ?
(funct3_in == `FUNCT3_ADD ? (funct7_in[5] == 0 | opcode_in == `OPC_ALI ?
$signed(rs1_data_in) + $signed(op2) : $signed(rs1_data_in) - $signed(op2)):
(funct3_in == `FUNCT3_SLT ? ($signed(rs1_data_in) < $signed(op2) ? 32'h1 : 32'h0):
(funct3_in == `FUNCT3_SLTU ? ($unsigned(rs1_data_in) < $unsigned(op2) ? 32'h1 : 32'h0):
(funct3_in == `FUNCT3_XOR ? rs1_data_in ^ op2 : 
(funct3_in == `FUNCT3_OR ? rs1_data_in | op2 : 
(funct3_in == `FUNCT3_AND ? rs1_data_in & op2 : 
(funct3_in == `FUNCT3_SLL ? rs1_data_in << op2[4:0] :
(funct3_in == `FUNCT3_SRL ? (funct7_in[5] == 0 ?
rs1_data_in >> op2[4:0] : $signed($signed(rs1_data_in)>>>op2[4:0])):32'h0)))))))):32'h0)));

assign jaddr_out = 
opcode_in == `OPC_JAL ? npc :
(opcode_in == `OPC_JALR ? $signed(rs1_data_in) + $signed(imm_in):
(opcode_in == `OPC_BRANCH ?
({funct3_in[2],funct3_in[0]} == `FUNCT3_BEQ ? 
(rs1_data_in == rs2_data_in ? npc : pc_in):
({funct3_in[2],funct3_in[0]} == `FUNCT3_BNE ? 
(rs1_data_in != rs2_data_in ? npc : pc_in):
({funct3_in[2],funct3_in[0]} == `FUNCT3_BLT ? (funct3_in[1] == 1 ? 
($unsigned(rs1_data_in) < $unsigned(rs2_data_in) ? npc : pc_in) :
($signed(rs1_data_in) < $signed(rs2_data_in) ? npc : pc_in)):
({funct3_in[2],funct3_in[0]} == `FUNCT3_BGE ? (funct3_in[1] == 1 ? 
($unsigned(rs1_data_in) >= $unsigned(rs2_data_in) ? npc : pc_in) :
($signed(rs1_data_in) >= $signed(rs2_data_in) ? npc : pc_in)): pc_in)))): pc_in));

assign jflag_out =
opcode_in == `OPC_JAL ? 1'b1 :
(opcode_in == `OPC_JALR ? 1'b1 :
(opcode_in == `OPC_BRANCH ?
({funct3_in[2],funct3_in[0]} == `FUNCT3_BEQ ? 
(rs1_data_in == rs2_data_in ? 1'b1 : 1'b0):
({funct3_in[2],funct3_in[0]} == `FUNCT3_BNE ? 
(rs1_data_in != rs2_data_in ? 1'b1 : 1'b0):
({funct3_in[2],funct3_in[0]} == `FUNCT3_BLT ? (funct3_in[1] == 1 ? 
($unsigned(rs1_data_in) < $unsigned(rs2_data_in) ? 1'b1 : 1'b0) :
($signed(rs1_data_in) < $signed(rs2_data_in) ? 1'b1 : 1'b0)):
({funct3_in[2],funct3_in[0]} == `FUNCT3_BGE ? (funct3_in[1] == 1 ? 
($unsigned(rs1_data_in) >= $unsigned(rs2_data_in) ? 1'b1 : 1'b0) :
($signed(rs1_data_in) >= $signed(rs2_data_in) ? 1'b1 : 1'b0)): 1'b0)))): 1'b0));

endmodule
