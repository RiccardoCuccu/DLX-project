----------------------------------------------------------------------------------------------------
-- Description:	This module serves as the Instruction RAM (IRAM) placeholder.
--
-- Author:	Riccardo Cuccu
-- Date:	2023/09/10
----------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.constants.all;

entity DLX_IRAM is
	
	generic (	RAM_DEPTH	: integer := IRAM_SIZE_GLOBAL;
			I_SIZE		: integer := IR_SIZE_GLOBAL);

	port (		RST		: in  std_logic;
			ADDR		: in  std_logic_vector(I_SIZE - 1 downto 0);
			DOUT		: out std_logic_vector(I_SIZE - 1 downto 0));

end DLX_IRAM;

architecture BEHAVIORAL of DLX_IRAM is
begin

end BEHAVIORAL;

configuration CFG_IRAM_BEHAVIORAL of DLX_IRAM is
	for BEHAVIORAL
	end for;
end CFG_IRAM_BEHAVIORAL;
