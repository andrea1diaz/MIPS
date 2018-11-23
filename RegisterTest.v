
`include "Register.v"

module RegisterTest ();
  reg clk, rst;
  reg [31:0] writeBack;
  reg RegisterWrite, MemoryToRegister, MemoryWrite, Branch, ALUSrc;
  reg [4:0] readRegister1, readRegister2, writeRegister;
  wire [31:0] readData1, readData2;
  reg [31:0] reg_file [31:0];

  integer i;
  initial begin
    for(i = 0;i < 32;i = i + 1)begin
      reg_file[i] = 32'b0;
      end
  end

  Register register(clk, rst, readRegister1, readRegister2, writeRegister,
  					        readData1, readData2, writeBack, RegisterWrite,
                    MemoryToRegister, MemoryWrite, Branch, ALUSrc);

  initial begin
    $dumpfile("RegisterTest.vcd");
    $dumpvars(0, RegisterTest);

    clk = 1'b1;
    writeRegister = 5'b1;
    writeBack = 32'hffffffff;
    RegisterWrite = 1'b1;

    #2 clk = 1'b0;

    #2 $display("Data  = %d, Register = %d", writeBack, writeRegister);

    RegisterWrite = 1'b0;
    #2 readRegister1 = 1;

    $display("DataRead =  %d, Register = %d", readData2, readRegister1);

    $finish;

  end





endmodule // Register
