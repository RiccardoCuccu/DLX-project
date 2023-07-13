library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use work.constants.all;

entity DLX_DATAPATH is

	generic (	IR_SIZE			: integer := IR_SIZE_GLOBAL;			-- Instruction Register size		/ 32 bits
			PC_SIZE			: integer := PC_SIZE_GLOBAL);			-- Program Counter size			/ 32 bits

	port (		CLK			: in  std_logic;				-- Clock
			RST			: in  std_logic;				-- Reset (active low)

--			IRam_DIn		: in  std_logic_vector(IR_SIZE - 1 downto 0);

			-- IF Control Signal
			IR_LATCH_EN		: in  std_logic;				-- Instruction Register Latch Enable
			NPC_LATCH_EN		: in  std_logic;

			-- ID Control Signals
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
			PC_LATCH_EN		: in  std_logic;				-- Program Counte Latch Enable

			-- WB Control signals
			WB_MUX_SEL		: in  std_logic;				-- Write Back MUX Sel
			RF_WE			: in  std_logic;				-- Register File Write Enable

			IR_OUTPUT			: out std_logic_vector(IR_SIZE - 1 downto 0));	-- Instruction Register			/ 32 bits
--			PC_OUTPUT			: out std_logic_vector(PC_SIZE - 1 downto 0));	-- Program Counter			/ 32 bits

end DLX_DATAPATH;


architecture DLX_DATAPATH_ARCH of DLX_DATAPATH is

	------------------------------------------------------------------------------------------------------------------------
	-- Components Declaration
	------------------------------------------------------------------------------------------------------------------------

	-- GLOBALS ------------------------------------------------------------------------------------------------------------------------

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

--	component MUX41 is
--
--		generic	(	N		: integer := SIZE_GLOBAL);			-- / 32 bits
--
--		port	(	A		: in  std_logic_vector(N - 1 downto 0);		-- / 32 bits
--				B		: in  std_logic_vector(N - 1 downto 0);		-- / 32 bits
--				C		: in  std_logic_vector(N - 1 downto 0);		-- / 32 bits
--				D		: in  std_logic_vector(N - 1 downto 0);		-- / 32 bits
--				S		: in  std_logic_vector(1 downto 0);		-- /  2 bits
--				Y		: out std_logic_vector(N - 1 downto 0));	-- / 32 bits
--
--	end component;

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

	-- FETCH ------------------------------------------------------------------------------------------------------------------------

	component IRAM

		generic (	RAM_DEPTH	: integer := IRAM_SIZE_GLOBAL;			-- / 2^8 bits
				I_SIZE		: integer := IR_SIZE_GLOBAL);			-- / 32 bits

		port (		RST		: in  std_logic;				-- Clock
				--CLK		: in  std_logic;				-- Reset (active low)
				ADDR		: in  std_logic_vector(I_SIZE - 1 downto 0);	-- Address		/ 32 bits
				DOUT		: out std_logic_vector(I_SIZE - 1 downto 0));	-- Data out		/ 32 bits

	end component;

	-- DECODE ------------------------------------------------------------------------------------------------------------------------

	component RF is

		generic	(	N		: integer := RF_SIZE_GLOBAL;			-- / 32 bits
				NA		: integer := RF_ADDRESSES_GLOBAL);		-- /  5 bits

		port	(	CLK		: in  std_logic;				-- Clock
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
				REG 		: integer := REG_SIZE_GLOBAL);			-- /  5 bits

		port (		INSTR		: in  std_logic_vector(N - 1 downto 0);		-- Instruction		/ 32 bits
				IMM		: out std_logic_vector(N - 1 downto 0));	-- Immediate		/ 32 bits

	end component;

	-- EXECUTE ------------------------------------------------------------------------------------------------------------------------

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

	-- MEMORY ------------------------------------------------------------------------------------------------------------------------

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




--	component FORWARDING_UNIT is
--	end component;


	------------------------------------------------------------------------------------------------------------------------
	-- Signals Declaration
	------------------------------------------------------------------------------------------------------------------------

	-- Instruction Register (IR) and Program Counter (PC) declaration
	signal IR_OUT : std_logic_vector(IR_SIZE - 1 downto 0);								-- Instruction Register signal		/ 32 bits
	signal PC_OUT : std_logic_vector(PC_SIZE - 1 downto 0);								-- Program Counter signal		/ 32 bits
	signal NPC_OUT : std_logic_vector(PC_SIZE - 1 downto 0);							-- Next Program Counter signal		/ 32 bits

	-- Instruction Ram Bus signals
