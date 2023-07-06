library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use work.constants.all;

entity DRAM is

	generic (	N	: integer := DRAM_SIZE_GLOBAL;
			NW	: integer := DRAM_WORD_SIZE_GLOBAL);

	port (		CLK	: in std_logic;					-- Clock
			RST	: in std_logic;					-- Reset:Active-Low
			RE	: in std_logic;					-- Read Enable
			WE	: in std_logic;					-- Write Enable
			ADDR	: in std_logic_vector(NW - 1 downto 0);		-- Address
			Din	: in std_logic_vector(NW - 1 downto 0);		-- Data in
			Dout	: out std_logic_vector(NW - 1 downto 0));	-- Data out

end DRAM;


architecture BEHAVIORAL of DRAM is

	type RAMtype is array (0 to N - 1) of std_logic_vector(NW-1 downto 0);

	signal DRAM_mem : RAMtype;

begin

	WRITE: process(RST, CLK)		-- synchronous
	begin
		if RST = '1' then
			DRAM_mem <= (others => (others => '0'));
		elsif rising_edge(CLK) then
			if(WE = '1' ) then
				DRAM_mem(to_integer(unsigned(ADDR))) <= Din;
			end if;
		end if;
	end process;

	READ: process(RE, ADDR)			-- asynchronous
	begin
		if RE = '1' then
			Dout <= DRAM_mem(to_integer(unsigned(ADDR)));
		end if;
	end process;

end BEHAVIORAL;

configuration CFG_DRAM_BEHAVIORAL of DRAM is
	for BEHAVIORAL
	end for;
end CFG_DRAM_BEHAVIORAL;
