----------------------------------------------------------------------------------------------------
-- Description:	This module encapsulates the entire datapath of the DLX architecture,
--		including its five pipeline stages: instruction fetch (IF), instruction
--		decode (ID), execution (EX), memory access (MEM) and write-back (WB).
--		The module takes clock and reset signals, along with various control signals
--		that manage the latching and forwarding of data through the pipeline
--		and ensure synchronous operations across all stages.
--
-- Author:	Riccardo Cuccu
-- Date:	2023/09/10
----------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use work.constants.all;

entity DLX_DATAPATH is

	generic (	IR_SIZE			: integer := IR_SIZE_GLOBAL;			-- Instruction Register Size		/ 32 bits
			PC_SIZE			: integer := PC_SIZE_GLOBAL;			-- Program Counter Size			/ 32 bits
			RS_SIZE			: integer := RS_SIZE_GLOBAL;			-- Registers Source Size		/  5 bits
			ALU_SIZE		: integer := ALU_OP_SIZE_GLOBAL;		-- ALU Operands Size			/ 32 bits
			DRAM_SIZE		: integer := DRAM_WORD_SIZE_GLOBAL);		-- DRAM Word Size			/ 32 bits

	port (		CLK			: in  std_logic;				-- Clock
			RST			: in  std_logic;				-- Reset (active low)

			IR_IN			: in  std_logic_vector(IR_SIZE - 1 downto 0);	-- Instruction Register			/ 32 bits
			DRAM_OUT		: in  std_logic_vector(DRAM_SIZE - 1 downto 0); -- DRAM Data Output			/ 32 bits

			-- IF Control Signal
			IR_LATCH_EN		: in  std_logic;				-- Instruction Register Latch Enable
			PC_LATCH_EN		: in  std_logic;				-- Program Counte Latch Enable
			NPC_LATCH_EN		: in  std_logic;				-- Next Program Counter Register Latch Enable

			-- ID Control Signals
			RF_WE			: in  std_logic;				-- Register File Write Enable
			RegA_LATCH_EN		: in  std_logic;				-- Register A Latch Enable
			RegB_LATCH_EN		: in  std_logic;				-- Register B Latch Enable
			RegIMM_LATCH_EN		: in  std_logic;				-- Immediate Register Latch Enable

			-- EX Control Signals
			MUXA_SEL		: in  std_logic;				-- MUX-A Sel
			MUXB_SEL		: in  std_logic;				-- MUX-B Sel
			ALU_OUTREG_EN		: in  std_logic;				-- ALU Output Register Enable
			EQ_COND			: in  std_logic;				-- Branch if (not) Equal to Zero

			-- ALU Operation Code
			ALU_OPCODE		: in  aluOp;					-- choose between implicit or explicit coding, like std_logic_vector(ALU_OPC_SIZE - 1 downto 0);
			--ALU_OPCODE		: in  std_logic_vector(ALU_OPC_SIZE - 1 downto 0);

			-- MEM Control Signals
			DRAM_RE			: in  std_logic;				-- Data RAM Read Enable
			DRAM_WE			: in  std_logic;				-- Data RAM Write Enable
			LMD_LATCH_EN		: in  std_logic;				-- LMD Register Latch Enable
			JUMP_EN			: in  std_logic;				-- JUMP Enable Signal for PC input MUX
			JUMP_COND		: in  std_logic;				-- JUMP Condition

			-- WB Control signals
			WB_MUX_SEL		: in  std_logic;				-- Write Back MUX Sel

			IR_OUT			: out std_logic_vector(IR_SIZE - 1 downto 0);		-- Instruction Register		/ 32 bits
			PC_OUT			: out std_logic_vector(PC_SIZE - 1 downto 0);		-- Program Counter		/ 32 bits
			ALU_OUT			: out std_logic_vector(ALU_SIZE - 1 downto 0);		-- DRAM Address Input		/ 32 bits
			DRAM_IN			: out std_logic_vector(DRAM_SIZE - 1 downto 0));	-- DRAM Data Input		/ 32 bits

end DLX_DATAPATH;


architecture DLX_DATAPATH_ARCH of DLX_DATAPATH is

	----------------------------------------------------------------------------------------------------
	-- Components Declaration
	----------------------------------------------------------------------------------------------------

	-- GLOBALS ----------------------------------------------------------------------------------------------------

	component LD is
	
		port	(	RST		: in  std_logic;				-- Reset (active low)
				EN		: in  std_logic;				-- Enable
				D		: in  std_logic;
				Q		: out std_logic);
	
	end component;

	component LDR is

		generic (	N		: integer := SIZE_GLOBAL);			-- / 32 bits

		port (		RST		: in  std_logic;				-- Reset (active low)
				EN		: in  std_logic;				-- Enable
				REGIN		: in  std_logic_vector(N - 1 downto 0);
				REGOUT		: out std_logic_vector(N - 1 downto 0));

	end component;

	component FFDR is
	
		generic (	N		: integer := SIZE_GLOBAL);			-- / 32 bits
	
		port (		CLK		: in  std_logic;				-- Clock
				RST		: in  std_logic;				-- Reset (active low)
				EN		: in  std_logic;				-- Enable
				REGIN		: in  std_logic_vector(N - 1 downto 0);
				REGOUT		: out std_logic_vector(N - 1 downto 0));

	end component;

	component MUX21 is

		generic	(	N		: integer := SIZE_GLOBAL);			-- / 32 bits

		port	(	A		: in  std_logic_vector(N - 1 downto 0);		-- / 32 bits
				B		: in  std_logic_vector(N - 1 downto 0);		-- / 32 bits
				S		: in  std_logic;				-- /  1 bit
				Y		: out std_logic_vector(N - 1 downto 0));	-- / 32 bits

	end component;

	component MUX41 is

		generic	(	N		: integer := SIZE_GLOBAL);			-- / 32 bits

		port	(	A		: in  std_logic_vector(N - 1 downto 0);		-- / 32 bits
				B		: in  std_logic_vector(N - 1 downto 0);		-- / 32 bits
				C		: in  std_logic_vector(N - 1 downto 0);		-- / 32 bits
				D		: in  std_logic_vector(N - 1 downto 0);		-- / 32 bits
				S		: in  std_logic_vector(1 downto 0);		-- /  2 bits
				Y		: out std_logic_vector(N - 1 downto 0));	-- / 32 bits

	end component;

--	component PC is
--
--		generic (	N		: integer := PC_SIZE_GLOBAL);			-- / 32 bits
--
--		port (		CLK		: in  std_logic;				-- Clock
--				RST		: in  std_logic;				-- Reset (active low)
--				EN		: in  std_logic;				-- Enable
--				REGIN		: in  std_logic_vector(N - 1 downto 0);		-- / 32 bits
--				REGOUT		: out std_logic_vector(N - 1 downto 0));	-- / 32 bits
--
--	end component;
--
--	component IR is
--
--		generic (	N		: integer := IR_SIZE_GLOBAL);			-- / 32 bits
--
--		port (		CLK		: in  std_logic;				-- Clock
--				RST		: in  std_logic;				-- Reset (active low)
--				EN		: in  std_logic;				-- Enable
--				REGIN		: in  std_logic_vector(N - 1 downto 0);		-- / 32 bits
--				REGOUT		: out std_logic_vector(N - 1 downto 0));	-- / 32 bits
--
--	end component;

	-- FETCH ----------------------------------------------------------------------------------------------------

