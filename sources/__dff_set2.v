`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/11 20:24:11
// Design Name: 
// Module Name: __dff_set2
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


module dff_set_#(parameter width = 32)
(
    input wire clock,
    input wire reset_n,

    input wire [width-1:0] data_in,
    output reg [width-1:0] data_out,
    input wire [width-1:0] set_data
);

    always @(posedge clock or negedge reset_n) begin
        if (!reset_n) begin
            data_out <= set_data;
        end else begin
            data_out <= data_in;
        end
    end
endmodule