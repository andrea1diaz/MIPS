module JoinShiftJump(Shifted, Last4, Joined);
	input [27:0] Shifted;
	input [3:0] Last4;
	output [31:0] Joined;

	assign Joined[31:8] = Last4;
	assign Joined[27:0] = Shifted;
	
endmodule