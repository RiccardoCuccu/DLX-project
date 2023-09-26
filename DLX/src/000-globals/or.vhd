library ieee;
use ieee.std_logic_1164.all;

-- Logic OR

entity OR2 is

	port	(	A	: in std_logic;
			B	: in std_logic;
			Y	: out std_logic);

end OR2;


architecture BEHAVIORAL of OR2 is

begin
	process (A, B)
	begin
		Y <= (A or B);
	end process;

end BEHAVIORAL;


configuration CFG_OR_BEHAVIORAL of OR2 is
	for BEHAVIORAL
	end for;
end CFG_OR_BEHAVIORAL;
