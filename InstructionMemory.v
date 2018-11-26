module InstructionMemory (clk, rst, pc, instruct);
	input [31:0] pc;
	input clk, rst;
	reg [7:0] instruction_mem [0:1023];
	output reg [31:0] instruct;

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
		instruction_mem[pc[31:24]],
		instruction_mem[pc[23:16]],
		instruction_mem[pc[15:8]],
		instruction_mem[pc[7:0]]
	};

end
endmodule // InstructionMemory
