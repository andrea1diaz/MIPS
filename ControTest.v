
module ControlTest();
  reg [31:0] Opcode;
  reg clk, rst;
  reg RegistroDestino;
  reg Jump;
  reg Branch;
  reg MemoryRead;
  reg MemoryToRegister;
  reg [1:0]ALUOpcode;
  reg [0:0]MemoryWrite;
  reg ALUSrc;
  reg RegisterWrite;

  CONTROL control(clk, rst, Opcode, ALUOpcode, ALUSrc, MemoryWrite, RegisterWrite,
           RegistroDestino, MemoryToRegister, MemoryRead, Branch, Jump);

    initial begin
	$dumpfile("ControlTest.vcd");
	$dumpvars(0, ControlTest);
	$display("Control Test");

	clk = 1'b1;
	rst = 1'b0;

	
	Opcode = 32'b10001100000000000000000000000000;

	$display("RegisterWrite = %d, writeRegister = %d, writeBack = %d",
 		RegisterWrite, writeRegister, writeBack);
    end	
endmodule