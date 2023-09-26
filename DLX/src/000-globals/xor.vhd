library ieee;
use ieee.std_logic_1164.all;

-- Logic XOR

entity XOR2 is

	port	(	A	: in std_logic;
			B	: in std_logic;
			Y	: out std_logic);

end XOR2;


architecture BEHAVIORAL of XOR2 is

begin
	process (A, B)
	begin
		Y <= (A xor B);
	end process;

end BEHAVIORAL;


configuration CFG_XOR_BEHAVIORAL of XOR2 is
	for BEHAVIORAL
	end for;
end CFG_XOR_BEHAVIORAL;
