#!/bin/bash

#----------------------------------------------------------------------------------------------------
# Description:	This bash script manages the simulation process for the DLX project. It allows
#		users to select the test file for simulation and choose whether to run the
#		simulation in the background.
#
# Author:	Riccardo Cuccu
# Date:		2023/09/19
#----------------------------------------------------------------------------------------------------

# Initialize default values for variables
filename=test.asm
background=y

# Parse command-line options for test filename and background execution
while getopts b:f: flag
do
	case "${flag}" in
		b) background=${OPTARG};;	# Set whether to run in the background
		f) filename=${OPTARG};;		# Set the test filename
	esac
done

# Initialize environment
source /eda/scripts/init_questa_core_prime &> /dev/null #setmentor

# Create a new working directory
vlib work

# Run assembler script for the chosen test file
source ./assembler.sh asm_example/$filename > /dev/null

#./assembler.bin/dlxasm.pl asm_example/$filename
#./assembler.bin/conv2memory asm_example/{$filename}.exe > {$filename}.txt

sleep 1

# Execute the simulation based on the background option; within the "QuestaSim" program
# it is possible to re-run the simulation simply using the "do resim.tcl" command
if [ $background == "y" ]
then

	# Execute the simulation in the background
	vsim -do sim.tcl &

elif [ $background == "n" ]
then

	# Execute the simulation in the foreground
	vsim -do sim.tcl

fi


# Wait for the last background job to finish (if any)
wait $!

# Cleanup
rm -r -f work
rm firmware.asm.mem
rm transcript
