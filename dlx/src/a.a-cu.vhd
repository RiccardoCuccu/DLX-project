----------------------------------------------------------------------------------------------------
-- Description:	This module serves as the Hardwired Control Unit (CU) for a DLX processor.
--		It takes an instruction from the Instruction Register (IR) as input and generates
--		control signals for various datapath elements across five pipeline stages.
--		These control signals are generated based on opcode and function fields.
--
-- Author:	Riccardo Cuccu
-- Date:	2023/09/10
----------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.constants.all;

entity DLX_CU is

	generic (	MICROCODE_MEM_SIZE	: integer := MMEM_SIZE_GLOBAL;		-- Microcode Memory Size
			FUNC_SIZE		: integer := FUNC_SIZE_GLOBAL;		-- Func Field Size for R-Type Ops
			OP_CODE_SIZE		: integer := OPC_SIZE_GLOBAL;		-- Op Code Size
--			ALU_OPC_SIZE		: integer := OPC_SIZE_GLOBAL;		-- ALU Op Code Size
--			ALU_SIZE		: integer := ALU_OP_SIZE_GLOBAL;	-- ALU Operands Size
			IR_SIZE			: integer := IR_SIZE_GLOBAL;		-- Instruction Register Size
			CW_SIZE			: integer := CW_SIZE_GLOBAL);		-- Control Word Size

	port (		CLK			: in  std_logic;	-- Clock
			RST			: in  std_logic;	-- Reset (active low)

			-- Instruction Register
			IR_IN			: in  std_logic_vector(IR_SIZE - 1 downto 0);

			-- IF Control Signal
			IR_LATCH_EN		: out std_logic;	-- Instruction Register Latch Enable
			PC_LATCH_EN		: out std_logic;	-- Program Counter Latch Enable
			NPC_LATCH_EN		: out std_logic;	-- Next Program Counter Register Latch Enable

			-- ID Control Signals
			RF_WE			: out std_logic;	-- Register File Write Enable
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
			DRAM_RE			: out std_logic;	-- Data RAM Read Enable
			DRAM_WE			: out std_logic;	-- Data RAM Write Enable
			LMD_LATCH_EN		: out std_logic;	-- LMD Register Latch Enable
			JUMP_EN			: out std_logic;	-- JUMP Enable Signal for PC input MUX
			JUMP_COND		: out std_logic;	-- JUMP Condition

			-- WB Control signals
			WB_MUX_SEL		: out std_logic);	-- Write Back MUX Sel

end DLX_CU;


