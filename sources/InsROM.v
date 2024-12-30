`timescale 1ns / 1ps

// Create Date: 2024/12/05 14:15:28

module InsROM(
    input  wire       re,
    input  wire[10:0] addr0,
    input  wire[10:0] addr1,
    input  wire[10:0] addr2,
    input  wire[10:0] addr3,
    output wire[7:0]  data0,
    output wire[7:0]  data1,
    output wire[7:0]  data2,
    output wire[7:0]  data3
    );
reg[7:0] rom [2047:0];

assign data0 = re ? rom[addr0] : 0;
assign data1 = re ? rom[addr1] : 0;
assign data2 = re ? rom[addr2] : 0;
assign data3 = re ? rom[addr3] : 0;

endmodule
