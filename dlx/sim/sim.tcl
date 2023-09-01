#----------------------------------------------------------------------------------------------------
# Description:	This module is responsible for setting up the simulation 
#		environment in QuestaSim for the DLX microarchitecture. 
#		It compiles VHDL files related to the various components of DLX
#		and, additionally, it sets up simulation waveforms based on
#		user-specified configurations for better debugging.
#		User can select between different waveform settings and focus on
#		specific pipeline stages for detailed observations.
#
# Author:	Riccardo Cuccu
# Date:		2023/09/01
#----------------------------------------------------------------------------------------------------

#----------------------------------------------------------------------------------------------------
# Control Panel
#----------------------------------------------------------------------------------------------------

# User-configurable settings for simulation
quietly set tb_waves 2		; # 0 = Default; 1 = DLX; 2 = DATAPATH
quietly set pipe_stage 3	; # 1 = Fetch; 2 = Decode; 3 = Execute; 4 = Memory; 5 = Write Back

#----------------------------------------------------------------------------------------------------
# Compile VHDL files
#----------------------------------------------------------------------------------------------------

# Constants & functions (000)
vcom -quiet ../src/000-functions.vhd
vcom -quiet ../src/000-globals.vhd

## Logic Ports
vcom -quiet ../src/000-globals/and.vhd
vcom -quiet ../src/000-globals/nand.vhd
#vcom -quiet ../src/000-globals/xand.vhd
#vcom -quiet ../src/000-globals/xnand.vhd
vcom -quiet ../src/000-globals/or.vhd
vcom -quiet ../src/000-globals/nor.vhd
vcom -quiet ../src/000-globals/xor.vhd
vcom -quiet ../src/000-globals/xnor.vhd

## Latch, flip-flop and registers
vcom -quiet ../src/000-globals/ffd.vhd
vcom -quiet ../src/000-globals/ffdr.vhd
vcom -quiet ../src/000-globals/ld.vhd
vcom -quiet ../src/000-globals/ldr.vhd

## Generic Logic Components
vcom -quiet ../src/000-globals/mux21.vhd
vcom -quiet ../src/000-globals/mux41.vhd
vcom -quiet ../src/000-globals/zerodetector.vhd

## Control Unit (a.a)
vcom -quiet ../src/a.a-cu.vhd
#-suppress 1937;				# ** Warning: (vcom-1937) Choice in CASE statement alternative must be locally static.

## Datapath (a.b)
vcom -quiet ../src/a.b-datapath.vhd
vcom -quiet ../src/a.b.a-registerfile.vhd
#vcom -quiet ../src/a.b.b-mux21.vhd
#vcom -quiet ../src/a.b.b-mux41.vhd
#vcom -quiet ../src/a.b.c-forwardingunit.vhd
vcom -quiet ../src/a.b.e-dram.vhd
vcom -quiet ../src/a.b.f-iram.vhd
#vcom -quiet ../src/a.b.g-pc.vhd
#vcom -quiet ../src/a.b.h-ir.vhd
vcom -quiet ../src/a.b.i-signextend.vhd
vcom -quiet ../src/a.b.j-registeraddresser.vhd

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
#vcom -quiet ../src/a.b.d-alu/a.b.d.c-comparator.vhd

#### Logic (a.b.d.d)
#vcom -quiet ../src/a.b.d-alu/a.b.d.d-logic.vhd

#### Floating Point Adder (a.b.d.e)
#vcom -quiet ../src/a.b.d-alu/a.b.d.e-floatingpointadder.vhd

#### Floating Point Multiplier (a.b.d.f)
#vcom -quiet ../src/a.b.d-alu/a.b.d.f-floatingpointmultiplier.vhd

# DLX (a)
vcom -quiet ../src/a-dlx.vhd

# Testbench
if {$tb_waves eq 1} {
	vcom -quiet ../src/test_bench/tb-dlx.vhd
}
if {$tb_waves eq 2} {
	vcom -quiet ../src/test_bench/tb-datapath.vhd
}

# Simulation
vsim -quiet -t 10ps work.CFG_TB -voptargs=+acc

#----------------------------------------------------------------------------------------------------
# Waveform Setup
#----------------------------------------------------------------------------------------------------