--	signal IRam_DOut : std_logic_vector(SIZE_IR - 1 downto 0);

	-- Datapath Bus signals
	signal IR_BUS : std_logic_vector(IR_SIZE - 1 downto 0);								-- Instruction Register Bus		/ 32 bits
	signal PC_BUS : std_logic_vector(PC_SIZE - 1 downto 0);								-- Program Counter Bus			/ 32 bits
	signal NPC_BUS : std_logic_vector(PC_SIZE - 1 downto 0);							-- Next Program Counter Bus		/ 32 bits

	-- FETCH-DECODE (IF_ID) Pipeline signals
	signal IF_ID_PC, IF_ID_PC_NEXT : std_logic_vector(PC_SIZE - 1 downto 0);					-- Program Counter signal		/ 32 bits
	signal IF_ID_IR, IF_ID_IR_NEXT : std_logic_vector(IR_SIZE - 1 downto 0);					-- Instruction Register signal		/ 32 bits
--	signal IF_ID_RegA_LATCH_EN, IF_ID_RegA_LATCH_EN_NEXT : std_logic;						-- Register A Latch Enable
--	signal IF_ID_RegB_LATCH_EN, IF_ID_RegB_LATCH_EN_NEXT : std_logic;						-- Register B Latch Enable
--	signal IF_ID_RegIMM_LATCH_EN, IF_ID_RegIMM_LATCH_EN_NEXT : std_logic;						-- Immediate Register Latch Enable
--	signal IF_ID_MUXA_SEL, IF_ID_MUXA_SEL_NEXT : std_logic;								-- ALU MUX A selector
--	signal IF_ID_MUXB_SEL, IF_ID_MUXB_SEL_NEXT : std_logic;								-- ALU MUX B selector
--	signal IF_ID_ALU_OPCODE, IF_ID_ALU_OPCODE_NEXT : aluOp;								-- ALU Operation Code

	-- DECODE-EXECUTE (DE_EX) Pipeline signals
	signal ID_EX_PC, ID_EX_PC_NEXT : std_logic_vector(PC_SIZE - 1 downto 0);					-- Program Counter signal		/ 32 bits
--	signal ID_EX_IR, ID_EX_IR_NEXT : std_logic_vector(IR_SIZE - 1 downto 0);					-- Instruction Register signal		/ 32 bits
	signal ID_EX_RD, ID_EX_RD_NEXT : std_logic_vector(RF_ADDRESSES_GLOBAL - 1 downto 0);				-- Register File - Write address	/  5 bits
	signal ID_EX_RF_DATAIN, ID_EX_RF_DATAIN_NEXT : std_logic_vector(RF_SIZE_GLOBAL - 1 downto 0);			-- Register File - Write data		/ 32 bits
	signal ID_EX_RF_OUT1, ID_EX_RF_OUT1_NEXT : std_logic_vector(RF_SIZE_GLOBAL - 1 downto 0);			-- Register File - Read data 1		/ 32 bits
	signal ID_EX_RF_OUT2, ID_EX_RF_OUT2_NEXT : std_logic_vector(RF_SIZE_GLOBAL - 1 downto 0);			-- Register File - Read data 2		/ 32 bits
	signal ID_EX_IMM, ID_EX_IMM_NEXT : std_logic_vector(RF_SIZE_GLOBAL - 1 downto 0);				-- Immediate				/ 32 bits
