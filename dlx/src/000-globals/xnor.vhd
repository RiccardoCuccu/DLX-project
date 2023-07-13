library ieee;
use ieee.std_logic_1164.all;

-- Logic XNOR

entity XNOR2 is

	port	(	A	: in std_logic;
			B	: in std_logic;
			Y	: out std_logic);

end XNOR2;


architecture BEHAVIORAL of XNOR2 is

begin
	process (A, B)
	begin
		Y <= not(A xor B);
	end process;

end BEHAVIORAL;


configuration CFG_XNOR_BEHAVIORAL of XNOR2 is
	for BEHAVIORAL
	end for;
end CFG_XNOR_BEHAVIORAL;
