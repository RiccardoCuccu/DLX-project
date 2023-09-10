#----------------------------------------------------------------------------------------------------
# Description:	This bash script is designed to manage the synthesis process for the DLX project.
#
# Author:	Riccardo Cuccu
# Date:		2023/09/10
#----------------------------------------------------------------------------------------------------

#!/bin/bash

# Initialize default values for variables
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
source /eda/scripts/init_design_vision &> /dev/null #setsynopsys

# Cleanup and create a new working directories
rm -r -f work designs reports
mkdir -p work designs reports

# Execute the synthesis based on the background option
if [ $background == "y" ]
then

	# Execute the simulation in the background
	dc_shell-xg-t -f syn.tcl > /dev/null

elif [ $background == "n" ]
then

	# Execute the simulation in the foreground
	dc_shell-xg-t -f syn.tcl

fi

#dc_shell-xg-t -f syn.tcl
#dc_shell-xg-t -help
