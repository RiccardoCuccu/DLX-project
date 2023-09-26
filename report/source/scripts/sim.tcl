#-------------------------------------------------------------------------------------------------
# Description:	This module is responsible for setting up the simulation environment in QuestaSim
#		for the DLX microarchitecture. It compiles VHDL files related to the various 
#		components of DLX and sets up simulation waveforms based on user-specified 
#		configurations for better debugging. Users can select between different waveform
#		settings and focus on specific pipeline stages for detailed observations.
#
# Author:	Riccardo Cuccu
# Date:		2023/09/19
#-------------------------------------------------------------------------------------------------

#-------------------------------------------------------------------------------------------------
# Control Panel
#-------------------------------------------------------------------------------------------------

# User-configurable settings for simulation

# 0 = DLX; 1 = CONTROL UNIT; 2 = DATAPATH; 3 = IRAM ; 4 = DRAM; 5 = ALU
quietly set dlx_unit 0

# 0 = All; 1 = Fetch; 2 = Decode; 3 = Execute; 4 = Memory; 5 = Write Back
quietly set pipe_stage 0

#-------------------------------------------------------------------------------------------------
# Compile VHDL files
#-------------------------------------------------------------------------------------------------

# Constants & functions (000)
vcom -quiet ../src/000-functions.vhd
vcom -quiet ../src/000-globals.vhd

## Basic Logic Gates
vcom -quiet ../src/000-globals/not.vhd
vcom -quiet ../src/000-globals/and.vhd
vcom -quiet ../src/000-globals/nand.vhd
vcom -quiet ../src/000-globals/or.vhd
vcom -quiet ../src/000-globals/nor.vhd
vcom -quiet ../src/000-globals/xor.vhd
vcom -quiet ../src/000-globals/xnor.vhd

## Memory Elements
vcom -quiet ../src/000-globals/ffd.vhd
vcom -quiet ../src/000-globals/ffdr.vhd
vcom -quiet ../src/000-globals/ld.vhd
vcom -quiet ../src/000-globals/ldr.vhd

## Multiplexers
vcom -quiet ../src/000-globals/mux21.vhd
vcom -quiet ../src/000-globals/mux21_logic.vhd
vcom -quiet ../src/000-globals/mux41.vhd
#vcom -quiet ../src/000-globals/mux41_logic.vhd
vcom -quiet ../src/000-globals/mux81.vhd
#vcom -quiet ../src/000-globals/mux81_logic.vhd

# Arithmetic Components
vcom -quiet ../src/000-globals/fa.vhd
vcom -quiet ../src/000-globals/rca.vhd
vcom -quiet ../src/000-globals/zero_detector.vhd

## Control Unit (a.a)
vcom -quiet ../src/a.a-cu.vhd

## Datapath (a.b)
vcom -quiet ../src/a.b-datapath.vhd
vcom -quiet ../src/a.b.a-register_file.vhd
vcom -quiet ../src/a.b.b-sign_extend.vhd
vcom -quiet ../src/a.b.c-register_addresser.vhd
vcom -quiet ../src/a.b.e-forwarding_unit.vhd

### ALU (a.b.d)
vcom -quiet ../src/a.b.d-alu.vhd
vcom -quiet ../src/a.b.d-alu/a.b.d.c-comparator.vhd
vcom -quiet ../src/a.b.d-alu/a.b.d.d-logic.vhd
vcom -quiet ../src/a.b.d-alu/a.b.d.e-barrel_shifter_left.vhd
vcom -quiet ../src/a.b.d-alu/a.b.d.f-barrel_shifter_right.vhd

#### P4 Adder (a.b.d.a)
vcom -quiet ../src/a.b.d-alu/a.b.d.a-p4_adder.vhd
vcom -quiet ../src/a.b.d-alu/a.b.d.a.a.d-pg_block.vhd
vcom -quiet ../src/a.b.d-alu/a.b.d.a.a.c-propagate.vhd
vcom -quiet ../src/a.b.d-alu/a.b.d.a.a.b-generate.vhd
vcom -quiet ../src/a.b.d-alu/a.b.d.a.a.a-pg_row.vhd
vcom -quiet ../src/a.b.d-alu/a.b.d.a.a-carry_generator.vhd
vcom -quiet ../src/a.b.d-alu/a.b.d.a.b.a-carry_select_block.vhd
vcom -quiet ../src/a.b.d-alu/a.b.d.a.b-sum_generator.vhd

