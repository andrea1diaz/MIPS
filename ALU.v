module ALU (A, B, zero, ALUresult, ALUcontrol);
  output zero;
  output [31:0]ALUresult;
  input [31:0]A;
  input [31:0]B;
  input [3:0] ALUcontrol;
  reg [32:0] temp;

  assign zero = (ALUresult == 0);

  @always @ (A or B or ALUcontrol) begin
    case (ALUcontrol)
      4'b0000: //AND
        ALUresult = A & B;
      4'b0001: //OR
        ALUresult = A | B;
      4'b0010: //add
        if( A+B > 0xFFFFFFFF)
          temp = A+B;
          ALUresult = temp[31:0];
        else
          ALUresult = A + B;
      4'b0110: //subtract
        ALUresult = A - B;
      4'b0111: // set on less than
        ALUresult = (A < B) ? 1'b1 : 1'b0; //ver si esto esta bien, lo hice en la madrugada
    endcase
  end
endmodule
