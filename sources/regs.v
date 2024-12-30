`timescale 1ns / 1ps

// Create Date: 2024/12/01 22:24:25

module regs(
    input wire clk,
    input wire rst,

    input wire[4:0] rs1_addr_in,
    input wire[4:0] rs2_addr_in,

    output reg[31:0] rs1_data_out,
    output reg[31:0] rs2_data_out,

    input wire rd_we_in,
    input wire[4:0] rd_addr_in,
    input wire[31:0] rd_data_in
    );
reg[31:0] register[31:0];
reg[5:0] int;

always @(negedge clk or negedge rst) begin
    if (!rst) begin
        rs1_data_out <= 32'h00000000;
    end else if (rd_we_in && rd_addr_in == rs1_addr_in) begin
        rs1_data_out <= rd_addr_in == 0 ? 32'h00000000 : rd_data_in;
    end  else begin
        rs1_data_out <= register[rs1_addr_in];
    end
end

always @(negedge clk or negedge rst) begin
    if(!rst) begin
        rs2_data_out <= 32'h00000000;
    end else if (rd_we_in && rd_addr_in == rs2_addr_in) begin
        rs2_data_out <= rd_addr_in == 0 ? 32'h00000000 : rd_data_in;
    end else begin
        rs2_data_out <= register[rs2_addr_in];
    end
end
//integer int;
always @(negedge clk or negedge rst) begin
    if (!rst) begin
        //register[0] <= 0;
        for (int = 0; int < 32; int = int + 1) begin
            register[int] <= 32'h00000000;
        end
    end else begin
        if (rd_we_in && rd_addr_in != 0) begin//address 0 is reserved for reset
            register[rd_addr_in] <= rd_data_in;
        end
    end
end

endmodule
