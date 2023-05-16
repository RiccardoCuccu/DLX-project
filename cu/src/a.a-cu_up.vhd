library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.constants.all;
--use ieee.numeric_std.all;
--use work.all;

entity DLX_CU is

	generic (
		INSTRUCTIONS_EXE_CYCLES	: integer := IN_EXE_CYCLES_GLOBAL;	-- Instructions Execution
		MICROCODE_MEM_SIZE	: integer := MMEM_SIZE_GLOBAL;		-- Microcode Memory Size
		RELOC_MEM_SIZE		: integer := RMEM_SIZE_GLOBAL;		-- Microcode Relocation
		FUNC_SIZE		: integer := FUNC_SIZE_GLOBAL;		-- Func Field Size for R-Type Ops
		OP_CODE_SIZE		: integer := OPC_SIZE_GLOBAL;		-- Op Code Size
--		ALU_OPC_SIZE		: integer := OPC_SIZE_GLOBAL;		-- ALU Op Code Size
		IR_SIZE			: integer := IR_SIZE_GLOBAL;		-- Instruction Register Size
		CW_SIZE			: integer := CW_SIZE_GLOBAL);		-- Control Word Size

	port (
		Clk			: in  std_logic;	-- Clock
		Rst			: in  std_logic;	-- Reset:Active-Low

		-- Instruction Register
		IR_IN			: in  std_logic_vector(IR_SIZE - 1 downto 0);

		-- IF Control Signal
		IR_LATCH_EN		: out std_logic;	-- Instruction Register Latch Enable
		NPC_LATCH_EN		: out std_logic;	-- NextProgramCounter Register Latch Enable

		-- ID Control Signals
		RegA_LATCH_EN		: out std_logic;	-- Register A Latch Enable
		RegB_LATCH_EN		: out std_logic;	-- Register B Latch Enable
		RegIMM_LATCH_EN		: out std_logic;	-- Immediate Register Latch Enable

		-- EX Control Signals
		MUXA_SEL		: out std_logic;	-- MUX-A Sel
		MUXB_SEL		: out std_logic;	-- MUX-B Sel
		ALU_OUTREG_EN		: out std_logic;	-- ALU Output Register Enable
		EQ_COND			: out std_logic;	-- Branch if (not) Equal to Zero

		-- ALU Operation Code
		ALU_OPCODE		: out aluOp;		-- choose between implicit or explicit coding, like std_logic_vector(ALU_OPC_SIZE - 1 downto 0);
		--ALU_OPCODE		: out std_logic_vector(ALU_OPC_SIZE - 1 downto 0);

		-- MEM Control Signals
		DRAM_WE			: out std_logic;	-- Data RAM Write Enable
		LMD_LATCH_EN		: out std_logic;	-- LMD Register Latch Enable
		JUMP_EN			: out std_logic;	-- JUMP Enable Signal for PC input MUX
		PC_LATCH_EN		: out std_logic;	-- Program Counter Latch Enable

		-- WB Control signals
		WB_MUX_SEL		: out std_logic;	-- Write Back MUX Sel
		RF_WE			: out std_logic);	-- Register File Write Enable

end DLX_CU;


