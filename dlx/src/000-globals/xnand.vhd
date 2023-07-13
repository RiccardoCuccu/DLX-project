library ieee;
use ieee.std_logic_1164.all;

-- Logic XNAND (equal to XOR)

entity XNAND2 is

	port	(	A	: in std_logic;
			B	: in std_logic;
			Y	: out std_logic);

end XNAND2;


architecture BEHAVIORAL of XNAND2 is

begin
	process (A, B)
	begin
		Y <= (A xor B);
	end process;

end BEHAVIORAL;


configuration CFG_XNAND_BEHAVIORAL of XNAND2 is
	for BEHAVIORAL
	end for;
end CFG_XNAND_BEHAVIORAL;
