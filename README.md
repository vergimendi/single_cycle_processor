# MIPS Single-Cycle Processor
This project implements a **Single-Cycle MIPS Processor** using **SystemVerilog**. The processor design follows the MIPS architecture and implements a simple, 32-bit processor with ALU operations, memory, and control logic.

**Team Members:**
- **Vergil Mendizabel**
- **Peter Le**
- **Seth Wanderman**

## Overview

### ALU
The ALU performs arithmetic and logical operations on two 32-bit inputs (A and B) and produces a 32-bit output Y. The operation to perform is determined by the 3-bit control signal F. It supports operations like AND, OR, NOR, addition, subtraction, and set less than.

#### Inputs:
- **A**: 32-bit operand
- **B**: 32-bit operand
- **F**: 3-bit ALU operation control signal

#### Outputs:
- **Y**: 32-bit result of the operation
- **zero**: 1-bit flag indicating if the result Y is zero

### ALU Decoder
The ALU Decoder generates the ALU control signal based on the opcode and function field of the instruction. This module decodes the ALU operation for both R-type and I-type instructions.

#### Inputs:
- **funct**: 6-bit function field from the instruction
- **aluop**: 2-bit ALU operation type from the controller

#### Outputs:
- **alucontrol**: 3-bit ALU control signal for operation selection

### Register File
The register file stores the 32 general-purpose registers. It allows for reading and writing of registers based on the instruction.

#### Inputs:
- **clk**: Clock signal
- **we3**: Write enable signal for register 3
- **ra1, ra2**: 5-bit read address for register 1 and register 2
- **wa3**: 5-bit write address for register 3
- **wd3**: 32-bit data to write into register 3

#### Outputs:
- **rd1, rd2**: 32-bit data read from register 1 and register 2

### Adder
The adder module adds two 32-bit operands.

#### Inputs:
- **a**: 32-bit operand
- **b**: 32-bit operand

#### Outputs:
- **y**: 32-bit result of the addition

### Shift Left by 2
This module shifts a 32-bit input left by 2 bits, typically used for computing branch addresses in MIPS.

#### Inputs:
- **a**: 32-bit operand

#### Outputs:
- **y**: 32-bit result after shifting left by 2 bits

### Sign Extend
The sign extension module extends a 16-bit immediate value to 32 bits, preserving the sign of the number.

#### Inputs:
- **a**: 16-bit immediate value

#### Outputs:
- **y**: 32-bit extended value

### Flip-Flop
This module is a generic resettable flip-flop that stores a value on the rising edge of the clock. It can be used to store the program counter or other signals in the processor.

#### Inputs:
- **clk**: Clock signal
- **reset**: Reset signal
- **d**: Input data to store

#### Outputs:
- **q**: Output stored value

### Multiplexer
This 2:1 multiplexer selects between two input values based on the control signal `s`.

#### Inputs:
- **d0, d1**: Two 8-bit input values
- **s**: Select signal

#### Outputs:
- **y**: Output value based on the selected input

### Controller
The controller decodes the instruction and generates control signals for various modules in the processor, including the ALU, memory, and register file. It uses the opcode and function code to generate signals for operations such as memory read/write, register writes, and ALU operations.

#### Inputs:
- **op**: 6-bit opcode of the instruction
- **funct**: 6-bit function code (for R-type instructions)
- **zero**: Zero flag from the ALU indicating if the result is zero

#### Outputs:
- **memtoreg**: Control signal for memory-to-register data forwarding
- **memwrite**: Control signal for memory write
- **pcsrc**: Control signal for branch decision
- **alusrc**: Control signal for ALU input source
- **regdst**: Control signal for selecting the destination register
- **regwrite**: Control signal for register write enable
- **jump**: Control signal for jump instruction
- **alucontrol**: ALU control signal

### Datapath
The datapath connects all the major components of the processor. It includes the program counter (PC), ALU, registers, memory, and multiplexers to handle data flow and control signal routing.

#### Inputs:
- **clk**: Clock signal
- **reset**: Reset signal
- **memtoreg, pcsrc, alusrc, regdst, regwrite, jump**: Control signals
- **alucontrol**: ALU control signal
- **instr**: Instruction input
- **readdata**: Data read from memory

#### Outputs:
- **zero**: Zero flag from the ALU
- **pc**: Program counter output
- **aluout**: ALU result
- **writedata**: Data to be written to memory or register
- **hex0, hex1, hex2, hex3**: 7-segment display outputs

### Data Memory
The data memory module simulates the read and write operations of a memory unit. It stores 64 words, each 32 bits wide.

#### Inputs:
- **clk**: Clock signal
- **we**: Write enable signal
- **a**: 32-bit address
- **wd**: 32-bit data to write

#### Outputs:
- **rd**: 32-bit data read from the memory

### Instruction Memory
The instruction memory module stores instructions fetched by the processor. It is initialized with values from a memory file during simulation.

#### Inputs:
- **a**: 6-bit address for instruction fetch

#### Outputs:
- **rd**: 32-bit instruction read from memory

### Main Decoder
The main decoder module decodes the opcode of the instruction and generates control signals for the processor's operations, such as register write, ALU operation, and memory access.

#### Inputs:
- **op**: 6-bit opcode

#### Outputs:
- **memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump**: Control signals
- **aluop**: ALU operation type signal

### MIPS Processor
This is the top-level module that instantiates the controller, datapath, instruction memory, and data memory. It connects all the components to form the complete processor.

#### Inputs:
- **clk**: Clock signal
- **reset**: Reset signal
- **instr**: Instruction fetched from memory
- **readdata**: Data read from memory

#### Outputs:
- **pc**: Program counter value
- **memwrite**: Memory write enable signal
- **aluout**: ALU output
- **writedata**: Data to be written to memory
- **hex0, hex1, hex2, hex3**: 7-segment display outputs showing results

### 7-Segment Display
This module converts a 4-bit input value into a 7-segment display encoding. It is used to display 4-bit values from the processor's result on four 7-segment displays.

#### Inputs:
- **sw**: 4-bit value to be displayed

#### Outputs:
- **hex**: 7-bit encoding for the 7-segment display

### Top-Level Module
The top module connects the processor, instruction memory, and data memory. It handles the clock and reset signals and connects the 7-segment display to show the results.

#### Inputs:
- **clk**: Clock signal
- **reset**: Reset signal

#### Outputs:
- **hex0, hex1, hex2, hex3**: 7-segment display outputs showing results

## Usage
1. Compile the design using Altera Quartus II or any compatible FPGA development environment.
2. Load the design onto the Altera Cyclone IV FPGA board.
3. Observe the results on the 7-segment displays, which will show the output of the processor's computations.

## Conclusion
This project implements a single-cycle MIPS processor capable of executing basic instructions. The system is built using SystemVerilog and designed to run on an Altera Cyclone IV FPGA board.
