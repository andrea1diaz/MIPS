module JoinShiftJumpTest();
    reg [27:0] in1;
    reg [3:0] in2;
    reg [31:0] out;

    JoinShiftJump joinShiftJumpTest(in1, in2, out);

    initial begin
	$dumpfile("JoinShiftJumpTest.vcd");
	$dumpvars(0, JoinShiftJumpTest);
	$display("JoinShiftJump Test");

	in1 = 28'b0000000000000000000000000000;
	in2 = 4'b1111; 	
	
	#5 
	$display("in1 = %d, int2 = %d, Output = %d",
 		in1, in2, out); 
	
    end	
endmodule