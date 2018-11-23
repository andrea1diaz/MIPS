module MuxTest();
    reg [31:0] in1, in2;
    reg select;
    reg [31:0] out;
    reg [3:0] test_vals;

    initial begin
	$display("Test mux");
	test_vals = 0;
	in1 = 32'b0;
	in2 = 32'b0;

	for(test_vals = 0;test_vals < 8;test_vals = test_vals + 1) begin
		{in[0],in[1],select} = test_vals[2:0];
		#5 
		$display("in0 = %d, in1 = %d, select = %b. Output = %d",
 		out0, out1, select, out); 
	end
	
	end	
endmodule