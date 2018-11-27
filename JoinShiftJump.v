module JoinShiftJump(last_4, op_code_28, joined);
	input wire [3:0] last_4;
	input wire [25:0] op_code_28;
	output reg [31:0] joined;

	always@(op_code_28) begin
		joined = {last_4,op_code_28,2'b00};
	end
endmodule
