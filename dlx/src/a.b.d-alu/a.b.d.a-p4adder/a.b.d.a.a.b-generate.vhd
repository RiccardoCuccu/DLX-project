library ieee;
use ieee.std_logic_1164.all;

entity GENERATE_BLOCK is
	port (
		Gik:	in	std_logic;	-- G_{i:k}
		Gkj:	in	std_logic;	-- G_{k-1:j}
		Pik:	in	std_logic;	-- P_{i:k}
		Gij:	out	std_logic);	-- G_{i:j}
end GENERATE_BLOCK;

architecture BEHAVIORAL of GENERATE_BLOCK is
begin

	Gij <= Gik or (Pik and Gkj);		-- G_{i:j} = G_{i:k} + P_{i:k} * G_{k-1:j}

end BEHAVIORAL;

configuration CFG_GENERATE_BLOCK_BEHAVIORAL of GENERATE_BLOCK is
	for BEHAVIORAL 
	end for;
end CFG_GENERATE_BLOCK_BEHAVIORAL;
