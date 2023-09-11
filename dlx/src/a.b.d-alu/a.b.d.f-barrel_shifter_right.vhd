----------------------------------------------------------------------------------------------------
-- Description:	This VHDL module performs the right-shifting operation within the ALU. It takes a
--		32-bit operand A, another 32-bit operand B, which specifies the number of
--		right-shifts to perform on A and a 1-bit shift type identifier (S). The shift
--		type is either logical (S='0') or arithmetic (S='1').
--
-- Author:	Riccardo Cuccu
-- Date:	2023/09/09
----------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.constants.all;
use work.functions.all;

entity BARREL_SHIFTER_RIGHT is

	generic (	N:	integer := ALU_OP_SIZE_GLOBAL);			-- / 32 bits

	port (		A:	in	std_logic_vector(N - 1 downto 0);	-- Operand		/ 32 bit
			B:	in	std_logic_vector(N - 1 downto 0);	-- Number of Shifts	/ 32 bit
			S:	in	std_logic;				-- Shif Type		/  2 bit
			Y:	out	std_logic_vector(N - 1 downto 0));	-- Result		/ 32 bit

end BARREL_SHIFTER_RIGHT;


architecture STRUCTURAL of BARREL_SHIFTER_RIGHT is

	component MUX21_L is

		port	(	A:	in	std_logic;
				B:	in	std_logic;
				S:	in	std_logic;
				Y:	out	std_logic);

	end component;

	type signalvector is array (log2(N) downto 0) of std_logic_vector (N - 1 downto 0);
	signal TMP : signalvector := ((others => (others => '0')));

	begin
	
		TMP(0) <= A;
	
		COLUMNS : for i in 0 to log2(N) - 1 generate
			
			-- Mapping the bits according to shifting logic
			MUX21_K : for j in 0 to N - pow2(i) - 1 generate
				MUX21_K : MUX21_L
				port map(TMP(i)(j), TMP(i)(j + pow2(i)), B(i), TMP(i + 1)(j));
			end generate;
	
			-- Handling the top bits based on the shift type
			MUX21_0 : for j in 0 to pow2(i) - 1 generate
				MUX21_J : MUX21_L
				-- Using S to choose between arithmetic (S = 1) and logical (S = 0) shift for the top bits
				port map(TMP(i)(N - pow2(i) + j), S, B(i), TMP(i + 1)(N - pow2(i) + j));
			end generate;
	
		end generate;
	
		Y <= TMP(log2(N));

end architecture;