--	component IRAM
--
--		generic (	RAM_DEPTH	: integer := IRAM_SIZE_GLOBAL;			-- / 2^8 bits
--				I_SIZE		: integer := IR_SIZE_GLOBAL);			-- / 32 bits
--
--		port (		RST		: in  std_logic;				-- Clock
--				--CLK		: in  std_logic;				-- Reset (active low)
--				ADDR		: in  std_logic_vector(I_SIZE - 1 downto 0);	-- Address		/ 32 bits
--				DOUT		: out std_logic_vector(I_SIZE - 1 downto 0));	-- Data out		/ 32 bits
--
--	end component;

	-- DECODE ----------------------------------------------------------------------------------------------------

	component RF is

		generic	(	N		: integer := RF_SIZE_GLOBAL;			-- / 32 bits
				NA		: integer := RS_SIZE_GLOBAL);			-- /  5 bits

		port	(	--CLK		: in  std_logic;				-- Clock
				RST		: in  std_logic;				-- Reset (active low)
				EN		: in  std_logic;				-- Enable
				EN_RD1		: in  std_logic;				-- Read Enable 1
				EN_RD2		: in  std_logic;				-- Read Enable 2
				EN_WR		: in  std_logic;				-- Write Enable
				ADD_RD1		: in  std_logic_vector(NA - 1 downto 0);	-- Read Address 1	/  5 bits
				ADD_RD2		: in  std_logic_vector(NA - 1 downto 0);	-- Read Address 2	/  5 bits
				ADD_WR		: in  std_logic_vector(NA - 1 downto 0);	-- Write Address	/  5 bits
				DATAIN		: in  std_logic_vector(N - 1 downto 0);		-- Input data		/ 32 bits
				OUT1		: out std_logic_vector(N - 1 downto 0);		-- Output data 1	/ 32 bits
				OUT2		: out std_logic_vector(N - 1 downto 0));	-- Output data 2	/ 32 bits

	end component;

	component SIGNEX is

		generic (	N 		: integer := IR_SIZE_GLOBAL;			-- / 32 bits
				OPC		: integer := OPC_SIZE_GLOBAL;			-- /  6 bits
				REG 		: integer := RS_SIZE);				-- /  5 bits

		port (		INSTR		: in  std_logic_vector(N - 1 downto 0);		-- Instruction		/ 32 bits
				IMM		: out std_logic_vector(N - 1 downto 0));	-- Immediate		/ 32 bits

	end component;

	component REGADDR is
	
		generic (	N		: integer := IR_SIZE_GLOBAL;			-- / 32 bits
				OPC		: integer := OPC_SIZE_GLOBAL;			-- /  6 bits
				REG		: integer := RS_SIZE_GLOBAL);			-- /  5 bits
	
		port (		INSTR		: in  std_logic_vector(N - 1 downto 0);		-- Instruction		/ 32 bits
				RS1		: out std_logic_vector(REG - 1 downto 0);	-- RS1			/  5 bits
				RS2		: out std_logic_vector(REG - 1 downto 0);	-- RS2			/  5 bits
				RD		: out std_logic_vector(REG - 1 downto 0));	-- RD			/  5 bits
	
	end component;

	-- EXECUTE ----------------------------------------------------------------------------------------------------

	component ALU is

		generic (	N		: integer := ALU_OP_SIZE_GLOBAL;		-- / 32 bits
				NB		: integer := ALU_BLOCK_SIZE_GLOBAL);		-- /  8 bits

		port (		OP1		: in  std_logic_vector(N - 1 downto 0);		-- Operand 1		/ 32 bits
				OP2		: in  std_logic_vector(N - 1 downto 0);		-- Operand 2		/ 32 bits
				OPC		: in  aluOp;					-- Control Signal
				Y		: out std_logic_vector(N - 1 downto 0);		-- Result		/ 32 bits
				Z		: out std_logic);				-- Zero flag	
				--Co		: out std_logic);
				--Ovf		: out std_logic);

	end component;

	component ZERODET is

		generic	(	N		: integer := ALU_OP_SIZE_GLOBAL);

		port	(	A		: in  std_logic_vector(N - 1 downto 0);
				Y		: out std_logic);

	end component;

	-- MEMORY ----------------------------------------------------------------------------------------------------

	component DRAM is

		generic (	N		: integer := DRAM_SIZE_GLOBAL;			-- / 2^8 bits
				NW		: integer := DRAM_WORD_SIZE_GLOBAL);		-- / 32 bits

		port (		CLK		: in  std_logic;				-- Clock
				RST		: in  std_logic;				-- Reset (active low)
				RE		: in  std_logic;				-- Read Enable
				WE		: in  std_logic;				-- Write Enable
				ADDR		: in  std_logic_vector(NW - 1 downto 0);	-- Address		/ 32 bits
				DIN		: in  std_logic_vector(NW - 1 downto 0);	-- Data in		/ 32 bits
				DOUT		: out std_logic_vector(NW - 1 downto 0));	-- Data out		/ 32 bits

	end component;


	component FU is

		generic (	N		: integer := RS_SIZE_GLOBAL);			-- /  5 bits
	
		port (		RS1		: in	std_logic_vector(N - 1 downto 0);	-- Source register 1				/  5 bits
				RS2		: in	std_logic_vector(N - 1 downto 0);	-- Source register 2				/  5 bits
				RD_MEM		: in	std_logic_vector(N - 1 downto 0);	-- Destination Registers at MEM stage		/  5 bits
				RD_WB		: in	std_logic_vector(N - 1 downto 0);	-- Destination Registers at WB stage		/  5 bits
				RF_WE_MEM	: in	std_logic;				-- Register File Write Enable at MEM stage
				RF_WE_WB	: in	std_logic;				-- Register File Write Enable at WB stage
				FORWARD_A	: out	std_logic_vector(1 downto 0);		-- Forward Selector A				/  2 bits
				FORWARD_B	: out	std_logic_vector(1 downto 0));		-- Forward Selector B				/  2 bits

	end component;


	----------------------------------------------------------------------------------------------------
	-- Signals Declaration
	----------------------------------------------------------------------------------------------------

	-- Instruction Register (IR) and Program Counter (PC) declaration
	signal IR_OUTPUT : std_logic_vector(IR_SIZE - 1 downto 0);							-- Instruction Register signal		/ 32 bits
	signal PC_OUTPUT : std_logic_vector(PC_SIZE - 1 downto 0);							-- Program Counter signal		/ 32 bits
	signal NPC_OUT : std_logic_vector(PC_SIZE - 1 downto 0);							-- Next Program Counter signal		/ 32 bits

	-- Instruction Ram Bus signals
