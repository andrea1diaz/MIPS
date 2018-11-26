module Clock(clk);
					 output reg clk;

					 initial begin
						 clk = 0;
					 end
					 initial #20 $finish();

					 always begin
						 #5 clk <= ~clk;
					 end
			 endmodule
