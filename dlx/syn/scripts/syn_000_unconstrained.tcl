#----------------------------------------------------------------------------------------------------
# Description:	DLX synthesis unconstrained.
#
# Author:	Riccardo Cuccu
# Date:		2023/09/14
#----------------------------------------------------------------------------------------------------

# File Name Extraction
set full_name [info script]
set file_name [file tail $full_name]

# Label Generation
regexp {syn_([0-9]+_.+)\.tcl} $file_name -> label

# Analyze Components
source "./scripts/analyze.tcl" > /dev/null

# Select Design
elaborate DLX -architecture DLX_RTL -library WORK

# Remove Unconnected Ports
remove_unconnected_ports [get_cells -hierarchical *]

# Set Wire Load
set_wire_load_model -name 5K_hvratio_1_4

# Compile Design
compile

# Reports
report_area > reports/dlx_area_${label}.txt
report_timing > reports/dlx_timing_${label}.txt
report_power > reports/dlx_power_${label}.txt

# Save Design
#write -hierarchy -format ddc -output designs/dlx_${label}.ddc

# Generate VHDL and Verilog
#write -hierarchy -format vhdl -output designs/dlx_${label}.vhd
#write -hierarchy -format verilog -output designs/dlx_${label}.v

quit
