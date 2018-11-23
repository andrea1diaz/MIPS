module InstructionMemory (clk, rst, instruction_mem, pc, instruct);
	input [7:0] pc;
	input clk, rst;
	input reg [7:0] instruction_mem [0:255];
	output reg [31:0] instruct;

	wire [7:0] inst_1;
	wire [7:0] inst_2;
	wire [7:0] inst_3;
	wire [7:0] inst_4:

	assign inst_1 = instruction[pc];
	assign inst_2 = instruction[pc+1];
	assign inst_3 = instruction[pc+2];
	assign inst_4 = instruction[pc+3];

	assign instruct = inst_1 + inst_2 + inst_3 + inst_4;

	always @ (clk) begin
		instruct = inst_1 + inst_2 + inst_3 + inst_4;
	end

endmodule // InstructionMemory