architecture DLX_CU_HW of DLX_CU is

	type mem_array is array (integer range 0 to MICROCODE_MEM_SIZE - 1) of std_logic_vector(CW_SIZE - 1 downto 0);

	-- look-up table (* = BASIC DLX; ** = PRO DLX)
	signal cw_mem : mem_array := (	

					"111" & "1110" & "0010" & "00000" & "1",		-- x"00" RTYPE	*
					"000" & "0000" & "0000" & "00000" & "0",		-- x"01"
					"111" & "0001" & "1110" & "00001" & "1",		-- x"02" J	*
					"111" & "1001" & "1110" & "00001" & "1",		-- x"03" JAL	*
					"111" & "0101" & "1110" & "00010" & "1",		-- x"04" BEQZ	*
					"111" & "0101" & "1111" & "00010" & "1",		-- x"05" BNEZ	*
					"000" & "0000" & "0000" & "00000" & "0",		-- x"06" BFPT	/
					"000" & "0000" & "0000" & "00000" & "0",		-- x"07" BFPF	/
					"111" & "1101" & "0110" & "00000" & "1",		-- x"08" ADDI	*
					"111" & "1101" & "0110" & "00000" & "1",		-- x"09" ADDUI	**
					"111" & "1101" & "0110" & "00000" & "1",		-- x"0A" SUBI	*
					"111" & "1101" & "0110" & "00000" & "1",		-- x"0B" SUBUI	**
					"111" & "1101" & "0110" & "00000" & "1",		-- x"0C" ANDI	*
					"111" & "1101" & "0110" & "00000" & "1",		-- x"0D" ORI	*
					"111" & "1101" & "0110" & "00000" & "1",		-- x"0E" XORI	*
					"111" & "1001" & "0110" & "00000" & "1",		-- x"0F" LHI	/

					"000" & "0000" & "0000" & "00000" & "0",		-- x"10" RFE	/
					"000" & "0000" & "0000" & "00000" & "0",		-- x"11" TRAP	/
					"000" & "0000" & "0000" & "00000" & "0",		-- x"12" JR	/
					"000" & "0000" & "0000" & "00000" & "0",		-- x"13" JALR	/
					"111" & "1101" & "0110" & "00000" & "1",		-- x"14" SLLI	*
					"000" & "0000" & "0000" & "00000" & "1",		-- x"15" NOP	*
					"111" & "1101" & "0110" & "00000" & "1",		-- x"16" SRLI	*
					"111" & "1101" & "0110" & "00000" & "1",		-- x"17" SRAI	**
					"111" & "1101" & "0110" & "00000" & "1",		-- x"18" SEQI	**
					"111" & "1101" & "0110" & "00000" & "1",		-- x"19" SNEI	*
					"111" & "1101" & "0110" & "00000" & "1",		-- x"1A" SLTI	**
					"111" & "1101" & "0110" & "00000" & "1",		-- x"1B" SGTI	**
					"111" & "1101" & "0110" & "00000" & "1",		-- x"1C" SLEI	*
					"111" & "1101" & "0110" & "00000" & "1",		-- x"1D" SGEI	*
					"000" & "0000" & "0000" & "00000" & "0",		-- x"1E"
					"000" & "0000" & "0000" & "00000" & "0",		-- x"1F"

					"000" & "0000" & "0000" & "00000" & "0",		-- x"20" LB	/
					"000" & "0000" & "0000" & "00000" & "0",		-- x"21" LH	/
					"000" & "0000" & "0000" & "00000" & "0",		-- x"22"
					"111" & "1101" & "0110" & "10100" & "0",		-- x"23" LW	*
					"000" & "0000" & "0000" & "00000" & "0",		-- x"24" LBU	/
					"000" & "0000" & "0000" & "00000" & "0",		-- x"25" LHU	/
					"000" & "0000" & "0000" & "00000" & "0",		-- x"26" LF	/
					"000" & "0000" & "0000" & "00000" & "0",		-- x"27" LD	/
					"000" & "0000" & "0000" & "00000" & "0",		-- x"28" SB	/
					"000" & "0000" & "0000" & "00000" & "0",		-- x"29" SH	/
					"000" & "0000" & "0000" & "00000" & "0",		-- x"2A"
					"111" & "0101" & "0110" & "01000" & "1",		-- x"2B" SW	*
					"000" & "0000" & "0000" & "00000" & "0",		-- x"2C"
					"000" & "0000" & "0000" & "00000" & "0",		-- x"2D"
					"000" & "0000" & "0000" & "00000" & "0",		-- x"2E" SF	/
					"000" & "0000" & "0000" & "00000" & "0",		-- x"2F" SD	/

					"000" & "0000" & "0000" & "00000" & "0",		-- x"30"
					"000" & "0000" & "0000" & "00000" & "0",		-- x"31"
					"000" & "0000" & "0000" & "00000" & "0",		-- x"32"
					"000" & "0000" & "0000" & "00000" & "0",		-- x"33"
					"000" & "0000" & "0000" & "00000" & "0",		-- x"34"
					"000" & "0000" & "0000" & "00000" & "0",		-- x"35"
					"000" & "0000" & "0000" & "00000" & "0",		-- x"36"
					"000" & "0000" & "0000" & "00000" & "0",		-- x"37"
					"000" & "0000" & "0000" & "00000" & "0",		-- x"38" ITLB	/
					"000" & "0000" & "0000" & "00000" & "0",		-- x"39"
					"111" & "1101" & "0110" & "00000" & "1",		-- x"3A" SLTUI	**
					"111" & "1101" & "0110" & "00000" & "1",		-- x"3B" SGTUI	**
					"111" & "1101" & "0110" & "00000" & "1",		-- x"3C" SLEUI	**
					"111" & "1101" & "0110" & "00000" & "1",		-- x"3D" SGEUI	**
					"000" & "0000" & "0000" & "00000" & "0",		-- x"3E"
					"000" & "0000" & "0000" & "00000" & "0");		-- x"3F"

	--signal IR_opcode : std_logic_vector(OP_CODE_SIZE - 1 downto 0);		-- OpCode part of IR
	--signal IR_func   : std_logic_vector(FUNC_SIZE - 1 downto 0);			-- Func part of IR when Rtype

	signal IR_opcode : std_logic_vector(5 downto 0);				-- OpCode part of IR
	signal IR_func   : std_logic_vector(10 downto 0);				-- Func part of IR when Rtype
	signal cw1       : std_logic_vector(CW_SIZE - 1 downto 0);			-- full control word read from cw_mem

	-- control words
