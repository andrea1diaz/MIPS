module Add_Single(sum_amount, receiver);
input [31:0] sum_amount;
output reg[31:0] receiver;

always@(sum_amount or receiver) begin
	receiver = sum_amount + receiver;
end
endmodule
