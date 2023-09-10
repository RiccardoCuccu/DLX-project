----------------------------------------------------------------------------------------------------
-- Description:	This module serves as the Data RAM (DRAM) placeholder.
--
-- Author:	Riccardo Cuccu
-- Date:	2023/09/10
----------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.constants.all;

entity DLX_DRAM is

	generic (	N	: integer := DRAM_SIZE_GLOBAL;			-- DRAM size			/ 256 addresses
			NW	: integer := DRAM_WORD_SIZE_GLOBAL);		-- DRAM registers size		/ 32 bits

	port (		CLK	: in std_logic;					-- Clock
			RST	: in std_logic;					-- Reset:Active-Low
			RE	: in std_logic;					-- Read Enable
			WE	: in std_logic;					-- Write Enable
			ADDR	: in std_logic_vector(NW - 1 downto 0);		-- Address
			DIN	: in std_logic_vector(NW - 1 downto 0);		-- Data in
			DOUT	: out std_logic_vector(NW - 1 downto 0));	-- Data out

end DLX_DRAM;


architecture BEHAVIORAL of DLX_DRAM is
begin

end BEHAVIORAL;


configuration CFG_DRAM_BEHAVIORAL of DLX_DRAM is
	for BEHAVIORAL
	end for;
end CFG_DRAM_BEHAVIORAL;
