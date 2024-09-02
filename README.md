# DLX-project

## Introduction

This project involves the engineering and deployment of an enhanced DLX-based processor, originally conceptualized by D. Patterson and J. Hennessy. Compared to the DLX-basic version, this enhanced version incorporates several advancements:

- **Extended Instruction Set**: inclusion of an additional 25 instructions, namely: `addu`, `addui`, `subu`, `subui`, `mult`, `multu`, `sra`, `srai`, `seq`, `seqi`, `slt`, `sltu`, `slti`, `sltui`, `sgt`, `sgtu`, `sgti`, `sgtui`, `sle`, `sleu`, `slei`, `sleui`, `jr`, `jalr`, and `lhi`, bringing the total count to 52.
- **Optimized ALU**: the arithmetic logic unit (ALU) has been optimized and enhanced with a Pentium 4 Adder and a Booth Multiplier Radix-4.
- **Forwarding Unit**: a forwarding Unit has been implemented to manage data hazards, specifically those related to Read-After-Write (RAW).
- **Parametric Design**: the entire project is designed to be parametric. All dimensions and design parameters can be managed through a single file, `000-globals.vhd`.
- **Semi-Automated Workflow**: scripts were used to partially automate various stages of the project, including simulation, synthesis, and place-and-route.

In addition to the advancements outlined above, various minor optimizations have been incorporated into the code for improved performance. Special attention has also been given to code readability. Great care has been taken to provide comprehensive comments throughout the code files and the scripts, making it as understandable and maintainable as possible.

## Architecture
The DLX processor serves as a **32-bit RISC architecture** that closely resembles the MIPS model. It operates on a **5-stage in-order pipeline** for integer processing, comprising stages for fetch, decode, execute, memory, and write back. Memory interactions occur via specific **load** and **store** commands, and they function in **big-endian mode**.

Initially, in the **fetch stage**, an instruction is retrieved from the _Instruction Memory_. After a single clock cycle, the instruction moves to the **decode stage**, where the addresses of the involved registers are identified and sent to the _Register File_, which subsequently reads and outputs the corresponding values. Simultaneously, if an immediate value is present, it is extracted and sign-extended for use in later stages. During the **execution stage**, the _Arithmetic Logic Unit (ALU)_ receives the appropriate input values, which may either come directly from the previous stage or be forwarded from one of the two subsequent stages, courtesy of the _Forwarding Unit_. Concurrently, a specialized module evaluates whether the first of the two register values is zero, which is particularly relevant for branch operations. In the **memory stage**, the _DRAM_ is accessed as needed, and jump conditions are assessed. Finally, during the **write back stage**, output values are channeled through designated _multiplexers_.

The details of each of these stages, along with the methodologies used to mitigate hazards and ensure reliable operation of the processor, can be found in the file [report/main.pdf](report/main.pdf).

## Simulation

Thanks to the initial files provided for this project, it has been possible to automate the loading of instruction code from an external assembly file. This automation is facilitated by the `assembler.sh` file, which serves as an interface for the actual Perl language assembler, `dlxasm.pl`.

The `dlxasm.pl` file was modified solely to enable the execution of the `MULT` and `MULTU` instructions by changing the OPCODE to R-type. Meanwhile, the `assembler.sh` file was slightly modified to better manage the generation of test files and maintain as clean a working directory as possible.

Furthermore, nineteen assembly files have been either created or modified, building upon the files initially provided.

### Using the `runsim.sh` script

The `runsim.sh` script is designed to manage the simulation process for the DLX project using the QuestaSim software. This script allows users to specify the test file to be used for the simulation and to choose whether to run the simulation in the background. Two specific flags can be employed for these purposes:

- `-b`: allows the user to choose whether to run the simulation in the background (`y` for yes, `n` for no). The default setting is to run in the background.
- `-f`: specifies the test filename. By default, the filename is `test.asm`.

To execute the script, navigate to the `dlx/sim` directory, which contains `runsim.sh`, and run the following command:

```bash
./runsim.sh
```

As mentioned earlier, running the simulation with default settings will use the default file (`test.asm`) and execute in the background. To run a custom test file (`mytest.asm`) in the background, use the following command:

```bash
./runsim.sh -f mytest.asm
```

To run a custom test file (`mytest.asm`) in the foreground, use the following command:

```bash
./runsim.sh -f mytest.asm -b n
```

To run the script again within the QuestaSim program, you must instead launch the `resim.sh` script using the following command:

```bash
do resim.tcl
```

Both of these files set up the optimal environment for running the simulation and then execute the `sim.tcl` file, which serves as the core of the simulation. This file contains the commands for compiling the VHDL files and managing the waveforms of the entire system's signals. It offers a rudimentary control panel at the beginning of the file, which allows the user to select the unit to execute (choices include DLX, Control Unit, Datapath, IRAM, DRAM, or ALU) and/or the stage to analyze (among all, fetch, decode, execute, memory, and write back).

Thanks to this type of display selection, a single testbench file could be used, enabling quicker identification of any bugs and delays. Furthermore, the more complex modules, such as the P4 Adder, Booth Multiplier, and Control Unit, had already been tested with specialized testbenches during the course, although they were slightly modified for this project.


## Synthesis

### Using the `runsyn.sh` script

The synthesis procedure for the DLX architecture was carried out using the Synopsys Design Compiler. The UMC 45nm technology library was employed for this purpose.

For the simulation phase, the bash script `runsyn.sh` was developed to initiate and streamline the synthesis process. This script also accommodates the same two optional flags as seen for simulation:

- `-b`: allows execution in the background when paired with the `y` label. Alternatively, using the `n` label initiates foreground execution, which is also the default behavior in this case.
- `-f`: enables the synthesis of a specific target file. In the absence of a specified file, the default action is to execute all types of synthesis files within the current subdirectory.

To execute the script, navigate to the `dlx/syn` directory that contains `runsyn.sh`. Then, run the following command:

```bash
./runsyn.sh
```
