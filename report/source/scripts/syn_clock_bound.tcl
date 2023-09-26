#-------------------------------------------------------------------------------------------------
# Description:	DLX synthesis with bounded clock.
#
# Author:	Riccardo Cuccu
# Date:		2023/09/19
#-------------------------------------------------------------------------------------------------

# Control Panel
set period 0.7
set power 20
set uncertainty 0.07

# File Name Extraction
set full_name [info script]
set file_name [file tail $full_name]

# Label Generation
regexp {syn_(.+)\.tcl} $file_name -> label

# Analyze Components
source "./analyze.tcl" > /dev/null

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
#set_max_dynamic_power $power uW

# Compile Design
#compile
#compile -map_effort high
compile_ultra -timing_high_effort_script

# Reports
report_area > reports/dlx_area_${label}_${period}.txt
report_timing > reports/dlx_timing_${label}_${period}.txt
report_power > reports/dlx_power_${label}_${period}.txt

# Save Design
write -hierarchy -format ddc -output designs/dlx_${label}_${period}.ddc

# Generate VHDL and Verilog
write -hierarchy -format vhdl -output designs/dlx_${label}_${period}.vhd
write -hierarchy -format verilog -output designs/dlx_${label}_${period}.v

# Generate SDC script
write_sdc constraints/dlx_${label}_${period}.sdc

quit
