library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.constants.all;

entity RF is

	generic (	N		: integer := RF_SIZE_GLOBAL;
			NA		: integer := RF_ADDRESSES_GLOBAL);

	port	(	CLK		: in	std_logic;				-- Clock
			RST		: in	std_logic;				-- Reset, active low
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

		REGISTER_INSTANCE: process(clk)
		begin
			if CLK'event and CLK='1' then					-- Posedge Clock

				if (RST = '0') then					-- Synchronous Reset
					OUT1 <= (others => '0');
					OUT2 <= (others => '0');
					REG <= (others => (others => '0'));
--					REG <= (	"00000000000000000000000000001010",	-- Default Value: 10 (0xA)
--							"00000000000000000000000000001011",	-- Default Value: 11 (0xB)
--							"00000000000000000000000000001100",	-- Default Value: 12 (0xC)
--							"00000000000000000000000000001101",	-- Default Value: 13 (0xD)
--							"00000000000000000000000000001110",	-- Default Value: 14 (0xE)
--							others=> (others=>'0'));
				else

					if (EN = '1') then				-- Enable Signal, active high

						if (EN_WR = '1') then
							REG(conv_integer(ADD_WR)) <= DATAIN;
						end if;

						if (EN_RD1 = '1') then
							OUT1 <= REG(conv_integer(ADD_RD1));
						end if;

						if (EN_RD2 = '1') then
							OUT2 <= REG(conv_integer(ADD_RD2));
						end if;
					end if;

					REG(0) <= (others => '0');
					REG(2**NA - 1) <= (others => '0');

				end if;
			end if;
		end process;

end BEHAVIORAL;


configuration CFG_RF_BEH of RF is
	for BEHAVIORAL
	end for;
end configuration;
