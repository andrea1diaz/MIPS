`include "Mux.v"

module MuxTest();
    reg [31:0] in1, in2;
    reg select;
    wire [31:0] out;
    reg [3:0] test_vals;

    Mux mux (in1, in2, out, select);

    initial begin
	$dumpfile("MuxTest.vcd");
	$dumpvars(0, MuxTest);
	$display("MuxTest Test");
	test_vals = 0;
	in1 = 32'b0;
	in2 = 32'b0;
	$display("Output = %d", out);
    end
endmodule
