library ieee;
use ieee.std_logic_1164.all;

-- Logic NOR

entity NOR2 is

	port	(	A	: in std_logic;
			B	: in std_logic;
			Y	: out std_logic);

end NOR2;


architecture BEHAVIORAL of NOR2 is

begin
	process (A, B)
	begin
		Y <= not(A or B);
	end process;

end BEHAVIORAL;


configuration CFG_NOR_BEHAVIORAL of NOR2 is
	for BEHAVIORAL
	end for;
end CFG_NOR_BEHAVIORAL;
