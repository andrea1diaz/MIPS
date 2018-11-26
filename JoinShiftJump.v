module JoinShiftJump(last_4, op_code_25, joined);
	input wire [27:0] op_code_25;
	input wire [3:0] last_4;
	output reg [31:0] joined;

always@(*) begin
	joined = {last_4, op_code_25};
end
endmodule