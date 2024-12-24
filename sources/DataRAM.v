`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/05 14:12:21
// Design Name: 
// Module Name: DataRAM
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


module DataRAM(
    input  wire re,
    input  wire we,

    input  wire[5:0] addr0,
    input  wire[5:0] addr1,
    input  wire[5:0] addr2,
    input  wire[5:0] addr3,

    inout  wire[7:0]  data0,
    inout  wire[7:0]  data1,
    inout  wire[7:0]  data2,
    inout  wire[7:0]  data3
    );

reg[7:0] ram [63:0];

assign data0 = re ? ram[addr0] : 8'hzz;
assign data1 = re ? ram[addr1] : 8'hzz;
assign data2 = re ? ram[addr2] : 8'hzz;
assign data3 = re ? ram[addr3] : 8'hzz;

always @(posedge we) begin
    ram[addr0] <= we ? data0 : ram[addr0];
    ram[addr1] <= we ? data1 : ram[addr1];
    ram[addr2] <= we ? data2 : ram[addr2];
    ram[addr3] <= we ? data3 : ram[addr3];
end

endmodule

/*
(
    input  wire re,
    input  wire we,

    input  wire[7:0] addr0,
    input  wire[7:0] addr1,
    input  wire[7:0] addr2,
    input  wire[7:0] addr3,

    input  wire[7:0]  data0,
    input  wire[7:0]  data1,
    input  wire[7:0]  data2,
    input  wire[7:0]  data3
    );

reg[7:0] ram [4095:0];

assign data0 = re ? ram[addr0] : 8'hzz;
assign data1 = re ? ram[addr1] : 8'hzz;
assign data2 = re ? ram[addr2] : 8'hzz;
assign data3 = re ? ram[addr3] : 8'hzz;

always @(posedge we) begin
    ram[addr0] = we ? data0 : ram[addr0];
    ram[addr1] = we ? data1 : ram[addr1];
    ram[addr2] = we ? data2 : ram[addr2];
    ram[addr3] = we ? data3 : ram[addr3];
end
*/