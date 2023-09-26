library ieee;
use ieee.std_logic_1164.all;

-- Logic XAND (equal to XNOR)

entity XAND2 is

	port	(	A	: in std_logic;
			B	: in std_logic;
			Y	: out std_logic);

end XAND2;


architecture BEHAVIORAL of XAND2 is

begin
	process (A, B)
	begin
		Y <= not(A xor B);
	end process;

end BEHAVIORAL;


configuration CFG_XAND_BEHAVIORAL of XAND2 is
	for BEHAVIORAL
	end for;
end CFG_XAND_BEHAVIORAL;
