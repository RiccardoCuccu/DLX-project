library ieee;
use ieee.std_logic_1164.all;
use work.constants.all;

-- Latch D with reset

entity LD is

	port	(	RST:	in	std_logic;
			EN:	in	std_logic;
			D:	in	std_logic;
			Q:	out	std_logic);

end LD;

architecture BEHAVIORAL of LD is
begin

	process (RST, EN, D)
	begin
		if (RST = '0') then		-- active low reset
			Q <= '0'; 
		elsif (EN = '1') then		-- enable signal
			Q <= D;
		end if;
	end process;

end BEHAVIORAL;

configuration CFG_LD_GEN_BEHAVIORAL of LD is
	for BEHAVIORAL
	end for;
end CFG_LD_GEN_BEHAVIORAL;
