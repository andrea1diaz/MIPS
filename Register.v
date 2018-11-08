module Register(clk, rst, regRead_1, regRead_2, regWrite, regMemWrite, writeBack, dataRead_1, dataRead_2);

reg clk, rst, regWrite;
reg [4:0] regRead_2, regRead_1, regMemWrite;
reg [31:0] dataRead_1, dataRead_2, writeBack;
reg [31:0] reg_file [31:0];

integer i;
initial begin

for( i = 0; i < 32; i = i + 1 )
    register_file[ i ] = 32'h00000001;

always@(posedge clk, rst, writeBack, regMemWrite, regWrite)
begin
	if(rst)
		integer i;
		for(i = 0;i < 32;i = i +1)
			reg_file[i] = 32'h00000000;
	if(regWrite)
		reg_file[regMemWrite] = writeBack;
end

always@(posedge clk, regWrite)
begin
	if(!regWrite)
		dataRead_1 = reg_file[regRead_1];
		dataRead_2 = reg_file[regRead_2]; 
end
endmodule


