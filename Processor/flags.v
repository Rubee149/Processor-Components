
`timescale 1ns / 1ps
module flags (
    input s,
    input [3:0] caez_in,
    output reg [3:0] caez_out = 4'h0
);

always @(*)
  if(s == 1'b1)
    caez_out <= caez_in;    

    
endmodule