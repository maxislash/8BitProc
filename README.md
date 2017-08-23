# 8BitProc

Designed and implemented an 8-bit processor on a Xilinx FPGA in VHDL.

The goal was to assemble combinatory and sequential functions to realize a programmable processor with a reduced instruction set (4 instructions: NOR, ADD, STORE and JUMP). The processor uses one operator, one operand (memory address) and an accumulator to make the instruction. The architecture is Von Neumann and the control unit is a Finite State Machine with 7 states. 

The processor was tested using a highest common factor algorithm and on a Xilinx Nexys4 FPGA board.
