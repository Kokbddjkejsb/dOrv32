`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/12 14:56:29
// Design Name: 
// Module Name: _bu_
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


module bubble_(
    input rst,
    
    input[6:0] opcode_in,//if_id
    input[4:0] rs1_addr_in,
    input[4:0] rs2_addr_in,
    input[4:0] rd_addr_in,//id_ex

    output hold_pc_out,
    output hold_id_out,//if_id->id_ex
    
    input[31:0]  pc_if_in,//if_id
    input[31:0]  data_if_in,
    input[31:0]  pc_id_in,//id_ex
    input[31:0]  data_id_in,
    
    output[31:0] pc_out,//->if_id
    output[31:0] data_out
);

assign hold_pc_out = !rst | (opcode_in == `OPC_LOAD & (rs1_addr_in == rd_addr_in | rs2_addr_in == rd_addr_in));
assign hold_id_out = hold_pc_out;

assign pc_out = hold_pc_out ? pc_id_in : pc_if_in;
assign data_out = hold_pc_out ? data_id_in : data_if_in;

endmodule
