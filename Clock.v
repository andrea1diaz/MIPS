module Clock(clk);
output reg clk;

initial begin
	clk = 0;
end

initial #50 $finish();

always begin
	#5 clk = ~clk;
end

endmodule
