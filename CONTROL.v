module CONTROL (clk, rst, Opcode, ALUOpcode, ALUSrc, MemoryWrite, RegisterWrite,
           RegistroDestino, MemoryToRegister, MemoryRead, Branch, Jump);
  

  input [31:0] Opcode;
  input wire clk, rst;
  output reg RegistroDestino;
  output reg Jump;
  output reg Branch;
  output reg MemoryRead;
  output reg MemoryToRegister;
  output reg [1:0]ALUOpcode;
  output reg [0:0]MemoryWrite;
  output reg ALUSrc;
  output reg RegisterWrite;

  reg [1:0]state;

  parameter S0=0, S1=1, S2=2, S3=3, S4=4, S5=5, S6=6, S7=7, S8=8, S9=9;

  always @(state) begin
          case (state) 
            S0: begin // fetch instruction
              RegistroDestino = 1'b0;
              Jump = 1'b0;
              Branch = 1'b0;
              MemoryRead = 1'b0;
              MemoryToRegister = 1'b0;
              ALUOpcode = 2'b00;
              MemoryWrite = 1'b0;
              ALUSrc = 1'b0;
              RegisterWrite = 1'b0;
	   end
	
            S1: begin // lw || sw || addi || ORi || ANDi
              RegistroDestino = 1'b0;
              Jump = 1'b0;
              Branch = 1'b0;
              MemoryRead = 1'b0;
              MemoryToRegister = 1'b0;
              ALUOpcode = 2'b00;
              MemoryWrite = 1'b0;
              ALUSrc = 1'b1;
              RegisterWrite = 1'b0;
	    end
            S2: begin // load word
              RegistroDestino = 1'b0;
              Jump = 1'b0;
              Branch = 1'b0;
              MemoryRead = 1'b1;
              MemoryToRegister = 1'b1;
              ALUOpcode = 2'b00;
              MemoryWrite = 1'b0;
              ALUSrc = 1'b1;
              RegisterWrite = 1'b1;
	    end
            S3: begin // store word
              RegistroDestino = 1'bx;
              Jump = 1'b0;
              Branch = 1'b0;
              MemoryRead = 1'b0;
              MemoryToRegister = 1'bx;
              ALUOpcode = 2'b00;
              MemoryWrite = 1'b1;
              ALUSrc = 1'b1;
              RegisterWrite = 1'b0;
	    end
            S4: begin //addi
              RegistroDestino = 1'b0;
              Jump = 1'b0;
              Branch = 1'b0;
              MemoryRead = 1'b0;
              MemoryToRegister = 1'b0;
              ALUOpcode = 2'b00;
              MemoryWrite = 1'b0;
              ALUSrc = 1'b1;
              RegisterWrite = 1'b1;
	    end
            S5: begin // op R-type
              RegistroDestino = 1'b0;
              Jump = 1'b0;
              Branch = 1'b0;
              MemoryRead = 1'b0;
              MemoryToRegister = 1'b0;
              ALUOpcode = 2'b10;
              MemoryWrite = 1'b0;
              ALUSrc = 1'b0;
              RegisterWrite = 1'b0;
	    end
            S6: begin // op R-type
              RegistroDestino = 1'b1;
              Jump = 1'b0;
              Branch = 1'b0;
              MemoryRead = 1'b0;
              MemoryToRegister = 1'b0;
              ALUOpcode = 2'b10;
              MemoryWrite = 1'b0;
              ALUSrc = 1'b0;
              RegisterWrite = 1'b1;
	    end
            S7: begin //beq
              RegistroDestino = 1'b0;
              Jump = 1'b0;
              Branch = 1'b0;
              MemoryRead = 1'b0;
              MemoryToRegister = 1'b0;
              ALUOpcode = 2'b01;
              MemoryWrite = 1'b0;
              ALUSrc = 1'b0;
              RegisterWrite = 1'b0;
	    end
            S8: begin //beq
              RegistroDestino = 1'bx;
              Jump = 1'b0;
              Branch = 1'b1;
              MemoryRead = 1'b0;
              MemoryToRegister = 1'bx;
              ALUOpcode = 2'b01;
              MemoryWrite = 1'b0;
              ALUSrc = 1'b0;
              RegisterWrite = 1'b0;
	    end
            S9: begin //jump
              RegistroDestino = 1'b0;
              Jump = 1'b1;
              Branch = 1'b0;
              MemoryRead = 1'b0;
              MemoryToRegister = 1'b0;
              ALUOpcode = 2'b00;
              MemoryWrite = 1'b0;
              ALUSrc = 1'b0;
              RegisterWrite = 1'b0;
	    end
          endcase
     end

  always @ ( state, clk) begin
    case (state)
      S0: begin
        if (Opcode[31:26] == 6'b100011 || Opcode[31:26] == 6'b101011 ||
            Opcode[31:26] == 6'b001000 || Opcode[31:26] == 6'b001100 ||
            Opcode[31:26] == 6'b001101 || Opcode[31:26] == 6'b001010 ||
            Opcode[31:26] == 6'b100000 || Opcode[31:26] == 6'b100001 |
            Opcode[31:26] == 6'b101000 || Opcode[31:26] == 6'b101001)
          state = S1;

        if (Opcode[31:26] == 6'b000000) //sll
          state = S5;

        if (Opcode[31:26] == 6'b000100 || Opcode[31:26] == 6'b000101 ||
            Opcode[31:26] == 6'b000111)
          state = S7;

        if (Opcode[31:26] == 6'b000010)
          state = S9;
	end
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

        if (Opcode[31:26] == 6'b001000) // addi
          state = S4;

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
      default:
        state = S0;
    endcase
  end

endmodule //CONTROL