--	signal IRam_DOut : std_logic_vector(SIZE_IR - 1 downto 0);

	-- Datapath Bus signals
	signal IR_BUS : std_logic_vector(IR_SIZE - 1 downto 0);								-- Instruction Register Bus		/ 32 bits
	signal PC_BUS : std_logic_vector(PC_SIZE - 1 downto 0);								-- Program Counter Bus			/ 32 bits
	signal NPC_BUS : std_logic_vector(PC_SIZE - 1 downto 0);							-- Next Program Counter Bus		/ 32 bits

	-- FETCH-DECODE (IF_ID) Pipeline signals
	signal IF_ID_NPC, IF_ID_NPC_NEXT : std_logic_vector(PC_SIZE - 1 downto 0);					-- Program Counter signal		/ 32 bits
	signal IF_ID_IR, IF_ID_IR_NEXT : std_logic_vector(IR_SIZE - 1 downto 0);					-- Instruction Register signal		/ 32 bits

	-- DECODE-EXECUTE (ID_EX) Pipeline signals
	signal ID_EX_NPC, ID_EX_NPC_NEXT : std_logic_vector(PC_SIZE - 1 downto 0);					-- Program Counter signal		/ 32 bits
	signal ID_EX_RF_WE, ID_EX_RF_WE_NEXT : std_logic;								-- Register File Write Enable

	signal ID_EX_RS1, ID_EX_RS1_NEXT : std_logic_vector(RS_SIZE - 1 downto 0);					-- Register Source 1			/  5 bits
	signal ID_EX_RS2, ID_EX_RS2_NEXT : std_logic_vector(RS_SIZE - 1 downto 0);					-- Register Source 2			/  5 bits
	signal ID_EX_RD, ID_EX_RD_NEXT : std_logic_vector(RS_SIZE - 1 downto 0);					-- Register File Write Address	/  5 bits
	signal ID_EX_RF_DATAIN, ID_EX_RF_DATAIN_NEXT : std_logic_vector(RF_SIZE_GLOBAL - 1 downto 0);			-- Register File Write Data		/ 32 bits
	signal ID_EX_RF_OUT1, ID_EX_RF_OUT1_NEXT : std_logic_vector(RF_SIZE_GLOBAL - 1 downto 0);			-- Register File Read Data 1		/ 32 bits
	signal ID_EX_RF_OUT2, ID_EX_RF_OUT2_NEXT : std_logic_vector(RF_SIZE_GLOBAL - 1 downto 0);			-- Register File Read Data 2		/ 32 bits
	signal ID_EX_IMM, ID_EX_IMM_NEXT : std_logic_vector(RF_SIZE_GLOBAL - 1 downto 0);				-- Immediate				/ 32 bits

	-- EXECUTE-MEMORY (EX_MEM) Pipeline signals
	signal EX_MEM_RF_WE, EX_MEM_RF_WE_NEXT : std_logic;								-- Register File Write Enable
	signal EX_MEM_BRANCH_DETECT, EX_MEM_BRANCH_DETECT_NEXT : std_logic;						-- Branch Condition
	signal EX_MEM_RD, EX_MEM_RD_NEXT : std_logic_vector(RS_SIZE - 1 downto 0);					-- Register File Write Address	/  5 bits
	signal EX_MEM_RF_OUT2, EX_MEM_RF_OUT2_NEXT : std_logic_vector(RF_SIZE_GLOBAL - 1 downto 0);			-- Register File Read Data 2
	signal EX_MEM_RF_DATAIN, EX_MEM_RF_DATAIN_NEXT : std_logic_vector(RF_SIZE_GLOBAL - 1 downto 0);			-- Register File Write Data		/ 32 bits
	signal EX_MEM_ALU_OUTPUT, EX_MEM_ALU_OUTPUT_NEXT : std_logic_vector(RF_SIZE_GLOBAL - 1 downto 0);		-- ALU Output				/ 32 bits

	-- MEMORY-WRITE BACK (MEM_WB) Pipeline signals
	signal MEM_WB_RF_WE, MEM_WB_RF_WE_NEXT : std_logic;								-- Register File Write Enable
	signal MEM_WB_RD, MEM_WB_RD_NEXT : std_logic_vector(RS_SIZE - 1 downto 0);					-- Register File Write Address	/  5 bits
	signal MEM_WB_ALU_OUTPUT, MEM_WB_ALU_OUTPUT_NEXT : std_logic_vector(RF_SIZE_GLOBAL - 1 downto 0);		-- ALU Output				/ 32 bits
	signal MEM_WB_DRAM_OUTPUT, MEM_WB_DRAM_OUTPUT_NEXT : std_logic_vector(DRAM_WORD_SIZE_GLOBAL - 1 downto 0);		-- DRAM Output 				/ 32 bits

	-- FETCH signals

	-- DECODE signals
	signal RS1, RS2, RD : std_logic_vector(RS_SIZE - 1 downto 0);							-- /  5 bits
	signal RF_OUT1, RF_OUT2 : std_logic_vector(RF_SIZE_GLOBAL - 1 downto 0);					-- / 32 bits
	signal IMM_OUT : std_logic_vector(IR_SIZE_GLOBAL - 1 downto 0);							-- / 32 bits

	-- EXECUTE signals
	signal ZERO_OUT, ZERO_OUT_NEG : std_logic;
	signal BRANCH_DETECT : std_logic;
	signal ALU_ZERO : std_logic;
	signal ALU_PREOP1, ALU_PREOP2, ALU_OP1, ALU_OP2, ALU_OUTPUT : std_logic_vector(RF_SIZE_GLOBAL - 1 downto 0);	-- / 32 bits

	-- MEMORY signals
	signal PC_MUX_SEL : std_logic;
	signal BRANCH_COND : std_logic;
	signal PC_MUXA, PC_MUXB : std_logic_vector(PC_SIZE - 1 downto 0);						-- / 32 bits
--	signal PC_JUMP, REL_JUMP : std_logic_vector(PC_SIZE - 1 downto 0);						-- / 32 bits
	signal DRAM_OUTPUT : std_logic_vector(DRAM_WORD_SIZE_GLOBAL - 1 downto 0);						-- / 32 bits
	signal WB_MUX_OUT : std_logic_vector(DRAM_WORD_SIZE_GLOBAL - 1 downto 0);					-- / 32 bits

	-- Forwarding Unit signals
	signal FORWARD_A, FORWARD_B : std_logic_vector(1 downto 0);							-- /  2 bits

	-- ALU signals (testbench) -- DELETE
	signal IF_ALU_LABEL, ID_ALU_LABEL, EX_ALU_LABEL, MEM_ALU_LABEL, WB_ALU_LABEL : ALU_label;					-- ALU Opcode
	signal IF_ALU_LABEL_NEXT, ID_ALU_LABEL_NEXT, EX_ALU_LABEL_NEXT, MEM_ALU_LABEL_NEXT, WB_ALU_LABEL_NEXT : ALU_label;		-- ALU Opcode
	
	-- ALU Func
	signal IR_opcode : std_logic_vector(5 downto 0);				-- OpCode part of IR
	signal IR_func   : std_logic_vector(10 downto 0);				-- Func part of IR when Rtype


	begin

		-- IRAM
		PC_OUT	<= PC_OUTPUT;
		IR_BUS	<= IR_IN;

		-- CU		
		IR_OUT	<= IR_OUTPUT;

		-- DRAM
		ALU_OUT <= EX_MEM_ALU_OUTPUT;
		DRAM_IN	<= EX_MEM_RF_OUT2;
		DRAM_OUTPUT <= DRAM_OUT;

		----------------------------------------------------------------------------------------------------
		-- LABELS -- DELETE!
		----------------------------------------------------------------------------------------------------

		IR_opcode	<= IR_OUTPUT(IR_SIZE_GLOBAL - 1 downto IR_SIZE_GLOBAL - OPC_SIZE_GLOBAL);
		IR_func		<= IR_OUTPUT(FUNC_SIZE_GLOBAL - 1 downto 0);

		ALU_OP_CODE_P: process (RST, IR_opcode, IR_func)
		begin
			if (RST = '0') then
				IF_ALU_LABEL		<= L_NOP;

			-- R-Type instructions
			elsif IR_opcode = RTYPE then			-- Operation Labels
				if IR_func = RTYPE_SLL		then	IF_ALU_LABEL <= L_RTYPE_SLL;
				elsif IR_func = RTYPE_SRL	then	IF_ALU_LABEL <= L_RTYPE_SRL;
				elsif IR_func = RTYPE_SRA	then	IF_ALU_LABEL <= L_RTYPE_SRA;
				elsif IR_func = RTYPE_ADD	then	IF_ALU_LABEL <= L_RTYPE_ADD;
				elsif IR_func = RTYPE_ADDU	then	IF_ALU_LABEL <= L_RTYPE_ADDU;
				elsif IR_func = RTYPE_SUB	then	IF_ALU_LABEL <= L_RTYPE_SUB;
				elsif IR_func = RTYPE_SUBU	then	IF_ALU_LABEL <= L_RTYPE_SUBU;
				elsif IR_func = RTYPE_AND	then	IF_ALU_LABEL <= L_RTYPE_AND;
				elsif IR_func = RTYPE_OR	then	IF_ALU_LABEL <= L_RTYPE_OR;
				elsif IR_func = RTYPE_XOR	then	IF_ALU_LABEL <= L_RTYPE_XOR;
				elsif IR_func = RTYPE_SEQ	then	IF_ALU_LABEL <= L_RTYPE_SEQ;
				elsif IR_func = RTYPE_SNE	then	IF_ALU_LABEL <= L_RTYPE_SNE;
				elsif IR_func = RTYPE_SLT	then	IF_ALU_LABEL <= L_RTYPE_SLT;
				elsif IR_func = RTYPE_SGT	then	IF_ALU_LABEL <= L_RTYPE_SGT;
				elsif IR_func = RTYPE_SLE	then	IF_ALU_LABEL <= L_RTYPE_SLE;
				elsif IR_func = RTYPE_SGE	then	IF_ALU_LABEL <= L_RTYPE_SGE;
