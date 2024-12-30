`timescale 1ns / 1ps

// Create Date: 2024/12/05 14:15:28

module mem_wb(
    input clk,
    input rst,

    input wire        rd_we_in,
    input wire[4:0]   rd_addr_in,
    input wire[31:0]  rd_data_in,

    output wire       rd_we_out,
    output wire[4:0]  rd_addr_out,
    output wire[31:0] rd_data_out
    );

dff_set_#(1)  dff0(clk, rst, rd_we_in, rd_we_out, 1'b0);
dff_set_#(5)  dff1(clk, rst, rd_addr_in, rd_addr_out, 5'b00000);
dff_set_#(32) dff2(clk, rst, rd_data_in, rd_data_out, 32'h00000000);

endmodule
