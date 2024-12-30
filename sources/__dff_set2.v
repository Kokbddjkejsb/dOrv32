`timescale 1ns / 1ps

// Create Date: 2024/12/11 20:24:11

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
