`include "InstructionMemory.v"

module InstructionMemoryTest();
    reg clk, rst;
    reg [7:0] pc;
    wire [31:0] instruct;


    InstructionMemory instMemTest(clk, rst, pc, instruct);

    initial begin
	$dumpfile("InstructionMemoryTest.vcd");
	$dumpvars(0, InstructionMemoryTest);
	$display("InstructionMemory Test");

	clk = 1'b1;
	rst = 1'b0;

	pc = 8'b00000000;

	#5 clk = 1'b0;
	#5 clk = 1'b1;
	

	#5
	$display("PC = %d, Instruct = %d",
 		pc, instruct);

    end
endmodule
