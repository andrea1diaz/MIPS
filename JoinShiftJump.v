module JoinShiftJump(last_4, op_code_28, joined);
	input wire [3:0] last_4;
	input wire [27:0] op_code_28;
	output reg [31:0] joined;

always@(*) begin
	joined = {last_4, op_code_28};
end
endmodule
