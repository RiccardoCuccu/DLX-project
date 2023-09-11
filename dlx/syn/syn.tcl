#----------------------------------------------------------------------------------------------------
# Description:	
#
# Author:	Riccardo Cuccu
# Date:		2023/09/10
#----------------------------------------------------------------------------------------------------

#----------------------------------------------------------------------------------------------------
# Control Panel
#----------------------------------------------------------------------------------------------------

set period 0.4
set power 20

#----------------------------------------------------------------------------------------------------
# Analyze Components
#----------------------------------------------------------------------------------------------------

# Constants & functions (000)
analyze -library WORK -format vhdl {../src/000-functions.vhd} > /dev/null
analyze -library WORK -format vhdl {../src/000-globals.vhd} > /dev/null

## Basic Logic Gates
analyze -library WORK -format vhdl {../src/000-globals/not.vhd} > /dev/null
analyze -library WORK -format vhdl {../src/000-globals/and.vhd} > /dev/null
analyze -library WORK -format vhdl {../src/000-globals/nand.vhd} > /dev/null
analyze -library WORK -format vhdl {../src/000-globals/or.vhd} > /dev/null
analyze -library WORK -format vhdl {../src/000-globals/nor.vhd} > /dev/null
analyze -library WORK -format vhdl {../src/000-globals/xor.vhd} > /dev/null
analyze -library WORK -format vhdl {../src/000-globals/xnor.vhd} > /dev/null

## Memory Elements
analyze -library WORK -format vhdl {../src/000-globals/ffd.vhd} > /dev/null
analyze -library WORK -format vhdl {../src/000-globals/ffdr.vhd} > /dev/null
analyze -library WORK -format vhdl {../src/000-globals/ld.vhd} > /dev/null
analyze -library WORK -format vhdl {../src/000-globals/ldr.vhd} > /dev/null

## Multiplexers
analyze -library WORK -format vhdl {../src/000-globals/mux21.vhd} > /dev/null
analyze -library WORK -format vhdl {../src/000-globals/mux21_logic.vhd} > /dev/null
analyze -library WORK -format vhdl {../src/000-globals/mux41.vhd} > /dev/null
#analyze -library WORK -format vhdl {../src/000-globals/mux41_logic.vhd} > /dev/null

# Arithmetic Components
analyze -library WORK -format vhdl {../src/000-globals/fa.vhd} > /dev/null
analyze -library WORK -format vhdl {../src/000-globals/rca.vhd} > /dev/null
analyze -library WORK -format vhdl {../src/000-globals/zerodetector.vhd} > /dev/null

# Control Unit (a.a)
analyze -library WORK -format vhdl {../src/a.a-cu.vhd} > /dev/null

## Datapath (a.b)
analyze -library WORK -format vhdl {../src/a.b-datapath.vhd} > /dev/null
analyze -library WORK -format vhdl {../src/a.b.a-registerfile.vhd} > /dev/null
analyze -library WORK -format vhdl {../src/a.b.c-forwardingunit.vhd} > /dev/null
analyze -library WORK -format vhdl {../src/a.b.i-signextend.vhd} > /dev/null
analyze -library WORK -format vhdl {../src/a.b.j-registeraddresser.vhd} > /dev/null

### ALU (a.b.d)
analyze -library WORK -format vhdl {../src/a.b.d-alu.vhd} > /dev/null
analyze -library WORK -format vhdl {../src/a.b.d-alu/a.b.d.c-comparator.vhd} > /dev/null
analyze -library WORK -format vhdl {../src/a.b.d-alu/a.b.d.d-logic.vhd} > /dev/null
analyze -library WORK -format vhdl {../src/a.b.d-alu/a.b.d.e-barrel-shifter-left.vhd} > /dev/null
analyze -library WORK -format vhdl {../src/a.b.d-alu/a.b.d.f-barrel-shifter-right.vhd} > /dev/null

#### P4Adder (a.b.d.a)
analyze -library WORK -format vhdl {../src/a.b.d-alu/a.b.d.a-p4adder.vhd} > /dev/null

