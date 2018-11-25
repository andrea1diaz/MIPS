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

	for(test_vals = 0;test_vals < 8;test_vals = test_vals + 1) begin
		{in1[0],in2[1],select} = test_vals[2:0];
		#5
		$display("in0 = %d, in1 = %d, select = %b. Output = %d",
 		in1, in2, select, out);
	end

    end
endmodule
