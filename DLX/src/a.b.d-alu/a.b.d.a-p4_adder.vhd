----------------------------------------------------------------------------------------------------
-- Description:	This module acts as the top-level entity for a parallel 4-bit adder (P4 Adder) within a DLX
--		architecture. It comprises two main components: a Sum Generator and a Carry Generator.
--		The Sum Generator is responsible for generating the sum output, whereas the Carry Generator
--		calculates intermediate and output carries.
--
-- Author:	Riccardo Cuccu
-- Date:	2023/09/09
----------------------------------------------------------------------------------------------------

library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;
use work.constants.all;

entity P4_ADDER is 

	generic (	N:	integer := ALU_OP_SIZE_GLOBAL;			-- / 32 bits
			NB:	integer := ALU_BLOCK_SIZE_GLOBAL);		-- /  8 bits

	port (		A:	in	std_logic_vector(N - 1 downto 0);	-- Operand 1		/ 32 bit
			B:	in	std_logic_vector(N - 1 downto 0);	-- Operand 2		/ 32 bit
			Ci:	in	std_logic;				-- Carry in
			S:	out	std_logic_vector(N - 1 downto 0);	-- Result		/ 32 bit
			Co:	out	std_logic);				-- Carry out
			-- Ovf:	out	std_logic);
end P4_ADDER;


architecture STRUCTURAL of P4_ADDER is

	component SUM_GENERATOR is -- Sum Generator

		generic (	N:	integer := ALU_OP_SIZE_GLOBAL;			-- / 32 bits
				NB:	integer := ALU_BLOCK_SIZE_GLOBAL);		-- /  8 bits

		port	(	A:	in	std_logic_vector(N - 1 downto 0);	-- Operand 1		/ 32 bit
				B:	in	std_logic_vector(N - 1 downto 0);	-- Operand 2		/ 32 bit
				Ci:	in	std_logic_vector(NB - 1 downto 0);	-- Carry in
				S:	out	std_logic_vector(N - 1 downto 0));	-- Result		/ 32 bit
				-- Ovf:	out	std_logic);

	end component;

	component CARRY_GENERATOR is -- Carry Generator

		generic (	N:	integer := ALU_OP_SIZE_GLOBAL;			-- / 32 bits
				NB:	integer := ALU_BLOCK_SIZE_GLOBAL);		-- /  8 bits

		port 	(	A:	in	std_logic_vector(N - 1 downto 0);	-- Operand 1		/ 32 bit
				B:	in	std_logic_vector(N - 1 downto 0);	-- Operand 2		/ 32 bit
				Ci:	in	std_logic;				-- Carry in
				Co:	out	std_logic_vector(NB - 1 downto 0));	-- Carry out		/  8 bit

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
