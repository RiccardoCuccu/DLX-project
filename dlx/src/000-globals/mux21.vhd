library ieee;
use ieee.std_logic_1164.all;
use work.constants.all;

-- Multiplexer 2-to-1

entity MUX21 is
	generic	(	N	: integer := SIZE_GLOBAL);

	port	(	A	: in	std_logic_vector(N - 1 downto 0);
			B	: in	std_logic_vector(N - 1 downto 0);
			S	: in	std_logic;
			Y	: out	std_logic_vector(N - 1 downto 0));
end MUX21;


architecture BEHAVIORAL of MUX21 is

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


configuration CFG_MUX21_GEN_BEHAVIORAL of MUX21 is
	for BEHAVIORAL
	end for;
end CFG_MUX21_GEN_BEHAVIORAL;
