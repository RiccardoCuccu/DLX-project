###################################################################

# Created by write_sdc on Fri Sep 15 06:05:19 2023

###################################################################
set sdc_version 2.1

set_units -time ns -resistance MOhm -capacitance fF -voltage V -current mA
set_wire_load_model -name 5K_hvratio_1_4 -library NangateOpenCellLibrary
create_clock [get_ports CLK]  -name CK  -period 0  -waveform {0 0}
