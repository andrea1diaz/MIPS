module ALU (clk, rst, A, B, zero, ALUresult, ALUcontrol);
  output reg zero;
  output reg [31:0] ALUresult;
  input [31:0] A;
  input [31:0] B;
  input [3:0] ALUcontrol;
  input clk;
  input rst;
  reg [32:0] temp;

  always @ (clk) begin
    case (ALUcontrol)
      4'b0000: //AND
        ALUresult = A & B;
      4'b0001: //OR
        ALUresult = A | B;
      4'b0010: //add
        if( A+B > 32'hFFFFFFFF) begin
          temp = A+B;
          ALUresult = temp[31:0];
	end
        else begin
          ALUresult = A + B;
	end
      4'b0110: begin //subtract
        ALUresult = (A - B);
        zero = (A - B) == 32'h00000000 ? 1'b1 : 1'b0;
	end
      4'b0111: // set on less than
        ALUresult = (A < B) ? 1'b1 : 1'b0;
    endcase
  end
endmodule