--				elsif IR_func = RTYPE_MOVI2S	then	IF_ALU_LABEL <= L_RTYPE_MOVI2S;
--				elsif IR_func = RTYPE_MOVS2I	then	IF_ALU_LABEL <= L_RTYPE_MOVS2I;
--				elsif IR_func = RTYPE_MOVF	then	IF_ALU_LABEL <= L_RTYPE_MOVF;
--				elsif IR_func = RTYPE_MOVD	then	IF_ALU_LABEL <= L_RTYPE_MOVD;
--				elsif IR_func = RTYPE_MOVFP2I	then	IF_ALU_LABEL <= L_RTYPE_MOVFP2I;
--				elsif IR_func = RTYPE_MOVI2FP	then	IF_ALU_LABEL <= L_RTYPE_MOVI2FP;
--				elsif IR_func = RTYPE_MOVI2T	then	IF_ALU_LABEL <= L_RTYPE_MOVI2T;
--				elsif IR_func = RTYPE_MOVT2I	then	IF_ALU_LABEL <= L_RTYPE_MOVT2I;
				elsif IR_func = RTYPE_SLTU	then	IF_ALU_LABEL <= L_RTYPE_SLTU;
				elsif IR_func = RTYPE_SGTU	then	IF_ALU_LABEL <= L_RTYPE_SGTU;
				elsif IR_func = RTYPE_SLEU	then	IF_ALU_LABEL <= L_RTYPE_SLEU;
				elsif IR_func = RTYPE_SGEU	then	IF_ALU_LABEL <= L_RTYPE_SGEU;
--				elsif IR_func = RTYPE_ADDF	then	IF_ALU_LABEL <= L_RTYPE_ADDF;
--				elsif IR_func = RTYPE_SUBF	then	IF_ALU_LABEL <= L_RTYPE_SUBF;
--				elsif IR_func = RTYPE_MULTF	then	IF_ALU_LABEL <= L_RTYPE_MULTF;
--				elsif IR_func = RTYPE_DIVF	then	IF_ALU_LABEL <= L_RTYPE_DIVF;
--				elsif IR_func = RTYPE_ADDD	then	IF_ALU_LABEL <= L_RTYPE_ADDD;
--				elsif IR_func = RTYPE_SUBD	then	IF_ALU_LABEL <= L_RTYPE_SUBD;
--				elsif IR_func = RTYPE_MULTD	then	IF_ALU_LABEL <= L_RTYPE_MULTD;
--				elsif IR_func = RTYPE_DIVD	then	IF_ALU_LABEL <= L_RTYPE_DIVD;
--				elsif IR_func = RTYPE_CVTF2D	then	IF_ALU_LABEL <= L_RTYPE_CVTF2D;
--				elsif IR_func = RTYPE_CVTF2I	then	IF_ALU_LABEL <= L_RTYPE_CVTF2I;
--				elsif IR_func = RTYPE_CVTD2F	then	IF_ALU_LABEL <= L_RTYPE_CVTD2F;
--				elsif IR_func = RTYPE_CVTD2I	then	IF_ALU_LABEL <= L_RTYPE_CVTD2I;
--				elsif IR_func = RTYPE_CVTI2F	then	IF_ALU_LABEL <= L_RTYPE_CVTI2F;
--				elsif IR_func = RTYPE_CVTI2D	then	IF_ALU_LABEL <= L_RTYPE_CVTI2D;
--				elsif IR_func = RTYPE_MULT	then	IF_ALU_LABEL <= L_RTYPE_MUL;
--				elsif IR_func = RTYPE_DIV	then	IF_ALU_LABEL <= L_RTYPE_DIV;
--				elsif IR_func = RTYPE_EQF	then	IF_ALU_LABEL <= L_RTYPE_EQF;
--				elsif IR_func = RTYPE_NEF	then	IF_ALU_LABEL <= L_RTYPE_NEF;
--				elsif IR_func = RTYPE_LTF	then	IF_ALU_LABEL <= L_RTYPE_LTF;
--				elsif IR_func = RTYPE_GTF	then	IF_ALU_LABEL <= L_RTYPE_GTF;
--				elsif IR_func = RTYPE_LEF	then	IF_ALU_LABEL <= L_RTYPE_LEF;
--				elsif IR_func = RTYPE_GEF	then	IF_ALU_LABEL <= L_RTYPE_GEF;
--				elsif IR_func = RTYPE_MULTU	then	IF_ALU_LABEL <= L_RTYPE_MULTU;
--				elsif IR_func = RTYPE_DIVU	then	IF_ALU_LABEL <= L_RTYPE_DIVU;
--				elsif IR_func = RTYPE_EQD	then	IF_ALU_LABEL <= L_RTYPE_EQD;
--				elsif IR_func = RTYPE_NED	then	IF_ALU_LABEL <= L_RTYPE_NED;
--				elsif IR_func = RTYPE_LTD	then	IF_ALU_LABEL <= L_RTYPE_LTD;
--				elsif IR_func = RTYPE_GTD	then	IF_ALU_LABEL <= L_RTYPE_GTD;
--				elsif IR_func = RTYPE_LED	then	IF_ALU_LABEL <= L_RTYPE_LED;
--				elsif IR_func = RTYPE_GED	then	IF_ALU_LABEL <= L_RTYPE_GED;
				else					IF_ALU_LABEL <= L_NOP;
				end if;
	
			-- I-Type instructions			-- Operation Labels
			elsif IR_opcode = ITYPE_BEQZ	then	IF_ALU_LABEL <= L_ITYPE_BEQZ;
			elsif IR_opcode = ITYPE_BNEZ	then	IF_ALU_LABEL <= L_ITYPE_BNEZ;
