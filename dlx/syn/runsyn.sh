#----------------------------------------------------------------------------------------------------
# Description:	This bash script is designed to manage the synthesis process for the DLX project.
#
# Author:	Riccardo Cuccu
# Date:		2023/09/14
#----------------------------------------------------------------------------------------------------

#!/bin/bash

# Initialize default values for variables
path="scripts/"
background=n
file_name="all"
file_list=()

# Populate file_list with .tcl files that match the regular expression
for file in $path*.tcl; do
	if [[ $file =~ syn_([0-9]+_.+)\.tcl ]]; then
		file_list+=("$file")
	fi
done

# Parse command-line options for test filename and background execution
while getopts b:f: flag
do
	case "${flag}" in
		b) background=${OPTARG};;	# Set whether to run in the background
		f) file_name=${OPTARG};;	# Set the test filename
	esac
done

# Initialize environment
source /eda/scripts/init_design_vision &> /dev/null #setsynopsys

# Cleanup and create new working directories
rm -r -f work designs reports
mkdir -p work designs reports

# Check whether a specific filename was provided or run all by default
if [ $file_name != "all" ]; then
	file_list=($path$file_name)
fi

# Execute the synthesis based on the background option and filename
for file in "${file_list[@]}"
do
	if [ $background == "y" ]; then

		# Execute the simulation in the background
		dc_shell-xg-t -f $file > /dev/null

	elif [ $background == "n" ]; then

		# Execute the simulation in the foreground
		dc_shell-xg-t -f $file

	fi
done

#dc_shell-xg-t -f syn.tcl
#dc_shell-xg-t -help
