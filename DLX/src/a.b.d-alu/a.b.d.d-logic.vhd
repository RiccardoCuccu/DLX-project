----------------------------------------------------------------------------------------------------
-- Description:	This module implements logical operations (AND, OR, XOR) within the ALU. The type
--		of logical operation is controlled by a 2-bit selector signal (S). Based on the
--		value of S, the operation is chosen as follows: "00" = AND; "01" = OR; "10" = XOR.
--
-- Author:	Riccardo Cuccu
-- Date:	2023/09/09
----------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.constants.all;

entity LOGIC is

	generic (	N:	integer	:= ALU_OP_SIZE_GLOBAL);			-- / 32 bits

	port (		A:	in	std_logic_vector(N - 1 downto 0);	-- Operand 1		/ 32 bits
			B:	in	std_logic_vector(N - 1 downto 0);	-- Operand 2		/ 32 bits
			S:	in	std_logic_vector(1 downto 0);		-- Selector		/  2 bits
			Y:	out	std_logic_vector(N - 1 downto 0));	-- Result		/ 32 bits

end LOGIC;


architecture BEHAVIORAL of LOGIC is
begin

	process(A, B, S)
	begin
		case S is

			when "00" => Y <= A and B;
			when "01" => Y <= A or B;
			when "10" => Y <= A xor B;
			when others => Y <= (others => '0');

		end case;
	end process;

end BEHAVIORAL;


configuration CFG_LOGIC_GEN_BEHAVIORAL of LOGIC is
	for BEHAVIORAL
	end for;
end CFG_LOGIC_GEN_BEHAVIORAL;
