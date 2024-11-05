module top(input	logic				clk,reset,
				output logic[6:0]		hex0,hex1,hex2,hex3);
				
	logic[31:0]	pc,instr,readdata,writedata,dataadr;
	logic memwrite;
	
	// instantiate processor and memories
	mips mips(clk,reset,pc,instr,memwrite,dataadr,writedata,readdata,hex0,hex1,hex2,hex3);
	imem imem(pc[7:2],instr);
	dmem dmem(clk,memwrite,dataadr,writedata,readdata);
	
	endmodule