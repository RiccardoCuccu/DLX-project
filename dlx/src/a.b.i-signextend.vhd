library ieee;
use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;
use work.constants.all;

entity SIGNEX is

	generic (	N	: integer := IR_SIZE_GLOBAL;			-- / 32 bits
			OPC	: integer := OPC_SIZE_GLOBAL;			-- /  6 bits
			REG	: integer := REG_SIZE_GLOBAL);			-- /  5 bits

	port (		INSTR	: in  std_logic_vector(N - 1 downto 0);
			IMM	: out std_logic_vector(N - 1 downto 0));

end SIGNEX;


architecture BEHAVIORAL of SIGNEX is

	signal IR_OPC : std_logic_vector(5 downto 0);

begin
	
	IR_OPC <= INSTR(N - 1 downto N - OPC);

	process(INSTR)
	begin

		if IR_OPC = (JTYPE_J or JTYPE_JAL) then
			IMM(N - OPC - 1 downto 0) <= INSTR(N - OPC - 1 downto 0);
			IMM(N - 1 downto N - OPC) <= (others => INSTR(N - OPC));

--		elsif IR_OPC = ITYPE_LHI then
--			IMM(N - OPC - REG*2 - 1 downto 0) <= (others => '0');
--			IMM(N - 1 downto N - OPC - REG*2) <= INSTR(N - OPC - REG*2 - 1 downto 0);

--		elsif IR_OPC = (ITYPE_ADDU or ITYPE_SLTU or ITYPE_SGTU or ITYPE_SGEU or ITYPE_SLEU or ITYPE_SUBU) then
--			IMM(N - OPC - REG*2 - 1 downto 0) <= INSTR(N - OPC - REG*2 - 1 downto 0);
--			IMM(N - 1 downto N - OPC - REG*2) <= (others => '0');

		elsif IR_OPC = RTYPE then
			IMM <= (others => '0');

--		elsif IR_OPC = (ITYPE_LB or ITYPE_LBU) then
--			IMM(1  downto  0) <= (others => '0');
--			IMM(N - OPC - REG*2 - 1 downto  2) <= INSTR(N - OPC - REG*2 - 1 downto 2);
--			IMM(N - 1 downto N - OPC - REG*2) <= (others => INSTR(N - OPC - REG*2 - 1));

--		elsif IR_OPC = ITYPE_LHU then
--			IMM(0) <= '0';
--			IMM(N - OPC - REG*2 - 1 downto  1) <= INSTR(N - OPC - REG*2 - 1 downto 1);
--			IMM(N - 1 downto N - OPC - REG*2) <= (others => INSTR(N - OPC - REG*2 - 1));

		else  
			IMM(N - OPC - REG*2 - 1 downto 0) <= INSTR(N - OPC - REG*2 - 1 downto 0);
			IMM(N - 1 downto N - OPC - REG*2) <= (others => INSTR(N - OPC - REG*2 - 1));
		
		end if;

	end process;

end BEHAVIORAL;


configuration CFG_SIGNEX_GEN_BEHAVIORAL of SIGNEX is
	for BEHAVIORAL
	end for;
end CFG_SIGNEX_GEN_BEHAVIORAL;
