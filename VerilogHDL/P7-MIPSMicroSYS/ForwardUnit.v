`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:12:18 12/20/2017 
// Design Name: 
// Module Name:    ForwardUnit 
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
`define MOVZ 3'b100	//D���������ݣ���֮���ߵ�ALU,WD��·������
`define ALU 3'b001	//����StallUnit����
`define DM  3'b010
`define PC  3'b011
`define NW  3'b000	//��д
module ForwardUnit(
    input [4:0] rs_D,
    input [4:0] rt_D,
    input [4:0] rs_E,
    input [4:0] rt_E,
	input [4:0] rt_M,
    input [4:0] A3_E,
    input [4:0] A3_M,
    input [4:0] A3_W,
    input [2:0] Res_E,
    input [2:0] Res_M,
    input [2:0] Res_W,
	input [31:0] Instr_D,
	input [31:0] Instr_M,
	output [2:0] Fwd_RegV1_D,
	output [2:0] Fwd_RegV2_D,
	output [2:0] Fwd_ALUA_E,
	output [2:0] Fwd_ALUB_E,
	output [2:0] Fwd_WDM_M,
	output Fwd_eret
    );
	//��E,M,W����D��ת��
	`define E2D_rs		5	//E->D, rs(movz)
	`define E2D_PCAdd8	4	//E->D, PCAdd8
	`define M2D_PCAdd8	3	//M->D, PCAdd8
	`define M2D_ALU		2	//M->D, ALUOut
	`define W2D_WD		1	//W->D, WriteData
	`define ORIGINAL	0	//No Forward
	assign Fwd_RegV1_D = /*((A3_E == rs_D) && (rs_D != 0) && (Res_E == `MOVZ)) ?`E2D_rs:*/
						 ((A3_E == rs_D) && (rs_D != 0) && (Res_E == `PC)) ?`E2D_PCAdd8:
			/*V1->rs*/	 ((A3_M == rs_D) && (rs_D != 0) && (Res_M == `PC)) ?`M2D_PCAdd8:
						 ((A3_M == rs_D) && (rs_D != 0) && (Res_M == `ALU/* || Res_M == `MOVZ*/))?`M2D_ALU:
						 ((A3_W == rs_D) && (rs_D != 0) && (Res_W == `ALU || Res_W == `DM || Res_W == `PC/* || Res_W == `MOVZ*/))?`W2D_WD:
						 `ORIGINAL;
	assign Fwd_RegV2_D = /*((A3_E == rt_D) && (rt_D != 0) && (Res_E == `MOVZ)) ?`E2D_rs:*/
						 ((A3_E == rt_D) && (rt_D != 0) && (Res_E == `PC)) ?`E2D_PCAdd8:
			/*V2->rt*/	 ((A3_M == rt_D) && (rt_D != 0) && (Res_M == `PC)) ?`M2D_PCAdd8:
						 ((A3_M == rt_D) && (rt_D != 0) && (Res_M == `ALU/* || Res_M == `MOVZ*/))?`M2D_ALU:
						 ((A3_W == rt_D) && (rt_D != 0) && (Res_W == `ALU || Res_W == `DM || Res_W == `PC/* || Res_W == `MOVZ*/))?`W2D_WD:
						 `ORIGINAL;
	//��M,W����E��ת��
	`define M2E_PCAdd8	3	//M->E, PCAdd8
	`define M2E_ALU		2	//M->E, ALUOut
	`define W2E_WD		1	//W->E, WriteData
	`define ORIGINAL	0	//No Forward
	assign Fwd_ALUA_E = ((A3_M == rs_E) && (rs_E != 0) && (Res_M == `PC)) ?`M2E_PCAdd8:
		  /*ALUA->rs*/  ((A3_M == rs_E) && (rs_E != 0) && (Res_M == `ALU || Res_M == `MOVZ))?`M2E_ALU:
					    ((A3_W == rs_E) && (rs_E != 0) && (Res_W == `ALU || Res_W == `DM || Res_W == `PC || Res_W == `MOVZ))?`W2E_WD:
						`ORIGINAL;
	assign Fwd_ALUB_E = ((A3_M == rt_E) && (rt_E != 0) && (Res_M == `PC)) ?`M2E_PCAdd8:
		  /*ALUB->rt*/  ((A3_M == rt_E) && (rt_E != 0) && (Res_M == `ALU || Res_M == `MOVZ))?`M2E_ALU:
					    ((A3_W == rt_E) && (rt_E != 0) && (Res_W == `ALU || Res_W == `DM || Res_W == `PC || Res_W == `MOVZ))?`W2E_WD:
						`ORIGINAL;
	//��W����M��ת��sw��д������
	`define W2M_WD		1	//W->M, WriteData
	`define ORIGINAL	0	//No Forward
	assign Fwd_WDM_M =  ((A3_W == rt_M) && (rt_M != 0) && (Res_W == `ALU || Res_W == `DM || Res_W == `PC || Res_W == `MOVZ))?`W2M_WD:
						`ORIGINAL;
	
	//��M����NPCת��eret�����ַ
	assign Fwd_eret = (Instr_D == 32'h42000018) & (Instr_M[31:26] == 6'b010000) & (Instr_M[25:21] == 5'b00100) & (Instr_M[15:11] == 14);
endmodule
