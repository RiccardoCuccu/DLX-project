library ieee;
use ieee.std_logic_1164.all;
use work.constants.all;

-- Logic Multiplexer 2-to-1

entity MUX21_L is

	port	(	A	: in	std_logic;
			B	: in	std_logic;
			S	: in	std_logic;
			Y	: out	std_logic);

end MUX21_L;


architecture BEHAVIORAL of MUX21_L is

begin

	process (A, B, S)
	begin
		if (S = '0') then
			Y <= A;
		else
			Y <= B;
		end if;
	end process;

end BEHAVIORAL;


configuration CFG_MUX21_L_BEHAVIORAL of MUX21_L is
	for BEHAVIORAL
	end for;
end CFG_MUX21_L_BEHAVIORAL;
