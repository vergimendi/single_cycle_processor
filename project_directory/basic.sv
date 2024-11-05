module regfile(input	 logic			clk,
					input  logic			we3,
					input  logic[4:0]		ra1,ra2,wa3,
					input  logic[31:0]	wd3,
					output logic[31:0]	rd1,rd2);

	// Internal logic
	logic[31:0] rf[31:0];
	
	always_ff @(posedge clk)
		if(we3) rf[wa3] <= wd3;
		
	assign rd1 = (ra1 != 0) ? rf[ra1] : 0;
	assign rd2 = (ra2 != 0) ? rf[ra2] : 0;
	endmodule
	
	
// Adder module
module adder(input	logic[31:0]		a,b,
				output	logic[31:0]		y);
				
	assign y = a+b;
	endmodule

// Shift Logic Left (2) Module
module sl2(input	logic[31:0]		a,
			output	logic[31:0]		y);
			
	// shift left by 2
	assign y = {a[29:0], 2'b00};
	endmodule
	
// Sign Extend Module
module signext(input		logic[15:0]		a,
					output	logic[31:0]		y);

	assign y = {{16{a[15]}},a};
	endmodule
	
// Resettable Flip-Flop
module flopr #(parameter WIDTH=8)
					(input logic		clk, reset,
					input logic			[WIDTH-1:0] d,
					output logic		[WIDTH-1:0] q);
					
	always_ff @(posedge clk, posedge reset)
		if(reset) 	q <= 0;
		else			q <= d;
	endmodule

// 2:1 Multiplexer
module mux2 #(parameter WIDTH=8)
					(input 	logic[WIDTH-1:0]	d0,d1,
					input		logic					s,
					output	logic[WIDTH-1:0]	y);
	
	assign y = s ? d1 : d0;
	endmodule
	