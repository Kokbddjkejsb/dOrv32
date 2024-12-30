`timescale 1ns / 1ps
 
// Create Date: 2024/12/08 13:54:55

module pu_rom(
    input clk,
    input rst,

    input  wire        re_in,
    input  wire[31:0]  addr_in,
    output reg[31:0]   data_out,
    
    output wire[10:0]  addr_out0,
    output wire[10:0]  addr_out1,
    output wire[10:0]  addr_out2,
    output wire[10:0]  addr_out3,
    input  wire[7:0]   data_in0,
    input  wire[7:0]   data_in1,
    input  wire[7:0]   data_in2,
    input  wire[7:0]   data_in3
    );

assign addr_out0 = addr_in[10:0] + 12'h000;
assign addr_out1 = addr_in[10:0] + 12'h001;
assign addr_out2 = addr_in[10:0] + 12'h002;
assign addr_out3 = addr_in[10:0] + 12'h003;

always @ (negedge clk or negedge rst) begin
    if (!rst) begin
        data_out <= 32'h00000000;
    end else begin
        data_out <= re_in ? {data_in3, data_in2, data_in1, data_in0} : data_out;
    end
end

endmodule
