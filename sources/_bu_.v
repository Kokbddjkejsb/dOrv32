`timescale 1ns / 1ps

// Create Date: 2024/12/12 14:56:29

module bubble_(
    input clk,
    input rst,
    
    input[6:0] opcode_in,//[0]ex
    input[4:0] rd_addr_in,
    input[4:0] rs1_addr_in,//[1]id
    input[4:0] rs2_addr_in,

    output hold_pc_out,
    output hold_id_out,//[1]id_ex
    
    input[31:0]  pc_if_in,//[2]if_id
    input[31:0]  data_if_in,
    input[31:0]  pc_id_in,//[1]id_ex
    input[31:0]  data_id_in,
    
    output[31:0] pc_out,//[2]if_id
    output[31:0] data_out
);
reg hold;

always @(negedge clk or negedge rst) begin
    if(!rst) begin
        hold = 1'b0;
    end else begin
        hold = (opcode_in == `OPC_LOAD & 
    (rs1_addr_in == rd_addr_in | rs2_addr_in == rd_addr_in)) ? 1'b1 : 1'b0;
    end
end
assign hold_pc_out = hold;
assign hold_id_out = hold;

assign pc_out = hold ? pc_id_in : pc_if_in;
assign data_out = hold ? data_id_in : data_if_in;

endmodule
