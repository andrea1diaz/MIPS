module Mux_3_5(in1, in2, in3, out, select);
	input wire[4:0] in1;
	input wire[4:0] in2;
	input wire[4:0] in3;
	input wire [1:0] select;
	output reg [4:0] out;

	always@(in1 or in2 or in3 or select) begin
		if(select == 2'b00) begin
			out = in1;
		end
		if(select == 2'b01) begin
			out = in2;
		end
		if(select == 2'b10) begin
			out = in3;
		end
	end
endmodule