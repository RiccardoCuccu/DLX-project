library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.constants.all;

entity REGISTER_FILE is

	generic (	N		: integer := RF_SIZE_GLOBAL;
			NA		: integer := RF_ADDRESSES_GLOBAL);

	port	(	CLK		: in	std_logic;
			RESET		: in	std_logic;
			ENABLE		: in	std_logic;
			RD1		: in	std_logic;
			RD2		: in	std_logic;
			WR		: in	std_logic;
			ADD_WR		: in	std_logic_vector(NA - 1 downto 0);
			ADD_RD1		: in	std_logic_vector(NA - 1 downto 0);
			ADD_RD2		: in	std_logic_vector(NA - 1 downto 0);
			DATAIN		: in	std_logic_vector(N - 1 downto 0);
			OUT1		: out	std_logic_vector(N - 1 downto 0);
			OUT2		: out	std_logic_vector(N - 1 downto 0));

end REGISTER_FILE;


architecture BEHAVIORAL of REGISTER_FILE is

	subtype REG_ADDR is natural range 0 to 2**NA - 1;
	type REG_ARRAY is array(REG_ADDR) of std_logic_vector(N - 1 downto 0);
	signal REG: REG_ARRAY; 

	begin
		REGISTER_INSTANCE: process(clk)

			begin
				if CLK'event and CLK='1' then			-- posedge clock

					if (RESET = '0') then			-- synchronous reset
						OUT1 <= (others => '0');
						OUT2 <= (others => '0');
						REG <= (others => (others => '0'));
					else

					if (ENABLE = '1') then			-- enable signal, active high

						if (WR = '1') then
							REG(conv_integer(ADD_WR)) <= DATAIN;
						end if;

						if (RD1 = '1') then
							OUT1 <= REG(conv_integer(ADD_RD1));
						end if;

						if (RD2 = '1') then
							OUT2 <= REG(conv_integer(ADD_RD2));
						end if;
					end if;

					REG(0) <= (others => '0');
					REG(2**NA - 1) <= (others => '0');

				end if;
			end if;
		end process;

end BEHAVIORAL;


configuration CFG_RF_BEH of REGISTER_FILE is
	for BEHAVIORAL
	end for;
end configuration;
