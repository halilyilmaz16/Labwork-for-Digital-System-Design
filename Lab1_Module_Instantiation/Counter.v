module Counter(Output,Clock,Reset);
	input Reset;
	input Clock;
	output [2:0] Output;
	reg [2:0] Data;

	always@ ( posedge Clock or negedge Reset)
		begin
			if(Reset == 1'b0) 
				Data[2:0] <= 3'b000; 
			else 
				Data[2:0] <= Data[2:0] + 3'b001; 
		end

	assign Output[2:0] = Data[2:0]; 

endmodule 