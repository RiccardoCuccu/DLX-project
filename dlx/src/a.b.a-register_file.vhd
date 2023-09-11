----------------------------------------------------------------------------------------------------
-- Description:	This module functions as a Register File (RF) within the DLX architecture.
--		In read mode, it receives register addresses (ADD_RD1, ADD_RD2) and returns 
--		the corresponding register values (OUT1, OUT2). In write mode, it writes 
--		the DATAIN value to the register specified by ADD_WR. Operations are enabled by 
--		the respective enable signals (EN, EN_RD1, EN_RD2, EN_WR).
--
-- Author:	Riccardo Cuccu
-- Date:	2023/09/10
----------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.constants.all;

entity RF is

	generic (	N		: integer := RF_SIZE_GLOBAL;			-- / 32 bits
			NA		: integer := RS_SIZE_GLOBAL);			-- /  5 bits

	port	(	RST		: in	std_logic;				-- Reset, active low
			EN		: in	std_logic;				-- Enable
			EN_RD1		: in	std_logic;				-- Read Enable 1
			EN_RD2		: in	std_logic;				-- Read Enable 2
			EN_WR		: in	std_logic;				-- Write Enable
			ADD_RD1		: in	std_logic_vector(NA - 1 downto 0);	-- Read Address 1	/  5 bits
			ADD_RD2		: in	std_logic_vector(NA - 1 downto 0);	-- Read Address 2	/  5 bits
			ADD_WR		: in	std_logic_vector(NA - 1 downto 0);	-- Write Address	/  5 bits
			DATAIN		: in	std_logic_vector(N - 1 downto 0);	-- Input Data		/ 32 bits
			OUT1		: out	std_logic_vector(N - 1 downto 0);	-- Output Data 1	/ 32 bits
			OUT2		: out	std_logic_vector(N - 1 downto 0));	-- Output Data 2	/ 32 bits

end RF;


architecture BEHAVIORAL of RF is

	subtype REG_ADDR is natural range 0 to 2**NA - 1;
	type REG_ARRAY is array(REG_ADDR) of std_logic_vector(N - 1 downto 0);
	signal REG: REG_ARRAY;

	begin

		REGISTER_WRITE: process(RST, EN, ADD_WR, EN_WR, DATAIN)			-- Asynchronous
		begin

			if RST = '0' then						-- Reset, active low
				REG <= (others => (others => '0'));
--				REG <= (	"00000000000000000000000000001010",	-- Default Value: 10 (0xA)
--						"00000000000000000000000000001011",	-- Default Value: 11 (0xB)
--						"00000000000000000000000000001100",	-- Default Value: 12 (0xC)
--						"00000000000000000000000000001101",	-- Default Value: 13 (0xD)
--						"00000000000000000000000000001110",	-- Default Value: 14 (0xE)
--						others => (others =>'0'));
--				REG <= (	"00000000000000000000101110101010",	-- Default Value: 2986 (0xBAA)
--						"00000000000000000000101111101010",	-- Default Value: 3050 (0xBEA)
--						"00000000000000000000111111101010",	-- Default Value: 4074 (0xFEA)
--						"00000000000000000001111111101010",	-- Default Value: 8170 (0xD)
--						"00000000000000000011101111101010",	-- Default Value: 15338 (0x3BEA)
--						others => (others =>'0'));
			else
				if EN = '1' and EN_WR = '1' then			-- Enable Signals, active high
					if (conv_integer(ADD_WR) = 0) then
						REG(0) <= (others => '0');		-- Special handling for register 0 (hardwired to 0)
					elsif (conv_integer(ADD_WR) = 2**NA - 1) then
						REG(2**NA - 1) <= (others => '0');	-- Special handling for register 31 (hardwired to 0)
					else
						REG(conv_integer(ADD_WR)) <= DATAIN;
					end if;
				end if;
			end if;

		end process;

		REGISTER_READ: process(EN, ADD_RD1, ADD_RD2, EN_RD1, EN_RD2, REG)	-- Asynchronous
		begin

			if EN = '1' then						-- Enable Signal, active high
				if EN_RD1 = '1' then
					OUT1 <= REG(conv_integer(ADD_RD1));
				end if;
				if EN_RD2 = '1' then
					OUT2 <= REG(conv_integer(ADD_RD2));
				end if;
			end if;

		end process;

end BEHAVIORAL;


configuration CFG_RF_BEH of RF is
	for BEHAVIORAL
	end for;
end CFG_RF_BEH;
