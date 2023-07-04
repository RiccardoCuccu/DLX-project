library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;
use work.constants.all;

entity P4_ADDER is 

	generic (	N:	integer := ALU_OP_SIZE_GLOBAL;
			NB:	integer := ALU_BLOCK_SIZE_GLOBAL);

	port (		A:	in	std_logic_vector(N - 1 downto 0);
			B:	in	std_logic_vector(N - 1 downto 0);
			Ci:	in	std_logic;
			S:	out	std_logic_vector(N - 1 downto 0);
			Co:	out	std_logic);
			--Ovf:	out	std_logic);
end P4_ADDER;


architecture STRUCTURAL of P4_ADDER is

	component SUM_GENERATOR is -- Sum Generator
	
		generic (	N:	integer := ALU_OP_SIZE_GLOBAL;
				NB:	integer := ALU_BLOCK_SIZE_GLOBAL);
	
		port	(	A:	in	std_logic_vector(N - 1 downto 0);
				B:	in	std_logic_vector(N - 1 downto 0);
				Ci:	in	std_logic_vector(NB - 1 downto 0);
				S:	out	std_logic_vector(N - 1 downto 0));
				-- Ovf:	out	std_logic);
	
	end component;

	component CARRY_GENERATOR is -- Carry Generator
	
		generic (	N:	integer := ALU_OP_SIZE_GLOBAL;
				NB:	integer := ALU_BLOCK_SIZE_GLOBAL);
	
		port 	(	A:	in	std_logic_vector(N - 1 downto 0);
				B:	in	std_logic_vector(N - 1 downto 0);
				Ci:	in	std_logic;
				Co:	out	std_logic_vector(NB - 1 downto 0));
	
	end component;

	signal CarriesOut, CarriesIn: std_logic_vector (ALU_BLOCK_SIZE_GLOBAL - 1 downto 0);

	begin

		CARRY_GENERATOR_INSTANCE: CARRY_GENERATOR
		port map (A, B, Ci, CarriesOut);
		
		SUM_GENERATOR_INSTANCE: SUM_GENERATOR
		generic map (N, NB)
		port map (A, B, CarriesIn, S);
		
		CarriesIn <= CarriesOut(NB - 2 downto 0) & Ci;

		Co <= CarriesOut(NB - 1);

end STRUCTURAL;