#### Booth Multiplier (a.b.d.b)
vcom -quiet ../src/a.b.d-alu/a.b.d.b-booth_multiplier.vhd
vcom -quiet ../src/a.b.d-alu/a.b.d.b.a-booth_encoder.vhd
vcom -quiet ../src/a.b.d-alu/a.b.d.b.a.a-encoder.vhd

## IRAM (a.c)
vcom -quiet ../src/a.c-iram.vhd

## DRAM (a.d)
vcom -quiet ../src/a.d-dram.vhd

# DLX (a)
vcom -quiet ../src/a-dlx.vhd

# Testbench
#vcom -quiet ../src/test_bench/tb-datapath.vhd
vcom -quiet ../src/test_bench/tb-dlx.vhd

# Simulation
vsim -quiet -t 10ps work.CFG_TB -voptargs=+acc

#-------------------------------------------------------------------------------------------------
# Waveform Setup
#-------------------------------------------------------------------------------------------------

# Configure signal name width in waveform for better readability
config wave -signalnamewidth 1

# CONTROL UNIT specific waves

if {$dlx_unit eq 0 || $dlx_unit eq 1} {

	add wave -height 50 -divider {CONTROL UNIT} -height 19 \
	-color white sim:/tb_dlx/U1/CLK \
	-color gray  sim:/tb_dlx/U1/RST

	add wave -divider {INPUTS} -position insertpoint -radix hex \
	sim:/tb_dlx/U1/CU_I/IR_IN \
	sim:/tb_dlx/U1/CU_I/IR_opcode \
	sim:/tb_dlx/U1/CU_I/IR_func

	add wave -divider {ALU} -position insertpoint \
	sim:/tb_dlx/U1/CU_I/aluOpcode1 \
	sim:/tb_dlx/U1/CU_I/aluOpcode2 \
	sim:/tb_dlx/U1/CU_I/aluOpcode3 \
	sim:/tb_dlx/U1/CU_I/ALU_OPCODE

	add wave -divider {CONTROL WORDS} -position insertpoint -radix binary \
	sim:/tb_dlx/U1/CU_I/cw1 \
	sim:/tb_dlx/U1/CU_I/cw2 \
	sim:/tb_dlx/U1/CU_I/cw3 \
	sim:/tb_dlx/U1/CU_I/cw4 \
	sim:/tb_dlx/U1/CU_I/cw5

	add wave -divider {OUTPUTS - FETCH} -position insertpoint \
	sim:/tb_dlx/U1/CU_I/IR_LATCH_EN \
	sim:/tb_dlx/U1/CU_I/PC_LATCH_EN \
	sim:/tb_dlx/U1/CU_I/NPC_LATCH_EN

	add wave -divider {OUTPUTS - DECODE} -position insertpoint \
	sim:/tb_dlx/U1/CU_I/RF_WE \
	sim:/tb_dlx/U1/CU_I/RegA_LATCH_EN \
	sim:/tb_dlx/U1/CU_I/RegB_LATCH_EN \
	sim:/tb_dlx/U1/CU_I/RegIMM_LATCH_EN

	add wave -divider {OUTPUTS - EXECUTE} -position insertpoint \
	sim:/tb_dlx/U1/CU_I/MUXA_SEL \
	sim:/tb_dlx/U1/CU_I/MUXB_SEL \
	sim:/tb_dlx/U1/CU_I/ALU_OUTREG_EN \
	sim:/tb_dlx/U1/CU_I/EQ_COND \
	sim:/tb_dlx/U1/CU_I/ALU_OPCODE

	add wave -divider {OUTPUTS - MEMORY} -position insertpoint \
	sim:/tb_dlx/U1/CU_I/DRAM_RE \
	sim:/tb_dlx/U1/CU_I/DRAM_WE \
	sim:/tb_dlx/U1/CU_I/LMD_LATCH_EN \
	sim:/tb_dlx/U1/CU_I/JUMP_EN \
	sim:/tb_dlx/U1/CU_I/JUMP_COND

	add wave -divider {OUTPUTS - WRITE BACK} -position insertpoint \
	sim:/tb_dlx/U1/CU_I/WB_MUX_SEL \
	sim:/tb_dlx/U1/CU_I/JAL_MUX_SEL

}

