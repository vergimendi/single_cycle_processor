module seven_seg(	input logic [3:0] sw,
						output logic [6:0] hex);
	always_comb
	case(sw)
		4'h0: hex <= 7'b100_0000;
		4'h1: hex <= 7'b111_1001; 
		4'h2: hex <= 7'b010_0100; 
		4'h3: hex <= 7'b011_0000; 
		4'h4: hex <= 7'b001_1001; 
		4'h5: hex <= 7'b001_0010; 
		4'h6: hex <= 7'b000_0010; 
		4'h7: hex <= 7'b111_1000; 
		4'h8: hex <= 7'b000_0000; 
		4'h9: hex <= 7'b001_1000; 
		4'hA: hex <= 7'b000_1000; 
		4'hB: hex <= 7'b000_0011; 
		4'hC: hex <= 7'b100_0110; 
		4'hD: hex <= 7'b010_0001; 
		4'hE: hex <= 7'b000_0110; 
		4'hF: hex <= 7'b000_1110; 
		default: hex <= 7'b111_1111;
	endcase
endmodule