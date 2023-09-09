library ieee;
use ieee.std_logic_1164.all;
use work.constants.all;

-- Logic Multiplexer 4-to-1

entity MUX41_L is

	port	(	A	: in	std_logic;
			B	: in	std_logic;
			C	: in	std_logic;
			D	: in	std_logic;
			S	: in	std_logic_vector(1 downto 0);
			Y	: out	std_logic);
end MUX41_L;


architecture BEHAVIORAL of MUX41_L is

begin

	process (A, B, C, D, S)
	begin
		case S is
			when "00" => Y <= A;
			when "01" => Y <= B;
			when "10" => Y <= C;
			when "11" => Y <= D;
			when others => Y <= '0';
		end case;
	end process;

end BEHAVIORAL;


configuration CFG_MUX41_L_BEHAVIORAL of MUX41 is
	for BEHAVIORAL
	end for;
end CFG_MUX41_L_BEHAVIORAL;
