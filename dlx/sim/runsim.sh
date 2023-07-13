#!/bin/bash

filename=test.asm
background=y

while getopts b:f: flag
do
	case "${flag}" in
		b) background=${OPTARG};;
		f) filename=${OPTARG};;
	esac
done

source /eda/scripts/init_questa_core_prime &> /dev/null #setmentor

rm -r -f work
vlib work

source ./assembler.sh asm_example/$filename > /dev/null

source ./assembler.sh asm_example/test.asm > /dev/null
#./assembler.bin/dlxasm.pl asm_example/test.asm
#./assembler.bin/conv2memory asm_example/test.asm.exe > test.txt

sleep 1

if [ $background == "y" ]
then
	vsim -do sim.tcl &		# within the "QuestaSim" program it is possible to re-run the simulation simply using the "do resim.tcl" command
elif [ $background == "n" ]
then
	vsim -do sim.tcl
fi

#vsim -do sim.tcl &			# within the "QuestaSim" program it is possible to re-run the simulation simply using the "do resim.tcl" command
#vsim -do sim.tcl

wait $!					# wait the last command launched in the background
rm firmware.asm.mem
rm transcript