--------------------------------------------------------------------------------
-- Description:	This module serves as the Hardwired Control Unit (CU) for a DLX processor.
--		It takes an instruction from the Instruction Register (IR) as input and generates
--		control signals for various datapath elements across five pipeline stages.
--		These control signals are generated based on opcode and function fields.
--
-- Author:	Riccardo Cuccu
-- Date:	2023/09/05
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.constants.all;
--use ieee.numeric_std.all;
--use work.all;

entity DLX_CU is

	generic (	MICROCODE_MEM_SIZE	: integer := MMEM_SIZE_GLOBAL;		-- Microcode Memory Size
			FUNC_SIZE		: integer := FUNC_SIZE_GLOBAL;		-- Func Field Size for R-Type Ops
			OP_CODE_SIZE		: integer := OPC_SIZE_GLOBAL;		-- Op Code Size
--			ALU_OPC_SIZE		: integer := OPC_SIZE_GLOBAL;		-- ALU Op Code Size
			IR_SIZE			: integer := IR_SIZE_GLOBAL;		-- Instruction Register Size
			CW_SIZE			: integer := CW_SIZE_GLOBAL);		-- Control Word Size

	port (		CLK			: in  std_logic;	-- Clock
			RST			: in  std_logic;	-- Reset (active low)

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
			MUXA_PRE_SEL		: out std_logic;	-- MUX-A Pre Sel
			MUXB_PRE_SEL		: out std_logic;	-- MUX-B Pre Sel
			MUXA_SEL		: out std_logic;	-- MUX-A Sel
			MUXB_SEL		: out std_logic;	-- MUX-B Sel
			ALU_OUTREG_EN		: out std_logic;	-- ALU Output Register Enable
			EQ_COND			: out std_logic;	-- Branch if (not) Equal to Zero

			-- ALU Operation Code
			ALU_OPCODE		: out aluOp;		-- choose between implicit or explicit coding, like std_logic_vector(ALU_OPC_SIZE - 1 downto 0);
			--ALU_OPCODE		: out std_logic_vector(ALU_OPC_SIZE - 1 downto 0);

			-- MEM Control Signals
			DRAM_RE			: out std_logic;	-- Data RAM Read Enable
			DRAM_WE			: out std_logic;	-- Data RAM Write Enable
			LMD_LATCH_EN		: out std_logic;	-- LMD Register Latch Enable
			JUMP_EN			: out std_logic;	-- JUMP Enable Signal for PC input MUX
			JUMP_COND		: out std_logic;	-- JUMP Condition
			PC_LATCH_EN		: out std_logic;	-- Program Counter Latch Enable

			-- WB Control signals
			WB_MUX_SEL		: out std_logic;	-- Write Back MUX Sel
			RF_WE			: out std_logic);	-- Register File Write Enable

end DLX_CU;


