module Mux(opt1, opt2, out, select);
input [31:0] opt1, opt2;
input select;

output reg [31:0] out;

always@(opt2 or opt1 or select) begin
	out = select ? opt2 : opt1;
end
endmodule
