module Register(clk, rst, readRegister1, readRegister2, writeRegister,
					 readData1, readData2, writeBack,
					 RegisterWrite, MemoryToRegister, MemoryWrite, Branch, ALUSrc);
input wire clk, rst;
input wire [31:0] writeBack;
input wire RegisterWrite, MemoryToRegister, MemoryWrite, Branch, ALUSrc;
input wire [4:0] readRegister1, readRegister2, writeRegister;
output reg [31:0] readData1, readData2;
reg [31:0] reg_file [31:0];

integer i;
always@(posedge clk)
begin
	if(rst) begin
		for(i = 0;i < 32;i = i +1) begin
			reg_file[i] = 32'h00000000;
		end
	end

	if(RegisterWrite) begin
		reg_file[writeRegister] <= writeBack;
	end
end

always@(posedge clk, RegisterWrite)
begin
	if(!RegisterWrite) begin
		readData1 <= reg_file[readRegister1];
		readData2 <= reg_file[readRegister2];
	end
end
endmodule
