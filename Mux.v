module Mux(opt1, opt2, out, select);
input opt1, opt2;
input select;
output out;

wire select;
wire [31:0] opt1, opt2;
wire [31:0] out;

assign out = select ? opt1 : opt2;

endmodule
