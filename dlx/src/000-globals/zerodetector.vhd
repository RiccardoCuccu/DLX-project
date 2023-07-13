library ieee;
use ieee.std_logic_1164.all;
use work.constants.all;
use work.functions.all;

-- Zero Detector: "Y" is one if all elements of vector "A" are zero.

entity ZERODET is

	generic	(	N	: integer := SIZE_GLOBAL);

	port	(	A	: in	std_logic_vector(N - 1 downto 0);
			Y	: out	std_logic);

end ZERODET;


architecture STRUCTURAL of ZERODET is

type matrix is array (log2(N) downto 0) of std_logic_vector(N - 1 downto 0);
signal M: matrix;

component AND2 is

	port	(	A	: in std_logic;
			B	: in std_logic;
			Y	: out std_logic);

end component;

component XNOR2 is

	port	(	A	: in std_logic;
			B	: in std_logic;
			Y	: out std_logic);

end component;

begin

	ROW_i: for ROW in 0 to log2(N) generate
		COL_i: for i in 0 to N/(2**ROW)-1 generate
			lev_0: if(ROW = 0) generate
				XOR0_i:	XNOR2 port map(A => A(i), B => '0', Y => M(ROW)(i));
			end generate lev_0;
			lev_i: if(ROW > 0) generate
				AND_i:	AND2 port map(A => M(ROW-1)(2*i), B => M(ROW-1)(2*i+1), Y => M(ROW)(i));
			end generate lev_i;
		end generate COL_i;
	end generate ROW_i;

	Y <= M(log2(N))(0);

end STRUCTURAL;


configuration CFG_ZERODET_GEN_STRUCTURAL of ZERODET is
	for STRUCTURAL
		for ROW_i
			for COL_i
				for lev_0
					for all: XNOR2
						use configuration WORK.CFG_XNOR_BEHAVIORAL;
					end for;
				end for;
				for lev_i
					for all: AND2
						use configuration WORK.CFG_AND_BEHAVIORAL;
					end for;
				end for;
			end for;
		end for;
	end for;
end CFG_ZERODET_GEN_STRUCTURAL;
