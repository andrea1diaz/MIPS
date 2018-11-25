`include "ShiftLeft2.v"
module ShiftLeft2Test();
    reg [31:0] in;
    reg [31:0] out;

    reg [3:0] test_vals;

    ShiftLeft2 slt(in, out);

    initial begin
	$dumpfile("ShiftLeft2Test.vcd");
	$dumpvars(0, ShiftLeft2Test);
	$display("Shift Left 2");

	test_vals = 0;
	in = 32'b00001111;

	for(test_vals = 0;test_vals < 8;test_vals = test_vals + 1) begin
		in[3:0] = test_vals;
		#5
		$display("in = %dOutput = %d",
 		int, out);
	end

    end
endmodule