architecture DLX_CU_HW of DLX_CU is

	type mem_array is array (integer range 0 to MICROCODE_MEM_SIZE - 1) of std_logic_vector(CW_SIZE - 1 downto 0);

	-- look-up table
	signal cw_mem : mem_array := (	

					"11" & "110" & "000010" & "000001" & "11",		-- x"00" RTYPE	*
					"00" & "000" & "000000" & "000000" & "00",		-- x"01"
					"11" & "001" & "111110" & "000011" & "10",		-- x"02" J	*
					"11" & "001" & "111110" & "000011" & "11",		-- x"03" JAL	*
					"11" & "101" & "111110" & "000101" & "10",		-- x"04" BEQZ	*
					"11" & "101" & "111111" & "000101" & "10",		-- x"05" BNEZ	*
					"00" & "000" & "000000" & "000000" & "00",		-- x"06" BFPT	/
					"00" & "000" & "000000" & "000000" & "00",		-- x"07" BFPF	/
					"11" & "101" & "010110" & "000001" & "11",		-- x"08" ADDI	*
					"00" & "000" & "000000" & "000000" & "00",		-- x"09" ADDUI	/
					"11" & "101" & "010110" & "000001" & "11",		-- x"0A" SUBI	*
					"00" & "000" & "000000" & "000000" & "00",		-- x"0B" SUBUI	/
					"11" & "101" & "010110" & "000001" & "11",		-- x"0C" ANDI	*
					"11" & "101" & "010110" & "000001" & "11",		-- x"0D" ORI	*
					"11" & "101" & "010110" & "000001" & "11",		-- x"0E" XORI	*
					"00" & "000" & "000000" & "000000" & "00",		-- x"0F" LHI	/

					"00" & "000" & "000000" & "000000" & "00",		-- x"10" RFE	/
					"00" & "000" & "000000" & "000000" & "00",		-- x"11" TRAP	/
					"00" & "000" & "000000" & "000000" & "00",		-- x"12" JR	/
					"00" & "000" & "000000" & "000000" & "00",		-- x"13" JALR	/
					"11" & "101" & "010110" & "000001" & "11",		-- x"14" SLLI	*
					"11" & "000" & "000000" & "000001" & "10",		-- x"15" NOP	*
					"11" & "101" & "010110" & "000001" & "11",		-- x"16" SRLI	*
					"00" & "000" & "000000" & "000000" & "00",		-- x"17" SRAI	/
					"00" & "000" & "000000" & "000000" & "00",		-- x"18" SEQI	/
					"11" & "101" & "010110" & "000001" & "11",		-- x"19" SNEI	*
					"00" & "000" & "000000" & "000000" & "00",		-- x"1A" SLTI	/
					"00" & "000" & "000000" & "000000" & "00",		-- x"1B" SGTI	/
					"11" & "101" & "010110" & "000001" & "11",		-- x"1C" SLEI	*
					"11" & "101" & "010110" & "000001" & "11",		-- x"1D" SGEI	*
					"00" & "000" & "000000" & "000000" & "00",		-- x"1E"
					"00" & "000" & "000000" & "000000" & "00",		-- x"1F"

					"00" & "000" & "000000" & "000000" & "00",		-- x"20" LB	/
					"00" & "000" & "000000" & "000000" & "00",		-- x"21" LH	/
					"00" & "000" & "000000" & "000000" & "00",		-- x"22"
					"11" & "101" & "010110" & "101001" & "01",		-- x"23" LW	*
					"00" & "000" & "000000" & "000000" & "00",		-- x"24" LBU	/
					"00" & "000" & "000000" & "000000" & "00",		-- x"25" LHU	/
					"00" & "000" & "000000" & "000000" & "00",		-- x"26" LF	/
					"00" & "000" & "000000" & "000000" & "00",		-- x"27" LD	/
					"00" & "000" & "000000" & "000000" & "00",		-- x"28" SB	/
					"00" & "000" & "000000" & "000000" & "00",		-- x"29" SH	/
					"00" & "000" & "000000" & "000000" & "00",		-- x"2A"
					"11" & "101" & "010110" & "010001" & "10",		-- x"2B" SW	*
					"00" & "000" & "000000" & "000000" & "00",		-- x"2C"
					"00" & "000" & "000000" & "000000" & "00",		-- x"2D"
					"00" & "000" & "000000" & "000000" & "00",		-- x"2E" SF	/
					"00" & "000" & "000000" & "000000" & "00",		-- x"2F" SD	/

					"00" & "000" & "000000" & "000000" & "00",		-- x"30"
					"00" & "000" & "000000" & "000000" & "00",		-- x"31"
					"00" & "000" & "000000" & "000000" & "00",		-- x"32"
					"00" & "000" & "000000" & "000000" & "00",		-- x"33"
					"00" & "000" & "000000" & "000000" & "00",		-- x"34"
					"00" & "000" & "000000" & "000000" & "00",		-- x"35"
					"00" & "000" & "000000" & "000000" & "00",		-- x"36"
					"00" & "000" & "000000" & "000000" & "00",		-- x"37"
					"00" & "000" & "000000" & "000000" & "00",		-- x"38" ITLB	/
					"00" & "000" & "000000" & "000000" & "00",		-- x"39"
					"00" & "000" & "000000" & "000000" & "00",		-- x"3A" SLTUI	/
					"00" & "000" & "000000" & "000000" & "00",		-- x"3B" SGTUI	/
					"00" & "000" & "000000" & "000000" & "00",		-- x"3C" SLEUI	/
					"00" & "000" & "000000" & "000000" & "00",		-- x"3D" SGEUI	/
					"00" & "000" & "000000" & "000000" & "00",		-- x"3E"
					"00" & "000" & "000000" & "000000" & "00");		-- x"3F"

	--signal IR_opcode : std_logic_vector(OP_CODE_SIZE - 1 downto 0);		-- OpCode part of IR
	--signal IR_func   : std_logic_vector(FUNC_SIZE - 1 downto 0);			-- Func part of IR when Rtype

	signal IR_opcode : std_logic_vector(5 downto 0);				-- OpCode part of IR
	signal IR_func   : std_logic_vector(10 downto 0);				-- Func part of IR when Rtype
	--signal cw        : std_logic_vector(CW_SIZE - 1 downto 0);			-- full control word read from cw_mem

	-- control words
	signal cw1 : std_logic_vector(CW_SIZE - 1 downto 0);				-- first stage		/ 2 signals
	signal cw2 : std_logic_vector(CW_SIZE - 1 - 2 downto 0);			-- second stage		/ 3 signals
	signal cw3 : std_logic_vector(CW_SIZE - 1 - 5 downto 0);			-- third stage		/ 6 signals
	signal cw4 : std_logic_vector(CW_SIZE - 1 - 11 downto 0);			-- fourth stage		/ 6 signals
	signal cw5 : std_logic_vector(CW_SIZE - 1 - 17 downto 0);			-- fifth stage		/ 2 signals

	signal aluOpcode_i : aluOp := OP_NOP;	-- ALUOP defined in package
	signal aluOpcode1  : aluOp := OP_NOP;
	signal aluOpcode2  : aluOp := OP_NOP;
	signal aluOpcode3  : aluOp := OP_NOP;

