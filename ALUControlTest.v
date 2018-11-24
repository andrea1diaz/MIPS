module ALUControlTest();
    reg clk, rst;
    reg [1:0] Opcode;
    reg [3:0] Control;
    reg [5:0] funct;

    ALUControl aluControlTest(clk, rst, Opcode, Control, funct);

    initial begin
	$dumpfile("AluControlTest.vcd");
	$dumpvars(0, ALUControlTest);
	$display("ALUControl Test");

	clk = 1'b1;
	rst = 1'b0;

	Opcode = 2'b00;
	funct = 6'bxx0110;

	#5 
	$display("Opcode = %d, Control = %d, funct = %d",
 		Opcode, Control, funct); 
	
    end	
endmodule
