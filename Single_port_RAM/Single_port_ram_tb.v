`timescale 1ns/1ns
`include "Single_port_ram.v"


module single_port_ram_tb;
 
 parameter ADDR_WIDTH = 4;
 parameter DATA_WIDTH = 16;
 parameter DEPTH = 16;

 reg clk;
 reg cs;
 reg we;
 reg oe;
 reg [ADDR_WIDTH-1:0] addr;
 wire [DATA_WIDTH-1:0] data;
 reg [DATA_WIDTH-1:0] tb_data;

 single_port_ram #(.DATA_WIDTH(DATA_WIDTH)) u0
 (                        .clk(clk),
                          .addr(addr),
                          .data(data),
                          .cs(cs),
                          .we(we),
                          .oe(oe));
 

 always #10 clk = ~clk;
 assign data = !oe ? tb_data : 'hz; //when oe inactive assign tb_data to data

 initial begin
 
    $dumpfile("Single_port_ram_tb.vcd");
    $dumpvars(0,single_port_ram_tb);

 {clk, cs, we, addr, tb_data, oe} <= 0;

 repeat (2) @ (posedge clk); //wait for two positive edges to ensure proper initialization

 for (integer i =0; i<2**ADDR_WIDTH; i=i+1) begin //check RAM for each address value by writing random values (write operation)
    repeat (1) @(posedge clk); 
    addr <= i; 
    we <= 1; 
    cs <= 1; 
    oe <= 0; 
    tb_data <= $random;
 end
 
 for (integer i = 0;i < 2**ADDR_WIDTH ; i=i+1 ) begin //check read operation
    repeat (1) @(posedge clk);
    addr <= i; 
    we <= 0; 
    cs <= 1; 
    oe <= 1;
 end
  
  #20 
  $display("Test Complete");
  $finish;
 end

  initial
    $monitor ("cs=%b, we=%b, oe=%b, tb_data=%b, addr=%b, data=%b",cs,we,oe,tb_data,addr,data);

endmodule