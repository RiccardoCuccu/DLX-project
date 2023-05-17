# Constants & functions (000)
vcom -quiet ../src/000-globals.vhd
#vcom -quiet ../src/000-functions.vhd

# Control Unit (a.a)
vcom -quiet ../src/a.a-cu.vhd \
-suppress 1937;				# ** Warning: (vcom-1937) Choice in CASE statement alternative must be locally static.

# Datapath (a.b)
vcom -quiet ../src/a.b-datapath.vhd

# Memory (a.c)
vcom -quiet ../src/a.c-iram.vhd

# DLX (a)
vcom -quiet ../src/a-dlx.vhd

# Testbench
vcom -quiet ../src/test_bench/tb-dlx.vhd

# Simulation
vsim -quiet -t 10ps work.CFG_TB -voptargs=+acc

#view -undock wave
add wave -divider {TB_DLX} /*

add wave -divider {DLX} -position insertpoint \
sim:/tb_dlx/U1/IR \
sim:/tb_dlx/U1/PC \
sim:/tb_dlx/U1/IRam_DOut \
sim:/tb_dlx/U1/PC_BUS

add wave -divider {CU - INPUTS} -position insertpoint -radix hex \
sim:/tb_dlx/U1/CU_I/IR_opcode \
sim:/tb_dlx/U1/CU_I/IR_func

# HARDWIRED CU
add wave -divider {CU - ALU} -position insertpoint \
sim:/tb_dlx/U1/CU_I/aluOpcode_i \
sim:/tb_dlx/U1/CU_I/aluOpcode1 \
sim:/tb_dlx/U1/CU_I/aluOpcode2 \
sim:/tb_dlx/U1/CU_I/aluOpcode3 \
sim:/tb_dlx/U1/CU_I/ALU_OPCODE

add wave -divider {CU - CONTROL WORDS} -position insertpoint -radix hex \
sim:/tb_dlx/U1/CU_I/cw1 \
sim:/tb_dlx/U1/CU_I/cw2 \
sim:/tb_dlx/U1/CU_I/cw3 \
sim:/tb_dlx/U1/CU_I/cw4 \
sim:/tb_dlx/U1/CU_I/cw5

add wave -divider {CU - OUTPUTS} -position insertpoint \
sim:/tb_dlx/U1/CU_I/IR_LATCH_EN \
sim:/tb_dlx/U1/CU_I/NPC_LATCH_EN \
sim:/tb_dlx/U1/CU_I/RegA_LATCH_EN \
sim:/tb_dlx/U1/CU_I/RegB_LATCH_EN \
sim:/tb_dlx/U1/CU_I/RegIMM_LATCH_EN \
sim:/tb_dlx/U1/CU_I/MUXA_SEL \
sim:/tb_dlx/U1/CU_I/MUXB_SEL \
sim:/tb_dlx/U1/CU_I/ALU_OUTREG_EN \
sim:/tb_dlx/U1/CU_I/EQ_COND \
sim:/tb_dlx/U1/CU_I/DRAM_WE \
sim:/tb_dlx/U1/CU_I/LMD_LATCH_EN \
sim:/tb_dlx/U1/CU_I/JUMP_EN \
sim:/tb_dlx/U1/CU_I/PC_LATCH_EN \
sim:/tb_dlx/U1/CU_I/WB_MUX_SEL \
sim:/tb_dlx/U1/CU_I/RF_WE

#add wave -divider {CU} -position insertpoint sim:/tb_dlx/U1/CU_I/*
#add wave -divider {IRAM} -position insertpoint sim:/tb_dlx/U1/IRAM_I/*

#add wave -divider {} -position insertpoint \
#sim:/tb_rfw/RG/REGISTERS \

run 60 ns

#quit
