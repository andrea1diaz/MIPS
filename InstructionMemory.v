module InstructionMemory (clk, rst, pc, instruct);
	input [7:0] pc;
	input clk, rst;
	reg [7:0] instruction_mem [0:255];
	output reg [31:0] instruct;

always@(clk) begin
	instruct[31:24] <= instruction_mem[pc]; //TODO ARREGLAR
	instruct[23:16] <= instruction_mem[pc+1];
	instruct[15:8] <= instruction_mem[pc+2];
	instruct[7:0] <= instruction_mem[pc+3];
	$display("in %b", instruction_mem[pc]);

end
endmodule // InstructionMemory
