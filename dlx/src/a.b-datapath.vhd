library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use work.constants.all;

entity DLX_DATAPATH is

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

end DLX_DATAPATH;


architecture DLX_DATAPATH_ARCH of DLX_DATAPATH is

	----------------------------------------------------------------
	-- Signals Declaration
	----------------------------------------------------------------
	
	-- Instruction Register (IR) and Program Counter (PC) declaration
	signal IR : std_logic_vector(IR_SIZE - 1 downto 0);
	signal PC : std_logic_vector(PC_SIZE - 1 downto 0);

	-- Instruction Ram Bus signals
--	signal IRam_DOut : std_logic_vector(SIZE_IR - 1 downto 0);

	-- Datapath Bus signals
	signal PC_BUS : std_logic_vector(PC_SIZE - 1 downto 0);

	begin

		PC_OUT	<= PC;
		IR_OUT	<= IR;

		-- This is the input to program counter: currently zero 
		-- so no update of PC happens
		-- TO BE REMOVED AS SOON AS THE DATAPATH IS INSERTED!!!!!
		-- a proper connection must be made here if more than one
		-- instruction must be executed
		-- PC_BUS <= (others => '0'); 

		PC_BUS_P: process (Clk, Rst)
		begin
			if Rst = '0' then			-- asynchronous reset (active low)
				PC_BUS <= (others => '0');
			elsif Clk'event and Clk = '0' then	-- rising clock edge
				PC_BUS <= std_logic_vector(unsigned(PC) + 4);
			end if;
		end process PC_BUS_P;


		-- purpose: Program Counter Process
		-- type   : sequential
		-- inputs : Clk, Rst, PC_BUS
		-- outputs: PC

		PC_P: process (Clk, Rst)
		begin
			if Rst = '0' then			-- asynchronous reset (active low)
				PC <= (others => '0');
			elsif Clk'event and Clk = '1' then	-- rising clock edge
				if (PC_LATCH_EN = '1') then
					PC <= PC_BUS;
				end if;
			end if;
		end process PC_P;


		-- purpose: Instruction Register Process
		-- type   : sequential
		-- inputs : Clk, Rst, IRam_DIn, IR_LATCH_EN
		-- outputs: IR

		IR_P: process (Clk, Rst)
		begin
			if Rst = '0' then			-- asynchronous reset (active low)
				IR_OUT <= (others => '0');
			elsif Clk'event and Clk = '1' then	-- rising clock edge
				if (IR_LATCH_EN = '1') then
					IR <= IRam_DIn;
				end if;
			end if;
		end process IR_P;


end DLX_DATAPATH_ARCH;
