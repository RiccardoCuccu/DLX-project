----------------------------------------------------------------------------------------------------
-- Description:	This Booth multiplier module serves as the multiplication unit within the DLX's ALU.
--		It employs Booth's algorithm for multiplication and is designed to handle N-bit operands.
--		The architecture employs a Ripple-Carry Adder (RCA), a Booth Encoder, and a multiplexer 
--		with 8-to-1 selection logic. A sequence of RCAs are used to accumulate the partial sums
--		of the Booth multiplication.
--
-- Author:	Riccardo Cuccu
-- Date:	2023/09/19
----------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.constants.all;

entity BOOTH_MULTIPLIER is

	generic (	N:	integer := ALU_OP_SIZE_GLOBAL);				-- / 32 bits

	port	(	A:	in	std_logic_vector(N/2 - 1 downto 0);
			B:	in	std_logic_vector(N/2 - 1 downto 0);
			P:	out	std_logic_vector(N - 1 downto 0));

end BOOTH_MULTIPLIER;


architecture STRUCTURAL of BOOTH_MULTIPLIER is

	component RCA

		generic (	N:	integer := ALU_OP_SIZE_GLOBAL);			-- / 32 bits

		port	(	A:	in	std_logic_vector(N - 1 downto 0);
				B:	in	std_logic_vector(N - 1 downto 0);
				Ci:	in	std_logic;
				S:	out	std_logic_vector(N - 1 downto 0);
				Co:	out	std_logic);

	end component; 

	component BOOTH_ENCODER

		generic	(	N:	integer := ALU_MUL_ENCODER_GLOBAL);		-- / 32 bits
		
		port	(	B:	in	std_logic_vector(N - 1 downto 0);
				Bo:	out	std_logic_vector(3*(N/2) - 1 downto 0));

	end component;

	component MUX81

		generic (	N:	integer := ALU_MUL_ENCODER_GLOBAL);		-- / 16 bits

		port	(	A:	in	std_logic_vector(N - 1 downto 0);
				B:	in	std_logic_vector(N - 1 downto 0);
				C:	in	std_logic_vector(N - 1 downto 0);
				D:	in	std_logic_vector(N - 1 downto 0);
				E:	in	std_logic_vector(N - 1 downto 0);
				F:	in	std_logic_vector(N - 1 downto 0);
				G:	in	std_logic_vector(N - 1 downto 0);
				H:	in	std_logic_vector(N - 1 downto 0);
				S:	in	std_logic_vector(2 downto 0);
				Y:	out	std_logic_vector(N - 1 downto 0));

	end component;

	constant RADIX: integer := ALU_MUL_RADIX_GLOBAL;
	constant MUXBIT: integer := ALU_OP_SIZE_GLOBAL;
	constant RCABIT: integer := ALU_OP_SIZE_GLOBAL;
	constant ENCBIT: integer := ALU_MUL_ENCODER_GLOBAL;
	constant L: integer := N/RADIX;					-- number of levels

	type MuxInputs is array(N - 1 downto 0) of std_logic_vector(MUXBIT - 1 downto 0);
	type MuxOutputs is array(L - 1 downto 0) of std_logic_vector(MUXBIT - 1 downto 0);
	type RcaOutputs is array(L - 2 downto 0) of std_logic_vector(RCABIT - 1 downto 0);

	signal Bo_signal: std_logic_vector(3*(ENCBIT/2) - 1 downto 0);
	
	signal aMatrix: MuxInputs;		-- mux inputs (A values)
	signal aEncMatrix: MuxOutputs;		-- mux outputs (selected A)
	signal pSumMatrix: RcaOutputs;		-- rca outputs (partial products)

	begin

		B_INSTANCE: BOOTH_ENCODER

			generic map (N => ENCBIT)
			port map (B, Bo_signal);

		-- Loop to generate positive and negative values for A operand
		A_INSTANCE: for i in 0 to N/2 - 1 generate

			aMatrix(2*i) <= std_logic_vector(shift_left(resize(signed(A), MUXBIT), i));	-- extended positive value
			aMatrix(2*i+1) <= (not aMatrix(2*i)) + '1';					-- extended negative value

		end generate;

		-- First level multiplexer instantiation
		FIRST_MUX: MUX81

			generic map (N => MUXBIT)
			port map ((others => '0'), aMatrix(0), aMatrix(1), aMatrix(2), aMatrix(3), (others => '0'), (others => '0'), (others => '0'), Bo_signal(2 downto 0), aEncMatrix(0));

		-- Sequence of multiplexers and adders for remaining levels
		SUMS: for i in 1 to L - 1 generate

			MUXES: MUX81

				generic map (N => MUXBIT)
				port map ((others => '0'), aMatrix(i*4), aMatrix(i*4+1), aMatrix(i*4+2), aMatrix(i*4+3), (others => '0'), (others => '0'), (others => '0'), Bo_signal(3*(i+1) - 1 downto 3*i), aEncMatrix(i));

			RCA1: if i = 1 generate

				FIRST_RCA: RCA

					generic map (N => RCABIT)
					port map (aEncMatrix(1), aEncMatrix(0), '0', pSumMatrix(0), open);

			end generate;

			RCAN: if i > 1 generate
				RCAS: RCA

					generic map (N => RCABIT)
					port map (aEncMatrix(i), pSumMatrix(i-2), '0', pSumMatrix(i - 1), open);

			end generate;

		end generate;

		-- Output of the last adder
		P <= pSumMatrix(L-2);

end STRUCTURAL;

