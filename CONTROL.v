module CONTROL (clk, rst, Opcode, ALUOpcode, ALUSrc, MemoryWrite, RegisterWrite,
           RegistroDestino, MemoryToRegister, MemoryRead, Branch, Jump, Jal, LUIctrl);


  input [31:0] Opcode;
  input wire clk, rst;
  output reg [1:0]RegistroDestino;
  output reg [1:0]Jump;
  output reg Branch;
  output reg MemoryRead;
  output reg [1:0]MemoryToRegister;
  output reg [1:0]ALUOpcode;
  output reg [0:0]MemoryWrite;
  output reg ALUSrc;
  output reg RegisterWrite;
  output reg Jal;
  output reg LUIctrl;

  reg [3:0]state;

  parameter S1=1, S2=2, S3=3, S4=4, S5=5, S6=6, S7=7, S8=8, S9=9, S10=10, S11=11,S12=12;


  always @ (state or Opcode) begin
    case (state)
      S1: begin // lw || sw || ORi || ANDi
        RegistroDestino = 2'b00;
        Jump = 2'b00;
        Branch = 1'b0;
        MemoryRead = 1'b0;
        MemoryToRegister = 2'b00;
        ALUOpcode = 2'b00;
        MemoryWrite = 1'b0;
        ALUSrc = 1'b1;
        RegisterWrite = 1'b0;
        Jal = 1'b0;
        LUIctrl = 1'b0;
      end

      S2: begin // load word
        RegistroDestino = 2'b00;
        Jump = 2'b00;
        Branch = 1'b0;
        MemoryRead = 1'b1;
        MemoryToRegister = 2'b01;
        ALUOpcode = 2'b00;
        MemoryWrite = 1'b0;
        ALUSrc = 1'b1;
        RegisterWrite = 1'b1;
        Jal = 1'b0;
        LUIctrl = 1'b0;
      end

      S3: begin // store word
        RegistroDestino = 2'bzz;
        Jump = 2'b00;
        Branch = 1'b0;
        MemoryRead = 1'b0;
        MemoryToRegister = 2'bzz;
        ALUOpcode = 2'b00;
        MemoryWrite = 1'b1;
        ALUSrc = 1'b1;
        RegisterWrite = 1'b0;
	      Jal = 1'b0;
        LUIctrl = 1'b0;
      end

      S4: begin //addi
        RegistroDestino = 2'b00;
        Jump = 2'b00;
        Branch = 1'b0;
        MemoryRead = 1'b0;
        MemoryToRegister = 2'b00;
        ALUOpcode = 2'b00;
        MemoryWrite = 1'b1;
        ALUSrc = 1'b1;
        RegisterWrite = 1'b1;
        Jal = 1'b0;
        LUIctrl = 1'b0;
	    end
      S5: begin // op R-type
        RegistroDestino = 2'b00;
        Jump = 2'b00;
        Branch = 1'b0;
        MemoryRead = 1'b0;
        MemoryToRegister = 2'b00;
        ALUOpcode = 2'b10;
        MemoryWrite = 1'b0;
        ALUSrc = 1'b0;
        RegisterWrite = 1'b1;
        Jal = 1'b0;
        LUIctrl = 1'b0;
	    end
      S6: begin // op R-type
        RegistroDestino = 2'b01;
        Jump = 2'b00;
        Branch = 1'b0;
        MemoryRead = 1'b0;
        MemoryToRegister = 2'b00;
        ALUOpcode = 2'b10;
        MemoryWrite = 1'b1;
        ALUSrc = 1'b0;
        RegisterWrite = 1'b1;
        Jal = 1'b0;
        LUIctrl = 1'b0;
	    end
      S7: begin //beq
        RegistroDestino = 2'b00;
        Jump = 2'b00;
        Branch = 1'b0;
        MemoryRead = 1'b0;
        MemoryToRegister = 2'b00;
        ALUOpcode = 2'b01;
        MemoryWrite = 1'b0;
        ALUSrc = 1'b0;
        RegisterWrite = 1'b0;
        Jal = 1'b0;
        LUIctrl = 1'b0;
	    end
      S8: begin //beq
        RegistroDestino = 2'bzz;
        Jump = 2'b00;
        Branch = 1'b1;
        MemoryRead = 1'b0;
        MemoryToRegister = 2'bzz;
        ALUOpcode = 2'b01;
        MemoryWrite = 1'b0;
        ALUSrc = 1'b0;
        RegisterWrite = 1'b0;
        Jal = 1'b0;
        LUIctrl = 1'b0;
	    end
      S9: begin //jump
        RegistroDestino = 2'b00;
        Jump = 2'b01;
        Branch = 1'b0;
        MemoryRead = 1'b0;
        MemoryToRegister = 2'b00;
        ALUOpcode = 2'b00;
        MemoryWrite = 1'b0;
        ALUSrc = 1'b0;
        RegisterWrite = 1'b0;
        Jal = 1'b0;
        LUIctrl = 1'b0;
	    end

      S10: begin // Jal
        RegistroDestino = 2'b10;
        Jump = 2'b01;
        Branch = 1'b0;
        MemoryRead = 1'b0;
        MemoryToRegister = 2'b10;
        ALUOpcode = 2'bzz;
        MemoryWrite = 1'b0;
        ALUSrc = 1'bz;
        RegisterWrite = 1'b1;
        Jal = 1'b1;
        LUIctrl = 1'b0;
      end

      S11: begin //Junior
        RegistroDestino = 2'bzz;
        Jump = 2'b10;
        Branch = 1'b0;
        MemoryRead = 1'bz;
        MemoryToRegister = 1'bz;
        ALUOpcode = 2'bzz;
        MemoryWrite = 1'b0;
        ALUSrc = 1'bz;
        RegisterWrite = 1'b0;
        Jal = 1'b0;
        LUIctrl = 1'bz;
      end
      S12: begin //LUI
        RegistroDestino = 2'b00;
        Jump = 2'b00;
        Branch = 1'b0;
        MemoryRead = 1'bz;
        MemoryToRegister = 1'bz;
        ALUOpcode = 2'bxx;
        MemoryWrite = 1'b0;
        ALUSrc = 1'bz;
        RegisterWrite = 1'b1;
        Jal = 1'b0;
        LUIctrl = 1'b1;
      end

  endcase
  end

  always @ (clk or Opcode) begin
    if (Opcode[31:26] == 6'b100011 || Opcode[31:26] == 6'b101011 ||
        Opcode[31:26] == 6'b001100 || Opcode[31:26] == 6'b001101 ||
        Opcode[31:26] == 6'b001010 || Opcode[31:26] == 6'b100000 ||
        Opcode[31:26] == 6'b100001 || Opcode[31:26] == 6'b101000 ||
        Opcode[31:26] == 6'b101001 )
      state = S1;


    if (Opcode[31:26] == 6'b000000) // wtf?
      state = S6;

    if (Opcode[31:26] == 6'b001000) // addi
      state = S4;

    if(Opcode[31:26] == 6'b111111) // subi
      state = S7;

    if (Opcode[31:26] == 6'b000100 || Opcode[31:26] == 6'b000101 ||
        Opcode[31:26] == 6'b000111)
      state = S7;

    if (Opcode[31:26] == 6'b000010) // jump
      state = S9;

    if (Opcode[31:26] == 6'b000011) // jal
      state = S10;

    if (Opcode[31:26] == 6'b000000 && Opcode[3:0] == 4'b1000) // junior
      state = S11;


    case (state)
      // I - type op
      S1: begin
        if (Opcode[31:26] == 6'b100011) // load word
          state = S2;

        if (Opcode[31:26] == 6'b100000) // lb
          state = S2;

        if (Opcode[31:26] == 6'b100001) // lh
          state = S2;

        if (Opcode[31:26] == 6'b101011) // store word
          state = S3;

        if (Opcode[31:26] == 6'b101000) // sb
          state = S3;

        if (Opcode[31:26] == 6'b101001) // sh
          state = S3;

        if (Opcode[31:26] == 6'b001100) // ANDi
          state = S4;

        if (Opcode[31:26] == 6'b001101) // ORi
          state = S4;

        if (Opcode[31:26] == 6'b001010) // slti
          state = S4;
      end

      S5: begin
        state = S6;
      end

      S7: begin
        if (Opcode[31:26] == 6'b000100) // beq
          state = S8; //TODO

        if (Opcode[31:26] == 6'b00101) // bnq
          state = S8; //TODO

        if (Opcode[31:26] == 6'b000111) // bgtz
          state = S8; //TODO
	      end
    endcase
  end

endmodule //CONTROL
