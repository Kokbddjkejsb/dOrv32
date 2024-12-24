`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/01 19:44:34
// Design Name: 
// Module Name: _id_
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
module decode_(
    input wire[31:0]  if_data_in,

    output wire[6:0]  opcode_out,
    output wire[2:0]  funct3_out,
    output wire[6:0]  funct7_out,

    output wire[4:0]  rs1_addr_out,
    output wire[4:0]  rs2_addr_out,
    
    output wire[4:0]  rd_addr_out,
    output wire[31:0] imm_out
    );

assign rs1_addr_out = if_data_in[19:15];
assign rs2_addr_out = if_data_in[24:20];
assign rd_addr_out  = if_data_in[11:7];
assign opcode_out   = if_data_in[6:0];
assign funct3_out   = if_data_in[14:12];
assign funct7_out   = if_data_in[31:25];

assign imm_out      =
opcode_out == `OPC_LOAD | opcode_out == `OPC_ALI | opcode_out == `OPC_JALR ? 
{{20{if_data_in[31]}}, if_data_in[31:20]}: 
(opcode_out == `OPC_STORE ? 
{{20{if_data_in[31]}}, if_data_in[31:25], if_data_in[11:7]} :
(opcode_out == `OPC_BRANCH ?
{{19{if_data_in[31]}},if_data_in[31], if_data_in[7], if_data_in[30:25], if_data_in[11:8], 1'b0}:
(opcode_out == `OPC_JAL ?
{{11{if_data_in[31]}}, if_data_in[31], if_data_in[19:12], if_data_in[20], if_data_in[30:21], 1'b0}:
(opcode_out == `OPC_LUI | opcode_out == `OPC_AUIPC ?
{if_data_in[31:12],12'b0}:32'b0))));

endmodule
