library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;
use work.constants.all;

entity CSB is

	generic (	N:	integer := ALU_OP_RCA_SIZE_GLOBAL);

	port (		A:	in	std_logic_vector(N-1 downto 0);
			B:	in	std_logic_vector(N-1 downto 0);
			Ci:	in	std_logic;
			S:	out	std_logic_vector(N-1 downto 0));
			-- Ovf:	out	std_logic);

end CSB;

architecture STRUCTURAL of CSB is

	component RCA
		generic (	N:	integer := ALU_OP_RCA_SIZE_GLOBAL);
		port (		A:	in	std_logic_vector(N-1 downto 0);
				B:	in	std_logic_vector(N-1 downto 0);
				Ci:	in	std_logic;
				S:	out	std_logic_vector(N-1 downto 0);
				Co:	out	std_logic);
	end component;

	component MUX21 
		generic (	N:	integer := ALU_OP_MUX_SIZE_GLOBAL);
		port (		A:	in  std_logic_vector (N-1 downto 0);
				B:	in  std_logic_vector (N-1 downto 0);
				S:	in  std_logic;
				Y:	out std_logic_vector (N-1 downto 0));
	end component;

	signal SUM0, SUM1: std_logic_vector (ALU_OP_RCA_SIZE_GLOBAL-1 downto 0);
	signal COUT0, COUT1: std_logic;
	--signal OVF0, OVF1: std_logic;

begin

	RCA0: RCA generic map (ALU_OP_RCA_SIZE_GLOBAL) port map (A, B, '0', SUM0, COUT0);
	RCA1: RCA generic map (ALU_OP_RCA_SIZE_GLOBAL) port map (A, B, '1', SUM1, COUT1);
	MUX: MUX21 generic map (ALU_OP_MUX_SIZE_GLOBAL) port map (SUM0, SUM1, Ci, S);

	-- Ovf <= (OVF1 and Ci) or (OVF0 and not Ci);

end STRUCTURAL;


configuration CFG_CSB_STRUCTURAL of CSB is
	for STRUCTURAL
		for RCA0 : RCA
			use configuration WORK.CFG_RCA_GEN_STRUCTURAL;
		end for;
		for RCA1 : RCA
			use configuration WORK.CFG_RCA_GEN_STRUCTURAL;
		end for;
		for MUX : MUX21
			use configuration WORK.CFG_MUX21_GEN_BEHAVIORAL;
		end for;
	end for;
end CFG_CSB_STRUCTURAL;