--	signal ID_EX_MUXA_SEL, ID_EX_MUXA_SEL_NEXT : std_logic;								-- ALU MUX A selector
--	signal ID_EX_MUXB_SEL, ID_EX_MUXB_SEL_NEXT : std_logic;								-- ALU MUX B selector	
--	signal ID_EX_ALU_OPCODE, ID_EX_ALU_OPCODE_NEXT : aluOp;								-- ALU Operation Code

	-- EXECUTE-MEMORY (EX_MEM) Pipeline signals
	signal EX_MEM_PC, EX_MEM_PC_NEXT : std_logic_vector(PC_SIZE - 1 downto 0);					-- Program Counter signal		/ 32 bits
	signal EX_MEM_BRANCH_COND, EX_MEM_BRANCH_COND_NEXT : std_logic;							-- Branch Condition
	signal EX_MEM_RD, EX_MEM_RD_NEXT : std_logic_vector(RF_ADDRESSES_GLOBAL - 1 downto 0);				-- Register File - Write address	/  5 bits
	signal EX_MEM_RF_OUT2, EX_MEM_RF_OUT2_NEXT : std_logic_vector(RF_SIZE_GLOBAL - 1 downto 0);			-- Register File - Read data 2		/ 32 bits
	signal EX_MEM_ALU_OUT, EX_MEM_ALU_OUT_NEXT : std_logic_vector(RF_SIZE_GLOBAL - 1 downto 0);			-- ALU Output				/ 32 bits

	-- MEMORY-WRITE BACK (MEM_WB) Pipeline signals
	signal MEM_WB_RD, MEM_WB_RD_NEXT : std_logic_vector(RF_ADDRESSES_GLOBAL - 1 downto 0);				-- Register File - Write address	/  5 bits
	signal MEM_WB_ALU_OUT, MEM_WB_ALU_OUT_NEXT : std_logic_vector(RF_SIZE_GLOBAL - 1 downto 0);			-- ALU Output				/ 32 bits
	signal MEM_WB_DRAM_OUT, MEM_WB_DRAM_OUT_NEXT : std_logic_vector(DRAM_WORD_SIZE_GLOBAL - 1 downto 0);		-- DRAM Output 				/ 32 bits

	-- FETCH signals

	-- DECODE signals
--	signal RF_ENABLE, RF_WR, RF_RD1, RF_RD2 : std_logic;
	signal RS1, RS2, RD : std_logic_vector(RF_ADDRESSES_GLOBAL - 1 downto 0);					-- /  5 bits
	signal RF_OUT1, RF_OUT2 : std_logic_vector(RF_SIZE_GLOBAL - 1 downto 0);					-- / 32 bits
	signal IMM_OUT : std_logic_vector(IR_SIZE_GLOBAL - 1 downto 0);							-- / 32 bits

	-- EXECUTE signals
	signal ZERO_OUT, ZERO_OUT_NEG : std_logic;
	signal BRANCH_COND : std_logic;
	signal ALU_ZERO : std_logic;
	signal ALU_PREOP1, ALU_PREOP2, ALU_OP1, ALU_OP2, ALU_OUT : std_logic_vector(RF_SIZE_GLOBAL - 1 downto 0);	-- / 32 bits

	-- MEMORY signals
	signal PC_MUX_SEL : std_logic;
	signal PC_MUXA, PC_MUXB : std_logic_vector(PC_SIZE - 1 downto 0);						-- / 32 bits
--	signal PC_JUMP, REL_JUMP : std_logic_vector(PC_SIZE - 1 downto 0);						-- / 32 bits
	signal DRAM_OUT : std_logic_vector(DRAM_WORD_SIZE_GLOBAL - 1 downto 0);						-- / 32 bits
	signal WB_MUX_OUT : std_logic_vector(DRAM_WORD_SIZE_GLOBAL - 1 downto 0);					-- / 32 bits

	-- Forwarding Unit signals

	begin

