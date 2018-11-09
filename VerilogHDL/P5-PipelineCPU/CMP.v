`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:10:14 12/19/2017 
// Design Name: 
// Module Name:    CMP 
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
module CMP(
    input [31:0] Instr,
    input [31:0] RD1,
    input [31:0] RD2,
    output CMPout
    );
	wire[5:0] OP, Func;
	wire beq, movz;
	assign OP = Instr[31:26]; 
	assign Func = Instr[20:16];	//bgez,bltz�Բ�,movz������
	assign beq = (OP == 6'b000100);
	assign movz = (OP == 6'b000000 & Instr[5:0] == 6'b001010);
	wire GreaterThenReg, GreaterThenZero, LessThenReg, LessThenZero, 
		 EqualReg, EqualZero;	//�ǵ��з��űȽ�Ҫ��$signed()
	assign EqualReg = RD1==RD2;
	assign EqualZero = RD2==0;	//���п�����RD2,��ͬ
	assign GreaterThenReg  = $signed(RD1) > $signed(RD2);
	assign LessThenReg     = $signed(RD1) < $signed(RD2);
	assign GreaterThenZero = $signed(RD1) > 0;
	assign LessThenZero    = $signed(RD1) < 0;
	assign CMPout = (beq) ?  EqualReg:
					(movz)?	 EqualZero:0;
endmodule
