library ieee;
use ieee.std_logic_1164.all;
use work.constants.all;

entity PG_ROW is
	
	generic (	N:	integer := ALU_OP_SIZE_GLOBAL);

	port (		A:	in	std_logic_vector(N-1 downto 0);
			B:	in	std_logic_vector(N-1 downto 0);
			Ci:	in	std_logic;
			P:	out	std_logic_vector(N-1 downto 0);
			G:	out	std_logic_vector(N-1 downto 0));

end PG_ROW;

architecture BEHAVIORAL of PG_ROW is

begin
	PG_LOOP: process (A, B, Ci) begin

		P(0) <= A(0) xor B(0);
		G(0) <= (A(0) and B(0)) or ((A(0) xor B(0)) and Ci);

		for i in 1 to N-1 loop
			P(i) <= A(i) xor B(i);	-- p_i = a_i ⊕ b_i
			G(i) <= A(i) and B(i);	-- g_i = a_i * b_i
		end loop;

	end process;

end BEHAVIORAL;
