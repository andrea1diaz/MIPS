module Mux_5Test();
    reg [4:0] in1, in2, out;
    reg select;
    
    initial begin
	$dumpfile("Mux_5Test.vcd");
	$dumpvars(0, Mux_5);
	$display("Mux_5 Test");

	in1 = 5'b11111;
	in2 = 5'b00000;
	

	#5 
	
	$display("in1 = %d, in2 = %d, select = %d Output = %d",
 		in, in2, select, out); 
    end	
endmodule
