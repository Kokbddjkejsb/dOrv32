`timescale 1ns / 1ps

// Create Date: 2024/12/10 22:27:19

module tb_rom;
reg clk;
reg rst;
wire en;

reg[31:0] addr_in;
wire[31:0] data_out;

wire[10:0] addr0;
wire[10:0] addr1;
wire[10:0] addr2;
wire[10:0] addr3;
wire[7:0] data0;
wire[7:0] data1;
wire[7:0] data2;
wire[7:0] data3;

always begin
    clk = 1;
    #5 clk = 0;
    #5;
end

initial begin
    rst = 0;
    #10 rst = 1;
end

initial begin
    $readmemh("rom1.mem", rom.rom);
end

initial begin
    addr_in = 20;
    #20 addr_in = 4;
    #10 addr_in = 8;
    #10 addr_in = 12;
    #10 addr_in = 16;
end

pu_rom torom(
    .clk(clk),
    .rst(rst),  

    .re_out(en),
    .addr_in(addr_in),
    .data_out(data_out),

    .addr_out0(addr0),
    .addr_out1(addr1),
    .addr_out2(addr2),
    .addr_out3(addr3),
    .data_in0(data0),
    .data_in1(data1),
    .data_in2(data2),
    .data_in3(data3)
);
InsROM rom(
    .re(en),
    .addr0(addr0),
    .addr1(addr1),
    .addr2(addr2),
    .addr3(addr3),
    .data0(data0),
    .data1(data1),
    .data2(data2),
    .data3(data3)
);
endmodule
