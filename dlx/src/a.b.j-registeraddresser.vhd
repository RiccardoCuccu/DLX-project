--------------------------------------------------------------------------------
-- Description:	This module is designed to accordingly set the RS1, RS2, and RD
--		register addresses. The module differentiates between 
--		R-Type, I-Type, and J-Type instructions based on the opcode
--		(IR_OPC).
-- Author:	Riccardo Cuccu
-- Date:	2023/09/01
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.constants.all;

entity REGADDR is

	generic (	N	: integer := IR_SIZE_GLOBAL;			-- / 32 bits
			OPC	: integer := OPC_SIZE_GLOBAL;			-- /  6 bits
			REG	: integer := RF_ADDRESSES_GLOBAL);		-- /  5 bits

	port (		INSTR	: in  std_logic_vector(N - 1 downto 0);		-- Instruction Input		/ 32 bits
			RS1	: out std_logic_vector(REG - 1 downto 0);	-- First Source Register	/  5 bits
			RS2	: out std_logic_vector(REG - 1 downto 0);	-- Second Source Register	/  5 bits
			RD	: out std_logic_vector(REG - 1 downto 0));	-- Destination Register		/  5 bits

end REGADDR;


architecture BEHAVIORAL of REGADDR is

	-- Local signal to hold the opcode portion of the instruction
	signal IR_OPC : std_logic_vector(5 downto 0);

begin

	-- Extract the opcode from the input instruction
	IR_OPC <= INSTR(N - 1 downto N - OPC);

	-- Process to differentiate between instruction types and set output ports
	process(IR_OPC)
	begin

		-- R-Type instruction
		if IR_OPC = RTYPE then

			-- Extract RS1, RS2 and RD fields for R-type instruction
			RS1	<= INSTR(N - OPC - 1 downto N - OPC - REG);			-- INSTR(25 downto 21);
			RS2	<= INSTR(N - OPC - REG - 1 downto N - OPC - REG*2);		-- INSTR(20 downto 16);
			RD	<= INSTR(N - OPC - REG*2 - 1 downto N - OPC - REG*3);		-- INSTR(15 downto 11);

		-- I-Type instruction	
		elsif IR_OPC /= JTYPE_J and IR_OPC /= JTYPE_JAL then

			-- Extract RS1 and RD fields for I-type instruction, RS2 is not applicable
			RS1	<= INSTR(N - OPC - 1 downto N - OPC - REG);			-- INSTR(25 downto 21);
			RS2	<= (others => '0');
			RD	<= INSTR(N - OPC - REG - 1 downto N - OPC - REG*2);		-- INSTR(20 downto 16);

		-- J-Type instruction
		else
			-- For J-type instruction, RS1, RS2 and RD are not applicable
			RS1	<= (others => '0');
			RS2	<= (others => '0');
			RD	<= (others => '0');

		end if;

	end process;

end BEHAVIORAL;


configuration CFG_REGADDR_GEN_BEHAVIORAL of REGADDR is
	for BEHAVIORAL
	end for;
end CFG_REGADDR_GEN_BEHAVIORAL;
