module PC(clk, pc, target_pc, Jump, Branch);
	input clk;
	input [31:0] target_pc;
	input Jump, Branch;
	output reg [31:0] pc;

	initial  begin
		pc = 32'b0;
	end

	always @ (posedge clk) begin
		pc = pc + 32'h4;
		if (Jump || Branch)
			pc = target_pc;
	end
endmodule
