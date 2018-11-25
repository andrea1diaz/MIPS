module Mux_5(opt1, opt2, out, select);

input wire select;
input wire [4:0] opt1, opt2;
output wire [4:0] out;

assign out = select ? opt1 : opt2;

endmodule
