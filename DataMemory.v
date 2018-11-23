module MainMemory (clk, rst, data_memory, ALUResult, read_data, MemoryRead, MemoryWrite, readDataMemory);
	input wire clk, rst;
	input wire MemoryRead, MemoryWrite;
	input wire [31:0] ALUResult;
	input wire [31:0] read_data;
	output reg [3:0] data_memory[255:0];
	output wire [31:0] readDataMemory;
	
always@ (clk)begin
      if(MemoryRead) begin
        readDataMemory[31:24] <= data_memory[ALUResult[31:24]];
        readDataMemory[23:16] <= data_memory[ALUResult[23:16]];
        readDataMemory[15:8] <= data_memory[ALUResult[15:8]];
        readDataMemory[7:0] <= data_memory[ALUResult[7:0]];
      end
 end
always @(negedge clk)
    begin
        if (MemoryWrite) begin
            data_memory[31:24] <= read_data[ALUResult[31:24]];
            data_memory[23:16] <= read_data[ALUResult[23:16]];
            data_memory[15:8] <= read_data[ALUResult[15:8]];
            data_memory[7:0] <= read_data[ALUResult[7:0]];
        end
    end
endmodule
