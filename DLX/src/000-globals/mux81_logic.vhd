library ieee;
use ieee.std_logic_1164.all;
use work.constants.all;

-- Logic Multiplexer 8-to-1

entity MUX81_L is

	port	(	A	: in	std_logic;
			B	: in	std_logic;
			C	: in	std_logic;
			D	: in	std_logic;
			E	: in	std_logic;
			F	: in	std_logic;
			G	: in	std_logic;
			H	: in	std_logic;
			S	: in	std_logic_vector(2 downto 0);
			Y	: out	std_logic);
end MUX81_L;


architecture BEHAVIORAL of MUX81_L is

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
			when others => Y <= '0';
		end case;
	end process;

end BEHAVIORAL;


configuration CFG_MUX81_L_GEN_BEHAVIORAL of MUX81_L is
	for BEHAVIORAL
	end for;
end CFG_MUX81_L_GEN_BEHAVIORAL;
