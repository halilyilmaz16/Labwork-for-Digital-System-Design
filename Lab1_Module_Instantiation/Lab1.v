module Lab1(Clock, Reset, Select, Output);
	input Clock;
	input Reset;
	input Select;
	output Output;
	wire [2:0] Wire;
	

	
	Counter Module1(.Clock(Clock), .Reset(Reset), .Output(Wire));
	AND_XOR Module2(.Input1(Wire[0]), .Input2(Wire[2]), .Select(Select), .Output(Output));

endmodule 