--	signal aluOpcode_i : std_logic_vector(ALU_OPC_SIZE - 1 downto 0) := ITYPE_NOP;
--	signal aluOpcode1  : std_logic_vector(ALU_OPC_SIZE - 1 downto 0) := ITYPE_NOP;
--	signal aluOpcode2  : std_logic_vector(ALU_OPC_SIZE - 1 downto 0) := ITYPE_NOP;
--	signal aluOpcode3  : std_logic_vector(ALU_OPC_SIZE - 1 downto 0) := ITYPE_NOP;

	-- testbench signals
	signal IR_opcode_LABEL_i : ALU_label;
	signal IR_opcode_LABEL1 : ALU_label;
	signal IR_opcode_LABEL2 : ALU_label;
	signal IR_opcode_LABEL3 : ALU_label;

	signal IR_func_LABEL_i : ALU_label;
	signal IR_func_LABEL1 : ALU_label;
	signal IR_func_LABEL2 : ALU_label;
	signal IR_func_LABEL3 : ALU_label;

begin

	-- Extract Opcode and Function fields from the incoming instruction
	IR_opcode	<= IR_IN(IR_SIZE - 1 downto IR_SIZE - OP_CODE_SIZE);
	IR_func		<= IR_IN(FUNC_SIZE - 1 downto 0);
	--cw		<= cw_mem(conv_integer(IR_opcode));

	-- Generate IF stage control signals
	IR_LATCH_EN	<= cw1(CW_SIZE - 1);
	NPC_LATCH_EN	<= cw1(CW_SIZE - 2);

	-- Generate ID stage control signals
	RegA_LATCH_EN	<= cw2(CW_SIZE - 3);
	RegB_LATCH_EN	<= cw2(CW_SIZE - 4);
	RegIMM_LATCH_EN	<= cw2(CW_SIZE - 5);

	-- Generate EX stage control signals
	MUXA_PRE_SEL	<= cw3(CW_SIZE - 6);
	MUXB_PRE_SEL	<= cw3(CW_SIZE - 7);
	MUXA_SEL	<= cw3(CW_SIZE - 8);
	MUXB_SEL	<= cw3(CW_SIZE - 9);
	ALU_OUTREG_EN	<= cw3(CW_SIZE - 10);
	EQ_COND		<= cw3(CW_SIZE - 11);

	-- Generate MEM stage control signals
	DRAM_RE		<= cw4(CW_SIZE - 12);
	DRAM_WE		<= cw4(CW_SIZE - 13);
	LMD_LATCH_EN	<= cw4(CW_SIZE - 14);
	JUMP_EN		<= cw4(CW_SIZE - 15);
	JUMP_COND	<= cw4(CW_SIZE - 16);
	PC_LATCH_EN	<= cw4(CW_SIZE - 17);

	-- Generate WB stage control signals
	WB_MUX_SEL	<= cw5(CW_SIZE - 18);
	RF_WE		<= cw5(CW_SIZE - 19);


	-- Process for generating ALU operations and labels
	ALU_OP_CODE_P: process (IR_opcode, IR_func)
	begin
		-- R-Type instructions
		if IR_opcode = RTYPE then			-- ALU Operations		-- Operation Labels
			if IR_func = RTYPE_SLL		then	aluOpcode_i <= OP_SLL;		IR_func_LABEL_i <= L_RTYPE_SLL;
			elsif IR_func = RTYPE_SRL	then	aluOpcode_i <= OP_SRL;		IR_func_LABEL_i <= L_RTYPE_SRL;
