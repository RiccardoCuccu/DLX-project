#----------------------------------------------------------------------------------------------------
# Description:	This TCL script is part of the DLX project and is designed to analyze VHDL modules 
#		that are part of the current design. It reads a list of VHDL files to be analyzed
#		from a file named "file_list.lst". The script then iterates through this list,
#		skipping any lines that are either empty or start with a "#" character, and performs 
#		VHDL analysis on each file.
#
# Author:	Riccardo Cuccu
# Date:		2023/09/14
#----------------------------------------------------------------------------------------------------

# Suppress warning messages
suppress_message ELAB-130
suppress_message ELAB-311

# Open file_list.lst
set file_id [open "file_list.lst" r]

# Initialize an empty list to hold the filenames
set file_list {}

# Read the file line-by-line
while {[gets $file_id line] >= 0} {

	# Remove whitespace from the line
	set line [string trim $line]

	# Skip empty lines
	if {[string length $line] == 0} {
		continue
	}

	# Skip lines that start with '#'
	if {[string index $line 0] == "#"} {
		continue
	}

	# Add the line to the list
	lappend file_list $line
}

# Close the file
close $file_id

# Perform VHDL analysis on each file
foreach VHD_file $file_list {
	analyze -library WORK -format vhdl $VHD_file
}

# Preserve RTL names in the netlist
set power_preserve_rtl_hier_names true