##### Carry Generator (a.b.d.a.a)
analyze -library WORK -format vhdl {../src/a.b.d-alu/a.b.d.a-p4adder/a.b.d.a.a.d-pg_block.vhd} > /dev/null
analyze -library WORK -format vhdl {../src/a.b.d-alu/a.b.d.a-p4adder/a.b.d.a.a.c-propagate.vhd} > /dev/null
analyze -library WORK -format vhdl {../src/a.b.d-alu/a.b.d.a-p4adder/a.b.d.a.a.b-generate.vhd} > /dev/null
analyze -library WORK -format vhdl {../src/a.b.d-alu/a.b.d.a-p4adder/a.b.d.a.a.a-pg_row.vhd} > /dev/null
analyze -library WORK -format vhdl {../src/a.b.d-alu/a.b.d.a-p4adder/a.b.d.a.a-carry_generator.vhd} > /dev/null

##### Sum Generator (a.b.d.a.b)
analyze -library WORK -format vhdl {../src/a.b.d-alu/a.b.d.a-p4adder/a.b.d.a.b.a-carry_select_block.vhd} > /dev/null
analyze -library WORK -format vhdl {../src/a.b.d-alu/a.b.d.a-p4adder/a.b.d.a.b-sum_generator.vhd} > /dev/null

#### Booth Multiplier (a.b.d.b)
#analyze -library WORK -format vhdl {../src/a.b.d-alu/a.b.d.b-boothmultiplier.vhd} > /dev/null

#### Comparator (a.b.d.c)
#analyze -library WORK -format vhdl {../src/a.b.d-alu/a.b.d.c-comparator.vhd} > /dev/null

#### Logic (a.b.d.d)
#analyze -library WORK -format vhdl {../src/a.b.d-alu/a.b.d.d-logic.vhd} > /dev/null

#### Floating Point Adder (a.b.d.e)
#analyze -library WORK -format vhdl {../src/a.b.d-alu/a.b.d.e-floatingpointadder.vhd} > /dev/null

#### Floating Point Multiplier (a.b.d.f)
#analyze -library WORK -format vhdl {../src/a.b.d-alu/a.b.d.f-floatingpointmultiplier.vhd} > /dev/null

## IRAM (a.c)
analyze -library WORK -format vhdl {../syn/memories/a.c-iram.vhd} > /dev/null

## DRAM (a.d)
analyze -library WORK -format vhdl {../syn/memories/a.d-dram.vhd} > /dev/null

# DLX (a)
analyze -library WORK -format vhdl {../src/a-dlx.vhd} > /dev/null

#----------------------------------------------------------------------------------------------------
# DLX Unconstrained
#----------------------------------------------------------------------------------------------------

# Select Design
elaborate DLX -architecture DLX_RTL -library WORK > /dev/null

# Compile Design
compile > /dev/null

# Reports
report_area > reports/dlx_area.txt
report_timing > reports/dlx_timing.txt
report_power > reports/dlx_power.txt

#----------------------------------------------------------------------------------------------------
# DLX with Bounded Clock
#----------------------------------------------------------------------------------------------------

# Set Clock
create_clock -name "CK" -period $period {"CLK"}
#report_clock

# Compile Design
compile

# Reports
report_area > reports/dlx_area_clk${period}.txt
report_timing > reports/dlx_timing_clk${period}.txt
report_power > reports/dlx_power_clk${period}.txt

#----------------------------------------------------------------------------------------------------
# DLX with Constrained Maximum Delay
#----------------------------------------------------------------------------------------------------

# Set Constraints
set_max_delay $period -from [all_inputs] -to [all_outputs]

# Compile Design
compile -map_effort high

# Reports
report_area > reports/dlx_area_max_delay.txt
report_timing > reports/dlx_timing_max_delay.txt
report_power > reports/dlx_power_max_delay.txt

#----------------------------------------------------------------------------------------------------
# DLX with Constrained Maximum Dynamic Power
#----------------------------------------------------------------------------------------------------

# Select Design
elaborate DLX -architecture DLX_RTL -library WORK

# Set Constraints
set_max_dynamic_power $power uW

# Compile Design
compile -map_effort high 

# Reports
report_area > reports/dlx_area_max_dynamic_power.txt
report_timing > reports/dlx_timing_max_dynamic_power.txt
report_power > reports/dlx_power_max_dynamic_power.txt
report_power -cell > reports/dlx_power_max_dynamic_power_cell.txt
report_power -net > reports/dlx_power_max_dynamic_power_net.txt

#----------------------------------------------------------------------------------------------------
# Design Generation
#----------------------------------------------------------------------------------------------------

# Save Design
write -hierarchy -format ddc -output designs/dlx.ddc

# Generate VHDL and Verilog
write -hierarchy -format vhdl -output designs/dlx.vhdl
write -hierarchy -format verilog -output designs/dlx.v

quit
