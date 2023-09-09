----------------------------------------------------------------------------------------------------
-- Description:	This VHDL module performs the left-shifting operation within the ALU. It takes a
--		32-bit operand A and another 32-bit operand B, which specifies the number of
--		left-shifts to perform on A.
--
-- Author:	Riccardo Cuccu
-- Date:	2023/09/09
----------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.constants.all;
use work.functions.all;

entity BARREL_SHIFTER_LEFT is

	generic (	N:	integer := ALU_OP_SIZE_GLOBAL);			-- / 32 bits

	port (		A:	in	std_logic_vector(N - 1 downto 0);	-- Operand		/ 32 bit
			B:	in	std_logic_vector(N - 1 downto 0);	-- Number of Shifts	/ 32 bit
			Y:	out	std_logic_vector(N - 1 downto 0));	-- Result		/ 32 bit

end BARREL_SHIFTER_LEFT;


architecture STRUCTURAL of BARREL_SHIFTER_LEFT is

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

		COLUMNS : for i in 0 to log2(n) - 1 generate

			MUX21_0 : for j in 0 to pow2(i) - 1 generate
				MUX21_J : MUX21_L
				port map(TMP(i)(j), '0', B(i), TMP(i + 1)(j));
			end generate;

			MUX21_K : for k in 0 to n - pow2(i) - 1 generate
				MUX21_K : MUX21_L
				port map(TMP(i)(pow2(i) + k), TMP(i)(k), B(i), TMP(i + 1)(pow2(i) + k));
			end generate;

		end generate;

		Y <= TMP(log2(N));

end architecture;
