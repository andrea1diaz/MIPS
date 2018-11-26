module PC(clk, pc, target_pc, clk_out);
	input clk;
	input [31:0] target_pc;
	output reg [31:0] pc;
	output clk_out;
	assign clk_out = clk;

	initial  begin
		pc = 32'b0;
	end
	always @ (posedge clk) begin
		pc = target_pc;
	end
endmodule
