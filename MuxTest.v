`include "Mux.v"

module MuxTest();
    reg [31:0] in1, in2;
    reg select;
    wire [31:0] out;

    Mux mux (in1, in2, out, select);

    initial begin
	$dumpfile("MuxTest.vcd");
	$dumpvars(0, MuxTest);
	$strobe("MuxTest Test");
	in1 = 32'h00000001;
	in2 = 32'h00000000;
	select = 1'b0;
	$strobe("Output = %d", out);
	$strobe("In 1 = %b, In 2 = %b", in1, in2);
    end
endmodule
