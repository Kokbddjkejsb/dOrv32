`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/28 23:14:25
// Design Name: 
// Module Name: processor
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


module Processor_(
    input wire clk,
    input wire rst,

    output wire rom_re_out,
    output wire[31:0] rom_addr_out,
    input wire[31:0] rom_data_in,

    output wire ram_re_out,
    output wire ram_we_out,
    output wire[1:0]  ram_width_out,
    output wire[31:0] ram_addr_out,
    inout wire[31:0] ram_data
    );
wire       hold_pc;
wire       jflag_pc;
wire[31:0] jaddr_pc;
wire[31:0] pc_if;

wire       jump_hold;
//wire[31:0] data_if;

wire       bubble_hold;
wire[31:0] bdata_if;
wire[31:0] baddr_if;

wire[31:0] data_id;
wire[31:0] pc_id;
wire[6:0]  opcode_id;
wire[2:0]  funct3_id;
wire[6:0]  funct7_id;
wire[31:0] imm_id;

wire[4:0]  rs1_addr_id;
wire[4:0]  rs2_addr_id;
wire[4:0]  rd_addr_id;

wire[31:0] rs1_data_id;
wire[31:0] rs2_data_id;
//forwarded
wire[31:0] rs1_data_id_;
wire[31:0] rs2_data_id_;

wire[31:0] pc_ex;
wire[6:0]  opcode_ex;
wire[2:0]  funct3_ex;
wire[6:0]  funct7_ex;
wire[31:0] imm_ex;
wire[4:0]  rs1_addr_ex;
wire[4:0]  rs2_addr_ex;

wire[31:0] rs1_data_ex;
wire[31:0] rs2_data_ex;

wire[31:0] rs1_data_ex_;
wire[31:0] rs2_data_ex_;
wire[4:0]  rd_addr_ex;
wire[31:0] rd_data_ex;
wire[31:0] ram_addr_ex;

wire[6:0]  opcode_mem;
wire[2:0]  funct3_mem;
wire[4:0]  rd_addr_mem;
wire[31:0] rd_data_mem;
wire[31:0] rs2_data_mem;

//wire[31:0] ram_addr_mem;
//wire       ram_re_mem;
//wire       ram_we_mem;
//wire[1:0]  width_mem;
//wire[31:0] rdata_mem;
//wire[31:0] wdata_mem;

wire       rd_we_mem;
wire[31:0] rd_data_mem_;//loaded

wire[31:0] jaddr_alu;
wire       jflag_alu;

wire       rd_we_wb;
wire[4:0]  rd_addr_wb;
wire[31:0] rd_data_wb;

assign rom_addr_out = pc_if;
//assign data_if = rom_data_in;

//assign ram_re_out = ram_re_mem;
//assign ram_we_out = ram_we_mem;

//assign rdata_mem = ram_re_out ? ram_data : 32'bz;

pc_if pc_if_(
    .clk(clk),
    .rst(rst),
    .hold(hold_pc),

    .jflag_in(jflag_pc),
    .jaddr_in(jaddr_pc),
    .re_out(rom_re_out),
    .pc_out(pc_if)
);


if_id if_id_(
    .clk(clk),
    .rst(rst),
    .hold(jump_hold),

    .data_in(bdata_if),
    .pc_in(baddr_if),

    .data_out(data_id),
    .pc_out(pc_id)
);

decode_ id_(
    .if_data_in(data_id),

    .opcode_out(opcode_id),
    .funct3_out(funct3_id),
    .funct7_out(funct7_id),

    .rs1_addr_out(rs1_addr_id),
    .rs2_addr_out(rs2_addr_id),

    .rd_addr_out(rd_addr_id),
    .imm_out(imm_id)
);

regs regs_(
    .clk(clk),
    .rst(rst),

    .rs1_addr_in(rs1_addr_id),
    .rs2_addr_in(rs2_addr_id),

    .rs1_data_out(rs1_data_id),
    .rs2_data_out(rs2_data_id),

    .rd_we_in(rd_we_wb),
    .rd_addr_in(rd_addr_wb),
    .rd_data_in(rd_data_wb)
);

id_ex id_ex_(
    .clk(clk),
    .rst(rst),
    .jump_hold(jump_hold),
    .bubble_hold(bubble_hold),

    .pc_in(pc_id),
    .opcode_in(opcode_id),
    .funct3_in(funct3_id),
    .funct7_in(funct7_id),
    .rs1_data_in(rs1_data_id_),
    .rs2_data_in(rs2_data_id_),
    .rd_addr_in(rd_addr_id),
    .imm_in(imm_id),
    .rs1_addr_in(rs1_addr_id),
    .rs2_addr_in(rs2_addr_id),

    .pc_out(pc_ex),
    .opcode_out(opcode_ex),
    .funct3_out(funct3_ex),
    .funct7_out(funct7_ex),
    .rs1_data_out(rs1_data_ex),
    .rs2_data_out(rs2_data_ex),
    .rd_addr_out(rd_addr_ex),
    .imm_out(imm_ex),
    .rs1_addr_out(rs1_addr_ex),
    .rs2_addr_out(rs2_addr_ex)
);

ALU alu_(
    .pc_in(pc_ex),
    .opcode_in(opcode_ex),
    .funct3_in(funct3_ex),
    .funct7_in(funct7_ex),

    .rs1_data_in(rs1_data_ex_),
    .rs2_data_in(rs2_data_ex_),
    .imm_in(imm_ex),

    .jaddr_out(jaddr_alu),
    .jflag_out(jflag_alu),
    .ram_addr_out(ram_addr_ex),
    .rd_data_out(rd_data_ex)
);

control_unit cu1(
    .clk(clk),
    .rst(rst),

    .jflag_in(jflag_alu),
    .jaddr_in(jaddr_alu),

    .hold_out(jump_hold),
    .jflag_out(jflag_pc),
    .jaddr_out(jaddr_pc)
);

bubble_ cu2(
    .rst(rst),

    .opcode_in(opcode_ex),
    .rs1_addr_in(rs1_addr_ex),
    .rs2_addr_in(rs2_addr_ex),
    .rd_addr_in(rd_addr_id),

    .hold_pc_out(hold_pc),
    .hold_id_out(bubble_hold),

    .pc_if_in(pc_if),
    .data_if_in(rom_data_in),//data_if
    .pc_id_in(pc_id),
    .data_id_in(data_id),
    
    .pc_out(baddr_if),
    .data_out(bdata_if)
);

ex_mem ex_mem_(
    .clk(clk),
    .rst(rst),
    
    .opcode_in(opcode_ex),
    .funct3_in(funct3_ex),
    .rd_addr_in(rd_addr_ex),
    .rd_data_in(rd_data_ex),
    .rs2_data_in(rs2_data_ex),
    .ram_addr_in(ram_addr_ex),

    .opcode_out(opcode_mem),
    .funct3_out(funct3_mem),
    .rd_addr_out(rd_addr_mem),
    .rd_data_out(rd_data_mem),
    .rs2_data_out(rs2_data_mem),
    .ram_addr_out(ram_addr_out)//
);

bypass_ forwarding_(
    .opcode_in(opcode_mem),
    .rd_addr_in(rd_addr_mem),
    .rd_data_in(rd_data_mem),

    .rs1_addr_id(rs1_addr_id),
    .rs2_addr_id(rs2_addr_id),
    .rs1_data_id(rs1_data_id),
    .rs2_data_id(rs2_data_id),
    .rs1_id_out(rs1_data_id_),
    .rs2_id_out(rs2_data_id_),

    .rs1_addr_ex(rs1_addr_ex),
    .rs2_addr_ex(rs2_addr_ex),
    .rs1_data_ex(rs1_data_ex),
    .rs2_data_ex(rs2_data_ex),
    .rs1_alu_out(rs1_data_ex_),
    .rs2_alu_out(rs2_data_ex_)
);

mem_ memdecode_(
    .opcode_in(opcode_mem),
    .funct3_in(funct3_mem),
    .rd_data_in(rd_data_mem),
    .rs2_data_in(rs2_data_mem),

    .ram_re_out(ram_re_out),
    .ram_we_out(ram_we_out),
    .ram_width_out(ram_width_out),
    .ram_data(ram_data),

    .rd_we_out(rd_we_mem),
    .rd_data_out(rd_data_mem_)
);
//assign ram_re_out = ram_re_mem;
//assign ram_we_out = ram_we_mem;
//assign width_out = width_mem;
//assign ram_addr_out = ram_addr_mem;
/*
pu_ram pu_ram_(
    .re_in(ram_re_mem),
    .raddr_in(ram_addr_mem),
    .raddr_out(ram_raddr_out),
    .rdata_in(ram_rdata_in),
    .rdata_out(rdata_mem),

    .we_in(ram_we_mem),
    .width_in(width_mem),
    .waddr_in(ram_addr_mem),
    .waddr_out(ram_waddr_out),
    .wdata_in(wdata_mem),
    .wdata_out(ram_wdata_out)
);
*/
mem_wb mem_wb_(
    .clk(clk),
    .rst(rst),

    .rd_we_in(rd_we_mem),
    .rd_addr_in(rd_addr_mem),
    .rd_data_in(rd_data_mem_),

    .rd_we_out(rd_we_wb),
    .rd_addr_out(rd_addr_wb),
    .rd_data_out(rd_data_wb)
);
endmodule