--			elsif IR_func = RTYPE_SRA	then	aluOpcode_i <= OP_SRA;		IR_func_LABEL_i <= L_RTYPE_SRA;
			elsif IR_func = RTYPE_ADD	then	aluOpcode_i <= OP_ADD;		IR_func_LABEL_i <= L_RTYPE_ADD;
--			elsif IR_func = RTYPE_ADDU	then	aluOpcode_i <= OP_ADDU;		IR_func_LABEL_i <= L_RTYPE_ADDU;
			elsif IR_func = RTYPE_SUB	then	aluOpcode_i <= OP_SUB;		IR_func_LABEL_i <= L_RTYPE_SUB;
--			elsif IR_func = RTYPE_SUBU	then	aluOpcode_i <= OP_SUBU;		IR_func_LABEL_i <= L_RTYPE_SUBU;
			elsif IR_func = RTYPE_AND	then	aluOpcode_i <= OP_AND;		IR_func_LABEL_i <= L_RTYPE_AND;
			elsif IR_func = RTYPE_OR	then	aluOpcode_i <= OP_OR;		IR_func_LABEL_i <= L_RTYPE_OR;
			elsif IR_func = RTYPE_XOR	then	aluOpcode_i <= OP_XOR;		IR_func_LABEL_i <= L_RTYPE_XOR;
--			elsif IR_func = RTYPE_SEQ	then	aluOpcode_i <= OP_SEQ;		IR_func_LABEL_i <= L_RTYPE_SEQ;
			elsif IR_func = RTYPE_SNE	then	aluOpcode_i <= OP_SNE;		IR_func_LABEL_i <= L_RTYPE_SNE;
--			elsif IR_func = RTYPE_SLT	then	aluOpcode_i <= OP_SLT;		IR_func_LABEL_i <= L_RTYPE_SLT;
--			elsif IR_func = RTYPE_SGT	then	aluOpcode_i <= OP_SGT;		IR_func_LABEL_i <= L_RTYPE_SGT;
			elsif IR_func = RTYPE_SLE	then	aluOpcode_i <= OP_SLE;		IR_func_LABEL_i <= L_RTYPE_SLE;
			elsif IR_func = RTYPE_SGE	then	aluOpcode_i <= OP_SGE;		IR_func_LABEL_i <= L_RTYPE_SGE;
