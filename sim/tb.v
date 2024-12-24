`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/02 13:11:50
// Design Name: 
// Module Name: tb
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

//simulation time: 40ns
module tb;

reg clk;
reg rst;

wire[7:0] r_data;
wire[3:0] r_addr;
wire r_enable;

wire[7:0] w_data;
wire[3:0] w_addr;
wire w_enable;

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
    mem1.ram[0] = 8'b01000001;
    mem1.ram[1] = 8'b01010101;
    mem1.ram[2] = 8'b00010011;
    mem1.ram[3] = 8'b01100010;
    mem1.ram[4] = 8'b00000001;
    mem1.ram[5] = 8'b00000010;
    mem1.ram[6] = 8'b00000000;
end

initial begin
    while (1) begin
        @(posedge clk or negedge clk);
        $display("----------\n%0t, if addr: %b\n", $time, processor1.if_addr);
        $display("reg[0]: %b, regs[1]: %b\n", processor1.regs[0], processor1.regs[1]);
        $display("data_read: , data_load: %b\n", r_data, processor1.ex_data);
        $display("op: %b, rs1: %b, rs2: %b, ram_addr: %b\n", processor1.opcode, processor1.rs1_addr, processor1.rs2_addr, processor1.ram_addr);
        $display("ram[6]: %b\n", mem1.ram[6]);
    end
end

Processor processor1(clk, rst, r_data, r_addr, r_enable, w_data, w_addr, w_enable);

Ram mem1(r_data, r_addr, r_enable, w_data, w_addr, w_enable);
    
endmodule
