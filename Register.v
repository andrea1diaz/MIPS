module Register(clk, rst, reg_file, readRegister1, readRegister2, writeRegister,
					 readData1, readData2,
					 RegisterWrite, MemoryToRegister, MemoryWrite, Branch, ALUSrc);
wire clk, rst;
wire RegisterWrite, MemoryToRegister, MemoryWrite, Branch, ALUSrc;
reg [4:0] readRegister1, readRegister2, writeRegister;
reg [31:0] readData1, readData2;
reg [31:0] reg_file [31:0];

always@(posedge clk)
begin
	if(rst)
		integer i;
		for(i = 0;i < 32;i = i +1) begin
			reg_file[i] = 32'h00000000;
		end
	if(regWrite)
		reg_file[writeRegister] = writeBack;
end

always@(posedge clk, RegisterWrite)
begin
	if(!RegisterWrite) begin
		readData1 = reg_file[readRegister1];
		readData2 = reg_file[readRegister2];
	end
end
endmodule