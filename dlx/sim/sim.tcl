# Constants & functions (000)
vcom -quiet ../src/000-functions.vhd
vcom -quiet ../src/000-globals.vhd

## Control Unit (a.a)
vcom -quiet ../src/a.a-cu.vhd \
-suppress 1937;				# ** Warning: (vcom-1937) Choice in CASE statement alternative must be locally static.

## Datapath (a.b)
vcom -quiet ../src/a.b-datapath.vhd
vcom -quiet ../src/a.b.a-registerfile.vhd
vcom -quiet ../src/a.b.b-mux41.vhd
#vcom -quiet ../src/a.b.c-forwardingunit.vhd

### ALU (a.b.d)
vcom -quiet ../src/a.b.d-alu.vhd


#### P4Adder (a.b.d.a)
vcom -quiet ../src/a.b.d-alu/a.b.d.a-p4adder.vhd

##### Carry Generator (a.b.d.a.a)
vcom -quiet ../src/a.b.d-alu/a.b.d.a-p4adder/a.b.d.a.a.d-pg_block.vhd
vcom -quiet ../src/a.b.d-alu/a.b.d.a-p4adder/a.b.d.a.a.c-propagate.vhd
vcom -quiet ../src/a.b.d-alu/a.b.d.a-p4adder/a.b.d.a.a.b-generate.vhd
vcom -quiet ../src/a.b.d-alu/a.b.d.a-p4adder/a.b.d.a.a.a-pg_row.vhd
vcom -quiet ../src/a.b.d-alu/a.b.d.a-p4adder/a.b.d.a.a-carry_generator.vhd

##### Sum Generator (a.b.d.a.b)
vcom -quiet ../src/a.b.d-alu/a.b.d.a-p4adder/a.b.d.a.b.a.b-mux21.vhd
vcom -quiet ../src/a.b.d-alu/a.b.d.a-p4adder/a.b.d.a.b.a.a.a-fa.vhd
vcom -quiet ../src/a.b.d-alu/a.b.d.a-p4adder/a.b.d.a.b.a.a-rca.vhd
vcom -quiet ../src/a.b.d-alu/a.b.d.a-p4adder/a.b.d.a.b.a-carry_select_block.vhd
vcom -quiet ../src/a.b.d-alu/a.b.d.a-p4adder/a.b.d.a.b-sum_generator.vhd

#### Booth Multiplier (a.b.d.b)
#vcom -quiet ../src/a.b.d-alu/a.b.d.b-boothmultiplier.vhd

#### Comparator (a.b.d.c)
vcom -quiet ../src/a.b.d-alu/a.b.d.c-comparator.vhd

#### Logic (a.b.d.d)
vcom -quiet ../src/a.b.d-alu/a.b.d.d-logic.vhd

#### Floating Point Adder (a.b.d.e)
#vcom -quiet ../src/a.b.d-alu/a.b.d.e-floatingpointadder.vhd

#### Floating Point Multiplier (a.b.d.f)
#vcom -quiet ../src/a.b.d-alu/a.b.d.f-floatingpointmultiplier.vhd

## Memory (a.c)
vcom -quiet ../src/a.c-iram.vhd

# DLX (a)
vcom -quiet ../src/a-dlx.vhd

# Testbench
vcom -quiet ../src/test_bench/tb-dlx.vhd

# Simulation
vsim -quiet -t 10ps work.CFG_TB -voptargs=+acc

#view -undock wave
add wave -divider {TB_DLX} /*

#add wave -divider {DLX} -position insertpoint \
#sim:/tb_dlx/U1/IR \
#sim:/tb_dlx/U1/PC \
#sim:/tb_dlx/U1/IRam_DOut
#sim:/tb_dlx/U1/PC_BUS

add wave -divider {CU - INPUTS} -position insertpoint -radix hex \
sim:/tb_dlx/U1/CU_I/IR_opcode \
sim:/tb_dlx/U1/CU_I/IR_func

add wave -position insertpoint  \
sim:/tb_dlx/U1/CU_I/IR_opcode_LABEL \
sim:/tb_dlx/U1/CU_I/IR_func_LABEL

# HARDWIRED CU
#add wave -divider {CU - ALU} -position insertpoint \
#sim:/tb_dlx/U1/CU_I/aluOpcode_i \
#sim:/tb_dlx/U1/CU_I/aluOpcode1 \
#sim:/tb_dlx/U1/CU_I/aluOpcode2 \
#sim:/tb_dlx/U1/CU_I/aluOpcode3 \
#sim:/tb_dlx/U1/CU_I/ALU_OPCODE

#add wave -divider {CU - CONTROL WORDS} -position insertpoint -radix hex \
#sim:/tb_dlx/U1/CU_I/cw1 \
#sim:/tb_dlx/U1/CU_I/cw2 \
#sim:/tb_dlx/U1/CU_I/cw3 \
#sim:/tb_dlx/U1/CU_I/cw4 \
#sim:/tb_dlx/U1/CU_I/cw5

add wave -divider {CU - OUTPUTS} -position insertpoint \
sim:/tb_dlx/U1/CU_I/IR_LATCH_EN \
sim:/tb_dlx/U1/CU_I/NPC_LATCH_EN
#sim:/tb_dlx/U1/CU_I/RegA_LATCH_EN 
#sim:/tb_dlx/U1/CU_I/RegB_LATCH_EN \
#sim:/tb_dlx/U1/CU_I/RegIMM_LATCH_EN \
#sim:/tb_dlx/U1/CU_I/MUXA_SEL \
#sim:/tb_dlx/U1/CU_I/MUXB_SEL \
#sim:/tb_dlx/U1/CU_I/ALU_OUTREG_EN \
#sim:/tb_dlx/U1/CU_I/EQ_COND \
#sim:/tb_dlx/U1/CU_I/DRAM_WE \
#sim:/tb_dlx/U1/CU_I/LMD_LATCH_EN \
#sim:/tb_dlx/U1/CU_I/JUMP_EN \
#sim:/tb_dlx/U1/CU_I/PC_LATCH_EN \
#sim:/tb_dlx/U1/CU_I/WB_MUX_SEL \
#sim:/tb_dlx/U1/CU_I/RF_WE

add wave -divider {DATAPATH} -position insertpoint \
sim:/tb_dlx/U1/DATAPATH_I/IR \
sim:/tb_dlx/U1/DATAPATH_I/PC \
sim:/tb_dlx/U1/DATAPATH_I/PC_BUS

add wave -divider {DATAPATH PIPE IF_ID} -position insertpoint \
sim:/tb_dlx/U1/DATAPATH_I/IF_ID_PC \
sim:/tb_dlx/U1/DATAPATH_I/IF_ID_PC_NEXT

#add wave -divider {CU} -position insertpoint sim:/tb_dlx/U1/CU_I/*
#add wave -divider {IRAM} -position insertpoint sim:/tb_dlx/U1/IRAM_I/*
#add wave -divider {DATAPATH} -position insertpoint sim:/tb_dlx/U1/DATAPATH_I/*

#add wave -divider {} -position insertpoint \
#sim:/tb_rfw/RG/REGISTERS \

run 60 ns

WaveRestoreCursors {0 ns}
#WaveRestoreZoom {0 fs} [simtime]
WaveRestoreZoom {0 ns} {30 ns}

#quit
