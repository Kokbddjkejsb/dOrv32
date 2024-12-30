`timescale 1ns / 1ps

// Create Date: 2024/12/05 21:59:22

module Test;

reg clk;
reg rst;

wire re_rom;
wire[31:0] addr_rom;
wire[31:0] data_rom;

wire[10:0] addr_rom0;
wire[10:0] addr_rom1;
wire[10:0] addr_rom2;
wire[10:0] addr_rom3;

wire[7:0] data_rom0;
wire[7:0] data_rom1;
wire[7:0] data_rom2;
wire[7:0] data_rom3;

wire re_ram;
wire we_ram;
wire we_ram_;
wire[1:0] width_ram;
wire[31:0] addr_ram;
wire[31:0] data_ram;

wire[5:0]  addr_ram0;
wire[5:0]  addr_ram1;
wire[5:0]  addr_ram2;
wire[5:0]  addr_ram3;

wire[7:0]  data_ram0;
wire[7:0]  data_ram1;
wire[7:0]  data_ram2;
wire[7:0]  data_ram3;

Processor_ pu(
    .clk(clk),
    .rst(rst),

    .rom_re_out(re_rom),
    .rom_addr_out(addr_rom),
    .rom_data_in(data_rom),

    .ram_re_out(re_ram),
    .ram_we_out(we_ram),
    .ram_width_out(width_ram),
    .ram_addr_out(addr_ram),
    .ram_data(data_ram)
);

pu_rom torom(
    .clk(clk),
    .rst(rst),

    .re_in(re_rom),
    .addr_in(addr_rom),
    .data_out(data_rom),
    
    .addr_out0(addr_rom0),
    .addr_out1(addr_rom1),
    .addr_out2(addr_rom2),
    .addr_out3(addr_rom3),
    .data_in0(data_rom0),
    .data_in1(data_rom1),
    .data_in2(data_rom2),
    .data_in3(data_rom3)
);
//0x0000-0x0FFF: ROM (4096)
InsROM rom(
    .re(re_rom),
    .addr0(addr_rom0),
    .addr1(addr_rom1),
    .addr2(addr_rom2),
    .addr3(addr_rom3),
    .data0(data_rom0),
    .data1(data_rom1),
    .data2(data_rom2),
    .data3(data_rom3)
);

pu_ram toram(
    .clk(clk),
    .rst(rst),

    .re_in(re_ram),
    .we_in(we_ram),
    .width_in(width_ram),
    .we_out(we_ram_),

    .addr_in(addr_ram),
    .addr_out0(addr_ram0),
    .addr_out1(addr_ram1),
    .addr_out2(addr_ram2),
    .addr_out3(addr_ram3),
    
    .data_pu(data_ram),
    .data_ram0(data_ram0),
    .data_ram1(data_ram1),
    .data_ram2(data_ram2),
    .data_ram3(data_ram3)
);
//0x1000-0x1040: RAM 64
DataRAM ram(
    .re(re_ram),
    .we(we_ram_),
    .addr0(addr_ram0),
    .addr1(addr_ram1),
    .addr2(addr_ram2),
    .addr3(addr_ram3),
    .data0(data_ram0),
    .data1(data_ram1),
    .data2(data_ram2),
    .data3(data_ram3)
);

always begin
    clk = 1;
    #2 clk = 0;
    #2;
end

initial begin
    rst = 0;
    #1 rst = 1;
end

initial begin
    $readmemh("rv32ui-p-slt.mem", rom.rom);//load/store lui sra srai
    //$readmemh("data-lb.mem",ram.ram);
end

initial begin
    while (1) begin
        @(posedge clk);
        $display("----------\n%0t Global pointer: %h", $time, pu.regs_.register[3]);
        $display("rs1: [%h]%h, rs2: [%h]%h, imm data: %h, rd data: [%h]%h",
        pu.rs1_addr_ex, pu.rs1_data_ex_, pu.rs2_addr_ex, pu.rs2_data_ex_,
        pu.imm_ex, pu.rd_addr_ex, pu.rd_data_ex);
        //$display("opc: %h, funct3: %h, funct7: %h", 
        //pu.opcode_ex, pu.funct3_ex, pu.funct7_ex);
        //$display("j: %h, jaddr: %h , b: %h", 
        //pu.jflag_alu, pu.jaddr_pc, pu.bubble_hold);
        $display("e: %h/%h, width: %h, data: [%h]%h(%h)",
        re_ram, we_ram, width_ram, addr_ram, data_ram,ram.ram[addr_ram]);
        $display("ra: %h, sp: %h; t5: %h, t4: %h",
        pu.regs_.register[1], pu.regs_.register[2], 
        pu.regs_.register[30], pu.regs_.register[29]);
        //$display("tp: %h, t0: %h, t1: %h",
        //pu.regs_.register[4], pu.regs_.register[5], pu.regs_.register[6]);
        $display("finish: %h, pass: %h\n", pu.regs_.register[26], pu.regs_.register[27]);
    end
end

endmodule
