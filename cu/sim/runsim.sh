#!/bin/bash

source /eda/scripts/init_questa_core_prime &> /dev/null #setmentor

rm -r -f work
vlib work

source ./assembler.sh test.asm > /dev/null
#./assembler.bin/dlxasm.pl test.asm
#./assembler.bin/conv2memory test.asm.exe > test.txt

#vsim -do sim.tcl &			# within the "QuestaSim" program it is possible to re-run the simulation simply using the "do resim.tcl" command
vsim -do sim.tcl