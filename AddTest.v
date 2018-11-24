module AddTest();
    reg [31:0] in, in2;
    reg [31:0] out;

    reg [3:0] test_vals;

    ADD add_t(in, in2, out);

    initial begin
	$dumpfile("AddTest.vcd");
	$dumpvars(0, AddTest);
	$display("Add Test ");

	test_vals = 0;
	in = 32'b00001111;

	for(test_vals = 0;test_vals < 8;test_vals = test_vals + 1) begin
		in[3:0] = test_vals;
		in2[3:0] = test_vals;
		#5 
		$display("in1 = %d, int2 = %d, Output = %d",
 		int, in2, out); 
	end
	
    end	
endmodule