--		PC_OUTPUT	<= PC_OUT;
		IR_OUTPUT	<= IR_OUT;

		------------------------------------------------------------------------------------------------------------------------
		-- Processes
		------------------------------------------------------------------------------------------------------------------------

		PIPELINES: process(CLK)
		begin
			if (CLK'event and CLK = '1') then
				if (RST = '0') then
					-- FETCH-DECODE
					IF_ID_PC		<= (others => '0');			-- Program Counter signal
					IF_ID_IR		<= (others => '0');			-- Instruction Register signal

					-- DECODE-EXECUTE
					ID_EX_PC		<= (others => '0');			-- Program Counter signal
--					ID_EX_IR		<= (others => '0');			-- Instruction Register signal
					ID_EX_RD		<= (others => '0');			-- Register File - Write address
					ID_EX_RF_DATAIN		<= (others => '0');			-- Register File - Write data
					ID_EX_RF_OUT1		<= (others => '0');			-- Register File - Read data 1
					ID_EX_RF_OUT2		<= (others => '0');			-- Register File - Read data 2
					ID_EX_IMM		<= (others => '0');			-- Immediate
--					ID_EX_MUXA_SEL		<= '0';					-- ALU MUX A selector
--					ID_EX_MUXB_SEL		<= '0';					-- ALU MUX B selector
--					ID_EX_ALU_OPCODE 	<= OP_NOP;				-- ALU Operation Code

					-- EXECUTE-MEMORY
					EX_MEM_PC		<= (others => '0');			-- Program Counter signal
					EX_MEM_RF_OUT2		<= (others => '0');			-- Register File - Read data 2
					EX_MEM_ALU_OUT		<= (others => '0');			-- ALU Output
					EX_MEM_BRANCH_COND	<= '0';					-- Branch Condition

					-- MEMORY-WRITE BACK
					MEM_WB_ALU_OUT		<= (others => '0');			-- ALU Output
					MEM_WB_DRAM_OUT		<= (others => '0');			-- DRAM Output
				else
					-- FETCH-DECODE
					IF_ID_PC		<= IF_ID_PC_NEXT;			-- Program Counter signal
					IF_ID_IR		<= IF_ID_IR_NEXT;			-- Instruction Register signal

					-- DECODE-EXECUTE
					ID_EX_PC		<= ID_EX_PC_NEXT;			-- Program Counter signal
--					ID_EX_IR		<= ID_EX_IR_NEXT;			-- Instruction Register signal
					ID_EX_RD		<= ID_EX_RD_NEXT;			-- Register File - Write address
					ID_EX_RF_DATAIN		<= ID_EX_RF_DATAIN_NEXT;		-- Register File - Write data
					ID_EX_RF_OUT1		<= ID_EX_RF_OUT1_NEXT;			-- Register File - Read data 1
					ID_EX_RF_OUT2		<= ID_EX_RF_OUT2_NEXT;			-- Register File - Read data 2
					ID_EX_IMM		<= ID_EX_IMM_NEXT;			-- Immediate
--					ID_EX_MUXA_SEL		<= ID_EX_MUXA_SEL_NEXT;			-- ALU MUX A selector
--					ID_EX_MUXB_SEL		<= ID_EX_MUXB_SEL_NEXT;			-- ALU MUX B selector
--					ID_EX_ALU_OPCODE 	<= ID_EX_ALU_OPCODE_NEXT;		-- ALU Operation Code

					-- EXECUTE-MEMORY
					EX_MEM_PC		<= EX_MEM_PC_NEXT;			-- Program Counter signal
					EX_MEM_RF_OUT2		<= EX_MEM_RF_OUT2_NEXT;			-- Register File - Read data 2
					EX_MEM_ALU_OUT		<= EX_MEM_ALU_OUT_NEXT;			-- ALU Output
					EX_MEM_BRANCH_COND	<= EX_MEM_BRANCH_COND_NEXT;		-- Branch Condition

					-- MEMORY-WRITE BACK
					MEM_WB_ALU_OUT		<= MEM_WB_ALU_OUT_NEXT;			-- ALU Output
					MEM_WB_DRAM_OUT		<= MEM_WB_DRAM_OUT_NEXT;		-- DRAM Output 	
				end if;
			end if;
		end process PIPELINES;


		------------------------------------------------------------------------------------------------------------------------
		-- FETCH (IF)
		------------------------------------------------------------------------------------------------------------------------

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
					REGOUT		=> PC_OUT);

		NEW_PROGRAM_COUNTER: LDR

			generic map (	N		=> PC_SIZE_GLOBAL)

			port map (	--CLK		=> CLK,
					RST		=> RST,
					EN		=> NPC_LATCH_EN,
					REGIN		=> NPC_BUS,
					REGOUT		=> NPC_OUT);

		INSTRUCTION_MEMORY: IRAM

			generic map (	RAM_DEPTH	=> IRAM_SIZE_GLOBAL,
					I_SIZE		=> IR_SIZE_GLOBAL)

			port map (	RST		=> RST,
					--CLK		=> CLK,
					ADDR		=> PC_OUT,
					DOUT		=> IR_BUS);

		-- Instruction Register Process
		-- 	type   : sequential
		-- 	inputs : CLK, RST, IRam_DIn, IR_LATCH_EN
		-- 	outputs: IR

