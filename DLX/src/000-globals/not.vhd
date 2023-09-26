library ieee;
use ieee.std_logic_1164.all;

-- Logic NOT

entity NOT1 is

	port	(	A	: in std_logic;
			Y	: out std_logic);

end NOT1;


architecture BEHAVIORAL of NOT1 is

begin
	process (A)
	begin
		Y <= not A;
	end process;

end BEHAVIORAL;


configuration CFG_NOT_BEHAVIORAL of NOT1 is
	for BEHAVIORAL
	end for;
end CFG_NOT_BEHAVIORAL;
