library ieee;
use ieee.std_logic_1164.all;
use work.constants.all;

entity MUX41 is
	generic	(	N	: integer := 32);

	port	(	A	: in	std_logic_vector(N - 1 downto 0);
			B	: in	std_logic_vector(N - 1 downto 0);
			C	: in	std_logic_vector(N - 1 downto 0);
			D	: in	std_logic_vector(N - 1 downto 0);
			S	: in	std_logic_vector(1 downto 0);
			Y	: out	std_logic_vector(N - 1 downto 0));
end MUX41;


architecture BEHAVIORAL of MUX41 is

begin
	process (A, B, C, D, S)
	begin
		case S is
			when "00" => Y <= A;
			when "01" => Y <= B;
			when "10" => Y <= C;
			when "11" => Y <= D;
			when others => Y <= (others => '0');
		end case;
	end process;

end BEHAVIORAL;


configuration CFG_MUX41_GEN_BEHAVIORAL of MUX41 is
	for BEHAVIORAL
	end for;
end CFG_MUX41_GEN_BEHAVIORAL;
