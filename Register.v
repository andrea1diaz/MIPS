module Register(clk, rst, readRegister1, readRegister2, writeRegister,
					 readData1, readData2, writeBack, RegisterWrite);

	input wire clk, rst;
	input wire [31:0] writeBack;
	input wire RegisterWrite;
	input wire [4:0] readRegister1, readRegister2, writeRegister;
	output reg [31:0] readData1, readData2;

	reg [31:0] reg_file [31:0];

		integer i;
		initial begin
			for(i = 0;i < 32;i = i +1) begin
				reg_file[i] = 32'h00000000;
			end
		end

	always@(posedge clk)
	begin
		if(rst) begin
			for(i = 0;i < 32;i = i +1) begin
				reg_file[i] = 32'h00000000;
			end
		end
	end

	always@(clk or readRegister1) begin
			readData1 = reg_file[readRegister1];
	end

	always@(clk or readRegister2) begin
			readData2 => reg_file[readRegister2];
	end

	always @ (posedge clk or writeBack or writeRegister) begin
		if(RegisterWrite) begin
			reg_file[writeRegister] <= writeBack;
		end
	end
endmodule
