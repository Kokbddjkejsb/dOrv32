`timescale 1ns / 1ps

// Create Date: 2024/12/24 21:33:19

module mem2_(
    input wire[6:0]   opcode_in,
    input wire[2:0]   funct3_in,
    input wire[31:0]  rd_data_in,
    input wire[31:0] ram_data,
    
    output wire       rd_we_out,
    output wire[31:0] rd_data_out
    );
    
assign rd_we_out = 
opcode_in == `OPC_BRANCH | opcode_in == `OPC_STORE ? 1'b0 : 1'b1;

assign rd_data_out =  
opcode_in ==`OPC_LOAD ? 
(funct3_in[1:0] == `FUNCT3_W ? ram_data[31:0] :
(funct3_in[1:0] == `FUNCT3_H ? 
(funct3_in[2] == 1'b1 | ram_data[15] == 1'b0 ? 
{16'h0000,ram_data[15:0]} : {16'hffff,ram_data[15:0]}) :
(funct3_in[1:0] == `FUNCT3_B ? 
(funct3_in[2] == 1'b1 | ram_data[7] == 1'b0 ? 
{24'h000000,ram_data[7:0]} : {24'hffffff,ram_data[7:0]}) : 32'h00000000 ))) : rd_data_in;

endmodule
