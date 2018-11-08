module PCcounter(clk, rst, in, out);
input in[31:0];
output out[31:0];

reg clk, rst;


always@(posedge clk, rst, in);
begin
	if(rst)
		out = 32'h00000000;
	out = in + 4'h4;
end
endmodule
