library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.constants.all;

entity DLX is

	generic (	SIZE_IR	: integer := IR_SIZE_GLOBAL;	-- Instruction Register Size
			SIZE_PC	: integer := PC_SIZE_GLOBAL);	-- Program Counter Size
	
	port (		Clk	: in std_logic;
			Rst	: in std_logic);		-- Active Low

end DLX;


-- This architecture is currently not complete
-- it just includes:
-- instruction register (complete)
-- program counter (complete)
-- instruction ram memory (complete)
-- control unit (UNCOMPLETE)

architecture DLX_RTL of DLX is

	--------------------------------------------------------------------
	-- Components Declaration
	--------------------------------------------------------------------

	-- Control Unit (a.a)
	component DLX_CU

		generic (	MICROCODE_MEM_SIZE	: integer := MMEM_SIZE_GLOBAL;	-- Microcode Memory Size
				FUNC_SIZE		: integer := FUNC_SIZE_GLOBAL;	-- Func Field Size for R-Type Ops
				OP_CODE_SIZE		: integer := OPC_SIZE_GLOBAL;	-- Op Code Size
				--ALU_OPC_SIZE		: integer := OPC_SIZE_GLOBAL;	-- ALU Op Code Word Size
				IR_SIZE			: integer := IR_SIZE_GLOBAL;	-- Instruction Register Size
				CW_SIZE			: integer := CW_SIZE_GLOBAL);	-- Control Word Size

		port (		Clk			: in  std_logic;	-- Clock
				Rst			: in  std_logic;	-- Reset:Active-Low

				-- Instruction Register
				IR_IN			: in  std_logic_vector(IR_SIZE - 1 downto 0);

				-- IF Control Signal
				IR_LATCH_EN		: out std_logic;	-- Instruction Register Latch Enable
				NPC_LATCH_EN		: out std_logic;

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
				PC_LATCH_EN		: out std_logic;	-- Program Counte Latch Enable

				-- WB Control signals
				WB_MUX_SEL		: out std_logic;	-- Write Back MUX Sel
				RF_WE			: out std_logic);	-- Register File Write Enable

		end component;


	-- Datapath (a.b)
	component DLX_DATAPATH

		generic (	IR_SIZE			: integer := IR_SIZE_GLOBAL;	-- Instruction Register size
				PC_SIZE			: integer := PC_SIZE_GLOBAL);	-- Program Counter size

		port (		Clk			: in std_logic;	-- Clock
				Rst			: in std_logic;	-- Reset:Active-Low

				IRam_DIn		: in std_logic_vector(IR_SIZE - 1 downto 0);

				-- IF Control Signal
				IR_LATCH_EN		: in std_logic;	-- Instruction Register Latch Enable
				NPC_LATCH_EN		: in std_logic;

				-- ID Control Signals
				RegA_LATCH_EN		: in std_logic;	-- Register A Latch Enable
				RegB_LATCH_EN		: in std_logic;	-- Register B Latch Enable
				RegIMM_LATCH_EN		: in std_logic;	-- Immediate Register Latch Enable

				-- EX Control Signals
				MUXA_SEL		: in std_logic;	-- MUX-A Sel
				MUXB_SEL		: in std_logic;	-- MUX-B Sel
				ALU_OUTREG_EN		: in std_logic;	-- ALU Output Register Enable
				EQ_COND			: in std_logic;	-- Branch if (not) Equal to Zero

				-- ALU Operation Code
				ALU_OPCODE		: in aluOp;		-- choose between implicit or explicit coding, like std_logic_vector(ALU_OPC_SIZE - 1 downto 0);
				--ALU_OPCODE		: in std_logic_vector(ALU_OPC_SIZE - 1 downto 0);

				-- MEM Control Signals
				DRAM_WE			: in std_logic;	-- Data RAM Write Enable
				LMD_LATCH_EN		: in std_logic;	-- LMD Register Latch Enable
				JUMP_EN			: in std_logic;	-- JUMP Enable Signal for PC input MUX
				PC_LATCH_EN		: in std_logic;	-- Program Counte Latch Enable

				-- WB Control signals
				WB_MUX_SEL		: in std_logic;	-- Write Back MUX Sel
				RF_WE			: in std_logic;	-- Register File Write Enable

				IR_OUT			: out std_logic_vector(IR_SIZE -1 downto 0);
				PC_OUT			: out std_logic_vector(PC_SIZE -1 downto 0));

		end component;


	-- Instruction Ram (a.c)
	component IRAM

		generic (	RAM_DEPTH	: integer := RAM_SIZE_GLOBAL;
				I_SIZE		: integer := IR_SIZE_GLOBAL);

		port (		Rst		: in  std_logic;
				Clk		: in  std_logic;
				Addr		: in  std_logic_vector(I_SIZE - 1 downto 0);
				Dout		: out std_logic_vector(I_SIZE - 1 downto 0));

	end component;

	-- Data Ram (MISSING! You must include it in your final project!)





	----------------------------------------------------------------
	-- Signals Declaration
	----------------------------------------------------------------
	
	-- Instruction Register (IR) and Program Counter (PC) declaration
	signal IR : std_logic_vector(SIZE_IR - 1 downto 0);
	signal PC : std_logic_vector(SIZE_PC - 1 downto 0);

	-- Instruction Ram Bus signals
	signal IRam_DOut : std_logic_vector(SIZE_IR - 1 downto 0);

	-- Datapath Bus signals
