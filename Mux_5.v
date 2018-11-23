module Mux_5(opt1, opt2, out, select);
input opt1, opt2;
input select;
output out;

wire select;
wire [4:0] opt1, opt2;
wire [4:0] out;

assign out = select ? opt1 : opt2;

endmodule
