module SignExtend(clk, in, out);
input clk;
input [15:0] in;

output reg [31:0] out;

always@( clk)
begin
	if(in[15] == 1)begin
		out = 32'hFFFF0000;
		out = out | in;
	end
	else begin
		out = 32'h00000000;
		out = in | out;
	end
end

endmodule
