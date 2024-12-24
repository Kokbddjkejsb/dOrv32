`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/28 22:49:35
// Design Name: 
// Module Name: mem
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


module Ram(
    output [7:0] data_out,
    input [3:0] addr_read,
    input read_enable,

    input [7:0] data_in,
    input [3:0] addr_write,
    input write_enable
    );

    reg [7:0] ram [15:0];

    assign data_out = (read_enable)?ram[addr_read]:8'b00000000;

    always @(posedge write_enable)begin
        ram[addr_write] <= (write_enable)?data_in:ram[addr_write];
    end

endmodule
