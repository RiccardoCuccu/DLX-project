###################################################################

# Created by write_sdc on Tue Sep 19 16:52:07 2023

###################################################################
set sdc_version 2.1

set_units -time ns -resistance MOhm -capacitance fF -voltage V -current mA
set_wire_load_model -name 5K_hvratio_1_4 -library NangateOpenCellLibrary
create_clock [get_ports CLK]  -name CK  -period 0.5  -waveform {0 0.25}
set_clock_uncertainty 0.07  [get_clocks CK]
