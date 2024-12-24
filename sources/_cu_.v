`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/02 23:03:12
// Design Name: 
// Module Name: _cu_
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


module control_unit(
    input wire clk,
    input wire rst,

    input  wire       jflag_in,
    input  wire[31:0] jaddr_in,

    output wire       hold_out,
    output reg        jflag_out,
    output reg[31:0]  jaddr_out
    );
//jump
assign hold_out = !rst | jflag_in;

always @(negedge clk or negedge rst) begin
    if(!rst) begin
        jflag_out <= 0;
        jaddr_out <= 0;
    end else begin
        jflag_out <= jflag_in;
        jaddr_out <= jaddr_in;
    end
end

endmodule
