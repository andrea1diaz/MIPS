module CONTROL (clk, rst, Opcode, ALUOpcode, ALUSrc, MemoryWrite, RegisterWrite,
           RegistroDestino, MemoryToRegister, MemoryRead, Branch, Jump);
  
  input [31:0] instruction;
  wire clk, rst;
  wire RegistroDestino;
  wire Jump;
  wire Branch;
  wire MemoryRead;
  wire MemoryToRegister;
  reg [1:0]ALUOpcode;
  wire [0:0]MemoryWrite;
  wire ALUSrc;
  output wire RegisterWrite;

  reg [1:0]state;

  parameter S0=0, S1=1, S2=2, S3=3, S4=4, S5=5, S6=6, S7=7, S8=8, S9=9;

  always @(state) begin
          case (state)
            S0: // fetch instruction
              RegDst = 1'b0;
              Jump = 1'b0;
              Branch = 1'b0;
              MemRead = 1'b0;
              MemtoReg = 1'b0;
              ALUOp = 2'b00;
              MemWrite = 1'b0;
              ALUSrc = 1'b0;
              RegWrite = 1'b0;

            S1: // lw || sw || addi || ORi || ANDi
              RegDst = 1'b0;
              Jump = 1'b0;
              Branch = 1'b0;
              MemRead = 1'b0;
              MemtoReg = 1'b0;
              ALUOp = 2'b00;
              MemWrite = 1'b0;
              ALUSrc = 1'b1;
              RegWrite = 1'b0;

            S2: // load word
              RegDst = 1'b0;
              Jump = 1'b0;
              Branch = 1'b0;
              MemRead = 1'b1;
              MemtoReg = 1'b1;
              ALUOp = 2'b00;
              MemWrite = 1'b0;
              ALUSrc = 1'b1;
              RegWrite = 1'b1;

            S3: // store word
              RegDst = 1'bx;
              Jump = 1'b0;
              Branch = 1'b0;
              MemRead = 1'b0;
              MemtoReg = 1'bx;
              ALUOp = 2'b00;
              MemWrite = 1'b1;
              ALUSrc = 1'b1;
              RegWrite = 1'b0;

            S4: //addi
              RegDst = 1'b0;
              Jump = 1'b0;
              Branch = 1'b0;
              MemRead = 1'b0;
              MemtoReg = 1'b0;
              ALUOp = 2'b00;
              MemWrite = 1'b0;
              ALUSrc = 1'b1;
              RegWrite = 1'b1;

            S5: // op R-type
              RegDst = 1'b0;
              Jump = 1'b0;
              Branch = 1'b0;
              MemRead = 1'b0;
              MemtoReg = 1'b0;
              ALUOp = 2'b10;
              MemWrite = 1'b0;
              ALUSrc = 1'b0;
              RegWrite = 1'b0;

            S6: // op R-type
              RegDst = 1'b1;
              Jump = 1'b0;
              Branch = 1'b0;
              MemRead = 1'b0;
              MemtoReg = 1'b0;
              ALUOp = 2'b10;
              MemWrite = 1'b0;
              ALUSrc = 1'b0;
              RegWrite = 1'b1;

            S7: //beq
              RegDst = 1'b0;
              Jump = 1'b0;
              Branch = 1'b0;
              MemRead = 1'b0;
              MemtoReg = 1'b0;
              ALUOp = 2'b01;
              MemWrite = 1'b0;
              ALUSrc = 1'b0;
              RegWrite = 1'b0;

            S8: //beq
              RegDst = 1'bx;
              Jump = 1'b0;
              Branch = 1'b1;
              MemRead = 1'b0;
              MemtoReg = 1'bx;
              ALUOp = 2'b01;
              MemWrite = 1'b0;
              ALUSrc = 1'b0;
              RegWrite = 1'b0;

            S9: //jump
              RegDst = 1'b0;
              Jump = 1'b1;
              Branch = 1'b0;
              MemRead = 1'b0;
              MemtoReg = 1'b0;
              ALUOp = 2'b00;
              MemWrite = 1'b0;
              ALUSrc = 1'b0;
              RegWrite = 1'b0;

            default:
              S0;
          endcase
     end

  always @ ( state, clk) begin
    case (state)
      S0:
        if (Opcode[31:26] == 6'b100011 or Opcode[31:26] == 6'b101011 or
            Opcode[31:26] == 6'b001000 or Opcode[31:26] == 6'b001100 or
            Opcode[31:26] == 6'b001101 or Opcode[31:26] == 6'b001010 or
            Opcode[31:26] == 6'b100000 or Opcode[31:26] == 6'b100001 or
            Opcode[31:26] == 6'b101000 or Opcode[31:26] == 6'b101001)
          state = S1;

        if (Opcode[31:26] == 6'b000000) //sll
          state = S5;

        if (Opcode[31:26] == 6'b000100 or Opcode[31:26] == 6'b000101 or
            Opcode[31:26] == 6'b000111)
          state = S7;

        if (Opcode[31:26] == 6'b000010)
          state = S9;

      // I - type op
      S1:
        if (Opcode[31:26] == 6'b100011) // load word
          state = S2;

        if (Opcode[31:26] == 6'b100000) // lb
          state = S2

        if (Opcode[31:26] == 6'b100001) // lh
          state = S2

        if (Opcode[31:26] == 6'b101011) // store word
          state = S3;

        if (Opcode[31:26] == 6'b101000) // sb
          state = S3

        if (Opcode[31:26] == 6'b101001) // sh
          state = S3

        if (Opcode[31:26] == 6'b001000) // addi
          state = S4;

        if (Opcode[31:26] == 6'b001100) // ANDi
          state = S4;

        if (Opcode[31:26] == 6'b001101) // ORi
          state = S4

        if (Opcode[31:26] == 6'b001010) // slti
          state = S4


      S5:
        state = S6;

      S7:
        if (Opcode[31:26] == 6'b000100) // beq
          state = S8 //TODO

        if (Opcode[31:26] == 6'b00101) // bnq
          state = S8 //TODO

        if (Opcode[31:26] == 6'b000111) // bgtz
          state = S8 //TODO

      default:
        state = S0;
    endcase
  end

endmodule //CONTROL