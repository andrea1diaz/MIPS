module Clock(clk);
output reg clk;

initial begin
	clk = 0;
end
integer i;
always begin
	for(i = 0;i < 5;i = i +1) begin
		#5 clk <= ~clk;
	end
	$finish();
end

endmodule