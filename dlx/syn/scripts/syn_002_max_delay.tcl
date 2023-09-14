#----------------------------------------------------------------------------------------------------
# Description:	DLX synthesis with constrained maximum delay.
#
# Author:	Riccardo Cuccu
# Date:		2023/09/14
#----------------------------------------------------------------------------------------------------

# Control Panel
set period 0.5
set uncertainty 0.07

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

# Set Clock
create_clock -name "CK" -period $period {"CLK"}

# Do not optimize clock network
set_dont_touch_network CK

# Set clock uncertainty (for jittering)
set_clock_uncertainty $uncertainty [get_clocks CK]

# Set Constraints
set_max_delay $period -from [all_inputs] -to [all_outputs]

# Compile Design
compile -map_effort high

# Reports
report_area > reports/dlx_area_${label}_${period}.txt
report_timing > reports/dlx_timing_${label}_${period}.txt
report_power > reports/dlx_power_${label}_${period}.txt

# Save Design
#write -hierarchy -format ddc -output designs/dlx_${label}_${period}.ddc

# Generate VHDL and Verilog
#write -hierarchy -format vhdl -output designs/dlx_${label}_${period}.vhd
#write -hierarchy -format verilog -output designs/dlx_${label}_${period}.v

quit
