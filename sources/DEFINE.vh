`define NOP 32'h00000013

`define OPC_BRANCH 7'b1100011
//{FUNCT3[2],FUNCT3[0]}
`define FUNCT3_BEQ 2'b00//000 beq
`define FUNCT3_BNE 2'b01//001 bne
`define FUNCT3_BLT 2'b10//100 blt 110 bltu
`define FUNCT3_BGE 2'b11//101 bge 111 bgeu

`define OPC_LOAD 7'b0000011
`define OPC_STORE 7'b0100011
//FUNCT3[1:0]
`define FUNCT3_B 2'b00//000 lb/sb 100 lbu
`define FUNCT3_H 2'b01//001 lh/sh 101 lhu 
`define FUNCT3_W 2'b10//010 lw/sw

`define OPC_ALI 7'b0010011
`define OPC_AL  7'b0110011
`define FUNCT3_ADD  3'b000//sub addi
`define FUNCT3_SLL  3'b001//slli
`define FUNCT3_SLT  3'b010//slti
`define FUNCT3_SLTU 3'b011//sltiu
`define FUNCT3_XOR  3'b100//xori
`define FUNCT3_SRL  3'b101//sra srli srai
`define FUNCT3_OR   3'b110//ori
`define FUNCT3_AND  3'b111//andi
//FUNCT7[5]
`define FUNCT7_ADD 1'b0//srl srli
`define FUNCT7_SUB 1'b1//sra srai

//`define OPC_MISC 7'b1110011

`define OPC_JAL 7'b1101111
`define OPC_JALR 7'b1100111
`define OPC_LUI 7'b0110111
`define OPC_AUIPC 7'b0010111
//efine OPC_FENCE 7'b0001111