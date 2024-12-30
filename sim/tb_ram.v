`timescale 1ns / 1ps

// Create Date: 2024/12/10 22:27:19

module tb_ram;
reg clk;
reg rst;
reg re;
reg we;
wire we_ram;

reg [1:0]  width;
reg [31:0] addr_in;
wire[31:0] data_read;
reg [31:0] data_write;

wire[5:0] addr0;
wire[5:0] addr1;
wire[5:0] addr2;
wire[5:0] addr3;

wire[7:0] data0;
wire[7:0] data1;
wire[7:0] data2;
wire[7:0] data3;

always begin
    re = 1;
    #10 re = 0;
    #10;
end

always begin
    we = 0;
    #10 we = 1;
    #10;
end

initial begin
    width = 2'b00;
    #20 width = 2'b01;
    #20 width = 2'b10;
end

initial begin
    addr_in = 12;
    #10 addr_in = 8;
    #10 addr_in = 4;
    #10 addr_in = 12;
    #10 addr_in = 0;
    #10 addr_in = 0;
end

initial begin
    $readmemh("rom1.mem", ram.ram);
    data_write = 32'h00000000;
    #10 data_write = 32'h01020304;
    #20 data_write = 32'h02040608;
    #20 data_write = 32'h0306090c;
end

assign data_read = re ? 32'bz : data_write;

initial begin
    while (1) begin
        @(posedge clk);
        $display("----------\n%0t\n", $time);
        $display("rom[0]: %h\n", ram.ram[0]);
        $display("addr_in: %h\ndata_out: %h\ndata_in: %h\n", addr_in, data_read, data_write);
    end
end

initial begin
    #60;
    $display("%h %h %h %h\n", ram.ram[0], ram.ram[1], ram.ram[2], ram.ram[3]);
    $display("%h %h %h %h\n", ram.ram[4], ram.ram[5], ram.ram[6], ram.ram[7]);
    $display("%h %h %h %h\n", ram.ram[8], ram.ram[9], ram.ram[10], ram.ram[11]);
    $display("%h %h %h %h\n", ram.ram[12], ram.ram[13], ram.ram[14], ram.ram[15]);
end

always begin
    clk = 1;
    #5 clk = 0;
    #5;
end

initial begin
    rst = 0;
    #5 rst = 1;
end

pu_ram toram(
    .clk(clk),
    .rst(rst),  

    .re_in(re),
    .we_in(we),
    .width_in(width),
    .we_out(we_ram),
    .addr_in(addr_in),
    .addr_out0(addr0),
    .addr_out1(addr1),
    .addr_out2(addr2),
    .addr_out3(addr3),
    .rdata_out(data_read),
    .rdata_in0(data0),
    .rdata_in1(data1),
    .rdata_in2(data2),
    .rdata_in3(data3)
);

DataRAM ram(
    .re(re),
    .we(we_ram),
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
