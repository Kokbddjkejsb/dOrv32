`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/08 13:54:55
// Design Name: 
// Module Name: pu_ram
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


module pu_ram(
    input clk,
    input rst,

    input  wire       re_in,
    input  wire       we_in,
    input  wire[1:0]  width_in,
    output reg        we_out,

    input  wire[31:0] addr_in,
    output wire[5:0] addr_out0,
    output wire[5:0] addr_out1,
    output wire[5:0] addr_out2,
    output wire[5:0] addr_out3,

    inout  wire[31:0] data_pu,
    inout  wire[7:0]  data_ram0,
    inout  wire[7:0]  data_ram1,
    inout  wire[7:0]  data_ram2,
    inout  wire[7:0]  data_ram3
    );
reg[31:0] data_tmp;
//ram0地址不可访问(置位0)或置位z
assign addr_out0 = width_in != 2'b11 ? addr_in[5:0] : 12'bz;
assign addr_out1 = width_in == 2'b01 | width_in == 2'b10 ? addr_in[5:0] + 1 : 12'bz;
assign addr_out2 = width_in == 2'b10 ? addr_in[5:0] + 2 : 12'bz;
assign addr_out3 = width_in == 2'b10 ? addr_in[5:0] + 3 : 12'bz;

assign data_pu = re_in ? data_tmp : 32'bz;
assign data_ram0 = we_in ? data_tmp[7:0] : 8'bz;
assign data_ram1 = we_in & (width_in == 2'b01 | width_in == 2'b10) ? data_tmp[15:8] : 8'hzz;
assign data_ram2 = we_in & width_in == 2'b10 ? data_tmp[23:16] : 8'hzz;
assign data_ram3 = we_in & width_in == 2'b10 ? data_tmp[31:24] : 8'hzz;

always @(negedge clk or negedge rst) begin
    if (!rst) begin
        we_out <= 0;
        data_tmp <= 32'h00000000;
    end else begin
        we_out <= 0;
        if (we_in) begin
            we_out <= 1;
            data_tmp <= data_pu;
        end
        if (re_in) begin
            case (width_in)
                2'b00:begin
                    data_tmp <= {24'h000000,data_ram0};
                end
                2'b01:begin
                    data_tmp <= {16'h0000, data_ram1, data_ram0};
                end
                2'b10:begin
                    data_tmp <= {data_ram3, data_ram2, data_ram1, data_ram0};
                end
                default:begin
                    data_tmp <= 32'h00000000;
                end
            endcase
        end
    end
end

endmodule

/*
(
    input clk,
    input rst,

    input  wire       re_in,
    input  wire       we_in,
    input  wire[1:0]  width_in,

    input  wire[31:0] addr_in,
    output wire[5:0] addr_out0,
    output wire[5:0] addr_out1,
    output wire[5:0] addr_out2,
    output wire[5:0] addr_out3,

    output wire[31:0] rdata_out,
    input  wire[7:0]  rdata_in0,
    input  wire[7:0]  rdata_in1,
    input  wire[7:0]  rdata_in2,
    input  wire[7:0]  rdata_in3,

    input  wire[31:0] wdata_in,
    output wire[7:0]  wdata_out0,
    output wire[7:0]  wdata_out1,
    output wire[7:0]  wdata_out2,
    output wire[7:0]  wdata_out3
);
reg[31:0] data_tmp;

assign addr_out0 = addr_in[5:0];
assign addr_out1 = width_in == 2'b01 ? addr_in[5:0] + 1 : 0;
assign addr_out2 = width_in == 2'b10 ? addr_in[5:0] + 2 : 0;
assign addr_out3 = width_in == 2'b10 ? addr_in[5:0] + 3 : 0;

assign rdata_out = re_in ? data_tmp : 32'b0;
assign wdata_out0 = we_in ? data_tmp[7:0] : 8'b0;
assign wdata_out1 = we_in & width_in == 2'b01 ? data_tmp[15:8] : 8'b0;
assign wdata_out2 = we_in & width_in == 2'b10 ? data_tmp[23:16] : 8'b0;
assign wdata_out3 = we_in & width_in == 2'b10 ? data_tmp[31:24] : 8'b0;

always @(negedge clk or negedge rst) begin
    if (!rst) begin
        data_tmp <= 32'h00000000;
    end else begin
        if (we_in) begin
            data_tmp <= wdata_in;
        end
        if (re_in) begin
            case (width_in)
                2'b00:begin
                    data_tmp <= {24'h000000,rdata_in0};
                end
                2'b01:begin
                    data_tmp <= {16'h0000, rdata_in1, rdata_in0};
                end
                2'b10:begin
                    data_tmp <= {rdata_in3, rdata_in2, rdata_in1, rdata_in0};
                end
                default:begin
                    data_tmp <= 32'h00000000;
                end
            endcase
        end
    end
end

*/