# DATAPATH specific waves

if {$dlx_unit eq 0 || $dlx_unit eq 2} {

	# FETCH (IF)

	if {$pipe_stage eq 0 || $pipe_stage eq 1} {

		add wave -height 50 -divider {FETCH (IF)} -height 19 \
		-color white sim:/tb_dlx/U1/CLK \
		-color gray  sim:/tb_dlx/U1/RST

		add wave -divider {IF Control Signals} -position insertpoint \
		sim:/tb_dlx/U1/DATAPATH_I/IR_LATCH_EN \
		sim:/tb_dlx/U1/DATAPATH_I/PC_LATCH_EN \
		sim:/tb_dlx/U1/DATAPATH_I/NPC_LATCH_EN

		add wave -divider {STAGE} -position insertpoint -radix binary \
		sim:/tb_dlx/U1/DATAPATH_I/IR_OUT

		add wave -position insertpoint \
		sim:/tb_dlx/U1/DATAPATH_I/IF_ALU_LABEL

		add wave -divider {PC_MUX} -position insertpoint \
		sim:/tb_dlx/U1/DATAPATH_I/NPC_BUS \
		sim:/tb_dlx/U1/DATAPATH_I/EX_MEM_ALU_OUTPUT \
		sim:/tb_dlx/U1/DATAPATH_I/PC_MUX_SEL \
		sim:/tb_dlx/U1/DATAPATH_I/PC_BUS

		add wave -divider {PROGRAM_COUNTER} -position insertpoint \
		sim:/tb_dlx/U1/DATAPATH_I/PC_LATCH_EN \
		sim:/tb_dlx/U1/DATAPATH_I/PC_BUS \
		sim:/tb_dlx/U1/DATAPATH_I/PC_OUTPUT

		add wave -divider {NEXT_PROGRAM_COUNTER} -position insertpoint \
		sim:/tb_dlx/U1/DATAPATH_I/NPC_LATCH_EN \
		sim:/tb_dlx/U1/DATAPATH_I/PC_BUS \
		sim:/tb_dlx/U1/DATAPATH_I/NPC_OUT

		add wave -divider {INSTRUCTION_REGISTER} -position insertpoint \
		sim:/tb_dlx/U1/DATAPATH_I/IR_BUS \
		sim:/tb_dlx/U1/DATAPATH_I/IR_OUT

		add wave -divider {IF-ID Pipeline} -position insertpoint \
		sim:/tb_dlx/U1/DATAPATH_I/IF_ID_NPC \
		sim:/tb_dlx/U1/DATAPATH_I/IF_ID_IR

	}

	# DECODE (ID)

	if {$pipe_stage eq 0 || $pipe_stage eq 2} {

		add wave -height 50 -divider {DECODE (ID)} -height 19 \
		-color white sim:/tb_dlx/U1/CLK \
		-color gray  sim:/tb_dlx/U1/RST

		add wave -divider {ID CONTROL SIGNALS} -position insertpoint \
		sim:/tb_dlx/U1/DATAPATH_I/RegA_LATCH_EN \
		sim:/tb_dlx/U1/DATAPATH_I/RegB_LATCH_EN \
		sim:/tb_dlx/U1/DATAPATH_I/RegIMM_LATCH_EN

		add wave -divider {STAGE} -position insertpoint \
		sim:/tb_dlx/U1/DATAPATH_I/IF_ID_IR \
		sim:/tb_dlx/U1/DATAPATH_I/ID_ALU_LABEL

		add wave -divider {REGISTER_ADDRESSER} -position insertpoint \
		sim:/tb_dlx/U1/DATAPATH_I/IF_ID_IR \
		sim:/tb_dlx/U1/DATAPATH_I/REGISTER_ADDRESSER/IR_OPC \
		sim:/tb_dlx/U1/DATAPATH_I/RS1 \
		sim:/tb_dlx/U1/DATAPATH_I/RS2 \
		sim:/tb_dlx/U1/DATAPATH_I/RD

		add wave -divider {REGISTER_FILE} -position insertpoint -radix decimal \
		sim:/tb_dlx/U1/DATAPATH_I/MEM_WB_RF_WE \
		sim:/tb_dlx/U1/DATAPATH_I/RS1 \
		sim:/tb_dlx/U1/DATAPATH_I/RS2 \
		sim:/tb_dlx/U1/DATAPATH_I/MEM_WB_RD \
		sim:/tb_dlx/U1/DATAPATH_I/WB_MUX_OUT \
		sim:/tb_dlx/U1/DATAPATH_I/RF_OUT1 \
		sim:/tb_dlx/U1/DATAPATH_I/RF_OUT2 \
		sim:/tb_dlx/U1/DATAPATH_I/REGISTER_FILE/REG

		add wave -divider {SIGN_EXTEND} -position insertpoint -radix decimal \
		sim:/tb_dlx/U1/DATAPATH_I/IF_ID_IR \
		sim:/tb_dlx/U1/DATAPATH_I/SIGN_EXTEND/IR_OPC \
		sim:/tb_dlx/U1/DATAPATH_I/SIGN_EXTEND/IMM_I \
		sim:/tb_dlx/U1/DATAPATH_I/SIGN_EXTEND/IMM_J \
		sim:/tb_dlx/U1/DATAPATH_I/IMM_OUT

		add wave -divider {IF-ID Pipeline} -position insertpoint \
		sim:/tb_dlx/U1/DATAPATH_I/IF_ID_NPC \
		sim:/tb_dlx/U1/DATAPATH_I/IF_ID_IR

		add wave -divider {ID-EX Pipeline} -position insertpoint \
		sim:/tb_dlx/U1/DATAPATH_I/ID_EX_NPC \
		sim:/tb_dlx/U1/DATAPATH_I/ID_EX_RF_WE \
		sim:/tb_dlx/U1/DATAPATH_I/ID_EX_RS1 \
		sim:/tb_dlx/U1/DATAPATH_I/ID_EX_RS2 \
		sim:/tb_dlx/U1/DATAPATH_I/ID_EX_RD \
		sim:/tb_dlx/U1/DATAPATH_I/ID_EX_RF_OUT1 \
		sim:/tb_dlx/U1/DATAPATH_I/ID_EX_RF_OUT2 \
		sim:/tb_dlx/U1/DATAPATH_I/ID_EX_IMM

	}

	# EXECUTE (EX)

	if {$pipe_stage eq 0 || $pipe_stage eq 3} {

		add wave -height 50 -divider {EXECUTE (EX)} -height 19 \
		-color white sim:/tb_dlx/U1/CLK \
		-color gray  sim:/tb_dlx/U1/RST

		add wave -divider {EX CONTROL SIGNALS} -position insertpoint \
		sim:/tb_dlx/U1/DATAPATH_I/MUXA_SEL \
		sim:/tb_dlx/U1/DATAPATH_I/MUXB_SEL \
		sim:/tb_dlx/U1/DATAPATH_I/ALU_OUTREG_EN \
		sim:/tb_dlx/U1/DATAPATH_I/EQ_COND \
		sim:/tb_dlx/U1/DATAPATH_I/ALU_OPCODE

		add wave -divider {STAGE} -position insertpoint \
		sim:/tb_dlx/U1/DATAPATH_I/EX_ALU_LABEL

		add wave -divider {FORWARDING UNIT} -position insertpoint \
		sim:/tb_dlx/U1/DATAPATH_I/ID_EX_RS1 \
		sim:/tb_dlx/U1/DATAPATH_I/ID_EX_RS2 \
		sim:/tb_dlx/U1/DATAPATH_I/EX_MEM_RD \
		sim:/tb_dlx/U1/DATAPATH_I/MEM_WB_RD \
		sim:/tb_dlx/U1/DATAPATH_I/EX_MEM_RF_WE \
		sim:/tb_dlx/U1/DATAPATH_I/MEM_WB_RF_WE \
		sim:/tb_dlx/U1/DATAPATH_I/FORWARD_A \
		sim:/tb_dlx/U1/DATAPATH_I/FORWARD_B

		add wave -divider {ALU_PRE_MUX1} -position insertpoint -radix decimal \
		sim:/tb_dlx/U1/DATAPATH_I/ID_EX_RF_OUT1 \
		sim:/tb_dlx/U1/DATAPATH_I/EX_MEM_ALU_OUTPUT \
		sim:/tb_dlx/U1/DATAPATH_I/JAL_MUX_OUT \
		sim:/tb_dlx/U1/DATAPATH_I/FORWARD_A \
		sim:/tb_dlx/U1/DATAPATH_I/ALU_PREOP1

		add wave -divider {ALU_MUX1} -position insertpoint -radix decimal \
		sim:/tb_dlx/U1/DATAPATH_I/ALU_PREOP1 \
		sim:/tb_dlx/U1/DATAPATH_I/ID_EX_NPC \
		sim:/tb_dlx/U1/DATAPATH_I/MUXA_SEL \
		sim:/tb_dlx/U1/DATAPATH_I/ALU_OP1

		add wave -divider {ALU_PRE_MUX2} -position insertpoint -radix decimal \
		sim:/tb_dlx/U1/DATAPATH_I/ID_EX_RF_OUT2 \
		sim:/tb_dlx/U1/DATAPATH_I/EX_MEM_ALU_OUTPUT \
		sim:/tb_dlx/U1/DATAPATH_I/JAL_MUX_OUT \
		sim:/tb_dlx/U1/DATAPATH_I/FORWARD_B \
		sim:/tb_dlx/U1/DATAPATH_I/ALU_PREOP2

		add wave -divider {ALU_MUX2} -position insertpoint -radix decimal \
		sim:/tb_dlx/U1/DATAPATH_I/ALU_PREOP2 \
		sim:/tb_dlx/U1/DATAPATH_I/ID_EX_IMM \
		sim:/tb_dlx/U1/DATAPATH_I/MUXB_SEL \
		sim:/tb_dlx/U1/DATAPATH_I/ALU_OP2

		add wave -divider {ALU} -position insertpoint -radix decimal \
		sim:/tb_dlx/U1/DATAPATH_I/ALU_OP1 \
		sim:/tb_dlx/U1/DATAPATH_I/ALU_OP2 \
		sim:/tb_dlx/U1/DATAPATH_I/ALU_OPCODE \
		sim:/tb_dlx/U1/DATAPATH_I/ALU_OUTPUT

		add wave -divider {ZERO_DETECTOR} -position insertpoint \
		sim:/tb_dlx/U1/DATAPATH_I/ID_EX_RF_OUT1 \
		sim:/tb_dlx/U1/DATAPATH_I/ZERO_OUT \
		sim:/tb_dlx/U1/DATAPATH_I/ZERO_OUT_NEG \
		sim:/tb_dlx/U1/DATAPATH_I/BRANCH_DETECT

		add wave -divider {ID-EX Pipeline} -position insertpoint \
		sim:/tb_dlx/U1/DATAPATH_I/ID_EX_NPC \
		sim:/tb_dlx/U1/DATAPATH_I/ID_EX_RF_WE \
		sim:/tb_dlx/U1/DATAPATH_I/ID_EX_RS1 \
		sim:/tb_dlx/U1/DATAPATH_I/ID_EX_RS2 \
		sim:/tb_dlx/U1/DATAPATH_I/ID_EX_RD \
		sim:/tb_dlx/U1/DATAPATH_I/ID_EX_RF_OUT1 \
		sim:/tb_dlx/U1/DATAPATH_I/ID_EX_RF_OUT2 \
		sim:/tb_dlx/U1/DATAPATH_I/ID_EX_IMM

		add wave -divider {EX-MEM Pipeline} -position insertpoint \
		sim:/tb_dlx/U1/DATAPATH_I/EX_MEM_NPC \
		sim:/tb_dlx/U1/DATAPATH_I/EX_MEM_BRANCH_DETECT \
		sim:/tb_dlx/U1/DATAPATH_I/EX_MEM_ALU_OUTPUT \
		sim:/tb_dlx/U1/DATAPATH_I/EX_MEM_RF_WE \
		sim:/tb_dlx/U1/DATAPATH_I/EX_MEM_RD \
		sim:/tb_dlx/U1/DATAPATH_I/EX_MEM_RF_OUT2

	}

	# MEMORY (MEM)

	if {$pipe_stage eq 0 || $pipe_stage eq 4} {

		add wave -height 50 -divider {MEMORY (MEM)} -height 19 \
		-color white sim:/tb_dlx/U1/CLK \
		-color gray  sim:/tb_dlx/U1/RST

		add wave -divider {MEM CONTROL SIGNALS} -position insertpoint \
		sim:/tb_dlx/U1/DATAPATH_I/DRAM_RE \
		sim:/tb_dlx/U1/DATAPATH_I/DRAM_WE \
		sim:/tb_dlx/U1/DATAPATH_I/LMD_LATCH_EN\
		sim:/tb_dlx/U1/DATAPATH_I/JUMP_EN \
		sim:/tb_dlx/U1/DATAPATH_I/JUMP_COND

		add wave -divider {STAGE} -position insertpoint \
		sim:/tb_dlx/U1/DATAPATH_I/MEM_ALU_LABEL

		add wave -divider {JUMP} -position insertpoint \
		sim:/tb_dlx/U1/DATAPATH_I/EX_MEM_BRANCH_DETECT \
		sim:/tb_dlx/U1/DATAPATH_I/JUMP_EN \
		sim:/tb_dlx/U1/DATAPATH_I/BRANCH_COND \
		sim:/tb_dlx/U1/DATAPATH_I/JUMP_COND \
		sim:/tb_dlx/U1/DATAPATH_I/PC_MUX_SEL

		add wave -divider {LATCHES} -position insertpoint \
		sim:/tb_dlx/U1/DATAPATH_I/MEM_WB_DRAM_OUTPUT_NEXT

		add wave -divider {EX-MEM Pipeline} -position insertpoint \
		sim:/tb_dlx/U1/DATAPATH_I/EX_MEM_NPC \
		sim:/tb_dlx/U1/DATAPATH_I/EX_MEM_BRANCH_DETECT \
		sim:/tb_dlx/U1/DATAPATH_I/EX_MEM_ALU_OUTPUT \
		sim:/tb_dlx/U1/DATAPATH_I/EX_MEM_RF_WE \
		sim:/tb_dlx/U1/DATAPATH_I/EX_MEM_RD \
		sim:/tb_dlx/U1/DATAPATH_I/EX_MEM_RF_OUT2

		add wave -divider {MEM-WB Pipeline} -position insertpoint \
		sim:/tb_dlx/U1/DATAPATH_I/MEM_WB_NPC \
		sim:/tb_dlx/U1/DATAPATH_I/MEM_WB_DRAM_OUTPUT \
		sim:/tb_dlx/U1/DATAPATH_I/MEM_WB_ALU_OUTPUT \
		sim:/tb_dlx/U1/DATAPATH_I/MEM_WB_RF_WE \
		sim:/tb_dlx/U1/DATAPATH_I/MEM_WB_RD

	}

	# WRITE BACK (WB)

	if {$pipe_stage eq 0 || $pipe_stage eq 5} {

		add wave -height 50 -divider {WRITE BACK (WB)} -height 19 \
		-color white sim:/tb_dlx/U1/CLK \
		-color gray  sim:/tb_dlx/U1/RST

		add wave -divider {WB CONTROL SIGNALS} -position insertpoint \
		sim:/tb_dlx/U1/DATAPATH_I/WB_MUX_SEL \
		sim:/tb_dlx/U1/DATAPATH_I/JAL_MUX_SEL

		add wave -divider {STAGE} -position insertpoint \
		sim:/tb_dlx/U1/DATAPATH_I/WB_ALU_LABEL

		add wave -divider {WB MUX} -position insertpoint \
		sim:/tb_dlx/U1/DATAPATH_I/MEM_WB_DRAM_OUTPUT \
		sim:/tb_dlx/U1/DATAPATH_I/MEM_WB_ALU_OUTPUT \
		sim:/tb_dlx/U1/DATAPATH_I/WB_MUX_SEL \
		sim:/tb_dlx/U1/DATAPATH_I/WB_MUX_OUT

		add wave -divider {JAL MUX} -position insertpoint -radix decimal \
		sim:/tb_dlx/U1/DATAPATH_I/WB_MUX_OUT \
		sim:/tb_dlx/U1/DATAPATH_I/MEM_WB_NPC \
		sim:/tb_dlx/U1/DATAPATH_I/JAL_MUX_SEL \
		sim:/tb_dlx/U1/DATAPATH_I/JAL_MUX_OUT

		add wave -divider {MEM-WB Pipeline} -position insertpoint -radix decimal \
		sim:/tb_dlx/U1/DATAPATH_I/MEM_WB_NPC \
		sim:/tb_dlx/U1/DATAPATH_I/MEM_WB_DRAM_OUTPUT \
		sim:/tb_dlx/U1/DATAPATH_I/MEM_WB_ALU_OUTPUT \
		sim:/tb_dlx/U1/DATAPATH_I/MEM_WB_RF_WE \
		sim:/tb_dlx/U1/DATAPATH_I/MEM_WB_RD

	}

}