--		IR_P: process (CLK, RST)
--		begin
--			if RST = '0' then			-- Asynchronous Reset (active low)
--				IR_OUT <= (others => '0');
--			elsif CLK'event and CLK = '1' then	-- Rising Clock Edge
--				if (IR_LATCH_EN = '1') then
----					IR_OUT <= IRam_DIn;
--					IR_OUT <= IR_BUS;
--				end if;
--			end if;
--		end process IR_P;

		INSTRUCTION_REGISTER: LDR

			generic map (	N		=> IR_SIZE_GLOBAL)

			port map (	--CLK		=> CLK,
					RST		=> RST,
					EN		=> IR_LATCH_EN,
					REGIN		=> IR_BUS,
					REGOUT		=> IR_OUT);

		NPC_BUS			<= std_logic_vector(unsigned(PC_OUT) + 4);
		
		-- IF-ID PIPELINE
		IF_ID_PC_NEXT		<= PC_OUT;
		IF_ID_IR_NEXT		<= IR_OUT;

		------------------------------------------------------------------------------------------------------------------------
		-- DECODE (ID)
		------------------------------------------------------------------------------------------------------------------------
		--	type   : sequential
		--	inputs : RST, IF_ID_PC, IF_ID_IR
		--	outputs: RF_SIGNALS

		REGISTER_FILE: RF

			generic map (	N		=> RF_SIZE_GLOBAL,
					NA		=> RF_ADDRESSES_GLOBAL)

			port map (	CLK		=> CLK,
					RST		=> RST,
					EN		=> '1',
					EN_RD1		=> '1',
					EN_RD2		=> '1',
					EN_WR		=> RF_WE,
					ADD_RD1		=> RS1,
					ADD_RD2		=> RS2,
					ADD_WR		=> MEM_WB_RD,
					DATAIN		=> WB_MUX_OUT,
					OUT1		=> RF_OUT1,
					OUT2		=> RF_OUT2);

		SIGN_EXTEND: SIGNEX

			generic map (	N		=> IR_SIZE_GLOBAL,
					OPC		=> OPC_SIZE_GLOBAL,
					REG		=> REG_SIZE_GLOBAL)

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

		RS1			<= IF_ID_IR(IR_SIZE - OPC_SIZE_GLOBAL - 1 downto IR_SIZE - OPC_SIZE_GLOBAL - REG_SIZE_GLOBAL);						-- IF_ID_IR(25 downto 21);
		RS2			<= IF_ID_IR(IR_SIZE - OPC_SIZE_GLOBAL - REG_SIZE_GLOBAL - 1 downto IR_SIZE - OPC_SIZE_GLOBAL - REG_SIZE_GLOBAL*2);			-- IF_ID_IR(20 downto 16);
		RD			<= IF_ID_IR(IR_SIZE - OPC_SIZE_GLOBAL - REG_SIZE_GLOBAL*2 - 1 downto IR_SIZE - OPC_SIZE_GLOBAL - REG_SIZE_GLOBAL*3);			-- IF_ID_IR(15 downto 11);

--		REL_JUMP		<= IF_ID_PC + ID_EX_IMM_NEXT;			-- Relative Jump Address

		LATCH_REGA: LDR		generic map (RF_SIZE_GLOBAL)	port map (RST, RegA_LATCH_EN, RF_OUT1, ID_EX_RF_OUT1_NEXT);
		LATCH_REGB: LDR		generic map (RF_SIZE_GLOBAL)	port map (RST, RegB_LATCH_EN, RF_OUT2, ID_EX_RF_OUT2_NEXT);
		LATCH_REGIMM: LDR	generic map (RF_SIZE_GLOBAL)	port map (RST, RegIMM_LATCH_EN, IMM_OUT, ID_EX_IMM_NEXT);

		-- ID-EX PIPELINE
		ID_EX_PC_NEXT		<= IF_ID_PC;
