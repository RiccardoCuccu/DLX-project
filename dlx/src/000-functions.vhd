----------------------------------------------------------------------------------------------------
-- Description:	This VHDL package contains utility functions used throughout the DLX architecture.
--		The package includes three primary functions: 'divide', 'log2', and 'pow2'.
--		1. The 'divide' function performs integer division and rounds up if there is a remainder.
--		2. The 'log2' function calculates the base-2 logarithm of an integer, also rounding up.
--		3. The 'pow2' function calculates 2 raised to the power of a given integer.
--
-- Author:	Riccardo Cuccu
-- Date:	2023/09/09
----------------------------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;

package functions is

	-- Performs division and rounds up if there's a remainder
	function divide (n:integer; m:integer) return integer;

	-- Calculates the base-2 logarithm of an integer, rounding up
	function log2 (n:integer) return integer;

	-- Calculates 2 to the power of n
	function pow2 (n:integer) return integer;

end functions;

package body functions is

	function divide (n:integer; m:integer) return integer is
	begin

		if (n mod m) = 0 then
			return n/m;
		else
			return (n/m) + 1;
		end if;

	end divide;

	function log2 (n:integer) return integer is
	begin
		if n <=2 then
			return 1;
		else
			return 1 + log2(divide(n,2));
		end if;
	end log2;

	function pow2 (n:integer) return integer is
		variable result: integer := 1;
	begin
		if n = 0 then
			return 1;
		else
			for i in 1 to n loop
				result := result * 2;
			end loop;
			return result;
		end if;
	end pow2;

end functions;