# IRAM specific waves

if {$dlx_unit eq 0 || $dlx_unit eq 3} {

	add wave -height 50 -divider {IRAM} -height 19 -position insertpoint \
	-color white sim:/tb_dlx/U1/CLK \
	-color gray  sim:/tb_dlx/U1/RST

	add wave -position insertpoint \
	sim:/tb_dlx/U1/IRAM_I/ADDR \
	sim:/tb_dlx/U1/IRAM_I/DOUT \
	
	add wave -position insertpoint -radix decimal \
	sim:/tb_dlx/U1/IRAM_I/IRAM_mem

	add wave -divider {STAGE} -position insertpoint \
	sim:/tb_dlx/U1/DATAPATH_I/IF_ALU_LABEL

}

# DRAM specific waves

if {$dlx_unit eq 0 || $dlx_unit eq 4} {

	add wave -height 50 -divider {DRAM} -height 19 -position insertpoint \
	-color white sim:/tb_dlx/U1/CLK \
	-color gray  sim:/tb_dlx/U1/RST \
	
	add wave -position insertpoint -radix decimal \
	sim:/tb_dlx/U1/DRAM_I/RE \
	sim:/tb_dlx/U1/DRAM_I/WE \
	sim:/tb_dlx/U1/DRAM_I/ADDR \
	sim:/tb_dlx/U1/DRAM_I/DIN \
	sim:/tb_dlx/U1/DRAM_I/DOUT \
	
	add wave -position insertpoint -radix decimal \
	sim:/tb_dlx/U1/DRAM_I/DRAM_mem

	add wave -divider {STAGE} -position insertpoint \
	sim:/tb_dlx/U1/DATAPATH_I/MEM_ALU_LABEL

}

