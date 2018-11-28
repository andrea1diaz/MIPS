module Add (A, B, ADDout);
  output reg [31:0]ADDout;
  input [31:0]A;
  input [31:0]B;
  reg[31:0] temp;
  
  always@(A or B) begin
  	temp = A + B;
  	ADDout = temp[31:0];
  end
endmodule
