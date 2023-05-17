library ieee;
use ieee.std_logic_1164.all;
use work.constants.all;

entity TB_DLX is
end TB_DLX;

architecture TEST of TB_DLX is

	constant SIZE_IR	: integer := IR_SIZE_GLOBAL;		-- Instruction Register Size
	constant SIZE_PC	: integer := PC_SIZE_GLOBAL;		-- Program Counter Size
	constant SIZE_ALU_OPC	: integer := OPC_SIZE_GLOBAL;		-- ALU Op Code Word Size in case explicit coding is used

	signal Clock		: std_logic := '0';
	signal Reset		: std_logic := '1';

	component DLX

		generic (	SIZE_IR	: integer := IR_SIZE_GLOBAL;	-- Instruction Register Size
				SIZE_PC	: integer := PC_SIZE_GLOBAL);	-- Program Counter Size

		port (		Clk	: in std_logic;
				Rst	: in std_logic);		-- Active Low

	end component;


begin

	-- instance of DLX
	U1: DLX

		generic map (SIZE_IR, SIZE_PC)
		port map (Clock, Reset);

	PCLOCK: process(Clock)
	begin
		Clock <= not(Clock) after 0.5 ns;
	end process;

	Reset <= '0', '1' after 6 ns, '0' after 11 ns, '1' after 15 ns;  

end TEST;


configuration CFG_TB of TB_DLX is
	for TEST
	end for;
end CFG_TB;
