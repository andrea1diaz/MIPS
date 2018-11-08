module CONTROL (Op, clk, in, out, reset, RegDst, Branch, MemRead, MemtoReg,
                ALUOp, MemWrite, ALUSrc, RegWrite);
  output wire RegDst;
  output wire Branch;
  output wire MemRead;
  output wire MemtoReg;
  output reg [1:0]ALUOp;
  output wire [0:0]MemWrite;
  output wire ALUSrc;
  output wire RegWrite;
  output out;
  input [31:0]Op;
  input clk;
  input in;
  input reset;

  reg [3:0]out;
  reg [1:0]state;

  parameter S0=0, S1=1, S2=2, S3=3, S4=4, S5=5, S6=6, S7=7, S8=8;

  always @(state) begin
          case (state)
            S0: // fetch instruction
              out = 4'b0000;
              RegDst = 1'b0;
              Branch = 1'b0;
              MemRead = 1'b0;
              MemtoReg = 1'b0;
              ALUOp = 2'b00;
              MemWrite = 1'b0;
              ALUSrc = 1'b0;
              RegWrite = 1'b0;

            S1: // load word or store word
              out = 4'b0001;
              RegDst = 1'b0;
              Branch = 1'b0;
              MemRead = 1'b0;
              MemtoReg = 1'b0;
              ALUOp = 2'b00;
              MemWrite = 1'b0;
              ALUSrc = 1'b1;
              RegWrite = 1'b0;

            S2: // load word
              out = 4'b0010;
              RegDst = 1'b0;
              Branch = 1'b0;
              MemRead = 1'b1;
              MemtoReg = 1'b1;
              ALUOp = 2'b00;
              MemWrite = 1'b0;
              ALUSrc = 1'b1;
              RegWrite = 1'b1;

            S3: // store word
              out = 4'b0100;
              RegDst = 1'b0;
              Branch = 1'b0;
              MemRead = 1'b0;
              MemtoReg = 1'b0;
              ALUOp = 2'b00;
              MemWrite = 1'b0;
              ALUSrc = 1'b1;
              RegWrite = 1'b1;

            S4: //addi
              out = 4'b1000;
              RegDst = 1'b0;
              Branch = 1'b0;
              MemRead = 1'b0;
              MemtoReg = 1'b0;
              ALUOp = 2'b00;
              MemWrite = 1'b0;
              ALUSrc = 1'b1;
              RegWrite = 1'b1;

            S5: // op R-type
              out = 4'b0101;
              RegDst = 1'b0;
              Branch = 1'b0;
              MemRead = 1'b0;
              MemtoReg = 1'b0;
              ALUOp = 2'b10;
              MemWrite = 1'b0;
              ALUSrc = 1'b0;
              RegWrite = 1'b0;

            S6: // op R-type
              out = 4'b0110;
              RegDst = 1'b1;
              Branch = 1'b0;
              MemRead = 1'b0;
              MemtoReg = 1'b0;
              ALUOp = 2'b10;
              MemWrite = 1'b0;
              ALUSrc = 1'b0;
              RegWrite = 1'b1;

            S7: //beq
              out = 4'b1001;
              RegDst = 1'b0;
              Branch = 1'b0;
              MemRead = 1'b0;
              MemtoReg = 1'b0;
              ALUOp = 2'b01;
              MemWrite = 1'b0;
              ALUSrc = 1'b0;
              RegWrite = 1'b0;

            S8: //beq
              out = 4'b1010;
              RegDst = 1'b0;
              Branch = 1'b1;
              MemRead = 1'b0;
              MemtoReg = 1'b0;
              ALUOp = 2'b01;
              MemWrite = 1'b0;
              ALUSrc = 1'b0;
              RegWrite = 1'b0;

            default:
              out = 4'b0000;
          endcase
     end

  always @(posedge clk or posedge reset) begin
    if (reset)
      state = S0;
    else
      case (state)
        S0:
          state = S1;
        S1:
          if (in)
            state = S0;
          else
            state = S2;
        S2:
          state = S3;
        S3:
          state = S4;
        S4:
          state = S5;
        S5:
          state = S6;
        S6:
          state = S7;
        S7:
          state = S8;
        S8:
          state = S0;
    endcase
  end

  always @ ( state, Opcode ) begin
    case (state)
      S0:
        if (Opcode[31:26] == 6'b100011 or Opcode[31:26] == 6'b101011 or
            Opcode[31:26] == 6'b001000)
          state = S1;

        if (Opcode[31:26] == 6'b000000)
          state = S5;

        if (Opcode[31:26] == 6'b000100)
          state = S7;

      S1:
        if (Opcode[31:26] == 6'100011) // load word
          state = S2;

        if (Opcode[31:26] == 6'101011) // store word
          state = S3;

          if (Opcode[31:26] == 6'001000) // addi
            state = S4;

      S5:
        state = S6;

      S7:
        state = S8;

      default:
        state = S0;
    endcase
  end

endmodule //CONTROL