--	signal cw1 : std_logic_vector(CW_SIZE - 1 downto 0);				-- first stage		/ 3 signals
	signal cw2 : std_logic_vector(CW_SIZE - 1 - 3 downto 0);			-- second stage		/ 4 signals
	signal cw3 : std_logic_vector(CW_SIZE - 1 - 7 downto 0);			-- third stage		/ 4 signals
	signal cw4 : std_logic_vector(CW_SIZE - 1 - 11 downto 0);			-- fourth stage		/ 6 signals
	signal cw5 : std_logic_vector(CW_SIZE - 1 - 16 downto 0);			-- fifth stage		/ 1 signals

	signal aluOpcode1 : aluOp := OP_NOP;	-- ALUOP defined in package
	signal aluOpcode2 : aluOp := OP_NOP;
	signal aluOpcode3 : aluOp := OP_NOP;

--	signal aluOpcode1 : std_logic_vector(ALU_OPC_SIZE - 1 downto 0) := ITYPE_NOP;
--	signal aluOpcode2 : std_logic_vector(ALU_OPC_SIZE - 1 downto 0) := ITYPE_NOP;
--	signal aluOpcode3 : std_logic_vector(ALU_OPC_SIZE - 1 downto 0) := ITYPE_NOP;

	-- testbench signals

	signal IR_opcode_LABEL1 : ALU_label;
	signal IR_opcode_LABEL2 : ALU_label;
	signal IR_opcode_LABEL3 : ALU_label;
	signal IR_opcode_LABEL4 : ALU_label;
	signal IR_opcode_LABEL5 : ALU_label;

	signal IR_func_LABEL1 : ALU_label;
	signal IR_func_LABEL2 : ALU_label;
	signal IR_func_LABEL3 : ALU_label;
	signal IR_func_LABEL4 : ALU_label;
	signal IR_func_LABEL5 : ALU_label;

begin

	-- Extract Opcode and Function fields from the incoming instruction
	IR_opcode	<= IR_IN(IR_SIZE - 1 downto IR_SIZE - OP_CODE_SIZE);
	IR_func		<= IR_IN(FUNC_SIZE - 1 downto 0);
	cw1		<= cw_mem(conv_integer(IR_opcode));

	-- Generate IF stage control signals
	IR_LATCH_EN	<= cw1(CW_SIZE - 1);
	PC_LATCH_EN	<= cw1(CW_SIZE - 2);
	NPC_LATCH_EN	<= cw1(CW_SIZE - 3);

	-- Generate ID stage control signals
	RF_WE		<= cw2(CW_SIZE - 4);
	RegA_LATCH_EN	<= cw2(CW_SIZE - 5);
	RegB_LATCH_EN	<= cw2(CW_SIZE - 6);
	RegIMM_LATCH_EN	<= cw2(CW_SIZE - 7);

	-- Generate EX stage control signals
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

	-- Generate WB stage control signals
	WB_MUX_SEL	<= cw5(CW_SIZE - 17);

	-- Process for generating ALU operations and labels
	ALU_OP_CODE_P: process (RST, IR_opcode, IR_func)
	begin
		if RST = '0' then
			aluOpcode1 <= OP_NOP;
			IR_func_LABEL1 <= L_RTYPE_NOP;
			IR_opcode_LABEL1 <= L_RTYPE_NOP;

		-- R-Type instructions				-- ALU Operations		-- Operation Labels
		elsif IR_opcode = RTYPE then 							IR_opcode_LABEL1 <= L_RTYPE;
			if IR_func = RTYPE_SLL		then	aluOpcode1 <= OP_SLL;		IR_func_LABEL1 <= L_RTYPE_SLL;
			elsif IR_func = RTYPE_SRL	then	aluOpcode1 <= OP_SRL;		IR_func_LABEL1 <= L_RTYPE_SRL;
			elsif IR_func = RTYPE_SRA	then	aluOpcode1 <= OP_SRA;		IR_func_LABEL1 <= L_RTYPE_SRA;
			elsif IR_func = RTYPE_ADD	then	aluOpcode1 <= OP_ADD;		IR_func_LABEL1 <= L_RTYPE_ADD;
			elsif IR_func = RTYPE_ADDU	then	aluOpcode1 <= OP_ADDU;		IR_func_LABEL1 <= L_RTYPE_ADDU;
			elsif IR_func = RTYPE_SUB	then	aluOpcode1 <= OP_SUB;		IR_func_LABEL1 <= L_RTYPE_SUB;
			elsif IR_func = RTYPE_SUBU	then	aluOpcode1 <= OP_SUBU;		IR_func_LABEL1 <= L_RTYPE_SUBU;
			elsif IR_func = RTYPE_AND	then	aluOpcode1 <= OP_AND;		IR_func_LABEL1 <= L_RTYPE_AND;
			elsif IR_func = RTYPE_OR	then	aluOpcode1 <= OP_OR;		IR_func_LABEL1 <= L_RTYPE_OR;
			elsif IR_func = RTYPE_XOR	then	aluOpcode1 <= OP_XOR;		IR_func_LABEL1 <= L_RTYPE_XOR;
			elsif IR_func = RTYPE_SEQ	then	aluOpcode1 <= OP_SEQ;		IR_func_LABEL1 <= L_RTYPE_SEQ;
			elsif IR_func = RTYPE_SNE	then	aluOpcode1 <= OP_SNE;		IR_func_LABEL1 <= L_RTYPE_SNE;
			elsif IR_func = RTYPE_SLT	then	aluOpcode1 <= OP_SLT;		IR_func_LABEL1 <= L_RTYPE_SLT;
			elsif IR_func = RTYPE_SGT	then	aluOpcode1 <= OP_SGT;		IR_func_LABEL1 <= L_RTYPE_SGT;
			elsif IR_func = RTYPE_SLE	then	aluOpcode1 <= OP_SLE;		IR_func_LABEL1 <= L_RTYPE_SLE;
			elsif IR_func = RTYPE_SGE	then	aluOpcode1 <= OP_SGE;		IR_func_LABEL1 <= L_RTYPE_SGE;