--	signal PC_BUS : std_logic_vector(SIZE_PC - 1 downto 0);

	-- Control Unit Bus signals
	signal IR_LATCH_EN_i : std_logic;
	signal NPC_LATCH_EN_i : std_logic;
	signal RegA_LATCH_EN_i : std_logic;
	signal RegB_LATCH_EN_i : std_logic;
	signal RegIMM_LATCH_EN_i : std_logic;
	signal EQ_COND_i : std_logic;
	signal JUMP_EN_i : std_logic;
	signal ALU_OPCODE_i : aluOp;
	--signal ALU_OPCODE_i : std_logic_vector(OPC_SIZE_GLOBAL - 1 downto 0);
	signal MUXA_SEL_i : std_logic;
	signal MUXB_SEL_i : std_logic;
	signal ALU_OUTREG_EN_i : std_logic;
	signal DRAM_WE_i : std_logic;
	signal LMD_LATCH_EN_i : std_logic;
	signal PC_LATCH_EN_i : std_logic;
	signal WB_MUX_SEL_i : std_logic;
	signal RF_WE_i : std_logic;


	-- Data Ram Bus signals

	begin

		-- This is the input to program counter: currently zero 
		-- so no uptade of PC happens
		-- TO BE REMOVED AS SOON AS THE DATAPATH IS INSERTED!!!!!
		-- a proper connection must be made here if more than one
		-- instruction must be executed
		-- PC_BUS <= (others => '0'); 

--		PC_BUS_P: process (Clk, Rst)
--		begin
--			if Rst = '0' then			-- asynchronous reset (active low)
--				PC_BUS <= (others => '0');
--			elsif Clk'event and Clk = '0' then	-- rising clock edge
--				PC_BUS <= std_logic_vector(unsigned(PC) + 4);
--			end if;
--		end process PC_BUS_P;


		-- purpose: Instruction Register Process
		-- type   : sequential
		-- inputs : Clk, Rst, IRam_DOut, IR_LATCH_EN_i
		-- outputs: IR

--		IR_P: process (Clk, Rst)
--		begin
--			if Rst = '0' then			-- asynchronous reset (active low)
--				IR <= (others => '0');
--			elsif Clk'event and Clk = '1' then	-- rising clock edge
--				if (IR_LATCH_EN_i = '1') then
--					IR <= IRam_DOut;
--				end if;
--			end if;
--		end process IR_P;


		-- purpose: Program Counter Process
		-- type   : sequential
		-- inputs : Clk, Rst, PC_BUS
		-- outputs: PC

--		PC_P: process (Clk, Rst)
--		begin
--			if Rst = '0' then			-- asynchronous reset (active low)
--				PC <= (others => '0');
--			elsif Clk'event and Clk = '1' then	-- rising clock edge
--				if (PC_LATCH_EN_i = '1') then
--					PC <= PC_BUS;
--				end if;
--			end if;
--		end process PC_P;

		-- Control Unit Instantiation
		CU_I: DLX_CU
			port map (	Clk		=> Clk,
					Rst		=> Rst,
					IR_IN		=> IR,
					IR_LATCH_EN	=> IR_LATCH_EN_i,
					NPC_LATCH_EN	=> NPC_LATCH_EN_i,
					RegA_LATCH_EN	=> RegA_LATCH_EN_i,
					RegB_LATCH_EN	=> RegB_LATCH_EN_i,
					RegIMM_LATCH_EN	=> RegIMM_LATCH_EN_i,
					MUXA_SEL	=> MUXA_SEL_i,
					MUXB_SEL	=> MUXB_SEL_i,
					ALU_OUTREG_EN	=> ALU_OUTREG_EN_i,
					EQ_COND		=> EQ_COND_i,
					ALU_OPCODE	=> ALU_OPCODE_i,
					DRAM_WE		=> DRAM_WE_i,
					LMD_LATCH_EN	=> LMD_LATCH_EN_i,
					JUMP_EN		=> JUMP_EN_i,
					PC_LATCH_EN	=> PC_LATCH_EN_i,
					WB_MUX_SEL	=> WB_MUX_SEL_i,
					RF_WE		=> RF_WE_i);

		-- Datapath Instantiation
		DATAPATH_I: DLX_DATAPATH
			port map (	Clk		=> Clk,
					Rst		=> Rst,
					IRam_DIn	=> IRam_DOut,
					IR_LATCH_EN	=> IR_LATCH_EN_i,
					NPC_LATCH_EN	=> NPC_LATCH_EN_i,
					RegA_LATCH_EN	=> RegA_LATCH_EN_i,
					RegB_LATCH_EN	=> RegB_LATCH_EN_i,
					RegIMM_LATCH_EN	=> RegIMM_LATCH_EN_i,
					MUXA_SEL	=> MUXA_SEL_i,
					MUXB_SEL	=> MUXB_SEL_i,
					ALU_OUTREG_EN	=> ALU_OUTREG_EN_i,
					EQ_COND		=> EQ_COND_i,
					ALU_OPCODE	=> ALU_OPCODE_i,
					DRAM_WE		=> DRAM_WE_i,
					LMD_LATCH_EN	=> LMD_LATCH_EN_i,
					JUMP_EN		=> JUMP_EN_i,
					PC_LATCH_EN	=> PC_LATCH_EN_i,
					WB_MUX_SEL	=> WB_MUX_SEL_i,
					RF_WE		=> RF_WE_i,
					IR_OUT		=> IR,
					PC_OUT		=> PC);

		-- Instruction Ram Instantiation
		IRAM_I: IRAM
			port map (	Clk	=> Clk,
					Rst	=> Rst,
					Addr	=> PC,
					Dout	=> IRam_DOut);

end DLX_RTL;