--			elsif IR_func = RTYPE_MOVI2S	then	aluOpcode_i <= OP_MOVI2S;	IR_func_LABEL_i <= L_RTYPE_MOVI2S;
--			elsif IR_func = RTYPE_MOVS2I	then	aluOpcode_i <= OP_MOVS2I;	IR_func_LABEL_i <= L_RTYPE_MOVS2I;
--			elsif IR_func = RTYPE_MOVF	then	aluOpcode_i <= OP_MOVF;		IR_func_LABEL_i <= L_RTYPE_MOVF;
--			elsif IR_func = RTYPE_MOVD	then	aluOpcode_i <= OP_MOVD;		IR_func_LABEL_i <= L_RTYPE_MOVD;
--			elsif IR_func = RTYPE_MOVFP2I	then	aluOpcode_i <= OP_MOVFP2I;	IR_func_LABEL_i <= L_RTYPE_MOVFP2I;
--			elsif IR_func = RTYPE_MOVI2FP	then	aluOpcode_i <= OP_MOVI2FP;	IR_func_LABEL_i <= L_RTYPE_MOVI2FP;
--			elsif IR_func = RTYPE_MOVI2T	then	aluOpcode_i <= OP_MOVI2T;	IR_func_LABEL_i <= L_RTYPE_MOVI2T;
--			elsif IR_func = RTYPE_MOVT2I	then	aluOpcode_i <= OP_MOVT2I;	IR_func_LABEL_i <= L_RTYPE_MOVT2I;
--			elsif IR_func = RTYPE_SLTU	then	aluOpcode_i <= OP_SLTU;		IR_func_LABEL_i <= L_RTYPE_SLTU;
--			elsif IR_func = RTYPE_SGTU	then	aluOpcode_i <= OP_SGTU;		IR_func_LABEL_i <= L_RTYPE_SGTU;
--			elsif IR_func = RTYPE_SLEU	then	aluOpcode_i <= OP_SLEU;		IR_func_LABEL_i <= L_RTYPE_SLEU;
--			elsif IR_func = RTYPE_SGEU	then	aluOpcode_i <= OP_SGEU;		IR_func_LABEL_i <= L_RTYPE_SGEU;
--			elsif IR_func = RTYPE_ADDF	then	aluOpcode_i <= OP_ADDF;		IR_func_LABEL_i <= L_RTYPE_ADDF;
--			elsif IR_func = RTYPE_SUBF	then	aluOpcode_i <= OP_SUBF;		IR_func_LABEL_i <= L_RTYPE_SUBF;
--			elsif IR_func = RTYPE_MULTF	then	aluOpcode_i <= OP_MULTF;	IR_func_LABEL_i <= L_RTYPE_MULTF;
--			elsif IR_func = RTYPE_DIVF	then	aluOpcode_i <= OP_DIVF;		IR_func_LABEL_i <= L_RTYPE_DIVF;
--			elsif IR_func = RTYPE_ADDD	then	aluOpcode_i <= OP_ADDD;		IR_func_LABEL_i <= L_RTYPE_ADDD;
--			elsif IR_func = RTYPE_SUBD	then	aluOpcode_i <= OP_SUBD;		IR_func_LABEL_i <= L_RTYPE_SUBD;
--			elsif IR_func = RTYPE_MULTD	then	aluOpcode_i <= OP_MULTD;	IR_func_LABEL_i <= L_RTYPE_MULTD;
--			elsif IR_func = RTYPE_DIVD	then	aluOpcode_i <= OP_DIVD;		IR_func_LABEL_i <= L_RTYPE_DIVD;
--			elsif IR_func = RTYPE_CVTF2D	then	aluOpcode_i <= OP_CVTF2D;	IR_func_LABEL_i <= L_RTYPE_CVTF2D;
--			elsif IR_func = RTYPE_CVTF2I	then	aluOpcode_i <= OP_CVTF2I;	IR_func_LABEL_i <= L_RTYPE_CVTF2I;
--			elsif IR_func = RTYPE_CVTD2F	then	aluOpcode_i <= OP_CVTD2F;	IR_func_LABEL_i <= L_RTYPE_CVTD2F;
--			elsif IR_func = RTYPE_CVTD2I	then	aluOpcode_i <= OP_CVTD2I;	IR_func_LABEL_i <= L_RTYPE_CVTD2I;
--			elsif IR_func = RTYPE_CVTI2F	then	aluOpcode_i <= OP_CVTI2F;	IR_func_LABEL_i <= L_RTYPE_CVTI2F;
--			elsif IR_func = RTYPE_CVTI2D	then	aluOpcode_i <= OP_CVTI2D;	IR_func_LABEL_i <= L_RTYPE_CVTI2D;
--			elsif IR_func = RTYPE_MULT	then	aluOpcode_i <= OP_MULT;		IR_func_LABEL_i <= L_RTYPE_MUL;
--			elsif IR_func = RTYPE_DIV	then	aluOpcode_i <= OP_DIV;		IR_func_LABEL_i <= L_RTYPE_DIV;
--			elsif IR_func = RTYPE_EQF	then	aluOpcode_i <= OP_EQF;		IR_func_LABEL_i <= L_RTYPE_EQF;
--			elsif IR_func = RTYPE_NEF	then	aluOpcode_i <= OP_NEF;		IR_func_LABEL_i <= L_RTYPE_NEF;
--			elsif IR_func = RTYPE_LTF	then	aluOpcode_i <= OP_LTF;		IR_func_LABEL_i <= L_RTYPE_LTF;
--			elsif IR_func = RTYPE_GTF	then	aluOpcode_i <= OP_GTF;		IR_func_LABEL_i <= L_RTYPE_GTF;
--			elsif IR_func = RTYPE_LEF	then	aluOpcode_i <= OP_LEF;		IR_func_LABEL_i <= L_RTYPE_LEF;
--			elsif IR_func = RTYPE_GEF	then	aluOpcode_i <= OP_GEF;		IR_func_LABEL_i <= L_RTYPE_GEF;
--			elsif IR_func = RTYPE_MULTU	then	aluOpcode_i <= OP_MULTU;	IR_func_LABEL_i <= L_RTYPE_MULTU;
--			elsif IR_func = RTYPE_DIVU	then	aluOpcode_i <= OP_DIVU;		IR_func_LABEL_i <= L_RTYPE_DIVU;
--			elsif IR_func = RTYPE_EQD	then	aluOpcode_i <= OP_EQD;		IR_func_LABEL_i <= L_RTYPE_EQD;
--			elsif IR_func = RTYPE_NED	then	aluOpcode_i <= OP_NED;		IR_func_LABEL_i <= L_RTYPE_NED;
--			elsif IR_func = RTYPE_LTD	then	aluOpcode_i <= OP_LTD;		IR_func_LABEL_i <= L_RTYPE_LTD;
--			elsif IR_func = RTYPE_GTD	then	aluOpcode_i <= OP_GTD;		IR_func_LABEL_i <= L_RTYPE_GTD;
--			elsif IR_func = RTYPE_LED	then	aluOpcode_i <= OP_LED;		IR_func_LABEL_i <= L_RTYPE_LED;
--			elsif IR_func = RTYPE_GED	then	aluOpcode_i <= OP_GED;		IR_func_LABEL_i <= L_RTYPE_GED;
			else					aluOpcode_i <= OP_NOP;		IR_func_LABEL_i <= L_RTYPE_NOP;
			end if;

		-- I-Type instructions			-- ALU Operations		-- Operation Labels
		elsif IR_opcode = ITYPE_BEQZ	then	aluOpcode_i <= OP_BEQZ;		IR_opcode_LABEL_i <= L_ITYPE_BEQZ;
		elsif IR_opcode = ITYPE_BNEZ	then	aluOpcode_i <= OP_BNEZ;		IR_opcode_LABEL_i <= L_ITYPE_BNEZ;