architecture DLX_CU_MIC of DLX_CU is
	-- R-Type OpCode: 0x00
	--    ADD func Code: 0x20
	--    SUB func Code: 0x22
	-- I-Type OpCode
	--    LW : 0x23
	--    SW : 0x2b
	-- J-Type OpCode
	--    J    : 0x02
	--    BEQZ : 0x04

	type mem_array is array (integer range 0 to MICROCODE_MEM_SIZE - 1) of std_logic_vector(CW_SIZE - 1 downto 0);
	type reloc_mem_array is array (0 to RELOC_MEM_SIZE - 1) of unsigned(OP_CODE_SIZE + 1 downto 0);

	signal reloc_mem : reloc_mem_array := (

						x"00",	-- x"00" RTYPE		-> All R-Type Instructions are not Relocated
						x"00",	-- x"01"
						x"02",	-- x"02" J		-> 0x02
						x"00",	-- x"03" JAL
						x"08",	-- x"04" BEQZ		-> 0x08
						x"00",	-- x"05" BNEZ
						x"00",	-- x"06" BFPT
						x"00",	-- x"07" BFPF
						x"00",	-- x"08" ADDI
						x"00",	-- x"09" ADDUI
						x"00",	-- x"0A" SUBI
						x"00",	-- x"0B" SUBUI
						x"00",	-- x"0C" ANDI
						x"00",	-- x"0D" ORI
						x"00",	-- x"0E" XORI
						x"00",	-- x"0F" LHI

						x"00",	-- x"10" RFE
						x"00",	-- x"11" TRAP
						x"00",	-- x"12" JR
						x"00",	-- x"13" JALR
						x"00",	-- x"14" SLLI
						x"00",	-- x"15" NOP
						x"00",	-- x"16" SRLI
						x"00",	-- x"17" SRAI
						x"00",	-- x"18" SEQI
						x"00",	-- x"19" SNEI
						x"00",	-- x"1A" SLTI
						x"00",	-- x"1B" SGTI
						x"00",	-- x"1C" SLEI
						x"00",	-- x"1D" SGEI
						x"00",	-- x"1E"
						x"00",	-- x"1F"

						x"00",	-- x"20" LB
						x"00",	-- x"21" LH
						x"00",	-- x"22"
						x"29",	-- x"23" LW		-> 0x29
						x"00",	-- x"24" LBU
						x"00",	-- x"25" LHU
						x"00",	-- x"26" LF
						x"00",	-- x"27" LD
						x"00",	-- x"28" SB
						x"00",	-- x"29" SH
						x"00",	-- x"2A"
						x"36",	-- x"2B" SW		-> 0x36
						x"00",	-- x"2C"
						x"00",	-- x"2D"
						x"00",	-- x"2E" SF
						x"00",	-- x"2F" SD

						x"00",	-- x"30"
						x"00",	-- x"31"
						x"00",	-- x"32"
						x"00",	-- x"33"
						x"00",	-- x"34"
						x"00",	-- x"35"
						x"00",	-- x"36"
						x"00",	-- x"37"
						x"00",	-- x"38" ITLB
						x"00",	-- x"39"
						x"00",	-- x"3A" SLTUI
						x"00",	-- x"3B" SGTUI
						x"00",	-- x"3C" SLEUI
						x"00",	-- x"3D" SGEUI
						x"00",	-- x"3E"
						x"00");	-- x"3F"

	signal microcode : mem_array := (

						"000000000000000",	-- RESET
						"110000000000000",	-- (IF)
						"001010110000000",	-- (ID) 'J' (0x02)
						"000000111000100",	-- (EX)
						"000000000000101",	-- (MEM)
						"000000000000000",	-- (WB)
						"000000000000000",
						"110000000000000",	-- (IF)
						"001010000000000",	-- (ID) 'BEQZ' (0x04)
						"000000101000000",	-- (EX)
						"000000000001000",	-- (MEM)
						"000000000000000",	-- (WB)
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",	-- (ID) 'LW' (0x23)
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",	-- (ID) 'SW' (0x2b)
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"110000000000000",
						"001100000000000",	-- (ID) 'ADD' (0x00,0x20)
						"000000010000000",
						"000000000000100",
						"000000000000011",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",	-- (ID) 'SUB' (0x00,0x22)
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000",
						"000000000000000");

	signal cw		: std_logic_vector(CW_SIZE - 1 downto 0);

	signal uPC		: integer range 0 to 131072;
	signal ICount		: integer range 0 to INSTRUCTIONS_EXE_CYCLES;
	
	signal IR_opcode	: unsigned(OP_CODE_SIZE - 1 downto 0);			-- OpCode part of IR
	signal IR_func		: unsigned(FUNC_SIZE - 1 downto 0);			-- Func part of IR when Rtype

	signal OpCode_Reloc	: unsigned(OP_CODE_SIZE + 1 downto 0);
	
	constant R_OpCode	: unsigned(OP_CODE_SIZE - 1 downto 0) := "000000";

