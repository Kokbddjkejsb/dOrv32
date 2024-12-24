`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/12 23:55:19
// Design Name: 
// Module Name: bypass_
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


module bypass_(
    input wire[6:0]   opcode_in,
    input wire[4:0]   rd_addr_in,
    input wire[31:0]  rd_data_in,

    input wire[4:0]   rs1_addr_id,
    input wire[4:0]   rs2_addr_id,
    input wire[31:0]  rs1_data_id,
    input wire[31:0]  rs2_data_id,
    output wire[31:0] rs1_id_out,
    output wire[31:0] rs2_id_out,

    input wire[4:0]   rs1_addr_ex,
    input wire[4:0]   rs2_addr_ex,
    input wire[31:0]  rs1_data_ex,
    input wire[31:0]  rs2_data_ex,
    output wire[31:0] rs1_alu_out,
    output wire[31:0] rs2_alu_out
    );
//x未定态
assign rs1_id_out = 
(rd_addr_in != 5'd0 & 
!(opcode_in == `OPC_BRANCH | opcode_in == `OPC_STORE) 
& rd_addr_in == rs1_addr_id) ? 
rd_data_in : rs1_data_id;
assign rs2_id_out = 
(rd_addr_in != 5'd0 & 
!(opcode_in == `OPC_BRANCH | opcode_in == `OPC_STORE) & 
rd_addr_in == rs2_addr_id) ? 
rd_data_in : rs2_data_id;

assign rs1_alu_out = 
(rd_addr_in != 5'd0 &
!(opcode_in == `OPC_BRANCH | opcode_in == `OPC_STORE) & 
rd_addr_in == rs1_addr_ex) ? 
rd_data_in : rs1_data_ex;
assign rs2_alu_out =
(rd_addr_in != 5'd0 & 
!(opcode_in == `OPC_BRANCH | opcode_in == `OPC_STORE) & 
rd_addr_in == rs2_addr_ex) ? 
rd_data_in : rs2_data_ex;

endmodule
