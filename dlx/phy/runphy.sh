#----------------------------------------------------------------------------------------------------
# Description:	This bash script is designed to manage the physical design process for the DLX project.
#
# Author:	Riccardo Cuccu
# Date:		2023/09/15
#----------------------------------------------------------------------------------------------------

#!/bin/bash

# Initialize environment
source /eda/scripts/init_cadence_2020-21 &> /dev/null #setinnovus

# Cleanup and create new working directories
rm -f ./scripts/*.sdc
rm -r -f designs reports
mkdir -p designs reports

# Copy Verilog files
cp -r ../syn/designs/*.v ./designs
cp -r ../syn/scripts/*.sdc ./scripts

#innovus

# After launching Innovus, select "File" > "Import Design."
# In the "Load" window, choose the dlx.globals file and click "OK."
# Then execute the source phy.tcl command to generate the physical design and save it in the current directory.
