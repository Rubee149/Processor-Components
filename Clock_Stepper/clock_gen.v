// From the book: "But How Do It Know?" pg. 96, 97
// Written by: J. Clark Scott
//
// Verilog HDL implementation of the computer described in the book.
// Created and all credits goes to: David J. Marion
//
// Clock Module
`timescale 1ns / 1ps
module clock_gen(
	input sys_clk,		// system input clock of arbitrary frequency
	output clk,			// stepper clock
	output clk_e,		// enable clock
	output clk_s		// set clock
	);
	
	reg [1:0] clk_reg = 2'b00; //clock register start from 0
	
	always @(posedge sys_clk)
		clk_reg <= clk_reg + 1; //increment of the clock register 1,2
		
	assign clk = ((clk_reg == 2'b00) || (clk_reg == 2'b01)) ? 1'b1 : 1'b0; //If clock reg 0 or 1, then clk become 1
	assign clk_e = clk_reg == 2'b11 ? 1'b0 : 1'b1; //If clock reg 3 then enable clock become 1
	assign clk_s = clk_reg == 2'b01 ? 1'b1 : 1'b0; //If clock reg 1 them set clock become 1
	
endmodule