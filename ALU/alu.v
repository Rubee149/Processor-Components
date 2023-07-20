// From the book: "But How Do It Know?" pg. 87, 88
// Written by: J. Clark Scott
//
//
// Verilog HDL implementation of the computer described in the book.
// Created and all credits goes to: David J. Marion
//
// Arithmetic and Logic Unit (ALU)
`timescale 1ns / 1ps
module alu(
	input [7:0] A,			// input operand 1
	input [7:0] B,			// input operand 2
	input c_in,				// carry in signal
	input [2:0] op,			// 3-bit opcode = maximum 8 instructions
	output [7:0] C,			// output result 
	output c_out,			// carry out signal
	output a_larger,		// A > B signal
	output equal,			// A == B signal
	output zero				// ALU result = 0 signal
	);
	
	// All 8 opcodes symbolically defined by octo notation
	parameter [2:0] ADD = 3'o0, // Addition
					RSH = 3'o1,	// right shift
					LSH = 3'o2,	// left shift
					NOT = 3'o3, // NOT operation
					AND = 3'o4, // AND operation
					OR  = 3'o5, // OR operation
					XOR = 3'o6, // XOR operation
					CMP = 3'o7; // Compare operation
	
	reg [8:0] out_reg;		// We need a ninth bit for the carry out from addition
	
	always @*
		case(op)
			ADD : out_reg <= A + B + c_in;
			RSH : out_reg <= {c_in, A[7:1]};
			LSH : out_reg <= {A[6:0], c_in};
			NOT : out_reg <= ~A;
			AND : out_reg <= A & B;
			OR  : out_reg <= A | B;
			XOR : out_reg <= A ^ B;
			CMP : out_reg <= A ^ B;			// Compare, used to set flags
		endcase
			   
	assign C = out_reg[7:0];	// ALU result
	assign zero = ~|C;			// reduction NOR to determine if result = 0
	assign equal = ((op == CMP) && (zero == 1'b1)) ? 1'b1 : 1'b0;	// At the compare operation, zero flag remain one, then equal port is one otherwise zero
	assign a_larger = ((op == CMP) && (A > B)) ? 1'b1 : 1'b0;  // At the compare operation, A larger than the B, then a_larger poer become one
	assign c_out = (op == ADD) ? out_reg[8]: (op == RSH) ? A[0]: (op == LSH) ? A[7]: 1'b0; //At the Addition, 9th bit of output register and At the Right shift, 1st bit of A and At the Left shift, 8th bit will be c out
	
endmodule