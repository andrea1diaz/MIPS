module ShiftLeft2Jump (in, out);
  output [27:0]out;
  input [25:0]in;

  assign out = {in[25:0, 2'b0]}

endmodule // ShiftLeft2