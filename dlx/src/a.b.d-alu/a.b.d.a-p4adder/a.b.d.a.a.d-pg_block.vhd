library ieee;
use ieee.std_logic_1164.all;

entity PG_BLOCK is
	port (
		Gik:	in	std_logic;	-- G_{i:k}
		Gkj:	in	std_logic;	-- G_{k-1:j}
		Pik:	in	std_logic;	-- P_{i:k}
		Pkj:	in	std_logic;	-- P_{k-1:j}
		Gij:	out	std_logic;	-- G_{i:j}
		Pij:	out	std_logic);	-- P_{i:j}
end PG_BLOCK;

architecture STRUCTURAL of PG_BLOCK is

component GENERATE_BLOCK
	port (
		Gik:	in	std_logic;	-- G_{i:k}
		Gkj:	in	std_logic;	-- G_{k-1:j}
		Pik:	in	std_logic;	-- P_{i:k}
		Gij:	out	std_logic);	-- G_{i:j}
end component;

component PROPAGATE_BLOCK
	port (
		Pik:	in	std_logic;	-- P_{i:k}
		Pkj:	in	std_logic;	-- P_{k-1:j}
		Pij:	out	std_logic);	-- P_{i:j}
end component;

begin

	G_BLOCK : GENERATE_BLOCK port map (Gik => Gik, Gkj => Gkj, Pik => Pik, Gij => Gij);	-- G_{i:j} = G_{i:k} + P_{i:k} * G_{k-1:j}
	P_BLOCK : PROPAGATE_BLOCK port map (Pik => Pik, Pkj => Pkj, Pij => Pij);		-- P_{i:j} = P_{i:k} * P_{k-1:j}

end STRUCTURAL;


architecture BEHAVIORAL of PG_BLOCK is

begin

	Gij <= Gik or (Pik and Gkj);		-- G_{i:j} = G_{i:k} + P_{i:k} * G_{k-1:j}
	Pij <= Pik and Pkj;			-- P_{i:j} = P_{i:k} * P_{k-1:j}

end BEHAVIORAL;

configuration CFG_PG_BLOCK_STRUCTURAL of PG_BLOCK is
	for STRUCTURAL
	end for;
end CFG_PG_BLOCK_STRUCTURAL;

configuration CFG_PG_BLOCK_BEHAVIORAL of PG_BLOCK is
	for BEHAVIORAL
	end for;
end CFG_PG_BLOCK_BEHAVIORAL;
