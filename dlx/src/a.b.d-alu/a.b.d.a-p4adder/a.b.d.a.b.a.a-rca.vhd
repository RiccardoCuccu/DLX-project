library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;
use work.constants.all;

entity RCA is

	generic (	N:	integer := ALU_OP_RCA_SIZE_GLOBAL);

	port (		A:	in	std_logic_vector(N-1 downto 0);
			B:	in	std_logic_vector(N-1 downto 0);
			Ci:	in	std_logic;
			S:	out	std_logic_vector(N-1 downto 0);
			Co:	out	std_logic);

end RCA; 

architecture STRUCTURAL of RCA is

	signal STMP : std_logic_vector(N-1 downto 0);
	signal CTMP : std_logic_vector(N downto 0);

	component FA 
	port (	A:	in	std_logic;
		B:	in	std_logic;
		Ci:	in	std_logic;
		S:	out	std_logic;
		Co:	out	std_logic);
	end component; 

begin

	CTMP(0) <= Ci;
	S <= STMP;
	Co <= CTMP(N);
	-- Ovf <= CTMP(N) xor CTMP(N-1);
	
	ADDER1: for I in 1 to N generate
		FAI : FA
		port map (A(I-1), B(I-1), CTMP(I-1), STMP(I-1), CTMP(I)); 
	end generate;

end STRUCTURAL;


architecture BEHAVIORAL of RCA is

	signal ATMP : std_logic_vector(N downto 0);
	signal BTMP : std_logic_vector(N downto 0);
	signal CTMP : std_logic_vector(N downto 0);
	signal ZEROES : std_logic_vector(N-1 downto 0) := (others => '0');
	signal STMP : std_logic_vector(N downto 0);

begin

	ATMP <= '0' & A;
	BTMP <= '0' & B;
	CTMP <= ZEROES & Ci;
	STMP <= ATMP + BTMP + CTMP;
	
	S <= STMP(N-1 downto 0);
	Co <= STMP(N);
	-- Ovf <= CTMP(N) xor CTMP(N-1);

end BEHAVIORAL;


configuration CFG_RCA_STRUCTURAL of RCA is
	for STRUCTURAL 
		for ADDER1
			for all : FA
				use configuration WORK.CFG_FA_BEHAVIORAL;
			end for;
		end for;
	end for;
end CFG_RCA_STRUCTURAL;

configuration CFG_RCA_BEHAVIORAL of RCA is
	for BEHAVIORAL 
	end for;
end CFG_RCA_BEHAVIORAL;
