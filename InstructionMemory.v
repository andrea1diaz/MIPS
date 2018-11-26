module InstructionMemory (clk, rst, pc, instruct, clk_out);
	input [7:0] pc;
	input clk, rst;
	reg [7:0] instruction_mem [0:1023];
	output reg [31:0] instruct;
	output clk_out;

	assign clk_out = clk;
initial begin
	$readmemb("instruct_mem.txt", instruction_mem);
end

integer i;
always@(posedge clk) begin
	if(rst) begin
		for(i = 0;i < 1024;i = i + 1) begin
			instruction_mem[ i ] = 0;
		end
	end
	instruct <= {
		instruction_mem[pc],
		instruction_mem[pc+1],
		instruction_mem[pc+2],
		instruction_mem[pc+3]
	};

end
endmodule // InstructionMemory
