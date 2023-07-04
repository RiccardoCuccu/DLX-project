library ieee;
use ieee.std_logic_1164.all;
use work.constants.all;

entity LOGIC is

	generic (	N: integer := ALU_OP_SIZE_GLOBAL);

	port (		A:	in	std_logic_vector(N - 1 downto 0);	-- Operand 1
			B:	in	std_logic_vector(N - 1 downto 0);	-- Operand 2
			OP:	in	std_logic_vector(1 downto 0);		-- Operation ("00" = AND; "11" = OR; "10" = XOR)
			S:	out	std_logic_vector(N - 1 downto 0));	-- Result

end LOGIC;


architecture BEHAVIORAL of LOGIC is
begin

	process(A, B, OP)	
	begin
		case(OP) is

			when "00" => S <= A and B;
			when "01" => S <= A or B;
			when "10" => S <= A xor B;
			when others => S <= (others => '0');

		end case;
	end process;

end BEHAVIORAL;