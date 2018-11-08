module ALUcontrol (ALUoperation, funct, ALUcontrol);
  output [3:0]ALUcontrol;
  input [1:0]ALUop;
  input [5:0]funct;

  always @ ( ALUoperation, funct ) begin
    if (ALUop == 2'b00) ALUcontrol = 4'b0010; // load word - store word
    if (ALUop == 2'b01) ALUcontrol = 4'b0110; // branch equal
    if (ALUop == 2'b10) begin
        case (funct[3:0])
          4'b0000:
            ALUcontrol = 4'b0010; // add
          4'b0010:
            ALUcontrol = 4'b0110; // subtract
          4'b0100:
            ALUcontrol = 4'b0000; // AND
          4'b0101:
            ALUcontrol = 4'b0001; // OR
          4'b1010:
            ALUcontrol = 4'b0111; // set on less than
        endcase
      end
  end
endmodule //ALUcontrol