# ALU-specific waves
if {$dlx_unit eq 5} {

	add wave -divider {TB_DATAPATH} -position insertpoint \
	sim:/tb_dlx/U1/DATAPATH_I/CLK \
	sim:/tb_dlx/U1/DATAPATH_I/RST

	add wave -divider {EX CONTROL SIGNALS} -position insertpoint \
	sim:/tb_dlx/U1/DATAPATH_I/MUXA_SEL \
	sim:/tb_dlx/U1/DATAPATH_I/MUXB_SEL \
	sim:/tb_dlx/U1/DATAPATH_I/ALU_OUTREG_EN \
	sim:/tb_dlx/U1/DATAPATH_I/EQ_COND \
	sim:/tb_dlx/U1/DATAPATH_I/ALU_OPCODE

	add wave -divider {STAGE} -position insertpoint \
	sim:/tb_dlx/U1/DATAPATH_I/EX_ALU_LABEL

	add wave -divider {ALU_PRE_MUX1} -position insertpoint \
	sim:/tb_dlx/U1/DATAPATH_I/ID_EX_NPC \
	sim:/tb_dlx/U1/DATAPATH_I/MUXA_SEL \
	sim:/tb_dlx/U1/DATAPATH_I/ALU_PREOP1

	add wave -divider {ALU_MUX1} -position insertpoint \
	sim:/tb_dlx/U1/DATAPATH_I/ID_EX_RF_OUT1 \
	sim:/tb_dlx/U1/DATAPATH_I/ALU_PREOP1 \
	sim:/tb_dlx/U1/DATAPATH_I/MUXA_SEL \
	sim:/tb_dlx/U1/DATAPATH_I/ALU_OP1

	add wave -divider {ALU_PRE_MUX2} -position insertpoint \
	sim:/tb_dlx/U1/DATAPATH_I/ID_EX_IMM_NEXT \
	sim:/tb_dlx/U1/DATAPATH_I/MUXB_SEL \
	sim:/tb_dlx/U1/DATAPATH_I/ALU_PREOP2

	add wave -divider {ALU_MUX2} -position insertpoint \
	sim:/tb_dlx/U1/DATAPATH_I/ID_EX_RF_OUT2 \
	sim:/tb_dlx/U1/DATAPATH_I/ALU_PREOP2 \
	sim:/tb_dlx/U1/DATAPATH_I/MUXB_SEL \
	sim:/tb_dlx/U1/DATAPATH_I/ALU_OP2

	add wave -divider {ALU I/O} -position insertpoint -radix decimal \
	sim:/tb_dlx/U1/DATAPATH_I/ARITHMETIC_LOGIC_UNIT/OP1 \
	sim:/tb_dlx/U1/DATAPATH_I/ARITHMETIC_LOGIC_UNIT/OP2 \
	sim:/tb_dlx/U1/DATAPATH_I/ARITHMETIC_LOGIC_UNIT/OPC \
	sim:/tb_dlx/U1/DATAPATH_I/ARITHMETIC_LOGIC_UNIT/Y_TMP \
	sim:/tb_dlx/U1/DATAPATH_I/ARITHMETIC_LOGIC_UNIT/Y \
	sim:/tb_dlx/U1/DATAPATH_I/ARITHMETIC_LOGIC_UNIT/Z

	add wave -divider {P4 ADDER} -position insertpoint -radix decimal \
	sim:/tb_dlx/U1/DATAPATH_I/ARITHMETIC_LOGIC_UNIT/SUM/*

	add wave -divider {P4 - CARRY GENERATOR} -position insertpoint \
	sim:/tb_dlx/U1/DATAPATH_I/ARITHMETIC_LOGIC_UNIT/SUM/CARRY_GENERATOR_INSTANCE/*

	add wave -divider {P4 - SUM GENERATOR} -position insertpoint \
	sim:/tb_dlx/U1/DATAPATH_I/ARITHMETIC_LOGIC_UNIT/SUM/SUM_GENERATOR_INSTANCE/*

}

#-------------------------------------------------------------------------------------------------
# Simulation Run
#-------------------------------------------------------------------------------------------------

# Suppress warnings 
quietly set StdArithNoWarnings 1
quietly set NumericStdNoWarnings 1

# Run 0 ns of simulation
run 0 ns;

# Re-enable warnings
quietly set StdArithNoWarnings 0
quietly set NumericStdNoWarnings 0

# Run the real simulation
run 100 ns

# Restore cursor and zoom settings for better visibility in wave view
WaveRestoreCursors {0 ns}
#WaveRestoreZoom {0 fs} [simtime]
WaveRestoreZoom {0 ns} {30 ns}

# Uncomment to quit the simulation automatically
#quit