--		elsif IR_opcode = ITYPE_BFPT	then	aluOpcode_i <= OP_BFPT;		IR_opcode_LABEL_i <= L_ITYPE_BFPT;
--		elsif IR_opcode = ITYPE_BFPF	then	aluOpcode_i <= OP_BFPF;		IR_opcode_LABEL_i <= L_ITYPE_BFPF;
		elsif IR_opcode = ITYPE_ADDI	then	aluOpcode_i <= OP_ADDI;		IR_opcode_LABEL_i <= L_ITYPE_ADDI;
--		elsif IR_opcode = ITYPE_ADDUI	then	aluOpcode_i <= OP_ADDUI;	IR_opcode_LABEL_i <= L_ITYPE_ADDUI;
		elsif IR_opcode = ITYPE_SUBI	then	aluOpcode_i <= OP_SUBI;		IR_opcode_LABEL_i <= L_ITYPE_SUBI;
--		elsif IR_opcode = ITYPE_SUBUI	then	aluOpcode_i <= OP_SUBUI;	IR_opcode_LABEL_i <= L_ITYPE_SUBUI;
		elsif IR_opcode = ITYPE_ANDI	then	aluOpcode_i <= OP_ANDI;		IR_opcode_LABEL_i <= L_ITYPE_ANDI;
		elsif IR_opcode = ITYPE_ORI	then	aluOpcode_i <= OP_ORI;		IR_opcode_LABEL_i <= L_ITYPE_ORI;
		elsif IR_opcode = ITYPE_XORI	then	aluOpcode_i <= OP_XORI;		IR_opcode_LABEL_i <= L_ITYPE_XORI;
