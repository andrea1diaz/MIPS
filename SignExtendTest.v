module SignExtendTest();
    reg [15:0] in;
    reg [31:0] out;

    SignExtend ext(in, out);

    initial begin
	$dumpfile("SignExtendTest.vcd");
	$dumpvars(0, SignExtendTest);
	$display("SignExtend Test");

	in = 15'b101010101010101;
	
	
	#5 

	$display("Sign = %d, Extend = %d",in, out); 
    end
endmodule