--			elsif IR_opcode = ITYPE_BFPT	then	IF_ALU_LABEL <= L_ITYPE_BFPT;
--			elsif IR_opcode = ITYPE_BFPF	then	IF_ALU_LABEL <= L_ITYPE_BFPF;
			elsif IR_opcode = ITYPE_ADDI	then	IF_ALU_LABEL <= L_ITYPE_ADDI;
			elsif IR_opcode = ITYPE_ADDUI	then	IF_ALU_LABEL <= L_ITYPE_ADDUI;
			elsif IR_opcode = ITYPE_SUBI	then	IF_ALU_LABEL <= L_ITYPE_SUBI;
			elsif IR_opcode = ITYPE_SUBUI	then	IF_ALU_LABEL <= L_ITYPE_SUBUI;
			elsif IR_opcode = ITYPE_ANDI	then	IF_ALU_LABEL <= L_ITYPE_ANDI;
			elsif IR_opcode = ITYPE_ORI	then	IF_ALU_LABEL <= L_ITYPE_ORI;
			elsif IR_opcode = ITYPE_XORI	then	IF_ALU_LABEL <= L_ITYPE_XORI;
			elsif IR_opcode = ITYPE_LHI	then	IF_ALU_LABEL <= L_ITYPE_LHI;
--			elsif IR_opcode = ITYPE_RFE	then	IF_ALU_LABEL <= L_ITYPE_RFE;
--			elsif IR_opcode = ITYPE_TRAP	then	IF_ALU_LABEL <= L_ITYPE_TRAP;
--			elsif IR_opcode = ITYPE_JR	then	IF_ALU_LABEL <= L_ITYPE_JR;
--			elsif IR_opcode = ITYPE_JALR	then	IF_ALU_LABEL <= L_ITYPE_JALR;
			elsif IR_opcode = ITYPE_SLLI	then	IF_ALU_LABEL <= L_ITYPE_SLLI;
			elsif IR_opcode = ITYPE_NOP	then	IF_ALU_LABEL <= L_ITYPE_NOP;
			elsif IR_opcode = ITYPE_SRLI	then	IF_ALU_LABEL <= L_ITYPE_SRLI;
			elsif IR_opcode = ITYPE_SRAI	then	IF_ALU_LABEL <= L_ITYPE_SRAI;
			elsif IR_opcode = ITYPE_SEQI	then	IF_ALU_LABEL <= L_ITYPE_SEQI;
			elsif IR_opcode = ITYPE_SNEI	then	IF_ALU_LABEL <= L_ITYPE_SNEI;
			elsif IR_opcode = ITYPE_SLTI	then	IF_ALU_LABEL <= L_ITYPE_SLTI;
			elsif IR_opcode = ITYPE_SGTI	then	IF_ALU_LABEL <= L_ITYPE_SGTI;
			elsif IR_opcode = ITYPE_SLEI	then	IF_ALU_LABEL <= L_ITYPE_SLEI;
			elsif IR_opcode = ITYPE_SGEI	then	IF_ALU_LABEL <= L_ITYPE_SGEI;
--			elsif IR_opcode = ITYPE_LB	then	IF_ALU_LABEL <= L_ITYPE_LB;
--			elsif IR_opcode = ITYPE_LH	then	IF_ALU_LABEL <= L_ITYPE_LH;
			elsif IR_opcode = ITYPE_LW	then	IF_ALU_LABEL <= L_ITYPE_LW;
--			elsif IR_opcode = ITYPE_LBU	then	IF_ALU_LABEL <= L_ITYPE_LBU;
--			elsif IR_opcode = ITYPE_LHU	then	IF_ALU_LABEL <= L_ITYPE_LHU;
--			elsif IR_opcode = ITYPE_LF	then	IF_ALU_LABEL <= L_ITYPE_LF;
--			elsif IR_opcode = ITYPE_LD	then	IF_ALU_LABEL <= L_ITYPE_LD;
--			elsif IR_opcode = ITYPE_SB	then	IF_ALU_LABEL <= L_ITYPE_SB;
--			elsif IR_opcode = ITYPE_SH	then	IF_ALU_LABEL <= L_ITYPE_SH;
			elsif IR_opcode = ITYPE_SW	then	IF_ALU_LABEL <= L_ITYPE_SW;