--			elsif IR_func = RTYPE_MOVI2S	then	aluOpcode1 <= OP_MOVI2S;	IR_func_LABEL1 <= L_RTYPE_MOVI2S;
--			elsif IR_func = RTYPE_MOVS2I	then	aluOpcode1 <= OP_MOVS2I;	IR_func_LABEL1 <= L_RTYPE_MOVS2I;
--			elsif IR_func = RTYPE_MOVF	then	aluOpcode1 <= OP_MOVF;		IR_func_LABEL1 <= L_RTYPE_MOVF;
--			elsif IR_func = RTYPE_MOVD	then	aluOpcode1 <= OP_MOVD;		IR_func_LABEL1 <= L_RTYPE_MOVD;
--			elsif IR_func = RTYPE_MOVFP2I	then	aluOpcode1 <= OP_MOVFP2I;	IR_func_LABEL1 <= L_RTYPE_MOVFP2I;
--			elsif IR_func = RTYPE_MOVI2FP	then	aluOpcode1 <= OP_MOVI2FP;	IR_func_LABEL1 <= L_RTYPE_MOVI2FP;
--			elsif IR_func = RTYPE_MOVI2T	then	aluOpcode1 <= OP_MOVI2T;	IR_func_LABEL1 <= L_RTYPE_MOVI2T;
--			elsif IR_func = RTYPE_MOVT2I	then	aluOpcode1 <= OP_MOVT2I;	IR_func_LABEL1 <= L_RTYPE_MOVT2I;
			elsif IR_func = RTYPE_SLTU	then	aluOpcode1 <= OP_SLTU;		IR_func_LABEL1 <= L_RTYPE_SLTU;
			elsif IR_func = RTYPE_SGTU	then	aluOpcode1 <= OP_SGTU;		IR_func_LABEL1 <= L_RTYPE_SGTU;
			elsif IR_func = RTYPE_SLEU	then	aluOpcode1 <= OP_SLEU;		IR_func_LABEL1 <= L_RTYPE_SLEU;
			elsif IR_func = RTYPE_SGEU	then	aluOpcode1 <= OP_SGEU;		IR_func_LABEL1 <= L_RTYPE_SGEU;
