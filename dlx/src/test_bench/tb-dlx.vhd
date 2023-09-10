----------------------------------------------------------------------------------------------------
-- Description:	This VHDL module serves as the testbench for the DLX architecture. It generates 
--		a clock signal and a reset sequence for the DLX core. The testbench includes 
--		instance instantiation of the DLX core and maps the testbench clock and reset 
--		signals to the core's clock and reset inputs.
--
-- Author:	Riccardo Cuccu
-- Date:	2023/09/10
----------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.constants.all;

entity TB_DLX is
end TB_DLX;

architecture TEST of TB_DLX is

	constant IR_SIZE	: integer := IR_SIZE_GLOBAL;		-- Instruction Register Size
	constant PC_SIZE	: integer := PC_SIZE_GLOBAL;		-- Program Counter Size
--	constant ALU_OPC_SIZE	: integer := OPC_SIZE_GLOBAL;		-- ALU Op Code Word Size in case explicit coding is used

	signal Clock		: std_logic := '0';
	signal Reset		: std_logic := '1';

	component DLX

		generic (	IR_SIZE		: integer := IR_SIZE_GLOBAL;		-- Instruction Register Size		/ 32 bits
				PC_SIZE		: integer := PC_SIZE_GLOBAL;		-- Program Counter Size			/ 32 bits
				DRAM_SIZE	: integer := DRAM_WORD_SIZE_GLOBAL);	-- DRAM Word Size			/ 32 bits

		port (		CLK	: in std_logic;
				RST	: in std_logic);		-- Active Low

	end component;


begin

	-- instance of DLX
	U1: DLX

		generic map (IR_SIZE, PC_SIZE)
		port map (Clock, Reset);

	PCLOCK: process(Clock)
	begin
		Clock <= not(Clock) after 0.5 ns;
	end process;

	Reset <= '0', '1' after 6 ns; -- '0' after 11 ns, '1' after 15 ns;

end TEST;


configuration CFG_TB of TB_DLX is
	for TEST
	end for;
end CFG_TB;
