library ieee;
use ieee.std_logic_1164.all;
use work.constants.all;

-- Latch D Register

entity LDR is

	generic (	N	: integer := SIZE_GLOBAL);

	port (		RST	: in std_logic;
			EN	: in std_logic;
			REGIN	: in std_logic_vector(N - 1 downto 0);
			REGOUT	: out std_logic_vector(N - 1 downto 0));
end LDR;


architecture STRUCTURAL of LDR is

	component LD
		port(		RST:	in	std_logic;
				EN:	in	std_logic;
				D:	in	std_logic;
				Q:	out	std_logic);
	end component;

begin
	GEN_LOOP: for i in (N - 1) downto 0 generate

		LDI: LD
		port map (	RST	=> RST,
				EN	=> EN,
				D	=> REGIN(i),
				Q	=> REGOUT(i));

	end generate GEN_LOOP;

end STRUCTURAL;


configuration CFG_LDR_GEN_STRUCTURAL of LDR is
	for STRUCTURAL
		for GEN_LOOP
			for all : LD
				use configuration WORK.CFG_LD_GEN_BEHAVIORAL;
			end for;
		end for;
	end for;
end configuration;
