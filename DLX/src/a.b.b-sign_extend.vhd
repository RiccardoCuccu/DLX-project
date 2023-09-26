----------------------------------------------------------------------------------------------------
-- Description: This module is designed to extend the IMMEDIATE field of the instruction to 32 bits
--		based on the OPCODE of the instruction. The module distinguishes among J-Type, I-Type,
--		and R-Type instructions and generates a 32-bit immediate field accordingly.
--
-- Author:	Riccardo Cuccu
-- Date:	2023/09/08
----------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.constants.all;

entity SIGNEX is

	generic (	N	: integer := IR_SIZE_GLOBAL;			-- / 32 bits
			OPC	: integer := OPC_SIZE_GLOBAL;			-- /  6 bits
			REG	: integer := RS_SIZE_GLOBAL);			-- /  5 bits

	port (		INSTR	: in  std_logic_vector(N - 1 downto 0);		-- Instruction Input		/ 32 bits
			IMM	: out std_logic_vector(N - 1 downto 0));	-- Extended Immediate		/ 32 bits

end SIGNEX;


architecture BEHAVIORAL of SIGNEX is

	-- Local signal to hold the opcode portion of the instruction
	signal IR_OPC : std_logic_vector(OPC - 1 downto 0);
	signal IMM_I : std_logic_vector(N - OPC - REG*2 - 1 downto 0);
	signal IMM_J : std_logic_vector(N - OPC - 1 downto 0);

begin

	-- Extract the opcode from the input instruction
	IR_OPC	<= INSTR(N - 1 downto N - OPC);
	IMM_I	<= INSTR(N - OPC - REG*2 - 1 downto 0);
	IMM_J	<= INSTR(N - OPC - 1 downto 0);

	-- Process to perform sign extension based on instruction type
	process(IR_OPC, IMM_J)
	begin

		-- R-Type instructions
		if IR_OPC = RTYPE then

			-- Zero out IMM as R-Type doesn't have immediate field
			IMM <= (others => '0');

		-- J-Type instructions
		elsif IR_OPC = JTYPE_J or IR_OPC = JTYPE_JAL then

			-- Sign extend 26-bit immediate
			IMM(N - OPC - 1 downto 0) <= IMM_J;
			IMM(N - 1 downto N - OPC) <= (others => IMM_J(N - OPC - 1));

		-- I-Type instructions
		elsif IR_OPC = ITYPE_ADDUI or IR_OPC = ITYPE_SUBUI or IR_OPC = ITYPE_SRAI or IR_OPC = ITYPE_SLTUI or IR_OPC = ITYPE_SGTUI or IR_OPC = ITYPE_SGEUI or IR_OPC = ITYPE_SLEUI then
			
			-- Zero extend 16-bit immediate (unsigned)
			IMM(N - OPC - REG*2 - 1 downto 0) <= IMM_I;
			IMM(N - 1 downto N - OPC - REG*2) <= (others => '0');

		elsif IR_OPC = ITYPE_LHI then

			-- Zero-extend lower 16-bits and copy higher 16-bits from immediate
			IMM(N - OPC - REG*2 - 1 downto 0) <= (others => '0');
			IMM(N - 1 downto N - OPC - REG*2) <= IMM_I;

--		elsif IR_OPC = ITYPE_LB or IR_OPC = ITYPE_LBU then
--
--			-- Zero-extend lower 2 bits, and sign-extend higher bits
--			IMM(1  downto  0) <= (others => '0');
--			IMM(N - OPC - REG*2 - 1 downto 2) <= IMM_I(N - OPC - REG*2 - 1 downto 2);
--			IMM(N - 1 downto N - OPC - REG*2) <= (others => IMM_I(N - OPC - REG*2 - 1));

--		elsif IR_OPC = ITYPE_LHU then
--
--			-- Zero-extend lower 1 bit, and sign-extend higher bits
--			IMM(0) <= '0';
--			IMM(N - OPC - REG*2 - 1 downto 1) <= IMM_I(N - OPC - REG*2 - 1 downto 1);
--			IMM(N - 1 downto N - OPC - REG*2) <= (others => IMM_I(N - OPC - REG*2 - 1));

		else

			-- Sign-extend 16-bit immediate (signed)
			IMM(N - OPC - REG*2 - 1 downto 0) <= IMM_I;
			IMM(N - 1 downto N - OPC - REG*2) <= (others => IMM_I(N - OPC - REG*2 - 1));
		
		end if;

	end process;

end BEHAVIORAL;


configuration CFG_SIGNEX_GEN_BEHAVIORAL of SIGNEX is
	for BEHAVIORAL
	end for;
end CFG_SIGNEX_GEN_BEHAVIORAL;
