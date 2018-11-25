`include "Add.v"
`include "AND.v"
`include "ALU.v"
`include "ALUControl.v"
`include "CONTROL.v"
`include "InstructionMemory.v"
`include "JoinShiftJump.v"
`include "DataMemory.v"
`include "Mux.v"
`include "Mux_5.v"
`include "Register.v"
`include "ShiftLeft2.v"
`include "ShiftLeft2_25.v"
`include "SignExtend.v"
`include "PC.v"

module DataPath();
	reg clk, rst;
	reg [7:0] pc;

	//Variables generales
	reg [4:0] op_31_26;
	reg [4:0] op_25_21;
	reg [4:0] op_20_16;
	reg [4:0] op_15_11;
	reg [15:0] op_15_0;
	reg [5:0] op_5_0;
	reg [25:0] op_25_0;

	wire [7:0] pc_increment;
	wire [31:0] target_pc;
	wire [31:0] pc_result_4;
	wire [31:0] pc_result_shift;
	wire [31:0] pc_result_jump;

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

	//Variables de CONTROL
	wire Jump;
	wire RegistroDestino;
	wire Branch;
	wire MemoryRead;
	wire MemoryToRegister;
	wire [0:0] MemoryWrite;
	wire [1:0] ALUOpcode;
	wire ALUSrc;
	wire RegisterWrite;

	//Variables ALU
	wire [31:0] A, B;
	wire [3:0] ALUControl;
	wire [31:0] ALUResult;
	wire branch_res;

	//Variables Mux_5
	wire [4:0] mux_5_result;
	wire mux_5_select;

	//Variables Mux 32
	wire [31:0] mux_32_1;
	wire [31:0] mux_32_result;
	wire mux_32_select;

	//Variables SignExtend 16->32
	wire [31:0] extend_32;

	//Variable InstructionMemory
	wire [31:0] instruction;

	//Variable DataMemory
	reg [7:0] data_memory [1023:0];
	wire [31:0] readDataMemory;


	//Unicos
	wire and_unico;


	//Asign inicial de wires
	assign pc_increment = 8'h04;

	//Encargado de hacer los cambios al PC
	PC(clk, pc, target_pc);

	//Union de shiftLeftJump a los 4 bits de la instruccion
	JoinShiftJump join_shift_jump(shift_out, instruction[31:28], shift_join);
	
	//Shift de 26 a 28 para usar instruct en jump
	ShiftLeft2 shiftLeftJump(op_25_0, shift_out);
	
	//Shift left sumar al PC una direccion
	ShiftLeft2 shiftLeftAdder(extend_32, shift_2);

	//Mux para ver si se ejecuta jump o no
	Mux muxJump(shift_join, pc_result_jump, target_pc, Jump);

	//Mux 5 para las instrucciones de write register
	Mux_5 muxWriteReg(op_20_16, op_15_11, mux_5_result, RegistroDeestino);

	//Mux que lee del  register  y el sign extende y va al ALU
	Mux muxALU(readData2, extend_32, mux_32_result, mux_32_select);

	//And de Branch (Control) y el resultado de la ALU para jump		
	AND andControl(Branch, branch_res, and_unico);
	
	//Mux final antes del PC counter
	Mux mux_32_pc(pc_result_shift, pc_result_4, pc_result_jump, and_u_unico);

	//Extiende el signo de 16 a 32bits
	SignExtend sign_extend(clk, op_15_0, extend_32);

	//Adder para incrementar el PC 
	Add_Single adderTargetPC(pc_increment, target_pc);

	// nose que hace
	Add add_pc_shift(pc_result_4, shift_2, pc_result_shift);

	//Modulo encargado de recoger la instruccion
	InstructionMemory inst_mem(clk, rst, pc, instruction);

	//Operaciones aritmeticas
	ALU alu(clk, rst, readData1, mux_32_result, branch_res, ALUResult, ALUControl);

	//Encrgado de los registros, leer y escribir
	Register register(clk, rst, readRegister1, readRegister2, mux_5_result,
					 readData1, readData2, readDataMemory,
					 RegisterWrite, MemoryToRegister, MemoryWrite, Branch, ALUSrc);

	//Control con flags para otros modulos
	CONTROL control(clk, rst, instruction, ALUOpcode, ALUSrc, MemoryWrite, RegisterWrite,
					 RegistroDestino, MemoryToRegister, MemoryRead, Branch, Jump);

	//Control con flags para el ALU
	ALUControl alu_control(clk, rst, ALUOpcode, ALUControl, op_5_0);


	//Encargado de manejar la memoria
	DataMemory data_mem(clk, rst, ALUResult, readData2, MemoryRead, MemoryWrite, readDataMemory);

	integer i;
	initial begin
		for( i = 0; i < 1024; i = i + 1 ) begin
			data_memory[ i ] = 8'h00;
		end
		for(i = 0;i < 32;i = i + 1) begin
			 reg_file[i] = 32'h00000000;
		end
	end

	initial begin

	$dumpfile("DataPath.vcd");
	$dumpvars(0, DataPath);
	$display("DataPath Test");

		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;
		#10
		clk = 1;
		#10
		clk = 0;

	end




	always@(*) begin
		op_31_26 <= instruction[31:26];
		op_25_21 <= instruction[25:21];
		op_20_16 <= instruction[20:16];
		op_15_11 <= instruction[15:11];
		op_15_0 <= instruction[15:0];
		op_25_0 <= instruction[25:0];
		op_5_0 <= instruction[5:0];
	end
endmodule
