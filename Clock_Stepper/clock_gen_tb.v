// From the book: "But How Do It Know?" pg. 96, 97
// Written by: J. Clark Scott
//
// Verilog HDL implementation of the computer described in the book.
// Created and all credits goes to: David J. Marion
//
// TEST BENCH for Clock Module
`timescale 1ns / 1ps
`include "clock_gen.v"
module clock_gen_TB;
	
	reg sys_clk;
	wire clk, clk_e, clk_s;
	
	clock_gen DUT(
		.sys_clk(sys_clk),
		.clk(clk),
		.clk_e(clk_e),
		.clk_s(clk_s)
	);
	
	always #1 sys_clk = ~sys_clk;
	
	initial begin
		$dumpfile("clk_gen.vcd");
		$dumpvars(0, clock_gen_TB);
	end
	
	initial begin
		sys_clk = 1'b0;	// Initialize system clock
        #40 
        $display("Test Complete");
		$finish;
	end
	
endmodule