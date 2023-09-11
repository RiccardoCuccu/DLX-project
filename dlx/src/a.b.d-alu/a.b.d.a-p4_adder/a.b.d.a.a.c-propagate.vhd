library ieee;
use ieee.std_logic_1164.all;

entity PROPAGATE_BLOCK is
	port (
		Pik:	in	std_logic;	-- P_{i:k}
		Pkj:	in	std_logic;	-- P_{k-1:j}
		Pij:	out	std_logic);	-- P_{i:j}
end PROPAGATE_BLOCK;

architecture BEHAVIORAL of PROPAGATE_BLOCK is
begin

	Pij <= Pik and Pkj;			-- P_{i:j} = P_{i:k} * P_{k-1:j}

end BEHAVIORAL;

configuration CFG_PROPAGATE_BLOCK_BEHAVIORAL of PROPAGATE_BLOCK is
	for BEHAVIORAL 
	end for;
end CFG_PROPAGATE_BLOCK_BEHAVIORAL;
