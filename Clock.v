module Clock(clk);
output reg clk;

initial begin
	clk = 0;
end

initial #60 $finish();

always begin
	#10 clk = ~clk;
end

endmodule