--		elsif IR_opcode = ITYPE_LHI	then	aluOpcode_i <= OP_LHI;		IR_opcode_LABEL_i <= L_ITYPE_LHI;
--		elsif IR_opcode = ITYPE_RFE	then	aluOpcode_i <= OP_RFE;		IR_opcode_LABEL_i <= L_ITYPE_RFE;
--		elsif IR_opcode = ITYPE_TRAP	then	aluOpcode_i <= OP_TRAP;		IR_opcode_LABEL_i <= L_ITYPE_TRAP;
--		elsif IR_opcode = ITYPE_JR	then	aluOpcode_i <= OP_JR;		IR_opcode_LABEL_i <= L_ITYPE_JR;
--		elsif IR_opcode = ITYPE_JALR	then	aluOpcode_i <= OP_JALR;		IR_opcode_LABEL_i <= L_ITYPE_JALR;
		elsif IR_opcode = ITYPE_SLLI	then	aluOpcode_i <= OP_SLLI;		IR_opcode_LABEL_i <= L_ITYPE_SLLI;
		elsif IR_opcode = ITYPE_NOP	then	aluOpcode_i <= OP_NOP;		IR_opcode_LABEL_i <= L_ITYPE_NOP;
		elsif IR_opcode = ITYPE_SRLI	then	aluOpcode_i <= OP_SRLI;		IR_opcode_LABEL_i <= L_ITYPE_SRLI;
--		elsif IR_opcode = ITYPE_SRAI	then	aluOpcode_i <= OP_SRAI;		IR_opcode_LABEL_i <= L_ITYPE_SRAI;
--		elsif IR_opcode = ITYPE_SEQI	then	aluOpcode_i <= OP_SEQI;		IR_opcode_LABEL_i <= L_ITYPE_SEQI;
		elsif IR_opcode = ITYPE_SNEI	then	aluOpcode_i <= OP_SNEI;		IR_opcode_LABEL_i <= L_ITYPE_SNEI;
--		elsif IR_opcode = ITYPE_SLTI	then	aluOpcode_i <= OP_SLTI;		IR_opcode_LABEL_i <= L_ITYPE_SLTI;
--		elsif IR_opcode = ITYPE_SGTI	then	aluOpcode_i <= OP_SGTI;		IR_opcode_LABEL_i <= L_ITYPE_SGTI;
		elsif IR_opcode = ITYPE_SLEI	then	aluOpcode_i <= OP_SLEI;		IR_opcode_LABEL_i <= L_ITYPE_SLEI;
		elsif IR_opcode = ITYPE_SGEI	then	aluOpcode_i <= OP_SGEI;		IR_opcode_LABEL_i <= L_ITYPE_SGEI;
--		elsif IR_opcode = ITYPE_LB	then	aluOpcode_i <= OP_LB;		IR_opcode_LABEL_i <= L_ITYPE_LB;
--		elsif IR_opcode = ITYPE_LH	then	aluOpcode_i <= OP_LH;		IR_opcode_LABEL_i <= L_ITYPE_LH;
		elsif IR_opcode = ITYPE_LW	then	aluOpcode_i <= OP_LW;		IR_opcode_LABEL_i <= L_ITYPE_LW;
--		elsif IR_opcode = ITYPE_LBU	then	aluOpcode_i <= OP_LBU;		IR_opcode_LABEL_i <= L_ITYPE_LBU;
--		elsif IR_opcode = ITYPE_LHU	then	aluOpcode_i <= OP_LHU;		IR_opcode_LABEL_i <= L_ITYPE_LHU;
--		elsif IR_opcode = ITYPE_LF	then	aluOpcode_i <= OP_LF;		IR_opcode_LABEL_i <= L_ITYPE_LF;
--		elsif IR_opcode = ITYPE_LD	then	aluOpcode_i <= OP_LD;		IR_opcode_LABEL_i <= L_ITYPE_LD;
--		elsif IR_opcode = ITYPE_SB	then	aluOpcode_i <= OP_SB;		IR_opcode_LABEL_i <= L_ITYPE_SB;
--		elsif IR_opcode = ITYPE_SH	then	aluOpcode_i <= OP_SH;		IR_opcode_LABEL_i <= L_ITYPE_SH;
		elsif IR_opcode = ITYPE_SW	then	aluOpcode_i <= OP_SW;		IR_opcode_LABEL_i <= L_ITYPE_SW;
