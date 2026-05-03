module lab3(input wire sw_out, clk, reset, enable,  output wire [3:0]dbo1, output wire [3:0]dbo2, output q1, q2);

	debouncer1 db1(.clk(clk), .sw_out(sw_out),  .reset(reset), .enable(enable), .bounce_out(q1), .q_out(dbo1));
	debouncer2 db2(.clk(clk), .sw_out(sw_out), .reset(reset), .enable(enable), .bounce_out(q2), .q_out(dbo2));
	

endmodule 

module debouncer1(input wire sw_out, clk, reset, enable, output [3:0] q_out, output reg bounce_out);

	wire c; //control cable
	
	d_ff d1(.clk(clk), .d(sw_out), .reset(reset), .enable(enable), .q(q_out[3]));
	d_ff d2(.clk(clk), .d(q_out[3]), .reset(reset), .enable(enable), .q(q_out[2]));
	d_ff d3(.clk(clk), .d(q_out[2]), .reset(reset), .enable(enable), .q(q_out[1]));
	d_ff d4(.clk(clk), .d(q_out[1]), .reset(reset), .enable(enable), .q(q_out[0]));
	
	assign c = q_out[3] & q_out[2] & q_out[1] & q_out[0];
	
	always@ (*) begin

		if (c == 1'b1)
			bounce_out <= 1'b1;
		if (q_out[0] == 1'b0)
			bounce_out <= 1'b0;
	
	end
	
endmodule 


module debouncer2(input wire sw_out, clk, reset, enable, output [3:0]q_out, output bounce_out);
	
	d_ff d1(.clk(clk), .d(sw_out), .reset(reset), .enable(enable), .q(q_out[3]));
	d_ff d2(.clk(clk), .d(q_out[3]), .reset(reset), .enable(enable), .q(q_out[2]));
	d_ff d3(.clk(clk), .d(q_out[2]), .reset(reset), .enable(enable), .q(q_out[1]));
	d_ff d4(.clk(clk), .d(q_out[1]), .reset(reset), .enable(enable), .q(q_out[0]));
	
	assign bounce_out = q_out[3] | q_out[2] | q_out[1] | q_out[0];
	
endmodule 



module d_ff(input clk, input d, input reset, input enable, output reg q);

always @(negedge clk, negedge reset)
begin
	if (reset == 1'b0)
		q <= 0;
	else
	begin
		if(enable == 1)
			q <= d;
		else
			q <= q;
	end
	
end

endmodule 