module single_port_ram #(
    parameter ADDR_WIDTH = 4, //4 bit address
    parameter DATA_WIDTH = 32, //32 bits data stream
    parameter DEPTH = 16 //16 registers available in RAM
) 
(
    input                  clk, //clock of the module
    input [ADDR_WIDTH-1:0] addr,//4 bits memory address
    inout [DATA_WIDTH-1:0] data,//32 bits data can be written
    input                  cs,  //control signal from the chip select port
    input                  we,  // write enable port for convert RAM to written in memory mode
    input                  oe   // Output enable port for convert RAM to reading mode from RAM
);

reg [DATA_WIDTH-1:0]  temp_data; 
reg [DATA_WIDTH-1:0]  mem[DEPTH];

always @(posedge clk) begin
    if (cs & we) begin
       mem[addr] <= data;     // write the data to the memory location specified by address   
    end
end

always @(posedge clk) begin
    if (cs & !we)
     temp_data <= mem[addr]; //read the data from the memory location specified by address
end
    

assign data = cs & oe & !we ? temp_data : 'hz; //If the chip select cs is active, output enable oe is active, and write enable we is inactive, it assigns the value of temp_data to data. Otherwise, it assigns high-impedance ('hz) to data, indicating that the output should be in a high-impedance state.

    
endmodule