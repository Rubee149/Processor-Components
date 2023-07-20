//
// Verilog HDL implementation of the computer described in the book.
// Created and all credits goes to: David J. Marion
//
// Main Memory 

`timescale 1ns / 1ps
module ram(
	input [7:0] a,			// memory address
	input sa,				// set memory address in memory address register
	input s,				// set data in memory at address
	input e,				// enable data out from memory at address
	inout [7:0] bus			// 8-bit data to/from data bus
	);
	
	// Memory Address Register (MAR)
	reg [7:0] addr_reg;
	
	// Random Access Memory (RAM)
	reg [7:0] mem_reg[0:255];		// 256 memory addresses
	
	// Set address register
	always @*
		if(sa == 1'b1)
			addr_reg <= a;
		
	// Data Input
	always @*
		if(s == 1'b1)
			mem_reg[addr_reg] <= bus; //Data write in memory in specified adress
		
	// Data Output
	assign bus = e ? mem_reg[addr_reg] : 8'bz; //if ram is enable then available data in bus feed in to the memory specified by address otherwise feed z

endmodule