--		elsif IR_opcode = ITYPE_SF	then	aluOpcode_i <= OP_SF;		IR_opcode_LABEL_i <= L_ITYPE_SF;
--		elsif IR_opcode = ITYPE_SD	then	aluOpcode_i <= OP_SD;		IR_opcode_LABEL_i <= L_ITYPE_SD;
--		elsif IR_opcode = ITYPE_ITLB	then	aluOpcode_i <= OP_ITLB;		IR_opcode_LABEL_i <= L_ITYPE_ITLB;
--		elsif IR_opcode = ITYPE_SLTUI	then	aluOpcode_i <= OP_SLTUI;	IR_opcode_LABEL_i <= L_ITYPE_SLTUI;
--		elsif IR_opcode = ITYPE_SGTUI	then	aluOpcode_i <= OP_SGTUI;	IR_opcode_LABEL_i <= L_ITYPE_SGTUI;
--		elsif IR_opcode = ITYPE_SLEUI	then	aluOpcode_i <= OP_SLEUI;	IR_opcode_LABEL_i <= L_ITYPE_SLEUI;
--		elsif IR_opcode = ITYPE_SGEUI	then	aluOpcode_i <= OP_SGEUI;	IR_opcode_LABEL_i <= L_ITYPE_SGEUI;

		-- J-Type instructions
		elsif IR_opcode = JTYPE_J	then	aluOpcode_i <= OP_J;		IR_opcode_LABEL_i <= L_JTYPE_J;
		elsif IR_opcode = JTYPE_JAL	then	aluOpcode_i <= OP_JAL;		IR_opcode_LABEL_i <= L_JTYPE_JAL;

		else					aluOpcode_i <= OP_NOP;		IR_opcode_LABEL_i <= L_ITYPE_NOP;
		end if;

	end process ALU_OP_CODE_P;


	-- Process for managing pipeline control words
	CW_PIPE: process (CLK, RST)
	begin
		if RST = '0' then			-- Asynchronous Reset (active low)

			cw1 <= (others => '0');
			cw2 <= (others => '0');
			cw3 <= (others => '0');
			cw4 <= (others => '0');
			cw5 <= (others => '0');
			
			aluOpcode1 <= OP_NOP;
			aluOpcode2 <= OP_NOP;
			aluOpcode3 <= OP_NOP;

			IR_opcode_LABEL1 <= L_ITYPE_NOP;
			IR_opcode_LABEL2 <= L_ITYPE_NOP;
			IR_opcode_LABEL3 <= L_ITYPE_NOP;

			IR_func_LABEL1 <= L_RTYPE_NOP;
			IR_func_LABEL2 <= L_RTYPE_NOP;
			IR_func_LABEL3 <= L_RTYPE_NOP;

		elsif CLK'event and CLK = '1' then	-- Rising Clock Edge

			cw1 <= cw_mem(conv_integer(IR_opcode));			-- first stage
			cw2 <= cw1(CW_SIZE - 1 - 2 downto 0);			-- second stage
			cw3 <= cw2(CW_SIZE - 1 - 5 downto 0);			-- third stage
			cw4 <= cw3(CW_SIZE - 1 - 11 downto 0);			-- fourth stage
			cw5 <= cw4(CW_SIZE - 1 - 17 downto 0);			-- fifth stage

			aluOpcode1 <= aluOpcode_i;
			aluOpcode2 <= aluOpcode1;
			aluOpcode3 <= aluOpcode2;

			IR_opcode_LABEL1 <= IR_opcode_LABEL_i;
			IR_opcode_LABEL2 <= IR_opcode_LABEL1;
			IR_opcode_LABEL3 <= IR_opcode_LABEL2;

			IR_func_LABEL1 <= IR_func_LABEL_i;
			IR_func_LABEL2 <= IR_func_LABEL1;
			IR_func_LABEL3 <= IR_func_LABEL2;

		end if;
	end process CW_PIPE;

	ALU_OPCODE <= aluOpcode3;

end DLX_CU_HW;
