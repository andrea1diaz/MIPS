`include "Add.v"
`include "AND.v"
`include "ALU.v"
`include "Mux_3.v"
`include "Mux_3_5.v"
`include "ALUControl.v"
`include "CONTROL.v"
`include "InstructionMemory.v"
`include "JoinShiftJump.v"
`include "DataMemory.v"
`include "Mux.v"
`include "Mux_5.v"
`include "Register.v"
`include "ShiftLeft2.v"
`include "SignExtend.v"
`include "PC.v"
`include "Clock.v"
`include "Add_Single.v"

module DataPath();
	wire clk, rst;


	//Variables generales
	reg [4:0] op_31_26;
	reg [4:0] op_25_21;
	reg [4:0] op_20_16;
	reg [4:0] op_15_11;
	reg [15:0] op_15_0;
	reg [5:0] op_5_0;
	reg [25:0] op_25_0;

	//Wires InstructionMemory
	wire [31:0] instruction;

	//Wires PC
	wire [31:0] pc;
	wire [31:0] target_pc_im;

	//Wires de CONTROL
	wire [1:0]Jump;
	wire [1:0]RegistroDestino;
	wire Branch;
	wire MemoryRead;
	wire [1:0]MemoryToRegister;
	wire [0:0] MemoryWrite;
	wire [1:0] ALUOpcode;
	wire ALUSrc;
	wire RegisterWrite;
	wire Jal;

	//Wires ALU
	wire [31:0] A, B;
	wire [3:0] ALUControl;
	wire [31:0] ALUResult;
	wire branch_res;

	//Variable DataMemory
	reg [7:0] data_memory [1023:0];
	wire [31:0] readDataMemory;

	//Variable Shift
	wire [27:0] shift_out;
	wire [31:0] shift_2;
	wire [31:0] shift_join;

	//Variable Register
	reg [31:0] reg_file [31:0];
	wire [4:0] readRegister1;
	wire [4:0] readRegister2;
	wire [4:0] writeRegister;

	wire[31:0] readData1;
	wire[31:0] readData2;

	//Variables Mux_5
	wire [4:0] mux_5_result;
	wire mux_5_select;

	//Variables Mux 32
	wire [31:0] mux_32_1;
	wire [31:0] mux_32_result;
	wire mux_32_select;

	wire [31:0] mux_mem_to_reg;

	//Variables SignExtend 16->32
	wire [31:0] extend_32;



	//Jump
	wire [31:0] aluResultJump;

	//Lui
	wire [31:0] mux_out_lui;


	//Unicos
	wire and_unico;

	integer i;
	initial begin
		for( i = 0; i < 1024; i = i + 1 ) begin
			data_memory[ i ] = 0;
		end
		for(i = 0;i < 32;i = i + 1) begin
			 reg_file[i] = 0;
		end
	end



	//Join para el jump
	JoinShiftJump JoinShiftJump(pc[31:28], instruction[25:0], target_pc_im);

	//Mux antes del mux Jump
	Mux MuxPCAdder(pc, shift_2, aluResultJump, Branch);

	// Adder shift 2 y PC
	Add AddPCAndImmediate(pc, shift_2, shift_2);

	//Shift left sumar al PC una direccion
	ShiftLeft2 ShiftLeftAdder(extend_32, shift_2);

	//Mux para ver si se ejecuta jump o no y JR
	//Mux_3 MuxJumpJR(aluResultJump, target_pc_im, readData1, target_pc_im, Jump);
	
	//Mux de MemtoReg
	Mux_3 MuxMemtoReg(ALUResult, readDataMemory, pc, mux_mem_to_reg, MemoryToRegister);

	//LUIControl
	Mux muxLUI({16'h0000,op_15_0}, mux_mem_to_reg, mux_out_lui, LUIctrl);

	//Mux 5 para las instrucciones de write register y Jal
	Mux_3_5 MuxRegDst(op_20_16, op_15_11, 5'd31, mux_5_result, RegistroDestino);

	//Mux que lee del  register  y el sign extende y va al ALU
	Mux MuxALU(readData2, extend_32, mux_32_result, ALUSrc);

	//And de Branch (Control) y el resultado de la ALU para jump
	AND AndControl(Branch, branch_res, and_unico);


	//Extiende el signo de 16 a 32bits
	SignExtend SignExtend(op_15_0, extend_32);

	//Modulo encargado de recoger la instruccion
	InstructionMemory InstructionMemory(clk, rst, pc, instruction);

	//Operaciones aritmeticas
	ALU ALU(clk, rst, readData1, mux_32_result, branch_res, ALUResult, ALUControl);

	//Encrgado de los registros, leer y escribir
	Register Register(clk, rst, instruction[25:21], instruction[20:16], mux_5_result,readData1, readData2, mux_out_lui, RegisterWrite);

	//Control con flags para otros modulos
	CONTROL Control(clk, rst, instruction, ALUOpcode, ALUSrc, MemoryWrite,
									RegisterWrite, RegistroDestino, MemoryToRegister, MemoryRead,
									Branch, Jump, Jal, LUIctrl);

	//Control con flags para el ALU
	ALUControl ALUcontrol(clk, rst, ALUOpcode, ALUControl, op_5_0);


	//Encargado de manejar la memoria
	DataMemory DataMemory(clk, rst, ALUResult, readData2, MemoryRead, MemoryWrite,
												readDataMemory);

	//Clock modulo
	Clock Clock(clk);

	//Encargado de hacer los cambios al PC
	PC PCModule(clk, pc, target_pc_im, Jump, Branch);

	initial begin

	$dumpfile("DataPath.vcd");
	$dumpvars(0, DataPath);
	$display("DataPath Test");

	end

	always@(instruction) begin
		op_31_26 = instruction[31:26];
		op_25_21 = instruction[25:21];
		op_20_16 = instruction[20:16];
		op_15_11 = instruction[15:11];
		op_15_0 = instruction[15:0];
		op_25_0 = instruction[25:0];
		op_5_0 = instruction[5:0];
	end
endmodule
