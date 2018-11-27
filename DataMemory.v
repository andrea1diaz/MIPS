module DataMemory (clk, rst, ALUResult, read_data, MemoryRead, MemoryWrite, readDataMemory);
	input wire clk, rst;
	input wire MemoryRead, MemoryWrite;
	input wire [31:0] ALUResult;
	input wire [31:0] read_data;
	output reg [31:0] readDataMemory;

	reg [7:0] data_memory [0:255];

always@ (posedge clk)begin
      if(MemoryRead) begin
        readDataMemory[31:24] <= data_memory[ALUResult];
        readDataMemory[23:16] <= data_memory[ALUResult[23:16]];
        readDataMemory[15:8] <= data_memory[ALUResult[15:8]];
        readDataMemory[7:0] <= data_memory[ALUResult[7:0]];
      end
 end
always @(negedge clk)
    begin
        if (MemoryWrite) begin
            data_memory[ALUResult[9:2]] <= read_data;
						readDataMemory <= read_data;
        end
    end
endmodule
