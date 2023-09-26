library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.constants.all;

entity BOOTH_ENCODER is
	
	generic	(	N:	integer := ALU_MUL_ENCODER_GLOBAL);
	
	port	(	B:	in	std_logic_vector(N-1 downto 0);
			Bo:	out	std_logic_vector(3*(N/2)-1 downto 0));

end BOOTH_ENCODER;

architecture STRUCTURAL of BOOTH_ENCODER is

	component ENCODER is

		port	(	B:	in	std_logic_vector(2 downto 0);
				Y:	out	std_logic_vector(2 downto 0));

	end component;

	type Matrix is array (N/2 downto 0) of std_logic_vector(2 downto 0);
	signal bMatrix: Matrix;

	begin
		-- first encoder
		bMatrix(0)(0) <= '0';
		bMatrix(0)(1) <= B(0);
		bMatrix(0)(2) <= B(1);

		-- rest of the Booth encoder
		BOOTH_ENC_MATRIX: for i in 1 to N/2-1 generate
			begin
				bMatrix(i)(0) <= B(2*i-1);
				bMatrix(i)(1) <= B(2*i);
				bMatrix(i)(2) <= B(2*i+1);
		end generate;

		BOOTH_ENC_OUT: for i in 0 to N/2-1 generate
			begin
				ENC: ENCODER port map (bMatrix(i),Bo(3*(i+1)-1 downto 3*i));
		end generate;

end STRUCTURAL;