# Default wave settings
if {$tb_waves eq 0} {

	#view -undock wave
	add wave /*

}


# DLX-specific waves
if {$tb_waves eq 1} {

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

	add wave -position insertpoint \
	sim:/tb_dlx/U1/CU_I/IR_opcode_LABEL_i \
	sim:/tb_dlx/U1/CU_I/IR_func_LABEL_i

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

}


# Datapath-specific waves
if {$tb_waves eq 2} {

	#view -undock wave
	#add wave -divider {TB_DATAPATH} /*

	add wave -divider {TB_DATAPATH} -position insertpoint \
	sim:/tb_datapath/U1/CLK \
	sim:/tb_datapath/U1/RST

	# FETCH (IF)

	if {$pipe_stage eq 1} { 

		add wave -divider {IF Control Signals} -position insertpoint \
		sim:/tb_datapath/U1/IR_LATCH_EN \
		sim:/tb_datapath/U1/NPC_LATCH_EN

		add wave -divider {STAGE} -position insertpoint -radix binary \
		sim:/tb_datapath/U1/IR_OUT

		add wave -position insertpoint \
		sim:/tb_datapath/U1/IF_ALU_LABEL

		add wave -divider {PC_MUX} -position insertpoint \
		sim:/tb_datapath/U1/NPC_BUS \
		sim:/tb_datapath/U1/EX_MEM_ALU_OUT \
		sim:/tb_datapath/U1/PC_MUX_SEL \
		sim:/tb_datapath/U1/PC_BUS

		add wave -divider {PROGRAM_COUNTER} -position insertpoint \
		sim:/tb_datapath/U1/PC_BUS \
		sim:/tb_datapath/U1/PC_OUT

		add wave -divider {NEXT_PROGRAM_COUNTER} -position insertpoint \
		sim:/tb_datapath/U1/PC_BUS \
		sim:/tb_datapath/U1/NPC_OUT

		add wave -divider {INSTRUCTION_MEMORY} -position insertpoint \
		sim:/tb_datapath/U1/PC_OUT \
		sim:/tb_datapath/U1/IR_BUS

		add wave -divider {INSTRUCTION_REGISTER} -position insertpoint \
		sim:/tb_datapath/U1/IR_BUS \
		sim:/tb_datapath/U1/IR_OUT

		add wave -divider {IF-ID Pipeline} -position insertpoint \
		sim:/tb_datapath/U1/IF_ID_NPC \
		sim:/tb_datapath/U1/IF_ID_IR

	}

	# DECODE (ID)

	if {$pipe_stage eq 2} { 

		add wave -divider {ID CONTROL SIGNALS} -position insertpoint \
		sim:/tb_datapath/U1/RegA_LATCH_EN \
		sim:/tb_datapath/U1/RegB_LATCH_EN \
		sim:/tb_datapath/U1/RegIMM_LATCH_EN

		add wave -divider {STAGE} -position insertpoint \
		sim:/tb_datapath/U1/IF_ID_IR \
		sim:/tb_datapath/U1/ID_ALU_LABEL

		add wave -divider {REGISTER_ADDRESSER} -position insertpoint \
		sim:/tb_datapath/U1/IF_ID_IR \
		sim:/tb_datapath/U1/RS1 \
		sim:/tb_datapath/U1/RS2 \
		sim:/tb_datapath/U1/RD \

		add wave -divider {REGISTER_FILE} -position insertpoint \
		sim:/tb_datapath/U1/RF_WE \
		sim:/tb_datapath/U1/RS1 \
		sim:/tb_datapath/U1/RS2 \
		sim:/tb_datapath/U1/MEM_WB_RD \
		sim:/tb_datapath/U1/WB_MUX_OUT \
		sim:/tb_datapath/U1/RF_OUT1 \
		sim:/tb_datapath/U1/RF_OUT2

		add wave -divider {SIGN_EXTEND} -position insertpoint \
		sim:/tb_datapath/U1/IF_ID_IR \
		sim:/tb_datapath/U1/SIGN_EXTEND/IR_OPC \
		sim:/tb_datapath/U1/IMM_OUT

		add wave -divider {IF-ID Pipeline} -position insertpoint \
		sim:/tb_datapath/U1/IF_ID_NPC \
		sim:/tb_datapath/U1/IF_ID_IR

		add wave -divider {ID-EX Pipeline} -position insertpoint \
		sim:/tb_datapath/U1/ID_EX_NPC \
		sim:/tb_datapath/U1/ID_EX_RD \
		sim:/tb_datapath/U1/ID_EX_RF_DATAIN \
		sim:/tb_datapath/U1/ID_EX_RF_OUT1 \
		sim:/tb_datapath/U1/ID_EX_RF_OUT2 \
		sim:/tb_datapath/U1/ID_EX_IMM

	}

	# EXECUTE (EX)

	if {$pipe_stage eq 3} {

		add wave -divider {EX CONTROL SIGNALS} -position insertpoint \
		sim:/tb_datapath/U1/MUXA_SEL \
		sim:/tb_datapath/U1/MUXB_SEL \
		sim:/tb_datapath/U1/ALU_OUTREG_EN \
		sim:/tb_datapath/U1/EQ_COND \
		sim:/tb_datapath/U1/ALU_OPCODE

		add wave -divider {STAGE} -position insertpoint \
		sim:/tb_datapath/U1/EX_ALU_LABEL

		add wave -divider {ALU_PRE_MUX1} -position insertpoint \
		sim:/tb_datapath/U1/ID_EX_RF_DATAIN \
		sim:/tb_datapath/U1/ID_EX_NPC \
		sim:/tb_datapath/U1/ALU_PREOP1

		add wave -divider {ALU_MUX1} -position insertpoint \
		sim:/tb_datapath/U1/ID_EX_RF_OUT1 \
		sim:/tb_datapath/U1/ALU_PREOP1 \
		sim:/tb_datapath/U1/ALU_OP1

		add wave -divider {ALU_PRE_MUX2} -position insertpoint \
		sim:/tb_datapath/U1/ID_EX_RF_DATAIN \
		sim:/tb_datapath/U1/ID_EX_IMM_NEXT \
		sim:/tb_datapath/U1/ALU_PREOP2

		add wave -divider {ALU_MUX2} -position insertpoint \
		sim:/tb_datapath/U1/ID_EX_RF_OUT2 \
		sim:/tb_datapath/U1/ALU_PREOP2 \
		sim:/tb_datapath/U1/ALU_OP2

		add wave -divider {ALU} -position insertpoint \
		sim:/tb_datapath/U1/ALU_OP1 \
		sim:/tb_datapath/U1/ALU_OP2 \
		sim:/tb_datapath/U1/ALU_OPCODE \
		sim:/tb_datapath/U1/ALU_OUT \
		sim:/tb_datapath/U1/ALU_ZERO

		add wave -divider {ZERO_DETECTOR} -position insertpoint \
		sim:/tb_datapath/U1/ID_EX_RF_OUT1 \
		sim:/tb_datapath/U1/ZERO_OUT \
		sim:/tb_datapath/U1/ZERO_OUT_NEG \
		sim:/tb_datapath/U1/BRANCH_COND

		add wave -divider {ID-EX Pipeline} -position insertpoint \
		sim:/tb_datapath/U1/ID_EX_NPC \
		sim:/tb_datapath/U1/ID_EX_RD \
		sim:/tb_datapath/U1/ID_EX_RF_DATAIN \
		sim:/tb_datapath/U1/ID_EX_RF_OUT1 \
		sim:/tb_datapath/U1/ID_EX_RF_OUT2 \
		sim:/tb_datapath/U1/ID_EX_IMM

		add wave -divider {EX_MEM Pipeline} -position insertpoint \
		sim:/tb_datapath/U1/EX_MEM_NPC \
		sim:/tb_datapath/U1/EX_MEM_RD \
		sim:/tb_datapath/U1/EX_MEM_RF_OUT2

	}

	# MEMORY (MEM)

	if {$pipe_stage eq 4} {

		add wave -divider {MEM CONTROL SIGNALS} -position insertpoint \
		sim:/tb_datapath/U1/DRAM_RE \
		sim:/tb_datapath/U1/DRAM_WE \
		sim:/tb_datapath/U1/LMD_LATCH_EN\
		sim:/tb_datapath/U1/JUMP_EN \
		sim:/tb_datapath/U1/PC_LATCH_EN

		add wave -divider {STAGE} -position insertpoint \
		sim:/tb_datapath/U1/EX_MEM_IR \
		sim:/tb_datapath/U1/MEM_ALU_LABEL

	}

	# WRITE BACK (WB)

	if {$pipe_stage eq 5} {

		add wave -divider {WB CONTROL SIGNALS} -position insertpoint \
		sim:/tb_datapath/U1/WB_MUX_SEL \
		sim:/tb_datapath/U1/RF_WE

		add wave -divider {STAGE} -position insertpoint \
		sim:/tb_datapath/U1/MEM_WB_IR \
		sim:/tb_datapath/U1/WB_ALU_LABEL

	}

}

#----------------------------------------------------------------------------------------------------
# Simulation Run
#----------------------------------------------------------------------------------------------------

# Run the simulation
run 60 ns

# Restore cursor and zoom settings for better visibility in wave view
WaveRestoreCursors {0 ns}
#WaveRestoreZoom {0 fs} [simtime]
WaveRestoreZoom {0 ns} {30 ns}

# Uncomment to quit the simulation automatically
#quit
