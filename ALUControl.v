module ALUControl (clk, rst, ALUOpcode, ALUControl, op_5_0, clk_out);
  output reg [3:0]ALUControl;
  input [1:0] ALUOpcode;
  input [5:0] op_5_0;
  input clk, rst;
  output clk_out;
  assign clk_out = clk;

  always @ (posedge clk) begin
    if (ALUOpcode == 2'b00) ALUControl = 4'b0010; // load word - store word - addi
    if (ALUOpcode == 2'bx1) ALUControl = 4'b0110; // branch equal - bnq - subi
    if (ALUOpcode == 2'b1x) begin
        case (op_5_0[3:0])
          4'b0000:
            ALUControl = 4'b0010; // add
          4'b0010:
            ALUControl = 4'b0110; // subtract
          4'b0100:
            ALUControl = 4'b0000; // AND
          4'b0101:
            ALUControl = 4'b0001; // OR
          4'b1010:
            ALUControl = 4'b0111; // set on less than
        endcase
      end
  end
endmodule //ALUcontrol