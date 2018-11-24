module AndTest();
    reg A, B, out;

    AND and_t(A, B, out);

    initial begin
	$dumpfile("AndTest.vcd");
	$dumpvars(0, AndTest);
	$display("And Test ");

	A = 32'h01010101;
	B = 32'h11111111;

	#5 
	$display("A = %d, B = %d, Output = %d",
 		A, B, out);
	
    end	
endmodule