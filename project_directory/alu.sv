module alu(input [31:0] A, B,
				input [2:0] F,
				output logic [31:0] Y,
				output zero);
				
	always@(*)
	case (F)
		3'b000	:	Y = A & B;
		3'b001	:	Y = A | B;
		3'b100	:	Y = ~(A | B);
		3'b010	:	Y = A + B;
		3'b110	:	Y = A - B;
		3'b111	:	Y = A < B ? 32'b1 : 32'b0;
		default	:	Y = A & B;
	endcase
	// assign zero = (Y==32'h0000) ? 1 : 0;
	assign zero = (Y == 32'b0);
	endmodule
