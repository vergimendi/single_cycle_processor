module datapath(input 		logic 			clk, reset,
						input 	logic				memtoreg, pcsrc,
						input		logic				alusrc,regdst,
						input		logic				regwrite, jump,
						input		logic[2:0]		alucontrol,
						output	logic				zero,
						output 	logic[31:0] 	pc,
						input 	logic[31:0] 	instr,
						output 	logic[31:0]		aluout,writedata,
						input 	logic[31:0]		readdata,
						output	logic[6:0]		hex0,hex1,hex2,hex3);
						
	// Internal logic
	logic[4:0] 	writereg;
	logic[31:0]	pcnext,pcnextbr,pcplus4,pcbranch;
	logic[31:0]	signimm,signimmsh;
	logic[31:0]	srca,srcb;
	logic[31:0]	result;
	
	// display register on seven_seg
	seven_seg Hex0(result[3:0], hex0);
	seven_seg Hex1(result[7:4], hex1);
	seven_seg Hex2(result[11:8], hex2);
	seven_seg Hex3(result[15:12], hex3);
	
	// nextpc logic
	flopr #(32)	pcreg(clk,reset,pcnext,pc);
	adder			pcadd1(pc,32'b100,pcplus4);
	sl2			immsh(signimm,signimmsh);
	adder			pcadd2(pcplus4,signimmsh,pcbranch);
	mux2 #(32)	pcbrmux(pcplus4,pcbranch,pcsrc,pcnextbr);
	mux2 #(32)	pcmux(pcnextbr,{pcplus4[31:28],instr[25:0],2'b00},
							jump,pcnext);
	
	// register file logic
	regfile		rf(clk,regwrite,instr[25:21],instr[20:16],writereg,
						result,srca,writedata);
	mux2 #(5)	wrmux(instr[20:16],instr[15:11],regdst,writereg);
	mux2 #(32)	resmux(aluout,readdata,memtoreg,result);
	signext		se(instr[15:0],signimm);
	
	// ALU logic
	mux2 #(32)	srcbmux(writedata,signimm,alusrc,srcb);
	alu			alu(srca,srcb,alucontrol,aluout,zero);
	
	endmodule
