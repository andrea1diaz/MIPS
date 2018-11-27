module PC(clk, pc);
	input clk;
	input [31:0] target_pc;
	output reg [31:0] pc;

	initial  begin
		pc = 32'b0;
	end
	
	always @ (posedge clk) begin
		pc = pc + 32'h4;
	end
endmodule
