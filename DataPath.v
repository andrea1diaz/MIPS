include "ADD.v";
include "AND.v";
include "ALU.v";
include "ALUControl.v";
include "CONTROL.v";
include "InstructionMemory.v";
include "JoinShiftJump.v";
include "DataMemory.v";
include "Mux.v";
include "Register.v";
include "ShiftLeft2.v";
include "ShiftLeft2_25.v";
include "SignExtend.v";

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

	reg [31:0] add_pc;
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
	reg [7:0] instruct_memory [255:0];
	wire [31:0] instruction;

	//Variable DataMemory
	reg [7:0] data_memory [255:0];
	wire [31:0] readDataMemory;


	//Unicos
	wire and_unico;

	JoinShiftJump join_shift_jump(shift_out, instruction[31:28], shift_join);	
	ShiftLeft2 shift_jump(op_25_0, shift_out);
	ShiftLeft2 shift_left(extend_32, shift_2);

	Mux mux_32_jump(shift_join, pc_result_jump, instruction, Jump);
	
	Mux_5 mux_5(op_20_16, op_15_11, mux_5_result, RegistroDestino);

	Mux mux_32(readData2, extend_32, mux_32_result, mux_32_select);

	AND and_u(Branch, branch_res, and_unico);

	Mux mux_32_pc(pc_result_shift, pc_result_4, pc_result_jump, and_u_unico);

	SignExtend sign_extend(clk, op_15_0, extend_32);

	ADD add_pc_4(instruction, add_pc, pc_result_4);

	ADD add_pc_shift(pc_result_4, shift_2, pc_result_shift);

	InstructionMemory inst_mem(clk, rst, pc, instruction);

	ALU alu(ck, rst, readData1, mux_32_result, branch_res, ALUResult, ALUControl);

	Register register(clk, rst, readRegister1, readRegister2, mux_5_result,
					 readData1, readData2, readDataMemory,
					 RegisterWrite, MemoryToRegister, MemoryWrite, Branch, ALUSrc); 

	CONTROL control(clk, rst, instruction, ALUOpcode, ALUSrc, MemoryWrite, RegisterWrite,
					 RegistroDestino, MemoryToRegister, MemoryRead, Branch, Jump);

	ALUControl alu_control(clk, rst, ALUOpcode, ALUControl, op_5_0);


	DataMemory data_mem(clk, rst, ALUResult, readData2, MemoryRead, MemoryWrite, readDataMemory);

	integer i;
	initial begin
		for( i = 0; i < 32; i = i + 1 ) begin
    			reg_file[ i ] = 32'h00000000;
    			data_memory[i] = 32'h00000000;
    		end
	end

	initial begin
		$readmemh("instruct_mem.txt", instruct_memory);
		clk = 0; //TODO agregar cambios al clock
		add_pc = 32'h00000004;
		pc = 32'h00000000;
	end

	always@(pc)
	begin
		op_31_26 = instruction[31:26];
		op_25_21 = instruction[25:21]; 
		op_20_16 = instruction[20:16];
		op_15_11 = instruction[15:11];
		op_15_0 = instruction[15:0];
		op_25_0 = instruction[25_0];
		op_5_0 = instruction[5_0];
	end
endmodule