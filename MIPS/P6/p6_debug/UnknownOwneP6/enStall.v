`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:13:28 12/12/2017 
// Design Name: 
// Module Name:    enStall 
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
//��Ϊ���ܼ���ͣ��Ҫjr��ת������ͣ�����ȼ���һЩ
//��ͣ�����E�Ĵ���ֵ������PC��D��
//Branch�ɹ�ʱ����D�Ĵ������㣨EҲ�������㣬��Ϊbeq�Ⱥ��治��ʶ��
module enStall(
	input Stall_Data,
	output PC_En,
	output D_En,
	output E_Clr
    );
	
	assign PC_En = Stall_Data;
	assign D_En	 = Stall_Data;
	assign E_Clr = Stall_Data;


endmodule