--		ID_EX_IR_NEXT		<= IF_ID_IR;
--		ID_EX_OFFSET_NEXT	<= ID_EX_OFFSET;

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

		------------------------------------------------------------------------------------------------------------------------
		-- EXECUTE (EX)
		------------------------------------------------------------------------------------------------------------------------
		--	type   : sequential
		--	inputs : 
		--	outputs: 

		ALU_PRE_MUX1: MUX21

			generic map (	N	=> RF_SIZE_GLOBAL)

			port map (	A	=> ID_EX_RF_DATAIN,
					B	=> ID_EX_PC,
					S	=> '0',
					Y	=> ALU_PREOP1);

		ALU_MUX1: MUX21

			generic map (	N	=> RF_SIZE_GLOBAL)

			port map (	A	=> ID_EX_RF_OUT1,
					B	=> ALU_PREOP1,					-- Warnings
					S	=> MUXA_SEL,
					Y	=> ALU_OP1);

		ALU_PRE_MUX2: MUX21

			generic map (	N	=> RF_SIZE_GLOBAL)

			port map (	A	=> ID_EX_RF_DATAIN,
					B	=> ID_EX_IMM_NEXT,
					S	=> '0',
					Y	=> ALU_PREOP2);

		ALU_MUX2: MUX21

			generic map (	N	=> RF_SIZE_GLOBAL)

			port map (	A	=> ID_EX_RF_OUT2,
					B	=> ALU_PREOP2,					-- Warnings
					S	=> MUXB_SEL,
					Y	=> ALU_OP2);

--		ALUMUX1: MUX41
--
--		generic map (	N	=> RF_SIZE_GLOBAL)
--
--		port map (	A	=> ID_EX_RF_OUT1,
--				B	=> ID_EX_RF_DATAIN,
--				C	=> (others => '0'),	-- NOTA: EX_MEM_ALU_result	(forwarding)
--				D	=> ID_EX_PC,
--				S	=> MUXA_SEL,
--				Y	=> ALU_OP1);
--
--		ALUMUX2: MUX41
--
--		generic map (	N	=> RF_SIZE_GLOBAL)
--
--		port map (	A	=> ID_EX_RF_OUT2,
--				B	=> ID_EX_RF_DATAIN,
--				C	=> (others => '0'),	-- NOTA: EX_MEM_ALU_result	(forwarding)
--				D	=> (others => '0'),
--				S	=> MUXB_SEL,
--				Y	=> ALU_OP2);

--		RS2_OR_IMM: process(ID_EX_ALUSrc, ID_EX_immediate, EX_MEM_FowardB_Next_app)
--		begin
--			-- for immediate operation
--			if (ID_EX_ALUSrc = '1') then
--				ALU_operand2 <= ID_EX_immediate;
--			-- for other operation
--			else
--				ALU_operand2 <= EX_MEM_FowardB_Next_app;
--			end if;
--		end process;

--		SW_OR_SB: process(EX_MEM_FowardB_Next_app, ID_EX_Take_MSB)
--		begin
--			-- for store a byte
--			if (ID_EX_Take_MSB = '1') then
--				EX_MEM_FowardB_Next(31 downto 8) <= (Others => '0');
--				EX_MEM_FowardB_Next(7 downto 0) <= EX_MEM_FowardB_Next_app(31 downto 24);
--			-- for other store
--			else
--				EX_MEM_FowardB_Next <= EX_MEM_FowardB_Next_app;
--			end if;
--		end process;

		ARITHMETIC_LOGIC_UNIT: ALU
			
			generic map (	N	=> ALU_OP_SIZE_GLOBAL,
					NB	=> ALU_BLOCK_SIZE_GLOBAL)

			port map (	OP1	=> ALU_OP1,
					OP2	=> ALU_OP2,
					OPC	=> ALU_OPCODE,
					Y	=> ALU_OUT,
					Z	=> ALU_ZERO);

		ZERO_DETECTOR: ZERODET

			generic map (	N	=> ALU_OP_SIZE_GLOBAL)

			port map (	A	=> ID_EX_RF_OUT1,
					Y	=> ZERO_OUT);

		ZERO_OUT_NEG	<= not(ZERO_OUT);

