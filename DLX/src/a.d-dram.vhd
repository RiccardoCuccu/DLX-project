----------------------------------------------------------------------------------------------------
-- Description:	This DRAM module is designed to act as a memory unit in a DLX architecture. 
--		The DRAM can be both read from and written to but is only accessible via
--		specific load and store commands.
--
-- Author:	Riccardo Cuccu
-- Date:	2023/09/10
----------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.constants.all;

entity DLX_DRAM is

	generic (	N	: integer := DRAM_SIZE_GLOBAL;			-- DRAM size			/ 256 addresses
			NW	: integer := DRAM_WORD_SIZE_GLOBAL);		-- DRAM registers size		/ 32 bits

	port (		CLK	: in std_logic;					-- Clock
			RST	: in std_logic;					-- Reset:Active-Low
			RE	: in std_logic;					-- Read Enable
			WE	: in std_logic;					-- Write Enable
			ADDR	: in std_logic_vector(NW - 1 downto 0);		-- Address			/ 32 bits
			DIN	: in std_logic_vector(NW - 1 downto 0);		-- Data in			/ 32 bits
			DOUT	: out std_logic_vector(NW - 1 downto 0));	-- Data out			/ 32 bits

end DLX_DRAM;


architecture BEHAVIORAL of DLX_DRAM is

	-- Define DRAM as an array of std_logic_vector
	type RAMtype is array (0 to N - 1) of std_logic_vector(NW-1 downto 0);
	signal DRAM_mem : RAMtype;

	begin

		-- Process for handling synchronous write operations
		REGISTER_WRITE: process(CLK, RST)
		begin
			-- Reset all memory locations to zero when RST is low
			if RST = '0' then
				DRAM_mem <= (others => (others => '0'));
			-- Write data to DRAM when clock rises and WE is high
			elsif rising_edge(CLK) then
				if(WE = '1' ) then
					DRAM_mem(to_integer(unsigned(ADDR))) <= DIN;
				end if;
			end if;
		end process;

		-- Process for handling asynchronous read operations
		REGISTER_READ: process(RST, RE, ADDR)
		begin
			-- Reset the output to zero when RST is low
			if RST = '0' then
				DOUT <= (others => '0');
			-- Read data from DRAM when RE is high
			elsif RE = '1' then
				DOUT <= DRAM_mem(to_integer(unsigned(ADDR)));
			end if;
		end process;

end BEHAVIORAL;


configuration CFG_DRAM_BEHAVIORAL of DLX_DRAM is
	for BEHAVIORAL
	end for;
end CFG_DRAM_BEHAVIORAL;
