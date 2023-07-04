library ieee;
use ieee.std_logic_1164.all;
use work.constants.all;

entity MUX21 is

	generic (	N:	integer := ALU_OP_MUX_SIZE_GLOBAL);

	port (		A:	in	std_logic_vector(N-1 downto 0) ;
			B:	in	std_logic_vector(N-1 downto 0);
			S:	in	std_logic;
			Y:	out	std_logic_vector(N-1 downto 0));

end MUX21;

architecture BEHAVIORAL of MUX21 is

begin
	process(A, B, S)
		begin
			for i in 0 to N-1 loop
				Y(i) <= (A(i) and S) or (B(i) and not(S));
			end loop;
	end process;

end BEHAVIORAL;


configuration CFG_MUX21_BEHAVIORAL of MUX21 is
	for BEHAVIORAL
	end for;
end CFG_MUX21_BEHAVIORAL;