--			elsif IR_func = RTYPE_ADDF	then	aluOpcode1 <= OP_ADDF;		IR_func_LABEL1 <= L_RTYPE_ADDF;
--			elsif IR_func = RTYPE_SUBF	then	aluOpcode1 <= OP_SUBF;		IR_func_LABEL1 <= L_RTYPE_SUBF;
--			elsif IR_func = RTYPE_MULTF	then	aluOpcode1 <= OP_MULTF;		IR_func_LABEL1 <= L_RTYPE_MULTF;
--			elsif IR_func = RTYPE_DIVF	then	aluOpcode1 <= OP_DIVF;		IR_func_LABEL1 <= L_RTYPE_DIVF;
--			elsif IR_func = RTYPE_ADDD	then	aluOpcode1 <= OP_ADDD;		IR_func_LABEL1 <= L_RTYPE_ADDD;
--			elsif IR_func = RTYPE_SUBD	then	aluOpcode1 <= OP_SUBD;		IR_func_LABEL1 <= L_RTYPE_SUBD;
--			elsif IR_func = RTYPE_MULTD	then	aluOpcode1 <= OP_MULTD;		IR_func_LABEL1 <= L_RTYPE_MULTD;
--			elsif IR_func = RTYPE_DIVD	then	aluOpcode1 <= OP_DIVD;		IR_func_LABEL1 <= L_RTYPE_DIVD;
--			elsif IR_func = RTYPE_CVTF2D	then	aluOpcode1 <= OP_CVTF2D;	IR_func_LABEL1 <= L_RTYPE_CVTF2D;
--			elsif IR_func = RTYPE_CVTF2I	then	aluOpcode1 <= OP_CVTF2I;	IR_func_LABEL1 <= L_RTYPE_CVTF2I;
--			elsif IR_func = RTYPE_CVTD2F	then	aluOpcode1 <= OP_CVTD2F;	IR_func_LABEL1 <= L_RTYPE_CVTD2F;
--			elsif IR_func = RTYPE_CVTD2I	then	aluOpcode1 <= OP_CVTD2I;	IR_func_LABEL1 <= L_RTYPE_CVTD2I;
--			elsif IR_func = RTYPE_CVTI2F	then	aluOpcode1 <= OP_CVTI2F;	IR_func_LABEL1 <= L_RTYPE_CVTI2F;
--			elsif IR_func = RTYPE_CVTI2D	then	aluOpcode1 <= OP_CVTI2D;	IR_func_LABEL1 <= L_RTYPE_CVTI2D;
--			elsif IR_func = RTYPE_MULT	then	aluOpcode1 <= OP_MULT;		IR_func_LABEL1 <= L_RTYPE_MUL;
--			elsif IR_func = RTYPE_DIV	then	aluOpcode1 <= OP_DIV;		IR_func_LABEL1 <= L_RTYPE_DIV;
--			elsif IR_func = RTYPE_EQF	then	aluOpcode1 <= OP_EQF;		IR_func_LABEL1 <= L_RTYPE_EQF;
--			elsif IR_func = RTYPE_NEF	then	aluOpcode1 <= OP_NEF;		IR_func_LABEL1 <= L_RTYPE_NEF;
--			elsif IR_func = RTYPE_LTF	then	aluOpcode1 <= OP_LTF;		IR_func_LABEL1 <= L_RTYPE_LTF;
--			elsif IR_func = RTYPE_GTF	then	aluOpcode1 <= OP_GTF;		IR_func_LABEL1 <= L_RTYPE_GTF;
--			elsif IR_func = RTYPE_LEF	then	aluOpcode1 <= OP_LEF;		IR_func_LABEL1 <= L_RTYPE_LEF;
--			elsif IR_func = RTYPE_GEF	then	aluOpcode1 <= OP_GEF;		IR_func_LABEL1 <= L_RTYPE_GEF;
--			elsif IR_func = RTYPE_MULTU	then	aluOpcode1 <= OP_MULTU;		IR_func_LABEL1 <= L_RTYPE_MULTU;
--			elsif IR_func = RTYPE_DIVU	then	aluOpcode1 <= OP_DIVU;		IR_func_LABEL1 <= L_RTYPE_DIVU;
--			elsif IR_func = RTYPE_EQD	then	aluOpcode1 <= OP_EQD;		IR_func_LABEL1 <= L_RTYPE_EQD;
--			elsif IR_func = RTYPE_NED	then	aluOpcode1 <= OP_NED;		IR_func_LABEL1 <= L_RTYPE_NED;
--			elsif IR_func = RTYPE_LTD	then	aluOpcode1 <= OP_LTD;		IR_func_LABEL1 <= L_RTYPE_LTD;
--			elsif IR_func = RTYPE_GTD	then	aluOpcode1 <= OP_GTD;		IR_func_LABEL1 <= L_RTYPE_GTD;
--			elsif IR_func = RTYPE_LED	then	aluOpcode1 <= OP_LED;		IR_func_LABEL1 <= L_RTYPE_LED;
--			elsif IR_func = RTYPE_GED	then	aluOpcode1 <= OP_GED;		IR_func_LABEL1 <= L_RTYPE_GED;
			else					aluOpcode1 <= OP_NOP;		IR_func_LABEL1 <= L_RTYPE_NOP;
			end if;

		-- I-Type instructions			-- ALU Operations		-- Operation Labels
		elsif IR_opcode = ITYPE_BEQZ	then	aluOpcode1 <= OP_BEQZ;		IR_opcode_LABEL1 <= L_ITYPE_BEQZ;	IR_func_LABEL1 <= L_ITYPE;
		elsif IR_opcode = ITYPE_BNEZ	then	aluOpcode1 <= OP_BNEZ;		IR_opcode_LABEL1 <= L_ITYPE_BNEZ;	IR_func_LABEL1 <= L_ITYPE;
