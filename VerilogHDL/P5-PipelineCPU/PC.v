`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:36:58 12/19/2017 
// Design Name: 
// Module Name:    PC 
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
module PC(
    input [31:0] NPC,
    input EN,
    input reset,
    input clk,
    output [31:0] PC_F
    );
	reg[31:0] pc;
	assign PC_F = pc;
	initial begin
		pc = 32'h00003000;
	end
	always @(posedge clk) begin 
		if (reset) begin
			pc = 32'h00003000;
		end
		else if(reset == 0 && EN == 1) begin
			pc <= NPC;
		end
		else if(reset == 0 && EN == 0) begin
			pc <= pc;
		end
	end

endmodule
