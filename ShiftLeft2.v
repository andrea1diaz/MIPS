module ShiftLeft2 (in, out);
  output reg [31:0]out;
  input [31:0]in;

always@(in) begin
	out = {in[29:0], 2'b00};
end
endmodule // ShiftLeft2
