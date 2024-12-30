`timescale 1ns / 1ps

// Create Date: 2024/12/01 19:44:34

module pc_if(
    input wire clk,
    input wire rst,
    input wire hold,

    input  wire       jflag_in,
    input  wire[31:0] jaddr_in,
    output wire       re_out,
    output reg[31:0]  pc_out
    );

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        pc_out <= 0;
    end else if (jflag_in) begin
        pc_out <= jaddr_in;
    end else begin
        pc_out <= hold ? pc_out: pc_out + 4;
    end
end

assign re_out = 1'b1;

endmodule
