library ieee;
use ieee.std_logic_1164.all;
use work.constants.all;

-- Flip-flop D (edge triggered) Register with syncronous reset

entity FFDR is

	generic (	N	: integer := SIZE_GLOBAL);

	port (		CLK	: in std_logic;
			RST	: in std_logic;
			EN	: in std_logic;
			REGIN	: in std_logic_vector(N - 1 downto 0);
			REGOUT	: out std_logic_vector(N - 1 downto 0));
end FFDR;


architecture STRUCTURAL of FFDR is

	component FFD
		port(		CLK:	in	std_logic;
				RST:	in	std_logic;
				EN:	in	std_logic;
				D:	in	std_logic;
				Q:	out	std_logic);
	end component;

begin
	GEN_LOOP: for i in (N - 1) downto 0 generate

		FFI: FFD
		port map (	CLK	=> CLK,
				RST	=> RST,
				EN	=> EN,
				D	=> REGIN(i),
				Q	=> REGOUT(i));

	end generate GEN_LOOP;

end STRUCTURAL;


configuration CFG_FFDR_GEN_STRUCTURAL of FFDR is
	for STRUCTURAL
		for GEN_LOOP
			for all : FFD
				use configuration WORK.CFG_FFD_GEN_BEHAVIORAL;
			end for;
		end for;
	end for;
end configuration;