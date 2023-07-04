library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;
use work.constants.all;

entity SUM_GENERATOR is -- Sum Generator

	generic (	N:	integer := ALU_OP_SIZE_GLOBAL;
			NB:	integer := ALU_BLOCK_SIZE_GLOBAL);

	port (		A:	in	std_logic_vector(N-1 downto 0);
			B:	in	std_logic_vector(N-1 downto 0);
			Ci:	in	std_logic_vector(NB-1 downto 0);
			S:	out	std_logic_vector(N-1 downto 0));
			-- Ovf:	out	std_logic);

end SUM_GENERATOR;

architecture STRUCTURAL of SUM_GENERATOR is

	component CSB
	generic (N : integer := ALU_OP_RCA_SIZE_GLOBAL);
	port (	A:	in	std_logic_vector(N-1 downto 0);
		B:	in	std_logic_vector(N-1 downto 0);
		Ci:	in	std_logic;
		S:	out	std_logic_vector(N-1 downto 0));
		-- Ovf:	out	std_logic);
	end component;

begin

	SUMGEN: for I in 1 to NB generate
		CSBI : CSB
		port map (A(I*ALU_OP_RCA_SIZE_GLOBAL-1 downto (I-1)*ALU_OP_RCA_SIZE_GLOBAL), B(I*ALU_OP_RCA_SIZE_GLOBAL-1 downto (I-1)*ALU_OP_RCA_SIZE_GLOBAL), Ci(I-1), S(I*ALU_OP_RCA_SIZE_GLOBAL-1 downto (I-1)*ALU_OP_RCA_SIZE_GLOBAL)); 
	end generate;

end STRUCTURAL;

configuration CFG_SUM_GENERATOR_STRUCTURAL of SUM_GENERATOR is
	for STRUCTURAL 
		for SUMGEN
			for all : CSB
				use configuration WORK.CFG_CSB_STRUCTURAL;
			end for;
		end for;
	end for;
end CFG_SUM_GENERATOR_STRUCTURAL;
