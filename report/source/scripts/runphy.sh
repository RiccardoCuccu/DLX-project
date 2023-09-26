#!/bin/bash

#-------------------------------------------------------------------------------------------------
# Description:	This bash script is designed to manage the physical design process for the
#		DLX project.
#
# Author:	Riccardo Cuccu
# Date:		2023/09/19
#-------------------------------------------------------------------------------------------------

# Initialize environment
source /eda/scripts/init_cadence_2020-21 &> /dev/null #setinnovus

# Cleanup and create new working directories
rm -r -f constraints designs
mkdir -p constraints designs

# Copy Verilog files
cp -r ../syn/designs/*.v ./designs
cp -r ../syn/constraints/*.sdc ./constraints

#innovus

# After launching Innovus:
# 1. Execute the "source dlx.globals" command to import the design.
# 2. Execute the "source phy.tcl" command to generate the physical design.
# 3. Execute the "source analyses.tcl" command to generate the reports.

# Cleanup
rm -f *.log *.logv *.cmd
