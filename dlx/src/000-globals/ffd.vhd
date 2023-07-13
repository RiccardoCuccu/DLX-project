library ieee;
use ieee.std_logic_1164.all;
use work.constants.all;

-- Flip-flop D (edge triggered) with syncronous reset

entity FFD is
	
	port	(	CLK:	in	std_logic;
			RST:	in	std_logic;
			EN:	in	std_logic;
			D:	in	std_logic;
			Q:	out	std_logic);
end FFD;


architecture BEHAVIORAL of FFD is

begin
	process(CLK, RST, EN)
	begin
		if (CLK'event and CLK = '1') then	-- positive edge trigger
			if (RST = '0') then		-- active low reset
				Q <= '0'; 
			elsif (EN = '1') then		-- enable signal
				Q <= D;
			end if;
		end if;
	end process;

end BEHAVIORAL;


configuration CFG_FFD_GEN_BEHAVIORAL of FFD is
	for BEHAVIORAL
	end for;
end CFG_FFD_GEN_BEHAVIORAL;
