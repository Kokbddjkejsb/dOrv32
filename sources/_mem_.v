`timescale 1ns / 1ps

// Create Date: 2024/12/05 14:18:25
`include "DEFINE.vh"
module mem_(
    input wire[6:0]   opcode_in,
    input wire[2:0]   funct3_in,
    input wire[31:0]  rs2_data_in,
    input wire[31:0]  ram_addr_in,

    output wire       ram_re_out, 
    output wire       ram_we_out,  
    output wire[1:0]  ram_width_out,
    output wire[31:0] ram_addr_out,
    output wire[31:0] ram_data
    );

assign ram_re_out = 
opcode_in == `OPC_LOAD ? 1'b1 : 1'b0;
assign ram_we_out = 
opcode_in == `OPC_STORE ? 1'b1 : 1'b0;//funct3_in[1:0] == 11

assign ram_width_out = 
funct3_in[1:0] == `FUNCT3_W ? 2'b10 :
(funct3_in[1:0] == `FUNCT3_H ? 2'b01 : 
(funct3_in[1:0] == `FUNCT3_B ? 2'b00 : 2'b11));

assign ram_addr_out = ram_addr_in < 32'h1000 ? 32'h1000 : ram_addr_in;

assign ram_data = 
opcode_in == `OPC_STORE ? 
(funct3_in[1:0] == `FUNCT3_W ? rs2_data_in : 
(funct3_in[1:0] == `FUNCT3_H ? {16'h0000,rs2_data_in[15:0]} : 
funct3_in[1:0] == `FUNCT3_B ? {24'h000000,rs2_data_in[7:0]} : 32'hz)) : 32'hz;

endmodule
