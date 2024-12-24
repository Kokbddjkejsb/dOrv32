`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/01 20:14:16
// Design Name: 
// Module Name: if_id
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
module if_id(
    input wire clk,
    input wire rst,
    input wire hold,
    
    input wire [31:0] data_in,
    input wire [31:0] pc_in,

    output wire [31:0] data_out,
    output wire [31:0] pc_out
    );

dff_set_h#(32) dff0(clk, rst, hold, data_in, data_out, `NOP);
dff_set_h#(32) dff1(clk, rst, hold, pc_in, pc_out, 32'h00000000);

endmodule
