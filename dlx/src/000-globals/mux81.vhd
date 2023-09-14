library ieee;
use ieee.std_logic_1164.all;
use work.constants.all;

-- Multiplexer 8-to-1

entity MUX81 is
	generic	(	N	: integer := SIZE_GLOBAL);

	port	(	A	: in	std_logic_vector(N - 1 downto 0);
			B	: in	std_logic_vector(N - 1 downto 0);
			C	: in	std_logic_vector(N - 1 downto 0);
			D	: in	std_logic_vector(N - 1 downto 0);
			E	: in	std_logic_vector(N - 1 downto 0);
			F	: in	std_logic_vector(N - 1 downto 0);
			G	: in	std_logic_vector(N - 1 downto 0);
			H	: in	std_logic_vector(N - 1 downto 0);
			S	: in	std_logic_vector(2 downto 0);
			Y	: out	std_logic_vector(N - 1 downto 0));
end MUX81;


architecture BEHAVIORAL of MUX81 is

begin

	process (A, B, C, D, E, F, G, H, S)
	begin
		case S is
			when "000" => Y <= A;
			when "001" => Y <= B;
			when "010" => Y <= C;
			when "011" => Y <= D;
			when "100" => Y <= E;
			when "101" => Y <= F;
			when "110" => Y <= G;
			when "111" => Y <= H;
			when others => Y <= (others => '0');
		end case;
	end process;

end BEHAVIORAL;


configuration CFG_MUX81_GEN_BEHAVIORAL of MUX81 is
	for BEHAVIORAL
	end for;
end CFG_MUX81_GEN_BEHAVIORAL;
