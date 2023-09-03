library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;
use work.constants.all;

entity RCA is

	generic (	N:	integer := ALU_OP_RCA_SIZE_GLOBAL);

	port (		A:	in	std_logic_vector(N-1 downto 0);
			B:	in	std_logic_vector(N-1 downto 0);
			Ci:	in	std_logic;
			S:	out	std_logic_vector(N-1 downto 0);
			Co:	out	std_logic);

end RCA; 


architecture STRUCTURAL of RCA is

	signal S_TMP : std_logic_vector(N-1 downto 0);
	signal C_TMP : std_logic_vector(N downto 0);

	component FA 
	port (	A:	in	std_logic;
		B:	in	std_logic;
		Ci:	in	std_logic;
		S:	out	std_logic;
		Co:	out	std_logic);
	end component; 

begin

	C_TMP(0) <= Ci;
	S <= S_TMP;
	Co <= C_TMP(N);
	-- Ovf <= C_TMP(N) xor C_TMP(N-1);
	
	ADDER1: for I in 1 to N generate
		FAI : FA
		port map (
				A(I-1),
				B(I-1),
				C_TMP(I-1),
				S_TMP(I-1),
				C_TMP(I)); 
	end generate;

end STRUCTURAL;


architecture BEHAVIORAL of RCA is
	
begin

	process(A, B, Ci)

	variable S_TMP : std_logic_vector(N-1 downto 0);
	variable C : std_logic_vector(N downto 0);

	begin

		C(0) := Ci;

		for i in 0 to N-1 loop
			S_TMP(i) := A(i) xor B(i) xor C(i);
			C(i+1) := (A(i) and B(i)) or (B(i) and C(i)) or (A(i) and C(i));
		end loop;

		Co <= C(N);
		S <= S_TMP;

	end process;

end BEHAVIORAL;


configuration CFG_RCA_GEN_STRUCTURAL of RCA is
	for STRUCTURAL 
		for ADDER1
			for all : FA
				use configuration WORK.CFG_FA_BEHAVIORAL;
			end for;
		end for;
	end for;
end CFG_RCA_GEN_STRUCTURAL;

configuration CFG_RCA_GEN_BEHAVIORAL of RCA is
	for BEHAVIORAL 
	end for;
end CFG_RCA_GEN_BEHAVIORAL;
