module mips(input 	logic 			clk, reset,
				output 	logic[31:0] 	pc,
				input 	logic[31:0] 	instr,
				output 	logic				memwrite,
				output 	logic[31:0]		aluout,writedata,
				input 	logic[31:0]		readdata,
				output	logic[6:0]		hex0,hex1,hex2,hex3);
	
	// Internal logic (wiring)
	logic memtoreg, alusrc, regdst, regwrite, jump, pcsrc, zero;
	logic[2:0] alucontrol;
	
	// Controller Module
	controller c(instr[31:26], instr[5:0], zero, memtoreg, memwrite,
					pcsrc, alusrc, regdst, regwrite, jump, alucontrol);
	
	// Datapath Module
	datapath dp(clk,reset,memtoreg,pcsrc,alusrc,regdst,regwrite,
				jump,alucontrol,zero,pc,instr,aluout,writedata,readdata,hex0,hex1,hex2,hex3);
	endmodule
	