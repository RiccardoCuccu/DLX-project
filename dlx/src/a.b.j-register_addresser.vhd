----------------------------------------------------------------------------------------------------
-- Description: This module sets the RS1, RS2, and RD register addresses based on the incoming 
--		instruction's opcode. It handles R-Type, I-Type, and J-Type instructions.
--
-- Author:	Riccardo Cuccu
-- Date:	2023/09/08
----------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.constants.all;

entity REGADDR is

	generic (	N	: integer := IR_SIZE_GLOBAL;			-- / 32 bits
			OPC	: integer := OPC_SIZE_GLOBAL;			-- /  6 bits
			REG	: integer := RS_SIZE_GLOBAL);			-- /  5 bits

	port (		INSTR	: in  std_logic_vector(N - 1 downto 0);		-- Instruction Input		/ 32 bits
			RS1	: out std_logic_vector(REG - 1 downto 0);	-- First Source Register	/  5 bits
			RS2	: out std_logic_vector(REG - 1 downto 0);	-- Second Source Register	/  5 bits
			RD	: out std_logic_vector(REG - 1 downto 0));	-- Destination Register		/  5 bits

end REGADDR;


architecture BEHAVIORAL of REGADDR is

	-- Local signals to temporarily store opcode and register addresses from the instruction
	signal IR_OPC	: std_logic_vector(OPC - 1 downto 0);
	signal REG1	: std_logic_vector(REG - 1 downto 0);
	signal REG2	: std_logic_vector(REG - 1 downto 0);
	signal REG3	: std_logic_vector(REG - 1 downto 0);

begin

	-- Extract opcode and register addresses from input instruction
	IR_OPC	<= INSTR(N - 1 downto N - OPC);
	REG1	<= INSTR(N - OPC - 1 downto N - OPC - REG);			-- INSTR(25 downto 21);
	REG2	<= INSTR(N - OPC - REG - 1 downto N - OPC - REG*2);		-- INSTR(20 downto 16);
	REG3	<= INSTR(N - OPC - REG*2 - 1 downto N - OPC - REG*3);		-- INSTR(15 downto 11);

	-- Process to identify instruction type and set the output ports
	process(IR_OPC, REG1, REG2, REG3)
	begin

		-- R-Type instruction
		if IR_OPC = RTYPE then

			-- Extract RS1, RS2 and RD fields for R-type instruction
			RS1	<= REG1;					-- INSTR(25 downto 21);
			RS2	<= REG2;					-- INSTR(20 downto 16);
			RD	<= REG3;					-- INSTR(15 downto 11);

		-- I-Type instruction	
		elsif IR_OPC /= JTYPE_J and IR_OPC /= JTYPE_JAL then

			-- Extract RS1 and RD fields for I-type instruction, RS2 is not applicable
			RS1	<= REG1;					-- INSTR(25 downto 21);
			RS2	<= (others => '0');
			RD	<= REG2;					-- INSTR(20 downto 16);

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
