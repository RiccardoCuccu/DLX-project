----------------------------------------------------------------------------------------------------
-- Description:	This testbench is responsible for validating the DLX processor's datapath.
--
-- Author:	Riccardo Cuccu
-- Date:	2023/09/03
----------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.constants.all;

entity TB_DATAPATH is
end TB_DATAPATH;

architecture TEST of TB_DATAPATH is

	constant IR_SIZE	: integer := IR_SIZE_GLOBAL;		-- Instruction Register Size
	constant PC_SIZE	: integer := PC_SIZE_GLOBAL;		-- Program Counter Size
--	constant ALU_OPC_SIZE	: integer := OPC_SIZE_GLOBAL;		-- ALU Op Code Word Size in case explicit coding is used

	signal Clock			: std_logic := '0';
	signal Reset			: std_logic := '1';
	
--	signal TB_IRam_DIn		: std_logic_vector(IR_SIZE - 1 downto 0) := (others => '0');

	signal TB_IR_LATCH_EN		: std_logic := '0';
	signal TB_NPC_LATCH_EN		: std_logic := '0';

	signal TB_RegA_LATCH_EN		: std_logic := '0';
	signal TB_RegB_LATCH_EN		: std_logic := '0';
	signal TB_RegIMM_LATCH_EN	: std_logic := '0';

	signal TB_MUXA_SEL		: std_logic := '0';
	signal TB_MUXB_SEL		: std_logic := '0';
	signal TB_ALU_OUTREG_EN		: std_logic := '0';
	signal TB_EQ_COND		: std_logic := '0';

	signal TB_ALU_OPCODE		: aluOp := OP_NOP;

	signal TB_DRAM_RE		: std_logic := '0';
	signal TB_DRAM_WE		: std_logic := '0';
	signal TB_LMD_LATCH_EN		: std_logic := '0';
	signal TB_JUMP_EN		: std_logic := '0';
	signal TB_PC_LATCH_EN		: std_logic := '0';

	signal TB_WB_MUX_SEL		: std_logic := '0';
	signal TB_RF_WE			: std_logic := '0';

	signal TB_IR_OUT		: std_logic_vector(IR_SIZE - 1 downto 0) := (others => '0');
--	signal TB_PC_OUT		: std_logic_vector(PC_SIZE - 1 downto 0) := (others => '0');

	component DLX_DATAPATH

	generic (	IR_SIZE			: integer := IR_SIZE_GLOBAL;	-- Instruction Register size		/ 32 bits
			PC_SIZE			: integer := PC_SIZE_GLOBAL);	-- Program Counter size			/ 32 bits

	port (		CLK			: in std_logic;			-- Clock
			RST			: in std_logic;			-- Reset:Active-Low

--			IRam_DIn		: in std_logic_vector(IR_SIZE - 1 downto 0);

			-- IF Control Signal
			IR_LATCH_EN		: in std_logic;			-- Instruction Register Latch Enable
			NPC_LATCH_EN		: in std_logic;

			-- ID Control Signals
			RegA_LATCH_EN		: in std_logic;			-- Register A Latch Enable
			RegB_LATCH_EN		: in std_logic;			-- Register B Latch Enable
			RegIMM_LATCH_EN		: in std_logic;			-- Immediate Register Latch Enable

			-- EX Control Signals
			MUXA_SEL		: in std_logic;			-- MUX-A Sel
			MUXB_SEL		: in std_logic;			-- MUX-B Sel
			ALU_OUTREG_EN		: in std_logic;			-- ALU Output Register Enable
			EQ_COND			: in std_logic;			-- Branch if (not) Equal to Zero

			-- ALU Operation Code
			ALU_OPCODE		: in aluOp;	-- choose between implicit or explicit coding, like std_logic_vector(ALU_OPC_SIZE - 1 downto 0);
			--ALU_OPCODE		: in std_logic_			ector(ALU_OPC_SIZE - 1 downto 0);

			-- MEM Control Signals
			DRAM_RE			: in std_logic;			-- Data RAM Read Enable
			DRAM_WE			: in std_logic;			-- Data RAM Write Enable
			LMD_LATCH_EN		: in std_logic;			-- LMD Register Latch Enable
			JUMP_EN			: in std_logic;			-- JUMP Enable Signal for PC input MUX
			PC_LATCH_EN		: in std_logic;			-- Program Counte Latch Enable

			-- WB Control signals
			WB_MUX_SEL		: in std_logic;			-- Write Back MUX Sel
			RF_WE			: in std_logic;			-- Register File Write Enable

			IR_OUTPUT		: out std_logic_vector(IR_SIZE - 1 downto 0));	-- Instruction Register		/ 32 bits
--			PC_OUTPUT		: out std_logic_vector(PC_SIZE - 1 downto 0));	-- Program Counter		/ 32 bits

	end component;


begin

	-- instance of DLX_DATAPATH
	U1: DLX_DATAPATH

		generic map (IR_SIZE, PC_SIZE)
		port map (Clock, Reset, TB_IR_LATCH_EN, TB_NPC_LATCH_EN, TB_RegA_LATCH_EN, TB_RegB_LATCH_EN, TB_RegIMM_LATCH_EN, TB_MUXA_SEL, TB_MUXB_SEL, TB_ALU_OUTREG_EN, TB_EQ_COND, TB_ALU_OPCODE, TB_DRAM_RE, TB_DRAM_WE, TB_LMD_LATCH_EN, TB_JUMP_EN, TB_PC_LATCH_EN, TB_WB_MUX_SEL, TB_RF_WE, TB_IR_OUT);

	PCLOCK: process(Clock)
	begin
		Clock <= not(Clock) after 0.5 ns;
	end process;

	Reset			<= '0', '1' after 5 ns, '0' after 11 ns, '1' after 15 ns;

--	TB_IRam_DIn		<= (others => '0'), '1' after 6 ns;
	TB_IR_LATCH_EN		<= '0', '1' after 6 ns;
	TB_NPC_LATCH_EN		<= '0', '1' after 6 ns;

	TB_RegA_LATCH_EN	<= '0', '1' after 6 ns;
	TB_RegB_LATCH_EN	<= '0', '1' after 6 ns;
	TB_RegIMM_LATCH_EN	<= '0', '1' after 6 ns;

	TB_MUXA_SEL		<= '0';
	TB_MUXB_SEL		<= '0';
	TB_ALU_OUTREG_EN	<= '0';
	TB_EQ_COND		<= '0', '1' after 6 ns;

	TB_ALU_OPCODE		<= OP_NOP, OP_ADD after 6 ns;

	TB_DRAM_RE		<= '0', '1' after 6 ns;
	TB_DRAM_WE		<= '0', '1' after 6 ns;
	TB_LMD_LATCH_EN		<= '0', '1' after 6 ns;
	TB_JUMP_EN		<= '0', '1' after 6 ns;
	TB_PC_LATCH_EN		<= '0', '1' after 6 ns;

	TB_WB_MUX_SEL		<= '0', '1' after 6 ns, '0' after 9 ns;
	TB_RF_WE		<= '0', '1' after 6 ns;

end TEST;


configuration CFG_TB of TB_DATAPATH is
	for TEST
	end for;
end CFG_TB;