begin

	IR_opcode	<= unsigned(IR_IN(IR_SIZE - 1 downto IR_SIZE - OP_CODE_SIZE));
	IR_func		<= unsigned(IR_IN(FUNC_SIZE - 3 downto 0)) & "00";		-- Multiply func value by 4 (Shift left)
	cw		<= microcode(uPC);
	
	OpCode_Reloc	<= reloc_mem(conv_integer(IR_opcode));

	-- stage one control signals
	IR_LATCH_EN	<= cw(CW_SIZE - 1);
	NPC_LATCH_EN	<= cw(CW_SIZE - 2);

	-- stage two control signals
	RegA_LATCH_EN	<= cw(CW_SIZE - 3);
	RegB_LATCH_EN	<= cw(CW_SIZE - 4);
	RegIMM_LATCH_EN	<= cw(CW_SIZE - 5);

	-- stage three control signals
	MUXA_SEL	<= cw(CW_SIZE - 6);
	MUXB_SEL	<= cw(CW_SIZE - 7);
	ALU_OUTREG_EN	<= cw(CW_SIZE - 8);
	EQ_COND		<= cw(CW_SIZE - 9);

	-- stage four control signals
	DRAM_WE		<= cw(CW_SIZE - 10);
	LMD_LATCH_EN	<= cw(CW_SIZE - 11);
	JUMP_EN		<= cw(CW_SIZE - 12);
	PC_LATCH_EN	<= cw(CW_SIZE - 13);

	-- stage five control signals
	WB_MUX_SEL	<= cw(CW_SIZE - 14);
	RF_WE		<= cw(CW_SIZE - 15);


	-- purpose: Generation of ALU OpCode
	-- type   : combinational
	-- inputs : IR_OpCode, IR_func
	-- outputs: ALU_OPCODE

	ALU_OP_CODE_P: process (IR_OpCode, IR_func)
	begin								-- process ALU_OP_CODE_P
		--ALU_OPCODE <= (others => '0');
		ALU_OPCODE <= OP_NOP;
		if (IR_opcode = R_OpCode) then				-- R-Type Instructions
			if (conv_integer(IR_func) = 128) then		-- ADD
				ALU_OPCODE <= OP_ADD;
			elsif (conv_integer(IR_func) = 136) then
				ALU_OPCODE <= OP_SUB;			-- SUB
			end if;
		end if;
	end process ALU_OP_CODE_P;

	-- purpose: Update the uPC value depending on the instruction Op Code
	-- type   : sequential
	-- inputs : Clk, Rst, IR_IN
	-- outputs: CW Control Signals

	uPC_Proc: process (Clk, Rst)
	begin								-- process uPC_Proc
		if Rst = '0' then					-- asynchronous reset (active low)
			uPC <= 0;
			ICount <= 0;
		elsif Clk'event and Clk = '1' then			-- rising clock edge
			if (ICount < 1) then
				uPC <= 1;
				ICount <= ICount + 1;
			elsif (ICount < 2) then
				if (IR_opcode = R_OpCode) then		-- R-Type instruction
					uPC <= conv_integer(IR_func);
				else
					uPC <= conv_integer(OpCode_Reloc);
				end if;
				ICount <= ICount + 1;
			elsif (ICount < INSTRUCTIONS_EXE_CYCLES) then
				uPC <= uPC + 1;
				ICount <= ICount + 1;
			else
				ICount <= 1;
				uPC <= 1;
			end if;

		end if;
	end process uPC_Proc;

end DLX_CU_MIC;
