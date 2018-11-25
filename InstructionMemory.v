module InstructionMemory (clk, rst, pc, instruct);
	input [7:0] pc;
	input clk, rst;
	reg [7:0] instruction_mem [0:1023];
	output reg [31:0] instruct;

initial begin
	$readmemb("instruct_mem.txt", instruction_mem);
end


always@(posedge clk) begin
	instruct <= {
		instruction_mem[pc],
		instruction_mem[pc+1],
		instruction_mem[pc+2],
		instruction_mem[pc+3]
	};

end
endmodule // InstructionMemory
