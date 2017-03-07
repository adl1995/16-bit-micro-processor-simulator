16 Bit Micro Processor Simulator
===================


Description
-

A graphical replica of the Von- Neumann architecture. This code contains the implementation for Arithmetic Logic Unit and Central Processing Unit. The basic instruction set is shown below. The RAM (random access memory) module generates addresses from starting to end in a 2 segment format. The hard drive module works reading files from current directory.

Work-flow
-
A text file is read from current directory, the data is passed onto the ALU, which decodes relevant information and passes it onto the next module. The instruction set has been modified from the original x8086 assembler.

Arithmetic logic unit
-
![alu](https://github.com/adl1995/16-bit-micro-processor-simulator/blob/master/alu.png)

Central processing unit
-
![cpu](https://github.com/adl1995/16-bit-micro-processor-simulator/blob/master/cpu.png)
Instruction set
-
![is](https://github.com/adl1995/16-bit-micro-processor-simulator/blob/master/is.png)

Final result
-
![result](https://github.com/adl1995/16-bit-micro-processor-simulator/blob/master/result.jpg)

How to run
-
This software requires [MASM611](https://sourceforge.net/projects/masm611/) or [DOSBox](http://www.dosbox.com/) to be installed on your system. For more information, please refer [here](http://totalecer.blogspot.com/2016/08/Running-first-assembly-language-program-using-8086-MASM-assembler-at-windows-7-64-bit.html)



