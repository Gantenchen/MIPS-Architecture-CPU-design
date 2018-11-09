`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:15:55 12/09/2017 
// Design Name: 
// Module Name:    NPC 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`include "macro.v"

module NPC(
	input		[31:0] pc8_D,		//����jal��
	input 	[31:0] IR_D,
	output 	[31:0] npc			//jr����������һ·
    );
	
	wire [31:0] instr_index;	//jal��j����ת��ָ��
	wire [31:0] B_Imm;				//beq����ת��
	wire [5:0] opcode, funct;
	wire [4:0] identify;
	
	assign instr_index = {{pc8_D [31:28]} , IR_D [25:0] , {2'b00}};
	assign B_Imm	= {{14{IR_D [15]}} , IR_D [15:0] , {2'b00}} + pc8_D - 4;
	assign opcode	= IR_D [31:26];
	assign funct	= IR_D [5:0];
	assign identify = IR_D [20:16];
	
	assign npc = (`jal | `j)												?	instr_index	:
					 `beq	| `bne | `blez	| `bltz | `bgez | `bgtz		?	B_Imm			:
					 32'hxxxx_xxxx;


endmodule
