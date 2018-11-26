module Clock(clk);
output reg clk;

initial begin
	clk = 0;
end

always@(*) begin
	#5 clk = ~clk;
	#5 clk = ~clk;
end

endmodule