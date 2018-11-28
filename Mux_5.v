module Mux_5(opt1, opt2, out, select);

input wire select;
input wire [4:0] opt1, opt2;
output reg [4:0] out;

always@(opt1 or opt2) begin
	out = select ? opt2 : opt1;
end

endmodule
