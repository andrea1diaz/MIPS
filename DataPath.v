module DataPath;
	reg clk, rst;
	reg [7:0] pc;

	//Variables generales
	wire [4:0] op_31_26;
	wire [4:0] op_25_21;
	wire [4:0] op_20_16;
	wire [4:0] op_15_11;
	wire [15:0] op_15_0;
	wire [5:0] op_5_0;
	wire [25:0] op_25_0;

	wire [31:0] add_pc;
	wire [31:0] pc_result_4;
	wire [31:0] pc_result_shift;
	wire [31:9] pc_result_jump;

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
	wire [0:0] MemoryWrite
	wire [1:0] ALUOpcode;
	wire ALUSrc
	wire RegisterWrite;

	//Variables ALU
	wire [31:0] A, B;
	wire [3:0] ALUControl;
	wire [31:0] ALUResult;
	wire branch_res;

	//Variables Mux_5
	wire mux_5_select;

	//Variables Mux 32
	wire [31:0] mux_32_1;
	wire [31:0] mux_32_result;
	wire mux_32_select;

	//Variables SignExtend 16->32
	wire [31:0] extend_32;

	//Variable InstructionMemory
	reg [7:0] intruct_memory [255:0];
	reg [31:0] instruction;

	//Variable DataMemory
	reg [7:0] data_memory [255:0];
	wire [31:0] readDataMemory;


	//Unicos
	wire and_unico;

	join_shift_jump JoinShiftJump(shift_out, instruction[31:28], shift_join);	
	shift_jump ShiftLeft2Jump(op_25_0, shift_out);
	shift_left ShiftLeft2(extend_32, shift_2);

	mux_32_jump Mux(shift_join, pc_result_jump, Jump, pc);
	
	mux_5 Mux_5(op_20_16, op_15_11, mux_5_result, RegistroDestino);

	mux_32 Mux(readData2, extend_32, mux_32_result, mux_32_select);

	and_u AND(Branch, branch_res, and_unico);

	mux_32_pc Mux(pc_result_shift, add_pc_4, and_u, pc_result_jump);

	sign_extend SignExtend(clk, op_15_0, extend_32);

	add_pc_4 ADD(pc, add_pc, pc_result_4);

	add_pc_shift ADD(pc_result_4, shift_2, pc_result_shift);

	inst_mem InstructionMemory(clk, rst, instruct_memory, pc, instruction);



	alu ALU(ck, rst, readData1, mux_32_result, branch_res, ALUResult, ALUControl);

	register Register(clk, rst, reg_file, readRegister1, readRegister2, mux_5_result,
					 readData1, readData2,
					 RegisterWrite, MemoryToRegister, MemoryWrite, Branch, ALUSrc); 

	control CONTROL(clk, rst, instruction, ALUOpcode, ALUSrc, MemoryWrite, RegisterWrite,
					 RegistroDestino, MemoryToRegister, MemoryRead, Branch, Jump);

	alu_control ALUControl(clk, rst, ALUOpcode, ALUControl, op_5_0);


	data_mem DataMemory(clk, rst, data_memory, ALUResult, readData2, MemoryRead, MemoryWrite, readDataMemory);

	initial begin
		integer i;
			for( i = 0; i < 32; i = i + 1 ) begin
    			register_file[ i ] = 32'h00000000;
    			data_memory[i] = 32'h00000000;
    		end
	end

	initial begin
		$readmemh("instruct_mem.txt", ); //TODO
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