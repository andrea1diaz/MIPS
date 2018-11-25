module Mux(opt1, opt2, out, select);
input [31:0] opt1, opt2;
input select;

output reg [31:0] out;

always@(opt1 or opt2 or select) begin
	out = select ? opt1 : opt2;
end
endmodule
 : 