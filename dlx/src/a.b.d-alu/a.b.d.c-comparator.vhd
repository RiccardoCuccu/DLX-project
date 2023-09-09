----------------------------------------------------------------------------------------------------
-- Description:	This module acts as a comparator within the ALU. It takes two 32-bit operands
--		and a 4-bit selector as inputs. Depending on the value of the selector, the
--		module will compare A and B based on various conditions (e.g., equality,
--		less than, greater than, etc.) and will output the result as a 32-bit value,
--		rather than a single bit flag.
--
-- Author:	Riccardo Cuccu
-- Date:	2023/09/09
----------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.constants.all;

entity COMPARATOR is

	generic (	N:	integer	:= ALU_OP_SIZE_GLOBAL);			-- / 32 bits

	port (		A:	in	std_logic_vector(N - 1 downto 0);	-- Operand 1		/ 32 bits
			B:	in	std_logic_vector(N - 1 downto 0);	-- Operand 2		/ 32 bits
			S:	in	std_logic_vector(3 downto 0);		-- Selector		/  4 bits
			Y:	out	std_logic_vector(N - 1 downto 0));	-- Result		/ 32 bits

end COMPARATOR;


architecture BEHAVIORAL of COMPARATOR is
begin

	process(A, B, S)
	begin
		case S is

			-- OP_SEQ | OP_SEQI
			when "0000" =>

				if (A = B) then
					Y <= std_logic_vector(to_unsigned(1, Y'length));
				else
					Y <= std_logic_vector(to_unsigned(0, Y'length));
				end if;

			-- OP_SNE | OP_SNEI
			when "0001" =>
				if (A /= B) then
					Y <= std_logic_vector(to_unsigned(1, Y'length));
				else
					Y <= std_logic_vector(to_unsigned(0, Y'length));
				end if;

			-- OP_SLT | OP_SLTI
			when "0010" =>
				if (signed(A) < signed(B)) then
					Y <= std_logic_vector(to_unsigned(1, Y'length));
				else
					Y <= std_logic_vector(to_unsigned(0, Y'length));
				end if;

			-- OP_SLTU | OP_SLTUI
			when "0011" =>
				if (unsigned(A) < unsigned(B)) then
					Y <= std_logic_vector(to_unsigned(1, Y'length));
				else
					Y <= std_logic_vector(to_unsigned(0, Y'length));
				end if;

			-- OP_SGT | OP_SGTI
			when "0100" =>	
				if (signed(A) > signed(B)) then
					Y <= std_logic_vector(to_unsigned(1, Y'length));
				else
					Y <= std_logic_vector(to_unsigned(0, Y'length));
				end if;

			-- OP_SGTU | OP_SGTUI
			when "0101" =>	
				if (unsigned(A) > unsigned(B)) then
					Y <= std_logic_vector(to_unsigned(1, Y'length));
				else
					Y <= std_logic_vector(to_unsigned(0, Y'length));
				end if;

			-- OP_SLE | OP_SLEI
			when "0110" =>
				if (signed(A) <= signed(B)) then
					Y <= std_logic_vector(to_unsigned(1, Y'length));
				else
					Y <= std_logic_vector(to_unsigned(0, Y'length));
				end if;

			-- OP_SLEU | OP_SLEUI
			when "0111" =>
				if (unsigned(A) <= unsigned(B)) then
					Y <= std_logic_vector(to_unsigned(1, Y'length));
				else
					Y <= std_logic_vector(to_unsigned(0, Y'length));
				end if;

			-- OP_SGE | OP_SGEI
			when "1000" =>	
				if (signed(A) >= signed(B)) then
					Y <= std_logic_vector(to_unsigned(1, Y'length));
				else
					Y <= std_logic_vector(to_unsigned(0, Y'length));
				end if;

			-- OP_SGEU | OP_SGEUI
			when "1001" =>
				if (unsigned(A) >= unsigned(B)) then
					Y <= std_logic_vector(to_unsigned(1, Y'length));
				else
					Y <= std_logic_vector(to_unsigned(0, Y'length));
				end if;

			when others =>
				Y <= (others => '0');

		end case;
	end process;

end BEHAVIORAL;
