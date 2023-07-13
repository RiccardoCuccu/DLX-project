library ieee;
use ieee.std_logic_1164.all;

-- Logic AND

entity AND2 is

	port	(	A	: in std_logic;
			B	: in std_logic;
			Y	: out std_logic);

end AND2;


architecture BEHAVIORAL of AND2 is

begin
	process (A, B)
	begin
		Y <= (A and B);
	end process;

end BEHAVIORAL;


configuration CFG_AND_BEHAVIORAL of AND2 is
	for BEHAVIORAL
	end for;
end CFG_AND_BEHAVIORAL;