--		elsif IR_opcode = ITYPE_BFPT	then	aluOpcode1 <= OP_BFPT;		IR_opcode_LABEL1 <= L_ITYPE_BFPT;	IR_func_LABEL1 <= L_ITYPE;
--		elsif IR_opcode = ITYPE_BFPF	then	aluOpcode1 <= OP_BFPF;		IR_opcode_LABEL1 <= L_ITYPE_BFPF;	IR_func_LABEL1 <= L_ITYPE;
		elsif IR_opcode = ITYPE_ADDI	then	aluOpcode1 <= OP_ADDI;		IR_opcode_LABEL1 <= L_ITYPE_ADDI;	IR_func_LABEL1 <= L_ITYPE;
		elsif IR_opcode = ITYPE_ADDUI	then	aluOpcode1 <= OP_ADDUI;		IR_opcode_LABEL1 <= L_ITYPE_ADDUI;	IR_func_LABEL1 <= L_ITYPE;
		elsif IR_opcode = ITYPE_SUBI	then	aluOpcode1 <= OP_SUBI;		IR_opcode_LABEL1 <= L_ITYPE_SUBI;	IR_func_LABEL1 <= L_ITYPE;
		elsif IR_opcode = ITYPE_SUBUI	then	aluOpcode1 <= OP_SUBUI;		IR_opcode_LABEL1 <= L_ITYPE_SUBUI;	IR_func_LABEL1 <= L_ITYPE;
		elsif IR_opcode = ITYPE_ANDI	then	aluOpcode1 <= OP_ANDI;		IR_opcode_LABEL1 <= L_ITYPE_ANDI;	IR_func_LABEL1 <= L_ITYPE;
		elsif IR_opcode = ITYPE_ORI	then	aluOpcode1 <= OP_ORI;		IR_opcode_LABEL1 <= L_ITYPE_ORI;	IR_func_LABEL1 <= L_ITYPE;
		elsif IR_opcode = ITYPE_XORI	then	aluOpcode1 <= OP_XORI;		IR_opcode_LABEL1 <= L_ITYPE_XORI;	IR_func_LABEL1 <= L_ITYPE;
		elsif IR_opcode = ITYPE_LHI	then	aluOpcode1 <= OP_LHI;		IR_opcode_LABEL1 <= L_ITYPE_LHI;	IR_func_LABEL1 <= L_ITYPE;
