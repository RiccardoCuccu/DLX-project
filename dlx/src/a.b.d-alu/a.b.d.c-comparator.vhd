library ieee;
use ieee.std_logic_1164.all;
use work.constants.all;

entity COMPARATOR is

	generic (	N: integer := ALU_OP_SIZE_GLOBAL);

	port (		A:	in	std_logic_vector(N - 1 downto 0);	-- Operand 1
			B:	in	std_logic_vector(N - 1 downto 0);	-- Operand 2
			S:	out	std_logic);				-- Result

end COMPARATOR;


architecture BEHAVIORAL of COMPARATOR is
begin

	process(A, B)
	begin
		if (A = B) then
			S <= '1';
		else
			S <= '0';
		end if;
	end process;

end BEHAVIORAL;
