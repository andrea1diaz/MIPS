`include "DataMemory.v"
`include "DataMemory.v"
module DataMemoryTest();
    reg clk, rst;
    reg MemoryRead, MemoryWrite;
    reg [31:0] ALUResult;
    reg [31:0] read_data;
    reg [7:0] data_memory [255:0];
    wire [31:0] readDataMemory;

    DataMemory dataTest(clk, rst, ALUResult, read_data, MemoryRead, MemoryWrite, readDataMemory);

    initial begin
	$dumpfile("DataMemoryTest.vcd");
	$dumpvars(0, DataMemoryTest);
	$display("DataMemory Test");

	clk = 1'b1;
	rst = 1'b0;
	ALUResult = 32'hffffffff;
	read_data[ALUResult[31:24]] = 8'hff;
	read_data[ALUResult[23:16]] = 8'hff;
	read_data[ALUResult[15:8]] = 8'hff;
	read_data[ALUResult[7:0]] = 8'hff;

	MemoryWrite = 1'b1;
	MemoryRead = 1'b1;
  #5 clk=1'b0;
  #5 clk=1'b1;

	#5 $display("ALUResult = %d, Read_Data[0] = %d, Read_Data[1] = %d, Read_Data[2] = %d, Read_Data[3] = %d",
 		ALUResult, read_data[ALUResult[31:24]], read_data[ALUResult[23:16]],
		read_data[ALUResult[15:8]], read_data[ALUResult[7:0]]);

	 MemoryWrite = 1'b0;
	 MemoryRead = 1'b0;

	#5 $display("Read_DataMemory[0] = %d, Read_DataMemory[1] = %d, Read_DataMemory[2] = %d, Read_DataMemory[3] = %d",
		data_memory[ALUResult[31:24]], data_memory[ALUResult[23:16]],
		data_memory[ALUResult[15:8]], data_memory[ALUResult[7:0]]);
    end
endmodule
