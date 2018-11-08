module InstructionMemory (ReadAddress, Instruction);
  output [31:0]Instruction;
  input [31:0]ReadAddress;

  always @ ( ReadAddress ) begin

  end

endmodule // InstructionMemory
