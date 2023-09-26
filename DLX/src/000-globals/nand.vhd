library ieee;
use ieee.std_logic_1164.all;

-- Logic NAND

entity NAND2 is

	port	(	A	: in std_logic;
			B	: in std_logic;
			Y	: out std_logic);

end NAND2;


architecture BEHAVIORAL of NAND2 is

begin
	process (A, B)
	begin
		Y <= not(A nand B);
	end process;

end BEHAVIORAL;


configuration CFG_NAND_BEHAVIORAL of NAND2 is
	for BEHAVIORAL
	end for;
end CFG_NAND_BEHAVIORAL;