--		elsif IR_opcode = ITYPE_RFE	then	aluOpcode1 <= OP_RFE;		IR_opcode_LABEL1 <= L_ITYPE_RFE;	IR_func_LABEL1 <= L_ITYPE;
--		elsif IR_opcode = ITYPE_TRAP	then	aluOpcode1 <= OP_TRAP;		IR_opcode_LABEL1 <= L_ITYPE_TRAP;	IR_func_LABEL1 <= L_ITYPE;
--		elsif IR_opcode = ITYPE_JR	then	aluOpcode1 <= OP_JR;		IR_opcode_LABEL1 <= L_ITYPE_JR;		IR_func_LABEL1 <= L_ITYPE;
--		elsif IR_opcode = ITYPE_JALR	then	aluOpcode1 <= OP_JALR;		IR_opcode_LABEL1 <= L_ITYPE_JALR;	IR_func_LABEL1 <= L_ITYPE;
		elsif IR_opcode = ITYPE_SLLI	then	aluOpcode1 <= OP_SLLI;		IR_opcode_LABEL1 <= L_ITYPE_SLLI;	IR_func_LABEL1 <= L_ITYPE;
		elsif IR_opcode = ITYPE_NOP	then	aluOpcode1 <= OP_NOP;		IR_opcode_LABEL1 <= L_ITYPE_NOP;	IR_func_LABEL1 <= L_ITYPE;
		elsif IR_opcode = ITYPE_SRLI	then	aluOpcode1 <= OP_SRLI;		IR_opcode_LABEL1 <= L_ITYPE_SRLI;	IR_func_LABEL1 <= L_ITYPE;
		elsif IR_opcode = ITYPE_SRAI	then	aluOpcode1 <= OP_SRAI;		IR_opcode_LABEL1 <= L_ITYPE_SRAI;	IR_func_LABEL1 <= L_ITYPE;
		elsif IR_opcode = ITYPE_SEQI	then	aluOpcode1 <= OP_SEQI;		IR_opcode_LABEL1 <= L_ITYPE_SEQI;	IR_func_LABEL1 <= L_ITYPE;
		elsif IR_opcode = ITYPE_SNEI	then	aluOpcode1 <= OP_SNEI;		IR_opcode_LABEL1 <= L_ITYPE_SNEI;	IR_func_LABEL1 <= L_ITYPE;
		elsif IR_opcode = ITYPE_SLTI	then	aluOpcode1 <= OP_SLTI;		IR_opcode_LABEL1 <= L_ITYPE_SLTI;	IR_func_LABEL1 <= L_ITYPE;
		elsif IR_opcode = ITYPE_SGTI	then	aluOpcode1 <= OP_SGTI;		IR_opcode_LABEL1 <= L_ITYPE_SGTI;	IR_func_LABEL1 <= L_ITYPE;
		elsif IR_opcode = ITYPE_SLEI	then	aluOpcode1 <= OP_SLEI;		IR_opcode_LABEL1 <= L_ITYPE_SLEI;	IR_func_LABEL1 <= L_ITYPE;
		elsif IR_opcode = ITYPE_SGEI	then	aluOpcode1 <= OP_SGEI;		IR_opcode_LABEL1 <= L_ITYPE_SGEI;	IR_func_LABEL1 <= L_ITYPE;
--		elsif IR_opcode = ITYPE_LB	then	aluOpcode1 <= OP_LB;		IR_opcode_LABEL1 <= L_ITYPE_LB;		IR_func_LABEL1 <= L_ITYPE;
--		elsif IR_opcode = ITYPE_LH	then	aluOpcode1 <= OP_LH;		IR_opcode_LABEL1 <= L_ITYPE_LH;		IR_func_LABEL1 <= L_ITYPE;
		elsif IR_opcode = ITYPE_LW	then	aluOpcode1 <= OP_LW;		IR_opcode_LABEL1 <= L_ITYPE_LW;		IR_func_LABEL1 <= L_ITYPE;
--		elsif IR_opcode = ITYPE_LBU	then	aluOpcode1 <= OP_LBU;		IR_opcode_LABEL1 <= L_ITYPE_LBU;	IR_func_LABEL1 <= L_ITYPE;
--		elsif IR_opcode = ITYPE_LHU	then	aluOpcode1 <= OP_LHU;		IR_opcode_LABEL1 <= L_ITYPE_LHU;	IR_func_LABEL1 <= L_ITYPE;
--		elsif IR_opcode = ITYPE_LF	then	aluOpcode1 <= OP_LF;		IR_opcode_LABEL1 <= L_ITYPE_LF;		IR_func_LABEL1 <= L_ITYPE;
--		elsif IR_opcode = ITYPE_LD	then	aluOpcode1 <= OP_LD;		IR_opcode_LABEL1 <= L_ITYPE_LD;		IR_func_LABEL1 <= L_ITYPE;
--		elsif IR_opcode = ITYPE_SB	then	aluOpcode1 <= OP_SB;		IR_opcode_LABEL1 <= L_ITYPE_SB;		IR_func_LABEL1 <= L_ITYPE;
--		elsif IR_opcode = ITYPE_SH	then	aluOpcode1 <= OP_SH;		IR_opcode_LABEL1 <= L_ITYPE_SH;		IR_func_LABEL1 <= L_ITYPE;
		elsif IR_opcode = ITYPE_SW	then	aluOpcode1 <= OP_SW;		IR_opcode_LABEL1 <= L_ITYPE_SW;		IR_func_LABEL1 <= L_ITYPE;
