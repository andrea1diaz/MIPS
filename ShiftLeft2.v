module ShiftLeft2 (in, out);
  output [32:0]out;
  input [32:0]in;

  assign out = {in[29:0, 2'b0]}

endmodule // ShiftLeft2