--			elsif IR_opcode = ITYPE_SF	then	IF_ALU_LABEL <= L_ITYPE_SF;
--			elsif IR_opcode = ITYPE_SD	then	IF_ALU_LABEL <= L_ITYPE_SD;
--			elsif IR_opcode = ITYPE_ITLB	then	IF_ALU_LABEL <= L_ITYPE_ITLB;
			elsif IR_opcode = ITYPE_SLTUI	then	IF_ALU_LABEL <= L_ITYPE_SLTUI;
			elsif IR_opcode = ITYPE_SGTUI	then	IF_ALU_LABEL <= L_ITYPE_SGTUI;
			elsif IR_opcode = ITYPE_SLEUI	then	IF_ALU_LABEL <= L_ITYPE_SLEUI;
			elsif IR_opcode = ITYPE_SGEUI	then	IF_ALU_LABEL <= L_ITYPE_SGEUI;
	
			-- J-Type instructions
			elsif IR_opcode = JTYPE_J	then	IF_ALU_LABEL <= L_JTYPE_J;
			elsif IR_opcode = JTYPE_JAL	then	IF_ALU_LABEL <= L_JTYPE_JAL;
	
			else					IF_ALU_LABEL <= L_NOP;
			end if;
	
		end process ALU_OP_CODE_P;

		LABEL_PIPE: process(CLK)
		begin
			if (CLK'event and CLK = '1') then
				if (RST = '0') then

					ID_ALU_LABEL		<= L_ITYPE_NOP;
					EX_ALU_LABEL		<= L_ITYPE_NOP;
					MEM_ALU_LABEL		<= L_ITYPE_NOP;
					WB_ALU_LABEL		<= L_ITYPE_NOP;

				else

					ID_ALU_LABEL		<= ID_ALU_LABEL_NEXT;
					EX_ALU_LABEL		<= EX_ALU_LABEL_NEXT;
					MEM_ALU_LABEL		<= MEM_ALU_LABEL_NEXT;
					WB_ALU_LABEL		<= WB_ALU_LABEL_NEXT;

				end if;
			end if;
		end process;

		ID_ALU_LABEL_NEXT		<= IF_ALU_LABEL;
		EX_ALU_LABEL_NEXT		<= ID_ALU_LABEL;
		MEM_ALU_LABEL_NEXT		<= EX_ALU_LABEL;
		WB_ALU_LABEL_NEXT		<= MEM_ALU_LABEL;

		----------------------------------------------------------------------------------------------------
		-- Processes
		----------------------------------------------------------------------------------------------------

		PIPELINES: process(CLK)
		begin
			if (CLK'event and CLK = '1') then
				if (RST = '0') then
					-- FETCH-DECODE
					IF_ID_NPC		<= (others => '0');			-- Program Counter signal
					IF_ID_IR		<= (others => '0');			-- Instruction Register signal

					-- DECODE-EXECUTE
					ID_EX_NPC		<= (others => '0');			-- Program Counter signal
					ID_EX_RF_WE		<= '0';					-- Register File Write Enable
					ID_EX_RS1		<= (others => '0');			-- Register Source 1
					ID_EX_RS2		<= (others => '0');			-- Register Source 2
					ID_EX_RD		<= (others => '0');			-- Register File Write Address
					ID_EX_RF_DATAIN		<= (others => '0');			-- Register File Write Data
					ID_EX_RF_OUT1		<= (others => '0');			-- Register File Read Data 1
					ID_EX_RF_OUT2		<= (others => '0');			-- Register File Read Data 2
					ID_EX_IMM		<= (others => '0');			-- Immediate

					-- EXECUTE-MEMORY
					EX_MEM_RF_WE		<= '0';					-- Register File Write Enable
					EX_MEM_RF_DATAIN	<= (others => '0');			-- Register File Write Data
					EX_MEM_RF_OUT2		<= (others => '0');			-- Register Source 2
					EX_MEM_ALU_OUTPUT	<= (others => '0');			-- ALU Output
					EX_MEM_BRANCH_DETECT	<= '0';					-- Branch Condition
					EX_MEM_RD		<= (others => '0');			-- Register File Write Address

					-- MEMORY-WRITE BACK
					MEM_WB_RF_WE		<= '0';					-- Register File Write Enable
					MEM_WB_ALU_OUTPUT	<= (others => '0');			-- ALU Output
					MEM_WB_DRAM_OUTPUT		<= (others => '0');			-- DRAM Output
					MEM_WB_RD		<= (others => '0');			-- Register File Write Address
				else
					-- FETCH-DECODE
					IF_ID_NPC		<= IF_ID_NPC_NEXT;			-- Program Counter signal
					IF_ID_IR		<= IF_ID_IR_NEXT;			-- Instruction Register signal

					-- DECODE-EXECUTE
					ID_EX_NPC		<= ID_EX_NPC_NEXT;			-- Program Counter signal
					ID_EX_RF_WE		<= ID_EX_RF_WE_NEXT;			-- Register File Write Enable
					ID_EX_RS1		<= ID_EX_RS1_NEXT;			-- Register Source 1
					ID_EX_RS2		<= ID_EX_RS2_NEXT;			-- Register Source 2
					ID_EX_RD		<= ID_EX_RD_NEXT;			-- Register File Write Address
					ID_EX_RF_DATAIN		<= ID_EX_RF_DATAIN_NEXT;		-- Register File Write Data
					ID_EX_RF_OUT1		<= ID_EX_RF_OUT1_NEXT;			-- Register File Read Data 1
					ID_EX_RF_OUT2		<= ID_EX_RF_OUT2_NEXT;			-- Register File Read Data 2
					ID_EX_IMM		<= ID_EX_IMM_NEXT;			-- Immediate

					-- EXECUTE-MEMORY
					EX_MEM_RF_WE		<= EX_MEM_RF_WE_NEXT;			-- Register File Write Enable
					EX_MEM_RF_DATAIN	<= EX_MEM_RF_DATAIN_NEXT;		-- Register File Write Data
					EX_MEM_RF_OUT2		<= EX_MEM_RF_OUT2_NEXT;			-- Register Source 2
					EX_MEM_ALU_OUTPUT	<= EX_MEM_ALU_OUTPUT_NEXT;		-- ALU Output
					EX_MEM_BRANCH_DETECT	<= EX_MEM_BRANCH_DETECT_NEXT;		-- Branch Condition
					EX_MEM_RD		<= EX_MEM_RD_NEXT;			-- Register File Write Address

					-- MEMORY-WRITE BACK
					MEM_WB_RF_WE		<= MEM_WB_RF_WE_NEXT;			-- Register File Write Enable
					MEM_WB_ALU_OUTPUT	<= MEM_WB_ALU_OUTPUT_NEXT;		-- ALU Output
					MEM_WB_DRAM_OUTPUT		<= MEM_WB_DRAM_OUTPUT_NEXT;		-- DRAM Output
					MEM_WB_RD		<= MEM_WB_RD_NEXT;			-- Register File Write Address
				end if;
			end if;
		end process PIPELINES;

		----------------------------------------------------------------------------------------------------
		-- FETCH (IF)
		----------------------------------------------------------------------------------------------------

		-- This is the input to program counter: currently zero 
		-- so no update of PC happens
		-- TO BE REMOVED AS SOON AS THE DATAPATH IS INSERTED!!!!!
		-- a proper connection must be made here if more than one
		-- instruction must be executed
		-- PC_BUS <= (others => '0'); 

--		PC_BUS_P: process (CLK, RST)
--		begin
--			if RST = '0' then			-- Asynchronous Reset (active low)
--				PC_BUS <= (others => '0');
--			elsif CLK'event and CLK = '0' then	-- Rising Clock Edge
--				PC_BUS <= std_logic_vector(unsigned(PC) + 4);
--			end if;
--		end process PC_BUS_P;


		-- Program Counter Process
		--	type   : sequential
		--	inputs : CLK, RST, PC_BUS, PC_LATCH_EN
		--	outputs: PC

--		PC_P: process (CLK, RST)
--		begin
--			if RST = '0' then			-- Asynchronous Reset (active low)
--				PC <= (others => '0');
--			elsif CLK'event and CLK = '1' then	-- Rising Clock Edge
--				if (PC_LATCH_EN = '1') then
--					PC <= PC_BUS;
--				end if;
--			end if;
--		end process PC_P;

		PROGRAM_COUNTER: FFDR

			generic map (	N		=> PC_SIZE_GLOBAL)

			port map (	CLK		=> CLK,
					RST		=> RST,
					EN		=> PC_LATCH_EN,
					REGIN		=> PC_BUS,
					REGOUT		=> PC_OUTPUT);

		NPC_BUS			<= std_logic_vector(unsigned(PC_OUTPUT) + 4);

		PC_MUX: MUX21

			generic map (	N		=> PC_SIZE_GLOBAL)

			port map (	A		=> NPC_BUS,
					B		=> EX_MEM_ALU_OUTPUT,
					S		=> PC_MUX_SEL,
					Y		=> PC_BUS);

		NEXT_PROGRAM_COUNTER: LDR

			generic map (	N		=> PC_SIZE_GLOBAL)

			port map (	--CLK		=> CLK,
					RST		=> RST,
					EN		=> NPC_LATCH_EN,
					REGIN		=> PC_BUS,
					REGOUT		=> NPC_OUT);

--		INSTRUCTION_MEMORY: IRAM
--
--			generic map (	RAM_DEPTH	=> IRAM_SIZE_GLOBAL,
--					I_SIZE		=> IR_SIZE_GLOBAL)
--
--			port map (	RST		=> RST,
--					--CLK		=> CLK,
--					ADDR		=> PC_OUTPUT,
--					DOUT		=> IR_BUS);

		-- Instruction Register Process
		-- 	type   : sequential
		-- 	inputs : CLK, RST, IRam_DIn, IR_LATCH_EN
		-- 	outputs: IR

--		IR_P: process (CLK, RST)
--		begin
--			if RST = '0' then			-- Asynchronous Reset (active low)
--				IR_OUTPUT <= (others => '0');
--			elsif CLK'event and CLK = '1' then	-- Rising Clock Edge
--				if (IR_LATCH_EN = '1') then
----					IR_OUTPUT <= IRam_DIn;
--					IR_OUTPUT <= IR_BUS;
--				end if;
--			end if;
--		end process IR_P;

		INSTRUCTION_REGISTER: LDR

			generic map (	N		=> IR_SIZE_GLOBAL)

			port map (	--CLK		=> CLK,
					RST		=> RST,
					EN		=> IR_LATCH_EN,
					REGIN		=> IR_BUS,
					REGOUT		=> IR_OUTPUT);

		-- IF-ID PIPELINE
		IF_ID_NPC_NEXT		<= NPC_OUT;
		IF_ID_IR_NEXT		<= IR_OUTPUT;

		----------------------------------------------------------------------------------------------------
		-- DECODE (ID)
		----------------------------------------------------------------------------------------------------
		--	type   : sequential
		--	inputs : RST, IF_ID_PC, IF_ID_IR
		--	outputs: RF_SIGNALS

		REGISTER_FILE: RF

			generic map (	N		=> RF_SIZE_GLOBAL,
					NA		=> RS_SIZE_GLOBAL)

			port map (	--CLK		=> CLK,
					RST		=> RST,
					EN		=> '1',
					EN_RD1		=> '1',
					EN_RD2		=> '1',
					EN_WR		=> MEM_WB_RF_WE,
					ADD_RD1		=> RS1,
					ADD_RD2		=> RS2,
					ADD_WR		=> MEM_WB_RD,
					DATAIN		=> WB_MUX_OUT,
					OUT1		=> RF_OUT1,
					OUT2		=> RF_OUT2);

		SIGN_EXTEND: SIGNEX

			generic map (	N		=> IR_SIZE_GLOBAL,
					OPC		=> OPC_SIZE_GLOBAL,
					REG		=> RS_SIZE)

			port map (	INSTR		=> IF_ID_IR,
					IMM		=> IMM_OUT);

--		JUMP_ADDRESS_P: process(NPC_LATCH_EN, IF_ID_PC, ID_EX_IMM_NEXT, RF_OUT1)
--		begin
--			if (NPC_LATCH_EN = '0') then			
--				PC_JUMP <= IF_ID_PC + ID_EX_IMM_NEXT;		-- Relative Jump
--			else
--				PC_JUMP <= RF_OUT1;				-- Absolute Jump
--			end if;
--		end process;

--		RELATIVE_JUMP: process(RST, IF_ID_PC, ID_EX_IMM_NEXT)
--		begin	
--			if RST = '0' then						-- Asynchronous Reset (active low)
--				REL_JUMP	<= (others => '0');
--			else
--				REL_JUMP	<= IF_ID_PC + ID_EX_IMM_NEXT;		-- Relative Jump Address
--			end if;
--		end process RELATIVE_JUMP;

--		JUMP_MUX: MUX21
--
--			generic map (	N		=> IR_SIZE_GLOBAL)
--
--			port map (	A		=> REL_JUMP,				-- Relative Jump
--					B		=> ID_EX_RF_OUT1_NEXT,			-- Absolute Jump
--					S		=> NPC_LATCH_EN,			-- NOTA: sostituire "NPC_LATCH_EN" con un segnale per indicare che il jump è relativo (definirlo come input del datapath)
--					Y		=> PC_JUMP);

-- NOTE: da definire
--		-- used for branch prediction
--		COMP_REG: process(ALUSrc_PC, ALU_result, EX_MEM_ALU_result, Branch_j, Branch, EX_MEM_RD, ID_EX_RD, MEM_WB_RD, writa_data_f, read_addr_f1, read_data_f1)
--		begin
--			{...}
--		end process;

--		-- How stall the pipeline, this is the mux for control signals
--		STALL_CONTROL_SIGNAL: process(stall, EXECUTE_CONTROL_SIGNALS, MemWrite, MemRead, Branch, RegWrite, MemToReg, ALUSrc, ALUSrc_PC)
--		begin
--			{..}
--		end process;

--		-- choose if use integer or floating register according OPCODE
--		CHOOSE_I_F_REG: process(IF_ID_INSTRUCTION(31 DOWNTO 26))
--		begin
--			{..}
--		end process;

		-- chose register destination
--		CHOOSE_RD: process(IF_ID_INSTRUCTION, ALUSrc, Branch_j, Float_operation_RD)
--		begin
--			{..}
--		end process;

		REGISTER_ADDRESSER: REGADDR

			generic map (	N		=> IR_SIZE_GLOBAL,
					OPC		=> OPC_SIZE_GLOBAL,
					REG		=> RS_SIZE_GLOBAL)

			port map (	INSTR		=> IF_ID_IR,
					RS1		=> RS1,				-- /  5 bits
					RS2		=> RS2,				-- /  5 bits
					RD		=> RD);				-- /  5 bits

--		RS1			<= IF_ID_IR(IR_SIZE - OPC_SIZE_GLOBAL - 1 downto IR_SIZE - OPC_SIZE_GLOBAL - RS_SIZE);					-- IF_ID_IR(25 downto 21);
--		RS2			<= IF_ID_IR(IR_SIZE - OPC_SIZE_GLOBAL - RS_SIZE - 1 downto IR_SIZE - OPC_SIZE_GLOBAL - RS_SIZE*2);			-- IF_ID_IR(20 downto 16);
--		RD			<= IF_ID_IR(IR_SIZE - OPC_SIZE_GLOBAL - RS_SIZE*2 - 1 downto IR_SIZE - OPC_SIZE_GLOBAL - RS_SIZE*3);			-- IF_ID_IR(15 downto 11);

--		REL_JUMP		<= IF_ID_PC + ID_EX_IMM_NEXT;			-- Relative Jump Address

		LATCH_REGA: LDR		generic map (RF_SIZE_GLOBAL)	port map (RST, RegA_LATCH_EN, RF_OUT1, ID_EX_RF_OUT1_NEXT);
		LATCH_REGB: LDR		generic map (RF_SIZE_GLOBAL)	port map (RST, RegB_LATCH_EN, RF_OUT2, ID_EX_RF_OUT2_NEXT);
		LATCH_REGIMM: LDR	generic map (RF_SIZE_GLOBAL)	port map (RST, RegIMM_LATCH_EN, IMM_OUT, ID_EX_IMM_NEXT);

		-- ID-EX PIPELINE
		ID_EX_NPC_NEXT		<= IF_ID_NPC;
--		ID_EX_IR_NEXT		<= IF_ID_IR;
--		ID_EX_OFFSET_NEXT	<= ID_EX_OFFSET;
		ID_EX_RF_WE_NEXT	<= RF_WE;

		ID_EX_RS1_NEXT		<= RS1;
		ID_EX_RS2_NEXT		<= RS2;
		ID_EX_RD_NEXT		<= RD;
		ID_EX_RF_DATAIN_NEXT	<= WB_MUX_OUT;

--		REG_LATCHES: process(RegA_LATCH_EN, RegB_LATCH_EN, RegIMM_LATCH_EN, IF_ID_IR, RF_OUT1, RF_OUT2)
--		begin
--			if (RegA_LATCH_EN = '1') then
--				ID_EX_RF_OUT1_NEXT <= RF_OUT1;
--			end if;
--			if (RegB_LATCH_EN = '1') then
--				ID_EX_RF_OUT2_NEXT <= RF_OUT2;
--			end if;
--			if (RegIMM_LATCH_EN = '1') then
--				ID_EX_IMM_NEXT <= IMM_OUT;
--			end if;
--		end process;

		----------------------------------------------------------------------------------------------------
		-- EXECUTE (EX)
		----------------------------------------------------------------------------------------------------
		--	type   : sequential
		--	inputs : 
		--	outputs: 

		ALU_PRE_MUX1: MUX41

			generic map (	N	=> RF_SIZE_GLOBAL)

			port map (	A	=> ID_EX_RF_OUT1,
					B	=> EX_MEM_ALU_OUTPUT,
					C	=> WB_MUX_OUT,
					D	=> (others => '0'),
					S	=> FORWARD_A,
					Y	=> ALU_PREOP1);

		ALU_PRE_MUX2: MUX41

			generic map (	N	=> RF_SIZE_GLOBAL)

			port map (	A	=> ID_EX_RF_OUT2,
					B	=> EX_MEM_ALU_OUTPUT,
					C	=> WB_MUX_OUT,
					D	=> (others => '0'),
					S	=> FORWARD_B,
					Y	=> ALU_PREOP2);
		ALU_MUX1: MUX21

			generic map (	N	=> RF_SIZE_GLOBAL)

			port map (	A	=> ALU_PREOP1,
					B	=> ID_EX_NPC,
					S	=> MUXA_SEL,
					Y	=> ALU_OP1);

		ALU_MUX2: MUX21

			generic map (	N	=> RF_SIZE_GLOBAL)

			port map (	A	=> ALU_PREOP2,
					B	=> ID_EX_IMM,
					S	=> MUXB_SEL,
					Y	=> ALU_OP2);

--		ALU_PRE_MUX1: MUX21
--
--			generic map (	N	=> RF_SIZE_GLOBAL)
--
--			port map (	A	=> ID_EX_RF_DATAIN,
--					B	=> ID_EX_NPC,
--					S	=> MUXA_PRE_SEL,
--					Y	=> ALU_PREOP1);
--
--		ALU_MUX1: MUX21
--
--			generic map (	N	=> RF_SIZE_GLOBAL)
--
--			port map (	A	=> ID_EX_RF_OUT1,
--					B	=> ALU_PREOP1,
--					S	=> MUXA_SEL,
--					Y	=> ALU_OP1);
--
--		ALU_PRE_MUX2: MUX21
--
--			generic map (	N	=> RF_SIZE_GLOBAL)
--
--			port map (	A	=> ID_EX_RF_DATAIN,
--					B	=> ID_EX_IMM_NEXT,
--					S	=> MUXB_PRE_SEL,
--					Y	=> ALU_PREOP2);
--
--		ALU_MUX2: MUX21
--
--			generic map (	N	=> RF_SIZE_GLOBAL)
--
--			port map (	A	=> ID_EX_RF_OUT2,
--					B	=> ALU_PREOP2,
--					S	=> MUXB_SEL,
--					Y	=> ALU_OP2);


		ARITHMETIC_LOGIC_UNIT: ALU

			generic map (	N	=> ALU_OP_SIZE_GLOBAL,
					NB	=> ALU_BLOCK_SIZE_GLOBAL)

			port map (	OP1	=> ALU_OP1,
					OP2	=> ALU_OP2,
					OPC	=> ALU_OPCODE,
					Y	=> ALU_OUTPUT,
					Z	=> ALU_ZERO);

		ZERO_DETECTOR: ZERODET

			generic map (	N	=> ALU_OP_SIZE_GLOBAL)

			port map (	A	=> ALU_PREOP1,
					Y	=> ZERO_OUT);

		ZERO_OUT_NEG	<= not(ZERO_OUT);

--		BRANCH_MUX: MUX21
--
--			generic map (	N	=> 1)
--
--			port map (	A	=> ZERO_OUT,
--					B	=> ZERO_OUT_NEG,
--					S	=> EQ_COND,
--					Y	=> BRANCH_DETECT);

		BRANCH_MUX: process(ZERO_OUT, EQ_COND)
		begin
			if (EQ_COND = '0') then
				BRANCH_DETECT <= ZERO_OUT;
			else
				BRANCH_DETECT <= ZERO_OUT_NEG;
			end if;
		end process;


		FORWARDING_UNIT: FU

			generic map (	N		=> RS_SIZE)

			port map (	RS1		=> ID_EX_RS1,
					RS2		=> ID_EX_RS2,
					RD_MEM		=> EX_MEM_RD,
					RD_WB		=> MEM_WB_RD,
					RF_WE_MEM	=> EX_MEM_RF_WE,
					RF_WE_WB	=> MEM_WB_RF_WE,
					FORWARD_A	=> FORWARD_A,
					FORWARD_B	=> FORWARD_B);

		LATCH_ALUOUT: LDR	generic map (ALU_OP_SIZE_GLOBAL)	port map (RST, ALU_OUTREG_EN, ALU_OUTPUT, EX_MEM_ALU_OUTPUT_NEXT);
		LATCH_BRANCH: LD						port map (RST, ALU_OUTREG_EN, BRANCH_DETECT, EX_MEM_BRANCH_DETECT_NEXT);

		-- EX-MEM PIPELINE
--		EX_MEM_NPC_NEXT		<= ID_EX_NPC;
		EX_MEM_RF_WE_NEXT	<= ID_EX_RF_WE;
		EX_MEM_RD_NEXT		<= ID_EX_RD;
--		EX_MEM_ALU_OUTPUT_NEXT	<= ALU_OUTPUT;
		EX_MEM_RF_DATAIN_NEXT 	<= ID_EX_RF_DATAIN;
		EX_MEM_RF_OUT2_NEXT	<= ID_EX_RF_OUT2;


		----------------------------------------------------------------------------------------------------
		-- MEMORY (MEM)
		----------------------------------------------------------------------------------------------------

		BRANCH_COND		<= EX_MEM_BRANCH_DETECT and JUMP_EN;
		PC_MUX_SEL		<= BRANCH_COND or JUMP_COND;

--		DATA_MEMORY: DRAM
--
--			generic map (	N	=> DRAM_SIZE_GLOBAL,
--					NW	=> DRAM_WORD_SIZE_GLOBAL)
--
--			port map (	CLK	=> CLK,					-- Clock
--					RST	=> RST,					-- Reset (active low)
--					RE	=> DRAM_RE,				-- Read Enable
--					WE	=> DRAM_WE,				-- Write Enable
--					ADDR	=> EX_MEM_ALU_OUTPUT,			-- Address
--					DIN	=> EX_MEM_RF_OUT2,			-- Data in
--					DOUT	=> DRAM_OUTPUT);				-- Data out

		LATCH_LMD: LDR		generic map (DRAM_WORD_SIZE_GLOBAL)	port map (RST, LMD_LATCH_EN, DRAM_OUTPUT, MEM_WB_DRAM_OUTPUT_NEXT);

		-- MEM-WB PIPELINE
		MEM_WB_RF_WE_NEXT	<= EX_MEM_RF_WE;
		MEM_WB_RD_NEXT		<= EX_MEM_RD;
		MEM_WB_ALU_OUTPUT_NEXT	<= EX_MEM_ALU_OUTPUT;
--		MEM_WB_DRAM_OUTPUT_NEXT	<= DRAM_OUTPUT;

		----------------------------------------------------------------------------------------------------
		-- WRITE BACK (WB)
		----------------------------------------------------------------------------------------------------

		WB_MUX: MUX21

			generic map (	N	=> DRAM_WORD_SIZE_GLOBAL)

			port map (	A	=> MEM_WB_DRAM_OUTPUT,			-- DRAM Data Out
					B	=> MEM_WB_ALU_OUTPUT,			-- ALU Data Out
					S	=> WB_MUX_SEL,				-- Selector
					Y	=> WB_MUX_OUT);				-- MUX Output

		----------------------------------------------------------------------------------------------------
		-- Components Mapping
		----------------------------------------------------------------------------------------------------


end DLX_DATAPATH_ARCH;