--		elsif IR_opcode = ITYPE_SF	then	aluOpcode1 <= OP_SF;		IR_opcode_LABEL1 <= L_ITYPE_SF;		IR_func_LABEL1 <= L_ITYPE;
--		elsif IR_opcode = ITYPE_SD	then	aluOpcode1 <= OP_SD;		IR_opcode_LABEL1 <= L_ITYPE_SD;		IR_func_LABEL1 <= L_ITYPE;
--		elsif IR_opcode = ITYPE_ITLB	then	aluOpcode1 <= OP_ITLB;		IR_opcode_LABEL1 <= L_ITYPE_ITLB;	IR_func_LABEL1 <= L_ITYPE;
		elsif IR_opcode = ITYPE_SLTUI	then	aluOpcode1 <= OP_SLTUI;		IR_opcode_LABEL1 <= L_ITYPE_SLTUI;	IR_func_LABEL1 <= L_ITYPE;
		elsif IR_opcode = ITYPE_SGTUI	then	aluOpcode1 <= OP_SGTUI;		IR_opcode_LABEL1 <= L_ITYPE_SGTUI;	IR_func_LABEL1 <= L_ITYPE;
		elsif IR_opcode = ITYPE_SLEUI	then	aluOpcode1 <= OP_SLEUI;		IR_opcode_LABEL1 <= L_ITYPE_SLEUI;	IR_func_LABEL1 <= L_ITYPE;
		elsif IR_opcode = ITYPE_SGEUI	then	aluOpcode1 <= OP_SGEUI;		IR_opcode_LABEL1 <= L_ITYPE_SGEUI;	IR_func_LABEL1 <= L_ITYPE;

		-- J-Type instructions
		elsif IR_opcode = JTYPE_J	then	aluOpcode1 <= OP_J;		IR_opcode_LABEL1 <= L_JTYPE_J;		IR_func_LABEL1 <= L_JTYPE;
		elsif IR_opcode = JTYPE_JAL	then	aluOpcode1 <= OP_JAL;		IR_opcode_LABEL1 <= L_JTYPE_JAL;	IR_func_LABEL1 <= L_JTYPE;

		else					aluOpcode1 <= OP_NOP;		IR_opcode_LABEL1 <= L_ITYPE_NOP;	IR_func_LABEL1 <= L_ITYPE;
		end if;

	end process ALU_OP_CODE_P;


	-- Process for managing pipeline control words
	CW_PIPE: process (CLK, RST)
	begin
		if RST = '0' then			-- Asynchronous Reset (active low)

--			cw1 <= (others => '0');
			cw2 <= (others => '0');
			cw3 <= (others => '0');
			cw4 <= (others => '0');
			cw5 <= (others => '0');

			aluOpcode2 <= OP_NOP;
			aluOpcode3 <= OP_NOP;

			IR_opcode_LABEL2 <= L_ITYPE_NOP;
			IR_opcode_LABEL3 <= L_ITYPE_NOP;
			IR_opcode_LABEL4 <= L_ITYPE_NOP;
			IR_opcode_LABEL5 <= L_ITYPE_NOP;

			IR_func_LABEL2 <= L_RTYPE_NOP;
			IR_func_LABEL3 <= L_RTYPE_NOP;
			IR_func_LABEL4 <= L_RTYPE_NOP;
			IR_func_LABEL5 <= L_RTYPE_NOP;

		elsif CLK'event and CLK = '1' then	-- Rising Clock Edge

--			cw1 <= cw(CW_SIZE - 1 downto 0);			-- first stage
			cw2 <= cw1(CW_SIZE - 1 - 3 downto 0);			-- second stage
			cw3 <= cw2(CW_SIZE - 1 - 7 downto 0);			-- third stage
			cw4 <= cw3(CW_SIZE - 1 - 11 downto 0);			-- fourth stage
			cw5 <= cw4(CW_SIZE - 1 - 16 downto 0);			-- fifth stage

			aluOpcode2 <= aluOpcode1;
			aluOpcode3 <= aluOpcode2;

			IR_opcode_LABEL2 <= IR_opcode_LABEL1;
			IR_opcode_LABEL3 <= IR_opcode_LABEL2;
			IR_opcode_LABEL4 <= IR_opcode_LABEL3;
			IR_opcode_LABEL5 <= IR_opcode_LABEL4;

			IR_func_LABEL2 <= IR_func_LABEL1;
			IR_func_LABEL3 <= IR_func_LABEL2;
			IR_func_LABEL4 <= IR_func_LABEL3;
			IR_func_LABEL5 <= IR_func_LABEL4;

		end if;
	end process CW_PIPE;

	ALU_OPCODE <= aluOpcode3;

end DLX_CU_HW;
