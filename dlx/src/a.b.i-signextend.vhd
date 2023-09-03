--------------------------------------------------------------------------------
-- Description:	This module is designed to handle the sign extension of the
--		IMMEDIATE field based on the type of instruction (J-Type, R-Type,
--		or I-Type). It differentiates the instruction types using the opcode
--		(IR_OPC).
-- Author:	Riccardo Cuccu
-- Date:	2023/09/01
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;
use work.constants.all;

entity SIGNEX is

	generic (	N	: integer := IR_SIZE_GLOBAL;			-- / 32 bits
			OPC	: integer := OPC_SIZE_GLOBAL;			-- /  6 bits
			REG	: integer := REG_SIZE_GLOBAL);			-- /  5 bits

	port (		INSTR	: in  std_logic_vector(N - 1 downto 0);		-- Instruction Input		/ 32 bits
			IMM	: out std_logic_vector(N - 1 downto 0));	-- Extended Immediate		/ 32 bits

end SIGNEX;


architecture BEHAVIORAL of SIGNEX is

	-- Local signal to hold the opcode portion of the instruction
	signal IR_OPC : std_logic_vector(5 downto 0);

begin

	-- Extract the opcode from the input instruction
	IR_OPC <= INSTR(N - 1 downto N - OPC);

	-- Process to perform sign extension based on instruction type
	process(IR_OPC)
	begin

		-- R-Type instructions
		if IR_OPC = RTYPE then

			-- Zero out the IMM field as R-Type doesn't have immediate values
			IMM <= (others => '0');

		-- J-Type instructions
		elsif IR_OPC = JTYPE_J or IR_OPC = JTYPE_JAL then

			-- Copy the immediate value and sign-extend
			IMM(N - OPC - 1 downto 0) <= INSTR(N - OPC - 1 downto 0);
			IMM(N - 1 downto N - OPC) <= (others => INSTR(N - OPC));

--		elsif IR_OPC = ITYPE_LHI then
--			IMM(N - OPC - REG*2 - 1 downto 0) <= (others => '0');
--			IMM(N - 1 downto N - OPC - REG*2) <= INSTR(N - OPC - REG*2 - 1 downto 0);

--		elsif IR_OPC = ITYPE_ADDU or IR_OPC = ITYPE_SLTU or IR_OPC = ITYPE_SGTU or IR_OPC = ITYPE_SGEU or IR_OPC = ITYPE_SLEU or IR_OPC = ITYPE_SUBU then
--			IMM(N - OPC - REG*2 - 1 downto 0) <= INSTR(N - OPC - REG*2 - 1 downto 0);
--			IMM(N - 1 downto N - OPC - REG*2) <= (others => '0');

--		elsif IR_OPC = ITYPE_LB or IR_OPC = ITYPE_LBU then
--			IMM(1  downto  0) <= (others => '0');
--			IMM(N - OPC - REG*2 - 1 downto  2) <= INSTR(N - OPC - REG*2 - 1 downto 2);
--			IMM(N - 1 downto N - OPC - REG*2) <= (others => INSTR(N - OPC - REG*2 - 1));

--		elsif IR_OPC = ITYPE_LHU then
--			IMM(0) <= '0';
--			IMM(N - OPC - REG*2 - 1 downto  1) <= INSTR(N - OPC - REG*2 - 1 downto 1);
--			IMM(N - 1 downto N - OPC - REG*2) <= (others => INSTR(N - OPC - REG*2 - 1));

		-- I-Type and other instructions
		else

			-- Copy the immediate value and sign-extend
			IMM(N - OPC - REG*2 - 1 downto 0) <= INSTR(N - OPC - REG*2 - 1 downto 0);
			IMM(N - 1 downto N - OPC - REG*2) <= (others => INSTR(N - OPC - REG*2 - 1));
		
		end if;

	end process;

end BEHAVIORAL;


configuration CFG_SIGNEX_GEN_BEHAVIORAL of SIGNEX is
	for BEHAVIORAL
	end for;
end CFG_SIGNEX_GEN_BEHAVIORAL;