--		BRANCH_MUX: MUX21
--
--			generic map (	N	=> 1)
--
--			port map (	A	=> ZERO_OUT,
--					B	=> ZERO_OUT_NEG,
--					S	=> EQ_COND,
--					Y	=> BRANCH_COND);

		BRANCH_MUX: process(ZERO_OUT, EQ_COND)
		begin
			if (EQ_COND = '0') then
				BRANCH_COND <= ZERO_OUT;
			else
				BRANCH_COND <= ZERO_OUT_NEG;
			end if;
		end process;


--		ForwardingUnitComponent: ForwardingUnit
--			Generic Map(NbitRegAddressing => R)
--			Port Map
--			(
--				Rs1             => ID_EX_RS1,
--				Rs2             => ID_EX_RS2,
--				RdinMemStage    => EX_MEM_RD,
--				RdinWrbStage    => writa_addr_f,
--				MEM_WB_RegWrite => MEM_WB_RegWrite,
--				EX_MEM_RegWrite => EX_MEM_RegWrite,
--				ForwardA        => ForwardAmuxSelector,
--				ForwardB        => ForwardBmuxSelector);

		LATCH_ALUOUT: LDR	generic map (ALU_OP_SIZE_GLOBAL)	port map (RST, ALU_OUTREG_EN, ALU_OUT, EX_MEM_ALU_OUT_NEXT);
		LATCH_BRANCH: LD						port map (RST, ALU_OUTREG_EN, BRANCH_COND, EX_MEM_BRANCH_COND_NEXT);

		-- EX-MEM PIPELINE
		EX_MEM_PC_NEXT		<= ID_EX_PC;
		EX_MEM_RD_NEXT		<= ID_EX_RD;
--		EX_MEM_ALU_OUT_NEXT	<= ALU_OUT;
		EX_MEM_RF_OUT2_NEXT	<= ID_EX_RF_OUT2;


		------------------------------------------------------------------------------------------------------------------------
		-- MEMORY (MEM)
		------------------------------------------------------------------------------------------------------------------------

		PC_MUX_SEL		<= EX_MEM_BRANCH_COND or JUMP_EN;

		PC_MUX: MUX21

			generic map (	N	=> PC_SIZE_GLOBAL)

			port map (	A	=> EX_MEM_ALU_OUT,
					B	=> EX_MEM_PC,
					S	=> PC_MUX_SEL,
					Y	=> PC_BUS);

		DATA_MEMORY: DRAM

			generic map (	N	=> DRAM_SIZE_GLOBAL,
					NW	=> DRAM_WORD_SIZE_GLOBAL)

			port map (	CLK	=> CLK,					-- Clock
					RST	=> RST,					-- Reset (active low)
					RE	=> DRAM_RE,				-- Read Enable
					WE	=> DRAM_WE,				-- Write Enable
					ADDR	=> EX_MEM_ALU_OUT,			-- Address
					DIN	=> EX_MEM_RF_OUT2,			-- Data in
					DOUT	=> DRAM_OUT);				-- Data out
		
		LATCH_LMD: LDR		generic map (DRAM_WORD_SIZE_GLOBAL)	port map (RST, LMD_LATCH_EN, DRAM_OUT, MEM_WB_DRAM_OUT_NEXT);

		-- MEM-WB PIPELINE
		MEM_WB_RD_NEXT		<= EX_MEM_RD;
		MEM_WB_ALU_OUT_NEXT	<= EX_MEM_ALU_OUT;
--		MEM_WB_DRAM_OUT_NEXT	<= DRAM_OUT;

		------------------------------------------------------------------------------------------------------------------------
		-- WRITE BACK (WB)
		------------------------------------------------------------------------------------------------------------------------

		WB_MUX: MUX21

			generic map (	N	=> DRAM_WORD_SIZE_GLOBAL)

			port map (	A	=> MEM_WB_DRAM_OUT,
					B	=> MEM_WB_ALU_OUT,
					S	=> WB_MUX_SEL,
					Y	=> WB_MUX_OUT);

		------------------------------------------------------------------------------------------------------------------------
		-- Components Mapping
		------------------------------------------------------------------------------------------------------------------------



end DLX_DATAPATH_ARCH;
